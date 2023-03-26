package ${config.maven.groupId}.${config.maven.artifactId}.web.advice;

import ${config.maven.groupId}.${config.maven.artifactId}.common.utils.JsonUtil;
import ${config.maven.groupId}.${config.maven.artifactId}.common.result.HttpResult;
import ${config.maven.groupId}.${config.maven.artifactId}.common.enumeration.BaseResponseEnum;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.lang.Nullable;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

/**
 * 统一返回处理
 */
@ControllerAdvice
public class HttpResultResponseBodyAdvice implements ResponseBodyAdvice<Object> {

    @Override
    public boolean supports(MethodParameter returnType, @Nullable Class<? extends HttpMessageConverter<?>> converterType) {
        return true;
    }

    @Override
    public Object beforeBodyWrite(Object body, MethodParameter returnType, MediaType selectedContentType, Class<? extends HttpMessageConverter<?>> selectedConverterType, ServerHttpRequest request, ServerHttpResponse response) {
        if (body instanceof String) {
            return JsonUtil.writeValueAsString(new HttpResult<>(BaseResponseEnum.SUCCESS.getCode(), null, body));
        }
        if (body instanceof HttpResult) {
            return body;
        }
        if (body instanceof BaseResponseEnum) {
            BaseResponseEnum baseResponseEnum = (BaseResponseEnum) body;
            return new HttpResult<>(baseResponseEnum.getCode(), baseResponseEnum.getMessage(), null);
        }
        return new HttpResult<>(BaseResponseEnum.SUCCESS.getCode(), null, body);
    }
}