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


document.addEventListener('DOMContentLoaded', function() {
    const slideButtons = document.querySelectorAll('.slider-nav button');

    slideButtons.forEach((button, index) => {
        button.addEventListener('click', function() {
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
		nextButton.addEventListener('click', function() {
			showMenuSlide((currentMenuSlide + 1) % totalMenuSlides);
		});

		prevButton.addEventListener('click', function() {
			showMenuSlide((currentMenuSlide - 1 + totalMenuSlides) % totalMenuSlides);
		});
	} else {
		console.error('슬라이더 내비게이션 버튼을 찾을 수 없습니다.');
	}


	// 찜 상태 초기 설정
	    const likeButton = document.getElementById('likeButton');
	    let isLiked = false;
	    let likeCount = 0;
	    const data = { store_ID: storeId };
	    
	    if (userId) {
	        data.user_ID = userId;
	    }

	    // AJAX 요청으로 초기 찜 상태 확인
	    $.ajax({
	        url: '/getLikeStatus',
	        method: 'GET',
	        data: data,
	        success: function(response) {
	            isLiked = response.liked;
	            likeCount = response.likeCount;

	            // 초기 UI 상태 업데이트
	            document.getElementById('likeCount').textContent = likeCount;
	            likeButton.classList.toggle('liked', isLiked);
	        },
	        error: function(xhr, status, error) {
	            console.error('초기 찜 상태를 가져오는 데 실패했습니다:', error);
	        }
	    });

	    // 찜 버튼 클릭 이벤트
	    likeButton.addEventListener('click', () => {
	        if (!userId) {
	            alert('로그인 후 가능합니다.');
	            return;
	        }

	        isLiked = !isLiked;
	        likeCount += isLiked ? 1 : -1;

	        document.getElementById('likeCount').textContent = likeCount;
	        likeButton.classList.toggle('liked', isLiked);

	        $.ajax({
	            url: '/likeStore',
	            method: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify({
	                memberId: userId,
	                storeId: storeId,
	                liked: isLiked
	            }),
	            success: function(response) {
	                likeCount = response.likeCount;
	                document.getElementById('likeCount').textContent = likeCount;
	                console.log('찜 상태와 누적 카운트가 DB에 저장되었습니다.');
	            },
	            error: function(xhr, status, error) {
	                console.error('찜 상태 저장에 실패했습니다:', error);
	            }
	        });
	    });


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


// 네이버 지도 초기화
    if (typeof naver !== 'undefined' && naver.maps) {
        const mapContainer = document.getElementById('map');
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
    } else {
        console.error('네이버 맵을 초기화할 수 없습니다.');
    }
});