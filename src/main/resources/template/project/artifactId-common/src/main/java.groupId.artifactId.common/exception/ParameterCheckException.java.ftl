package ${config.maven.groupId}.${config.maven.artifactId}.common.exception;

import ${config.maven.groupId}.${config.maven.artifactId}.common.enumeration.BaseResponseEnum;
import lombok.Getter;

/**
 * 参数校验异常
 */
public class ParameterCheckException extends RuntimeException {

    @Getter
    private final String code;

    /**
     * <p>
     * 构造函数
     * </p>
     */
    public ParameterCheckException(BaseResponseEnum baseResponseEnum) {
        super(baseResponseEnum.getMessage());
        this.code = baseResponseEnum.getCode();
    }
}