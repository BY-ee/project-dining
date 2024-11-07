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
    <input type="hidden" name="category" value="일반">
    <input type="hidden" name="email">

    <div class="id-form">
      <input type="text" placeholder="아이디" id="member_id" name="member_id" required>
      <input type="button" value="아이디중복검사" onclick="checkDuplicateId()">
    </div>

    <div class="id-form">
      <input type="text" placeholder="닉네임" id="nickname" name="nickname" required>
      <input type="button" value="닉네임중복검사" onclick="checkDuplicateNickname()">
    </div> 

    <div class="passwd-form">
      <input type="password" placeholder="비밀번호" name="passwd" required>
    </div>

    <div class="email-form">
      <input type="text" placeholder="이메일" class="email-input" required>
      <span class="domain-symbol">@</span>
      <select class="email-select">
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
    const id = document.getElementById('member_id').value;
    alert("아이디 중복 검사를 수행합니다.");
  }

  // 닉네임 중복 검사 함수
  function checkDuplicateNickname() {
    const nickname = document.getElementById('nickname').value;
    alert("닉네임 중복 검사를 수행합니다.");
  }
</script>

<script>
  // 폼 제출 시 이메일을 합치는 함수
  document.querySelector('form').addEventListener('submit', function (event) {
    const emailInput = document.querySelector('.email-input').value.trim();
    let emailDomain = document.querySelector('.email-select').value;

    // 사용자 직접 입력을 위한 로직 추가
    if (emailDomain === 'custom') {
      const customDomain = prompt("직접 입력할 도메인을 입력해주세요:");
      if (customDomain) {
        emailDomain = customDomain;
      } else {
        event.preventDefault();
        alert("도메인을 입력해주세요.");
        return;
      }
    }

    // emailInput과 emailDomain을 합쳐서 email 필드로 전송
	const fullEmail = emailInput + '@' + emailDomain;
    document.querySelector('input[name="email"]').value = fullEmail;

    // 디버깅용 로그 출력
    console.log("Email to be submitted:", fullEmail);
  });
</script>

</body>
</html>