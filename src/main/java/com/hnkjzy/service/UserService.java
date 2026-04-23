package com.hnkjzy.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnkjzy.entity.User;
import java.math.BigDecimal;

public interface UserService extends IService<User> {

    User login(String username, String password);

    boolean register(User user);

    void decreaseBalance(Integer userId, BigDecimal amount);

    void increaseBalance(Integer userId, BigDecimal amount);
}