package com.ide.controller;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
//@RequestMapping("/api")
@ComponentScan("com.ide")
public class CodeController {

    @GetMapping("/")
    public String test() {
        return "Backend is working ";
    }
}