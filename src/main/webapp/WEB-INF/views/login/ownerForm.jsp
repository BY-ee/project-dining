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
<div class="ownerform-container">
    
  <div class="ownerform-header">
    <h1 class="owner-logo">사업자회원가입</h1>
  </div>
<form method="post" action="/joinMember">
<input type="hidden" name="category" value="사업자">
<input type="hidden" name="email" id="email">
<input type="hidden" name="registrationNumber" id="registrationNumber">
<div class="owner-num">
	<input type="text" placeholder="사업자" id="ownerCode1">
    <span class="owner-symbol" >-</span>
	<input type="text" placeholder="번호" id="ownerCode2" >
	<span class="owner-symbol" >-</span>
	<input type="text" placeholder="입력" id="ownerCode3">
	<input type="button" value="사업자번호 인증"  id="ownerValidation">
</div>
<div id="validationMessage" class="instruction-text"></div>
 
  <div class="id-form">
 	<input type="text" placeholder="아이디" id="memberId" name= "memberId">
 	<input type="button" value="아이디중복검사" id="idCheck-btn">
 	<div id="id-check-result" class="check-result"></div> 
 </div>


 <div class="id-form">
 	<input type="text" placeholder="닉네임" id="nickname" name= "nickname">
 	<input type="button" value="닉네임중복검사" id="nicknameCheck-btn">
 	<div id="nickname-check-result" class="check-result"></div> 
 </div> 
  
 <div class="passwd-form">
    <input type="password" placeholder="비밀번호" id="passwd" name= "passwd">
    <input type="password" placeholder="비밀번호 확인" id="passwdCheck" name= "passwdCheck">
    <div id="passwd-check-result" class="check-result"></div> 
 </div> 
  
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



    <!-- 인증하기 버튼 -->
    <button type="button"  id="verifyButton"  >인증</button>
      </div>   
    
    <!-- 인증 입력 필드와 확인 버튼이 나타날 위치 -->
    <div id="verification-input-container" class="verification-container"></div> 
    <!-- 인증 완료 메시지를 표시할 빈 div -->
  	<div id="verificationMessage" class="verification-message"></div>
    <!-- 회원가입 버튼 -->
    <button type="submit" class="signcomplete" id="owner-signup-button" >회원가입</button>
    </div>
</form>
</body>
</html>
