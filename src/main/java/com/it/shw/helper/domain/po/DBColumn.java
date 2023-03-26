package com.it.shw.helper.domain.po;

import lombok.Data;

/**
 * 数据表列
 */
@Data
public class DBColumn {
    // 列名
    private String columnName;
    // 数据类型
    private String dataType;
    // 列描述
    private String columnComment;
}