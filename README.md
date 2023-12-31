# pom-update

## DESC：
Check if there are updates to the direct dependencies of your maven project.

**Test Now**：
- Entrance 1：[UI page](http://autopom.itlym.cn/) [中文测试地址](http://autopom.itlym.cn/index-CN.html)
- Entrance 2：Copy this to your browser，**Note: **Replace the **📧Email**（`yourEmail@demo.com`） and **🔗pom.xml link** into yours or you will meet error.

> http://autopom.itlym.cn/projects/createWithUrl?email=yourEmail@demo.com&pomXmlUrl=https://raw.githubusercontent.com/ChinaLym/shoulder-framework/master/shoulder-dependencies/pom.xml&notifyInstantlyAfterCheck=true&notifyReason=ONLY_TEST_DEMO

> [Click here if any questions](https://github.com/ChinaLym/pom-update/issues/new#留言自动激活邮箱还未打通，作者看到回)

## 同类比较
与 maven 的 `mvn versions:display-dependency-updates` 相比

- pom-update 的第三方版本信息非实时（时间间隔3小时）；maven 是实时检测的，每个依赖都需要至少访问一次中央仓库
- pom-update 的检测时间在毫秒-秒级，并发检测 + 缓存（内存比较无网络）；maven 的检测通常在分钟级，大型项目检测时往往几十分钟
- pom-update 只检测直接依赖 / 自行管理版本的间接依赖，如依赖了 spring-boot，间接依赖（如spring-core) 的版本是不纳入检测的（当且仅当自己在 dependencyManager 中指定了它的版本或显示指定其版本依赖）有利于维护责任独立更轻量；maven 会检测所有依赖以及全部间接依赖
- pom-update 是部署在服务端，不消耗客户端性能，检测时直接出结果；maven 的必须要客户端等待检测结果
- pom-update 可定时检测，支持订阅，如每周发送更新邮件，并能根据是否稳定版设置是否发送邮件通知；maven 不可以

**总结：**

- pom-update 秒级出检测结果，不需要数十分钟等待获取一大堆自己部管理也不关心的间接依赖版本
- pom-update 支持订阅，如每周发送本项目的所有依赖版本变化情况


## 本地运行

1. git clone 本工程
2. 确保有可连接的数据库，将表结构和示例数据导入数据库 [pom-update-schema-and-demo-data.sql](pom-update-schema-and-demo-data.sql)
3. 修改配置文件 或 添加环境变量（二选一）
```text
# 邮箱，如 demo@qq.com
TEST_SENDER_EMAIL
# 邮箱 SFTP token，自行搜索获取
TEST_EMAIL_TOKEN
# MYSQL 地址、用户名、密码
MYSQL_ADDR
MYSQL_PWD
```

## 测试 API
http://localhost:12345/index.html
选择 pom 输入希望接受邮件的邮箱 your@demoemail.com

http://localhost:12345/test/version
检查所有工程 version

http://localhost:12345/test/notify
给所有需要更新的人发邮件通知

调整通知策略
http://localhost:12345/dependencies/updateNotifyStrategy?projectId=10&notifyStrategy=ALWAYS&email=your@demoemail.com

```bash
# TEMP TEST
curl --location --request GET 'http://localhost:12345/projects/createWithUrl?email=yourEmail@demo.com&pomXmlUrl=https://raw.githubusercontent.com/ChinaLym/shoulder-framework/master/shoulder-dependencies/pom.xml&notifyInstantlyAfterCheck=true&notifyReason=ONLY_TEST_DEMO' || echo '======= SKIP dependency check. ======='
```
```bash
# POST
curl --location --request POST 'http://localhost:12345/projects/create' --form 'email=yourEmail@demo.com' --form 'pomXml=@shoulder-dependencies/pom.xml' --form 'notifyInstantlyAfterCheck=true' --form 'notifyReason=CI-<a href="https://cicd.yourdomain.com/xxx/${DRONE_REPO_NAME}">${DRONE_REPO_NAME}::${DRONE_REPO_BRANCH}</a><br> with <a href="https://cicd.yourdomain.cn/gogs/${DRONE_REPO_NAME}/${DRONE_BUILD_NUMBER}">Drone Build-${DRONE_BUILD_NUMBER}</a><br>' || echo '======= SKIP dependency check. ======='
```

---

![icon.png](icon.png)
> 其他：本项目使用了 + [Shoulder-Framework](https://github.com/ChinaLym/shoulder-framework) （基于[Spring-Boot](https://github.com/spring-projects/spring-boot)的二次开发套件）搭建省下了不少工作量。