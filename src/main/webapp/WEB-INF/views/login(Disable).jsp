<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Sign In</title>
    <link rel="stylesheet" href="/css/login.css">
</head>
<body>
<main class="main">
  <div class="container">
    <section class="wrapper">
      <div class="heading">
        <h1 class="text text-large">로그인</h1>
        <p class="text text-normal">
            회원이 아니신가요? <a href="/signup" class="text text-links">회원가입 하기</a>
        </p>
      </div>
      <form name="signin" class="form" action="/login" method="post">
        <div class="input-control">
          <label for="email" class="input-label" hidden>id</label>
          <input type="email" name="email" id="email" class="input-field" placeholder="input email" autocomplete="username">
        </div>
        <div class="input-control">
          <label for="password" class="input-label" hidden>password</label>
          <input type="password" name="password" id="password" class="input-field" placeholder="input password" autocomplete="current-password">
        </div>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <div class="input-control">
          <input type="submit" name="submit" class="input-submit" value="Sign In">
        </div>
      </form>
      <div class="striped">
        <span class="striped-line"></span>
        <span class="striped-text">Or</span>
        <span class="striped-line"></span>
      </div>
      <div class="method">
        <div class="method-control">
          <a href="/login-google" class="method-action">
            <i class="ion ion-logo-google"></i>
            <span>Google 간편 로그인</span>
          </a>
        </div>
        <div class="method-control">
          <a href="/login-facebook" class="method-action">
            <i class="ion ion-logo-facebook"></i>
            <span>Face Book 간편 로그인</span>
          </a>
        </div>
        <div class="method-control">
          <a href="/login-apple" class="method-action">
            <i class="ion ion-logo-apple"></i>
            <span>Apple 간편 로그인</span>
          </a>
        </div>
      </div>
    </section>
  </div>
</main>

알림 표시
<% if ("emailNotFound".equals(request.getAttribute("loginStatus"))) { %>
    <script>
        alert("이메일이 존재하지 않습니다.");
    </script>
<% } else if ("passwordIncorrect".equals(request.getAttribute("loginStatus"))) { %>
    <script>
        alert("비밀번호가 일치하지 않습니다.");
    </script>
<% } else if ("success".equals(request.getAttribute("loginStatus"))) { %>
    <script>
        alert("로그인에 성공했습니다!");
    </script>
<% } %>

</body>
</html> --%>