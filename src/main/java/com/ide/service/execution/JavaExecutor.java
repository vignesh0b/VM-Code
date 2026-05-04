package com.ide.service.execution;

import javax.websocket.Session;

import java.io.*;

public class JavaExecutor extends DockerExecutor implements CodeExecutor {

    @Override
    public void execute(String code, Session session) throws Exception {

        String fileName = "Main.java";

        File file = new File("temp/" + fileName);
        file.getParentFile().mkdirs();

        try (FileWriter fw = new FileWriter(file)) {
            fw.write(code);
        }

        Process process = startContainer(
                fileName,
                "eclipse-temurin:17",
                "javac Main.java && java Main"
        );

        streamOutput(session);
    }
}