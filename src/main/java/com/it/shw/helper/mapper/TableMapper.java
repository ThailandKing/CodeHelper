package com.it.shw.helper.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.it.shw.helper.domain.po.DBTable;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface TableMapper extends BaseMapper<DBTable> {

    /**
     * 获取指定tableSchema下元数据信息
     */
    @Select({"SELECT DISTINCT TABLE_NAME FROM information_schema.tables WHERE table_schema = #{tableSchema}"})
    List<String> getTableNameList(@Param(value = "tableSchema") String tableSchema);
}