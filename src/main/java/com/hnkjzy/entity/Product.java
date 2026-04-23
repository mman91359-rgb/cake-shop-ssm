package com.hnkjzy.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;

@Data
@TableName("product")
public class Product {

    @TableId(type = IdType.AUTO)
    private Integer id;

    private String name;
    private BigDecimal price;
    private Integer stock;
    private String image;          // 图片路径
    private String description;
    private Integer status;        // 0下架 1上架

    @TableField(fill = FieldFill.INSERT)
    private Date createdTime;
}