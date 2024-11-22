<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <!-- 한글 인코딩 -->

<!DOCTYPE html>
<html lang="ko">

<head>
    <title>자주 묻는 질문</title>
    <link rel="stylesheet" href="css/home/csr.css">
    <jsp:include page="/WEB-INF/views/templates/head.jsp" /> <!-- header -->
</head>
<body>
	<jsp:include page="/WEB-INF/views/templates/header.jsp" /> <!-- header -->
    
    <main class="container"> <!-- main content start -->

        <!-- 기존 FAQ 섹션 -->
        <section class="faq">
            <h2>무엇을 도와드릴까요?</h2>
            <div class="faq-items">
                <button class="faq-item" onclick="toggleAnswer(this)">Q. 원하는 맛집을 어떻게 찾을 수 있나요?</button>
                <div class="faq-answer">앱 내 카테고리 기능을 이용하여 원하는 지역이나 음식 종류를 선택하시면 확인이 가능합니다.</div>
                
                <button class="faq-item" onclick="toggleAnswer(this)">Q. 리뷰는 어떻게 작성하나요?</button>
                <div class="faq-answer">방문한 맛집에서 '리뷰 작성' 버튼을 클릭하시면, 음식, 분위기, 서비스에 대한 평가와 함께 사진 및 텍스트 리뷰를 
                남기실 수 있습니다. 다른 사용자에게 도움이 되는 생생한 리뷰를 작성해 주세요!</div>
                
                <button class="faq-item" onclick="toggleAnswer(this)">Q. 추천 받은 맛집을 저장할 수 있나요?</button>
                <div class="faq-answer">네, 추천 받은 맛집을 '좋아요' 기능을 통해 저장할 수 있습니다. 앱 내에서 저장한 맛집은 '활동내역' 
                메뉴에서 언제든지 다시 확인하실 수 있습니다.</div>
                
                <button class="faq-item" onclick="toggleAnswer(this)">Q. 쿠폰이나 할인 혜택은 어떻게 확인하나요?</button>
                <div class="faq-answer">앱에서는 제휴된 맛집의 할인 정보와 쿠폰 혜택을 제공하고 있습니다. 가게 상세 페이지에서 현재 제공 중인 혜택을 
                확인하거나, '쿠폰/할인' 섹션에서 사용 가능한 혜택을 확인할 수 있습니다.</div>
            </div>
        </section>

        <section class="customer-center">
		    <h3>고객센터 <span class="hours">09:00 ~ 18:00</span></h3>
		    <ul class="info-list">
		        <li>ㆍ평일: 전체 문의 상담</li>
		        <li>ㆍ토요일, 공휴일: 오늘의집 직배송 주문건 상담</li>
		        <li>ㆍ일요일: 휴무</li>
		    </ul>
		    <div class="contact-number">
		    	<p>📞 010-6286-9140</p>
		   	</div>
		    <button class="contact-button">1:1 카톡 상담하기 (준비 중)</button>
		    <div class="email-options">
		        <button class="email-button" onclick="window.location.href='/emailInquery';">이메일 문의하기</button>
		        <button class="email-copy">이메일 주소 복사하기</button>
		    </div>
		</section>
    </main> <!-- main content end -->

    <!-- 하단 탭 섹션 -->
    <section class="tab-faq">
        <div class="tabs">
            <button class="tab-button" onclick="showTab('login', event)">로그인/회원가입</button>
            <button class="tab-button" onclick="showTab('recommendation', event)">채팅 이용방법</button>
            <button class="tab-button" onclick="showTab('store-inquiry', event)">가게 등록 문의</button>
            <button class="tab-button" onclick="showTab('ad-partnership', event)">광고 제휴 문의</button>
        </div>
        
        <div id="login" class="tab-content">
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 간편가입으로 가입했는데 이메일 변경 가능한가요?</button>
            <div class="faq-detial-answer">미아페이지 > 간편가입 경우 계정 정보 탭에서 변경이 가능합니다.</div>
            
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 비밀번호는 어떻게 변경하나요?</button>
            <div class="faq-detial-answer">마이페이지 > 비밀번호는 계정 정보에서 이메일 인증을 통해 변경 가능합니다.</div>
            
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 회원 탈퇴는 어떻게 하나요?</button>
            <div class="faq-detial-answer">마이페이지 > 회원 탈퇴는 약관 동의 이후 계정 정보에서 탈퇴/회원 삭제가 가능합니다 </div>
            
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 중복 가입 시 문제는 어떻게 해결하나요?</button>
            <div class="faq-detial-answer">고객센터로 문의 바랍니다.</div>
        </div>
        
        <div id="recommendation" class="tab-content">
		    <button class="faq-item" onclick="toggleAnswer(this)">Q. 채팅방은 어떻게 생성하나요?</button>
		    <div class="faq-detial-answer">커뮤니티 페이지에서 '채팅방 생성' 버튼을 클릭한 후, 필요한 정보를 입력하고 '생성' 버튼을 누르면 채팅방이 만들어집니다.</div>
		    
		    <button class="faq-item" onclick="toggleAnswer(this)">Q. 부적절한 언어를 사용하는 유저는 어떻게 신고하나요?</button>
		    <div class="faq-detial-answer">고객센터의 '이메일 문의하기'를 통해 대화 내용과 닉네임이 보이는 캡처를 보내주시면, 확인 후 계정이 비활성화될 수 있습니다.</div>
		    
		    <button class="faq-item" onclick="toggleAnswer(this)">Q. 입장 버튼을 눌렀는데 채팅방이 보이지 않아요.</button>
		    <div class="faq-detial-answer">채팅방 입장은 로그인 후 가능합니다. 상단 메뉴에서 '내 채팅'을 클릭하면 참여 중인 채팅방 목록을 확인할 수 있습니다.</div>
		    
		    <button class="faq-item" onclick="toggleAnswer(this)">Q. 채팅방 만료 시간 이후에는 어떻게 되나요?</button>
		    <div class="faq-detial-answer">채팅방은 만료 시간이 지나면 자동으로 삭제됩니다. 바로 반영되지 않을 경우 페이지를 새로고침해 주세요.</div>
		</div>
        
        <div id="store-inquiry" class="tab-content">
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 가게 등록 절차는 어떻게 되나요?</button>
            <div class="faq-detial-answer">등록은 기본 정보 입력 후 검토를 거쳐 승인됩니다.</div>
            
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 등록 시 필요한 서류는 무엇인가요?</button>
            <div class="faq-detial-answer">사업자 등록증과 가게 사진이 필요합니다.</div>
            
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 등록을 취소할 수 있나요?</button>
            <div class="faq-detial-answer">등록 취소는 고객센터를 통해 요청 가능합니다.</div>
            
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 가게 정보 수정은 어떻게 하나요?</button>
            <div class="faq-detial-answer">가게 정보 수정은 관리자 페이지에서 가능합니다.</div>
        </div>
        
        <div id="ad-partnership" class="tab-content">
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 광고 제휴 신청은 어떻게 하나요?</button>
            <div class="faq-detial-answer">광고 제휴는 제휴 페이지에서 신청 가능합니다.</div>
            
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 광고 비용은 어떻게 책정되나요?</button>
            <div class="faq-detial-answer">광고 비용은 노출 시간과 위치에 따라 다릅니다.</div>
            
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 광고 효과는 어떻게 확인하나요?</button>
            <div class="faq-detial-answer">효과는 관리자 페이지에서 통계로 확인 가능합니다.</div>
            
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 광고 계약은 어떻게 갱신되나요?</button>
            <div class="faq-detial-answer">갱신은 계약 만료 시 자동으로 알림이 발송됩니다.</div>
        </div>
    </section>

	<jsp:include page="/WEB-INF/views/templates/footer.jsp" /> <!-- footer -->

    <script src="js/home/QnA.js"></script>
</body>
</html>