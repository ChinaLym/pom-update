package org.lym.pom.util;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.converters.reflection.ObjectAccessException;
import com.thoughtworks.xstream.converters.reflection.PureJavaReflectionProvider;
import com.thoughtworks.xstream.io.naming.NoNameCoder;
import com.thoughtworks.xstream.io.xml.DomDriver;
import org.lym.pom.dto.xml.*;

import java.io.File;
import java.io.InputStream;
import java.lang.reflect.Field;

/**
 * @author lym
 */
public class XmlUtil {

    /**
     * 匹配准确度
     * 语法复杂度（思考花费时间长短）
     * 后续处理复杂度
     * 可维护性
     * 可读性
     */
    private static final XStream DEFAULT_X_STREAM;

    static {
        DEFAULT_X_STREAM = generateDefaultXStream();
        //DEFAULT_X_STREAM.registerConverter(new PojoMapConverter());
        Class<?>[] xmlClass = new Class[]{ProjectDTO.class, DependencyDTO.class, DependencyManagementDTO.class,
                BuildDTO.class, PluginDTO.class, PluginManagementDTO.class};
        DEFAULT_X_STREAM.processAnnotations(xmlClass);
        DEFAULT_X_STREAM.allowTypes(xmlClass);
    }

    public static XStream generateDefaultXStream() {
        XStream xStream = new XStream(new FieldDefaultValueProvider(), new DomDriver("UTF-8", new NoNameCoder()));
        XStream.setupDefaultSecurity(xStream);
        //自动探测注解
        xStream.autodetectAnnotations(true);
        //忽略未知元素
        xStream.ignoreUnknownElements();
        return xStream;
    }

    /**
     * xml转对象时，默认值 null
     */
    public static class FieldDefaultValueProvider extends PureJavaReflectionProvider {

        @Override
        public void writeField(Object object, String fieldName, Object value, Class definedIn) {
            //返回存在于xml中的字段
            Field field = fieldDictionary.field(object.getClass(), fieldName, definedIn);
            //验证字段可以被访问
            validateFieldAccess(field);
            try {
                if (value instanceof String) {
                    //字符串首尾去空
                    String trim = ((String) value).trim();
                    if (trim.length() == 0) {
                        //如果是空字符串，则不做赋值，使用默认初始值
                        return;
                    }
                    field.set(object, trim);
                } else {
                    field.set(object, value);
                }
            } catch (Exception e) {
                throw new ObjectAccessException("Could not set field " + object.getClass() + "." + field.getName(), e);
            }
        }
    }

    /**
     * 将xml文件解析为实体对象
     *
     * @param xml xml文件
     * @return
     */
    public static <T extends Object> T xmlToObject(XStream xStream, File xml) {
        if (xml == null) {
            return null;
        }
        return (T) xStream.fromXML(xml);
    }

    public static <T extends Object> T xmlToObject(File xml) throws Exception {
        try {
            return (T) DEFAULT_X_STREAM.fromXML(xml);
        } catch (Exception e) {
            throw new Exception("convert xml to object FAIL!", e);
        }
    }

    public static <T extends Object> T xmlToObject(InputStream inputStream) throws Exception {
        try {
            return (T) DEFAULT_X_STREAM.fromXML(inputStream);
        } catch (Exception e) {
            throw new Exception("convert xml to object FAIL!", e);
        }
    }

    public static void main(String[] args) throws Exception {
        //ProjectDTO projectDTO = xmlToObject(new File("F:\\codes\\java\\self\\shoulder-framework\\shoulder-dependencies/pom.xml"));
        ProjectDTO projectDTO = xmlToObject(new File("/Users/liuyanming/IdeaProjects/openSource/pom-update/pom.xml"));
        System.out.println(projectDTO);
    }

}
