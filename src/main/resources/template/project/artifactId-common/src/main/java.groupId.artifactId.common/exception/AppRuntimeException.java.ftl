package ${config.maven.groupId}.${config.maven.artifactId}.common.exception;

import ${config.maven.groupId}.${config.maven.artifactId}.common.enumeration.BaseResponseEnum;
import lombok.Getter;

/**
 * 应用运行异常
 */
public class AppRuntimeException extends RuntimeException {

    @Getter
    private final String code;

    /**
     * <p>
     * 构造函数
     * </p>
     */
    public AppRuntimeException(BaseResponseEnum baseResponseEnum) {
        super(baseResponseEnum.getMessage());
        this.code = baseResponseEnum.getCode();
    }

    /**
     * <p>
     * 构造函数
     * </p>
     */
    public AppRuntimeException(String code, String message) {
        super(message);
        this.code = code;
    }
}