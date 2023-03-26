package ${config.maven.groupId}.${config.maven.artifactId}.common.result;

import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 统一返回结果
 */
@Data
@NoArgsConstructor
public class HttpResult<T> implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 状态码
     */
    private String code;

    /**
     * 提示消息
     */
    private String message;

    /**
     * 数据
     */
    private T data;

    /**
     * 构造函数
     */
    public HttpResult(String code, String message, T data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }
}