<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>购物车 - 蛋糕商城</title>
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
      border-radius: 10px;
      padding: 30px;
      box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    }
    table {
      width: 100%;
      border-collapse: collapse;
    }
    th, td {
      padding: 15px;
      text-align: left;
      border-bottom: 1px solid #eee;
    }
    th {
      background: #f8f9fa;
    }
    .quantity-input {
      width: 60px;
      padding: 5px;
      text-align: center;
    }
    .btn-update, .btn-remove {
      padding: 5px 10px;
      border: none;
      border-radius: 3px;
      cursor: pointer;
    }
    .btn-update {
      background: #28a745;
      color: white;
    }
    .btn-remove {
      background: #dc3545;
      color: white;
    }
    .total-row {
      font-weight: bold;
      background: #f8f9fa;
    }
    .total-amount {
      color: #e53e3e;
      font-size: 20px;
    }
    .btn-checkout {
      display: inline-block;
      background: #667eea;
      color: white;
      padding: 12px 30px;
      text-decoration: none;
      border-radius: 5px;
      margin-top: 20px;
    }
    .empty-cart {
      text-align: center;
      padding: 50px;
      color: #666;
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
  <h2>🛒 购物车</h2>

  <c:choose>
    <c:when test="${empty cart}">
      <div class="empty-cart">
        <p>购物车还是空的</p>
        <a href="${pageContext.request.contextPath}/product/list" class="btn-checkout">去逛逛</a>
      </div>
    </c:when>
    <c:otherwise>
      <table>
        <thead>
        <tr>
          <th>商品名称</th>
          <th>单价</th>
          <th>数量</th>
          <th>小计</th>
          <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${cart}" var="item">
          <tr>
            <td>${item.productName}</td>
            <td>¥<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></td>
            <td>
              <form action="${pageContext.request.contextPath}/cart/update" method="post" style="display: flex; gap: 5px;">
                <input type="hidden" name="productId" value="${item.productId}">
                <input type="number" name="quantity" value="${item.quantity}" min="1" class="quantity-input">
                <button type="submit" class="btn-update">更新</button>
              </form>
            </td>
            <td>¥<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></td>
            <td>
              <form action="${pageContext.request.contextPath}/cart/remove" method="post">
                <input type="hidden" name="productId" value="${item.productId}">
                <button type="submit" class="btn-remove">删除</button>
              </form>
            </td>
          </tr>
        </c:forEach>
        <tr class="total-row">
          <td colspan="3" style="text-align: right;">总计：</td>
          <td colspan="2" class="total-amount">¥<fmt:formatNumber value="${total}" pattern="#,##0.00"/></td>
        </tr>
        </tbody>
      </table>
      <div style="text-align: right;">
        <a href="${pageContext.request.contextPath}/order/confirm" class="btn-checkout">去结算</a>
      </div>
    </c:otherwise>
  </c:choose>
</div>
</body>
</html>