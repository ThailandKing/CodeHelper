<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <!--基础信息-->
    <parent>
        <artifactId>${config.maven.artifactId}</artifactId>
        <groupId>${config.maven.groupId}</groupId>
        <version>1.0.0-SNAPSHOT</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>
    <artifactId>${config.maven.artifactId}-manager</artifactId>
    <packaging>jar</packaging>
    <name>${config.maven.artifactId}-manager</name>

    <!--依赖信息-->
    <dependencies>
        <!--repository-->
        <dependency>
            <groupId>${config.maven.groupId}</groupId>
            <artifactId>${config.maven.artifactId}-repository</artifactId>
            <version>${r'${project.parent.version}'}</version>
        </dependency>
    </dependencies>
</project>