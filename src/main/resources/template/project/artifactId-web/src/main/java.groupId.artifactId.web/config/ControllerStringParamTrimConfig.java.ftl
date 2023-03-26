package ${config.maven.groupId}.${config.maven.artifactId}.web.config;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.deser.std.StdScalarDeserializer;
import java.io.IOException;
import org.springframework.boot.autoconfigure.jackson.Jackson2ObjectMapperBuilderCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;
import org.springframework.util.StringUtils;

/**
 * 去除字符串空格
 */
@Configuration
public class ControllerStringParamTrimConfig {

    @Bean
    public Jackson2ObjectMapperBuilderCustomizer jackson2ObjectMapperBuilderCustomizer() {
        return new Jackson2ObjectMapperBuilderCustomizer() {
            @Override
            public void customize(Jackson2ObjectMapperBuilder jacksonObjectMapperBuilder) {
                jacksonObjectMapperBuilder.deserializerByType(String.class, new StdScalarDeserializer<String>(String.class) {
                    private static final long serialVersionUID = 1L;

                    @Override
                    public String deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException {
                        return StringUtils.trimWhitespace(jsonParser.getValueAsString());
                    }
                });
            }
        };
    }
}