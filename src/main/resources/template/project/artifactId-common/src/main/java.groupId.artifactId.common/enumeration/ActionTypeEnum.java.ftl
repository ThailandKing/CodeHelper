package ${config.maven.groupId}.${config.maven.artifactId}.common.enumeration;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

/**
 * 操作类型枚举
 */
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@ToString
@Getter
public enum ActionTypeEnum {

    GET("获取", "get"),
    LIST("列表", "list"),
    PAGE("分页", "page"),
    ADD("添加", "add"),
    UPDATE("更新", "update"),
    DELETE("删除", "delete"),
    UPLOAD("上传", "upload"),
    DOWNLOAD("下载", "download"),
    ;

    /**
     * <p>
     * 名称
     * </p>
     */
    private final String name;

    /**
     * <p>
     * 值
     * </p>
     */
    private final String value;

    /**
     * <p>
     * 获取名称
     * </p>
     */
    public static String getNameByValue(String value) {
        for (ActionTypeEnum actionTypeEnum : ActionTypeEnum.values()) {
            if (actionTypeEnum.getValue().equals(value)) {
                return actionTypeEnum.getName();
            }
        }
        return null;
    }
}