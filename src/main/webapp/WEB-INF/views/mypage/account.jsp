<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%-- <%@ include file="/WEB-INF/views/templates/head.jsp" %> --%>
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
	<%-- <%@ include file="/WEB-INF/views/templates/header.jsp" %> --%>
	<div class="container">
		<div class="content">
			<!-- 사이드바: 프로필 사진과 이름 표시 -->
			<%@ include file="/WEB-INF/views/mypage/templates/sidebar.jsp" %>
			<!-- 메인 콘텐츠 부분 -->
			<div class="main-content">
				<!-- 탭 메뉴 -->
				<div class="tabs">
					<button class="tab" onclick="location.href='/mypage'">활동내역</button>
					<button class="tab" onclick="location.href='/profile'">프로필</button>
					<button class="tab" onclick="location.href='/account'">계정 정보</button>
					<button class="tab" onclick="location.href='/userPoint'">포인트</button>
				</div>
				<div class="expanded-content">
					<!-- 계정 정보 섹션 -->
					<div id="account-settings" class="section">
						<div class="div-content">
							<h3>이메일 정보</h3>
								<input type="email" id="userEmail" name="userEmail" value="${sessionMember.email}">
								<!-- <button class="email-verify-button" onclick="sendVerificationEmail()">이메일 인증</button> -->
								<button type="button" class="email-verify-button">이메일 인증</button>
								<div id="verification-popup" style="display: none; position: fixed; top: 30%; left: 50%; transform: translate(-50%, -50%); width: 300px; padding: 20px; border: 1px solid #ccc; background: #fff; z-index: 1000;">
								    <h3>인증 코드 입력</h3>
								    <input type="text" id="verificationCode" placeholder="인증 코드를 입력하세요">
								    <button id="verify-code-btn">확인</button>
								    <button id="close-popup-btn">닫기</button>
								</div>
							<p>이메일 변경은 변경한 이메일로 인증 요청 메일이 발송되고 해당 이메일을 통해 인증을 정상적으로 완료한 후
								최종적으로 반영됩니다.</p>
						</div>
						<div class="div-content">
							<h3>소셜계정 연동</h3>
							<p>사용하시는 소셜 및 인증 제공자들과 계정을 연동하고 손쉽게 로그인하세요.</p>
							<div class="social-connect-buttons">
								<c:choose>
									<c:when test="${empty sessionMember.naverId}">
										<a href="/oauth2/authorization/naver" onclick="setRedirectUrl('/updateSocialId','네이버')">
											<img src="/images/naver_button.png" alt="네이버 간편 로그인" class="login-btn">
											네이버 연결하기
										</a>
									</c:when>
									<c:otherwise>
										<a style="cursor: default;">
											<img src="/images/naver_button.png" alt="네이버 간편 로그인" class="enrolled-login-btn">
											네이버 등록완료
										</a>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${empty sessionMember.kakaoId}"> 
										<a href="/oauth2/authorization/kakao" onclick="setRedirectUrl('/updateSocialId','카카오')">
											<img src="/images/카카오.png" alt="카카오 간편 로그인" class="login-btn">
											카카오 연결하기
										</a>
									</c:when>
									<c:otherwise>
										<a style="cursor: default;">
											<img src="/images/kakao_button.png" alt="카카오 간편 로그인" class="enrolled-login-btn">
											카카오 등록완료
										</a>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${empty sessionMember.googleId}">
										<a href="/oauth2/authorization/google" onclick="setRedirectUrl('/updateSocialId','구글')">
											<img src="/images/구글.png" alt="구글 간편 로그인" class="login-btn">
											구글 연결하기
										</a>
									</c:when>
									<c:otherwise>
										<a style="cursor: default;">
											<img src="/images/google_button.png" alt="구글 간편 로그인" class="enrolled-login-btn">
										구글 등록완료
										</a>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="div-content">
							<h3>비밀번호 설정</h3>
							<div class="security-setting-item">
							<form action="/account" method="post">
								<label for="current_password">현재 비밀번호</label> 
								<input type="password" id="current_password" name="current_password" class="${sessionMember.passwd == null ? 'disabled' : ''}" >
								<label for="new_password">새비밀번호</label>
								<input type="password" id="new_password" name="new_password"> 
								<label for="new_password_check">비밀번호 확인</label> 
								<input type="password" id="new_password_check" name="new_password_check">
								<button type="submit">수정</button>
							</form>
							</div>
						</div>

						<div class="div-content">
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
	<%-- <%@ include file="/WEB-INF/views/templates/footer.jsp" %> --%>
	<script>
		$(".email-verify-button").on("click",function(){
			const userEmail = $("#userEmail").val();

		    if (!userEmail) {
		        alert("이메일을 입력해주세요.");
		        return;
		    }
			alert("이메일 인증을 보냈습니다.")
		    $.ajax({
		        url: '/sendVerificationEmail',
		        type: 'POST',
		        data: { userEmail: userEmail },
		        success: function(data) {
		            //alert(data); // "인증 이메일이 발송되었습니다." 출력
		            $("#verification-popup").fadeIn(); // 팝업창 띄우기
		        },
		        error: function(xhr, status, error) {
		            console.error('Error:', error);
		            alert("인증 이메일 전송에 실패했습니다.");
		        }
		    });
		})
		
			// 인증 코드 확인 버튼 클릭 시
	    $("#verify-code-btn").on("click", function () {
	        const userEmail = $("#userEmail").val();
	        const verificationCode = $("#verificationCode").val();
	
	        if (!userEmail || !verificationCode) {
	            alert("이메일과 인증 코드를 모두 입력해주세요.");
	            return;
	        }
	
	        // AJAX로 인증 코드 검증 요청
	        $.ajax({
	            url: '/verifyCode',
	            type: 'POST',
	            data: { userEmail: userEmail, code: verificationCode },
	            success: function (data) {
	                alert(data); // "인증에 성공했습니다." 또는 실패 메시지 출력
	                $("#verification-popup").fadeOut(); // 팝업창 닫기
	            },
	            error: function (xhr, status, error) {
	                console.error('Error:', error);
	                alert("인증에 실패했습니다.");
	            }
	        });
	    });

	    // 팝업창 닫기 버튼 클릭 시
	    $("#close-popup-btn").on("click", function () {
	        $("#verification-popup").fadeOut(); // 팝업창 숨기기
	    });
	
	    
	    
		// 클릭 시 `redirectUrl`을 세션에 저장하기 위한 함수
		function setRedirectUrl(url,socialName) {
			alert(url+","+socialName);
			fetch('/setRedirectUrl', {
				method : 'POST',
				headers : {
					'Content-Type' : 'application/json'
				},
				body : JSON.stringify({
					redirectUrl : url,
					socialName : socialName
				})
			});
		}
		
		function sendVerificationEmail() {
		    const userEmail = $("#userEmail").val();

		    if (!userEmail) {
		        alert("이메일을 입력해주세요.");
		        return;
		    }

		    $.ajax({
		        url: '/sendVerificationEmail',
		        type: 'POST',
		        data: { userEmail: userEmail },
		        success: function(data) {
		            alert(data); // "인증 이메일이 발송되었습니다." 출력
		        },
		        error: function(xhr, status, error) {
		            console.error('Error:', error);
		            alert("인증 이메일 전송에 실패했습니다.");
		        }
		    });
		}
		
		function verifyCode() {
		    const userEmail = document.getElementById("userEmail").value;
		    const code = document.getElementById("verificationCode").value;

		    if (!userEmail || !code) {
		        alert("이메일과 인증 코드를 모두 입력해주세요.");
		        return;
		    }

		    fetch('/verifyCode', {
		        method: 'POST',
		        headers: {
		            'Content-Type': 'application/x-www-form-urlencoded',
		        },
		        body: new URLSearchParams({ userEmail, code })
		    })
		    .then(response => response.text())
		    .then(data => {
		        alert(data); // "인증에 성공했습니다." 또는 다른 메시지 출력
		    })
		    .catch(error => {
		        console.error('Error:', error);
		        alert("인증에 실패했습니다.");
		    });
		}
	</script>
</body>
</html>