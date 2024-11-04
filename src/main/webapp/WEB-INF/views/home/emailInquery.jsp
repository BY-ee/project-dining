<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이메일 문의</title>
    <link rel="stylesheet" href="css/home/emailInquiry.css">
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
    
    <div class="container">
        <h2>이메일 문의</h2>
        <p>문의사항을 남겨주시면 빠른 시일 내에 답변 드리겠습니다.</p>
        
        <form class="inquiry-form">
            <label for="name">이름</label>
            <input type="text" id="name" name="name" required>
            
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" required>
            
            <label for="phone">전화번호</label>
            <input type="tel" id="phone" name="phone">
            
            <label for="subject">제목</label>
            <input type="text" id="subject" name="subject" required>
            
            <label for="message">문의 내용</label>
            <textarea id="message" name="message" maxlength="500"></textarea>
            <div class="char-limit">0자 / 최대 500자</div>
            
            <label for="file">첨부 파일</label>
            <input type="file" id="file" name="file">
            
            <div class="consent-section">
                <label>
                    <input type="checkbox" required> 정보 수집 및 이용 동의
                </label>
                <p class="consent-text">
                    개인정보는 문의에 대한 답변을 위해서만 사용되며, 문의 접수 후 1개월 이내에 파기됩니다.
                </p>
            </div>
            
            <button type="submit" class="submit-btn">제출하기</button>
        </form>
    </div>

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

</body>
</html>