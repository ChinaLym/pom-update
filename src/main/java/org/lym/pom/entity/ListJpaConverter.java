package org.lym.pom.entity;

import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import javax.persistence.AttributeConverter;
import java.util.*;

/**
 * @author lym
 */
public class ListJpaConverter implements AttributeConverter<List<String>, String> {
	
	@Override
	public String convertToDatabaseColumn(List<String> strings) {
		if(CollectionUtils.isEmpty(strings)){
			return "";
		}
		StringJoiner sj = new StringJoiner(",");
		strings.forEach(sj::add);
		return sj.toString();
	}

	@Override
	public List<String> convertToEntityAttribute(String s) {
		if(StringUtils.isEmpty(s)){
			return new LinkedList<>();
		}
		String[] strings = s.split(",");
		return new ArrayList<>(Arrays.asList(strings));
	}
}

