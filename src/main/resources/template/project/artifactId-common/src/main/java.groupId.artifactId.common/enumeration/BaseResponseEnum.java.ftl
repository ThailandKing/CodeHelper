package ${config.maven.groupId}.${config.maven.artifactId}.common.enumeration;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

/**
 * 统一响应枚举
 */
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@ToString
@Getter
public enum BaseResponseEnum {

    // SUCCESS
    SUCCESS(BaseResponseEnum.SUCCESS_CODE, "成功"),

    // ERROR
    PARAM_ERROR("A050001", "非法请求参数"),

    // OTHERS
    SERVICE_ERROR("C050001", "服务异常"),
    ;

    /**
     * <p>
     * 成功状态码常量
     * </p>
     */
    private static final String SUCCESS_CODE = "0000";

    /**
     * <p>
     * 状态码（系统+模块+编号）
     * 共7位：(A|B|C) + (05) + (01|02|03) + (01)
     * </p>
     */
    private final String code;

    /**
     * <p>
     * 提示消息
     * </p>
     */
    private final String message;
}