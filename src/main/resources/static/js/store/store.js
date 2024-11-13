document.addEventListener('DOMContentLoaded', function() {
	// 메인 사진 슬라이드 기능 설정
	const slidesContainer = document.querySelector('.slider');
	const slides = document.querySelectorAll('.slide');
	const slideButtons = document.querySelectorAll('.slider-nav button');
	let currentSlideIndex = 0;

	function moveToMainPhotoSlide(slideIndex) {
		slidesContainer.style.transform = `translateX(-${slideIndex * 100}%)`;
		slideButtons.forEach(button => button.classList.remove('active'));
		slideButtons[slideIndex].classList.add('active');
		currentSlideIndex = slideIndex;
	}

	slideButtons.forEach((button, index) => {
		button.addEventListener('click', function() {
			moveToMainPhotoSlide(index);
		});
	});

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
		nextButton.addEventListener('click', function() {
			showMenuSlide((currentMenuSlide + 1) % totalMenuSlides);
		});

		prevButton.addEventListener('click', function() {
			showMenuSlide((currentMenuSlide - 1 + totalMenuSlides) % totalMenuSlides);
		});
	} else {
		console.error('슬라이더 내비게이션 버튼을 찾을 수 없습니다.');
	}

	// 찜하기 버튼 기능
	const likeButton = document.getElementById('likeButton');
	let isLiked = false;
	let likeCount = 0;

	// 초기 상태 설정
	window.addEventListener('DOMContentLoaded', () => {
		$.ajax({
			url: '/getLikeStatus',  // 초기 찜 상태와 누적 찜 수를 가져오는 API 엔드포인트
			method: 'GET',
			data: {
				memberId: userId,
				storeId: storeId
			},
			success: function(response) {
				isLiked = response.isLiked; // 서버에서 받은 초기 찜 상태
				likeCount = response.likeCount; // 서버에서 받은 storeId에 대한 누적 찜 수

				// UI 업데이트
				document.getElementById('likeCount').textContent = likeCount;
				likeButton.classList.toggle('liked', isLiked); // 찜 상태에 따라 버튼 색상 변경
			},
			error: function(xhr, status, error) {
				console.error('초기 찜 상태를 가져오는 데 실패했습니다:', error);
			}
		});
	});

	if (likeButton) {
		likeButton.addEventListener('click', () => {
			isLiked = !isLiked; // 현재 찜 상태 반전
			likeCount += isLiked ? 1 : -1;  // 찜 상태에 따라 카운트 증가 또는 감소

			// UI 업데이트
			document.getElementById('likeCount').textContent = likeCount;
			likeButton.classList.toggle('liked', isLiked);

			
			// 서버에 찜 상태 전송 및 최신 카운트 요청
			$.ajax({
				url: 'likeStore',  // 서버의 API 엔드포인트
				method: 'POST',
				contentType: 'application/json',
				data: JSON.stringify({
					memberId: userId,  // 세션에서 받아온 userId
					storeId: storeId,
					isLiked: isLiked  // 찜 상태 전달
				}),
				success: function(response) {
					likeCount = response.likeCount; // 서버에서 반환된 최신 카운트 값 반영
					document.getElementById('likeCount').textContent = likeCount; // UI 업데이트
					console.log('찜 상태와 누적 카운트가 DB에 저장되었습니다.');
				},
				error: function(xhr, status, error) {
					console.error('찜 상태 저장에 실패했습니다:', error);
				}
			});
		});
	}

	// 리뷰 정렬 및 렌더링 기능
	//    let reviews = [];
	//    let currentPage = 1;
	//    const reviewsPerPage = 5;

	/*    function generateSampleReviews() {
			for (let i = 1; i <= 20; i++) {
				reviews.push({
					author: `사용자${i}`,
					rating: Math.floor(Math.random() * 5) + 1,
					content: `이것은 샘플 리뷰 내용입니다. 리뷰 번호: ${i}`,
					date: `2023-10-${(i % 30) + 1}`
				});
			}
		}
	*/
	/*    function renderReviews() {
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
		}*/

	//    function renderPagination() {
	//        const pagination = document.getElementById('pagination');
	//        pagination.innerHTML = '';
	//
	//        const totalPages = Math.ceil(reviews.length / reviewsPerPage);
	//
	//        if (currentPage > 1) {
	//            const prevButton = document.createElement('button');
	//            prevButton.textContent = '이전';
	//            prevButton.addEventListener('click', () => {
	//                currentPage--;
	//                renderReviews();
	//            });
	//            pagination.appendChild(prevButton);
	//        }
	//
	//        for (let i = 1; i <= totalPages; i++) {
	//            const pageButton = document.createElement('button');
	//            pageButton.textContent = i;
	//
	//            if (i === currentPage) {
	//                pageButton.disabled = true;
	//            }
	//
	//            pageButton.addEventListener('click', () => {
	//                currentPage = i;
	//                renderReviews();
	//            });
	//
	//            pagination.appendChild(pageButton);
	//        }
	//
	//        if (currentPage < totalPages) {
	//            const nextButton = document.createElement('button');
	//            nextButton.textContent = '다음';
	//            nextButton.addEventListener('click', () => {
	//                currentPage++;
	//                renderReviews();
	//            });
	//            pagination.appendChild(nextButton);
	//        }
	//    }
	//
	//    function loadReviews() {
	////        generateSampleReviews();
	//        renderReviews();
	//        document.getElementById('reviewCount').textContent = reviews.length;
	//    }
	//
	//    loadReviews();
	//
	//    // 리뷰 작성 이벤트
	//    document.getElementById('reviewForm').addEventListener('submit', function (e) {
	//        e.preventDefault();
	//        addReview();
	//    });
	//
	//    function addReview() {
	//        const reviewerName = document.getElementById('reviewerName').value;
	//        const reviewRating = parseInt(document.getElementById('reviewRating').value);
	//        const reviewText = document.getElementById('reviewText').value;
	//        const reviewDate = new Date().toISOString().split('T')[0];
	//
	//        reviews.unshift({
	//            author: reviewerName,
	//            rating: reviewRating,
	//            content: reviewText,
	//            date: reviewDate
	//        });
	//        renderReviews();
	//        document.getElementById('reviewCount').textContent = reviews.length;
	//        document.getElementById('reviewForm').reset();
	//    }
	//
	//    // 리뷰 정렬 함수 전역 설정
	//    window.sortReviewsByDate = function () {
	//        reviews.sort((a, b) => new Date(b.date) - new Date(a.date));
	//        renderReviews();
	//    };
	//
	//    window.sortReviewsByRating = function () {
	//        reviews.sort((a, b) => b.rating - a.rating);
	//        renderReviews();
	//    };
});


// 네이버 지도 초기화
function initMap() {
	const mapContainer = document.getElementById('map');

	console.log("JS 파일에서 받은 latitude:", latitude);
	console.log("JS 파일에서 받은 longitude:", longitude);

	if (mapContainer) {
		const map = new naver.maps.Map('map', {
			center: new naver.maps.LatLng(latitude, longitude),
			zoom: 16
		});

		new naver.maps.Marker({
			position: new naver.maps.LatLng(latitude, longitude),
			map: map
		});
	} else {
		console.error('지도를 표시할 #map 요소를 찾을 수 없습니다.');
	}
}

document.addEventListener('DOMContentLoaded', function() {
	if (typeof naver !== 'undefined' && naver.maps) {
		naver.maps.onJSContentLoaded = initMap;
	} else {
		console.error('네이버 맵을 초기화할 수 없습니다.');
	}
});
