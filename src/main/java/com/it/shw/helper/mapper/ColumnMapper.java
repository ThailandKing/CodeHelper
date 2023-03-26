package com.it.shw.helper.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.it.shw.helper.domain.po.DBColumn;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ColumnMapper extends BaseMapper<DBColumn> {

    /**
     * 获取指定tableName下元数据信息
     */
    @Select({"SELECT DISTINCT COLUMN_NAME, DATA_TYPE, COLUMN_COMMENT FROM information_schema.COLUMNS WHERE table_name = #{tableName}"})
    List<DBColumn> getColumnList(@Param(value = "tableName") String tableName);
}