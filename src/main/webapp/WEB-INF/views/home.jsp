	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<!DOCTYPE html>
	<html lang="ko">
	<head>
	    <meta charset="UTF-8">
	    <title>Dining Recommendation</title>
	    <link rel="stylesheet" type="text/css" href="/css/home.css">
	    <script src="/js/slider.js" defer></script>
	    <script src="/js/userdropdown.js" defer></script>
	</head>
	<body>
	    <!-- 헤더 섹션 -->
	    <div class="header">
	        <!-- 페이지 이름 및 로고 -->
	        <div class="page-name">
	            <a href="/">냐미냐미</a>
	        </div>
	        
	        <!-- 로그인 및 인증 버튼 -->
	        <div class="auth-buttons">
	<c:choose>
		   <c:when test="${not empty sessionScope.loginUser.userid}">
	        <!-- 로그인된 사용자를 위한 팝업 메뉴 -->
	        <div class="user-popup-container">
	            <button class="menu-btn">☰</button>
	            <div class="user-popup" style="display: none;">
	                <a href="/profile">프로필</a>
	                <a href="/mypage">마이페이지</a>
	                <a href="/settings">환경설정</a>
	                <a href="/recommendations">1:1 추천</a>
	            </div>
	        </div>
	    </c:when>
	    <c:otherwise>
	        <!-- 비로그인 사용자를 위한 로그인 버튼 -->
	        <form action="loginForm.do" meth	od="get" style="display:inline;">
	            <button type="submit">로그인/회원가입</button>
	        </form>
	    </c:otherwise>
	</c:choose>
	        </div>
	    </div>
	
	    <!-- 메인 콘텐츠 섹션 -->
	    <div class="content">
	        <!-- 위치 및 카테고리 드롭다운 메뉴 -->
	        <div class="filter-container">
	            <div class="location-dropdown">
	                <button class="location-btn">강남역</button>
	                <div class="location-menu">
	                    <a href="#">강남역</a>
	                    <a href="#">신사역</a>
	                    <a href="#">압구정역</a>
	                    <a href="#">역삼역</a>
	                </div>
	            </div>
	        </div>
	
	        <!-- 메인 배너 슬라이드 -->
	        <div class="main-banner">
	            <div class="slider-container">
	                <div class="slide">
	                    <div class="slide-title"></div>
	                    <img src="/images/모수 간판.png" alt="슬라이드 1 이미지" class="slide-image">
	                </div>
	                <div class="slide">
	                    <img src="/images/티앤미미.jpg" alt="슬라이드 2 이미지" class="slide-image">
	                </div>
	                <div class="slide">에드워드 리</div>
	                <div class="slide">물고기</div>
	            </div>
	        </div>
	
	        <div class="filter-container">
	            <div class="category-menu">
	                <select class="category-select">
	                    <option selected disabled>음식 종류</option>
	                    <option>한식</option>
	                    <option>중식</option>
	                    <option>양식</option>
	                </select>
	                <select class="category-select">
	                    <option selected disabled>업종 종류</option>
	                    <option>음식점</option>
	                    <option>술집</option>
	                    <option>카페</option>
	                </select>
	                <select class="category-select">
	                    <option selected disabled>테마</option>
	                    <option>혼자왔어요 혼자왔는데 뭐요</option>
	                    <option>둘이왔는데, 이제 친구를 곁들인</option>
	                    <option>커 | 플</option>
	                    <option>회식왔어요, 부장님 전 포장이요</option>
	                </select>
	            </div>
	        </div>
	            
	        <!-- 가게 목록 컨테이너 -->
	        <div class="store-container">
	            <div class="store-list">
	                <div class="store-item-box">
	                    <div class="store-item"></div>
	                    <div class="store-name">모수</div>
	                </div>
	                <div class="store-item-box">
	                    <div class="store-item"></div>
	                    <div class="store-name">티앤미미</div>
	                </div>
	                <div class="store-item-box">
	                    <div class="store-item"></div>
	                    <div class="store-name">에드워드 리</div>
	                </div>
	                <div class="store-item-box">
	                    <div class="store-item"></div>
	                    <div class="store-name">물고기</div>
	                </div>
	            </div>
	        </div>
	        
	        <!-- 푸터 섹션 -->
	        <div class="footer">
	            <div class="footer-content">
	                <!-- 고객센터 정보 -->
	                <div class="customer-center">
	                    <h3><a href="/csr">고객 센터</a></h3>
	                    <p>010-6286-9140 <span class="time">09:00-18:00</span></p>
	                    <p>평일: 전체 문의 상담<br>
	                       토요일, 공휴일: 제휴 가게 신청 상담<br>
	                       일요일: 휴무</p>
	                    <button>카톡 상담 ( 준비 중 )</button>
	                    <button>이메일 문의</button>
	                </div>
	        
	                <!-- 회사 정보 및 링크 -->
	                <div class="company-links">
	                    <ul>
	                        <li><a href="#">이용 약관</a></li>
	                        <li><a href="#">사업자 가게 등록</a></li>
	                        <li><a href="#">공지 사항</a></li>
	                    </ul>
	                </div>
	            </div>
	            <div class="footer-bottom">
	                <p>Copyright 2024. , Nyaminyami Co., Ltd. All rights reserved.</p>
	            </div>
	        </div>
	    </div>
	</body>
	</html>
