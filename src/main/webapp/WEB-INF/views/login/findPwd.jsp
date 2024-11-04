<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>비밀번호 찾기</title>
  <link rel="stylesheet" href="css/login/yunyoung.css">
</head>
<body>
<div class="findpwd-form-container">
    
  <div class="findpwd-header">
    <h1 class="findpwd-logo">비밀번호 찾기</h1>
  </div>
 
 <div class="findpwd-form">
  	<p class="instruction-text"> 찾고자 하는 아이디와 비밀번호를 받을 이메일 주소를 입력하세요. </p>

 	<input type="text" placeholder="아이디" id="loginId" name= "id">
 </div>
 
 
<div class="email-form">
  <input type="text" placeholder="이메일" class="email-input">
  <span class="domain-symbol">@</span>
  <select class="email-select">
    <option value="naver.com">naver.com</option>
    <option value="kakao.com">kakao.com</option>
    <option value="gmail.com">gmail.com</option>
    <option value="custom">직접 입력</option>
  </select>
</div>
    <button type="submit" class="signcomplete">비밀번호 찾기</button>


</div>
</body>
</html>
