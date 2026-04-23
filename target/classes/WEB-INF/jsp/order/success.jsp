<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>下单成功 - 蛋糕商城</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: #f5f5f5;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .success-container {
      background: white;
      border-radius: 10px;
      padding: 50px;
      text-align: center;
      box-shadow: 0 10px 40px rgba(0,0,0,0.1);
      max-width: 500px;
    }
    .success-icon {
      font-size: 64px;
      margin-bottom: 20px;
    }
    h2 {
      color: #28a745;
      margin-bottom: 20px;
    }
    .order-info {
      background: #f8f9fa;
      padding: 20px;
      border-radius: 5px;
      margin: 20px 0;
    }
    .btn {
      display: inline-block;
      background: #667eea;
      color: white;
      padding: 10px 20px;
      text-decoration: none;
      border-radius: 5px;
      margin: 5px;
    }
    .btn-outline {
      background: white;
      color: #667eea;
      border: 1px solid #667eea;
    }
  </style>
</head>
<body>
<div class="success-container">
  <div class="success-icon">🎉</div>
  <h2>下单成功！</h2>
  <p>感谢您的购买，订单已提交</p>
  <div class="order-info">
    <p>订单号：${order.orderNo}</p>
    <p>订单金额：¥<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></p>
  </div>
  <div>
    <a href="${pageContext.request.contextPath}/product/list" class="btn">继续购物</a>
    <a href="${pageContext.request.contextPath}/user/center" class="btn btn-outline">查看订单</a>
  </div>
</div>
</body>
</html>