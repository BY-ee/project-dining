<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>가게 상세페이지</title>
    <!-- 외부 CSS 파일 연결 -->
    <link rel="stylesheet" type="text/css" href="/css/store/store2.css">
</head>

<body>

<div class="header">
    <h1><a href="/" style="text-decoration: none;">가게 상세페이지</a></h1>
    <div class="nav">
        <button>로그인/회원가입</button>
        <button>☰</button>
    </div>
</div>

<!-- 이동경로 섹션 -->

<%
    String region = (String) request.getAttribute("region");
    String category = (String) request.getAttribute("category");
    String theme = (String) request.getAttribute("theme");
    String storeName = (String) request.getAttribute("storeName");

    region = region != null ? region : "지역 정보 없음";
    category = category != null ? category : "업종 정보 없음";
    theme = theme != null ? theme : "테마 정보 없음";
    storeName = storeName != null ? storeName : "가게 이름 없음";
%>

<div class="breadcrumb">
    <span class="breadcrumb-label">이동경로:</span>
    <a href="/" class="breadcrumb-item">Home</a>
    
    <% if (region != null && !region.isEmpty()) { %>
        <span class="breadcrumb-separator">›</span>
        <a href="/store?region=<%= URLEncoder.encode(region, "UTF-8") %>" class="breadcrumb-item"><%= region %></a>
    <% } else { %>
        <span class="breadcrumb-separator">›</span>
        <span class="breadcrumb-item">지역 정보 없음</span>
    <% } %>

    <% if (category != null && !category.isEmpty()) { %>
        <span class="breadcrumb-separator">›</span>
        <a href="/store?region=<%= URLEncoder.encode(region, "UTF-8") %>&category=<%= URLEncoder.encode(category, "UTF-8") %>" class="breadcrumb-item"><%= category %></a>
    <% } else { %>
        <span class="breadcrumb-separator">›</span>
        <span class="breadcrumb-item">업종 정보 없음</span>
    <% } %>

    <% if (theme != null && !theme.isEmpty()) { %>
        <span class="breadcrumb-separator">›</span>
        <a href="/store?region=<%= URLEncoder.encode(region, "UTF-8") %>&category=<%= URLEncoder.encode(category, "UTF-8") %>&theme=<%= URLEncoder.encode(theme, "UTF-8") %>" class="breadcrumb-item"><%= theme %></a>
    <% } else { %>
        <span class="breadcrumb-separator">›</span>
        <span class="breadcrumb-item">테마 정보 없음</span>
    <% } %>

    <% if (storeName != null && !storeName.isEmpty()) { %>
        <span class="breadcrumb-separator">›</span>
        <span class="breadcrumb-current"><%= storeName %></span>
    <% } else { %>
        <span class="breadcrumb-separator">›</span>
        <span class="breadcrumb-current">가게 이름 없음</span>
    <% } %>
</div>



<div class="container">
    <!-- 가게 이름과 찜 버튼 -->
    <div class="store-header">
        <h2>가게 이름: 냐미냐미 </h2>
        <button id="likeButton" class="like-button" onclick="increaseLikeCount()">❤️ 찜하기 <span id="likeCount">0</span></button>
    </div>

    <!-- 메인 사진 섹션 -->
    <div class="section main-photo">
        <div class="section-title">가게 메인 사진</div>
        <div class="slider" id="slider">
            <div class="slide"><img src="/img/store1.jpg"></div>
            <div class="slide"><img src="/img/store2.jpg"></div>
            <div class="slide"><img src="/img/store3.jpg"></div>
        </div>
        <div class="slider-nav">
            <button aria-label="이전 슬라이드" onclick="prevSlide()">&#10094;</button>
            <button aria-label="다음 슬라이드" onclick="nextSlide()">&#10095;</button>
        </div>
        <div class="store-info">
            <strong>가게 주소:</strong> 서울 강남구 테헤란로7길 7 에스코빌딩 5~7층
        </div>
    </div>

    <!-- 메뉴 가격 섹션 -->
    <div class="section menu-price-section">
        <div class="section-title">메뉴 가격 목록</div>
        <div class="menu-card">
            <img src="img/pasta.jpg" alt="감자 사진">
            <div class="menu-info">
                <p class="menu-name">감자</p>
                <p class="menu-description">감자, 간장 글레이즈, 수제 아이올리</p>
                <p class="menu-price">9,000원</p>
            </div>
        </div>
        <div class="menu-card">
            <img src="img/food.jpg" alt="육회 사진">
            <div class="menu-info">
                <p class="menu-name">육회</p>
                <p class="menu-description">1++한우, 엔다이브, 배 잼</p>
                <p class="menu-price">19,000원</p>
            </div>
        </div>
        <div class="menu-card">
            <div class="default-image">🍴</div>
            <div class="menu-info">
                <p class="menu-name">골뱅이</p>
                <p class="menu-description">골뱅이, 마늘, 버터, 링귀니</p>
                <p class="menu-price">19,000원</p>
            </div>
        </div>
        <div class="menu-card">
            <img src="img/pizza.jpg" alt="시금치 사진">
            <div class="menu-info">
                <p class="menu-name">시금치</p>
                <p class="menu-description">시금치 페스토, 삼겹살, 오르끼에떼</p>
                <p class="menu-price">19,000원</p>
            </div>
        </div>
    </div>
	
	<!-- 메뉴 가격 사진 섹션 추가 -->
	<div class="section menu-photo-container">
	    <div class="section-title">메뉴 사진 모음</div>
	    <div class="photo-gallery">
	        <img src="img/pasta.jpg" alt="감자 사진">
	        <img src="img/food.jpg" alt="육회 사진">
	        <img src="img/golbangi.jpg" alt="골뱅이 사진">
	        <img src="img/spinach.jpg" alt="시금치 사진">
	    </div>
	</div>

    <!-- 지도 섹션 -->
    <div class="section map-section">
        <div class="section-title">가게 상세지도</div>
        <div id="map" class="map-container"></div>
    </div>

    <!-- 리뷰 섹션 -->
    <div class="section review-section">
        <div class="review-title">리뷰 목록</div>

        <div class="sort-buttons">
            <button onclick="sortReviewsByDate()">작성일자 순</button>
            <button onclick="sortReviewsByRating()">별점 순</button>
        </div>

        <div id="review-list"></div>
        <div class="pagination" id="pagination"></div>
    </div>

</div>

<!-- 외부 JS 파일 연결 -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=eyf1ptej0y"></script>
<script src="/js/store/store2.js"></script>

</body>
</html>
