package com.ide.controller;

import com.ide.service.CodeExecutionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class CodeController {

    @Autowired
    private CodeExecutionService service;

    @PostMapping("/run")
    public String runCode(@RequestParam String code,
                          @RequestParam String language,
                          @RequestParam(required = false) String input) {

        return service.execute(language, code, input);
    }
}
