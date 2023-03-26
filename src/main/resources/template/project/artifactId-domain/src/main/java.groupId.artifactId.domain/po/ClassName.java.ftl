package ${config.maven.groupId}.${config.maven.artifactId}.domain.po;

import ${config.maven.groupId}.${config.maven.artifactId}.domain.base.BaseDomain;
import lombok.Data;
import lombok.EqualsAndHashCode;
<#list data.dataTypeList as i>
    <#if i == "BigDecimal" >
import java.math.BigDecimal;
        <#break />
    </#if>
</#list>
<#list data.dataTypeList as i>
    <#if i == "Date" >
import java.util.Date;
        <#break />
    </#if>
</#list>

/**
 * ${data.dbTable}
 *
 * @author ${config.project.author}
 */
@EqualsAndHashCode(callSuper = false)
@Data
public class ${data.dbTable} extends BaseDomain {

<#list data.dbColumnList as dbColumn>
    /**
     * ${dbColumn.columnComment}
     */
    private ${dbColumn.dataType} ${dbColumn.columnName};

</#list>
}