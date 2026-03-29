package com.ide.service.execution;

import java.io.*;

public class PythonExecutor extends DockerExecutor {

    @Override
    public String execute(String code, String input) throws Exception {

        File file = new File("temp/script.py");
        file.getParentFile().mkdirs();

        FileWriter writer = new FileWriter(file);
        writer.write(code);
        writer.close();

        String command = "python script.py";

        return runInDocker("python:3.10", command, input);
    }
}
