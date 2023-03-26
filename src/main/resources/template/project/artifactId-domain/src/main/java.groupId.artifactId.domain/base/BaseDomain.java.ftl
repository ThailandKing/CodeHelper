package ${config.maven.groupId}.${config.maven.artifactId}.domain.base;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import java.util.Date;
import lombok.Data;

/**
 * 基础领域对象
 */
@Data
public class BaseDomain {

    /**
     * 主键
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 是否有效
     */
    private Integer enable;

    /**
     * 是否删除
     */
    @TableLogic
    private Date deleted;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 创建人
     */
    private String createUser;

    /**
     * 最近修改时间
     */
    private Date modifyTime;

    /**
     * 最近修改人
     */
    private String modifyUser;
}