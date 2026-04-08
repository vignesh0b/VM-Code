package com.ide.websocket;
import com.google.gson.Gson;
import com.ide.service.execution.*;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
@ServerEndpoint("/ws")
public class CodeSocket {
    private static final Map<Session, CodeExecutor> executors = new ConcurrentHashMap<>();
    private static final Gson gson = new Gson();

    @OnOpen
    public void onOpen(Session session) {
        System.out.println("Connected: " + session.getId());
    }
    @OnMessage
    public void onMessage(String message, Session session) {
        try {
            if (message.startsWith("{")) {
                Map<String, String> data = gson.fromJson(message, Map.class);
                String code = data.get("code");
                String language = data.get("language");
                CodeExecutor executor = ExecutorFactory.getExecutor(language);
                executors.put(session, executor);
                new Thread(() -> {
                    try {
                        executor.execute(code, session);
                    } catch (Exception e) {
                        try {
                            session.getBasicRemote().sendText("Error: " + e.getMessage());
                        } catch (Exception ignored) {}
                        e.printStackTrace();
                    }
                }).start();
                return;
            }
            CodeExecutor executor = executors.get(session);
            if (executor instanceof DockerExecutor) {
                ((DockerExecutor) executor).sendInput(message);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @OnClose
    public void onClose(Session session) {
        try {
            CodeExecutor executor = executors.remove(session);
            if (executor instanceof DockerExecutor) {
                ((DockerExecutor) executor).stop();
            }
            System.out.println(" Disconnected: " + session.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}