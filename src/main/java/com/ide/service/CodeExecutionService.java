package com.ide.service;

import com.ide.service.execution.*;

import org.springframework.stereotype.Service;

@Service
public class CodeExecutionService {

    public String execute(String language, String code, String input) {

        try {
            CodeExecutor executor;

            switch (language.toLowerCase()) {
                case "java":
                    executor = new JavaExecutor();
                    break;
                case "python":
                    executor = new PythonExecutor();
                    break;
                case "c":
                    executor = new CExecutor();
                    break;
                default:
                    return "Unsupported language";
            }

            return executor.execute(code, input);

        } catch (Exception e) {
            return "ERROR:\n" + e.getMessage();
        }
    }
}
