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
    public void onMessage(Session session, String message) {

        try {
            // 🔥 FIRST MESSAGE → RUN CODE
            if (message.startsWith("CODE:")) {

                String code = message.substring(5);

                // Save file
                Files.write(Paths.get("Main.java"), code.getBytes());

                ProcessBuilder pb = new ProcessBuilder(
                        "docker", "run", "--rm", "-i",
                        "-v", System.getProperty("user.dir") + ":/app",
                        "-w", "/app",
                        "eclipse-temurin:17",
                        "sh", "-c",
                        "javac Main.java && java Main"
                );

                pb.redirectErrorStream(true);

                process = pb.start();

                // ✅ writer (for input)
                writer = new BufferedWriter(
                        new OutputStreamWriter(process.getOutputStream())
                );

                InputStream is = process.getInputStream();

// 🔥 Read output character-by-character
                new Thread(() -> {
                    try {
                        int ch;
                        while ((ch = is.read()) != -1) {
                            session.getBasicRemote().sendText(String.valueOf((char) ch));
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }).start();
            }

            // 🔥 HANDLE INPUT
            else {
                if (writer != null) {
                    writer.write(message);
                    writer.newLine();   // 🔥 VERY IMPORTANT
                    writer.flush();
                }
            }

        } catch (Exception e) {
            try {
                session.getBasicRemote().sendText("Error: " + e.getMessage());
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        try {
            if (writer != null) writer.close();
            if (process != null) process.destroy();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}