<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>가게 등록</title>
    <link rel="stylesheet" href="/css/admin/admin.css">
    <link rel="stylesheet" href="/css/admin/adminApprove.css">
</head>
<body>
    <div class="content">
        <h2 style="margin-bottom: 20px;">사업자 가게 등록</h2>
        
        <section>
            <h3>기본 정보</h3>
            <label for="storeName">가게 이름</label>
            <p id="storeName">모수</p>
            
            <label for="ownerName">대표자 이름</label>
            <p id="ownerName">에드워드 리</p>
            
            <label for="businessNumber">사업자 등록번호</label>
            <p id="businessNumber">123-456-7890</p>
            
            <label for="contactNumber">연락처</label>
            <p id="contactNumber">010-1234-5678</p>
        </section>

        <section>
            <h3>위치 정보</h3>
            <label for="storeAddress">가게 주소</label>
            <p id="storeAddress">서울시 강남구 테헤란로</p>
            
            <label for="map">지도에서 위치 설정</label>
            <div id="map" class="map-container">지도 표시 영역</div>
        </section>

        <section>
            <h3>가게 상세 정보</h3>
            <label for="location">위치</label>
            <p id="location">서울시 송파구</p>
            
            <label for="category">종류</label>
            <p id="category">한식</p>

            <label for="theme">테마</label>
            <p id="theme">데이트, sns</p>
            
            <label for="businessHours">영업시간</label>
            <p id="businessHours">월요일은 9시부터 저녁 10시까지 나머지는 24시간</p>
            
            <label for="storeDescription">가게 설명</label>
            <p id="storeDescription">
                기습 공격에 성공했다.
                블랙핑크가 갖고 있던 강렬한 모습도, 솔로 데뷔곡 ‘On the ground’의 팝 스타적 면모도 과감히 내려놓았다.
                약 10년 전 싸이의 ‘강남스타일’이 그랬던 것처럼 익살스러운 요소가 가장 먼저 음악을 지배한다.
                특히 한국 사람들에게 친근한 술 게임의 멜로디를 차용했다.
                재밌는 점은 음주를 의도적으로 멀리하는 올해의 ‘소버 큐리어스(Sober Curious)’ 유행과는 정반대의 콘셉트를 가져와
                모두를 자신의 노래로 취하게 만들었다는 점이다.

                화룡점정은 단연 비트와 찰떡으로 맞아떨어지는 브루노 마스의 보컬에 있지만 로제도 그에 못지않게 매력을 뽐낸다.
                가벼운 노래에 맞춘 듯 힘을 빼고 부른 창법이나, 노래보다는 게임 구호 외치기에 가까운 후렴 부분이 그렇다.
                익숙한데 새롭고, 쉬운데 우습지 않고, 재밌는데 가볍지 않다.
                이제 대한민국(아니, 전 세계)에서 로제와 브루노 마스의 ‘Apt.’는 그 옛날 윤수일보다, 치솟은 집값보다 유명해졌다.
                2024년 K팝 중 가장 높은 1층은 로제의 명의가 됐다.
            </p>
        </section>

        <section>
            <h3>가게 사진</h3>
            <div id="storeImages" class="map-container">가게 사진 ( ~ 2개)</div>

            <h3>메뉴 사진</h3>
            <div id="storeImages" class="map-container">메뉴 사진 ( ~ 4개)</div>
        </section>

        <div style="display: flex; justify-content: space-evenly;">
            <form>
                <button class="btn btn-submit">등록</button>
            </form>

            <form>
                <button class="btn btn-reject">반려</button>
            </form>
        </div>
    </div>
</body>
</html>