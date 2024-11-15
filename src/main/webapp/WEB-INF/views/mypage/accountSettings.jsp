<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/templates/head.jsp" %>
<link rel="stylesheet" href="css/mypage/myPageStyles.css">
<link rel="stylesheet" href="css/mypage/commonStyles.css">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
	$(document).ready(function(){
		$("form").on("submit",function(event){
			const newPassword = $("#new_password").val();
			const newPasswordCheck = $("#new_password_check").val();
			
			if(newPassword !== newPasswordCheck){
				alert("비밀번호 확인이 비밀번호와 일치하지 않습니다.");
				$("#new_password").focus();
				event.preventDefault();
			}
		})
		$("#delete-account-btn").on("click",function(event){
			if(!$("#agreement-checkbox").is(":checked")){
				event.preventDefault();
				alert("계정 삭제에 관한 정책에 동의해야 합니다.");
			}else{
				if(confirm("정말 탈퇴하시겠습니까?")){
					alert("회원 탈퇴가 성공적으로 완료되었습니다.");
				}else{
					event.preventDefault();
				}
			}
		})
	})
</script>
<script type="text/javascript">
        function showAlert(message) {
            alert(message);
        }
    </script>
</head>
<body>
	<%@ include file="/WEB-INF/views/templates/header.jsp" %>
	<div class="container">
		<div class="content">
			<!-- 사이드바: 프로필 사진과 이름 표시 -->
			<%@ include file="/WEB-INF/views/mypage/templates/sidebar.jsp" %>
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
							<form action="/accountSettings" method="post">
								<label for="current_password">현재 비밀번호</label> 
								<input type="password" id="current_password" name="current_password"> 
								<label for="new_password">새비밀번호</label>
								<input type="password" id="new_password" name="new_password"> 
								<label for="new_password_check">비밀번호 확인</label> 
								<input type="password" id="new_password_check" name="new_password_check">
								<button type="submit">수정</button>
							</form>
							</div>
						</div>

						<div class="delete-account">
							<h3>계정삭제</h3>
							<textarea class="policy-text" readonly>"회원 탈퇴일로부터 계정과 닉네임을 포함한 계정 정보(아이디/이메일/닉네임)는 개인정보 처리방침에 따라 60일간 보관(잠김)되며, 
		60일 경과된 후에는 모든 개인 정보는 완전히 삭제되며 더 이상 복구할 수 없게 됩니다. 작성된 게시물은 삭제되지 않으며, 익명처리 후 namyi 로 소유권이 귀속됩니다."
							</textarea>
							<div class="policy-agreement">
								<p>계정 삭제에 관한 정책을 읽고 이에 동의합니다.</p>
								<input type="checkbox" id="agreement-checkbox">
							</div>
							<form action="/deleteAccount" method="post">
								<button type="submit" class="email-verify-button" id="delete-account-btn">회원탈퇴</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<c:if test="${not empty message}">
           <script type="text/javascript">
               showAlert("${message}");
           </script>
    </c:if>
	</div>
	<%@ include file="/WEB-INF/views/templates/footer.jsp" %>
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