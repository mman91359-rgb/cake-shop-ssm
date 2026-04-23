<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>确认订单 - 蛋糕商城</title>
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
        .section {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        .section h3 {
            margin-bottom: 15px;
            color: #333;
        }
        .info-row {
            display: flex;
            margin-bottom: 10px;
        }
        .info-label {
            width: 100px;
            color: #666;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        .total-amount {
            font-size: 24px;
            color: #e53e3e;
            font-weight: bold;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .btn-submit {
            background: #667eea;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .message {
            background: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
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
    <h2>📝 确认订单</h2>

    <c:if test="${not empty message}">
        <div class="message">${message}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/order/submit" method="post">
        <div class="section">
            <h3>收货信息</h3>
            <div class="form-group">
                <label>收货人姓名</label>
                <input type="text" name="receiverName" value="${user.nickname}" required>
            </div>
            <div class="form-group">
                <label>收货人电话</label>
                <input type="text" name="receiverPhone" value="${user.phone}" required>
            </div>
            <div class="form-group">
                <label>收货地址</label>
                <input type="text" name="receiverAddress" value="${user.address}" required>
            </div>
            <div class="form-group">
                <label>备注</label>
                <textarea name="remark" rows="3"></textarea>
            </div>
        </div>

        <div class="section">
            <h3>商品清单</h3>
            <table>
                <thead>
                <tr>
                    <th>商品名称</th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${cart}" var="item">
                    <tr>
                        <td>${item.productName}</td>
                        <td>¥<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></td>
                        <td>${item.quantity}</td>
                        <td>¥<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div style="text-align: right; margin-top: 15px;">
                <span>总计：</span>
                <span class="total-amount">¥<fmt:formatNumber value="${total}" pattern="#,##0.00"/></span>
            </div>
        </div>

        <div style="text-align: right;">
            <button type="submit" class="btn-submit">提交订单</button>
        </div>
    </form>
</div>
</body>
</html>