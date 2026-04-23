package com.hnkjzy.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;

@Data
@TableName("`order`")
public class Order {

    @TableId(type = IdType.AUTO)
    private Integer id;

    private String orderNo;
    private Integer userId;
    private BigDecimal totalAmount;
    private Integer status;        // 0待支付 1已支付 2已发货 3已完成 4已取消

    @TableField(fill = FieldFill.INSERT)
    private Date createdTime;

    @TableField(exist = false)
    private User user;
}