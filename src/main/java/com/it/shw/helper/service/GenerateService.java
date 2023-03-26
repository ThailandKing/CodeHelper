package com.it.shw.helper.service;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.io.resource.ResourceUtil;
import com.it.shw.helper.config.CodeConfig;
import com.it.shw.helper.domain.bo.DBMetaInfo;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Slf4j
@Service
public class GenerateService {

    // template目录位置
    private static final String TEMPLATE_PATH = "template";
    // freemarker模板文件后缀
    private static final String FILE_SUFFIX = ".ftl";
    // ClassName模板文件前缀
    private static final String DB_FILE_PREFIX = "ClassName";
    // 项目目录
    private static final String PROJECT_PTAH = "\\project";

    @Autowired
    private CodeConfig codeConfig;

    @Autowired
    private Configuration configuration;

    @Autowired
    private DBService dbService;

    /**
     * 1、生成code入口方法
     */
    public void generateCode() {
        String templateDir = ResourceUtil.getResource(TEMPLATE_PATH).getPath();
        File dirFile = new File(templateDir);
        generateDir(dirFile);
    }

    /**
     * 1.1、生成目录
     */
    private void generateDir(File dirFile) {
        // 生成文件
        if (dirFile.isFile()) {
            generateFile(dirFile);
            return;
        }
        File[] childFileList = dirFile.listFiles();
        // 空目录判断
        if (childFileList == null || childFileList.length == 0) {
            log.info("================Skip empty file folder.==================");
            return;
        }
        // 递归目录
        for (File file : childFileList) {
            generateDir(file);
        }
    }

    /**
     * 1.2、生成文件
     */
    private void generateFile(File dirFile) {
        String fileName = dirFile.getName();
        // 跳过白名单文件
        if (codeConfig.getProject().getWhiteList().contains(fileName)) {
            return;
        }
        // 非freemarker模板文件，直接复制文件到目标路径
        if (!StringUtils.endsWithIgnoreCase(fileName, FILE_SUFFIX)) {
            copyNoTemplateFile(dirFile);
            return;
        }
        // 非涉及数据库表文件
        if (!StringUtils.startsWithIgnoreCase(fileName, DB_FILE_PREFIX)) {
            writeNoTableFile(dirFile);
            return;
        }
        // 涉及数据库表文件
        writeTableFile(dirFile);
    }

    /**
     * 1.3、拷贝非模板文件
     */
    private void copyNoTemplateFile(File dirFile) {
        String absolutePath = dirFile.getAbsolutePath();
        String outFilePath = getOutFilePath(absolutePath, null);
        if (hasWrite(outFilePath)) {
            return;
        }
        File desFile = new File(outFilePath);
        FileUtil.copyFile(dirFile, desFile);
    }

    /**
     * 1.4、写非涉及数据库表文件
     */
    private void writeNoTableFile(File dirFile) {
        String absolutePath = dirFile.getAbsolutePath();
        String outFilePath = getOutFilePath(absolutePath, null);
        if (hasWrite(outFilePath)) {
            return;
        }
        try {
            Map<String, Object> rootMap = new HashMap<>();
            rootMap.put("config", codeConfig);
            FileUtil.mkParentDirs(outFilePath);
            Writer out = new FileWriter(outFilePath);
            Template template = configuration.getTemplate(getTemplatePath(absolutePath));
            template.process(rootMap, out);
            template.setAutoFlush(true);
        } catch (IOException | TemplateException e) {
            log.error("============Freemarker生成模板文件错误.============", e);
        }
    }

    /**
     * 1.5、写涉及数据库表文件
     */
    private void writeTableFile(File dirFile) {
        List<DBMetaInfo> dbMetaInfoList = dbService.getDBMetaInfo();
        for (DBMetaInfo dbMetaInfo : dbMetaInfoList) {
            String absolutePath = dirFile.getAbsolutePath();
            String outFilePath = getOutFilePath(absolutePath, dbMetaInfo.getDbTable());
            if (hasWrite(outFilePath)) {
                return;
            }
            try {
                Map<String, Object> rootMap = new HashMap<>();
                rootMap.put("config", codeConfig);
                rootMap.put("data", dbMetaInfo);
                FileUtil.mkParentDirs(outFilePath);
                Writer out = new FileWriter(outFilePath);
                Template template = configuration.getTemplate(getTemplatePath(absolutePath));
                template.process(rootMap, out);
                template.setAutoFlush(true);
            } catch (IOException | TemplateException e) {
                log.error("============Freemarker生成模板文件错误.============", e);
            }
        }
    }

    /**
     * 1.6、获取模板文件位置（相对于freemarker template-loader-path）
     */
    private String getTemplatePath(String absolutePath) {
        int index = absolutePath.indexOf(TEMPLATE_PATH);
        return absolutePath.substring(index + TEMPLATE_PATH.length() + 1);
    }

    /**
     * 1.7、获取文件输出位置
     */
    private String getOutFilePath(String absolutePath, String className) {
        // 移除文件模板后缀
        String removeSuffix = StringUtils.replace(absolutePath, FILE_SUFFIX, "");
        // 替换groupId、artifactId
        String removeGroupId = StringUtils.replace(removeSuffix, "groupId", codeConfig.getMaven().getGroupId());
        String removeArtifactId = StringUtils.replace(removeGroupId, "artifactId", codeConfig.getMaven().getArtifactId());
        // 替换className
        String removeClassName = StringUtils.replace(removeArtifactId, DB_FILE_PREFIX, StringUtils.hasText(className) ? className : "");
        // 替换父目录
        int index = removeClassName.indexOf(TEMPLATE_PATH + PROJECT_PTAH);
        String allPath = codeConfig.getProject().getDesFolder() + removeClassName.substring(index + (TEMPLATE_PATH + PROJECT_PTAH).length());
        // 替换.->\
        // 替换\->\\
        int pos = allPath.lastIndexOf("\\");
        String temp = StringUtils.replace(allPath.substring(0, pos), ".", "\\") + "\\" + allPath.substring(pos);
        return StringUtils.replace(temp, "\\", "\\\\");
    }

    /**
     * 1.8、判断文件是否存在
     */
    private boolean hasWrite(String outFilePath) {
        File file = new File(outFilePath);
        return file.exists();
    }
}