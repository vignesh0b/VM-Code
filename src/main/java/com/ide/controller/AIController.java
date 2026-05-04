package com.ide.controller;

import com.ide.service.GeminiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/ai")
public class AIController {

    private final GeminiService geminiService;

    @Autowired
    public AIController(GeminiService geminiService) {
        this.geminiService = geminiService;
    }

    @PostMapping(value = "/explain")
    public ResponseEntity<String> explain(@RequestBody String code) {
        return ResponseEntity.ok(geminiService.explainCode(code));
    }

    @PostMapping(value = "/debug")
    public ResponseEntity<String> debug(@RequestBody String code) {
        return ResponseEntity.ok(geminiService.debugCode(code));
    }

    @PostMapping(value = "/prompt", consumes = "application/json")
    public ResponseEntity<String> customPrompt(@RequestBody java.util.Map<String, String> payload) {
        String code = payload.get("code");
        String prompt = payload.get("prompt");
        return ResponseEntity.ok(geminiService.customPrompt(code, prompt));
    }
}
