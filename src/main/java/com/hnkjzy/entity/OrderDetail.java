package com.hnkjzy.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.util.Date;

@Data
@TableName("order_detail")
public class OrderDetail {

    @TableId(type = IdType.AUTO)
    private Integer id;

    private Integer orderId;
    private String receiverName;
    private String receiverPhone;
    private String receiverAddress;
    private Date deliveryTime;
    private String remark;

    @TableField(fill = FieldFill.INSERT)
    private Date createdTime;
}