<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>아이디 찾기</title>
  <link rel="stylesheet" href="css/login/loginCommon.css">
</head>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="js/login/join.js"></script> 
    
<body>
<div class="findpwd-form-container">
  <div class="findpwd-header">
    <h1 class="findpwd-logo">아이디 찾기</h1>
  </div>

 	<p class="instruction-text"> 회원가입 시 사용한 이메일을 입력해주세요 </p>

<div class="email-form">

  <input type="text" placeholder="이메일" class="email-input" id="mailid" name="mailid">
  <span class="domain-symbol">@</span>
  <input type="text" placeholder="도메인" class="email-input" id="domain" name="domain">

  <select class="email-select" id="emailSelect">
    <option value="">직접입력</option>
    <option value="naver.com">네이버</option>
    <option value="kakao.com">카카오</option>
    <option value="gmail.com">구글</option>
  </select>

</div>
    <input type="button" class="signcomplete" id="findId-btn" value="아이디 찾기">
    <input type="button" class="signcomplete" value="로그인 화면으로 돌아가기" 
    onClick = "location.href = '/loginForm.do' ">
</div>

</body>
</html>
