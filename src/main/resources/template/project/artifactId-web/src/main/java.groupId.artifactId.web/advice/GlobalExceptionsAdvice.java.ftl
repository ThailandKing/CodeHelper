package ${config.maven.groupId}.${config.maven.artifactId}.web.advice;

import ${config.maven.groupId}.${config.maven.artifactId}.common.result.HttpResult;
import ${config.maven.groupId}.${config.maven.artifactId}.common.enumeration.BaseResponseEnum;
import ${config.maven.groupId}.${config.maven.artifactId}.common.exception.AppRuntimeException;
import ${config.maven.groupId}.${config.maven.artifactId}.common.exception.ParameterCheckException;
import java.util.stream.Collectors;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.support.DefaultMessageSourceResolvable;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * 全局统一异常处理
 */
@RestControllerAdvice
@Slf4j
public class GlobalExceptionsAdvice {

    /**
     * <p>
     * 请求参数异常
     * </p>
     */
    @ResponseStatus(HttpStatus.OK)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public HttpResult<Object> methodArgumentNotValidExceptionHandler(MethodArgumentNotValidException e) {
        String message = e.getBindingResult().getAllErrors().stream().map(DefaultMessageSourceResolvable::getDefaultMessage).collect(Collectors.joining());
        return buildErrorResult(BaseResponseEnum.PARAM_ERROR.getCode(), message, e);
    }

    /**
     * <p>
     * 参数校验异常
     * </p>
     */
    @ResponseStatus(HttpStatus.OK)
    @ExceptionHandler(ParameterCheckException.class)
    public HttpResult<Object> parameterCheckExceptionHandler(ParameterCheckException e) {
        return buildErrorResult(e.getCode(), e.getMessage(), e);
    }

    /**
     * <p>
     * 应用执行异常
     * </p>
     */
    @ResponseStatus(HttpStatus.OK)
    @ExceptionHandler(AppRuntimeException.class)
    public HttpResult<Object> appRuntimeExceptionHandler(AppRuntimeException e) {
        return buildErrorResult(e.getCode(), e.getMessage(), e);
    }

    /**
     * <p>
     * 未知异常
     * </p>
     */
    @ResponseStatus(HttpStatus.OK)
    @ExceptionHandler(value = Exception.class)
    public HttpResult<Object> exceptionHandler(Exception e) {
        return buildErrorResult(BaseResponseEnum.SERVICE_ERROR.getCode(), BaseResponseEnum.SERVICE_ERROR.getMessage(), e);
    }

    /**
     * <p>
     * 构造错误结果
     * </p>
     */
    private HttpResult<Object> buildErrorResult(String code, String message, Exception e) {
        log.error("错误日志: {}", e.getMessage(), e);
        HttpResult<Object> result = new HttpResult<>(code, message, null);
        log.error("返回错误结果: {}", result);
        return result;
    }
}