package ${config.maven.groupId}.${config.maven.artifactId}.common.enumeration;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

/**
 * 启用停用枚举
 */
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@ToString
@Getter
public enum EnableEnum {

    ENABLE(1, "启用"),
    DISABLE(0, "禁用"),
    ;

    /**
     * <p>
     * 值
     * </p>
     */
    private final Integer value;

    /**
     * <p>
     * 名称
     * </p>
     */
    private final String name;

    /**
     * <p>
     * 获取name
     * </p>
     */
    public static String getNameByValue(Integer value) {
        for (EnableEnum enableEnum : EnableEnum.values()) {
            if (enableEnum.getValue().equals(value)) {
                return enableEnum.getName();
            }
        }
        return null;
    }
}