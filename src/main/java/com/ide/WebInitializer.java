package com.ide;

import com.ide.config.DBConfig;
import com.ide.config.WebConfig;
import com.ide.websocket.CodeSocket;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.websocket.server.ServerContainer;

public class WebInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[]{DBConfig.class};
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[]{WebConfig.class};
    }

    @Override
    protected String[] getServletMappings() {
        return new String[]{"/"};
    }

    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        super.onStartup(servletContext);

        ServerContainer container =
                (ServerContainer) servletContext.getAttribute("javax.websocket.server.ServerContainer");

        try {
            container.addEndpoint(CodeSocket.class);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}