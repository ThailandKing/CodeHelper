package ${config.maven.groupId}.${config.maven.artifactId}.repository.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import ${config.maven.groupId}.${config.maven.artifactId}.domain.po.${data.dbTable};
import org.apache.ibatis.annotations.Mapper;

/**
 * ${data.dbTable}Mapper
 *
 * @author ${config.project.author}
 */
@Mapper
public interface ${data.dbTable}Mapper extends BaseMapper<${data.dbTable}> {

}