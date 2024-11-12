<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.project.domain.Login"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Dining Recommendation</title>
    <link rel="stylesheet" type="text/css" href="/css/home/home-category.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/js/home/slider.js" defer></script>
    <script src="/js/home/userdropdown.js" defer></script>
</head>
<body>
    <!-- 헤더 섹션 -->
    <div class="header">
        <!-- 페이지 이름 및 로고 -->
        <div class="page-name">
        	<h1><a href="/">냐미냐미</a></h1>
        </div>
        
        <!-- 인증 버튼 -->
        <div class="auth-buttons">
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <!-- 로그인된 사용자를 위한 메뉴 -->
                    <div class="user-popup-container">
                        <button class="menu-btn">☰</button>
                        <div class="user-popup" style="display: none;">
                            <span class="welcome-message">환영합니다, ${sessionScope.loginUser.nickname}님!</span>
                            <a href="/profile">프로필</a>
                            <a href="/myPage">마이페이지</a>
                            <a href="/settings">환경설정</a>
                            <a href="/recommendations">1:1 추천</a>
                            <form action="/logout" method="post" style="display:inline;">
                                <button type="submit">로그아웃</button>
                            </form>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- 비로그인 사용자를 위한 로그인/회원가입 버튼 -->
                    <form action="/loginForm.do" method="get" style="display:inline;">
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
	            <button class="location-btn" id="location-btn">지역 선택</button>
	            <div class="location-menu">
				    <a href="#" onclick="filterByLocation('MAPO', '마포구')">마포구</a>
				    <a href="#" onclick="filterByLocation('SONGPA', '송파구')">송파구</a>
				    <a href="#" onclick="filterByLocation('GANGNAM', '강남/서초구')">강남/서초구</a>
				    <a href="#" onclick="filterByLocation('SEONGBUK', '성복/종로구')">성북/종로구</a>
				    <a href="#" onclick="filterByLocation('GWANGJIN', '광진/성동구')">광진/성동구</a>
				</div>
	        </div>
	    </div>
	    

        <!-- 메인 배너 슬라이드 -->
        <div class="main-banner">
		    <div class="slider-container">
		        <div class="slide">
		            <img src="/images/home/모수 긴 화면 2.png" alt="슬라이드 1 이미지" class="slide-image">
		        </div>
		        <div class="slide">
		            <img src="/images/home/티앤미미.jpg" alt="슬라이드 2 이미지" class="slide-image">
		        </div>
		        <!-- 추가 슬라이드는 여기에 배치 -->
		    </div>
		    
		   	<div class="slide-buttons">
			    <button onclick="moveToSlide(0)"></button>
			    <button onclick="moveToSlide(1)"></button>
			    <button onclick="moveToSlide(2)"></button>
			    <button onclick="moveToSlide(3)"></button>
			</div>
		</div>
		
		<div class="category-select-container">
		    <button class="category-select-btn" onclick="toggleCategoryPopup()">카테고리 선택</button>
		
		    <!-- 카테고리 선택 영역 -->
		    <div id="categoryPopup" class="category-popup" style="display: none;">
		        <div class="category-step">
		            <h3>업종 선택</h3>
		            <button onclick="selectIndustry('음식점')">음식점</button>
		            <button onclick="selectIndustry('카페')">카페</button>
		            <button onclick="selectIndustry('술집')">술집</button>
		        </div>
		        <div id="selectedIndustryOptions" class="selected-industry-options" style="display: none;">
		            <!-- 업종에 따른 세부 항목이 여기에 추가됨 -->
		        </div>
		        <div class="category-step" id="themeStep" style="display: none;">
		            <h3>테마 선택</h3>
		            <button onclick="selectTheme('솔로')">솔로</button>
		            <button onclick="selectTheme('데이트')">데이트</button>
		            <button onclick="selectTheme('친구')">친구</button>
		            <button onclick="selectTheme('회식')">회식</button>
		        </div>
		        <button onclick="searchStores()" class="search-btn" style="display: none;" id="searchBtn">검색</button>
		    </div>
		</div>
		            
        <!-- 가게 목록 컨테이너 -->
        <div class="store-container">
		    <div id="store-list-container" class="store-list">
		        <jsp:include page="store_list.jsp" />
		    </div>
		</div>

		
		<!-- 푸터 섹션 -->
		<div class="footer">
		    <div class="footer-content">
		        <div class="customer-center">
		            <h3><a href="/csr">고객 센터</a></h3>
					<p>010-6286-9140 <span class="time">09:00-18:00</span></p>
		            <p>평일: 전체 문의 상담<br>
		               토요일, 공휴일: 제휴 가게 신청 상담<br>
		               일요일: 휴무</p>
		            <button>카톡 상담 ( 준비 중 )</button>
		            <button onclick="window.location.href='/emailInquery';">이메일 문의</button>
		        </div>
		        <div class="company-links">
		            <ul>
		                <li><a href="/terms">이용 약관</a></li>
		                <li><a href="/storeRegistration">사업자 가게 등록</a></li>
		                <li><a href="/noticeList">공지 사항</a></li>
		                <li><a href="/admin/members">관리자 페이지</a></li>
		            </ul>
		        </div>
		    </div>
		    <div class="footer-bottom">
		        <p>Copyright 2024. , Nyaminyami Co., Ltd. All rights reserved.</p>
		    </div>
		</div>
    </div>
</body>

	<script type="text/javascript">
	    // JSP 표현식으로 user_ID 가져오기
		var userId = "${sessionScope.user_ID != null ? sessionScope.user_ID : ''}";
	
	    function goToStoreDetail(storeId) {	        
	        var url = '/storeDetail?store_ID=' + storeId;
	        if (userId && userId.trim() !== "") {  
	            url += '&user_ID=' + userId;
	        }
	        window.location.href = url;  
	    }
	    
	    function filterByLocation(locationCode, locationName) {
	        console.log("Selected location:", locationName); // 로그 추가
	        document.getElementById("location-btn").innerText = locationName;

	        $.ajax({
	            url: "/storesByLocation",
	            type: "GET",
	            data: { location: locationCode },
	            success: function(stores) {

	                let html = '';
	                stores.forEach(function(store) {
	                    html += '<div class="store-item-box" onclick="goToStoreDetail(' + store.id + ')">' +
	                                '<div class="store-item">' +
	                                    '<img src="/images/store/' + store.mainImage1 + '" alt="' + store.storeName + ' 이미지">' +
	                                '</div>' +
	                                '<div class="store-name">' + store.storeName + '</div>' +
	                            '</div>';
	                });
	                $("#store-list-container").html(html);
	            },
	            error: function() {
	                alert("가게 목록을 불러오는 중 문제가 발생했습니다.");
	            }
	        });
	    }
	</script>
    
    
    <script src="js/home/home-category.js"></script>
</html>
