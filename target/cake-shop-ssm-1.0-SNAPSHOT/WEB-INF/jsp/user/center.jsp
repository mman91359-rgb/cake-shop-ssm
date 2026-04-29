<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>个人中心 - 蛋糕商城</title>
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

    /* 顶栏 */
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

    /* 用户 Hero 区 */
    .user-hero {
      background: linear-gradient(135deg, var(--primary) 0%, #9b6dff 100%);
      color: #fff; padding: 36px 40px 80px;
    }
    .hero-inner {
      max-width: 900px; margin: 0 auto;
      display: flex; align-items: center; gap: 24px;
    }
    .avatar {
      width: 80px; height: 80px; border-radius: 50%;
      background: rgba(255,255,255,0.2);
      display: flex; align-items: center; justify-content: center;
      font-size: 36px; flex-shrink: 0;
      border: 3px solid rgba(255,255,255,0.5);
    }
    .hero-text .name { font-size: 24px; font-weight: 800; }
    .hero-text .sub  { font-size: 13px; opacity: 0.8; margin-top: 4px; }

    /* 主体（卡片上移覆盖hero） */
    .main-wrap {
      max-width: 900px; margin: -48px auto 48px; padding: 0 24px;
      display: grid; grid-template-columns: 260px 1fr; gap: 20px;
      align-items: start;
    }

    /* 卡片 */
    .card {
      background: var(--card-bg); border-radius: var(--radius);
      box-shadow: var(--shadow); overflow: hidden;
    }
    .card-header {
      padding: 18px 22px 14px;
      border-bottom: 1px solid #f0eaff;
      font-size: 15px; font-weight: 800;
      display: flex; align-items: center; gap: 7px;
    }

    /* 左侧：信息 + 余额 + 快捷入口 */
    .left-col { display: flex; flex-direction: column; gap: 16px; }

    /* 余额卡 */
    .balance-card {
      background: linear-gradient(135deg, #fff5f7, #fdf2ff);
      border-radius: var(--radius); padding: 22px;
      box-shadow: var(--shadow); text-align: center;
    }
    .balance-label { font-size: 13px; color: var(--text-muted); margin-bottom: 8px; }
    .balance-num { font-size: 38px; font-weight: 900; color: var(--danger); line-height: 1; }
    .balance-num .unit { font-size: 20px; }
    .balance-action { margin-top: 14px; }
    .btn-recharge {
      display: inline-block; padding: 9px 24px;
      background: linear-gradient(135deg, var(--primary), #9b6dff);
      color: #fff; border: none; border-radius: 20px;
      font-size: 14px; font-weight: 600; cursor: pointer; transition: var(--transition);
    }
    .btn-recharge:hover { transform: translateY(-1px); box-shadow: 0 4px 14px rgba(124,92,191,0.4); }

    /* 快捷入口 */
    .quick-links {
      display: grid; grid-template-columns: 1fr 1fr; gap: 10px; padding: 16px;
    }
    .quick-link {
      display: flex; flex-direction: column; align-items: center; gap: 5px;
      padding: 14px 8px; border-radius: 10px;
      background: var(--bg); text-decoration: none; color: var(--text);
      font-size: 13px; transition: var(--transition);
    }
    .quick-link:hover { background: #ede8f7; transform: translateY(-2px); }
    .quick-link .icon { font-size: 22px; }

    /* 右侧：基本信息 */
    .info-list { padding: 6px 0; }
    .info-item {
      display: flex; align-items: flex-start; gap: 0;
      padding: 14px 22px; border-bottom: 1px solid #f9f6ff;
      transition: var(--transition);
    }
    .info-item:last-child { border-bottom: none; }
    .info-item:hover { background: #faf8ff; }
    .info-label { width: 90px; font-size: 13px; color: var(--text-muted); flex-shrink: 0; padding-top: 1px; }
    .info-val { flex: 1; font-size: 15px; font-weight: 500; word-break: break-all; }
    .info-val.empty { color: var(--text-muted); font-size: 13px; font-weight: 400; }
    .info-badge {
      display: inline-block; padding: 2px 10px; border-radius: 12px;
      font-size: 11px; font-weight: 700;
      background: #e6f4ea; color: var(--success);
    }

    /* 充值弹窗 */
    .modal-mask {
      display: none; position: fixed; inset: 0;
      background: rgba(0,0,0,0.4); z-index: 1000;
      align-items: center; justify-content: center;
    }
    .modal-mask.show { display: flex; }
    .modal-box {
      background: #fff; border-radius: var(--radius);
      padding: 32px; width: 340px; max-width: 94vw;
      box-shadow: 0 16px 60px rgba(0,0,0,0.2);
      animation: pop 0.3s ease;
    }
    @keyframes pop { from{transform:scale(.85);opacity:0;} to{transform:scale(1);opacity:1;} }
    .modal-title { font-size: 17px; font-weight: 800; margin-bottom: 18px; }
    .amount-chips { display: flex; gap: 8px; flex-wrap: wrap; margin-bottom: 14px; }
    .chip {
      padding: 7px 16px; border-radius: 20px; border: 1.5px solid #e0d4f7;
      font-size: 14px; cursor: pointer; transition: var(--transition); background: #fff;
    }
    .chip.active, .chip:hover { background: var(--primary); color: #fff; border-color: var(--primary); }
    .modal-input {
      width: 100%; padding: 10px 14px; border: 1.5px solid #e0d4f7;
      border-radius: 10px; font-size: 15px; outline: none; margin-bottom: 18px;
      transition: var(--transition);
    }
    .modal-input:focus { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(124,92,191,0.1); }
    .modal-btns { display: flex; gap: 10px; }
    .modal-btn {
      flex: 1; padding: 11px 0; border-radius: 10px;
      font-size: 15px; font-weight: 700; cursor: pointer; transition: var(--transition); border: none;
    }
    .modal-btn.primary { background: linear-gradient(135deg,var(--primary),#9b6dff); color:#fff; }
    .modal-btn.primary:hover { transform: translateY(-1px); box-shadow: 0 4px 14px rgba(124,92,191,0.4); }
    .modal-btn.cancel { background: #f0eaff; color: var(--primary); }
    .modal-btn.cancel:hover { background: #e4d8ff; }
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
    <a href="${pageContext.request.contextPath}/user/center" class="active">个人中心</a>
    <a href="${pageContext.request.contextPath}/user/logout">退出</a>
  </nav>
</div>

<%-- 用户 Hero --%>
<div class="user-hero">
  <div class="hero-inner">
    <div class="avatar">😊</div>
    <div class="hero-text">
      <div class="name">${user.nickname != null ? user.nickname : user.username}</div>
      <div class="sub">欢迎回来，继续享受甜蜜时光 🍰</div>
    </div>
  </div>
</div>

<div class="main-wrap">
  <%-- 左列 --%>
  <div class="left-col">
    <%-- 余额卡 --%>
    <div class="balance-card">
      <div class="balance-label">账户余额</div>
      <div class="balance-num">
        <span class="unit">¥</span><fmt:formatNumber value="${user.balance}" pattern="#,##0.00"/>
      </div>
      <div class="balance-action">
        <button class="btn-recharge" onclick="openRecharge()">💳 充值</button>
      </div>
    </div>

    <%-- 快捷入口 --%>
    <div class="card">
      <div class="card-header">🧭 快捷入口</div>
      <div class="quick-links">
        <a href="${pageContext.request.contextPath}/product/list" class="quick-link">
          <span class="icon">🍰</span><span>去购物</span>
        </a>
        <a href="${pageContext.request.contextPath}/cart/list" class="quick-link">
          <span class="icon">🛒</span><span>购物车</span>
        </a>
        <a href="${pageContext.request.contextPath}/user/orders" class="quick-link">
          <span class="icon">📋</span><span>我的订单</span>
        </a>
        <a href="${pageContext.request.contextPath}/user/logout" class="quick-link">
          <span class="icon">🚪</span><span>退出登录</span>
        </a>
      </div>
    </div>
  </div>

  <%-- 右列：基本信息 --%>
  <div class="card">
    <div class="card-header">👤 基本信息</div>
    <div class="info-list">
      <div class="info-item">
        <div class="info-label">用户名</div>
        <div class="info-val">${user.username} <span class="info-badge">已认证</span></div>
      </div>
      <div class="info-item">
        <div class="info-label">昵称</div>
        <c:choose>
          <c:when test="${not empty user.nickname}">
            <div class="info-val">${user.nickname}</div>
          </c:when>
          <c:otherwise>
            <div class="info-val empty">未设置</div>
          </c:otherwise>
        </c:choose>
      </div>
      <div class="info-item">
        <div class="info-label">手机号</div>
        <c:choose>
          <c:when test="${not empty user.phone}">
            <div class="info-val">${user.phone}</div>
          </c:when>
          <c:otherwise>
            <div class="info-val empty">未绑定</div>
          </c:otherwise>
        </c:choose>
      </div>
      <div class="info-item">
        <div class="info-label">收货地址</div>
        <c:choose>
          <c:when test="${not empty user.address}">
            <div class="info-val">${user.address}</div>
          </c:when>
          <c:otherwise>
            <div class="info-val empty">未填写</div>
          </c:otherwise>
        </c:choose>
      </div>
      <div class="info-item">
        <div class="info-label">注册时间</div>
        <div class="info-val">
          <fmt:formatDate value="${user.createdTime}" pattern="yyyy-MM-dd HH:mm"/>
        </div>
      </div>
    </div>
  </div>
</div>

<%-- 充值弹窗（纯前端模拟，实际可对接充值接口） --%>
<div class="modal-mask" id="rechargeMask" onclick="closeRecharge(event)">
  <div class="modal-box">
    <div class="modal-title">💳 账户充值</div>
    <div class="amount-chips">
      <span class="chip" onclick="setAmount(50)">¥50</span>
      <span class="chip" onclick="setAmount(100)">¥100</span>
      <span class="chip" onclick="setAmount(200)">¥200</span>
      <span class="chip" onclick="setAmount(500)">¥500</span>
    </div>
    <input type="number" class="modal-input" id="rechargeAmt" placeholder="或输入自定义金额" min="1">
    <div class="modal-btns">
      <button class="modal-btn cancel" onclick="closeRecharge()">取 消</button>
      <button class="modal-btn primary" onclick="doRecharge()">确认充值</button>
    </div>
  </div>
</div>

<script>
  function openRecharge()  { document.getElementById('rechargeMask').classList.add('show'); }
  function closeRecharge(e) {
    if (!e || e.target === document.getElementById('rechargeMask'))
      document.getElementById('rechargeMask').classList.remove('show');
  }
  function setAmount(v) {
    document.getElementById('rechargeAmt').value = v;
    document.querySelectorAll('.chip').forEach(function(c){ c.classList.remove('active'); });
    event.target.classList.add('active');
  }
  function doRecharge() {
    var amt = parseFloat(document.getElementById('rechargeAmt').value);
    if (!amt || amt <= 0) { alert('请输入有效充值金额'); return; }
    // 此处为前端演示提示，实际项目可提交到后端 /user/recharge 接口
    alert('充值功能演示：¥' + amt + ' 充值成功！\n（实际项目请对接支付接口）');
    closeRecharge();
  }
</script>
</body>
</html>
