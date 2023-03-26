package com.it.shw.helper.domain.bo;

import com.it.shw.helper.domain.po.DBColumn;

import java.util.List;
import java.util.Set;

import lombok.Data;

/**
 * DB元数据信息
 */
@Data
public class DBMetaInfo {
    // 数据表名
    private String dbTable;
    // 数据表中列集合
    private List<DBColumn> dbColumnList;
    // 数据表中类型集合
    private Set<String> dataTypeList;
}