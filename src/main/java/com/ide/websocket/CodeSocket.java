package com.ide.websocket;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.*;
import java.nio.file.*;

@ServerEndpoint("/ws")
public class CodeSocket {

    private Process process;
    private BufferedWriter writer;

    @OnMessage
    public void onMessage(Session session, String message) throws Exception {

        if (message.startsWith("CODE:")) {

            String code = message.substring(5);
            Files.write(Paths.get("Main.java"), code.getBytes());

            ProcessBuilder pb = new ProcessBuilder(
                    "docker", "run", "--rm", "-i",
                    "-v", System.getProperty("user.dir") + ":/app",
                    "-w", "/app",
                    "eclipse-temurin:17",
                    "sh", "-c",
                    "javac Main.java && java Main"
            );

            process = pb.start();

            writer = new BufferedWriter(
                    new OutputStreamWriter(process.getOutputStream())
            );

            BufferedReader reader = new BufferedReader(
                    new InputStreamReader(process.getInputStream())
            );

            new Thread(() -> {
                try {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        session.getBasicRemote().sendText(line);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }).start();

        } else {
            writer.write(message);
            writer.newLine();
            writer.flush();
        }
    }
}