<!-- community.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <jsp:include page="/WEB-INF/views/templates/head.jsp" /> <!-- header -->
    <script src="/js/community/createChatRoomByTheme.js"></script> <!-- 채팅 -->
    <script src="/js/community/chatDropDown.js"></script>
</head>
<body>

    <jsp:include page="/WEB-INF/views/templates/header.jsp" /> <!-- header -->

    <!-- 채팅방 생성 팝업 -->
    <div id="create-form-popup" style="display: none;" class="popup-container">
        <div class="popup-content">
            <h2>채팅방 생성</h2>
            <form id="chat-room-form" class="form-layout">
                <label for="roomName">채팅방 이름:</label>
                <input type="text" id="roomName" name="roomName" required><br><br>
                
                <label for="location">지역:</label>
                <select id="location" name="location" required>
			    	<option value="마포구">마포구</option>
			    	<option value="송파구">송파구</option>
			    	<option value="강남/서초구">강남/서초구</option>
			    	<option value="성북/종로구">성북/종로구</option>
			    	<option value="광진/성동구">광진/성동구</option>
				</select>
				
                <label for="maxParticipants">정원:</label>
                <input type="number" id="maxParticipants" name="maxParticipants" required><br><br>
                
                <label for="theme">테마:</label>
	            <div id="categoryPopup" class="category-popup">
	                <div class="category-step">
	                    <h3>업종</h3>
	                    <button type="button" class="industry-btn" data-industry="음식점" onclick="selectIndustry('음식점')">음식점</button>
	                    <button type="button" class="industry-btn" data-industry="카페" onclick="selectIndustry('카페')">카페</button>
	                    <button type="button" class="industry-btn" data-industry="술집" onclick="selectIndustry('술집')">술집</button>
	                </div>
	
	                <div id="selectedIndustryOptions" class="selected-industry-options" style="display: none;">
	                    <!-- 세부 항목 버튼이 동적으로 추가됩니다. -->
	                </div>
	
	                <div class="category-step" id="themeStep" style="display: none;">
	                    <h3>테마</h3>
	                    <button type="button" class="theme-btn" data-theme="혼밥" onclick="selectTheme('혼밥')">혼밥</button>
	                    <button type="button" class="theme-btn" data-theme="데이트" onclick="selectTheme('데이트')">데이트</button>
	                    <button type="button" class="theme-btn" data-theme="친구" onclick="selectTheme('친구')">친구</button>
	                    <button type="button" class="theme-btn" data-theme="회식" onclick="selectTheme('회식')">회식</button>
	                </div>
	            </div>
	            
                <label for="recruitmentDuration">모집 기간(분):</label>
                <input type="number" id="recruitmentDuration" name="recruitmentDuration" required><br><br>
                
                <label for="additionalDescription">추가 설명:</label>
                <textarea id="additionalDescription" name="additionalDescription"></textarea><br><br>
                
                <div class="button-group">
                    <button type="submit" class="primary-btn">생성</button>
                    <button type="button" id="cancel-create-popup" class="secondary-btn">취소</button>
                </div>
            </form>
        </div>
    </div>
    <div id="create-form-popup-overlay" class="popup-overlay" style="display: none;"></div>
   
    
    <!-- 채팅방 목록 -->
    <div class="chat-home-content">
	    <!-- 검색 필터 -->
	    <div class="filter-chat-section">
    <!-- Left Section -->
    <div class="filter-chat-buttons left-section">
        <!-- 지역 드롭다운 -->
        <div class="location-chat-dropdown">
            <button class="location-chat-btn" id="location-chat-btn">지역 선택</button>
	            <div class="location-chat-menu" id="location-chat-menu" style="display: none;">
	                <a href="#" onclick="filterByLocation('ALL', '전체')">전체</a>
	                <a href="#" onclick="filterByLocation('MAPO', '마포구')">마포구</a>
	                <a href="#" onclick="filterByLocation('SONGPA', '송파구')">송파구</a>
	                <a href="#" onclick="filterByLocation('GANGNAM', '강남/서초구')">강남/서초구</a>
	                <a href="#" onclick="filterByLocation('SEONGBUK', '성북/종로구')">성북/종로구</a>
	                <a href="#" onclick="filterByLocation('GWANGJIN', '광진/성동구')">광진/성동구</a>
	            </div>
	        </div>
	
	        <!-- 업종 드롭다운 -->
	        <div class="location-chat-dropdown">
	            <button class="location-chat-btn" id="industry-chat-btn">업종 선택</button>
	            <div class="location-chat-menu" id="industry-chat-menu" style="display: none;">
	                <a href="#" onclick="filterByIndustry('', '전체')">전체</a>
	                <a href="#" onclick="filterByIndustry('음식점', '음식점')">음식점</a>
	                <a href="#" onclick="filterByIndustry('카페', '카페')">카페</a>
	                <a href="#" onclick="filterByIndustry('술집', '술집')">술집</a>
	            </div>
	        </div>
	
	        <!-- 세부 업종 드롭다운 -->
	        <div class="location-chat-dropdown">
	            <button class="location-chat-btn" id="subCategory-chat-btn">세부 업종 선택</button>
	            <div class="location-chat-menu" id="subCategory-chat-menu" style="display: none;">
	                <!-- 업종 변경 시 동적으로 세부 항목이 추가됨 -->
	            </div>
	        </div>
	
	        <!-- 테마 드롭다운 -->
	        <div class="location-chat-dropdown">
	            <button class="location-chat-btn" id="theme-chat-btn">테마 선택</button>
	            <div class="location-chat-menu" id="theme-chat-menu" style="display: none;">
	                <a href="#" onclick="filterByTheme('', '전체')">전체</a>
	                <a href="#" onclick="filterByTheme('데이트', '데이트')">데이트</a>
	                <a href="#" onclick="filterByTheme('친구', '친구')">친구</a>
	                <a href="#" onclick="filterByTheme('회식', '회식')">회식</a>
	            </div>
	        </div>
	    </div>
	
	    <!-- Right Section -->
	    <div class="filter-chat-buttons right-section">
	        <button id="show-create-popup" class="create-btn">채팅방 생성</button>
	    </div>
	</div>
	
	    <!-- 채팅 목록 -->
	    <div class="chat-list">
	        <!-- `fetchChatRooms()` 함수가 이곳에 채팅 목록 항목을 추가 -->
	    </div>
	</div>
    
    
    <jsp:include page="/WEB-INF/views/templates/footer.jsp" />
    

</body>
</html>