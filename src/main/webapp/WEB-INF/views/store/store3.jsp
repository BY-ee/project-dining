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
    <link rel="stylesheet" type="text/css" href="/css/store/store3.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

<% 
	String user_ID = request.getParameter("user_ID");
	String store_ID = request.getParameter("store_ID");
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
        <button id="likeButton" class="like-button">❤️ 찜하기 <span id="likeCount">0</span></button>
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
            <button aria-label="이전 슬라이드" onclick="moveToSlide(currentSlideIndex - 1)"></button>
            <button aria-label="다음 슬라이드" onclick="moveToSlide(currentSlideIndex + 1)"></button>
        </div>
        <div class="store-info">
            <strong>가게주소:</strong> 서울 강남구 테헤란로7길 7 에스코빌딩 5~7층<br>
            <strong>영업시간:</strong> 월 ~ 토 02:00에 영업종료<br>
            <strong>전화번호:</strong> 02-1234-5678<br>
            <strong>가게설명:</strong> 분위기 좋은 레스토랑<br>
        </div>
    </div>

    <!-- 메뉴 가격 섹션 -->
    <div class="section menu-price-section">
        <div class="section-title">메뉴 가격 목록</div>
        <div class="menu-card">
            <img src="img/pasta.jpg">
            <div class="menu-info">
                <p class="menu-name">감자</p>
                <p class="menu-description">감자, 간장 글레이즈, 수제 아이올리</p>
                <p class="menu-price">9,000원</p>
            </div>
        </div>
        <div class="menu-card">
            <img src="img/food.jpg">
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
            <img src="img/pizza.jpg">
            <div class="menu-info">
                <p class="menu-name">시금치</p>
                <p class="menu-description">시금치 페스토, 삼겹살, 오르끼에떼</p>
                <p class="menu-price">19,000원</p>
            </div>
        </div>
    </div>
	
	<!-- 메뉴 음식 사진 슬라이더 섹션 -->
<div class="section menu-photo-container">
    <div class="section-title">메뉴 사진 모음</div>
    <div class="menu-slider">
        <div class="menu-slide"><img src="img/pasta.jpg"></div>
        <div class="menu-slide"><img src="img/food.jpg"></div>
        <div class="menu-slide"><img src="img/pizza.jpg"></div>
    </div>
    <div class="menu-slider-nav">
    	<button class="prev-button" aria-label="이전 슬라이드">&#10094;</button>
	    <button class="next-button" aria-label="다음 슬라이드">&#10095;</button>
</div>
    </div>

    <!-- 지도 섹션 -->
    <div class="section map-section">
        <div class="section-title">가게 상세지도</div>
        <div id="map" class="map-container"></div>
    </div>

    <!-- 리뷰 섹션 -->
    <div class="section review-section">
       <div class="review-title">리뷰 목록 (<span id="reviewCount">0</span>)</div>

        <div class="sort-buttons">
            <button onclick="sortReviewsByDate()">작성일자 순</button>
            <button onclick="sortReviewsByRating()">별점 순</button>
        </div>

        <div id="review-list"></div>
        <div class="pagination" id="pagination"></div>
    </div>

	<!-- 리뷰 입력 섹션 -->
	<div class="review-input-section">
	    <h3>리뷰 작성하기</h3>
	    <form id="reviewForm" action="/submitReview" method="post">
	        <!-- user_ID와 store_ID를 hidden input으로 설정하여 서버에서 전달 -->
	    <input type="hidden" name="user_id" value="<%= user_ID %>">
		<input type="hidden" name="store_id" value="<%= store_ID %>">
	
	        <label>작성자:</label>
    		<span>${sessionScope.nickname}</span>
	        <select id="reviewRating" name="score">
	            <option value="5.0">5점 - 아주 좋아요</option>
	            <option value="4.0">4점 - 좋아요</option>
	            <option value="3.0">3점 - 보통이에요</option>
	            <option value="2.0">2점 - 별로에요</option>
	            <option value="1.0">1점 - 싫어요</option>
	        </select>
	        <textarea id="reviewText" name="review" placeholder="리뷰 내용을 입력하세요" required></textarea>
	        <button type="button" onclick="addReview(event)">리뷰 작성</button>
	    </form>
	</div>
</div>

<!-- 외부 JS 파일 연결 -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=eyf1ptej0y"></script>


<!-- <script src="/js/store/store3.js"></script>
 -->
 
<script type="text/javascript">
    $(document).ready(function(){
        loadReviews();
    });

    function addReview(event) {
        event.preventDefault(); // 기본 폼 제출 방지

        const userId = parseInt('<%= user_ID %>');
        const storeId = parseInt('<%= store_ID %>');
        const reviewRating = parseFloat($('#reviewRating').val());
        const reviewText = $('#reviewText').val();
        
        console.log("Injected userId:", userId);
        console.log("Injected storeId:", storeId);

        $.ajax({
            url: '/submitReview',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                user_id: userId, 
                store_id: storeId,
                score: reviewRating,
                review: reviewText,
            }),
            success: function(response) {
                // 성공적으로 리뷰가 추가되었을 때 처리
                loadReviews(); // 리뷰 새로고침
            },
            error: function(error) {
                // 오류 처리
                console.error("Error submitting review:", error);
            }
        });
    }

    function loadReviews() {
        $.ajax({
            url: '/getReviews?store_id=' + $('[name="store_id"]').val(),
            method: 'GET',
            dataType: 'json',
            success: function(reviews) {
                renderReviews(reviews);
                $('#reviewCount').text(reviews.length); // 리뷰 수 업데이트
            },
            error: function(xhr, status, error) {
                console.error('리뷰 데이터를 불러오는 중 오류가 발생했습니다:', error);
            }
        });
    }

    function renderReviews(reviews) {
        var reviewList = $('#review-list');
        reviewList.empty();

        $.each(reviews, function(index, review) {
        	var reviewItem = 
        	    '<div class="review-item">' +
        	        '<div class="review-header">' +
        	            '<span class="review-author">' + review.user_id + '</span>' +
        	            '<span class="review-date">' + review.created_at + '</span>' +
        	        '</div>' +
        	        '<div class="review-rating">' + generateStars(review.score) + '</div>' +
        	        '<div class="review-content">' + review.review + '</div>' +
        	    '</div>';
            reviewList.append(reviewItem);
        });
    }

    function generateStars(rating) {
        var stars = '';
        for (var i = 1; i <= 5; i++) {
            stars += (i <= rating) ? '<span class="star filled">★</span>' : '<span class="star">★</span>';
        }
        return stars;
    }
</script>

</body>
</html>
