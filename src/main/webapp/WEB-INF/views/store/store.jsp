<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <!-- 한글 인코딩 -->
<%@ page import="java.net.URLEncoder" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    
<!DOCTYPE html>
<html lang="ko">

<head>
    <jsp:include page="/WEB-INF/views/templates/head.jsp" /> <!-- header -->
	
    <title>가게 상세페이지</title>
    <link rel="stylesheet" type="text/css" href="/css/store/store.css">
   
    <!-- JavaScript에서 사용할 userId와 storeId -->
    <script type="text/javascript">
	    var userId = ${user_ID != null ? user_ID : 'null'};
	    var storeId = ${store_ID != null ? store_ID : 'null'};
        var latitude = ${storeDetail.latitude != null ? storeDetail.latitude : "null"};
        var longitude = ${storeDetail.longitude != null ? storeDetail.longitude : "null"};
        
        console.log("userId:", userId);
        console.log("storeId:", storeId);
        console.log("latitude:", latitude);
        console.log("longitude:", longitude);
    </script>
    
</head>

<body>
    <jsp:include page="/WEB-INF/views/templates/header.jsp" /> <!-- header -->

    <c:if test="${not empty pointMessage}">
        <script>
            alert("${pointMessage}");
        </script>
    </c:if>

    <c:if test="${not empty duplicateReviewMessage}">
        <script>alert("${duplicateReviewMessage}");</script>
    </c:if>

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
    <main> <!-- main content start -->
        
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

        <!-- 가게 이름과 찜 버튼 -->
        <div class="container">
            <div class="store-header">
                <h2>가게 이름: ${storeDetail.storeName} </h2>
                <button id="likeButton" class="like-button">❤️ 찜하기 <span id="likeCount">${memberLike.likeCount}</span></button>
            </div>

            <!-- 메인 사진 섹션 -->
            <div class="section main-photo">
                <div class="section-title">가게 메인 사진</div>
                <div class="slider-container"> <!-- 슬라이더 컨테이너 추가 -->
                    <div class="slider" id="slider">
                        <div class="slide"><img src="${storeDetail.mainImage1}" alt="Main Image 1"></div>
                        <div class="slide"><img src="${storeDetail.mainImage2}" alt="Main Image 2"></div>
                    </div>
                </div>
                <div class="slider-nav">
                    <button aria-label="이전 슬라이드" onclick="moveToMainPhotoSlide(currentSlideIndex - 1)"></button>
                    <button aria-label="다음 슬라이드" onclick="moveToMainPhotoSlide(currentSlideIndex + 1)"></button>
                </div>
                <div class="store-info">
                    <strong>가게주소:</strong> ${storeDetail.address}<br>
                    <strong>상세주소:</strong> ${storeDetail.detailAddress}<br>
                    <strong>전화번호:</strong> ${storeDetail.tel}<br>
                    <strong>영업시간:</strong> ${storeDetail.openTime}<br>
                    <strong>가게설명:</strong> ${storeDetail.storeDescription}<br>
                </div>
            </div>


            <!-- 대표 메뉴 섹션 -->
            <div class="section menu-price-section">
                <div class="section-title">대표 메뉴</div>
                <c:forEach var="menu" items="${menuList}">
                    <div class="menu-card">
                        <img src="${menu.menuImage}">
                        <div class="menu-info">
                            <p class="menu-name">${menu.menuName}</p>
                            <p class="menu-description">${menu.menuDescription }</p>
                            <p class="menu-price">${menu.menuPrice}원</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
	
            <!-- 메뉴 음식 사진 슬라이더 섹션 -->
            <div class="section menu-photo-container">
                <div class="section-title">메뉴 사진 모음</div>
                <div class="menu-slider">
                    <c:forEach var="menu" items="${menuList}">
                        <div class="menu-slide"><img src="${menu.menuImage }"></div>
                    </c:forEach>
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

            <!-- 리뷰 목록 섹션 -->
            <jsp:include page="reviews.jsp" />

            <!-- 리뷰 입력 섹션 -->
            <jsp:include page="reviewInput.jsp" />
        </div>
    </main> <!-- main content end -->
	
	<jsp:include page="/WEB-INF/views/templates/footer.jsp" /> <!-- footer -->

<!-- 외부 JS 파일 연결 -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=eyf1ptej0y"></script>
<script src="/js/store/store.js"></script>

</body>
</html>
