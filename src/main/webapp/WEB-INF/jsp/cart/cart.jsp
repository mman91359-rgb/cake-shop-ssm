<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>购物车 - 蛋糕商城</title>
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
    .nav a {
      color: rgba(255,255,255,0.88); text-decoration: none;
      padding: 7px 16px; border-radius: 20px; font-size: 14px; transition: var(--transition);
    }
    .nav a:hover, .nav a.active { background: rgba(255,255,255,0.2); color: #fff; }

    /* 主体 */
    .page-wrap {
      max-width: 1000px; margin: 32px auto 60px; padding: 0 24px;
      display: flex; gap: 24px; align-items: flex-start;
    }

    /* 左侧商品列表 */
    .cart-main { flex: 1; }

    .section-title {
      font-size: 20px; font-weight: 800; margin-bottom: 16px;
      display: flex; align-items: center; gap: 8px;
    }

    /* 购物车行卡片 */
    .cart-card {
      background: var(--card-bg); border-radius: var(--radius);
      box-shadow: var(--shadow); overflow: hidden; margin-bottom: 14px;
    }

    .cart-row {
      display: grid;
      grid-template-columns: 80px 1fr auto auto auto;
      align-items: center;
      gap: 16px; padding: 18px 20px;
      transition: var(--transition);
    }

    .cart-card:hover .cart-row { background: #faf8ff; }

    /* 商品缩略图 */
    .item-thumb {
      width: 80px; height: 80px; border-radius: 10px; object-fit: cover;
      background: linear-gradient(135deg,#f3e8ff,#fce7f3);
    }

    /* 商品信息 */
    .item-info {}
    .item-name { font-size: 15px; font-weight: 700; margin-bottom: 4px; }
    .item-price { font-size: 13px; color: var(--text-muted); }

    /* 步进器 */
    .stepper {
      display: flex; align-items: center;
      border: 1.5px solid #e0d4f7; border-radius: 10px; overflow: hidden;
    }
    .step-btn {
      width: 32px; height: 32px; border: none; background: transparent;
      font-size: 16px; cursor: pointer; color: var(--primary); transition: var(--transition);
    }
    .step-btn:hover { background: var(--bg); }
    .step-num {
      width: 40px; height: 32px; text-align: center;
      border: none; border-left: 1px solid #e0d4f7; border-right: 1px solid #e0d4f7;
      font-size: 14px; color: var(--text); background: #fff; outline: none;
    }

    /* 小计 */
    .item-sub {
      font-size: 16px; font-weight: 800; color: var(--danger); min-width: 80px; text-align: right;
    }

    /* 删除按钮 */
    .btn-remove {
      width: 30px; height: 30px; border-radius: 50%; border: none;
      background: transparent; color: var(--text-muted); font-size: 18px;
      cursor: pointer; transition: var(--transition);
      display: flex; align-items: center; justify-content: center;
    }
    .btn-remove:hover { background: #fff0f0; color: var(--danger); }

    /* 隐藏的更新表单 */
    .update-form { display: none; }

    /* 右侧结算面板 */
    .cart-aside {
      flex: 0 0 260px;
      position: sticky; top: 84px;
    }

    .aside-card {
      background: var(--card-bg); border-radius: var(--radius);
      box-shadow: var(--shadow); padding: 24px;
    }

    .aside-title { font-size: 16px; font-weight: 700; margin-bottom: 20px; }

    .aside-row {
      display: flex; justify-content: space-between;
      font-size: 14px; color: var(--text-muted); margin-bottom: 12px;
    }

    .aside-row.total {
      border-top: 1px dashed #e0d4f7; padding-top: 14px; margin-top: 6px;
      font-size: 18px; color: var(--text); font-weight: 700;
    }
    .aside-row.total .amount { color: var(--danger); font-size: 22px; font-weight: 900; }

    .btn-checkout {
      display: block; width: 100%;
      background: linear-gradient(135deg, var(--primary), #9b6dff);
      color: #fff; border: none; border-radius: 12px;
      padding: 14px 0; font-size: 16px; font-weight: 700;
      cursor: pointer; text-align: center; text-decoration: none;
      margin-top: 18px; transition: var(--transition);
    }
    .btn-checkout:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(124,92,191,0.4); }

    .btn-continue {
      display: block; text-align: center; margin-top: 10px;
      color: var(--primary); text-decoration: none; font-size: 13px;
    }
    .btn-continue:hover { text-decoration: underline; }

    /* 空购物车 */
    .empty-state {
      background: var(--card-bg); border-radius: var(--radius);
      box-shadow: var(--shadow); padding: 80px 40px; text-align: center;
    }
    .empty-icon { font-size: 72px; margin-bottom: 16px; }
    .empty-text { color: var(--text-muted); font-size: 16px; margin-bottom: 24px; }
    .btn-shop {
      background: linear-gradient(135deg, var(--primary), #9b6dff);
      color: #fff; padding: 12px 32px; border-radius: 24px;
      text-decoration: none; font-weight: 700; font-size: 15px; transition: var(--transition);
    }
    .btn-shop:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(124,92,191,0.35); }

    /* Toast */
    #toast {
      position: fixed; bottom: 32px; left: 50%;
      transform: translateX(-50%) translateY(20px);
      background: #333; color: #fff; padding: 12px 24px;
      border-radius: 28px; font-size: 14px; opacity: 0;
      transition: all 0.35s ease; z-index: 9999; pointer-events: none;
    }
    #toast.show  { opacity: 1; transform: translateX(-50%) translateY(0); }
    #toast.success { background: var(--success); }
    #toast.error   { background: var(--danger); }
  </style>
</head>
<body>

<%-- 顶栏 --%>
<div class="header">
  <div class="logo">🍰 蛋糕商城</div>
  <nav class="nav">
    <a href="${pageContext.request.contextPath}/product/list">商品列表</a>
    <a href="${pageContext.request.contextPath}/cart/list" class="active">购物车</a>
    <a href="${pageContext.request.contextPath}/user/orders">我的订单</a>
    <a href="${pageContext.request.contextPath}/user/center">个人中心</a>
    <a href="${pageContext.request.contextPath}/user/logout">退出</a>
  </nav>
</div>

<div class="page-wrap">
  <c:choose>
    <%-- ===== 购物车为空 ===== --%>
    <c:when test="${empty cart}">
      <div class="cart-main">
        <div class="empty-state">
          <div class="empty-icon">🛒</div>
          <div class="empty-text">购物车空空如也，快去挑选美味蛋糕吧～</div>
          <a href="${pageContext.request.contextPath}/product/list" class="btn-shop">去选购</a>
        </div>
      </div>
    </c:when>

    <%-- ===== 购物车有商品 ===== --%>
    <c:otherwise>
      <%-- 左侧商品列表 --%>
      <div class="cart-main">
        <div class="section-title">🛒 购物车（<c:out value="${fn:length(cart)}"/>件）</div>

        <c:forEach items="${cart}" var="item">
          <div class="cart-card">
            <div class="cart-row">
              <%-- 缩略图（若无图则用默认） --%>
              <img src="${pageContext.request.contextPath}/images/cake${item.productId}.jpg"
                   class="item-thumb"
                   onerror="this.src='${pageContext.request.contextPath}/images/default-cake.jpg'"
                   alt="${item.productName}">

              <%-- 商品信息 --%>
              <div class="item-info">
                <div class="item-name">${item.productName}</div>
                <div class="item-price">单价：¥<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></div>
              </div>

              <%-- 数量步进器（点击后自动提交隐藏表单） --%>
              <div class="stepper">
                <button type="button" class="step-btn"
                        onclick="stepQty('${item.productId}', -1)">−</button>
                <input type="text" id="qty_${item.productId}"
                       class="step-num" value="${item.quantity}" readonly>
                <button type="button" class="step-btn"
                        onclick="stepQty('${item.productId}', 1)">+</button>
              </div>

              <%-- 小计 --%>
              <div class="item-sub" id="sub_${item.productId}">
                ¥<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/>
              </div>

              <%-- 删除按钮 --%>
              <form action="${pageContext.request.contextPath}/cart/remove" method="post">
                <input type="hidden" name="productId" value="${item.productId}">
                <button type="submit" class="btn-remove"
                        onclick="return confirm('确定移除「${item.productName}」？')"
                        title="删除">✕</button>
              </form>
            </div>

            <%-- 隐藏的更新数量表单（由 JS 自动提交） --%>
            <form class="update-form" id="upd_${item.productId}"
                  action="${pageContext.request.contextPath}/cart/update" method="post">
              <input type="hidden" name="productId" value="${item.productId}">
              <input type="hidden" name="quantity" id="updQty_${item.productId}" value="${item.quantity}">
            </form>
          </div>
        </c:forEach>
      </div>

      <%-- 右侧结算面板 --%>
      <div class="cart-aside">
        <div class="aside-card">
          <div class="aside-title">订单汇总</div>
          <div class="aside-row">
            <span>商品合计</span>
            <span>¥<fmt:formatNumber value="${total}" pattern="#,##0.00"/></span>
          </div>
          <div class="aside-row">
            <span>运费</span>
            <span style="color:var(--success);">免费</span>
          </div>
          <div class="aside-row total">
            <span>应付</span>
            <span class="amount">¥<fmt:formatNumber value="${total}" pattern="#,##0.00"/></span>
          </div>
          <a href="${pageContext.request.contextPath}/order/confirm" class="btn-checkout">去结算 →</a>
          <a href="${pageContext.request.contextPath}/product/list" class="btn-continue">← 继续购物</a>
        </div>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<div id="toast"></div>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>
  /**
   * 步进器：修改数量后延迟自动提交表单更新服务端购物车
   * @param {string} pid   - 商品ID
   * @param {number} delta - +1 或 -1
   */
  var debounceTimer = {};
  function stepQty(pid, delta) {
    var input = document.getElementById('qty_' + pid);
    var val   = parseInt(input.value) + delta;
    if (val < 1) { showToast('数量不能少于1件', 'error'); return; }
    input.value = val;
    document.getElementById('updQty_' + pid).value = val;

    // 防抖：500ms 内多次点击只提交一次
    clearTimeout(debounceTimer[pid]);
    debounceTimer[pid] = setTimeout(function() {
      document.getElementById('upd_' + pid).submit();
    }, 500);
  }

  function showToast(msg, type, duration) {
    duration = duration || 2000;
    var t = document.getElementById('toast');
    t.textContent = msg;
    t.className = 'show' + (type ? ' ' + type : '');
    clearTimeout(t._timer);
    t._timer = setTimeout(function() { t.className = ''; }, duration);
  }
</script>
</body>
</html>
