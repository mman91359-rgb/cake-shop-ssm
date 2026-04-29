package com.hnkjzy.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.hnkjzy.entity.Order;
import com.hnkjzy.entity.User;
import com.hnkjzy.service.OrderService;
import com.hnkjzy.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 用户控制器
 * 包含登录、注册、个人中心、我的订单、退出
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private OrderService orderService;

    /** 登录页 */
    @GetMapping("/login")
    public String loginPage() {
        return "user/login";
    }

    /** 登录处理 */
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
            model.addAttribute("message", "用户名或密码错误，请重试");
            return "user/login";
        }
    }

    /** 注册页 */
    @GetMapping("/register")
    public String registerPage() {
        return "user/register";
    }

    /** 注册处理 */
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

    /** 个人中心 */
    @GetMapping("/center")
    public String center(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        // 从数据库刷新，确保余额最新
        User user = userService.getById(loginUser.getId());
        model.addAttribute("user", user);
        return "user/center";
    }

    /**
     * 我的订单列表
     * @param status 订单状态筛选（可选）：0待支付 1已支付 2已发货 3已完成 4已取消
     */
    @GetMapping("/orders")
    public String myOrders(@RequestParam(required = false) Integer status,
                           HttpSession session,
                           Model model) {
        User loginUser = (User) session.getAttribute("loginUser");

        LambdaQueryWrapper<Order> wrapper = new LambdaQueryWrapper<>();
        // 只查当前登录用户的订单
        wrapper.eq(Order::getUserId, loginUser.getId());
        // 状态筛选
        if (status != null) {
            wrapper.eq(Order::getStatus, status);
        }
        // 最新的订单排在前面
        wrapper.orderByDesc(Order::getCreatedTime);

        List<Order> orderList = orderService.list(wrapper);
        model.addAttribute("orderList", orderList);
        return "user/orders";
    }

    /** 退出登录 */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("loginUser");
        return "redirect:/user/login";
    }
}
