<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>登录 - 蛋糕商城</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }
    :root {
      --primary: #7c5cbf; --primary-dark: #5e3f9e;
      --text: #2d2d2d; --text-muted: #888;
      --danger: #e53e3e; --success: #38a169;
      --radius: 16px; --transition: 0.25s cubic-bezier(.4,0,.2,1);
    }

    body {
      font-family: 'Segoe UI','PingFang SC','Microsoft YaHei',sans-serif;
      min-height: 100vh;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
      display: flex; align-items: center; justify-content: center;
      position: relative; overflow: hidden;
    }

    /* 背景装饰圆 */
    body::before, body::after {
      content: ''; position: absolute; border-radius: 50%;
      background: rgba(255,255,255,0.08);
    }
    body::before { width: 500px; height: 500px; top: -150px; right: -100px; }
    body::after  { width: 350px; height: 350px; bottom: -100px; left: -80px; }

    /* 登录卡片 */
    .login-card {
      background: rgba(255,255,255,0.97);
      border-radius: var(--radius);
      box-shadow: 0 20px 60px rgba(0,0,0,0.2);
      padding: 48px 44px;
      width: 420px; max-width: 94vw;
      position: relative; z-index: 1;
      animation: slideUp 0.5s cubic-bezier(.4,0,.2,1);
    }
    @keyframes slideUp {
      from { opacity: 0; transform: translateY(24px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    /* LOGO区 */
    .brand {
      text-align: center; margin-bottom: 30px;
    }
    .brand-icon { font-size: 48px; line-height: 1; }
    .brand-name { font-size: 22px; font-weight: 800; color: var(--primary); margin-top: 8px; }
    .brand-sub  { font-size: 13px; color: var(--text-muted); margin-top: 4px; }

    /* 错误提示 */
    .alert {
      background: #fff5f5; border: 1px solid #fed7d7;
      color: var(--danger); border-radius: 10px; padding: 10px 14px;
      font-size: 13px; margin-bottom: 18px;
      display: flex; align-items: center; gap: 7px;
      animation: shake 0.4s ease;
    }
    @keyframes shake {
      0%,100%{ transform:translateX(0); }
      25%    { transform:translateX(-6px); }
      75%    { transform:translateX(6px); }
    }

    /* 输入框组 */
    .form-group { margin-bottom: 18px; }
    .form-group label {
      display: block; font-size: 13px; font-weight: 600;
      color: var(--text); margin-bottom: 7px;
    }
    .input-wrap { position: relative; }
    .input-icon {
      position: absolute; left: 14px; top: 50%; transform: translateY(-50%);
      font-size: 16px; color: var(--text-muted);
    }
    .form-group input {
      width: 100%; padding: 12px 14px 12px 40px;
      border: 1.5px solid #e0d4f7; border-radius: 10px;
      font-size: 15px; color: var(--text); outline: none;
      transition: var(--transition); background: #faf8ff;
    }
    .form-group input:focus {
      border-color: var(--primary);
      background: #fff;
      box-shadow: 0 0 0 3px rgba(124,92,191,0.1);
    }

    /* 显示密码 */
    .toggle-pw {
      position: absolute; right: 14px; top: 50%; transform: translateY(-50%);
      cursor: pointer; color: var(--text-muted); font-size: 15px; user-select: none;
    }

    /* 记住我 */
    .remember-row {
      display: flex; justify-content: space-between; align-items: center;
      font-size: 13px; margin-bottom: 22px;
    }
    .remember-row label { display: flex; align-items: center; gap: 6px; cursor: pointer; color: var(--text-muted); }
    .remember-row a { color: var(--primary); text-decoration: none; }
    .remember-row a:hover { text-decoration: underline; }

    /* 登录按钮 */
    .btn-login {
      width: 100%; padding: 14px 0;
      background: linear-gradient(135deg, var(--primary), #9b6dff);
      color: #fff; border: none; border-radius: 12px;
      font-size: 16px; font-weight: 700; cursor: pointer;
      transition: var(--transition);
    }
    .btn-login:hover { transform: translateY(-2px); box-shadow: 0 8px 24px rgba(124,92,191,0.45); }
    .btn-login:active { transform: scale(0.98); }

    /* 分割线 */
    .divider {
      display: flex; align-items: center; gap: 12px;
      margin: 22px 0; color: var(--text-muted); font-size: 13px;
    }
    .divider::before, .divider::after { content: ''; flex: 1; height: 1px; background: #e0d4f7; }

    /* 注册链接 */
    .register-tip { text-align: center; font-size: 14px; color: var(--text-muted); }
    .register-tip a { color: var(--primary); font-weight: 700; text-decoration: none; }
    .register-tip a:hover { text-decoration: underline; }

    /* 演示账号提示 */
    .demo-tip {
      margin-top: 20px; background: linear-gradient(135deg,#f3e8ff,#fce7f3);
      border-radius: 10px; padding: 12px 16px; font-size: 12px; color: var(--text-muted);
    }
    .demo-tip strong { color: var(--primary); }
    .demo-row { display: flex; gap: 16px; margin-top: 6px; flex-wrap: wrap; }
    .demo-item { cursor: pointer; color: var(--primary); font-weight: 600; }
    .demo-item:hover { text-decoration: underline; }
  </style>
</head>
<body>

<div class="login-card">
  <div class="brand">
    <div class="brand-icon">🍰</div>
    <div class="brand-name">蛋糕商城</div>
    <div class="brand-sub">甜蜜每一刻，从这里开始</div>
  </div>

  <%-- 错误提示 --%>
  <c:if test="${not empty message}">
    <div class="alert">⚠️ ${message}</div>
  </c:if>

  <form action="${pageContext.request.contextPath}/user/login" method="post" id="loginForm">
    <div class="form-group">
      <label>用户名</label>
      <div class="input-wrap">
        <span class="input-icon">👤</span>
        <input type="text" name="username" id="username"
               placeholder="请输入用户名" required autocomplete="username">
      </div>
    </div>

    <div class="form-group">
      <label>密码</label>
      <div class="input-wrap">
        <span class="input-icon">🔒</span>
        <input type="password" name="password" id="password"
               placeholder="请输入密码" required autocomplete="current-password">
        <span class="toggle-pw" id="togglePw" onclick="togglePassword()">👁</span>
      </div>
    </div>

    <div class="remember-row">
      <label><input type="checkbox"> 记住我</label>
    </div>

    <button type="submit" class="btn-login">登 录</button>
  </form>

  <div class="divider">还没有账号？</div>
  <div class="register-tip">
    <a href="${pageContext.request.contextPath}/user/register">立即注册，享受专属优惠 →</a>
  </div>

  <%-- 演示账号一键填入 --%>
  <div class="demo-tip">
    <strong>演示账号（点击快速填入）：</strong>
    <div class="demo-row">
      <span class="demo-item" onclick="fillDemo('lishuai','123456')">李帅 / 余额¥1000</span>
      <span class="demo-item" onclick="fillDemo('lichun','123456')">李春 / 余额¥500</span>
      <span class="demo-item" onclick="fillDemo('lizikang','123456')">李梓康 / 余额¥200</span>
    </div>
  </div>
</div>

<script>
  /** 一键填入演示账号 */
  function fillDemo(user, pwd) {
    document.getElementById('username').value = user;
    document.getElementById('password').value = pwd;
  }

  /** 切换密码可见性 */
  function togglePassword() {
    var pw  = document.getElementById('password');
    var btn = document.getElementById('togglePw');
    if (pw.type === 'password') {
      pw.type = 'text';  btn.textContent = '🙈';
    } else {
      pw.type = 'password'; btn.textContent = '👁';
    }
  }
</script>
</body>
</html>
