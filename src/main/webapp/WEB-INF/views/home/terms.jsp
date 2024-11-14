<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <!-- 한글 인코딩 -->

<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/templates/head.jsp" %> <!-- head -->

<head>
    <title>이용약관</title>
    <link rel="stylesheet" href="css/home/terms.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/templates/header.jsp" /> <!-- header -->

	<main> <!-- main content start -->

		<div class="header-container">
			<h1 class="title">이용 약관</h1>
			<p class="date">2024.10.31</p>
		</div>

		<!-- 목차 컨테이너 -->
		<div class="terms-container">
			<div class="terms-sections">
				<div class="section">
					<h2>제 1 장 서비스 소개</h2>
					<ul>
						<li class="terms-item"><a href="#section1">제 1 조 (목적)</a></li>
						<li class="terms-item"><a href="#section2">제 2 조 (정의)</a></li>
						<li class="terms-item"><a href="#section3">제 3 조 (약관의 설명 및 개정)</a></li>
						<li class="terms-item"><a href="#section4">제 4 조 (약관 외 준칙)</a></li>
					</ul>
				</div>

				<div class="section">
					<h2>제 2 장 서비스 이용 안내</h2>
					<ul>
						<li class="terms-item"><a href="#section5">제 5 조 (회원가입)</a></li>
						<li class="terms-item"><a href="#section6">제 6 조 (이용요금)</a></li>
						<li class="terms-item"><a href="#section7">제 7 조 (개인정보)</a></li>
						<li class="terms-item"><a href="#section8">제 8 조 (ID 및 비밀번호 관리)</a></li>
						<li class="terms-item"><a href="#section9">제 9 조 (서비스 제공)</a></li>
					</ul>
				</div>

				<div class="section">
					<h2>제 3 장 이용자의 권리와 의무</h2>
					<ul>
						<li class="terms-item"><a href="#section10">제 10 조 (이용자의 의무)</a></li>
						<li class="terms-item"><a href="#section11">제 11 조 (콘텐츠의 저작권)</a></li>
						<li class="terms-item"><a href="#section12">제 12 조 (서비스 중단)</a></li>
					</ul>
				</div>

				<div class="section">
					<h2>제 4 장 기타</h2>
					<ul>
						<li class="terms-item"><a href="#section13">제 13 조 (분쟁 해결)</a></li>
						<li class="terms-item"><a href="#section14">제 14 조 (관할법원)</a></li>
					</ul>
				</div>
			</div>
		</div>

		<!-- 상세 약관 내용 컨테이너 -->
		<div class="detailed-terms">
			<div class="detailed-terms-jang-head">
				<h3>제 1 장 서비스 소개</h3>
				<div class="detailed-terms-jo-head" id="section1">
					<p><strong>제 1조 (목적)</strong><br>이 약관은 외식 추천 서비스의 이용과 관련하여 서비스 제공자와 이용자의 권리, 의무 및 책임을 규정함을 목적으로 합니다.</p>
				</div>
				<div class="detailed-terms-jo" id="section2">			
					<p><strong>제 2조 (정의)</strong><br>본 약관에서 사용하는 용어의 정의는 다음과 같습니다: ...</p>
				</div>
				<div class="detailed-terms-jo" id="section3">						  
					<p><strong>제 3조 (약관의 설명 및 개정)</strong><br>회사는 약관의 개정이 필요할 경우, 관련 법령에 따라 약관을 개정할 수 있습니다. 변경 사항은 ...</p>
				</div>
				<div class="detailed-terms-jo" id="section4">
					<p><strong>제 4조 (약관 외 준칙)</strong><br>이 약관에 명시되지 않은 사항에 대해서는 관련 법령 또는 회사의 운영 방침에 따릅니다.</p>
				</div>
			</div>
			
			<div class="detailed-terms-jang">
				<h3>제 2 장 서비스 이용 안내</h3>
				<div class="detailed-terms-jo-head" id="section5">
					<p><strong>제 5조 (회원가입)</strong><br>이용자는 회사가 정한 가입 양식에 따라 회원정보를 기입한 후 회원가입을 신청할 수 있으며, 회사는 이를 승인하여 이용계약이 체결됩니다.</p>
				</div>
				<div class="detailed-terms-jo" id="section6">
					<p><strong>제 6조 (이용요금)</strong><br>기본적인 서비스는 무료로 제공되나, 특정 유료 서비스의 경우 이용요금이 발생할 수 있습니다.</p>
				</div>
				<div class="detailed-terms-jo" id="section7">
					<p><strong>제 7조 (개인정보)</strong><br>회사는 서비스 제공을 위하여 이용자의 개인정보를 수집할 수 있으며, 이에 대한 자세한 사항은 개인정보 처리방침에 따릅니다.</p>
				</div>
				<div class="detailed-terms-jo" id="section8">
					<p><strong>제 8조 (ID 및 비밀번호 관리)</strong><br>이용자는 자신의 ID와 비밀번호 관리에 대한 책임이 있으며, 이를 소홀히 하여 발생한 손해에 대한 책임은 이용자에게 있습니다.</p>
				</div>
				<div class="detailed-terms-jo" id="section9">
					<p><strong>제 9조 (서비스 제공)</strong><br>회사는 정기점검, 기술적 문제 등이 발생하는 경우 서비스 제공을 일시적으로 중단할 수 있습니다.</p>
				</div>
			</div>
			
			<div class="detailed-terms-jang">
				<h3>제 3 장 이용자의 권리와 의무</h3>
				<div class="detailed-terms-jo-head" id="section10">
					<p><strong>제 10조 (이용자의 의무)</strong><br>이용자는 본 약관 및 회사의 운영 방침을 준수하여야 하며, 불법 행위를 하지 않아야 합니다.</p>
				</div>
				<div class="detailed-terms-jo" id="section11">
					<p><strong>제 11조 (콘텐츠의 저작권)</strong><br>회사가 제공하는 콘텐츠의 저작권은 회사에 있으며, 이용자는 이를 무단으로 복제, 배포할 수 없습니다.</p>
				</div>
				<div class="detailed-terms-jo" id="section12">
					<p><strong>제 12조 (서비스 중단)</strong><br>회사는 일정한 사유가 발생할 경우, 서비스의 제공을 일시 중단할 수 있으며, 이 경우 사전 공지를 하여야 합니다.</p>
				</div>
			</div>
			
			<div class="detailed-terms-jang">
				<h3>제 4 장 기타</h3>
				<div class="detailed-terms-jo-head" id="section13">
					<p><strong>제 13조 (분쟁 해결)</strong><br>이 약관과 관련된 분쟁이 발생할 경우, 회사와 이용자는 상호 합의하여 해결하도록 노력합니다.</p>
				</div>
				<div class="detailed-terms-jo" id="section14">
					<p><strong>제 14조 (관할법원)</strong><br>이 약관에 의한 서비스 이용과 관련된 소송은 회사의 본사 소재지를 관할하는 법원을 관할 법원으로 합니다.</p>
				</div>
			</div>
		</div>
    </main> <!-- main content end -->

	<jsp:include page="/WEB-INF/views/templates/footer.jsp" /> <!-- footer -->

	<script src="js/home/termsScroll.js"></script>
    
</body>
</html>