import org.junit.jupiter.api.Test;
import org.lym.pom.PomUpdateApplication;
import org.lym.pom.repository.mongo.Comment;
import org.shoulder.core.util.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

@SpringBootTest(classes = PomUpdateApplication.class)
public class TestMongodb {

    @Autowired
    private MongoTemplate mongoTemplate;


    @Test
    public void create(){
        boolean exists = mongoTemplate.collectionExists("comment");
        System.out.println("mongodb exists collection: comment");
    }

    @Test
    public void testMongo() {
        Criteria criteria = Criteria.where("relatedId").is("xxx");
        Query query = new Query(criteria)
                .with(Sort.by(Sort.Order.desc("userId")))
                .limit(1);
        Comment comment = mongoTemplate.findOne(query, Comment.class);
        System.out.println(JsonUtils.toJson(comment));
    }

}
