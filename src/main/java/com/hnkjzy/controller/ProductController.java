package com.hnkjzy.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.hnkjzy.entity.Product;
import com.hnkjzy.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    /**
     * 商品列表页（显示所有上架商品，带蛋糕图片）
     */
    @GetMapping("/list")
    public String list(Model model) {
        LambdaQueryWrapper<Product> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Product::getStatus, 1)
                .orderByAsc(Product::getPrice);
        List<Product> productList = productService.list(wrapper);
        model.addAttribute("productList", productList);
        return "product/list";
    }

    /**
     * 商品详情页
     */
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Integer id, Model model) {
        Product product = productService.getById(id);
        model.addAttribute("product", product);
        return "product/detail";
    }
}