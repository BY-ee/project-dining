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

  <!-- 전체 회원가입 폼을 감싸는 form 태그 추가 -->
  <form action="/register" method="POST">

    <div class="id-form">
      <input type="text" placeholder="아이디" id="loginId" name="userid" required>
      <input type="button" value="아이디중복검사" onclick="checkDuplicateId()">
    </div>

    <div class="id-form">
      <input type="text" placeholder="닉네임" id="nickname" name="nickname" required>
      <input type="button" value="닉네임중복검사" onclick="checkDuplicateNickname()">
    </div> 

    <div class="passwd-form">
      <input type="password" placeholder="비밀번호" name="userpwd" required>
    </div>

    <div class="email-form">
      <input type="text" placeholder="이메일" class="email-input" name="email" required>
      <span class="domain-symbol">@</span>
      <select class="email-select" name="emailDomain">
        <option value="naver.com">naver.com</option>
        <option value="kakao.com">kakao.com</option>
        <option value="gmail.com">gmail.com</option>
        <option value="custom">직접 입력</option>
      </select>
    </div>

    <button type="submit" class="signcomplete">회원가입</button>

  </form>
</div>

<script>
  // 아이디 중복 검사 함수
  function checkDuplicateId() {
    const id = document.getElementById('loginId').value;
    // 서버로 아이디 중복 검사 요청을 보낼 코드 작성
    alert("아이디 중복 검사를 수행합니다.");
  }

  // 닉네임 중복 검사 함수
  function checkDuplicateNickname() {
    const nickname = document.getElementById('nickname').value;
    // 서버로 닉네임 중복 검사 요청을 보낼 코드 작성
    alert("닉네임 중복 검사를 수행합니다.");
  }
</script>

</body>
</html>