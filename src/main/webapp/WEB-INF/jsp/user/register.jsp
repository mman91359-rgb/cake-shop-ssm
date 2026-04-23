<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>蛋糕商城 - 注册</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .register-container {
      background: white;
      border-radius: 10px;
      padding: 40px;
      width: 450px;
      box-shadow: 0 10px 40px rgba(0,0,0,0.2);
    }
    .register-container h2 {
      text-align: center;
      margin-bottom: 30px;
      color: #333;
    }
    .form-group {
      margin-bottom: 15px;
    }
    .form-group label {
      display: block;
      margin-bottom: 5px;
      color: #666;
    }
    .form-group input {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 5px;
      font-size: 16px;
    }
    .btn-register {
      width: 100%;
      background: #667eea;
      color: white;
      padding: 12px;
      border: none;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
    }
    .login-link {
      text-align: center;
      margin-top: 20px;
    }
    .message {
      background: #f8d7da;
      color: #721c24;
      padding: 10px;
      border-radius: 5px;
      margin-bottom: 20px;
      text-align: center;
    }
  </style>
</head>
<body>
<div class="register-container">
  <h2>🍰 用户注册</h2>
  <c:if test="${not empty message}">
    <div class="message">${message}</div>
  </c:if>
  <form action="${pageContext.request.contextPath}/user/register" method="post">
    <div class="form-group">
      <label>用户名</label>
      <input type="text" name="username" required>
    </div>
    <div class="form-group">
      <label>密码</label>
      <input type="password" name="password" required>
    </div>
    <div class="form-group">
      <label>昵称</label>
      <input type="text" name="nickname">
    </div>
    <div class="form-group">
      <label>手机号</label>
      <input type="text" name="phone">
    </div>
    <div class="form-group">
      <label>地址</label>
      <input type="text" name="address">
    </div>
    <button type="submit" class="btn-register">注册</button>
  </form>
  <div class="login-link">
    已有账号？ <a href="${pageContext.request.contextPath}/user/login">立即登录</a>
  </div>
</div>
</body>
</html>