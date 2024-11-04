<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>가게 등록 폼</title>
    <link rel="stylesheet" href="/css/businessJoin.css"> <!-- 스타일 시트를 연결하세요 -->
</head>
<body>
    <div class="registration-form">
        <h2>사업자 가게 등록</h2>
        
        <form action="/submit-registration" method="post" enctype="multipart/form-data">
            <!-- 기본 정보 섹션 -->
            <section>
                <h3>기본 정보</h3>
                <label for="storeName">가게 이름</label>
                <input type="text" id="storeName" name="storeName" required>
                
                <label for="ownerName">대표자 이름</label>
                <input type="text" id="ownerName" name="ownerName" required>
                
                <label for="businessNumber">사업자 등록번호</label>
                <input type="text" id="businessNumber" name="businessNumber" required>
                
                <label for="contactNumber">연락처</label>
                <input type="tel" id="contactNumber" name="contactNumber" required>
            </section>

            <!-- 위치 정보 섹션 -->
            <section>
                <h3>위치 정보</h3>
                <label for="storeAddress">가게 주소</label>
                <input type="text" id="storeAddress" name="storeAddress" required>
                
                <label for="map">지도에서 위치 설정</label>
                <div id="map" class="map-container">지도 표시 영역</div>
            </section>

            <!-- 가게 상세 정보 섹션 -->
            <section>
                <h3>가게 상세 정보</h3>
                <label for="category">업종 선택</label>
                <select id="category" name="category" required>
                    <option value="restaurant">음식점</option>
                    <option value="cafe">카페</option>
                    <option value="retail">소매업</option>
                    <option value="services">서비스업</option>
                </select>
                
                <label for="businessHours">영업시간</label>
                <input type="text" id="businessHours" name="businessHours" placeholder="예: 09:00 - 22:00">
                
                <label for="storeDescription">가게 설명</label>
                <textarea id="storeDescription" name="storeDescription" rows="4" placeholder="가게에 대해 간략히 설명해주세요."></textarea>
            </section>

            <!-- 이미지 업로드 섹션 -->
            <section>
                <h3>가게 사진 업로드</h3>
                <label for="storeImages">사진 선택</label>
                <input type="file" id="storeImages" name="storeImages" accept="image/*" multiple>
            </section>

            <!-- 제출 버튼 -->
            <button type="submit">등록하기</button>
        </form>
    </div>
</body>
</html>
 --%>