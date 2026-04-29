<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>我的订单 - 蛋糕商城</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }
    :root {
      --primary: #7c5cbf; --primary-dark: #5e3f9e;
      --bg: #f7f3ff; --card-bg: #fff; --text: #2d2d2d; --text-muted: #888;
      --danger: #e53e3e; --success: #38a169; --warn: #dd6b20;
      --shadow: 0 4px 20px rgba(124,92,191,0.12);
      --radius: 14px; --transition: 0.25s cubic-bezier(.4,0,.2,1);
    }
    body { font-family: 'Segoe UI','PingFang SC','Microsoft YaHei',sans-serif; background: var(--bg); color: var(--text); }

    .header {
      background: linear-gradient(135deg, var(--primary) 0%, #9b6dff 100%);
      color: #fff; padding: 0 40px; height: 64px;
      display: flex; align-items: center; justify-content: space-between;
      position: sticky; top: 0; z-index: 100;
      box-shadow: 0 2px 16px rgba(124,92,191,0.25);
    }
    .logo { font-size: 22px; font-weight: 700; }
    .nav { display: flex; gap: 6px; }
    .nav a { color: rgba(255,255,255,0.88); text-decoration: none; padding: 7px 16px; border-radius: 20px; font-size: 14px; transition: var(--transition); }
    .nav a:hover, .nav a.active { background: rgba(255,255,255,0.2); color: #fff; }

    /* 页面主体 */
    .container { max-width: 860px; margin: 32px auto 60px; padding: 0 24px; }

    .page-title {
      font-size: 22px; font-weight: 800; margin-bottom: 20px;
      display: flex; align-items: center; gap: 8px;
    }

    /* 状态筛选标签 */
    .filter-tabs {
      display: flex; gap: 8px; margin-bottom: 20px; flex-wrap: wrap;
    }
    .tab {
      padding: 6px 18px; border-radius: 20px; font-size: 13px;
      border: 1.5px solid #e0d4f7; background: #fff; color: var(--text);
      cursor: pointer; text-decoration: none; transition: var(--transition);
    }
    .tab:hover, .tab.active {
      background: var(--primary); color: #fff; border-color: var(--primary);
    }

    /* 订单卡片 */
    .order-card {
      background: var(--card-bg); border-radius: var(--radius);
      box-shadow: var(--shadow); margin-bottom: 16px; overflow: hidden;
      transition: var(--transition);
    }
    .order-card:hover { box-shadow: 0 8px 32px rgba(124,92,191,0.18); }

    /* 订单头部 */
    .order-head {
      padding: 14px 22px;
      background: #faf8ff;
      border-bottom: 1px solid #f0eaff;
      display: flex; align-items: center; justify-content: space-between;
      flex-wrap: wrap; gap: 8px;
    }
    .order-no { font-size: 13px; color: var(--text-muted); }
    .order-no em { color: var(--text); font-style: normal; font-weight: 600; letter-spacing: .5px; }
    .order-time { font-size: 12px; color: var(--text-muted); }

    /* 状态徽章 */
    .status-badge {
      padding: 4px 12px; border-radius: 12px;
      font-size: 12px; font-weight: 700;
    }
    .status-0 { background: #fffbeb; color: var(--warn); }
    .status-1 { background: #ebf8ff; color: #2b6cb0; }
    .status-2 { background: #f0fff4; color: var(--success); }
    .status-3 { background: #f0fff4; color: var(--success); }
    .status-4 { background: #f7fafc; color: var(--text-muted); }

    /* 订单体 */
    .order-body { padding: 16px 22px; display: flex; align-items: center; justify-content: space-between; gap: 16px; }

    .order-summary { flex: 1; }
    .summary-text { font-size: 14px; color: var(--text-muted); line-height: 1.8; }
    .summary-text span { color: var(--text); font-weight: 600; }

    .order-amount { text-align: right; flex-shrink: 0; }
    .amount-num { font-size: 22px; font-weight: 900; color: var(--danger); }
    .amount-label { font-size: 12px; color: var(--text-muted); margin-bottom: 4px; }

    /* 空状态 */
    .empty-state {
      background: var(--card-bg); border-radius: var(--radius);
      box-shadow: var(--shadow); padding: 80px 40px; text-align: center;
    }
    .empty-icon { font-size: 64px; margin-bottom: 16px; }
    .empty-text { color: var(--text-muted); font-size: 16px; margin-bottom: 24px; }
    .btn-shop {
      display: inline-block;
      background: linear-gradient(135deg, var(--primary), #9b6dff);
      color: #fff; padding: 12px 32px; border-radius: 24px;
      text-decoration: none; font-weight: 700; font-size: 15px;
      transition: var(--transition);
    }
    .btn-shop:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(124,92,191,0.35); }
  </style>
</head>
<body>

<div class="header">
  <div class="logo">🍰 蛋糕商城</div>
  <nav class="nav">
    <a href="${pageContext.request.contextPath}/product/list">商品列表</a>
    <a href="${pageContext.request.contextPath}/cart/list">购物车</a>
    <a href="${pageContext.request.contextPath}/user/orders" class="active">我的订单</a>
    <a href="${pageContext.request.contextPath}/user/center">个人中心</a>
    <a href="${pageContext.request.contextPath}/user/logout">退出</a>
  </nav>
</div>

<div class="container">
  <div class="page-title">📋 我的订单</div>

  <%-- 状态筛选标签 --%>
  <div class="filter-tabs">
    <a href="?status=" class="tab ${empty param.status ? 'active':''}">全部</a>
    <a href="?status=0"  class="tab ${param.status=='0'  ? 'active':''}">⏳ 待支付</a>
    <a href="?status=1"  class="tab ${param.status=='1'  ? 'active':''}">✅ 已支付</a>
    <a href="?status=2"  class="tab ${param.status=='2'  ? 'active':''}">🚚 已发货</a>
    <a href="?status=3"  class="tab ${param.status=='3'  ? 'active':''}">🎉 已完成</a>
    <a href="?status=4"  class="tab ${param.status=='4'  ? 'active':''}">❌ 已取消</a>
  </div>

  <c:choose>
    <c:when test="${empty orderList}">
      <div class="empty-state">
        <div class="empty-icon">📦</div>
        <div class="empty-text">
          <c:choose>
            <c:when test="${not empty param.status}">该状态下暂无订单</c:when>
            <c:otherwise>您还没有下过订单，快去挑选美味蛋糕吧～</c:otherwise>
          </c:choose>
        </div>
        <a href="${pageContext.request.contextPath}/product/list" class="btn-shop">去选购</a>
      </div>
    </c:when>
    <c:otherwise>
      <c:forEach items="${orderList}" var="order">
        <div class="order-card">
          <%-- 订单头 --%>
          <div class="order-head">
            <div>
              <div class="order-no">订单号：<em>${order.orderNo}</em></div>
              <div class="order-time">
                下单时间：<fmt:formatDate value="${order.createdTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
              </div>
            </div>
            <%-- 状态徽章 --%>
            <c:choose>
              <c:when test="${order.status == 0}"><span class="status-badge status-0">⏳ 待支付</span></c:when>
              <c:when test="${order.status == 1}"><span class="status-badge status-1">✅ 已支付</span></c:when>
              <c:when test="${order.status == 2}"><span class="status-badge status-2">🚚 已发货</span></c:when>
              <c:when test="${order.status == 3}"><span class="status-badge status-3">🎉 已完成</span></c:when>
              <c:when test="${order.status == 4}"><span class="status-badge status-4">❌ 已取消</span></c:when>
            </c:choose>
          </div>
          <%-- 订单体 --%>
          <div class="order-body">
            <div class="order-summary">
              <div class="summary-text">
                支付方式：<span>账户余额</span>
              </div>
            </div>
            <div class="order-amount">
              <div class="amount-label">实付金额</div>
              <div class="amount-num">¥<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></div>
            </div>
          </div>
        </div>
      </c:forEach>
    </c:otherwise>
  </c:choose>
</div>

</body>
</html>
