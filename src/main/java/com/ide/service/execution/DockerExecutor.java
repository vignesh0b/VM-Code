package com.ide.service.execution;

import java.io.*;

public abstract class DockerExecutor implements CodeExecutor {

    protected String runInDocker(String image, String command, String input) throws Exception {

        ProcessBuilder pb = new ProcessBuilder(
                "docker", "run", "--rm",
                "--memory=256m",
                "--cpus=1.0",
                "--network=none",
                "-i",   //  IMPORTANT for input
                "-v", new File("temp").getAbsolutePath().replace("\\", "/") + ":/app",
                "-w", "/app",
                image,
                "sh", "-c", command
        );

        Process process = pb.start();

        //  SEND INPUT
        if (input != null && !input.isEmpty()) {
            BufferedWriter writer = new BufferedWriter(
                    new OutputStreamWriter(process.getOutputStream())
            );
            writer.write(input);
            writer.newLine();
            writer.flush();
            writer.close();
        }

        BufferedReader outputReader = new BufferedReader(
                new InputStreamReader(process.getInputStream())
        );

        BufferedReader errorReader = new BufferedReader(
                new InputStreamReader(process.getErrorStream())
        );

        StringBuilder output = new StringBuilder();
        String line;

        while ((line = outputReader.readLine()) != null) {
            output.append(line).append("\n");
        }

        while ((line = errorReader.readLine()) != null) {
            output.append(line).append("\n");
        }

        boolean finished = process.waitFor(5, java.util.concurrent.TimeUnit.SECONDS);

        if (!finished) {
            process.destroy();
            return "Execution Timeout (5s)";
        }

        return output.toString();
    }
}
