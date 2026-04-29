<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>下单成功 - 蛋糕商城</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }
    :root {
      --primary: #7c5cbf; --primary-dark: #5e3f9e;
      --bg: #f7f3ff; --card-bg: #fff; --text: #2d2d2d; --text-muted: #888;
      --danger: #e53e3e; --success: #38a169;
      --shadow: 0 4px 20px rgba(124,92,191,0.12);
      --radius: 16px;
    }
    body {
      font-family: 'Segoe UI','PingFang SC','Microsoft YaHei',sans-serif;
      background: var(--bg); color: var(--text);
      min-height: 100vh; display: flex; flex-direction: column; align-items: center; justify-content: center;
    }

    /* 撒花动画 */
    .confetti-wrap { position: fixed; inset: 0; pointer-events: none; overflow: hidden; z-index: 0; }
    .confetti {
      position: absolute; top: -20px; width: 10px; height: 14px; border-radius: 3px;
      animation: fall linear forwards;
    }
    @keyframes fall {
      to { transform: translateY(110vh) rotate(720deg); opacity: 0; }
    }

    /* 主卡片 */
    .success-card {
      background: var(--card-bg); border-radius: var(--radius);
      box-shadow: 0 16px 60px rgba(124,92,191,0.18);
      padding: 52px 48px; text-align: center;
      max-width: 460px; width: 90%;
      position: relative; z-index: 1;
      animation: slideUp 0.6s cubic-bezier(.4,0,.2,1);
    }
    @keyframes slideUp {
      from { opacity: 0; transform: translateY(30px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    /* 成功图标 */
    .success-icon {
      width: 88px; height: 88px; border-radius: 50%;
      background: linear-gradient(135deg, #d4edda, #c3e6cb);
      display: flex; align-items: center; justify-content: center;
      margin: 0 auto 24px; font-size: 42px;
      animation: pop 0.5s 0.3s cubic-bezier(.4,0,.2,1) both;
    }
    @keyframes pop {
      from { transform: scale(0.3); opacity: 0; }
      to   { transform: scale(1); opacity: 1; }
    }

    .success-title { font-size: 26px; font-weight: 900; color: var(--success); margin-bottom: 8px; }
    .success-sub { font-size: 14px; color: var(--text-muted); margin-bottom: 28px; }

    /* 订单信息块 */
    .order-info {
      background: var(--bg); border-radius: 12px; padding: 18px 22px;
      text-align: left; margin-bottom: 28px;
    }
    .info-row {
      display: flex; justify-content: space-between; align-items: center;
      font-size: 14px; padding: 6px 0;
    }
    .info-row + .info-row { border-top: 1px solid #ede8f7; }
    .info-label { color: var(--text-muted); }
    .info-val   { font-weight: 700; }
    .info-val.amount { color: var(--danger); font-size: 18px; }

    /* 步骤条（完成） */
    .steps {
      display: flex; align-items: center; gap: 0; margin-bottom: 28px;
    }
    .step { flex: 1; text-align: center; }
    .step-dot {
      width: 28px; height: 28px; border-radius: 50%;
      display: inline-flex; align-items: center; justify-content: center;
      font-size: 12px; font-weight: 700;
    }
    .step.done .step-dot { background: var(--success); color: #fff; }
    .step-label { font-size: 11px; color: var(--text-muted); margin-top: 4px; }
    .step.done .step-label { color: var(--success); font-weight: 600; }
    .step-line { flex: 1; height: 2px; background: var(--success); position: relative; top: -8px; }

    /* 按钮组 */
    .btn-row { display: flex; gap: 12px; }
    .btn {
      flex: 1; padding: 12px 0; border-radius: 10px;
      font-size: 15px; font-weight: 700; cursor: pointer;
      text-align: center; text-decoration: none; transition: 0.2s;
      display: flex; align-items: center; justify-content: center; gap: 4px;
    }
    .btn-primary {
      background: linear-gradient(135deg, var(--primary), #9b6dff);
      color: #fff; border: none;
    }
    .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(124,92,191,0.4); }
    .btn-outline {
      background: #fff; color: var(--primary);
      border: 1.5px solid var(--primary);
    }
    .btn-outline:hover { background: var(--bg); }

    /* 自动跳转倒计时 */
    .auto-tip { font-size: 12px; color: var(--text-muted); margin-top: 18px; }
    .auto-tip em { color: var(--primary); font-style: normal; font-weight: 700; }
  </style>
</head>
<body>

<%-- 撒花特效（JS动态生成） --%>
<div class="confetti-wrap" id="confettiWrap"></div>

<div class="success-card">
  <%-- 步骤条：全部完成 --%>
  <div class="steps">
    <div class="step done"><div class="step-dot">✓</div><div class="step-label">购物车</div></div>
    <div class="step-line"></div>
    <div class="step done"><div class="step-dot">✓</div><div class="step-label">确认订单</div></div>
    <div class="step-line"></div>
    <div class="step done"><div class="step-dot">✓</div><div class="step-label">完成</div></div>
  </div>

  <div class="success-icon">🎉</div>
  <div class="success-title">下单成功！</div>
  <div class="success-sub">感谢您的购买，我们会尽快为您配送 🚚</div>

  <%-- 订单信息 --%>
  <div class="order-info">
    <div class="info-row">
      <span class="info-label">订单号</span>
      <span class="info-val" style="font-size:13px;letter-spacing:.5px;">${order.orderNo}</span>
    </div>
    <div class="info-row">
      <span class="info-label">订单金额</span>
      <span class="info-val amount">¥<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></span>
    </div>
    <div class="info-row">
      <span class="info-label">支付方式</span>
      <span class="info-val">账户余额</span>
    </div>
    <div class="info-row">
      <span class="info-label">订单状态</span>
      <span class="info-val" style="color:var(--success);">✅ 待发货</span>
    </div>
  </div>

  <div class="btn-row">
    <a href="${pageContext.request.contextPath}/product/list" class="btn btn-outline">继续购物</a>
    <a href="${pageContext.request.contextPath}/user/orders"  class="btn btn-primary">查看订单 →</a>
  </div>
  <div class="auto-tip">将在 <em id="countdown">5</em> 秒后自动返回商品列表</div>
</div>

<script>
  /* ===== 撒花特效 ===== */
  var colors = ['#7c5cbf','#ff6b9d','#ffd93d','#6bcb77','#4d96ff','#ff922b'];
  var wrap = document.getElementById('confettiWrap');
  for (var i = 0; i < 70; i++) {
    (function(i) {
      var el = document.createElement('div');
      el.className = 'confetti';
      el.style.left       = Math.random() * 100 + 'vw';
      el.style.background = colors[Math.floor(Math.random() * colors.length)];
      el.style.width      = (8 + Math.random() * 8)  + 'px';
      el.style.height     = (10 + Math.random() * 10) + 'px';
      el.style.animationDuration = (1.5 + Math.random() * 2.5) + 's';
      el.style.animationDelay   = (Math.random() * 0.8) + 's';
      wrap.appendChild(el);
    })(i);
  }

  /* ===== 自动倒计时跳转 ===== */
  var sec = 5;
  var cd  = document.getElementById('countdown');
  var timer = setInterval(function() {
    sec--;
    cd.textContent = sec;
    if (sec <= 0) {
      clearInterval(timer);
      location.href = '${pageContext.request.contextPath}/product/list';
    }
  }, 1000);
</script>
</body>
</html>
