package ${config.maven.groupId}.${config.maven.artifactId}.common.utils;

import ${config.maven.groupId}.${config.maven.artifactId}.common.enumeration.BaseResponseEnum;
import ${config.maven.groupId}.${config.maven.artifactId}.common.exception.ParameterCheckException;

/**
 * 参数校验工具类
 */
public class ParameterCheckUtil {

    /**
     * <p>
     * 私有构造函数
     * </p>
     */
    private ParameterCheckUtil() {
    }

    /**
     * <p>
     * 1、对象不为NULL
     * </p>
     */
    public static void checkNotNull(Object value, BaseResponseEnum baseResponseEnum) {
        if (value == null) {
            throw new ParameterCheckException(baseResponseEnum);
        }
    }

    /**
     * <p>
     * 2、字符串不为NULL不为空
     * </p>
     */
    public static void checkNotNullNotEmptyAfterTrimming(String value, BaseResponseEnum baseResponseEnum) {
        checkNotNull(value, baseResponseEnum);
        if (value.trim().length() == 0) {
            throw new ParameterCheckException(baseResponseEnum);
        }
    }
}