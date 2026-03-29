package com.ide.service.execution;

import java.io.*;

public class CExecutor extends DockerExecutor {

    @Override
    public String execute(String code, String input) throws Exception {

        File file = new File("temp/main.c");
        file.getParentFile().mkdirs();

        FileWriter writer = new FileWriter(file);
        writer.write(code);
        writer.close();

        String command = "gcc main.c -o main && ./main";

        return runInDocker("gcc:latest", command, input);
    }
}
