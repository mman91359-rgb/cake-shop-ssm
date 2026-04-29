<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>${product.name} - 蛋糕商城</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }
    :root {
      --primary: #7c5cbf; --primary-dark: #5e3f9e; --accent: #ff6b9d;
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
    .nav { display: flex; align-items: center; gap: 6px; }
    .nav a {
      color: rgba(255,255,255,0.88); text-decoration: none;
      padding: 7px 16px; border-radius: 20px; font-size: 14px; transition: var(--transition);
    }
    .nav a:hover { background: rgba(255,255,255,0.2); color: #fff; }

    /* 面包屑 */
    .breadcrumb {
      max-width: 1100px; margin: 20px auto 0; padding: 0 40px;
      font-size: 13px; color: var(--text-muted);
    }
    .breadcrumb a { color: var(--primary); text-decoration: none; }
    .breadcrumb a:hover { text-decoration: underline; }
    .breadcrumb span { margin: 0 6px; }

    /* 主体容器 */
    .container {
      max-width: 1100px; margin: 20px auto 60px;
      padding: 0 40px;
    }

    /* 详情卡片 */
    .detail-card {
      background: var(--card-bg);
      border-radius: var(--radius);
      box-shadow: var(--shadow);
      display: flex;
      overflow: hidden;
      min-height: 480px;
    }

    /* 图片区 */
    .img-section {
      flex: 0 0 480px;
      background: linear-gradient(135deg, #f3e8ff, #fce7f3);
      display: flex; align-items: center; justify-content: center;
      position: relative; overflow: hidden;
    }

    .product-image {
      width: 100%; height: 100%;
      object-fit: cover;
      transition: transform 0.5s ease;
    }
    .img-section:hover .product-image { transform: scale(1.04); }

    /* 缺货遮罩 */
    .out-of-stock-overlay {
      position: absolute; inset: 0;
      background: rgba(0,0,0,0.45);
      display: flex; align-items: center; justify-content: center;
      color: #fff; font-size: 24px; font-weight: 700; letter-spacing: 2px;
    }

    /* 信息区 */
    .info-section {
      flex: 1; padding: 40px;
      display: flex; flex-direction: column; gap: 18px;
    }

    .product-name {
      font-size: 28px; font-weight: 800; color: var(--text); line-height: 1.3;
    }

    /* 价格块 */
    .price-block {
      background: linear-gradient(135deg, #fff5f7, #fdf2ff);
      border-radius: 12px; padding: 18px 22px;
      display: flex; align-items: baseline; gap: 12px;
    }
    .price-main {
      font-size: 38px; color: var(--danger); font-weight: 900; line-height: 1;
    }
    .price-unit { font-size: 20px; }
    .price-tag {
      background: var(--accent); color: #fff;
      font-size: 11px; padding: 3px 10px; border-radius: 12px; font-weight: 700;
    }

    /* 标签行 */
    .meta-row {
      display: flex; gap: 10px; flex-wrap: wrap; align-items: center;
      font-size: 14px; color: var(--text-muted);
    }
    .meta-chip {
      background: var(--bg); border-radius: 20px;
      padding: 5px 14px; font-size: 13px;
      display: flex; align-items: center; gap: 5px;
    }
    .meta-chip.warn { background: #fff5f5; color: var(--danger); }
    .meta-chip.ok   { background: #f0fff4; color: var(--success); }

    /* 描述 */
    .desc-block { border-top: 1px dashed #e8dff7; padding-top: 16px; }
    .desc-title { font-size: 13px; color: var(--text-muted); margin-bottom: 8px; }
    .desc-text { font-size: 15px; line-height: 1.8; color: var(--text); }

    /* 数量选择器 */
    .qty-block { display: flex; align-items: center; gap: 12px; }
    .qty-label { font-size: 14px; color: var(--text-muted); }
    .qty-stepper {
      display: flex; align-items: center; border: 1.5px solid #e0d4f7;
      border-radius: 10px; overflow: hidden; background: #fff;
    }
    .qty-btn {
      width: 36px; height: 36px; border: none; background: transparent;
      font-size: 18px; cursor: pointer; color: var(--primary);
      transition: var(--transition); display: flex; align-items: center; justify-content: center;
    }
    .qty-btn:hover { background: var(--bg); }
    .qty-num {
      width: 48px; height: 36px; text-align: center; border: none;
      border-left: 1px solid #e0d4f7; border-right: 1px solid #e0d4f7;
      font-size: 15px; color: var(--text); outline: none; background: #fff;
    }

    /* 操作按钮 */
    .action-row { display: flex; gap: 12px; margin-top: 8px; }

    .btn-cart {
      flex: 1; padding: 14px 0;
      background: linear-gradient(135deg, var(--primary), #9b6dff);
      color: #fff; border: none; border-radius: 12px;
      font-size: 16px; font-weight: 700; cursor: pointer;
      transition: var(--transition);
      display: flex; align-items: center; justify-content: center; gap: 6px;
    }
    .btn-cart:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 20px rgba(124,92,191,0.4);
    }
    .btn-cart:active { transform: scale(0.97); }
    .btn-cart:disabled {
      background: #ccc; cursor: not-allowed; transform: none; box-shadow: none;
    }

    .btn-back {
      padding: 14px 22px;
      border: 1.5px solid var(--primary); color: var(--primary);
      background: #fff; border-radius: 12px;
      font-size: 15px; cursor: pointer; transition: var(--transition);
      text-decoration: none; display: flex; align-items: center; gap: 5px;
    }
    .btn-back:hover { background: var(--bg); }

    /* Toast */
    #toast {
      position: fixed; bottom: 32px; left: 50%;
      transform: translateX(-50%) translateY(20px);
      background: #333; color: #fff; padding: 12px 24px;
      border-radius: 28px; font-size: 14px; opacity: 0;
      transition: all 0.35s ease; z-index: 9999; pointer-events: none;
      box-shadow: 0 4px 20px rgba(0,0,0,0.2);
    }
    #toast.show  { opacity: 1; transform: translateX(-50%) translateY(0); }
    #toast.success { background: var(--success); }
    #toast.error   { background: var(--danger); }

    /* 推荐提示条 */
    .tip-bar {
      margin-top: 24px; background: var(--card-bg);
      border-radius: var(--radius); padding: 18px 24px;
      box-shadow: var(--shadow);
      display: flex; gap: 30px; flex-wrap: wrap;
    }
    .tip-item { display: flex; align-items: center; gap: 8px; font-size: 14px; color: var(--text-muted); }
    .tip-icon { font-size: 20px; }
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

<div class="container">
  <%-- 面包屑导航 --%>
  <div class="breadcrumb">
    <a href="${pageContext.request.contextPath}/product/list">商品列表</a>
    <span>›</span>
    <span>${product.name}</span>
  </div>

  <%-- 详情卡片 --%>
  <div class="detail-card" style="margin-top:16px;">
    <%-- 图片区 --%>
    <div class="img-section">
      <img src="${pageContext.request.contextPath}${product.image}"
           alt="${product.name}" class="product-image"
           onerror="this.src='${pageContext.request.contextPath}/images/default-cake.jpg'">
      <c:if test="${product.stock == 0}">
        <div class="out-of-stock-overlay">暂时售罄</div>
      </c:if>
    </div>

    <%-- 信息区 --%>
    <div class="info-section">
      <div class="product-name">${product.name}</div>

      <%-- 价格块 --%>
      <div class="price-block">
        <div class="price-main"><span class="price-unit">¥</span><fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></div>
        <span class="price-tag">精选好物</span>
      </div>

      <%-- 库存标签 --%>
      <div class="meta-row">
        <c:choose>
          <c:when test="${product.stock == 0}">
            <span class="meta-chip warn">⚠️ 暂时售罄</span>
          </c:when>
          <c:when test="${product.stock <= 10}">
            <span class="meta-chip warn">🔥 仅剩 ${product.stock} 件</span>
          </c:when>
          <c:otherwise>
            <span class="meta-chip ok">✅ 库存充足（${product.stock} 件）</span>
          </c:otherwise>
        </c:choose>
        <span class="meta-chip">🚚 下单即配送</span>
        <span class="meta-chip">🎁 精美包装</span>
      </div>

      <%-- 描述 --%>
      <div class="desc-block">
        <div class="desc-title">商品介绍</div>
        <div class="desc-text">${product.description}</div>
      </div>

      <%-- 加购表单 --%>
      <form action="${pageContext.request.contextPath}/cart/add" method="post"
            id="cartForm" onsubmit="return handleAdd(event)">
        <input type="hidden" name="productId" value="${product.id}">
        <input type="hidden" name="quantity" id="qtyHidden" value="1">

        <div class="qty-block">
          <span class="qty-label">数量：</span>
          <div class="qty-stepper">
            <button type="button" class="qty-btn" onclick="changeQty(-1)">−</button>
            <input type="text" id="qtyDisplay" class="qty-num" value="1" readonly>
            <button type="button" class="qty-btn" onclick="changeQty(1)">+</button>
          </div>
          <span style="font-size:13px;color:var(--text-muted);">最多可购 ${product.stock} 件</span>
        </div>

        <div class="action-row">
          <button type="submit" class="btn-cart" ${product.stock == 0 ? 'disabled' : ''}>
            🛒 加入购物车
          </button>
          <a href="${pageContext.request.contextPath}/product/list" class="btn-back">← 返回</a>
        </div>
      </form>
    </div>
  </div>

  <%-- 服务保障条 --%>
  <div class="tip-bar">
    <div class="tip-item"><span class="tip-icon">🛡️</span> 品质保证，不满意退款</div>
    <div class="tip-item"><span class="tip-icon">🚚</span> 当日下单，次日送达</div>
    <div class="tip-item"><span class="tip-icon">❄️</span> 全程冷链，新鲜保温</div>
    <div class="tip-item"><span class="tip-icon">🎀</span> 支持定制，专属祝福</div>
  </div>
</div>

<div id="toast"></div>

<script>
  var maxQty = ${product.stock}; // 最大库存
  var qty = 1;

  /** 调整数量 */
  function changeQty(delta) {
    qty = Math.max(1, Math.min(maxQty, qty + delta));
    document.getElementById('qtyDisplay').value = qty;
    document.getElementById('qtyHidden').value  = qty;
  }

  /** 加购前校验 */
  function handleAdd(event) {
    if (maxQty === 0) {
      event.preventDefault();
      showToast('该商品暂时售罄', 'error');
      return false;
    }
    showToast('正在加入购物车...', '');
    return true; // 允许表单正常提交
  }

  /** Toast 提示 */
  function showToast(msg, type, duration) {
    duration = duration || 1800;
    var t = document.getElementById('toast');
    t.textContent = msg;
    t.className = 'show' + (type ? ' ' + type : '');
    clearTimeout(t._timer);
    t._timer = setTimeout(function() { t.className = ''; }, duration);
  }
</script>
</body>
</html>
