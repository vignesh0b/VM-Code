package com.ide.controller;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@ComponentScan("com.ide")
public class HomeController {
    @GetMapping("/")
    public String home() {
        return "index";
    }
}