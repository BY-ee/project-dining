<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/templates/head.jsp" %> <!-- head -->

<head>
  <title>비밀번호 찾기</title>
  <link rel="stylesheet" href="css/login/loginCommon.css">
</head>

    <script src="js/login/join.js"></script> 
    
<body>
<div class="findpwd-form-container">
  <div class="findpwd-header">
    <h1 class="findpwd-logo">비밀번호 찾기</h1>
  </div>

 <div class="findpwd-form">
  	<p class="instruction-text"> 찾고자 하는 아이디와 비밀번호를 받을 이메일 주소를 입력하세요. </p>

 	<input type="text" placeholder="아이디" id="memberId" name= "memberId">
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

</div>
    <input type="button" class="signcomplete" id="findPwd-btn" value="비밀번호 찾기">
    <input type="button" class="signcomplete" value="로그인 화면으로 돌아가기" 
    onClick = "location.href = '/login' ">
</div>


</body>
</html>
