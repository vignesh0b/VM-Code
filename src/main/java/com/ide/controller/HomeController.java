package com.ide.controller;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class HomeController {
    @GetMapping("/")
    public String home(HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        return "home";
    }
    @GetMapping("/ide")
    public String ide(@RequestParam(value = "lang", required = false, defaultValue = "java") String lang,
                      Model model) {

        model.addAttribute("lang", lang);
        return "index";
    }
}