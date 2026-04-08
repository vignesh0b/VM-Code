package com.ide.service.execution;

import javax.websocket.Session;
import java.io.*;

public abstract class DockerExecutor {

    private Process process;
    private BufferedWriter writer;

    protected Process startContainer(String fileName, String image, String command) throws Exception {

        ProcessBuilder pb = new ProcessBuilder(
                "docker", "run", "-i", "--rm",
                "--memory=256m",
                "--cpus=1.0",
                "--network=none",
                "-v", new File("temp").getAbsolutePath().replace("\\", "/") + ":/app",
                "-w", "/app",
                image,
                "sh", "-c", command
        );

        pb.redirectErrorStream(true);
        process = pb.start();
        writer = new BufferedWriter(
                new OutputStreamWriter(process.getOutputStream())
        );
        return process;
    }
    protected void streamOutput(Session session) {
        new Thread(() -> {
            try {
                BufferedReader reader = new BufferedReader(
                        new InputStreamReader(process.getInputStream())
                );
                String line;
                while ((line = reader.readLine()) != null) {
                    safeSend(session, line + "\n");
                }
                process.waitFor();
                safeSend(session, "\n[Process Finished]");
            } catch (Exception e) {
                safeSend(session, "Error: " + e.getMessage());
            }
        }).start();
    }

    public void sendInput(String input) {
        try {
            if (writer != null) {
                writer.write(input);
                writer.newLine();
                writer.flush();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void stop() {
        try {
            if (writer != null) writer.close();
        } catch (Exception ignored) {}

        if (process != null && process.isAlive()) {
            process.destroy();
        }
    }

    protected void safeSend(Session session, String msg) {
        try
        {
            session.getBasicRemote().sendText(msg);
        } catch (Exception ignored) {}
    }
}