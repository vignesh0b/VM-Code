package com.ide.service.execution;

import javax.websocket.Session;
import java.io.*;

public class CExecutor extends DockerExecutor implements CodeExecutor {

    @Override
    public void execute(String code, Session session) throws Exception {

        String fileName = "main.c";

        File file = new File("temp/" + fileName);
        file.getParentFile().mkdirs();

        try (FileWriter fw = new FileWriter(file)) {
            fw.write(code);
        }

        Process process = startContainer(
                fileName,
                "gcc:latest",
                "gcc main.c -o main && ./main"
        );

        streamOutput(session);
    }
}