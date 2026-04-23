package com.hnkjzy.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnkjzy.entity.Order;
import com.hnkjzy.entity.OrderDetail;
import com.hnkjzy.mapper.OrderMapper;
import com.hnkjzy.service.OrderDetailService;
import com.hnkjzy.service.OrderService;
import com.hnkjzy.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Service
public class OrderServiceImpl extends ServiceImpl<OrderMapper, Order> implements OrderService {

    @Autowired
    private UserService userService;

    @Autowired
    private OrderDetailService orderDetailService;

    @Override
    @Transactional
    public void createOrder(Order order) {
        String orderNo = "ORD" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS"));
        order.setOrderNo(orderNo);
        order.setStatus(0);
        this.save(order);
        userService.decreaseBalance(order.getUserId(), order.getTotalAmount());
    }

    @Override
    @Transactional
    public void createOrderWithDetail(Order order, OrderDetail orderDetail) {
        // 1. 生成订单号
        String orderNo = "ORD" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS"));
        order.setOrderNo(orderNo);
        order.setStatus(0);

        // 2. 保存订单
        this.save(order);

        // 3. 设置订单详情中的订单ID
        orderDetail.setOrderId(order.getId());

        // 4. 保存订单详情
        orderDetailService.save(orderDetail);

        // 5. 扣减用户余额
        userService.decreaseBalance(order.getUserId(), order.getTotalAmount());
    }
}