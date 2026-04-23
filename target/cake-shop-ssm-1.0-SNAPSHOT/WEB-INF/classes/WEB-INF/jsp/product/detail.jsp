<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>${product.name} - 蛋糕商城</title>
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
      max-width: 1000px;
      margin: 40px auto;
      background: white;
      border-radius: 15px;
      overflow: hidden;
      box-shadow: 0 10px 40px rgba(0,0,0,0.1);
      display: flex;
    }
    .product-image-section {
      flex: 1;
      padding: 30px;
      background: #fafafa;
      text-align: center;
    }
    .product-image {
      max-width: 100%;
      max-height: 400px;
      border-radius: 10px;
    }
    .product-info-section {
      flex: 1;
      padding: 30px;
    }
    .product-name {
      font-size: 28px;
      font-weight: bold;
      color: #333;
      margin-bottom: 15px;
    }
    .product-price {
      font-size: 32px;
      color: #e53e3e;
      font-weight: bold;
      margin-bottom: 20px;
    }
    .product-stock {
      color: #666;
      margin-bottom: 20px;
      padding-bottom: 20px;
      border-bottom: 1px solid #eee;
    }
    .product-desc {
      color: #666;
      line-height: 1.6;
      margin-bottom: 30px;
    }
    .cart-form {
      display: flex;
      gap: 15px;
      align-items: center;
    }
    .quantity-input {
      width: 80px;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 5px;
      text-align: center;
      font-size: 16px;
    }
    .btn-buy {
      background: #667eea;
      color: white;
      padding: 10px 30px;
      border: none;
      border-radius: 25px;
      cursor: pointer;
      font-size: 16px;
      transition: background 0.3s;
    }
    .btn-buy:hover {
      background: #5a67d8;
    }
    .btn-back {
      display: inline-block;
      margin-top: 20px;
      color: #667eea;
      text-decoration: none;
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
  <div class="product-image-section">
    <img src="${pageContext.request.contextPath}${product.image}"
         alt="${product.name}"
         class="product-image"
         onerror="this.src='${pageContext.request.contextPath}/images/default-cake.jpg'">
  </div>
  <div class="product-info-section">
    <div class="product-name">${product.name}</div>
    <div class="product-price">¥<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></div>
    <div class="product-stock">库存：${product.stock}件</div>
    <div class="product-desc">${product.description}</div>
    <form action="${pageContext.request.contextPath}/cart/add" method="post" class="cart-form">
      <input type="hidden" name="productId" value="${product.id}">
      <input type="number" name="quantity" value="1" min="1" max="${product.stock}" class="quantity-input">
      <button type="submit" class="btn-buy">加入购物车</button>
    </form>
    <a href="${pageContext.request.contextPath}/product/list" class="btn-back">← 返回商品列表</a>
  </div>
</div>
</body>
</html>