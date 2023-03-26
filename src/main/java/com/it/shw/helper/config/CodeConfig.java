package com.it.shw.helper.config;

import java.util.List;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * Code元数据配置
 */
@Configuration
@ConfigurationProperties(prefix = "code")
@Data
public class CodeConfig {
    private DB db;
    private Maven maven;
    private Project project;

    @Data
    public static class DB {
        private String database;
        private List<String> ignoreFiledList;
    }

    @Data
    public static class Maven {
        private String groupId;
        private String artifactId;
    }

    @Data
    public static class Project {
        private String desFolder;
        private String author;
        private List<String> whiteList;
    }
}