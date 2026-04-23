<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>个人中心 - 蛋糕商城</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: #f5f5f5;
    }
    .header {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      padding: 15px 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .nav a {
      color: white;
      text-decoration: none;
      margin-left: 20px;
      padding: 8px 16px;
      border-radius: 5px;
    }
    .container {
      max-width: 800px;
      margin: 40px auto;
      background: white;
      border-radius: 10px;
      padding: 30px;
      box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    }
    .user-info {
      border-bottom: 1px solid #eee;
      padding-bottom: 20px;
      margin-bottom: 20px;
    }
    .user-info h3 {
      color: #333;
      margin-bottom: 15px;
    }
    .info-row {
      display: flex;
      margin-bottom: 10px;
    }
    .info-label {
      width: 100px;
      color: #666;
    }
    .info-value {
      color: #333;
    }
    .balance {
      color: #e53e3e;
      font-size: 20px;
      font-weight: bold;
    }
    .btn-back {
      display: inline-block;
      background: #667eea;
      color: white;
      padding: 10px 20px;
      text-decoration: none;
      border-radius: 5px;
    }
  </style>
</head>
<body>
<div class="header">
  <h1>🍰 蛋糕商城</h1>
  <div class="nav">
    <a href="${pageContext.request.contextPath}/product/list">商品列表</a>
    <a href="${pageContext.request.contextPath}/cart/list">购物车</a>
    <a href="${pageContext.request.contextPath}/user/center">个人中心</a>
    <a href="${pageContext.request.contextPath}/user/logout">退出登录</a>
  </div>
</div>

<div class="container">
  <h2>个人中心</h2>
  <div class="user-info">
    <h3>基本信息</h3>
    <div class="info-row">
      <div class="info-label">用户名：</div>
      <div class="info-value">${user.username}</div>
    </div>
    <div class="info-row">
      <div class="info-label">昵称：</div>
      <div class="info-value">${user.nickname}</div>
    </div>
    <div class="info-row">
      <div class="info-label">手机号：</div>
      <div class="info-value">${user.phone}</div>
    </div>
    <div class="info-row">
      <div class="info-label">地址：</div>
      <div class="info-value">${user.address}</div>
    </div>
    <div class="info-row">
      <div class="info-label">余额：</div>
      <div class="info-value balance">¥<fmt:formatNumber value="${user.balance}" pattern="#,##0.00"/></div>
    </div>
  </div>
  <a href="${pageContext.request.contextPath}/product/list" class="btn-back">开始购物</a>
</div>
</body>
</html>