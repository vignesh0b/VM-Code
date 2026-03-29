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
    public String runCode(@RequestBody String code) {
        return dockerService.runJavaCode(code);
    }
}