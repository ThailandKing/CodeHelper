package ${config.maven.groupId}.${config.maven.artifactId}.common.utils;

/**
 * 获取登录信息工具类
 */
public class LoginUtil {

    private static final String DEFAULT_USER_NAME = "default";

    /**
     * <p>
     * 私有构造函数
     * </p>
     */
    private LoginUtil() {

    }

    /**
     * <p>
     * 获取username
     * </p>
     */
    public static String getUserName() {
        return DEFAULT_USER_NAME;
    }
}