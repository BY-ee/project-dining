<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>
  <link rel="stylesheet" href="css/login/yunyoung.css">

</head>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="js/login/join.js"></script> 
    
<body>
<form>
<div class="memberform-container">
    
  <div class="memberform-header">
    <h1 class="memberform-logo">일반회원가입</h1>
  </div>
 <div class="id-form">
 	<input type="text" placeholder="아이디" id="loginId" name= "id">
 	<input type="button" value="아이디중복검사">
 </div>


 <div class="id-form">
 	<input type="text" placeholder="닉네임" id="loginPwd" name= "pwd">
 	<input type="button" value="닉네임중복검사">
 </div> 
  
 <div class="passwd-form">
    <input type="password" placeholder="비밀번호">
    <input type="password" placeholder="비밀번호 확인">
 </div> 
  


<div class="email-form">

  <input type="text" placeholder="이메일" class="email-input" id="mailid" name="mailid">
  <span class="domain-symbol">@</span>
  <input type="text" placeholder="도메인" class="email-input" id="domain" name="domain">

  <select class="email-select" id="email">
    <option value="">직접 입력</option>
    <option value="naver.com">네이버</option>
    <option value="kakao.com">카카오</option>
    <option value="gmail.com">구글</option>
  </select>


    <!-- 인증하기 버튼 -->
    <button type="button"  id="verifyButton"  >인증</button>
      </div>   
    
    <!-- 인증 입력 필드와 확인 버튼이 나타날 위치 -->
    <div id="verification-input-container" class="verification-container"></div> 
    <!-- 회원가입 버튼 -->
    <button type="submit" class="signcomplete">회원가입</button>
  </div>
</form>

</body>
</html>
