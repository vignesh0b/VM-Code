package com.ide.service.execution;

import java.io.*;

public class JavaExecutor extends DockerExecutor {

    @Override
    public String execute(String code, String input) throws Exception {

        File file = new File("temp/Main.java");
        file.getParentFile().mkdirs();

        FileWriter writer = new FileWriter(file);
        writer.write(code);
        writer.close();

        String command = "javac Main.java && java Main";

        return runInDocker("eclipse-temurin:17", command, input);
    }
}
