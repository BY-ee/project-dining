<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <!-- 한글 인코딩 -->
<%@ page import="com.project.dto.Login" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/templates/head.jsp" %> <!-- head -->

<head>
    <link rel="stylesheet" type="text/css" href="/css/home/homeCategory.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/templates/header.jsp" /> <!-- header -->

    <main class="content"> <!-- main content start -->

        <!-- 위치 및 카테고리 드롭다운 메뉴 -->
        <div class="filter-container">
	        <div class="location-dropdown">
	            <button class="location-btn" id="location-btn">지역 선택</button>
	            <div class="location-menu">
				    <a href="#" onclick="filterByLocation('ALL', '지역 선택')">지역 선택</a>
				    <a href="#" onclick="filterByLocation('MAPO', '마포구')">마포구</a>
				    <a href="#" onclick="filterByLocation('SONGPA', '송파구')">송파구</a>
				    <a href="#" onclick="filterByLocation('GANGNAM', '강남/서초구')">강남/서초구</a>
				    <a href="#" onclick="filterByLocation('SEONGBUK', '성북/종로구')">성북/종로구</a>
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
		        <div class="category-step" id="themeStep">
		            <h3>테마 선택</h3>
		            <button onclick="selectTheme('혼밥')">혼밥</button>
		            <button onclick="selectTheme('데이트')">데이트</button>
		            <button onclick="selectTheme('친구')">친구</button>
		            <button onclick="selectTheme('회식')">회식</button>
		        </div>
		        <button onclick="searchStores()" class="search-btn" style="display: none;" id="searchBtn">검색</button>
		    </div>
		    </div>

			<!-- 게시글 정렬 -->
			<div class="orderby-criteria">
				<select id="orderOptions" onchange="orderOptionChoice()">
					<option value="recent" id="recent">최신순</option>
					<option value="likes" id="likes">좋아요순</option>
					<option value="comments" id="comments">댓글순</option>
				</select>
			</div>


		
       
        <!-- 가게 목록 컨테이너 -->
        <div class="store-container">
		    <div id="store-list-container" class="store-list">
		        <jsp:include page="storeList.jsp" />
		    </div>
		</div>
    </main> <!-- main content end -->

	<jsp:include page="/WEB-INF/views/templates/footer.jsp" /> <!-- footer -->

	<script type="text/javascript">
	    // JSP 표현식으로 user_ID 가져오기
		var userId = "${sessionScope.user_ID != null ? sessionScope.user_ID : ''}";
		let selectedLocation = ""; // 추가된 변수

	
	    function goToStoreDetail(storeId) {	        
	        var url = '/storeDetail?store_ID=' + storeId;
	        if (userId && userId.trim() !== "") {  
	            url += '&user_ID=' + userId;
	        }
	        window.location.href = url;  
	    }
	    
	    function filterByLocation(locationCode, locationName) {
	        selectedLocation = locationCode; // 지역 값 저장
	        console.log("Selected location:", locationName); // 로그 추가
	        document.getElementById("location-btn").innerText = locationName;

	        $.ajax({
	            url: "/storesByLocation",
	            type: "GET",
	            data: { location: selectedLocation },
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
	    
	    function filterByCategory(industry, subCategory, theme) {
	    	
	        console.log("Sending filter criteria:", {
	            industry: industry,
	            subCategory: subCategory,
	            themes: theme.join(",")
	        });
	        
	        $.ajax({
	            url: "/storesByCategory",
	            type: "GET",
	            data: {
	                industry: industry,
	                subCategory: subCategory,
	                theme: theme.join(","),
	                location: selectedLocation  // selectedLocation이 필요하다면 이 변수도 정의되어 있어야 합니다.
	            },
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
</body>
</html>
