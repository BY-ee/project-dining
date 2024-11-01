<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자주 묻는 질문</title>
    <link rel="stylesheet" href="css/csr.css">
</head>
<body>
    <header>
        <h1><a href="/">냐미냐미</a></h1>
        <nav>
            <a href="#">같이 먹기</a>
            <a href="#">맛집 검색</a>
            <a href="#">간단 게임</a>
            <input type="text" placeholder="통합검색">
        </nav>
    </header>
    
    <main class="container">
        <!-- 기존 FAQ 섹션 -->
        <section class="faq">
            <h2>무엇을 도와드릴까요?</h2>
            <div class="faq-items">
                <button class="faq-item" onclick="toggleAnswer(this)">Q. 가까운 맛집을 어떻게 찾을 수 있나요?</button>
                <div class="faq-answer">앱 내 검색 기능을 이용하여 원하는 지역이나 음식 종류를 입력하시면, 
                위치를 기반으로 가까운 맛집을 추천받을 수 있습니다. GPS 기능을 켜두시면 더욱 정확한 추천이 가능합니다.</div>
                
                <button class="faq-item" onclick="toggleAnswer(this)">Q. 리뷰는 어떻게 작성하나요?</button>
                <div class="faq-answer">방문한 맛집에서 '리뷰 작성' 버튼을 클릭하시면, 음식, 분위기, 서비스에 대한 평가와 함께 사진 및 텍스트 리뷰를 
                남기실 수 있습니다. 다른 사용자에게 도움이 되는 생생한 리뷰를 작성해 주세요!</div>
                
                <button class="faq-item" onclick="toggleAnswer(this)">Q. 추천 받은 맛집을 저장할 수 있나요?</button>
                <div class="faq-answer">네, 추천 받은 맛집을 '즐겨찾기' 기능을 통해 저장할 수 있습니다. 앱 내에서 저장한 맛집은 '내 즐겨찾기' 
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
    </main>

    <!-- 하단 탭 섹션 -->
    <section class="tab-faq">
        <div class="tabs">
            <button class="tab-button" onclick="showTab('login', event)">로그인/회원가입</button>
            <button class="tab-button" onclick="showTab('recommendation', event)">추천 이용방법</button>
            <button class="tab-button" onclick="showTab('store-inquiry', event)">가게 등록 문의</button>
            <button class="tab-button" onclick="showTab('ad-partnership', event)">광고 제휴 문의</button>
        </div>
        
        <div id="login" class="tab-content">
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 간편가입으로 가입했는데 이메일 변경 가능한가요?</button>
            <div class="faq-detial-answer">간편가입 계정에서는 이메일 변경이 불가능합니다.</div>
            
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 비밀번호는 어떻게 변경하나요?</button>
            <div class="faq-detial-answer">마이페이지 > 계정 설정에서 변경 가능합니다.</div>
            
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 회원 탈퇴는 어떻게 하나요?</button>
            <div class="faq-detial-answer">탈퇴는 고객센터를 통해 진행해 주세요.</div>
            
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 중복 가입 시 문제는 어떻게 해결하나요?</button>
            <div class="faq-detial-answer">고객센터로 문의 바랍니다.</div>
        </div>
        
        <div id="recommendation" class="tab-content"">
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 추천 알고리즘은 어떻게 작동하나요?</button>
            <div class="faq-detial-answer">알고리즘은 사용자 관심사를 기반으로 추천됩니다.</div>
            
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 추천 목록을 새로고침하려면?</button>
            <div class="faq-detial-answer">추천 목록은 새로고침 버튼을 누르거나 일정 시간마다 업데이트됩니다.</div>
            
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 추천이 마음에 안 들면 어떻게 하나요?</button>
            <div class=faq-detial-answer>관심 없는 항목을 설정하면 더욱 맞춤 추천이 가능합니다.</div>
            
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 추천 항목을 저장할 수 있나요?</button>
            <div class="faq-detial-answer">저장 기능은 마이페이지에서 이용 가능합니다.</div>
        </div>
        
        <div id="store-inquiry" class="tab-content"">
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 가게 등록 절차는 어떻게 되나요?</button>
            <div class="faq-detial-answer">등록은 기본 정보 입력 후 검토를 거쳐 승인됩니다.</div>
            
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 등록 시 필요한 서류는 무엇인가요?</button>
            <div class="faq-detial-answer">사업자 등록증과 가게 사진이 필요합니다.</div>
            
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 등록을 취소할 수 있나요?</button>
            <div class="faq-detial-answer">등록 취소는 고객센터를 통해 요청 가능합니다.</div>
            
            <button class="faq-item" onclick="toggleAnswer(this)">Q. 가게 정보 수정은 어떻게 하나요?</button>
            <div class="faq-detial-answer">가게 정보 수정은 관리자 페이지에서 가능합니다.</div>
        </div>
        
        <div id="ad-partnership" class="tab-content"">
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
   
    <!-- Footer Section -->
		<div class="footer">
		    <div class="footer-content">
		        <!-- 고객센터 정보 -->
		        <div class="customer-center">
		            <h3><a href="/csr">고객 센터</a></h3>
		            <p>010-6286-9140 <span class="time">09:00-18:00</span></p>
		            <p>평일: 전체 문의 상담<br>
		               토요일, 공휴일: 제휴 가게 신청 상담<br>
		               일요일: 휴무</p>
		            <button class="contact-button">카톡 상담 ( 준비 중 )</button>
		            <button class="contact-button">이메일 문의</button>
		        </div>
		
		        <!-- 회사 정보 및 링크 -->
		        <div class="company-links">
		            <ul>
		                <li><a href="/terms">이용 약관</a></li>
		                <li><a href="#">사업자 가게 등록</a></li>
		                <li><a href="#">공지 사항</a></li>
		            </ul>
		        </div>
		    </div>
		    <div class="footer-bottom">
		        <p>Copyright 2024. Nyaminyami Co., Ltd. All rights reserved.</p>
		    </div>
		</div>
    <script src="js/QnA.js"></script>
</body>
</html>