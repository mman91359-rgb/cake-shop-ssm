<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>蛋糕商城 - 精选蛋糕</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    /* ===== 全局重置 ===== */
    *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

    :root {
      --primary: #7c5cbf;
      --primary-light: #9b7dd4;
      --primary-dark: #5e3f9e;
      --accent: #ff6b9d;
      --bg: #f7f3ff;
      --card-bg: #ffffff;
      --text: #2d2d2d;
      --text-muted: #888;
      --danger: #e53e3e;
      --success: #38a169;
      --shadow: 0 4px 20px rgba(124,92,191,0.12);
      --radius: 14px;
      --transition: 0.25s cubic-bezier(.4,0,.2,1);
    }

    body {
      font-family: 'Segoe UI', 'PingFang SC', 'Microsoft YaHei', sans-serif;
      background: var(--bg);
      color: var(--text);
      min-height: 100vh;
    }

    /* ===== 顶栏 ===== */
    .header {
      background: linear-gradient(135deg, var(--primary) 0%, #9b6dff 100%);
      color: #fff;
      padding: 0 40px;
      height: 64px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      position: sticky;
      top: 0;
      z-index: 100;
      box-shadow: 0 2px 16px rgba(124,92,191,0.25);
    }

    .logo { font-size: 22px; font-weight: 700; letter-spacing: 1px; }

    .nav { display: flex; align-items: center; gap: 6px; }

    .nav a {
      color: rgba(255,255,255,0.88);
      text-decoration: none;
      padding: 7px 16px;
      border-radius: 20px;
      font-size: 14px;
      transition: var(--transition);
      position: relative;
    }

    .nav a:hover, .nav a.active {
      background: rgba(255,255,255,0.2);
      color: #fff;
    }

    /* 购物车角标 */
    .cart-badge {
      display: inline-flex;
      align-items: center;
      gap: 5px;
    }
    .badge-num {
      background: var(--accent);
      color: #fff;
      border-radius: 10px;
      font-size: 11px;
      padding: 1px 6px;
      font-weight: 700;
    }

    /* ===== 搜索区 ===== */
    .search-bar {
      background: linear-gradient(180deg, rgba(124,92,191,0.08) 0%, transparent 100%);
      padding: 28px 40px 20px;
    }

    .search-inner {
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      gap: 12px;
      align-items: center;
      flex-wrap: wrap;
    }

    .search-input-wrap {
      flex: 1;
      min-width: 220px;
      position: relative;
    }

    .search-input-wrap input {
      width: 100%;
      padding: 11px 20px 11px 44px;
      border: 1.5px solid rgba(124,92,191,0.25);
      border-radius: 28px;
      background: #fff;
      font-size: 15px;
      outline: none;
      transition: var(--transition);
      color: var(--text);
    }

    .search-input-wrap input:focus {
      border-color: var(--primary);
      box-shadow: 0 0 0 3px rgba(124,92,191,0.12);
    }

    .search-icon {
      position: absolute;
      left: 15px;
      top: 50%;
      transform: translateY(-50%);
      color: var(--text-muted);
      font-size: 17px;
    }

    .btn-search {
      background: var(--primary);
      color: #fff;
      border: none;
      padding: 11px 26px;
      border-radius: 28px;
      font-size: 14px;
      cursor: pointer;
      transition: var(--transition);
      font-weight: 600;
    }

    .btn-search:hover { background: var(--primary-dark); transform: translateY(-1px); }

    .btn-reset {
      background: #fff;
      color: var(--primary);
      border: 1.5px solid var(--primary);
      padding: 10px 20px;
      border-radius: 28px;
      font-size: 14px;
      cursor: pointer;
      transition: var(--transition);
      text-decoration: none;
      font-weight: 500;
    }

    .btn-reset:hover { background: var(--bg); }

    /* ===== 排序标签 ===== */
    .sort-tags {
      max-width: 1200px;
      margin: 0 auto 8px;
      padding: 0 40px;
      display: flex;
      gap: 10px;
      flex-wrap: wrap;
      align-items: center;
    }

    .sort-label { color: var(--text-muted); font-size: 14px; }

    .sort-tag {
      padding: 5px 16px;
      border-radius: 18px;
      border: 1.5px solid rgba(124,92,191,0.2);
      background: #fff;
      color: var(--text);
      font-size: 13px;
      cursor: pointer;
      text-decoration: none;
      transition: var(--transition);
    }

    .sort-tag:hover, .sort-tag.active {
      background: var(--primary);
      color: #fff;
      border-color: var(--primary);
    }

    /* ===== 结果统计 ===== */
    .result-info {
      max-width: 1200px;
      margin: 0 auto;
      padding: 0 40px 16px;
      color: var(--text-muted);
      font-size: 13px;
    }

    .result-info em { color: var(--primary); font-style: normal; font-weight: 600; }

    /* ===== 商品网格 ===== */
    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 0 40px 60px;
    }

    .product-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
      gap: 24px;
    }

    /* ===== 商品卡片 ===== */
    .product-card {
      background: var(--card-bg);
      border-radius: var(--radius);
      overflow: hidden;
      box-shadow: var(--shadow);
      transition: var(--transition);
      position: relative;
      display: flex;
      flex-direction: column;
    }

    .product-card:hover {
      transform: translateY(-6px);
      box-shadow: 0 12px 36px rgba(124,92,191,0.2);
    }

    /* 图片区 */
    .card-img-wrap {
      position: relative;
      overflow: hidden;
      height: 200px;
      background: linear-gradient(135deg, #f3e8ff, #fce7f3);
    }

    .product-image {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.4s ease;
    }

    .product-card:hover .product-image { transform: scale(1.06); }

    /* 库存角标 */
    .stock-badge {
      position: absolute;
      top: 10px;
      right: 10px;
      background: rgba(0,0,0,0.5);
      color: #fff;
      font-size: 11px;
      padding: 3px 9px;
      border-radius: 12px;
      backdrop-filter: blur(4px);
    }

    .stock-badge.low { background: rgba(229,62,62,0.85); }

    /* 详情链接遮罩 */
    .detail-overlay {
      position: absolute;
      inset: 0;
      background: rgba(124,92,191,0.0);
      display: flex;
      align-items: center;
      justify-content: center;
      transition: var(--transition);
      text-decoration: none;
    }

    .detail-overlay span {
      background: rgba(255,255,255,0.95);
      color: var(--primary);
      padding: 8px 20px;
      border-radius: 20px;
      font-size: 13px;
      font-weight: 600;
      opacity: 0;
      transform: translateY(8px);
      transition: var(--transition);
    }

    .product-card:hover .detail-overlay { background: rgba(124,92,191,0.15); }
    .product-card:hover .detail-overlay span { opacity: 1; transform: translateY(0); }

    /* 信息区 */
    .card-body {
      padding: 16px 18px;
      flex: 1;
      display: flex;
      flex-direction: column;
    }

    .product-name {
      font-size: 16px;
      font-weight: 700;
      color: var(--text);
      margin-bottom: 6px;
      line-height: 1.4;
    }

    .product-desc {
      font-size: 13px;
      color: var(--text-muted);
      line-height: 1.5;
      flex: 1;
      margin-bottom: 12px;
      /* 最多显示2行 */
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    .card-footer {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 10px;
    }

    .product-price {
      font-size: 22px;
      color: var(--danger);
      font-weight: 800;
      line-height: 1;
    }

    .price-unit { font-size: 14px; font-weight: 500; }

    /* 加入购物车区域 */
    .cart-action {
      display: flex;
      align-items: center;
      gap: 6px;
    }

    .qty-input {
      width: 52px;
      padding: 7px 6px;
      border: 1.5px solid #e0d4f7;
      border-radius: 8px;
      text-align: center;
      font-size: 14px;
      outline: none;
      color: var(--text);
      background: var(--bg);
      transition: var(--transition);
    }

    .qty-input:focus { border-color: var(--primary); }

    .btn-add {
      background: linear-gradient(135deg, var(--primary), #9b6dff);
      color: #fff;
      border: none;
      padding: 8px 14px;
      border-radius: 10px;
      font-size: 13px;
      font-weight: 600;
      cursor: pointer;
      transition: var(--transition);
      white-space: nowrap;
    }

    .btn-add:hover {
      transform: scale(1.04);
      box-shadow: 0 4px 12px rgba(124,92,191,0.4);
    }

    .btn-add:active { transform: scale(0.97); }

    /* ===== 空状态 ===== */
    .empty-state {
      text-align: center;
      padding: 80px 20px;
      color: var(--text-muted);
    }

    .empty-state .icon { font-size: 64px; margin-bottom: 16px; }
    .empty-state p { font-size: 16px; margin-bottom: 20px; }

    .btn-link {
      display: inline-block;
      background: var(--primary);
      color: #fff;
      padding: 10px 28px;
      border-radius: 24px;
      text-decoration: none;
      font-size: 14px;
      font-weight: 600;
      transition: var(--transition);
    }

    .btn-link:hover { background: var(--primary-dark); }

    /* ===== Toast提示 ===== */
    #toast {
      position: fixed;
      bottom: 32px;
      left: 50%;
      transform: translateX(-50%) translateY(20px);
      background: #333;
      color: #fff;
      padding: 12px 24px;
      border-radius: 28px;
      font-size: 14px;
      opacity: 0;
      transition: all 0.35s ease;
      z-index: 9999;
      pointer-events: none;
      box-shadow: 0 4px 20px rgba(0,0,0,0.2);
    }

    #toast.show {
      opacity: 1;
      transform: translateX(-50%) translateY(0);
    }

    #toast.success { background: var(--success); }
    #toast.error   { background: var(--danger); }
  </style>
</head>
<body>

<%-- ===== 顶部导航 ===== --%>
<div class="header">
  <div class="logo">🍰 蛋糕商城</div>
  <nav class="nav">
    <a href="${pageContext.request.contextPath}/product/list" class="active">商品列表</a>
    <a href="${pageContext.request.contextPath}/cart/list">
      <span class="cart-badge">购物车</span>
    </a>
    <a href="${pageContext.request.contextPath}/user/orders">我的订单</a>
    <a href="${pageContext.request.contextPath}/user/center">个人中心</a>
    <a href="${pageContext.request.contextPath}/user/logout">退出</a>
  </nav>
</div>

<%-- ===== 搜索区 ===== --%>
<div class="search-bar">
  <form action="${pageContext.request.contextPath}/product/list" method="get" class="search-inner">
    <div class="search-input-wrap">
      <span class="search-icon">🔍</span>
      <input type="text" name="keyword" placeholder="搜索蛋糕名称或描述..."
             value="${param.keyword}">
    </div>
    <button type="submit" class="btn-search">搜 索</button>
    <c:if test="${not empty param.keyword}">
      <a href="${pageContext.request.contextPath}/product/list" class="btn-reset">清除</a>
    </c:if>
  </form>
</div>

<%-- ===== 排序标签 ===== --%>
<div class="sort-tags">
  <span class="sort-label">排序：</span>
  <a href="${pageContext.request.contextPath}/product/list?keyword=${param.keyword}&sort=price_asc"
     class="sort-tag ${param.sort == 'price_asc' || empty param.sort ? 'active' : ''}">价格升序</a>
  <a href="${pageContext.request.contextPath}/product/list?keyword=${param.keyword}&sort=price_desc"
     class="sort-tag ${param.sort == 'price_desc' ? 'active' : ''}">价格降序</a>
  <a href="${pageContext.request.contextPath}/product/list?keyword=${param.keyword}&sort=newest"
     class="sort-tag ${param.sort == 'newest' ? 'active' : ''}">最新上架</a>
</div>

<%-- ===== 结果统计 ===== --%>
<div class="result-info">
  共找到 <em>${fn:length(productList)}</em> 款蛋糕
  <c:if test="${not empty param.keyword}">，关键词：「${param.keyword}」</c:if>
</div>

<%-- ===== 商品网格 ===== --%>
<div class="container">
  <c:choose>
    <c:when test="${empty productList}">
      <div class="empty-state">
        <div class="icon">🍰</div>
        <p>没有找到相关蛋糕，换个关键词试试~</p>
        <a href="${pageContext.request.contextPath}/product/list" class="btn-link">查看全部</a>
      </div>
    </c:when>
    <c:otherwise>
      <div class="product-grid">
        <c:forEach items="${productList}" var="product">
          <div class="product-card">
            <%-- 图片区 --%>
            <div class="card-img-wrap">
              <img src="${pageContext.request.contextPath}${product.image}"
                   alt="${product.name}"
                   class="product-image"
                   onerror="this.src='${pageContext.request.contextPath}/images/default-cake.jpg'">
              <%-- 库存角标 --%>
              <c:choose>
                <c:when test="${product.stock <= 10}">
                  <span class="stock-badge low">仅剩 ${product.stock} 件</span>
                </c:when>
                <c:otherwise>
                  <span class="stock-badge">库存 ${product.stock}</span>
                </c:otherwise>
              </c:choose>
              <%-- 查看详情遮罩 --%>
              <a href="${pageContext.request.contextPath}/product/detail/${product.id}"
                 class="detail-overlay">
                <span>查看详情</span>
              </a>
            </div>

            <%-- 信息区 --%>
            <div class="card-body">
              <div class="product-name">${product.name}</div>
              <div class="product-desc">${product.description}</div>

              <div class="card-footer">
                <div class="product-price">
                  <span class="price-unit">¥</span><fmt:formatNumber value="${product.price}" pattern="#,##0.00"/>
                </div>
                <%-- 加入购物车 --%>
                <form action="${pageContext.request.contextPath}/cart/add" method="post"
                      class="cart-action" onsubmit="handleAddCart(event, '${product.name}')">
                  <input type="hidden" name="productId" value="${product.id}">
                  <input type="number" name="quantity" value="1" min="1"
                         max="${product.stock}" class="qty-input">
                  <button type="submit" class="btn-add">🛒 加购</button>
                </form>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<%-- ===== Toast提示层 ===== --%>
<div id="toast"></div>

<script>
  /**
   * 拦截加购表单，提交后弹出 Toast 提示
   * 实际跳转由服务端 redirect 完成，此处先显示提示再跳转
   */
  function handleAddCart(event, name) {
    // 不阻止提交，只在跳转前显示 toast
    showToast('已将「' + name + '」加入购物车 🎉', 'success');
  }

  /**
   * 显示底部 Toast 通知
   * @param {string} msg  - 提示内容
   * @param {string} type - 'success' | 'error' | ''
   * @param {number} duration - 显示毫秒数
   */
  function showToast(msg, type, duration) {
    duration = duration || 2000;
    var t = document.getElementById('toast');
    t.textContent = msg;
    t.className = 'show' + (type ? ' ' + type : '');
    setTimeout(function() { t.className = ''; }, duration);
  }

  // 检测URL中是否携带加购成功标志（从购物车重定向回来时可用）
  if (location.search.indexOf('added=1') !== -1) {
    showToast('商品已成功加入购物车 ✅', 'success');
  }
</script>

<%-- 需要引入 JSTL fn 标签以使用 fn:length --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
</body>
</html>
