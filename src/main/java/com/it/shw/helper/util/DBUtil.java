package com.it.shw.helper.util;

import com.google.common.base.CaseFormat;

public class DBUtil {

    /**
     * 获取类名
     */
    public static String getClassName(String source) {
        return CaseFormat.UPPER_UNDERSCORE.to(CaseFormat.UPPER_CAMEL, source);
    }

    /**
     * 获取字段名
     */
    public static String getFiledName(String source) {
        return CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.LOWER_CAMEL, source);
    }

    /**
     * 类型转换
     */
    public static String toJavaType(String source) {
        source = source.toLowerCase();
        switch (source) {
            case "char":
            case "varchar":
            case "text":
                return "String";
            case "int":
            case "tinyint":
                return "Integer";
            case "float":
                return "Float";
            case "double":
                return "Double";
            case "decimal":
                return "BigDecimal";
            case "date":
            case "datetime":
                return "Date";
            default:
                break;
        }
        return source;
    }
}