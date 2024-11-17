<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/templates/head.jsp" %> <!-- head -->

<head>
  <title>비밀번호 재설정</title>
  <link rel="stylesheet" href="css/login/loginCommon.css">
  <script src="js/login/join.js"></script> 
</head>
<body>


<input type="hidden" id="memberId" value="${memberId}">
  
<div class="findpwd-form-container">
   
<h1 class="findpwd-logo">비밀번호 재설정</h1>
    
    
    <div class="passwd-form">
      <input type="password" placeholder="비밀번호" id="passwd" name="passwd" required>
      <input type="password" placeholder="비밀번호 확인" id="passwdCheck" name="passwdCheck" required>
      <div id="passwd-check-result" class="check-result"></div> 
    </div> 

    <input type="button" class="signcomplete" id="updatePwd-btn" value="비밀번호 재설정">
  </div>


</body>
</html>
