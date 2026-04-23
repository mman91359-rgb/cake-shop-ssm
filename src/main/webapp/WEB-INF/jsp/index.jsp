<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>蛋糕商城</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
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
        .header h1 {
            font-size: 24px;
        }
        .nav a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            padding: 8px 16px;
            border-radius: 5px;
            transition: background 0.3s;
        }
        .nav a:hover {
            background: rgba(255,255,255,0.2);
        }
        .banner {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            text-align: center;
            padding: 60px 20px;
        }
        .banner h2 {
            font-size: 36px;
            margin-bottom: 20px;
        }
        .banner p {
            font-size: 18px;
        }
        .features {
            display: flex;
            justify-content: center;
            gap: 40px;
            padding: 40px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .feature-card {
            background: white;
            border-radius: 10px;
            padding: 30px;
            text-align: center;
            flex: 1;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .feature-card h3 {
            margin-bottom: 15px;
            color: #333;
        }
        .btn {
            display: inline-block;
            background: #667eea;
            color: white;
            padding: 12px 30px;
            text-decoration: none;
            border-radius: 25px;
            margin-top: 20px;
            transition: background 0.3s;
        }
        .btn:hover {
            background: #5a67d8;
        }
        .footer {
            text-align: center;
            padding: 20px;
            background: #333;
            color: white;
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

<div class="banner">
    <h2>欢迎来到蛋糕商城</h2>
    <p>精选美味蛋糕，甜蜜每一天</p>
    <a href="${pageContext.request.contextPath}/product/list" class="btn">开始选购</a>
</div>

<div class="features">
    <div class="feature-card">
        <h3>🍰 精选蛋糕</h3>
        <p>严选优质食材，匠心制作</p>
    </div>
    <div class="feature-card">
        <h3>🚚 快速配送</h3>
        <p>下单后快速送达，保鲜包装</p>
    </div>
    <div class="feature-card">
        <h3>💳 安全支付</h3>
        <p>多种支付方式，安全便捷</p>
    </div>
</div>

<div class="footer">
    <p>&copy; 2026 蛋糕商城 | 甜蜜每一刻</p>
</div>
</body>
</html>