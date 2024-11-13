<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/mypage/myPageStyles.css">
<link rel="stylesheet" href="css/mypage/commonStyles.css">
</head>
<body>
	<!-- 상단바 -->
	<header class="navbar">
		<div class="navbar-left">
			<a class="navbar-logo">냐미</a>
		</div>
		<div class="navbar-right">
			<a href="#" class="icon">로그아웃</a> 
			<a href="/" class="icon">홈</a>
		</div>
	</header>
	<div class="container">
		<div class="content">
			<!-- 사이드바: 프로필 사진과 이름 표시 -->
			<div class="sidebar">
				<div class="profile-pic"
					onclick="document.getElementById('fileInput').click()">
					<span class="profile-overlay">프로필 변경</span>
				</div>
				<div class="profile-name">야미</div>
				<input type="file" id="fileInput" style="display: none">
				<div class="prifile-point">내 포인트 : 500p</div>
				<div class="profile-intro">안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.</div>
			</div>
			<!-- 메인 콘텐츠 부분 -->
			<div class="main-content">
				<!-- 탭 메뉴 -->
				<div class="tabs">
					<button class="tab" onclick="location.href='/mypage'">내 활동</button>
					<button class="tab" onclick="location.href='/profile'">프로필</button>
					<button class="tab" onclick="location.href='/accountSettings'">계정 정보</button>
				</div>
				<div class="expanded-content">
					<!-- 계정 정보 섹션 -->
					<div id="account-settings" class="section">
						<div class="email-info">
							<h3>이메일 정보</h3>
							<input type="email" value="abc123@gmail.com" readonly>
							<button class="email-verify-button">이메일 인증</button>
							<p>이메일 변경은 변경한 이메일로 인증 요청 메일이 발송되고 해당 이메일을 통해 인증을 정상적으로 완료한 후
								최종적으로 반영됩니다.</p>
						</div>
						<div class="social-connect">
							<h3>소셜계정 연동</h3>
							<p>사용하시는 소셜 및 인증 제공자들과 계정을 연동하고 손쉽게 로그인하세요.</p>
							<div class="social-connect-buttons">
								<a href="/oauth2/authorization/naver" onclick="setRedirectUrl('/myPage')"><img src="/images/naver_button.png" alt="네이버 간편 로그인" class="login-btn"></a> 
								<a href="/oauth2/authorization/kakao" onclick="setRedirectUrl('/myPage')"><img src="/images/카카오.png" alt="카카오 간편 로그인" class="login-btn"></a>
								<a href="/oauth2/authorization/google" onclick="setRedirectUrl('/myPage')"><img src="/images/구글.png" alt="구글 간편 로그인" class="login-btn"></a>
							</div>
						</div>

						<div class="security-settings">
							<h3>비밀번호설정</h3>
							<div class="security-setting-item">
								<label for="current_password">현재 비밀번호</label> <input type="text"
									id="current_password"> <label for="new_password">새비밀번호</label>
								<input type="text" id="new_password"> <label
									for="new_password_verify">비밀번호 확인</label> <input type="text"
									id="new_password_verify">
								<button>수정</button>
							</div>
						</div>

						<div class="delete-account">
							<h3>계정삭제</h3>
							<textarea class="policy-text" readonly>"회원 탈퇴일로부터 계정과 닉네임을 포함한 계정 정보(아이디/이메일/닉네임)는 개인정보 처리방침에 따라 60일간 보관(잠김)되며, 
				60일 경과된 후에는 모든 개인 정보는 완전히 삭제되며 더 이상 복구할 수 없게 됩니다. 작성된 게시물은 삭제되지 않으며, 익명처리 후 namyi 로 소유권이 귀속됩니다."</textarea>
							<div class="policy-agreement">
								<p>계정 삭제에 관한 정책을 읽고 이에 동의합니다.</p>
								<input type="checkbox">
							</div>
							<button class="email-verify-button">회원탈퇴</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		// 클릭 시 `redirectUrl`을 세션에 저장하기 위한 함수
		function setRedirectUrl(url) {
			fetch('/setRedirectUrl', {
				method : 'POST',
				headers : {
					'Content-Type' : 'application/json'
				},
				body : JSON.stringify({
					redirectUrl : url
				})
			});
		}
	</script>
</body>
</html>