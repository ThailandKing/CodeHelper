package ${config.maven.groupId}.${config.maven.artifactId}.common.utils;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;

/**
 * json工具类
 */
@Slf4j
public class JsonUtil {

    private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

    static {
        OBJECT_MAPPER.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
    }

    /**
     * <p>
     * 转换对象为字符串
     * </p>
     */
    public static String writeValueAsString(Object value) {
        try {
            return OBJECT_MAPPER.writeValueAsString(value);
        } catch (Exception e) {
            log.error("转换对象为字符串失败！", e);
        }
        return null;
    }

    /**
     * <p>
     * 转换字符串为对象
     * </p>
     */
    public static <T> T readValue(String jsonStr, Class<T> valueType) {
        try {
            return OBJECT_MAPPER.readValue(jsonStr, valueType);
        } catch (Exception e) {
            log.error("转换字符串为对象失败！", e);
        }
        return null;
    }
}