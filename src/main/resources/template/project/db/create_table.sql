USE code_helper;

-- 0、应用访问日志记录表
DROP TABLE IF EXISTS `app_access_log`;

CREATE TABLE `app_access_log` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
    `app` VARCHAR(63) NOT NULL COMMENT '应用服务',
    `module` VARCHAR(63) DEFAULT NULL COMMENT '功能模块',
    `operation_type` VARCHAR(63) DEFAULT NULL COMMENT '操作类型',
    `description` VARCHAR(255) DEFAULT NULL COMMENT '操作描述',
    `request_param` TEXT DEFAULT NULL COMMENT '请求参数',
    `return_result` TEXT DEFAULT NULL COMMENT '返回结果',
    `flag` TINYINT NOT NULL DEFAULT '1' COMMENT '是否异常 0：异常 1：正常',
    `trace_id` VARCHAR(50) DEFAULT NULL COMMENT '日志追踪traceId',
    `exception_name` VARCHAR(255) DEFAULT NULL COMMENT '异常名称',
    `exception_message` TEXT DEFAULT NULL COMMENT '异常信息',
    `operation_user` VARCHAR(63) NOT NULL COMMENT '操作人员',
    `method` VARCHAR(255) NOT NULL COMMENT '方法',
    `uri` VARCHAR(255) NOT NULL COMMENT '请求URI',
    `ip` VARCHAR(63) NOT NULL COMMENT '请求IP',
    `enable` TINYINT NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效 1:有效)',
    `deleted` DATETIME(3) NOT NULL DEFAULT '1970-01-01 08:00:01' COMMENT '是否删除',
    `create_time` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP (3) COMMENT '创建时间',
    `create_user` VARCHAR(63) DEFAULT NULL COMMENT '创建人',
    `modify_time` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP (3) ON UPDATE CURRENT_TIMESTAMP (3) COMMENT '最近修改时间',
    `modify_user` VARCHAR(63) DEFAULT NULL COMMENT '最近修改人',
    PRIMARY KEY (`id`)
)  ENGINE=INNODB AUTO_INCREMENT=1 CHARSET=UTF8MB4 COMMENT '应用访问日志记录表';