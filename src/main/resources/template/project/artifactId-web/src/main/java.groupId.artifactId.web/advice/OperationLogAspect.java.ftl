package ${config.maven.groupId}.${config.maven.artifactId}.web.advice;

import ${config.maven.groupId}.${config.maven.artifactId}.common.annotation.OperationLog;
import ${config.maven.groupId}.${config.maven.artifactId}.common.constant.SystemConstant;
import ${config.maven.groupId}.${config.maven.artifactId}.common.enumeration.EnableEnum;
import ${config.maven.groupId}.${config.maven.artifactId}.common.utils.JsonUtil;
import ${config.maven.groupId}.${config.maven.artifactId}.common.utils.LoginUtil;
import ${config.maven.groupId}.${config.maven.artifactId}.domain.po.AppAccessLog;
import ${config.maven.groupId}.${config.maven.artifactId}.repository.mapper.AppAccessLogMapper;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.multipart.MultipartFile;

/**
 * 应用日志记录切面
 */
@Slf4j
@Aspect
@Component
@ConditionalOnProperty(value = "log.enabled", havingValue = "true")
public class OperationLogAspect {

    @Autowired
    private AppAccessLogMapper appAccessLogMapper;

    @Pointcut("@annotation(${config.maven.groupId}.${config.maven.artifactId}.common.annotation.OperationLog)")
    public void operationAccessLogPointCut() {
    }

    @Pointcut("execution(* ${config.maven.groupId}.${config.maven.artifactId}.web.controller..*.*(..))")
    public void operationExceptionLogPointCut() {
    }

    /**
     * 应用访问日志
     */
    @AfterReturning(value = "operationAccessLogPointCut()", returning = "keys")
    public void saveOperationAccessLog(JoinPoint joinPoint, Object keys) {
        try {
            // 获取方法注解信息
            MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();
            Method method = methodSignature.getMethod();
            OperationLog operationLog = method.getAnnotation(OperationLog.class);
            if (operationLog == null) {
                return;
            }
            AppAccessLog appAccessLog = new AppAccessLog();
            appAccessLog.setModule(operationLog.module().getValue());
            appAccessLog.setOperationType(operationLog.type().getValue());
            appAccessLog.setDescription(operationLog.description());
            // 获取request
            RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
            assert requestAttributes != null;
            HttpServletRequest request = (HttpServletRequest) requestAttributes.resolveReference(RequestAttributes.REFERENCE_REQUEST);
            assert request != null;
            // 获取方法名信息
            String className = joinPoint.getTarget().getClass().getName();
            appAccessLog.setMethod(className + "." + method.getName());
            // 获取请求参数，过滤HttpServletRequest和HttpServletResponse类型的参数
            Object[] args = joinPoint.getArgs();
            if (args != null && args.length > 0) {
                List<Object> argList = Arrays.stream(args)
                        .filter(arg -> (!(arg instanceof HttpServletRequest) && !(arg instanceof HttpServletResponse) && !(arg instanceof MultipartFile) && !(arg instanceof MultipartFile[])))
                        .collect(Collectors.toList());
                appAccessLog.setRequestParam(JsonUtil.writeValueAsString(argList));
            }
            // 获取其他
            appAccessLog.setApp(SystemConstant.APP_NAME);
            appAccessLog.setReturnResult(JsonUtil.writeValueAsString(keys));
            appAccessLog.setOperationUser(LoginUtil.getUserName());
            appAccessLog.setUri(request.getRequestURI());
            appAccessLog.setIp(IpUtil.getIpAddress(request));
            appAccessLog.setFlag(EnableEnum.ENABLE.getValue());
            appAccessLog.setTraceId(MDC.get(SystemConstant.TRACE_ID));
            appAccessLogMapper.insert(appAccessLog);
        } catch (Exception e) {
            log.error("Aop record operation access log occur exception.", e);
        }
    }

    /**
     * 应用异常日志
     */
    @AfterThrowing(pointcut = "operationExceptionLogPointCut()", throwing = "e")
    public void saveOperationExceptionLog(JoinPoint joinPoint, Throwable e) {
        try {
            AppAccessLog appAccessLog = new AppAccessLog();
            // 获取request
            RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
            assert requestAttributes != null;
            HttpServletRequest request = (HttpServletRequest) requestAttributes.resolveReference(RequestAttributes.REFERENCE_REQUEST);
            assert request != null;
            // 获取方法注解信息
            MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();
            Method method = methodSignature.getMethod();
            OperationLog operationLog = method.getAnnotation(OperationLog.class);
            if (operationLog != null) {
                appAccessLog.setModule(operationLog.module().getValue());
                appAccessLog.setOperationType(operationLog.type().getValue());
                appAccessLog.setDescription(operationLog.description());
            }
            // 获取方法名信息
            String className = joinPoint.getTarget().getClass().getName();
            appAccessLog.setMethod(className + "." + method.getName());
            // 获取请求参数，过滤HttpServletRequest和HttpServletResponse类型的参数
            Object[] args = joinPoint.getArgs();
            if (args != null && args.length > 0) {
                List<Object> argList = Arrays.stream(args)
                        .filter(arg -> (!(arg instanceof HttpServletRequest) && !(arg instanceof HttpServletResponse) && !(arg instanceof MultipartFile)))
                        .collect(Collectors.toList());
                appAccessLog.setRequestParam(JsonUtil.writeValueAsString(argList));
            }
            // 获取异常信息
            appAccessLog.setExceptionName(e.getClass().getName());
            appAccessLog.setExceptionMessage(convertException(e));
            // 获取其他
            appAccessLog.setApp(SystemConstant.APP_NAME);
            appAccessLog.setOperationUser(LoginUtil.getUserName());
            appAccessLog.setUri(request.getRequestURI());
            appAccessLog.setIp(IpUtil.getIpAddress(request));
            appAccessLog.setFlag(EnableEnum.DISABLE.getValue());
            appAccessLog.setTraceId(MDC.get(SystemConstant.TRACE_ID));
            appAccessLogMapper.insert(appAccessLog);
        } catch (Exception ex) {
            log.error("Aop record operation exception log occur exception.", ex);
        }
    }

    /**
     * 异常堆栈信息转换
     */
    private String convertException(Throwable e) {
        StringBuilder sb = new StringBuilder();
        for (StackTraceElement ste : e.getStackTrace()) {
            sb.append(ste).append("\n");
        }
        return e.getClass().getName() + ":" + e.getMessage() + "\n" + sb;
    }
}