package com.hnkjzy.entity;

import lombok.Data;
import java.math.BigDecimal;

@Data
public class CartItem {
    private Integer productId;
    private String productName;
    private BigDecimal price;
    private Integer quantity;
    private BigDecimal subtotal;  // 小计 = price * quantity
}