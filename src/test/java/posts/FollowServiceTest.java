package posts;

import cn.hutool.core.lang.Assert;
import org.junit.jupiter.api.Test;
import org.lym.pom.PomUpdateApplication;
import org.lym.pom.repository.mongo.Follow;
import org.lym.pom.service.FollowService;
import org.shoulder.core.dto.request.BasePageQuery;
import org.shoulder.core.dto.response.PageResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.mongodb.core.MongoTemplate;

@SpringBootTest(classes = PomUpdateApplication.class)
public class FollowServiceTest {

    @Autowired
    private MongoTemplate mongoTemplate;

    @Autowired
    private FollowService followService;

    @Test
    public void testFollowService() {
        String userId = "user1";
        String followUserId = "user2";
        // 确认没数据
        followService.unfollow(userId, followUserId);
        Assert.isFalse(followService.isFollow(userId, followUserId));

        // 测试 follow 方法
        followService.follow(userId, followUserId);
        
        // 进行查询验证
        Assert.isTrue(followService.isFollow(userId, followUserId));
        Assert.isFalse(followService.isFollow(followUserId, userId));
        Assert.equals(followService.countFollowNumber(userId), 1L);
        Assert.equals(followService.countFollowNumber(followUserId), 0L);

        BasePageQuery<Follow> followPageQuery = new BasePageQuery<>(1, 10);
        Follow followCondition = new Follow();
        followCondition.setUserId(userId);
        followPageQuery.setCondition(followCondition);
        PageResult<Follow> followListResult = followService.pageQueryFollows(followPageQuery);
        Assert.equals(followListResult.getTotalPageNum(), 1);
        Assert.equals(followListResult.getTotal(), 1L);

        BasePageQuery<Follow> followedPageQuery = new BasePageQuery<>(1, 10);
        Follow followedCondition = new Follow();
        followedCondition.setFolloweeUserId(followUserId);
        followedPageQuery.setCondition(followedCondition);
        PageResult<Follow> followedListResult = followService.pageQueryFollowed(followedPageQuery);
        Assert.equals(followedListResult.getTotalPageNum(), 1);
        Assert.equals(followedListResult.getTotal(), 1L);

        followService.unfollow(userId, followUserId);

        Assert.isFalse(followService.isFollow(userId, followUserId));
        Assert.isFalse(followService.isFollow(followUserId, userId));
        Assert.equals(followService.countFollowNumber(userId), 0L);
        Assert.equals(followService.countFollowNumber(followUserId), 0L);
    }


}
