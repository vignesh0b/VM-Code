package com.ide.controller;

import com.ide.encryption.AESUtil;
import com.ide.encryption.SecureCodeUtil;
import com.ide.model.User;
import com.ide.service.CodeHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.crypto.SecretKey;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.ide.model.CodeHistory;

@RestController
@RequestMapping("/api")
public class CodeHistoryController {

    @Autowired
    private CodeHistoryService codeHistoryService;

    @PostMapping("/save")
    public ResponseEntity<String> saveCode(@RequestBody Map<String, String> body,
                                           HttpSession session) throws Exception {

        User user = (User) session.getAttribute("user");

        String title = body.get("title");
        String language = body.get("language");
        String code = body.get("code");
        String output = body.getOrDefault("output", "");
        String encryptCode = AESUtil.encrypt(code);

        SecretKey key = SecureCodeUtil.getFixedKey();
        String encryptedCode = SecureCodeUtil.encryptAndCompress(code, key);



        String result = codeHistoryService.saveCode(user, title, language, encryptedCode, output);

        switch (result) {
            case "NOT_LOGGED_IN":
                return ResponseEntity.status(401).body("Not logged in. Please login first.");
            case "LANGUAGE_REQUIRED":
                return ResponseEntity.badRequest().body("language is required");
            case "CODE_REQUIRED":
                return ResponseEntity.badRequest().body("code is required");
            case "TITLE_REQUIRED":
                return ResponseEntity.badRequest().body("title is required");
            default:
                return ResponseEntity.ok("Code saved successfully!");
        }
    }

    @GetMapping("/history")
    public ResponseEntity<?> getHistory(HttpSession session) throws Exception {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return ResponseEntity.status(401).body("Not logged in. Please login first.");
        }

        List<CodeHistory> historyList = codeHistoryService.getHistory(user);
        List<Map<String, Object>> response = new ArrayList<>();


        SecretKey key = SecureCodeUtil.getFixedKey();

        for (CodeHistory history : historyList) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", history.getId());
            map.put("title", history.getTitle());
            map.put("language", history.getLanguage());
            String decryptCode = history.getCode();
            try {
                if (decryptCode != null) {
//                    decryptCode = AESUtil.decrypt(decryptCode);
                    decryptCode = SecureCodeUtil.decryptAndDecompress(decryptCode, key);
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
            map.put("code", decryptCode);
            map.put("output", history.getOutput());
            map.put("createdAt", history.getCreatedAt() != null ? history.getCreatedAt().toString() : null); 
            response.add(map);
        }

        return ResponseEntity.ok(response);
    }

}
