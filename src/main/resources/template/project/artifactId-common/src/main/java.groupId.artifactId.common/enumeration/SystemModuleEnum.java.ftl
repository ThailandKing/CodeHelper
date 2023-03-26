package ${config.maven.groupId}.${config.maven.artifactId}.common.enumeration;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

/**
 * 系统模块枚举
 */
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@ToString
@Getter
public enum SystemModuleEnum {

    COMMON("COMMON", "公共模块"),
    ;

    /**
     * <p>
     * 值
     * </p>
     */
    private final String value;

    /**
     * <p>
     * 名称
     * </p>
     */
    private final String name;

    /**
     * <p>
     * 获取名称
     * </p>
     */
    public static String getNameByValue(String value) {
        for (SystemModuleEnum systemModuleEnum : SystemModuleEnum.values()) {
            if (systemModuleEnum.getValue().equals(value)) {
                return systemModuleEnum.getName();
            }
        }
        return null;
    }
}