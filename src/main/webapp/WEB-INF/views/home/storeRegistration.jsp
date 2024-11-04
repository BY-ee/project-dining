<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사업자 가게 등록</title>
    <link rel="stylesheet" href="css/home/storeRegistration.css">
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
        <h2>사업자 가게 등록</h2>
        <p>가게 정보를 입력해 주세요. 검토 후 등록이 승인됩니다.</p>

        <form class="store-registration-form">
            <label for="storeName">가게 이름</label>
            <input type="text" id="storeName" name="storeName" required>

            <label for="ownerName">대표자 이름</label>
            <input type="text" id="ownerName" name="ownerName" required>

            <label for="contact">연락처</label>
            <input type="tel" id="contact" name="contact" required>

            <label for="address">가게 주소</label>
			<div class="address-container">
			    <input type="text" id="address" name="address" placeholder="도로명 주소" readonly>
			    <button type="button" class="address-search-btn" onclick="openAddressPopup()">주소 검색</button>
			    <input type="text" id="address" name="address" placeholder="상세 주소" readonly>
			    
			</div>
            <label for="category">업종</label>
            <select id="category" name="category" required>
                <option value="">선택</option>
                <option value="restaurant">음식점</option>
                <option value="cafe">카페</option>
                <option value="bar">술집</option>
            </select>

            <label for="businessHours">영업 시간</label>
            <input type="text" id="businessHours" name="businessHours" placeholder="예: 09:00 - 22:00" required>

            <label for="description">가게 설명</label>
            <textarea id="description" name="description" maxlength="500" placeholder="가게에 대한 간단한 설명을 입력해 주세요."></textarea>
            <div class="char-limit">0자 / 최대 500자</div>


            <label for="menuPhotos">대표 메뉴 사진 (최대 4개)</label>
			<input type="file" id="menuPhotos" name="menuPhotos" multiple accept="image/*">
			<div id="menuPhotosNames" class="file-names"></div> <!-- 선택된 파일 이름 표시 -->
            

            <label for="storePhotos">가게 대표 사진 (최대 2개)</label>
            <input type="file" id="storePhotos" name="storePhotos" multiple accept="image/*">
            <div id="storePhotosNames" class="file-names"></div> <!-- 선택된 파일 이름 표시 -->
            

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
    </div>

    <div class="footer">
        <div class="footer-content">
            <div class="customer-center">
                <h3><a href="/csr">고객 센터</a></h3>
                <p>010-6286-9140 <span class="time">09:00-18:00</span></p>
                <p>평일: 전체 문의 상담<br>
                   토요일, 공휴일: 제휴 가게 신청 상담<br>
                   일요일: 휴무</p>
                <button class="contact-button">카톡 상담 ( 준비 중 )</button>
                <button class="contact-button" onclick="window.location.href='/emailInquery';">이메일 문의</button>
            </div>
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
	<!-- 카카오 주소 API 불러오기 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
function openAddressPopup() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 검색된 주소 값을 가져와서, 주소 입력 필드에 넣어줍니다.
            document.getElementById("address").value = data.roadAddress;
        }
    }).open();
}
</script>
 <script src="js/home/inputfile.js"></script>
</html>