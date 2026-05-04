package com.ide.service.execution;

import javax.websocket.Session;
import java.io.File;
import java.io.FileWriter;

public class PythonExecutor extends DockerExecutor implements CodeExecutor {

    @Override
    public void execute(String code, Session session) throws Exception {

        String fileName = "main.py";

        File file = new File("temp/" + fileName);
        file.getParentFile().mkdirs();

        try (FileWriter fw = new FileWriter(file)) {
            fw.write(code);
        }

        startContainer(
                fileName,
                "python:3",
                "python -u main.py"
        );

        streamOutput(session);
    }
}