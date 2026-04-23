package com.hnkjzy.controller;

import com.hnkjzy.entity.CartItem;
import com.hnkjzy.entity.Order;
import com.hnkjzy.entity.OrderDetail;
import com.hnkjzy.entity.User;
import com.hnkjzy.service.OrderService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.Map;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    /**
     * 确认订单页
     */
    @GetMapping("/confirm")
    public String confirmPage(HttpSession session, Model model) {
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            return "redirect:/cart/list";
        }

        // 计算总金额
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : cart.values()) {
            total = total.add(item.getSubtotal());
        }

        User loginUser = (User) session.getAttribute("loginUser");
        model.addAttribute("cart", cart.values());
        model.addAttribute("total", total);
        model.addAttribute("user", loginUser);
        return "order/confirm";
    }

    /**
     * 提交订单
     */
    @PostMapping("/submit")
    public String submitOrder(@RequestParam String receiverName,
                              @RequestParam String receiverPhone,
                              @RequestParam String receiverAddress,
                              @RequestParam String remark,
                              HttpSession session,
                              Model model) {
        try {
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            if (cart == null || cart.isEmpty()) {
                return "redirect:/cart/list";
            }

            User loginUser = (User) session.getAttribute("loginUser");

            // 计算总金额
            BigDecimal total = BigDecimal.ZERO;
            for (CartItem item : cart.values()) {
                total = total.add(item.getSubtotal());
            }

            // 创建订单
            Order order = new Order();
            order.setUserId(loginUser.getId());
            order.setTotalAmount(total);

            // 创建订单详情
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setReceiverName(receiverName);
            orderDetail.setReceiverPhone(receiverPhone);
            orderDetail.setReceiverAddress(receiverAddress);
            orderDetail.setRemark(remark);

            orderService.createOrderWithDetail(order, orderDetail);

            // 清空购物车
            session.removeAttribute("cart");

            model.addAttribute("order", order);
            return "order/success";

        } catch (Exception e) {
            model.addAttribute("message", e.getMessage());
            return "order/confirm";
        }
    }
}