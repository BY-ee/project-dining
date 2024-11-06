<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<script>

	$(document).ready(function() {
		// 페이지 로드 시 서버에서 리뷰데이터를 불러옴
		loadReviews();

		// 작성일자 순 정렬 버튼 클릭 이벤트
		$('#sortByDate').click(function() {
			sortReviewsByDate();
		});

		// 별점 순 정렬 버튼 클릭 이벤트
		$('#sortByRating').click(function() {
			sortReviewsByRating();
		});
	});

	// 서버에서 리뷰 데이터를 가져오는 함수
	function loadReviews() {
		$.ajax({
			url : 'getReviews',
			method : 'GET',
			data : { storeId: storeId }, // storeId 전달
			dataType : 'json',
			success : function(reviews) {
				console.log("reviews:" + reviews);
				renderReviews(reviews);
				$('#reviewCount').text(reviews.length); // 리뷰 수 업데이트
			},
			error : function(xhr, status, error) {
				console.error('리뷰 데이터를 불러오는 중 오류가 발생했습니다: ', error);
			}
		});
	}

	// 중복 리뷰 확인 후 alert 메시지 표시
	function checkDuplicateReview() {
        $.ajax({
            url: 'getReviews',
            method: 'GET',
            data: { storeId: storeId }, // storeId 전달
            dataType: 'json',
            success: function(reviews) {
                const existingReview = reviews.find(review => review.userId === userId); // userId 변수는 세션에서 가져온 사용자 ID
                if (existingReview) {
                    alert("이미 리뷰를 작성하셨습니다."); // 중복 리뷰가 있을 경우 alert 메시지 표시
                    window.location.reload();
                } else {
                    // 중복이 아닐 경우, 리뷰 입력을 위한 로직 수행
                    submitReview(); // 실제 리뷰 제출 함수 호출
                }
            },
            error: function(xhr, status, error) {
                console.error('리뷰 데이터를 불러오는 중 오류가 발생했습니다: ', error);
            }
        });
    }
	
	// 리뷰 데이터를 화면에 렌더링하는 함수
	function renderReviews(reviews) {
		var reviewList = $('#review-list');
		reviewList.empty(); // 기존 리뷰 목록 초기화

		// 리뷰 목록을 동적으로 생성
		$.each(reviews, function(index, review) {

			// 문자열 연결 방식으로 변경
			var reviewItem = '<div class="review-item">'
		        + '<div class="review-header">'
	            + '<span class="review-author">' + review.userId + '</span>' // 사용자 이름
	            + '<br>'  // 줄바꿈
	            + '<span class="review-date">' + review.createdAt + '</span>' // 날짜는 작성자 이름 아래
	            + '<div class="review-rating">' + generateStars(review.score) + '</div>' // 별점은 오른쪽 상단에 CSS로 배치
	        + '</div>'
	        + '<div class="review-content">' + review.review + '</div>' // 리뷰 내용
	    + '</div>';

			reviewList.append(reviewItem); // reviewItem을 리뷰 리스트에 추가
		});
	}

	// 별점 표시를 위한 함수
	function generateStars(rating) {
		var stars = '';
		for (var i = 1; i <= 5; i++) {
			if (i <= rating) {
				stars += '<span class="star filled">★</span>';
			} else {
				stars += '<span class="star">★</span>';
			}
		}
		return stars;
	}

	// 작성일자 순으로 정렬하는 함수
	function sortReviewsByDate() {
		$.ajax({
			url : 'getReviews', // 서버 엔드포인트
			method : 'GET',
			dataType : 'json',
			success : function(reviews) {
				reviews.sort(function(a, b) {
					return new Date(b.createdAt) - new Date(a.createdAt);
				});
				renderReviews(reviews);
			},
			error : function(xhr, status, error) {
				console.error('리뷰 데이터를 불러오는 중 오류가 발생했습니다: ', error);
			}
		});
	}

	// 별점 순으로 정렬하는 함수
	function sortReviewsByRating() {
		$.ajax({
			url : 'getReviews', // 서버 엔드포인트
			method : 'GET',
			dataType : 'json',
			success : function(reviews) {
				reviews.sort(function(a, b) {
					return b.score - a.score;
				});
				renderReviews(reviews);
			},
			error : function(xhr, status, error) {
				console.error('리뷰 데이터를 불러오는 중 오류가 발생했습니다: ', error);
			}
		});
	}
</script>

</head>
<body>

	<!-- 리뷰 섹션 -->
	<div class="section review-section">
		<div class="review-title">
			리뷰 목록 (<span id="reviewCount">0</span>)
		</div>

		<div class="sort-buttons">
			<button id="sortByDate">작성일자 순</button>
			<button id="sortByRating">별점 순</button>
		</div>

		<div id="review-list"></div>
		<div class="pagination" id="pagination"></div>
	</div>

</body>
</html>