package com.it.shw.helper.service;

import com.it.shw.helper.config.CodeConfig;
import com.it.shw.helper.domain.bo.DBMetaInfo;
import com.it.shw.helper.domain.po.DBColumn;
import com.it.shw.helper.mapper.ColumnMapper;
import com.it.shw.helper.mapper.TableMapper;
import com.it.shw.helper.util.DBUtil;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DBService {

    @Autowired
    private TableMapper tableMapper;

    @Autowired
    private ColumnMapper columnMapper;

    @Autowired
    private CodeConfig codeConfig;

    /**
     * 获取数据库元数据信息
     */
    public List<DBMetaInfo> getDBMetaInfo() {
        List<DBMetaInfo> dbMetaInfoList = new ArrayList<>();
        List<String> tableNameList = tableMapper.getTableNameList(codeConfig.getDb().getDatabase());
        for (String tableName : tableNameList) {
            List<DBColumn> columns = columnMapper.getColumnList(tableName);
            Set<String> dataTypeList = new HashSet<>();
            List<DBColumn> columnList = new ArrayList<>();
            for (DBColumn dbColumn : columns) {
                // 过滤系统字段
                if (codeConfig.getDb().getIgnoreFiledList().contains(dbColumn.getColumnName())) {
                    continue;
                }
                // 转换列名+转换类型
                String dataType = DBUtil.toJavaType(dbColumn.getDataType());
                dataTypeList.add(dataType);
                dbColumn.setColumnName(DBUtil.getFiledName(dbColumn.getColumnName()));
                dbColumn.setDataType(dataType);
                columnList.add(dbColumn);
            }
            DBMetaInfo dbMetaInfo = new DBMetaInfo();
            dbMetaInfo.setDbTable(DBUtil.getClassName(tableName));
            dbMetaInfo.setDbColumnList(columnList);
            dbMetaInfo.setDataTypeList(dataTypeList);
            dbMetaInfoList.add(dbMetaInfo);
        }
        return dbMetaInfoList;
    }
}