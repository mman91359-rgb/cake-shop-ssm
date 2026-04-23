package com.hnkjzy.controller;

import com.hnkjzy.entity.CartItem;
import com.hnkjzy.entity.Product;
import com.hnkjzy.service.ProductService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private ProductService productService;

    /**
     * 加入购物车
     */
    @PostMapping("/add")
    public String addToCart(@RequestParam Integer productId,
                            @RequestParam Integer quantity,
                            HttpSession session) {
        // 获取购物车（从Session中取）
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }

        // 获取商品信息
        Product product = productService.getById(productId);

        // 创建购物车项
        CartItem item = cart.get(productId);
        if (item == null) {
            item = new CartItem();
            item.setProductId(productId);
            item.setProductName(product.getName());
            item.setPrice(product.getPrice());
            item.setQuantity(quantity);
            item.setSubtotal(product.getPrice().multiply(BigDecimal.valueOf(quantity)));
            cart.put(productId, item);
        } else {
            item.setQuantity(item.getQuantity() + quantity);
            item.setSubtotal(item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
        }

        return "redirect:/cart/list";
    }

    /**
     * 查看购物车
     */
    @GetMapping("/list")
    public String cartList(HttpSession session, Model model) {
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        // 计算总金额
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : cart.values()) {
            total = total.add(item.getSubtotal());
        }

        model.addAttribute("cart", cart.values());
        model.addAttribute("total", total);
        return "cart/cart";
    }

    /**
     * 修改购物车数量
     */
    @PostMapping("/update")
    public String updateQuantity(@RequestParam Integer productId,
                                 @RequestParam Integer quantity,
                                 HttpSession session) {
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart != null && cart.containsKey(productId)) {
            CartItem item = cart.get(productId);
            item.setQuantity(quantity);
            item.setSubtotal(item.getPrice().multiply(BigDecimal.valueOf(quantity)));
        }
        return "redirect:/cart/list";
    }

    /**
     * 删除购物车项
     */
    @PostMapping("/remove")
    public String removeFromCart(@RequestParam Integer productId,
                                 HttpSession session) {
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart != null) {
            cart.remove(productId);
        }
        return "redirect:/cart/list";
    }
}