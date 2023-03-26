package com.it.shw.helper.init;

import com.it.shw.helper.service.GenerateService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

/**
 * Code生成Main方法
 */
@Slf4j
@Component
public class CodeRunInit implements CommandLineRunner {

    @Autowired
    private GenerateService generateService;

    @Override
    public void run(String... args) throws Exception {
        log.info("===============code start==============");
        generateService.generateCode();
        log.info("===============code end==============");
    }
}