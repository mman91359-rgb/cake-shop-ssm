package com.hnkjzy.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnkjzy.entity.User;
import com.hnkjzy.mapper.UserMapper;
import com.hnkjzy.service.UserService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Override
    public User login(String username, String password) {
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getUsername, username)
                .eq(User::getPassword, password);
        return this.getOne(wrapper);
    }

    @Override
    @Transactional
    public boolean register(User user) {
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getUsername, user.getUsername());
        long count = this.count(wrapper);
        if (count > 0) {
            throw new RuntimeException("用户名已存在：" + user.getUsername());
        }
        return this.save(user);
    }

    @Override
    @Transactional
    public void decreaseBalance(Integer userId, BigDecimal amount) {
        User user = this.getById(userId);
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }
        BigDecimal newBalance = user.getBalance().subtract(amount);
        if (newBalance.compareTo(BigDecimal.ZERO) < 0) {
            throw new RuntimeException("余额不足");
        }
        user.setBalance(newBalance);
        this.updateById(user);
    }

    @Override
    @Transactional
    public void increaseBalance(Integer userId, BigDecimal amount) {
        User user = this.getById(userId);
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }
        user.setBalance(user.getBalance().add(amount));
        this.updateById(user);
    }
}