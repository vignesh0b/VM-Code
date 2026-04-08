package com.ide.service;

import com.ide.model.CodeHistory;
import com.ide.model.User;
import com.ide.repository.CodeHistoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CodeHistoryService {

    @Autowired
    private CodeHistoryRepository codeHistoryRepository;

    public String saveCode(User user, String title, String language, String code, String output) {

        if (user == null) return "NOT_LOGGED_IN";
        if (language == null || language.isBlank()) return "LANGUAGE_REQUIRED";
        if (code == null || code.isBlank()) return "CODE_REQUIRED";
        if (title == null || title.isBlank()) return "TITLE_REQUIRED";

        CodeHistory history = new CodeHistory();
        history.setUser(user);
        history.setTitle(title);
        history.setLanguage(language);
        history.setCode(code);
        history.setOutput(output);

        codeHistoryRepository.save(history);

        return "SUCCESS";
    }
    public java.util.List<CodeHistory> getHistory(User user) {
        if (user == null) return java.util.Collections.emptyList();
        return codeHistoryRepository.findByUser(user);
    }
}