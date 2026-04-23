package com.hnkjzy.controller;

import com.hnkjzy.entity.User;
import com.hnkjzy.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String loginPage() {
        return "user/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {
        User user = userService.login(username, password);
        if (user != null) {
            session.setAttribute("loginUser", user);
            return "redirect:/product/list";
        } else {
            model.addAttribute("message", "用户名或密码错误");
            return "user/login";
        }
    }

    @GetMapping("/register")
    public String registerPage() {
        return "user/register";
    }

    @PostMapping("/register")
    public String register(User user, Model model) {
        try {
            userService.register(user);
            return "redirect:/user/login";
        } catch (Exception e) {
            model.addAttribute("message", e.getMessage());
            return "user/register";
        }
    }

    @GetMapping("/center")
    public String center(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        User user = userService.getById(loginUser.getId());
        model.addAttribute("user", user);
        return "user/center";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("loginUser");
        return "redirect:/user/login";
    }
}