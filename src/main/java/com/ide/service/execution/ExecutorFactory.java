package com.ide.service.execution;

public class ExecutorFactory {

    public static CodeExecutor getExecutor(String language) {

        switch (language.toLowerCase()) {
            case "java":
                return new JavaExecutor();

            case "python":
                return new PythonExecutor();

            case "c":
                return new CExecutor();
                
            case "mysql":
                return new MySQLExecutor();

            default:
                throw new RuntimeException("Unsupported language: " + language);
        }
    }
}