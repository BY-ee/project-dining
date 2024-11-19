let currentSlideIndex = 0;

function moveToMainPhotoSlide(slideIndex) {
    const slidesContainer = document.querySelector('.slider');
    const slides = document.querySelectorAll('.slide');

    // 슬라이드 범위 제한
    if (slideIndex < 0) {
        slideIndex = slides.length - 1;
    }
    if (slideIndex >= slides.length) {
        slideIndex = 0;
    }

    // 슬라이드 이동
    slidesContainer.style.transform = `translateX(-${slideIndex * 100}%)`;
    currentSlideIndex = slideIndex;
}

document.addEventListener('DOMContentLoaded', function () {
    const slideButtons = document.querySelectorAll('.slider-nav button');

    slideButtons.forEach((button, index) => {
        button.addEventListener('click', function () {
            moveToMainPhotoSlide(index);
        });
    });

    // 초기 슬라이드 설정
    moveToMainPhotoSlide(0);

    // 메뉴 사진 슬라이더 기능 설정
    const menuSlides = document.querySelectorAll('.menu-slide');
    const totalMenuSlides = menuSlides.length;
    const menuSlider = document.querySelector('.menu-slider');
    let currentMenuSlide = 0;

    function showMenuSlide(index) {
        menuSlider.style.transform = `translateX(-${index * 100}%)`;
        currentMenuSlide = index;
    }

    showMenuSlide(currentMenuSlide);

    // 메뉴 슬라이더 버튼 이벤트 설정
    const nextButton = document.querySelector('.next-button');
    const prevButton = document.querySelector('.prev-button');

    if (nextButton && prevButton) {
        nextButton.addEventListener('click', function () {
            showMenuSlide((currentMenuSlide + 1) % totalMenuSlides);
        });

        prevButton.addEventListener('click', function () {
            showMenuSlide((currentMenuSlide - 1 + totalMenuSlides) % totalMenuSlides);
        });
    } else {
        console.error('슬라이더 내비게이션 버튼을 찾을 수 없습니다.');
    }

    // 찜 상태 초기 설정
    const likeButton = document.getElementById('likeButton');
    let isLiked = false;
    let likeCount = 0;

    const data = {
        user_ID: memberId,
        store_ID: storeId,
    };

    // AJAX 요청으로 초기 찜 상태 확인
    $.ajax({
        url: '/getLikeStatus',
        method: 'GET',
        data: data,
        success: function (response) {
            likeCount = response.likeCount;

            // 로그인 여부 확인 후 찜 상태 반영
            if (typeof memberId !== 'undefined' && memberId !== null && memberId !== 'null') {
                isLiked = response.liked;
                likeButton.classList.toggle('liked', isLiked);
            }

            // UI 업데이트
            document.getElementById('likeCount').textContent = likeCount;
        },
        error: function (xhr, status, error) {
            console.error('초기 찜 상태를 가져오는 데 실패했습니다:', error);
        },
    });

    // 찜 버튼 클릭 이벤트
    likeButton.addEventListener('click', () => {
        if (typeof memberId === 'undefined' || memberId === null || memberId === 'null') {
            // 비로그인 사용자: 로그인 유도 메시지
            alert('로그인 후 찜하기 기능을 사용할 수 있습니다.');
            return;
        }

        // 로그인 사용자: 찜 상태 변경
        isLiked = !isLiked;
        likeCount += isLiked ? 1 : -1;

        document.getElementById('likeCount').textContent = likeCount;
        likeButton.classList.toggle('liked', isLiked);

        // 찜 상태를 서버에 업데이트
        $.ajax({
            url: '/likeStore',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                memberId: memberId,
                storeId: storeId,
                liked: isLiked,
            }),
            success: function (response) {
                likeCount = response.likeCount;
                document.getElementById('likeCount').textContent = likeCount;
                console.log('찜 상태와 누적 카운트가 DB에 저장되었습니다.');
            },
            error: function (xhr, status, error) {
                console.error('찜 상태 저장에 실패했습니다:', error);
            },
        });
    });

    // 네이버 지도 초기화
    if (typeof naver !== 'undefined' && naver.maps) {
        const mapContainer = document.getElementById('map');
        if (mapContainer) {
            const map = new naver.maps.Map('map', {
                center: new naver.maps.LatLng(latitude, longitude),
                zoom: 16,
            });
            new naver.maps.Marker({
                position: new naver.maps.LatLng(latitude, longitude),
                map: map,
            });
        } else {
            console.error('지도를 표시할 #map 요소를 찾을 수 없습니다.');
        }
    } else {
        console.error('네이버 맵을 초기화할 수 없습니다.');
    }
});