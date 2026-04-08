package com.ide.controller;
import com.ide.model.User;
import com.ide.service.CodeHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
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
                                           HttpSession session) {

        User user = (User) session.getAttribute("user");

        if (user == null) {
            return ResponseEntity.status(401).body("User not logged in");
        }

        String title = body.get("title");
        String language = body.get("language");
        String code = body.get("code");
        String output = body.getOrDefault("output", "");

        String result = codeHistoryService.saveCode(user, title, language, code, output);

        switch (result) {
            case "LANGUAGE_REQUIRED":
                return ResponseEntity.badRequest().body("language required");
            case "CODE_REQUIRED":
                return ResponseEntity.badRequest().body("code required");
            case "TITLE_REQUIRED":
                return ResponseEntity.badRequest().body("title required");
            default:
                return ResponseEntity.ok("saved");
        }
    }

    @GetMapping("/history")
    public ResponseEntity<?> getHistory(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return ResponseEntity.status(401).body("Not logged in. Please login first.");
        }

        List<CodeHistory> historyList = codeHistoryService.getHistory(user);
        List<Map<String, Object>> response = new ArrayList<>();

        for (CodeHistory history : historyList) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", history.getId());
            map.put("title", history.getTitle());
            map.put("language", history.getLanguage());
            map.put("code", history.getCode());
            map.put("output", history.getOutput());
            map.put("createdAt", history.getCreatedAt() != null ? history.getCreatedAt().toString() : null);
            response.add(map);
        }

        return ResponseEntity.ok(response);
    }
}
