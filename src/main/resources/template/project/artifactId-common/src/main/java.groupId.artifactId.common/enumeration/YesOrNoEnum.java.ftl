package ${config.maven.groupId}.${config.maven.artifactId}.common.enumeration;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

/**
 * 是否枚举
 */
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@ToString
@Getter
public enum YesOrNoEnum {

    YES(1, "是"),
    NO(0, "否"),
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
        for (YesOrNoEnum yesOrNoEnum : YesOrNoEnum.values()) {
            if (yesOrNoEnum.getValue().equals(value)) {
                return yesOrNoEnum.getName();
            }
        }
        return null;
    }
}