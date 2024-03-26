package com.sad.web.config;

import com.sad.web.constant.SystemConstant;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
@Configuration
public class SpringWebMvcConfig implements WebMvcConfigurer {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        /** 本地文件上传路径 */
        registry.addResourceHandler(SystemConstant.RESOURCE_PREFIX + "/**")
                .addResourceLocations("file:" + SystemConstant.PROFILE_PATH + "/");
        WebMvcConfigurer.super.addResourceHandlers(registry);
    }
}
