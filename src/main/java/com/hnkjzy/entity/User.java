package com.hnkjzy.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Data
@TableName("user")
public class User {

    @TableId(type = IdType.AUTO)
    private Integer id;

    private String username;
    private String password;
    private String nickname;
    private String phone;
    private String address;
    private BigDecimal balance;

    @TableField(fill = FieldFill.INSERT)
    private Date createdTime;

    @TableField(exist = false)
    private List<Order> orders;
}