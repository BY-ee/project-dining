<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원가입</title>
  <link rel="stylesheet" href="css/login/yunyoung.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="js/login/join.js"></script> 
</head>
<body>
<div class="memberform-container">
    
  <div class="memberform-header">
    <h1 class="memberform-logo">일반회원가입</h1>
  </div>

  <!-- 회원가입 폼 -->
  <form action="/register" method="POST">
    <input type="hidden" name="category" value="일반">
    <input type="hidden" name="email">

    <div class="id-form">
      <input type="text" placeholder="아이디" id="member_id" name="member_id" required>
      <input type="button" value="아이디 중복 검사" onclick="checkDuplicateId()">
    </div>

    <div class="id-form">
      <input type="text" placeholder="닉네임" id="nickname" name="nickname" required>
      <input type="button" value="닉네임 중복 검사" onclick="checkDuplicateNickname()">
    </div> 

    <div class="passwd-form">
      <input type="password" placeholder="비밀번호" name="passwd" required>
      <input type="password" placeholder="비밀번호 확인" name="confirm_passwd" required>
    </div>

    <div class="email-form">
      <input type="text" placeholder="이메일" class="email-input" id="mailid" name="mailid" required>
      <span class="domain-symbol">@</span>
      <input type="text" placeholder="도메인" class="email-input" id="domain" name="domain">
      
      <select class="email-select" id="email">
        <option value="">직접 입력</option>
        <option value="naver.com">네이버</option>
        <option value="kakao.com">카카오</option>
        <option value="gmail.com">구글</option>
      </select>
      
      <button type="button" id="verifyButton">인증</button>
    </div>

    <!-- 인증 관련 입력과 메시지 -->
    <div id="verification-input-container" class="verification-container"></div>
    <div id="verificationMessage" class="verification-message"></div>

    <button type="submit" class="signcomplete">회원가입</button>
  </form>
</div>

<!-- JavaScript 코드 -->
<script>
  // 아이디 중복 검사 함수
  function checkDuplicateId() {
    const id = document.getElementById('member_id').value;
    alert("아이디 중복 검사를 수행합니다.");
  }

  // 닉네임 중복 검사 함수
  function checkDuplicateNickname() {
    const nickname = document.getElementById('nickname').value;
    alert("닉네임 중복 검사를 수행합니다.");
  }

  // 폼 제출 시 이메일을 합치는 함수
  document.querySelector('form').addEventListener('submit', function (event) {
    const emailInput = document.querySelector('.email-input').value.trim();
    let emailDomain = document.querySelector('.email-select').value;

    if (emailDomain === '') {
      emailDomain = document.getElementById('domain').value.trim();
    }

    const fullEmail = emailInput + '@' + emailDomain;
    document.querySelector('input[name="email"]').value = fullEmail;

    console.log("Email to be submitted:", fullEmail);
  });
</script>

</body>
</html>