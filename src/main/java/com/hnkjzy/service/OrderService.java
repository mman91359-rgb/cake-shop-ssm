package com.hnkjzy.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnkjzy.entity.Order;
import com.hnkjzy.entity.OrderDetail;

public interface OrderService extends IService<Order> {

    void createOrder(Order order);

    void createOrderWithDetail(Order order, OrderDetail orderDetail);
}