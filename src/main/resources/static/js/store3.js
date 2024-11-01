document.addEventListener('DOMContentLoaded', function () {
    // 가게 메인 사진 슬라이더 설정
    let currentSlide = 0;
    const slides = document.querySelectorAll('.slide');
    const totalSlides = slides.length;

    slides.forEach((slide, index) => {
        slide.style.position = 'absolute';
        slide.style.left = `${index * 100}%`;
    });

    function showSlide(index) {
        slides.forEach((slide) => {
            slide.style.transform = `translateX(-${index * 100}%)`;
        });
    }

    showSlide(currentSlide); // 첫 슬라이드 표시

    function nextSlide() {
        currentSlide = (currentSlide + 1) % totalSlides;
        showSlide(currentSlide);
    }

    function prevSlide() {
        currentSlide = (currentSlide - 1 + totalSlides) % totalSlides;
        showSlide(currentSlide);
    }

    // 슬라이더 버튼 이벤트 설정
    const nextSlideButton = document.querySelector('.next-slide-button'); // 다음 버튼 선택자
    const prevSlideButton = document.querySelector('.prev-slide-button'); // 이전 버튼 선택자

    if (nextSlideButton && prevSlideButton) {
        nextSlideButton.addEventListener('click', nextSlide); // 다음 버튼에 클릭 이벤트 연결
        prevSlideButton.addEventListener('click', prevSlide); // 이전 버튼에 클릭 이벤트 연결
    } else {
        console.error('슬라이더 버튼을 찾을 수 없습니다.');
    }

    // 자동 슬라이드
    let slideInterval = setInterval(nextSlide, 3000);
    const slider = document.getElementById('slider');

    if (slider) {
        slider.addEventListener('mouseenter', () => clearInterval(slideInterval));
        slider.addEventListener('mouseleave', () => slideInterval = setInterval(nextSlide, 3000));
    }

    // 메뉴 사진 슬라이더 기능 설정
    let currentMenuSlide = 0;
    const menuSlides = document.querySelectorAll('.menu-slide');
    const totalMenuSlides = menuSlides.length;
    const menuSlider = document.querySelector('.menu-slider');

    function showMenuSlide(index) {
        if (menuSlider) {
            menuSlider.style.transform = `translateX(-${index * 100}%)`;
        }
    }

    showMenuSlide(currentMenuSlide); // 첫 메뉴 슬라이드 표시

    // 메뉴 슬라이더 버튼 이벤트 설정
    const nextButton = document.querySelector('.next-button');
    const prevButton = document.querySelector('.prev-button');

    if (nextButton && prevButton) {
        nextButton.addEventListener('click', function () {
            currentMenuSlide = (currentMenuSlide + 1) % totalMenuSlides;
            showMenuSlide(currentMenuSlide);
        });

        prevButton.addEventListener('click', function () {
            currentMenuSlide = (currentMenuSlide - 1 + totalMenuSlides) % totalMenuSlides;
            showMenuSlide(currentMenuSlide);
        });
    } else {
        console.error('슬라이더 내비게이션 버튼을 찾을 수 없습니다.');
    }

    // 찜하기 버튼 기능
    let isLiked = false;
    let likeCount = 0;

    const likeButton = document.getElementById('likeButton');
    if (likeButton) {
        likeButton.addEventListener('click', () => {
            if (isLiked) {
                likeCount--;
            } else {
                likeCount++;
            }

            document.getElementById('likeCount').textContent = likeCount;
            isLiked = !isLiked;
        });
    }

    // 리뷰 목록 관리
    let reviews = [];
    let currentPage = 1;
    const reviewsPerPage = 5;

    function generateSampleReviews() {
        for (let i = 1; i <= 20; i++) {
            reviews.push({
                author: `사용자${i}`,
                rating: Math.floor(Math.random() * 5) + 1,
                content: `이것은 샘플 리뷰 내용입니다. 리뷰 번호: ${i}`,
                date: `2023-10-${(i % 30) + 1}`
            });
        }
    }

    function renderReviews() {
        const reviewList = document.getElementById('review-list');
        reviewList.innerHTML = '';

        const startIndex = (currentPage - 1) * reviewsPerPage;
        const endIndex = startIndex + reviewsPerPage;
        const currentReviews = reviews.slice(startIndex, endIndex);

        currentReviews.forEach(review => {
            const reviewItem = document.createElement('div');
            reviewItem.classList.add('review-item');

            const reviewHeader = document.createElement('div');
            reviewHeader.classList.add('review-header');

            const reviewAuthor = document.createElement('span');
            reviewAuthor.classList.add('review-author');
            reviewAuthor.textContent = review.author;

            const reviewRating = document.createElement('div');
            reviewRating.classList.add('review-rating');

            for (let i = 1; i <= 5; i++) {
                const star = document.createElement('span');
                star.classList.add('star');
                star.textContent = '★';
                if (i <= review.rating) {
                    star.classList.add('filled');
                }
                reviewRating.appendChild(star);
            }

            reviewHeader.appendChild(reviewAuthor);
            reviewHeader.appendChild(reviewRating);

            const reviewDate = document.createElement('div');
            reviewDate.classList.add('review-date');
            reviewDate.textContent = review.date;

            const reviewContent = document.createElement('div');
            reviewContent.classList.add('review-content');
            reviewContent.textContent = review.content;

            reviewItem.appendChild(reviewHeader);
            reviewItem.appendChild(reviewDate);
            reviewItem.appendChild(reviewContent);

            reviewList.appendChild(reviewItem);
        });

        renderPagination();
    }

    function renderPagination() {
        const pagination = document.getElementById('pagination');
        pagination.innerHTML = '';

        const totalPages = Math.ceil(reviews.length / reviewsPerPage);

        if (currentPage > 1) {
            const prevButton = document.createElement('button');
            prevButton.textContent = '이전';
            prevButton.addEventListener('click', () => {
                currentPage--;
                renderReviews();
            });
            pagination.appendChild(prevButton);
        }

        for (let i = 1; i <= totalPages; i++) {
            const pageButton = document.createElement('button');
            pageButton.textContent = i;

            if (i === currentPage) {
                pageButton.disabled = true;
            }

            pageButton.addEventListener('click', () => {
                currentPage = i;
                renderReviews();
            });

            pagination.appendChild(pageButton);
        }

        if (currentPage < totalPages) {
            const nextButton = document.createElement('button');
            nextButton.textContent = '다음';
            nextButton.addEventListener('click', () => {
                currentPage++;
                renderReviews();
            });
            pagination.appendChild(nextButton);
        }
    }

    function loadReviews() {
        generateSampleReviews();
        renderReviews();
        document.getElementById('reviewCount').textContent = reviews.length;
    }

    loadReviews();

    document.getElementById('reviewForm').addEventListener('submit', function (e) {
        e.preventDefault();
        addReview();
    });

    function addReview() {
        const reviewerName = document.getElementById('reviewerName').value;
        const reviewRating = parseInt(document.getElementById('reviewRating').value);
        const reviewText = document.getElementById('reviewText').value;
        const reviewDate = new Date().toISOString().split('T')[0];

        const review = {
            author: reviewerName,
            rating: reviewRating,
            content: reviewText,
            date: reviewDate
        };

        reviews.unshift(review);
        renderReviews();
        document.getElementById('reviewCount').textContent = reviews.length;
        document.getElementById('reviewForm').reset();
    }
});

// 네이버 지도 초기화
function initMap() {
    const mapContainer = document.getElementById('map');
    if (mapContainer) {
        const map = new naver.maps.Map('map', {
            center: new naver.maps.LatLng(37.5013068, 127.0396),
            zoom: 16
        });

        new naver.maps.Marker({
            position: new naver.maps.LatLng(37.5013068, 127.0396),
            map: map
        });
    } else {
        console.error('지도를 표시할 #map 요소를 찾을 수 없습니다.');
    }
}

document.addEventListener('DOMContentLoaded', function () {
    if (typeof naver !== 'undefined' && naver.maps) {
        naver.maps.onJSContentLoaded = initMap;
    } else {
        console.error('네이버 맵을 초기화할 수 없습니다.');
    }
});
