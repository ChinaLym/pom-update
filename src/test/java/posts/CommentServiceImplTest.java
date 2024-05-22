package posts;

import cn.hutool.core.lang.Assert;
import org.junit.jupiter.api.Test;
import org.lym.pom.PomUpdateApplication;
import org.lym.pom.repository.mongo.Comment;
import org.lym.pom.repository.mongo.Comment.RelatedType;
import org.lym.pom.repository.mongo.Comment.Type;
import org.lym.pom.repository.mongo.enums.CommentStatusEnum;
import org.lym.pom.service.CommentService;
import org.shoulder.core.dto.request.BasePageQuery;
import org.shoulder.core.dto.response.PageResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

@SpringBootTest(classes = PomUpdateApplication.class)
public class CommentServiceImplTest {

    @Autowired
    private MongoTemplate mongoTemplate;

    @Autowired
    private CommentService commentService;

    String relatedId   = "unit_test_post_demo_id";
    String publishUser = "unit_test_post_creator";
    String commentCreator = "unit_test_comment_creator";
    String mentionedUserId = "unit_test_comment_mentionedUserId";
    String commentContent = "this is a content.😄";
    @Test
    public void testCommentService() throws InterruptedException {
        // 清空
        Query cleanQuery = new Query(Criteria.where("relatedUserId").is(publishUser));
        mongoTemplate.remove(cleanQuery, Comment.class);

        // 创建自评
        Comment comment = new Comment();
        comment.setXxx(CommentStatusEnum.AUDIT);
        comment.setRelatedId(relatedId);
        comment.setRelatedType(RelatedType.MOMENT);
        comment.setRelatedUserId(publishUser);
        comment.setCreator(publishUser);
        comment.setType(Type.TEXT);
        comment.setContent(commentContent);
        commentService.addComment(comment);

        long count = commentService.countCommentNumber(relatedId, RelatedType.MOMENT, null);
        Assert.notEquals(count, 0L);

        // 分页查询
        BasePageQuery<Comment> pageQuery = new BasePageQuery<>();
        Comment condition = new Comment();
        condition.setRelatedId(relatedId);
        condition.setRelatedType(RelatedType.MOMENT);
        pageQuery.setCondition(condition);
        PageResult<Comment> pageResult = commentService.pageQueryDirectComments(pageQuery);
        Assert.equals(pageResult.getTotalPageNum(), 1);
        Assert.equals(pageResult.getTotal(), 1L);
        Assert.isNull(pageResult.getList().get(0).getSubComments());

        String firstCommentId = pageResult.getList().get(0).getId();

        // 查单条
        Comment queryById = commentService.queryCommentDetail(firstCommentId);
        Assert.equals(queryById.getContent(), commentContent);

        // 分页查询含子评论
        PageResult<Comment> pageIncludeSubResult = commentService.pageQueryDirectCommentsWithSubComments(pageQuery);
        Assert.equals(pageIncludeSubResult.getTotalPageNum(), 1);
        Assert.equals(pageIncludeSubResult.getTotal(), 1L);
        Assert.equals(pageIncludeSubResult.getList().get(0).getSubComments().getTotal(), 0L);

        // 评论的评论
        Comment replyComment = new Comment();
        replyComment.setRelatedId(relatedId);
        replyComment.setRelatedType(RelatedType.MOMENT);
        replyComment.setRelatedUserId(publishUser);
        replyComment.setCreator(publishUser);
        replyComment.setType(Type.TEXT);
        replyComment.setContent(commentContent + "__reply");
        replyComment.setRootCommentId(firstCommentId);
        commentService.addComment(replyComment);

        pageIncludeSubResult = commentService.pageQueryDirectCommentsWithSubComments(pageQuery);
        Assert.equals(pageIncludeSubResult.getTotalPageNum(), 1);
        Assert.equals(pageIncludeSubResult.getTotal(), 1L);
        Assert.equals(pageIncludeSubResult.getList().get(0).getSubComments().getTotal(), 1L);
        String commentId2 = pageIncludeSubResult.getList().get(0).getSubComments().getList().get(0).getId();

        // 创建评论的评论的回复
        Comment reply2Comment = new Comment();
        reply2Comment.setRelatedId(relatedId);
        reply2Comment.setRelatedType(RelatedType.MOMENT);
        reply2Comment.setRelatedUserId(publishUser);
        reply2Comment.setParentId(commentId2);
        reply2Comment.setCreator(publishUser);
        reply2Comment.setType(Type.TEXT);
        reply2Comment.setContent(commentContent + "__reply_reply");
        reply2Comment.setRootCommentId(firstCommentId);
        commentService.addComment(reply2Comment);

        pageIncludeSubResult = commentService.pageQueryDirectCommentsWithSubComments(pageQuery);
        Assert.equals(pageIncludeSubResult.getTotalPageNum(), 1);
        Assert.equals(pageIncludeSubResult.getTotal(), 1L);
        Assert.equals(pageIncludeSubResult.getList().get(0).getSubComments().getTotal(), 2L);

        commentService.removeComment(comment);
        pageIncludeSubResult = commentService.pageQueryDirectCommentsWithSubComments(pageQuery);
        Assert.equals(pageIncludeSubResult.getTotal(), 0L);

        pageIncludeSubResult = commentService.pageQueryDirectCommentsWithSubComments(pageQuery);
        Assert.equals(pageIncludeSubResult.getTotalPageNum(), 0);
        Assert.equals(pageIncludeSubResult.getTotal(), 0L);

        // 清空
        mongoTemplate.remove(cleanQuery, Comment.class);
        // 确保清空
        PageResult<Comment> cleanConfirmResult = commentService.pageQueryDirectCommentsWithSubComments(pageQuery);
        Assert.equals(cleanConfirmResult.getTotal(), 0L);

    }

}
