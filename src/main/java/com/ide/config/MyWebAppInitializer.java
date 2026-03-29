package com.ide.config;

import com.ide.websocket.CodeSocket;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.websocket.server.ServerContainer;
import javax.websocket.server.ServerEndpointConfig;

public class MyWebAppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

    @Override
    protected Class<?>[] getRootConfigClasses() {
        return null;
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

        ServerContainer container = (ServerContainer)
                servletContext.getAttribute("javax.websocket.server.ServerContainer");

        try {
            container.addEndpoint(ServerEndpointConfig.Builder
                    .create(CodeSocket.class, "/ws")
                    .build());

            System.out.println("🔥 WebSocket registered at /ws");

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}