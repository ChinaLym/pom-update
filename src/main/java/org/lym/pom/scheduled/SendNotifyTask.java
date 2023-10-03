package org.lym.pom.scheduled;

import lombok.extern.slf4j.Slf4j;
import org.lym.pom.constant.NewVersionNotifyStrategyEnum;
import org.lym.pom.dto.business.NotifyEmailBO;
import org.lym.pom.dto.business.NotifyProjectBO;
import org.lym.pom.dto.business.NotifyRecordBO;
import org.lym.pom.entity.*;
import org.lym.pom.notify.event.SendNotifyEvent;
import org.lym.pom.service.*;
import org.shoulder.core.exception.CommonErrorCodeEnum;
import org.shoulder.core.util.AssertUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 发送提醒任务
 * 每天早上 9 点执行
 *
 * @author lym
 */
@Slf4j
@Service
public class SendNotifyTask {

    @Autowired
    private INotifyRecordService notifyRecordService;

    @Autowired
    private IProjectService projectService;

    @Autowired
    private IUserService userService;

    @Autowired
    private IThirdProjectService thirdProjectService;

    @Autowired
    private INotifySendService notifySender;

    /**
     * 找出所有待发送提醒的记录
     * 按照每个项目一次通知发送
     * 09:00
     */
    @Scheduled(cron = "0 0 9 * * ?")
    public void sendNotify() {
        log.info("ready to send notify...");

        // 获取所有待通知记录
        List<NotifyRecordEntity> toNotifiedRecordList = notifyRecordService.findAllByNotified(false);
        sendNotify(toNotifiedRecordList, "Scheduled");
    }

    /**
     * 发送的通知
     *
     * @param event 工程更新事件
     */
    @Async
    @EventListener(SendNotifyEvent.class)
    public void onSendNotifyEvent(SendNotifyEvent sendNotifyEvent) {
        AssertUtils.notBlank(sendNotifyEvent.getNotifyReason(), CommonErrorCodeEnum.ILLEGAL_PARAM);
        sendNotify(sendNotifyEvent.getToNotifiedRecordList(), sendNotifyEvent.getNotifyReason());
    }

    /**
     * 需要注意 notifyReason 是拼接的，注意避免注入脚本
     */
    public void sendNotify(List<NotifyRecordEntity> toNotifiedRecordList, String notifyReason) {
        if (CollectionUtils.isEmpty(toNotifiedRecordList)) {
            log.info("not need send notify. toNotifiedRecordList is empty.");
            return;
        } else {
            log.info("toNotifiedRecordList.size=" + toNotifiedRecordList.size());
        }
        Set<Long> projectIds = new HashSet<>();
        Set<DependencyIndex> thirdProjectIds = new HashSet<>();
        toNotifiedRecordList.forEach(record -> {
            projectIds.add(record.getProjectId());
            thirdProjectIds.add(record.getDependencyIndex());
        });

        // 查询需要的 projectInfo、thirdProjectInfo、userInfo
        List<String> userIds = new LinkedList<>();
        List<ProjectEntity> projects = projectService.findByIds(projectIds);
        Map<Long, ProjectEntity> projectMap = new HashMap<>(projects.size());
        projects.forEach(p -> {
            projectMap.put(p.getId(), p);
            userIds.add(p.getUserId());
        });

        Map<DependencyIndex, ThirdProjectEntity> thirdProjectMap = thirdProjectService.findMapByIds(thirdProjectIds);
        Map<String, UserEntity> userMap = new HashMap<>(userIds.size());
        List<UserEntity> users = userService.findByIds(userIds);
        users.forEach(u -> userMap.put(u.getId(), u));

        Map<Long, NotifyProjectBO> projectIdToBoMap = new HashMap<>(projectIds.size());

        List<Long> notifiedRecordIds = new LinkedList<>();
        toNotifiedRecordList.forEach(
                record -> {
                    notifiedRecordIds.add(record.getId());
                    ProjectEntity project = projectMap.get(record.getProjectId());
                    UserEntity user = userMap.get(project.getUserId());
                    NotifyProjectBO notifyProjectBO = projectIdToBoMap.computeIfAbsent(project.getId(), id -> new NotifyProjectBO(project, user));
                    notifyProjectBO.addNotifyRecordBO(record, thirdProjectMap.get(record.getDependencyIndex()));
                    notifyProjectBO.setNotifyReason(notifyReason);
                }
        );

        // 转化为邮件 BO
        List<NotifyEmailBO> notifyEmailBOList = projectIdToBoMap.values().stream()
                .map(this::generateNotifyEmailBO).collect(Collectors.toList());

        // 发送
        notifySender.sendEmailNotify(notifyEmailBOList);

        // 更新发送状态为已经发送
        notifyRecordService.setNotified(notifiedRecordIds);

        log.info("finished sending notify TASK!");
    }


    private NotifyEmailBO generateNotifyEmailBO(NotifyProjectBO notifyProjectBO) {
        NotifyEmailBO emailBO = new NotifyEmailBO();
        emailBO.setEmail(notifyProjectBO.getUser().getEmail());
        emailBO.setSubject("Dependency Update Notification.");
        emailBO.setContent(getEmailContent(notifyProjectBO));
        return emailBO;
    }

    private static boolean from_style = true;

