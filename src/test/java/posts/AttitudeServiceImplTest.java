package posts;

import cn.hutool.core.lang.Assert;
import org.junit.jupiter.api.Test;
import org.lym.pom.PomUpdateApplication;
import org.lym.pom.repository.mongo.Attitude;
import org.lym.pom.repository.mongo.Comment;
import org.lym.pom.repository.mongo.Comment.RelatedType;
import org.lym.pom.repository.mongo.Comment.Type;
import org.lym.pom.service.AttitudeService;
import org.lym.pom.service.CommentService;
import org.shoulder.core.dto.request.BasePageQuery;
import org.shoulder.core.dto.response.PageResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

import java.util.Map;

@SpringBootTest(classes = PomUpdateApplication.class)
public class AttitudeServiceImplTest {

    @Autowired
    private MongoTemplate mongoTemplate;

    @Autowired
    private CommentService commentService;

    @Autowired
    private AttitudeService attitudeService;

    String relatedId   = "unit_test_comment_demo_id";
    String publishUser = "unit_test_post_creator";
    String attitudeCreator = "unit_test_attitude_creator";
    String commentContent = "this is a content.😄";
    @Test
    public void testCommentService() throws InterruptedException {

        // 清空
        Query cleanAttitudeQuery = new Query(Criteria.where("creator").is(attitudeCreator));
        mongoTemplate.remove(cleanAttitudeQuery, Attitude.class);

        Query cleanCommentQuery = new Query(Criteria.where("relatedUserId").is(publishUser));
        mongoTemplate.remove(cleanCommentQuery, Comment.class);

        // 创建自评
        Comment comment = new Comment();
        comment.setRelatedId(relatedId);
        comment.setRelatedType(RelatedType.MOMENT);
        comment.setRelatedUserId(publishUser);
        comment.setCreator(publishUser);
        comment.setType(Type.TEXT);
        comment.setContent(commentContent);
        commentService.addComment(comment);

        // 分页查询-确保评论成功
        BasePageQuery<Comment> pageQuery = new BasePageQuery<>();
        Comment condition = new Comment();
        condition.setRelatedId(relatedId);
        condition.setRelatedType(RelatedType.MOMENT);
        pageQuery.setCondition(condition);
        PageResult<Comment> pageIncludeSubResult = commentService.pageQueryDirectComments(pageQuery);
        Assert.equals(pageIncludeSubResult.getTotal(), 1L);

        // 为评论点赞
        String commentId = pageIncludeSubResult.getList().get(0).getId();
        Attitude attitude = new Attitude();
        attitude.setRelatedId(commentId);
        attitude.setRelatedType(Attitude.RelatedType.COMMENT.getStorageValue());
        attitude.setRelatedUserId(publishUser);
        attitude.setCreator(attitudeCreator);
        attitude.setType(Attitude.Type.LIKE);
        attitudeService.addAttitude(attitude);

        // 查询点赞、踩分布
        Map<String, Integer> groupCount = attitudeService.countAttitudeNumber(attitude.getRelatedId(), attitude.getRelatedType());
        Assert.equals(groupCount.getOrDefault(Attitude.Type.LIKE, 0), 1);
        Assert.equals(groupCount.getOrDefault(Attitude.Type.LOVE, 0), 0);
        Assert.equals(groupCount.getOrDefault(Attitude.Type.DISLIKE, 0), 0);

        // wait 点赞后查询 post 赞数量
        //Thread.sleep(2000);
        Comment commentUpdated = commentService.queryCommentDetail(commentId);
        Assert.equals(commentUpdated.getLikeNumber(), 1);

        // cancel
        attitudeService.removeAttitude(attitude);
        // 确保cancel
        Attitude canceledLikeAttitude = attitudeService.queryAttitudeDetail(relatedId, Attitude.RelatedType.COMMENT.getStorageValue(), attitudeCreator);
        Assert.isNull(canceledLikeAttitude);
        // 查询点赞、踩分布
        groupCount = attitudeService.countAttitudeNumber(attitude.getRelatedId(), attitude.getRelatedType());
        Assert.equals(groupCount.getOrDefault(Attitude.Type.LIKE, 0), 0);
        Assert.equals(groupCount.getOrDefault(Attitude.Type.LOVE, 0), 0);
        Assert.equals(groupCount.getOrDefault(Attitude.Type.DISLIKE, 0), 0);
        commentUpdated = commentService.queryCommentDetail(commentId);
        Assert.equals(commentUpdated.getLikeNumber(), 0);

        // =====================
        // 清空
        mongoTemplate.remove(cleanCommentQuery, Comment.class);
        mongoTemplate.remove(cleanAttitudeQuery, Attitude.class);
        // 确保清空
        PageResult<Comment> cleanConfirmResult = commentService.pageQueryDirectCommentsWithSubComments(pageQuery);
        Assert.equals(cleanConfirmResult.getTotal(), 0L);

    }

}
