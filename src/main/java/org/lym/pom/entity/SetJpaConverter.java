package org.lym.pom.entity;

import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import javax.persistence.AttributeConverter;
import java.util.*;

/**
 * @author lym
 */
public class SetJpaConverter implements AttributeConverter<Set<String>, String> {
	
	@Override
	public String convertToDatabaseColumn(Set<String> strings) {
		if(CollectionUtils.isEmpty(strings)){
			return "";
		}
		StringJoiner sj = new StringJoiner(",");
		strings.forEach(sj::add);
		return sj.toString();
	}

	@Override
	public Set<String> convertToEntityAttribute(String s) {
		if(StringUtils.isEmpty(s)){
			return new HashSet<>();
		}
		String[] strings = s.split(",");
		return new HashSet<>(Arrays.asList(strings));
	}
}