    /**
     * 邮件模板：
     * hi, {userName}！
     * Your project {projectName}({groupId}, {artifactId}) may need update.
     * The dependency({dependency.name}) has published a <a href="{dependency.changeLogUrl}">new version ({newVersion})
     * xx dependency has published a <a href="xxx">new version (xxx)</a>.
     * xx dependency has published a <a href="xxx">new version (xxx)</a>.
     * —
     * You are receiving this because you are subscribed to this project.
     * View it on <a href="">PomUpdate</a> or <a href="xxx">unsubscribe</a>.
     */
    private String getEmailContent(NotifyProjectBO notifyProjectBO) {
        String USER_NAME = notifyProjectBO.getUser().getName();
        String PROJECT_NAME = notifyProjectBO.getName();
        String NOTIFY_REASON = notifyProjectBO.getNotifyReason();
        String projectDetail = "(" + notifyProjectBO.getGroupId() + ":" + notifyProjectBO.getArtifactId() + ")";
        if (!StringUtils.hasText(PROJECT_NAME)) {
            PROJECT_NAME = projectDetail;
        } else {
            PROJECT_NAME += projectDetail;
        }

        // -------------------------------------------------------------
        String splitLine = "</br><hr></br>";

        String headTemplate = "Deer {USER_NAME}</br>" +
                " Your project <b>{PROJECT_NAME}</b> may need update.";
        String header = headTemplate
                .replace("{PROJECT_NAME}", PROJECT_NAME)
                .replace("{USER_NAME}", USER_NAME);

        StringBuilder result = new StringBuilder(header);
        // -------------------------------------------------------------
//        result.append(splitLine);
        String eachDependencyTemplate = "* The dependency({DEPENDENCY_ID}) has published a new stable version " +
                "({NEW_VERSION})  Your version is {YOUR_VERSION}.</br>";
        if (from_style) {
            String tableHeader = "<style type=\"text/css\">" +
                    "            table.tftable {font-size:12px;color:#333333;width:100%;border-width: 1px;border-color: #729ea5;border-collapse: collapse;}" +
                    "    table.tftable th {font-size:12px;background-color:#acc8cc;border-width: 1px;padding: 8px;border-style: solid;border-color: #729ea5;text-align:left;}" +
                    "    table.tftable tr {background-color:#ffffff;}" +
                    "    table.tftable td {font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #729ea5;}" +
                    "</style>" +
                    "<table id=\"tfhover\" class=\"tftable\" border=\"1\">" +
                    "<tr><th>Dependency</th><th>Your<br>Version</th><th>New<br>Version</th>";
            result.append(tableHeader);
            eachDependencyTemplate = "<tr><td>{DEPENDENCY_ID}</td><td>{YOUR_VERSION}</td><td>{NEW_VERSION}</td>";
        }

        for (NotifyRecordBO notifyRecordBO : notifyProjectBO.getNotifyRecordBOList()) {
            result.append(getDependencyContent(notifyRecordBO, eachDependencyTemplate));
        }
        if (from_style) {
            String tableTail = "</table>";
            result.append(tableTail);
        }
        // -------------------------------------------------------
        result.append(splitLine);

        String unsubscribeUrl = "http://autoPom.itlym.cn/dependencies/updateNotifyStrategy?projectId={PROJECT_ID}&email&={USER_EMAIL}&notifyStrategy=" + NewVersionNotifyStrategyEnum.IGNORE.getValue()
                .replace("{PROJECT_ID}", String.valueOf(notifyProjectBO.getProjectId()))
                .replace("{USER_EMAIL}", notifyProjectBO.getUser().getEmail());
        String LINK_POM_UPDATE_PROJECT = convertHtmlLink("View on PomUpdate", "http://autoPom.itlym.cn/projects?email=" + notifyProjectBO.getUser().getEmail());
        String LINK_POM_UPDATE_UNSUBSCRIBE = convertHtmlLink("Unsubscribe", unsubscribeUrl, "gray", false);

        String tailTemplate = " Notify Reason: {NOTIFY_REASON}.<br>" +
                "{LINK_POM_UPDATE_PROJECT}<br>" +
                "<br> {LINK_POM_UPDATE_UNSUBSCRIBE}";
        String tail = tailTemplate
                .replace("{LINK_POM_UPDATE_PROJECT}", LINK_POM_UPDATE_PROJECT)
                .replace("{LINK_POM_UPDATE_UNSUBSCRIBE}", LINK_POM_UPDATE_UNSUBSCRIBE)
                .replace("{NOTIFY_REASON}", NOTIFY_REASON);

        result.append(tail);

        return result.toString();
    }

    private String getDependencyContent(NotifyRecordBO notifyRecordBO, String template) {
        ThirdProjectEntity thirdProject = notifyRecordBO.getThirdProject();

        String thirdProjectUrl = thirdProject.getHomeUrl();
        String dependencyName = thirdProject.getName();
        String dependencyDetail =
                thirdProject.getId().getGroupId() + ":<br>" + thirdProject.getId().getArtifactId();
        if (!StringUtils.hasText(dependencyName)) {
            dependencyName = dependencyDetail;
        } else {
            dependencyName += dependencyDetail;
        }
        String newStableVersion = thirdProject.getStableVersion();
        String changeLogUrl = thirdProject.getChangeLogUrl();

        String DEPENDENCY_ID = convertHtmlLink(dependencyName, thirdProjectUrl);
        String NEW_VERSION = convertHtmlLink(newStableVersion, changeLogUrl);
        String YOUR_VERSION = notifyRecordBO.getCurrentVersion();

        return template.replace("{DEPENDENCY_ID}", DEPENDENCY_ID)
                .replace("{NEW_VERSION}", NEW_VERSION)
                .replace("{YOUR_VERSION}", YOUR_VERSION);
    }

    private static String convertHtmlLink(String text, String url) {
        return convertHtmlLink(text, url, "blue", true);
    }
    private static String convertHtmlLink(String text, String url, String color, boolean blod) {
        if (StringUtils.hasText(url)) {
            String style = " style=\"color:" + color + ";";
            if(blod) {
                style += "font-weight:bold;";
            }
            style += "\" ";
            return "<a " + style + " href=\"" + url + "\">" + text + "</a>";
        }
        return text;
    }

}
