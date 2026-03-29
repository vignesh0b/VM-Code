package com.ide.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
public class PageController {
    @GetMapping("/")
    public String index() {
        return "forward:/index.html";
    }
    @GetMapping("/editor")
    public String editor() {
        return "forward:/editor.html";
    }
}