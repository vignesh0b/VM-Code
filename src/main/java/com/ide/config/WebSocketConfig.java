package com.ide.config;

import javax.websocket.server.ServerEndpointConfig;
import javax.websocket.server.ServerContainer;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.ide.websocket.CodeSocket;

public class WebSocketConfig implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();

        ServerContainer serverContainer =
                (ServerContainer) context.getAttribute("javax.websocket.server.ServerContainer");

        try {
            serverContainer.addEndpoint(ServerEndpointConfig.Builder
                    .create(CodeSocket.class, "/ws")
                    .build());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {}
}