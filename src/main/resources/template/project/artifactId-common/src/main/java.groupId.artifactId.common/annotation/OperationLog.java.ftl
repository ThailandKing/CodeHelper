package ${config.maven.groupId}.${config.maven.artifactId}.common.annotation;

import ${config.maven.groupId}.${config.maven.artifactId}.common.enumeration.ActionTypeEnum;
import ${config.maven.groupId}.${config.maven.artifactId}.common.enumeration.SystemModuleEnum;
import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * aop日志注解
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface OperationLog {

    /**
     * <p>
     * 功能模块
     * </p>
     */
    SystemModuleEnum module();

    /**
     * <p>
     * 操作类型
     * </p>
     */
    ActionTypeEnum type();

    /**
     * <p>
     * 操作描述
     * </p>
     */
    String description() default "";
}