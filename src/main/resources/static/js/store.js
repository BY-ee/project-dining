var mapOptions = { center: new naver.maps.LatLng(37.498095, 127.027610), zoom: 15 };
var map = new naver.maps.Map('map', mapOptions);

let currentIndex = 0;
const slides = document.querySelectorAll('#slider .slide');
let slideInterval = setInterval(nextSlide, 3000);

function showSlide(index) {
    slides.forEach((slide, i) => { slide.style.transform = `translateX(-${index * 100}%)`; });
}

function nextSlide() { currentIndex = (currentIndex + 1) % slides.length; showSlide(currentIndex); }
function prevSlide() { currentIndex = (currentIndex - 1 + slides.length) % slides.length; showSlide(currentIndex); }

function increaseLike(element) {
    const likeCount = element.querySelector(".like-count");
    likeCount.textContent = parseInt(likeCount.textContent) + 1;
}

function sortReviewsByDate() {
    reviews.sort((a, b) => new Date(b.date) - new Date(a.date));
    renderReviews(currentPage);
}

function sortReviewsByRating() {
    reviews.sort((a, b) => b.rating - a.rating);
    renderReviews(currentPage);
}

// 페이징 기능을 포함한 리뷰 표시
const reviews = [
    { reviewer: "김철수", date: "2024-10-01", rating: 4, text: "맛있고 분위기 좋은 가게였습니다!" },
    { reviewer: "박영희", date: "2024-10-02", rating: 5, text: "친절한 직원들과 깔끔한 인테리어가 마음에 들었어요." },
    { reviewer: "이민수", date: "2024-10-03", rating: 3, text: "가격 대비 훌륭한 맛이었습니다." },
    { reviewer: "최준혁", date: "2024-10-04", rating: 5, text: "정말 멋진 경험이었어요!" },
    { reviewer: "김하나", date: "2024-10-05", rating: 4, text: "친절한 서비스에 감사드립니다." },
    { reviewer: "박수빈", date: "2024-10-06", rating: 2, text: "음식이 조금 기대 이하였습니다." },
    { reviewer: "이서준", date: "2024-10-07", rating: 4, text: "매우 만족스럽습니다." },
    { reviewer: "오현우", date: "2024-10-08", rating: 3, text: "보통이었어요." },
    { reviewer: "정예지", date: "2024-10-09", rating: 5, text: "훌륭한 분위기와 맛있는 음식!" },
    { reviewer: "조민아", date: "2024-10-10", rating: 4, text: "가격 대비 만족했습니다." },
    { reviewer: "최민수", date: "2024-10-11", rating: 3, text: "가격에 비해 조금 아쉬웠어요." },
    { reviewer: "홍길동", date: "2024-10-12", rating: 5, text: "완벽한 경험이었습니다!" },
    { reviewer: "김영희", date: "2024-10-13", rating: 4, text: "재방문하고 싶습니다." },
    { reviewer: "박찬호", date: "2024-10-14", rating: 5, text: "추천드려요!" },
    { reviewer: "이유진", date: "2024-10-15", rating: 3, text: "보통입니다." },
    { reviewer: "정수민", date: "2024-10-16", rating: 2, text: "조금 아쉬웠어요." },
    { reviewer: "김다현", date: "2024-10-17", rating: 4, text: "전반적으로 만족합니다." },
    { reviewer: "박세훈", date: "2024-10-18", rating: 5, text: "정말 좋아요!" },
    { reviewer: "윤지훈", date: "2024-10-19", rating: 3, text: "괜찮은 가게입니다." },
    { reviewer: "장수현", date: "2024-10-20", rating: 4, text: "친구들과 함께 가기 좋습니다." }
];

const reviewsPerPage = 10;
let currentPage = 1;

function renderReviews(page) {
    const reviewList = document.getElementById("review-list");
    reviewList.innerHTML = "";

    const start = (page - 1) * reviewsPerPage;
    const end = start + reviewsPerPage;
    const paginatedReviews = reviews.slice(start, end);

    paginatedReviews.forEach(review => {
        const reviewItem = document.createElement("div");
        reviewItem.className = "review-item";
        reviewItem.setAttribute("data-date", review.date);
        reviewItem.setAttribute("data-rating", review.rating);
        reviewItem.innerHTML = `
            <div class="reviewer">${review.reviewer} <span class="star-rating">${'★'.repeat(review.rating)}${'☆'.repeat(5 - review.rating)}</span></div>
            <div class="review-date">작성일자: ${review.date}</div>
            <div class="review-text">${review.text}</div>
            <div class="like-button" onclick="increaseLike(this)">❤️ 좋아요 <span class="like-count">0</span></div>
        `;
        reviewList.appendChild(reviewItem);
    });

    renderPagination();
}

function renderPagination() {
    const pagination = document.getElementById("pagination");
    pagination.innerHTML = "";

    const totalPages = Math.ceil(reviews.length / reviewsPerPage);

    for (let i = 1; i <= totalPages; i++) {
        const button = document.createElement("button");
        button.innerText = i;
        if (i === currentPage) {
            button.style.fontWeight = 'bold';
        }
        button.onclick = () => {
            currentPage = i;
            renderReviews(currentPage);
        };
        pagination.appendChild(button);
    }
}

renderReviews(currentPage);
