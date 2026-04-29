package com.hnkjzy.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.hnkjzy.entity.Product;
import com.hnkjzy.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 商品控制器
 * 支持商品列表（含关键词搜索、排序）和商品详情
 */
@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    /**
     * 商品列表页
     * @param keyword 搜索关键词（可选，匹配名称或描述）
     * @param sort    排序方式：price_asc（默认）/ price_desc / newest
     */
    @GetMapping("/list")
    public String list(@RequestParam(required = false) String keyword,
                       @RequestParam(required = false, defaultValue = "price_asc") String sort,
                       Model model) {

        LambdaQueryWrapper<Product> wrapper = new LambdaQueryWrapper<>();

        // 只显示上架商品
        wrapper.eq(Product::getStatus, 1);

        // 关键词搜索：名称 OR 描述 模糊匹配
        if (keyword != null && !keyword.trim().isEmpty()) {
            wrapper.and(w -> w.like(Product::getName, keyword.trim())
                              .or()
                              .like(Product::getDescription, keyword.trim()));
        }

        // 排序
        switch (sort) {
            case "price_desc":
                wrapper.orderByDesc(Product::getPrice);
                break;
            case "newest":
                wrapper.orderByDesc(Product::getCreatedTime);
                break;
            default: // price_asc
                wrapper.orderByAsc(Product::getPrice);
        }

        List<Product> productList = productService.list(wrapper);
        model.addAttribute("productList", productList);
        return "product/list";
    }

    /**
     * 商品详情页
     * @param id 商品ID
     */
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Integer id, Model model) {
        Product product = productService.getById(id);
        model.addAttribute("product", product);
        return "product/detail";
    }
}
