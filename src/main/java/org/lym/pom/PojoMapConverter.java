package org.lym.pom;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.thoughtworks.xstream.converters.Converter;
import com.thoughtworks.xstream.converters.MarshallingContext;
import com.thoughtworks.xstream.converters.UnmarshallingContext;
import com.thoughtworks.xstream.io.HierarchicalStreamReader;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;

/**
 * 动态标签转换器 xml -> Map<String, String>
 * @author lym
 */
public class PojoMapConverter implements Converter {

    public PojoMapConverter() {
        super();
    }

    @Override
    public boolean canConvert(Class clazz) {
        String classname = clazz.getName();
        return classname.contains("Map") || classname.contains("List");
    }

    // ******************************** Map -> xml ***********************************

    @Override
    public void marshal(Object value, HierarchicalStreamWriter writer,
                        MarshallingContext context) {

        map2xml(value, writer, context);
    }

    protected void map2xml(Object value, HierarchicalStreamWriter writer,
            MarshallingContext context) {
        boolean bMap = true;
        String classname = value.getClass().getName();

        bMap = (!classname.contains("List"));
        Map<String, Object> map;
        List<Object> list;
        String key;
        Object subvalue;
        if (bMap) {
            map = (Map<String, Object>) value;
            for (Iterator<Entry<String, Object>> iterator = map.entrySet()
                    .iterator(); iterator.hasNext();) {
                Entry<String, Object> entry = iterator
                        .next();
                key = (String) entry.getKey();
                subvalue = entry.getValue();
                writer.startNode(key);
                if (subvalue.getClass().getName().indexOf("String") >= 0) {
                    writer.setValue((String) subvalue);
                } else {
                    map2xml(subvalue, writer, context);
                }
                writer.endNode();
            }

        } else {
            list = (List<Object>) value;
            for (Object subval : list) {
                subvalue = subval;
                writer.startNode("child");
                if (subvalue.getClass().getName().indexOf("String") >= 0) {
                    writer.setValue((String) subvalue);
                } else {
                    map2xml(subvalue, writer, context);
                }
                writer.endNode();
            }
        }
    }

    // ******************************** xml -> Map ***********************************

    @Override
    public Map<String, Object> unmarshal(HierarchicalStreamReader reader,
                                         UnmarshallingContext context) {
        return (Map<String, Object>) populateMap(reader,
                context);
    }

    protected Object populateMap(HierarchicalStreamReader reader,
            UnmarshallingContext context) {
        boolean bMap = true;
        Map<String, Object> map = new HashMap<String, Object>();
        List<Object> list = new ArrayList<Object>();
        while (reader.hasMoreChildren()) {
            reader.moveDown();
            String key = reader.getNodeName();
            Object value = null;
            if (reader.hasMoreChildren()) {
                value = populateMap(reader, context);
            } else {
                value = reader.getValue();
            }
            if (bMap) {
                // 如果有多个重名标签，则转为 List
                if (map.containsKey(key)) {
                    // convert to list
                    bMap = false;
                    Iterator<Entry<String, Object>> iter = map.entrySet()
                            .iterator();
                    while (iter.hasNext())
                        list.add(iter.next().getValue());
                    // insert into list
                    list.add(value);
                } else {
                    // insert into map
                    map.put(key, value);
                }
            } else {
                // insert into list
                list.add(value);
            }
            reader.moveUp();
        }
        if (bMap) {
            return map;
        } else {
            return list;
        }
    }

}