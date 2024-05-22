package posts;

import cn.hutool.core.lang.Assert;
import lombok.Setter;
import org.junit.jupiter.api.Test;
import org.lym.pom.PomUpdateApplication;
import org.lym.pom.repository.mongo.enums.AttitudeTypeEnum;
import org.lym.pom.repository.mongo.enums.IntCodeEnum;
import org.shoulder.core.converter.ShoulderConversionService;
import org.shoulder.web.template.dictionary.dto.DictionaryItemDTO;
import org.shoulder.web.template.dictionary.model.ConfigAbleDictionaryItem;
import org.shoulder.web.template.dictionary.model.DictionaryItemEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.Instant;

@SpringBootTest(classes = PomUpdateApplication.class)
public class ConversionServiceTest {

    @Setter
    @Autowired
    protected ShoulderConversionService conversionService;
    @Test
    public void testConvert() {
        try {
            String time = conversionService.convert(Instant.now(), String.class);

            AttitudeTypeEnum a = conversionService.convert("LIKE", AttitudeTypeEnum.class);
            Assert.equals(a, AttitudeTypeEnum.LIKE);

            Assert.equals(conversionService.convert(AttitudeTypeEnum.DISLIKE, String.class), AttitudeTypeEnum.DISLIKE.getStorageName());
            Assert.equals(conversionService.convert(AttitudeTypeEnum.DISLIKE, String.class), AttitudeTypeEnum.DISLIKE.getItemId());
            Assert.equals(conversionService.convert(AttitudeTypeEnum.DISLIKE, Integer.class), AttitudeTypeEnum.DISLIKE.ordinal());

            Assert.equals(conversionService.convert(IntCodeEnum.T2, String.class), IntCodeEnum.T2.name());
            Assert.equals(conversionService.convert(IntCodeEnum.T2, Integer.class), IntCodeEnum.T2.getItemId());
            Assert.equals(conversionService.convert(IntCodeEnum.T2, Integer.class), IntCodeEnum.T2.getCustomerIntId());

            Assert.equals(conversionService.convert("D", AttitudeTypeEnum.class), AttitudeTypeEnum.DISLIKE);
            Assert.equals(conversionService.convert("2", AttitudeTypeEnum.class), AttitudeTypeEnum.DISLIKE);
            Assert.equals(conversionService.convert("DISLIKE", AttitudeTypeEnum.class), AttitudeTypeEnum.DISLIKE);

            // 区分大小写
//            Assert.notEquals(conversionService.convert("t2", IntCodeEnum.class), IntCodeEnum.T2);

            // str to intEnum  非常不建议，会走到通过name()寻找，但如果有人改了枚举项代码名称，会导致代码发布前后转换结果不同
            Assert.equals(conversionService.convert("T2", IntCodeEnum.class), IntCodeEnum.T2);
            Assert.equals(conversionService.convert("4", IntCodeEnum.class), IntCodeEnum.T2);

            // int to strEnum  非常不建议，会走到通过下标寻找，但如果有人写枚举时不再最后写，会导致代码发布前后转换结果不同
            Assert.equals(conversionService.convert(2, AttitudeTypeEnum.class), AttitudeTypeEnum.DISLIKE);
            Assert.equals(conversionService.convert(4, IntCodeEnum.class), IntCodeEnum.T2);

            DictionaryItemDTO dto = conversionService.convert(AttitudeTypeEnum.DISLIKE, DictionaryItemDTO.class);
            Assert.equals(dto.getCode(), AttitudeTypeEnum.DISLIKE.getItemId());
            Assert.equals(conversionService.convert(dto, AttitudeTypeEnum.class), AttitudeTypeEnum.DISLIKE);
            Assert.equals(conversionService.convert(dto, DictionaryItemEntity.class).getBizId(), dto.getCode());
            Assert.equals(conversionService.convert(dto, ConfigAbleDictionaryItem.class).getItemId(), dto.getCode());

            DictionaryItemDTO dto2 = conversionService.convert(IntCodeEnum.T2, DictionaryItemDTO.class);
            Assert.equals(dto2.getCode(), IntCodeEnum.T2.getItemId().toString());
            Assert.equals(conversionService.convert(dto2, IntCodeEnum.class), IntCodeEnum.T2);
            Assert.equals(conversionService.convert(dto2, DictionaryItemEntity.class).getBizId(), dto2.getCode());
            Assert.equals(conversionService.convert(dto2, ConfigAbleDictionaryItem.class).getItemId(), dto2.getCode());

        } catch (Exception e){
            throw e;
        }
    }


}
