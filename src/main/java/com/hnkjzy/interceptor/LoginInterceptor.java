package com.hnkjzy.interceptor;

import com.hnkjzy.entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler) throws Exception {

        // 获取请求路径
        String uri = request.getRequestURI();

        // ========== 放行不需要登录的请求 ==========
        // 1. 登录和注册页面
        if (uri.contains("/user/login") || uri.contains("/user/register")) {
            return true;
        }

        // 2. 商品相关（游客可以查看商品）
        if (uri.contains("/product/list") || uri.contains("/product/detail")) {
            return true;
        }

        // 3. 静态资源（图片、CSS、JS）
        if (uri.contains("/images/") || uri.contains("/css/") ||
                uri.contains("/js/") || uri.contains("/uploads/")) {
            return true;
        }

        // ========== 需要登录的请求 ==========
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser == null) {
            // 未登录，跳转到登录页
            response.sendRedirect(request.getContextPath() + "/user/login");
            return false;
        }

        return true;
    }
}