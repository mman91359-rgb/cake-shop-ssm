<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>蛋糕商城 - 商品列表</title>
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
    }
    .nav a:hover {
      background: rgba(255,255,255,0.2);
    }
    .container {
      max-width: 1200px;
      margin: 30px auto;
      padding: 0 20px;
    }
    .product-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 30px;
    }
    .product-card {
      background: white;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 5px 20px rgba(0,0,0,0.1);
      transition: transform 0.3s;
    }
    .product-card:hover {
      transform: translateY(-5px);
    }
    .product-image {
      width: 100%;
      height: 200px;
      object-fit: cover;
      background: #f0f0f0;
    }
    .product-info {
      padding: 15px;
    }
    .product-name {
      font-size: 18px;
      font-weight: bold;
      margin-bottom: 10px;
      color: #333;
    }
    .product-price {
      font-size: 20px;
      color: #e53e3e;
      font-weight: bold;
      margin-bottom: 10px;
    }
    .product-price span {
      font-size: 14px;
      color: #999;
    }
    .product-desc {
      color: #666;
      font-size: 14px;
      margin-bottom: 15px;
      line-height: 1.4;
    }
    .btn-buy {
      display: inline-block;
      background: #667eea;
      color: white;
      padding: 8px 20px;
      text-decoration: none;
      border-radius: 20px;
      border: none;
      cursor: pointer;
      font-size: 14px;
      transition: background 0.3s;
    }
    .btn-buy:hover {
      background: #5a67d8;
    }
    .cart-form {
      display: flex;
      gap: 10px;
      align-items: center;
    }
    .quantity-input {
      width: 60px;
      padding: 6px;
      border: 1px solid #ddd;
      border-radius: 5px;
      text-align: center;
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
  <h2 style="margin-bottom: 20px;">🍰 精选蛋糕</h2>
  <div class="product-grid">
    <c:forEach items="${productList}" var="product">
      <div class="product-card">
        <img src="${pageContext.request.contextPath}${product.image}"
             alt="${product.name}"
             class="product-image"
             onerror="this.src='${pageContext.request.contextPath}/images/default-cake.jpg'">
        <div class="product-info">
          <div class="product-name">${product.name}</div>
          <div class="product-price">
            ¥<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/>
          </div>
          <div class="product-desc">${product.description}</div>
          <form action="${pageContext.request.contextPath}/cart/add" method="post" class="cart-form">
            <input type="hidden" name="productId" value="${product.id}">
            <input type="number" name="quantity" value="1" min="1" class="quantity-input">
            <button type="submit" class="btn-buy">加入购物车</button>
          </form>
        </div>
      </div>
    </c:forEach>
  </div>
</div>
</body>
</html>