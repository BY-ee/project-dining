<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>
  <link rel="stylesheet" href="/css/login/yunyoung.css">
</head>
<body>
<div class="login-container">
    
 
    <a href="/signUp.do" class="no-underline" > 
    	<button type="button"  class="gosignup-button">회원가입 </button>
    </a>

    
  <div class="login-header">
    <h1 class="login-logo">Login</h1>
  </div>
  
  <form class="login-form" method="post" action="login_ok.do">
    <input type="text" placeholder="아이디" id="userid" name="userid">
    <input type="password" placeholder="비밀번호" id="userpwd" name="userpwd">
    <button type="submit" >로그인</button>


	<div>
	  <a href="/oauth2/authorization/naver">
	    <img src="/images/naver_button.png" alt="네이버 간편 로그인" class="naver-login-btn">
	  </a>
	</div>
	


    <br>
    <a href="findPwd.do" class="forgot-password">비밀번호 찾기</a>
  </form>

</div>
</body>
</html>