<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <!-- 한글 인코딩 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- footer 태그 템플릿 -->
<footer class="footer">
    <div class="footer-content">
        <div class="customer-center">
            <h3><a href="/csr">고객 센터</a></h3>
            <p>010-6286-9140 <span class="time">09:00-18:00</span></p>
            <p>평일: 전체 문의 상담<br>
               토요일, 공휴일: 제휴 가게 신청 상담<br>
               일요일: 휴무</p>
            <button>카톡 상담 ( 준비 중 )</button>
            <button onclick="window.location.href='/emailInquery'">이메일 문의</button>
        </div>
        <div class="company-links">
            <ul>
                <li><a href="/terms">이용 약관</a></li>
                <li><a href="/storeRegistration">사업자 가게 등록</a></li>
                <li><a href="/noticeList">공지 사항</a></li>
                <c:if test="${sessionMember.role == 'ROLE_ADMIN'}">
                    <li><a href="/admin/members">관리자 페이지</a></li>
                </c:if>
            </ul>
        </div>
    </div>
    <div class="footer-bottom">
        <p>Copyright 2024. , Nyaminyami Co., Ltd. All rights reserved.</p>
    </div>
</footer>