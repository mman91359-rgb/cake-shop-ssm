<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>注册 - 蛋糕商城</title>
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
      background: linear-gradient(135deg, #f093fb 0%, #7c5cbf 50%, #4d96ff 100%);
      display: flex; align-items: center; justify-content: center;
      position: relative; overflow: hidden; padding: 24px 0;
    }
    body::before {
      content: ''; position: absolute; border-radius: 50%;
      width: 480px; height: 480px; top: -120px; left: -100px;
      background: rgba(255,255,255,0.07);
    }

    .register-card {
      background: rgba(255,255,255,0.97);
      border-radius: var(--radius);
      box-shadow: 0 20px 60px rgba(0,0,0,0.2);
      padding: 44px 44px 36px;
      width: 460px; max-width: 94vw;
      position: relative; z-index: 1;
      animation: slideUp 0.5s cubic-bezier(.4,0,.2,1);
    }
    @keyframes slideUp {
      from { opacity: 0; transform: translateY(24px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    .brand { text-align: center; margin-bottom: 26px; }
    .brand-icon { font-size: 42px; }
    .brand-name { font-size: 20px; font-weight: 800; color: var(--primary); margin-top: 6px; }

    /* 进度条（视觉装饰） */
    .progress-bar {
      height: 4px; background: #e0d4f7; border-radius: 4px; margin-bottom: 24px; overflow: hidden;
    }
    .progress-fill {
      height: 100%; background: linear-gradient(90deg, var(--primary), #9b6dff);
      border-radius: 4px; width: 0%;
      transition: width 0.4s ease;
    }

    /* 错误 */
    .alert {
      background: #fff5f5; border: 1px solid #fed7d7;
      color: var(--danger); border-radius: 10px; padding: 10px 14px;
      font-size: 13px; margin-bottom: 16px;
      display: flex; align-items: center; gap: 7px;
    }

    /* 表单行 */
    .form-row { display: flex; gap: 12px; }
    .form-row .form-group { flex: 1; }

    .form-group { margin-bottom: 14px; }
    .form-group label {
      display: block; font-size: 13px; font-weight: 600;
      color: var(--text); margin-bottom: 6px;
    }
    .form-group label .opt { color: var(--text-muted); font-weight: 400; font-size: 11px; margin-left: 4px; }

    .input-wrap { position: relative; }
    .input-icon {
      position: absolute; left: 13px; top: 50%; transform: translateY(-50%);
      font-size: 15px; color: var(--text-muted);
    }
    .form-group input {
      width: 100%; padding: 11px 13px 11px 38px;
      border: 1.5px solid #e0d4f7; border-radius: 10px;
      font-size: 14px; color: var(--text); outline: none;
      transition: var(--transition); background: #faf8ff;
    }
    .form-group input:focus {
      border-color: var(--primary); background: #fff;
      box-shadow: 0 0 0 3px rgba(124,92,191,0.1);
    }
    /* 校验状态 */
    .form-group input.valid   { border-color: var(--success); }
    .form-group input.invalid { border-color: var(--danger); }
    .field-hint { font-size: 11px; margin-top: 4px; min-height: 16px; }
    .field-hint.ok  { color: var(--success); }
    .field-hint.err { color: var(--danger); }

    /* 密码强度 */
    .pwd-strength { margin-top: 6px; display: flex; gap: 4px; }
    .strength-bar {
      flex: 1; height: 3px; border-radius: 3px;
      background: #e0d4f7; transition: var(--transition);
    }
    .strength-bar.active-weak   { background: var(--danger); }
    .strength-bar.active-mid    { background: var(--warn, #dd6b20); }
    .strength-bar.active-strong { background: var(--success); }

    /* 协议 */
    .agree-row {
      display: flex; align-items: flex-start; gap: 8px;
      font-size: 13px; color: var(--text-muted); margin-bottom: 18px;
      line-height: 1.5;
    }
    .agree-row input { margin-top: 2px; flex-shrink: 0; }
    .agree-row a { color: var(--primary); text-decoration: none; }
    .agree-row a:hover { text-decoration: underline; }

    .btn-register {
      width: 100%; padding: 13px 0;
      background: linear-gradient(135deg, var(--primary), #9b6dff);
      color: #fff; border: none; border-radius: 12px;
      font-size: 16px; font-weight: 700; cursor: pointer;
      transition: var(--transition);
    }
    .btn-register:hover { transform: translateY(-2px); box-shadow: 0 8px 24px rgba(124,92,191,0.45); }
    .btn-register:disabled { background: #ccc; cursor: not-allowed; transform: none; box-shadow: none; }

    .login-tip { text-align: center; margin-top: 16px; font-size: 14px; color: var(--text-muted); }
    .login-tip a { color: var(--primary); font-weight: 700; text-decoration: none; }
    .login-tip a:hover { text-decoration: underline; }
  </style>
</head>
<body>

<div class="register-card">
  <div class="brand">
    <div class="brand-icon">🍰</div>
    <div class="brand-name">创建新账号</div>
  </div>

  <%-- 表单填写进度条 --%>
  <div class="progress-bar"><div class="progress-fill" id="progressFill"></div></div>

  <c:if test="${not empty message}">
    <div class="alert">⚠️ ${message}</div>
  </c:if>

  <form action="${pageContext.request.contextPath}/user/register" method="post"
        id="regForm" onsubmit="return validateReg()">

    <%-- 用户名 + 昵称 --%>
    <div class="form-row">
      <div class="form-group">
        <label>用户名 <span style="color:#e53e3e;">*</span></label>
        <div class="input-wrap">
          <span class="input-icon">👤</span>
          <input type="text" name="username" id="username" placeholder="4-20位字符"
                 required oninput="checkUsername()" autocomplete="username">
        </div>
        <div class="field-hint" id="hint-username"></div>
      </div>
      <div class="form-group">
        <label>昵称 <span class="opt">选填</span></label>
        <div class="input-wrap">
          <span class="input-icon">😊</span>
          <input type="text" name="nickname" placeholder="显示给别人的名字">
        </div>
      </div>
    </div>

    <%-- 密码 --%>
    <div class="form-group">
      <label>密码 <span style="color:#e53e3e;">*</span></label>
      <div class="input-wrap">
        <span class="input-icon">🔒</span>
        <input type="password" name="password" id="password" placeholder="至少6位"
               required oninput="checkPwd()">
      </div>
      <div class="pwd-strength">
        <div class="strength-bar" id="bar1"></div>
        <div class="strength-bar" id="bar2"></div>
        <div class="strength-bar" id="bar3"></div>
      </div>
      <div class="field-hint" id="hint-pwd"></div>
    </div>

    <%-- 手机号 + 地址 --%>
    <div class="form-group">
      <label>手机号 <span class="opt">选填</span></label>
      <div class="input-wrap">
        <span class="input-icon">📱</span>
        <input type="tel" name="phone" id="phone" placeholder="11位手机号" oninput="checkPhone()">
      </div>
      <div class="field-hint" id="hint-phone"></div>
    </div>

    <div class="form-group">
      <label>收货地址 <span class="opt">选填</span></label>
      <div class="input-wrap">
        <span class="input-icon">📍</span>
        <input type="text" name="address" placeholder="省 / 市 / 区 / 详细地址">
      </div>
    </div>

    <%-- 用户协议 --%>
    <div class="agree-row">
      <input type="checkbox" id="agree">
      <label for="agree">我已阅读并同意
        <a href="#">《用户服务协议》</a>和<a href="#">《隐私政策》</a>
      </label>
    </div>

    <button type="submit" class="btn-register" id="regBtn" disabled>注 册</button>
  </form>

  <div class="login-tip">已有账号？<a href="${pageContext.request.contextPath}/user/login">立即登录 →</a></div>
</div>

<script>
  var filled = { username: false, password: false };

  /** 动态更新进度条（已填必填项比例） */
  function updateProgress() {
    var count = Object.values(filled).filter(Boolean).length;
    document.getElementById('progressFill').style.width = (count / 2 * 100) + '%';
    // 协议勾选后才启用注册按钮
    document.getElementById('regBtn').disabled =
      !(filled.username && filled.password && document.getElementById('agree').checked);
  }

  document.getElementById('agree').addEventListener('change', updateProgress);

  /** 用户名校验 */
  function checkUsername() {
    var val  = document.getElementById('username').value.trim();
    var hint = document.getElementById('hint-username');
    var inp  = document.getElementById('username');
    if (val.length >= 4 && val.length <= 20) {
      hint.textContent = '✓ 格式正确'; hint.className = 'field-hint ok';
      inp.className = 'valid'; filled.username = true;
    } else {
      hint.textContent = val.length > 0 ? '用户名需4-20位' : '';
      hint.className = 'field-hint err';
      inp.className = val.length > 0 ? 'invalid' : '';
      filled.username = false;
    }
    updateProgress();
  }

  /** 密码强度检测 */
  function checkPwd() {
    var val = document.getElementById('password').value;
    var score = 0;
    if (val.length >= 6)                          score++;
    if (/[A-Z]/.test(val) || /[0-9]/.test(val))  score++;
    if (/[^a-zA-Z0-9]/.test(val) && val.length >= 8) score++;

    var labels = ['弱', '中', '强'];
    var classes = ['active-weak','active-mid','active-strong'];
    var colors  = ['err','','ok'];
    for (var i = 1; i <= 3; i++) {
      var bar = document.getElementById('bar' + i);
      bar.className = 'strength-bar' + (i <= score ? ' ' + classes[score-1] : '');
    }
    var hint = document.getElementById('hint-pwd');
    if (val.length === 0) { hint.textContent = ''; filled.password = false; }
    else if (val.length < 6) { hint.textContent = '密码至少6位'; hint.className = 'field-hint err'; filled.password = false; }
    else { hint.textContent = '密码强度：' + labels[score-1]; hint.className = 'field-hint ' + colors[score-1]; filled.password = true; }
    updateProgress();
  }

  /** 手机号格式校验 */
  function checkPhone() {
    var val  = document.getElementById('phone').value.trim();
    var hint = document.getElementById('hint-phone');
    if (val.length === 0) { hint.textContent = ''; return; }
    if (/^1[3-9]\d{9}$/.test(val)) {
      hint.textContent = '✓ 手机号格式正确'; hint.className = 'field-hint ok';
    } else {
      hint.textContent = '请输入正确的11位手机号'; hint.className = 'field-hint err';
    }
  }

  /** 提交前最终校验 */
  function validateReg() {
    if (!document.getElementById('agree').checked) {
      alert('请阅读并同意用户协议'); return false;
    }
    var phone = document.getElementById('phone').value.trim();
    if (phone && !/^1[3-9]\d{9}$/.test(phone)) {
      alert('请输入正确的手机号'); return false;
    }
    return true;
  }
</script>
</body>
</html>
