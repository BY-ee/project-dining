<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <!-- 한글 인코딩 -->

<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/templates/head.jsp" %> <!-- head -->

<head>
    <title>사업자 가게 등록</title>
    <link rel="stylesheet" href="css/home/storeRegistration.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/templates/header.jsp" /> <!-- header -->

    <main class="container"> <!-- main content start -->

        <h2>사업자 가게 등록</h2>
        <p>가게 정보를 입력해 주세요. 검토 후 등록이 승인됩니다.</p>

        <form class="store-registration-form" id="storeRegistrationForm" method="post" action="/registerStore" onsubmit="prepareFormData()" enctype="multipart/form-data">
            <!-- 숨겨진 필드 -->
            <input type="hidden" id="hiddenIndustry" name="industry" value="">
            <input type="hidden" id="hiddenSubCategory" name="subcategory" value="">
            <input type="hidden" id="hiddenThemes" name="theme" value="">

			<label for="location">지역</label>
            <select id="location" name="location" required>
			    <option value="마포구">마포구</option>
			    <option value="송파구">송파구</option>
			    <option value="강남/서초구">강남/서초구</option>
			    <option value="성북/종로구">성북/종로구</option>
			    <option value="광진/성동구">광진/성동구</option>
			</select>

            <label for="storeName">가게 이름</label>
            <input type="text" id="storeName" name="storeName" required>

            <label for="ceoName">대표자 이름</label>
            <input type="text" id="ceoName" name="ceoName" required>

            <label for="tel">연락처</label>
            <input type="tel" id="tel" name="tel" required>

            <label for="address">가게 주소</label>
            <div class="address-container">
                <input type="text" id="address" name="address" placeholder="도로명 주소" readonly>
                <button type="button" class="address-search-btn" onclick="openAddressPopup()">주소 검색</button>
                <input type="text" id="detailAddress" name="detailAddress" placeholder="상세 주소">
            </div>

            <!-- 업종 및 테마 선택 -->
            <label>업종 및 테마 선택</label>
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

            <label for="openTime">영업 시간</label>
            <input type="text" id="openTime" name="openTime" placeholder="예: 09:00 - 22:00" required>

            <label for="storeDescription">가게 설명</label>
            <textarea id="storeDescription" name="storeDescription" maxlength="500" placeholder="가게에 대한 간단한 설명을 입력해 주세요."></textarea>
            <div class="char-limit">0자 / 최대 500자</div>

            <label for="storePhotos">가게 대표 사진 (최대 2개)</label>
            <input type="file" id="storePhotos" name="storePhotos" multiple accept="image/*">
            <div id="storePhotosNames" class="file-names"></div>

            <label for="menuPhotos">대표 메뉴 사진 (최대 4개)</label>
            <input type="file" id="menuPhotos" name="menuPhotos" multiple accept="image/*">
            <div id="menuPhotosNames" class="file-names"></div>
            
            <div class="consent-section">
                <label>
                    <input type="checkbox" required> 정보 수집 및 이용 동의
                </label>
                <p class="consent-text">
                    개인정보는 가게 등록 검토를 위해서만 사용되며, 등록 후 1개월 이내에 파기됩니다.
                </p>
            </div>

            <button type="submit" class="submit-btn">등록하기</button>
        </form>
    </main> <!-- main content end -->

	<jsp:include page="/WEB-INF/views/templates/footer.jsp" /> <!-- footer -->
</body>

<!-- 카카오 주소 API 불러오기 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function openAddressPopup() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById("address").value = data.roadAddress;
        }
    }).open();
}
</script>
<script src="js/home/inputfile.js"></script>
<script src="/js/home/storeRegistration.js"></script>
</html>
