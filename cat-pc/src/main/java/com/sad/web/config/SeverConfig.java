package com.sad.web.config;

import com.sad.web.utils.ServletUtil;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
@Component
public class SeverConfig {
    public String getUrl()
    {
        HttpServletRequest request = ServletUtil.getRequest();
        return getDomain(request);
    }

    public static String getDomain(HttpServletRequest request)
    {
        StringBuffer url = request.getRequestURL();
        String contextPath = request.getServletContext().getContextPath();
        return url.delete(url.length() - request.getRequestURI().length(), url.length()).append(contextPath).toString();
    }
}
