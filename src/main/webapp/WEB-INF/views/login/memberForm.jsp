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
<body>
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
  
  <form class="passwd-form">
    <input type="password" placeholder="비밀번호">
    <input type="password" placeholder="비밀번호 확인">
  </form>

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
    <button type="submit" class="signcomplete">회원가입</button>


</div>
</body>
</html>
