package com.ide.controller;

import com.ide.service.execution.DockerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class ApiController {

    @Autowired
    private DockerService dockerService;

    @PostMapping("/run")
    public String runCode(@RequestBody Map<String, String> data) {
        String code = data.get("code");
        String input = data.get("input");
        return dockerService.runJavaCode(code, input);
    }
}