package ${config.maven.groupId}.${config.maven.artifactId}.web;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableAsync;

<#include "/common/author.ftl">
@EnableAsync
@SpringBootApplication
@ComponentScan(basePackages = {"${config.maven.groupId}.${config.maven.artifactId}.repository", "${config.maven.groupId}.${config.maven.artifactId}.manager", "${config.maven.groupId}.${config.maven.artifactId}.service", "${config.maven.groupId}.${config.maven.artifactId}.web"})
@MapperScan("${config.maven.groupId}.${config.maven.artifactId}.repository")
public class WebMainApp {

    public static void main(String[] args) {
        SpringApplication.run(WebMainApp.class, args);
    }

}