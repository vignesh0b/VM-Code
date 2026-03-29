package com.ide.service.execution;

import org.springframework.stereotype.Service;

import java.io.*;
import java.nio.file.*;

@Service
public class DockerService {

    public String runJavaCode(String code) {
        try {
            Path path = Paths.get("Main.java");
            Files.write(path, code.getBytes());

            ProcessBuilder pb = new ProcessBuilder(
                    "docker", "run", "--rm",
                    "-v", System.getProperty("user.dir") + ":/app",
                    "-w", "/app",
                    "eclipse-temurin:17",
                    "sh", "-c",
                    "javac Main.java && java Main"
            );

            pb.redirectErrorStream(true);
            Process process = pb.start();

            BufferedReader reader = new BufferedReader(
                    new InputStreamReader(process.getInputStream())
            );

            StringBuilder output = new StringBuilder();
            String line;

            while ((line = reader.readLine()) != null) {
                output.append(line).append("\n");
            }

            process.waitFor();

            return output.toString();

        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }
}