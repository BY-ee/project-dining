<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" href="/css/signup.css">
</head>
<body>

<main class="main">
    <div class="container">
        <section class="wrapper">
            <div class="heading">
                <h1 class="text text-large">회원가입</h1>
                <p class="text text-normal">이미 회원이신가요? <a href="/login" class="text text-links">로그인</a></p>
            </div>
            <form name="signup" class="form" action="/signup" method="post">
                <div class="input-control">
                    <label for="username" class="input-label" hidden>Username</label>
                    <input type="text" name="username" id="username" class="input-field" placeholder="사용자 이름">
                </div>
                <div class="input-control">
                    <label for="email" class="input-label" hidden>Email</label>
                    <input type="email" name="email" id="email" class="input-field" placeholder="이메일 주소">
                </div>
                <div class="input-control">
                    <label for="password" class="input-label" hidden>Password</label>
                    <input type="password" name="password" id="password" class="input-field" placeholder="비밀번호">
                </div>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <div class="input-control">
                    <input type="submit" name="submit" class="input-submit" value="회원가입">
                </div>
            </form>
        </section>
    </div>
</main>

</body>
</html>