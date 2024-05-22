package posts;

import cn.hutool.core.lang.Assert;
import org.junit.jupiter.api.Test;
import org.lym.pom.PomUpdateApplication;
import org.lym.pom.repository.mongo.Feed;
import org.lym.pom.repository.mongo.Post;
import org.lym.pom.repository.mongo.enums.PostTypeEnum;
import org.lym.pom.repository.mongo.enums.PostVisibilityEnum;
import org.lym.pom.service.FeedService;
import org.lym.pom.service.FollowService;
import org.lym.pom.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

import java.util.List;
import java.util.Set;

@SpringBootTest(classes = PomUpdateApplication.class)
public class PostServiceTest {

    @Autowired
    private MongoTemplate mongoTemplate;

    @Autowired
    private PostService postService;

    @Autowired
    private FeedService feedService;

    @Autowired
    private FollowService followService;

    String postId      = "unit_post_test_demo_id";
    String postCreator = "unit_post_test_creator";
    String follower    = "unit_post_test_follower";

    @Test
    public void testPostService() {
        // 清空
        Query cleanPostQuery = new Query(Criteria.where("creator").is(postCreator));
        mongoTemplate.remove(cleanPostQuery, Post.class);
        Query cleanFeedQuery = new Query(Criteria.where("relatedCreator").is(postCreator));
        mongoTemplate.remove(cleanFeedQuery, Feed.class);
        followService.unfollow(follower, postCreator);
        Assert.isFalse(followService.isFollow(follower, postCreator));

        followService.follow(follower, postCreator);

        Post post = new Post();

        post.setCreator(postCreator);
        post.setTitle("title");
        post.setContent("xxx");
        post.setDevice("phone");
        post.setType(PostTypeEnum.MOMENT.getStorageName());
        post.setVisibility(PostVisibilityEnum.PUBLIC.getStorageName());
        // 发布文章
        post = postService.addPost(post);
        Assert.notNull(post);
        Assert.notNull(post.getId());

        // 查详情
        Post fromDb = postService.queryPostDetail(post.getId());
        Assert.notNull(fromDb);

        // 查列表
        List<Post> postList = postService.queryListByIds(Set.of(post.getId()));
        Assert.notNull(postList);
        Assert.isFalse(postList.isEmpty());

        // 查询个人动态
        List<Feed> feedList = feedService.queryByUserId(postCreator, postCreator);
        Assert.notEmpty(feedList);
        Assert.equals(feedList.size(), 1);
        Assert.equals(feedList.get(0).getRelatedId(), post.getId());

        // 查询好友时间轴
        List<Feed> followerFeedList = feedService.queryByUserId(follower, postCreator);
        Assert.notEmpty(followerFeedList);
        Assert.equals(followerFeedList.size(), 1);
        Assert.equals(followerFeedList.get(0).getRelatedId(), post.getId());

        // 删除 查不到 POST
        postService.removePost(post.getId());
        Post fromDbAfterDelete = postService.queryPostDetail(post.getId());
        Assert.isNull(fromDbAfterDelete);

        // 清空
        mongoTemplate.remove(cleanPostQuery, Post.class);
        mongoTemplate.remove(cleanFeedQuery, Feed.class);
    }

}
