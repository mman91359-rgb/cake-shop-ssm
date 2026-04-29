<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>确认订单 - 蛋糕商城</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }
    :root {
      --primary: #7c5cbf; --primary-dark: #5e3f9e;
      --bg: #f7f3ff; --card-bg: #fff; --text: #2d2d2d; --text-muted: #888;
      --danger: #e53e3e; --success: #38a169;
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
    .nav a:hover { background: rgba(255,255,255,0.2); color: #fff; }

    /* 步骤条 */
    .steps {
      max-width: 700px; margin: 28px auto 0; padding: 0 24px;
      display: flex; align-items: center; gap: 0;
    }
    .step { flex: 1; text-align: center; }
    .step-dot {
      width: 32px; height: 32px; border-radius: 50%;
      background: var(--bg); border: 2px solid #d0bfef;
      display: inline-flex; align-items: center; justify-content: center;
      font-size: 14px; font-weight: 700; color: var(--text-muted);
      transition: var(--transition); position: relative; z-index: 1;
    }
    .step.done .step-dot  { background: var(--success); border-color: var(--success); color: #fff; }
    .step.active .step-dot { background: var(--primary); border-color: var(--primary); color: #fff; }
    .step-label { font-size: 12px; color: var(--text-muted); margin-top: 6px; }
    .step.active .step-label { color: var(--primary); font-weight: 600; }
    .step-line { flex: 1; height: 2px; background: #d0bfef; margin: 0 -1px; position: relative; top: -10px; }
    .step-line.done { background: var(--success); }

    /* 主体两栏 */
    .page-wrap {
      max-width: 900px; margin: 20px auto 60px; padding: 0 24px;
      display: flex; gap: 22px; align-items: flex-start;
    }
    .form-col { flex: 1; display: flex; flex-direction: column; gap: 16px; }
    .aside-col { flex: 0 0 280px; position: sticky; top: 84px; }

    /* 卡片 */
    .card {
      background: var(--card-bg); border-radius: var(--radius);
      box-shadow: var(--shadow); padding: 24px;
    }
    .card-title {
      font-size: 15px; font-weight: 800; margin-bottom: 18px;
      display: flex; align-items: center; gap: 7px;
      padding-bottom: 12px; border-bottom: 1px solid #f0eaff;
    }

    /* 表单 */
    .form-group { margin-bottom: 14px; }
    .form-group label {
      display: block; font-size: 13px; color: var(--text-muted); margin-bottom: 6px; font-weight: 500;
    }
    .form-group input,
    .form-group textarea {
      width: 100%; padding: 10px 14px;
      border: 1.5px solid #e0d4f7; border-radius: 10px;
      font-size: 14px; color: var(--text); outline: none;
      transition: var(--transition); background: #fff;
      font-family: inherit;
    }
    .form-group input:focus,
    .form-group textarea:focus {
      border-color: var(--primary);
      box-shadow: 0 0 0 3px rgba(124,92,191,0.1);
    }
    .form-group textarea { resize: vertical; min-height: 70px; }

    /* 商品清单表格 */
    .order-table { width: 100%; border-collapse: collapse; }
    .order-table th {
      text-align: left; font-size: 12px; font-weight: 600;
      color: var(--text-muted); padding: 8px 0; border-bottom: 1px solid #f0eaff;
    }
    .order-table td {
      padding: 12px 0; border-bottom: 1px solid #f9f6ff; font-size: 14px;
      vertical-align: middle;
    }
    .order-table tr:last-child td { border-bottom: none; }
    .td-price { color: var(--danger); font-weight: 700; text-align: right; }
    .td-name { font-weight: 600; }
    .td-qty  { color: var(--text-muted); text-align: center; }

    /* 结算面板 */
    .sum-row {
      display: flex; justify-content: space-between;
      font-size: 14px; margin-bottom: 10px; color: var(--text-muted);
    }
    .sum-row.total {
      border-top: 1px dashed #e0d4f7; padding-top: 12px; margin-top: 4px;
      font-size: 17px; font-weight: 800; color: var(--text);
    }
    .sum-row.total .val { color: var(--danger); font-size: 22px; }

    /* 余额提示 */
    .balance-tip {
      background: #f0fff4; border-radius: 10px; padding: 10px 14px;
      font-size: 13px; color: var(--success); margin: 14px 0;
      display: flex; align-items: center; gap: 6px;
    }
    .balance-tip.warn { background: #fff5f5; color: var(--danger); }

    /* 提交按钮 */
    .btn-submit {
      display: block; width: 100%; padding: 14px 0;
      background: linear-gradient(135deg, var(--primary), #9b6dff);
      color: #fff; border: none; border-radius: 12px;
      font-size: 16px; font-weight: 700; cursor: pointer;
      transition: var(--transition); margin-top: 16px;
    }
    .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(124,92,191,0.4); }
    .btn-submit:active { transform: scale(0.97); }

    /* 错误提示 */
    .alert-error {
      background: #fff5f5; border: 1px solid #fed7d7;
      color: var(--danger); border-radius: 10px; padding: 12px 16px;
      font-size: 14px; display: flex; align-items: center; gap: 8px;
    }
  </style>
</head>
<body>

<%-- 顶栏 --%>
<div class="header">
  <div class="logo">🍰 蛋糕商城</div>
  <nav class="nav">
    <a href="${pageContext.request.contextPath}/product/list">商品列表</a>
    <a href="${pageContext.request.contextPath}/cart/list">购物车</a>
    <a href="${pageContext.request.contextPath}/user/orders">我的订单</a>
    <a href="${pageContext.request.contextPath}/user/center">个人中心</a>
    <a href="${pageContext.request.contextPath}/user/logout">退出</a>
  </nav>
</div>

<%-- 步骤条 --%>
<div class="steps">
  <div class="step done">
    <div class="step-dot">✓</div>
    <div class="step-label">购物车</div>
  </div>
  <div class="step-line done"></div>
  <div class="step active">
    <div class="step-dot">2</div>
    <div class="step-label">确认订单</div>
  </div>
  <div class="step-line"></div>
  <div class="step">
    <div class="step-dot">3</div>
    <div class="step-label">完成</div>
  </div>
</div>

<div class="page-wrap">
  <%-- 左侧：收货信息 + 商品清单 --%>
  <div class="form-col">

    <%-- 错误提示 --%>
    <c:if test="${not empty message}">
      <div class="alert-error">⚠️ ${message}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/order/submit" method="post" id="orderForm">
      <%-- 收货信息 --%>
      <div class="card">
        <div class="card-title">📍 收货信息</div>
        <div class="form-group">
          <label>收货人姓名 <span style="color:var(--danger);">*</span></label>
          <input type="text" name="receiverName" value="${user.nickname}" required placeholder="请输入收货人姓名">
        </div>
        <div class="form-group">
          <label>联系电话 <span style="color:var(--danger);">*</span></label>
          <input type="tel" name="receiverPhone" value="${user.phone}" required placeholder="请输入手机号">
        </div>
        <div class="form-group">
          <label>收货地址 <span style="color:var(--danger);">*</span></label>
          <input type="text" name="receiverAddress" value="${user.address}" required placeholder="省 / 市 / 区 / 详细地址">
        </div>
        <div class="form-group">
          <label>备注（选填）</label>
          <textarea name="remark" placeholder="如：生日蛋糕，请写上祝福语..."></textarea>
        </div>
      </div>

      <%-- 商品清单 --%>
      <div class="card">
        <div class="card-title">🛒 商品清单</div>
        <table class="order-table">
          <thead>
            <tr>
              <th>商品名称</th>
              <th style="text-align:center;">数量</th>
              <th style="text-align:right;">单价</th>
              <th style="text-align:right;">小计</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${cart}" var="item">
              <tr>
                <td class="td-name">${item.productName}</td>
                <td class="td-qty">× ${item.quantity}</td>
                <td style="text-align:right;color:var(--text-muted);">¥<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></td>
                <td class="td-price">¥<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </form>
  </div>

  <%-- 右侧：支付摘要 --%>
  <div class="aside-col">
    <div class="card">
      <div class="card-title">💳 支付摘要</div>
      <div class="sum-row"><span>商品金额</span><span>¥<fmt:formatNumber value="${total}" pattern="#,##0.00"/></span></div>
      <div class="sum-row"><span>运费</span><span style="color:var(--success);">免费</span></div>
      <div class="sum-row total"><span>合计</span><span class="val">¥<fmt:formatNumber value="${total}" pattern="#,##0.00"/></span></div>

      <%-- 余额判断提示 --%>
      <c:choose>
        <c:when test="${user.balance >= total}">
          <div class="balance-tip">✅ 余额充足（¥<fmt:formatNumber value="${user.balance}" pattern="#,##0.00"/>）</div>
        </c:when>
        <c:otherwise>
          <div class="balance-tip warn">⚠️ 余额不足（¥<fmt:formatNumber value="${user.balance}" pattern="#,##0.00"/>），请充值</div>
        </c:otherwise>
      </c:choose>

      <button type="submit" form="orderForm" class="btn-submit"
              onclick="return validateForm()">
        确认下单 →
      </button>
    </div>
  </div>
</div>

<script>
  /** 提交前简单校验 */
  function validateForm() {
    var name    = document.querySelector('[name=receiverName]').value.trim();
    var phone   = document.querySelector('[name=receiverPhone]').value.trim();
    var address = document.querySelector('[name=receiverAddress]').value.trim();
    if (!name)    { alert('请填写收货人姓名'); return false; }
    if (!phone)   { alert('请填写联系电话'); return false; }
    if (!address) { alert('请填写收货地址'); return false; }
    // 简单手机号格式校验
    if (!/^1[3-9]\d{9}$/.test(phone)) {
      alert('请输入正确的手机号'); return false;
    }
    return true;
  }
</script>
</body>
</html>
