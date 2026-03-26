package com.ide.controller;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@ComponentScan("com.ide")
public class CodeController {
    @GetMapping("/")
    public String home() {
        return "index";
    }
}