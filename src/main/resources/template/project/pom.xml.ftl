<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <!--基础信息-->
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.6.4</version>
        <relativePath/>
    </parent>
    <groupId>${config.maven.groupId}</groupId>
    <artifactId>${config.maven.artifactId}</artifactId>
    <version>1.0.0-SNAPSHOT</version>
    <packaging>pom</packaging>
    <name>${config.maven.artifactId}</name>

    <!--模块信息-->
    <modules>
        <module>${config.maven.artifactId}-common</module>
        <module>${config.maven.artifactId}-domain</module>
        <module>${config.maven.artifactId}-repository</module>
        <module>${config.maven.artifactId}-manager</module>
        <module>${config.maven.artifactId}-service</module>
        <module>${config.maven.artifactId}-web</module>
    </modules>

    <!--配置信息-->
    <properties>
        <jdk.version>1.8</jdk.version>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <maven.compiler.encoding>UTF-8</maven.compiler.encoding>
        <maven.compiler.source>1.8</maven.compiler.source>
        <maven.compiler.target>1.8</maven.compiler.target>
        <maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>
        <druid-spring-boot-starter.version>1.2.8</druid-spring-boot-starter.version>
        <mybatis-plus.version>3.5.1</mybatis-plus.version>
        <httpclient.version>4.5.6</httpclient.version>
        <trace.version>1.0.0</trace.version>
    </properties>

    <!-- 打包配置信息 -->
    <profiles>
        <profile>
            <!-- 开发环境 -->
            <id>develop</id>
            <properties>
                <activatedProperties>develop</activatedProperties>
            </properties>
            <!-- 默认 -->
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
        </profile>
    </profiles>

    <!--依赖管理信息-->
    <dependencyManagement>
        <dependencies>
            <!--druid-->
            <dependency>
                <groupId>com.alibaba</groupId>
                <artifactId>druid-spring-boot-starter</artifactId>
                <version>${r'${druid-spring-boot-starter.version}'}</version>
            </dependency>
            <!--mybatis plus-->
            <dependency>
                <groupId>com.baomidou</groupId>
                <artifactId>mybatis-plus-boot-starter</artifactId>
                <version>${r'${mybatis-plus.version}'}</version>
            </dependency>
            <dependency>
                <groupId>com.baomidou</groupId>
                <artifactId>mybatis-plus-annotation</artifactId>
                <version>${r'${mybatis-plus.version}'}</version>
            </dependency>
            <dependency>
                <groupId>com.baomidou</groupId>
                <artifactId>mybatis-plus-extension</artifactId>
                <version>${r'${mybatis-plus.version}'}</version>
            </dependency>
            <!--httpclient-->
            <dependency>
                <groupId>org.apache.httpcomponents</groupId>
                <artifactId>httpclient</artifactId>
                <version>${r'${httpclient.version}'}</version>
            </dependency>
            <!--trace log-->
            <dependency>
                <groupId>com.wuyunonline.tracelog</groupId>
                <artifactId>tracelog-spring-boot-starter</artifactId>
                <version>${r'${trace.version}'}</version>
                <exclusions>
                    <exclusion>
                        <groupId>ch.qos.logback</groupId>
                        <artifactId>logback-classic</artifactId>
                    </exclusion>
                </exclusions>
            </dependency>
        </dependencies>
    </dependencyManagement>
</project>