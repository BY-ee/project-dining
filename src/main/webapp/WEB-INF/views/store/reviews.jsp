<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록</title>

<%
    // 세션에서 user_ID 및 user_nickname 가져오기
    Long userId = (Long) session.getAttribute("user_ID");
    String nickname = (String) session.getAttribute("user_nickname");
%>

<script src="http://code.jquery.com/jquery-latest.js"></script>

<script>

    $(document).ready(function() {
        // storeId가 유효할 때만 리뷰 불러오기 실행
        if (!storeId) {
            console.error("store_ID가 설정되지 않았습니다.");
        } else {
            loadReviews(); // storeId가 있을 때만 loadReviews 호출
        }

        // 작성일자 순 정렬 버튼 이벤트
        $('#sortByDate').click(function() {
            sortReviewsByDate();
        });

        // 별점 순 정렬 버튼 이벤트
        $('#sortByRating').click(function() {
            sortReviewsByRating();
        });
    });

    // 서버에서 리뷰 데이터를 가져오는 함수
    function loadReviews() {
	    $.ajax({
	        url: 'getReviews',
	        method: 'GET',
	        data: { store_id: storeId },  // store_id 전달
	        dataType: 'json',
	        success: function(reviews) {
	            console.log("API Response:", reviews);
	            console.log("userId:", userId);
	            
	            if (reviews.length > 0) {
	                console.log("API Response: memberId", reviews[0].memberId);
	            } else {
	                console.log("No reviews available");
	            }	
	            // userReviewIndex를 여기서 구합니다.
	            var userReviewIndex = reviews.findIndex(function(review) {
	                return review.memberId != null && review.memberId === userId;
	            });
	
	            // renderReviews 함수 호출 시 두 번째 인자로 전달합니다.
	            renderReviews(reviews, userReviewIndex);
	            $('#reviewCount').text(reviews.length);
	        },
	        error: function(xhr, status, error) {
	            console.error('리뷰 데이터를 불러오는 중 오류가 발생했습니다: ', error);
	        }
	    });
	}

    // 리뷰 데이터를 화면에 렌더링하는 함수
    function renderReviews(reviews, userReviewIndex) {
	    var reviewList = $('#review-list');
	    reviewList.empty();
	    console.log("asd: ", reviews)
	
	    $.each(reviews, function(index, review) {
	    	if(review.status === 'active') {
		        var reviewItem = '<div class="review-item">'
		            + '<div class="review-header">'
		            + '<span class="review-author">' + review.nickname + '</span>'
		            + '<br>'
		            + '<span class="review-date">' + review.createdAt + '</span>'
		            + '<div class="review-rating">' + generateStars(review.score) + '</div>'
		            + '</div>'
		            + '<div class="review-content">' + review.content + '</div>';
		
		        // 수정, 삭제 버튼 추가
		        if (review.memberId != null && review.memberId === userId) { // 본인이 작성한 리뷰일 경우에만 삭제 버튼 표시
		            console.log("review.memberId ", review.memberId);
		            reviewItem += '<button class="edit-review-button" onclick="editReview(' + review.id + ', \'' + review.content + '\')">수정</button>';
		            reviewItem += '<button class="delete-review-button" onclick="hiddenReview(' + review.id + ', ' + review.memberId + ')">삭제</button>';
		        }
		
		        reviewItem += '</div>'; // review-item 종료
		        reviewList.append(reviewItem);
	    	}
	    });
	}

    // 별점 표시를 위한 함수
    function generateStars(rating) {
        var stars = '';
        for (var i = 1; i <= 5; i++) {
            stars += i <= rating ? '<span class="star filled">★</span>' : '<span class="star">★</span>';
        }
        return stars;
    }

    // 작성일자 순으로 정렬하는 함수
    function sortReviewsByDate() {
        $.ajax({
            url: 'getReviews',
            method: 'GET',
            data: { store_id: storeId },
            dataType: 'json',
            success: function(reviews) {
                reviews.sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));
                renderReviews(reviews);
            },
            error: function(xhr, status, error) {
                console.error('리뷰 데이터를 불러오는 중 오류가 발생했습니다: ', error);
            }
        });
    }
    
    // 별점 순으로 정렬하는 함수
    function sortReviewsByRating() {
        $.ajax({
            url: 'getReviews',
            method: 'GET',
            data: { store_id: storeId },
            dataType: 'json',
            success: function(reviews) {
                reviews.sort((a, b) => b.score - a.score);
                renderReviews(reviews);
            },
            error: function(xhr, status, error) {
                console.error('리뷰 데이터를 불러오는 중 오류가 발생했습니다: ', error);
            }
        });
    }
    
	// 중복 리뷰 확인 후 alert 메시지 표시
    function checkDuplicateReview() {
        $.ajax({
            url: 'getReviews',
            method: 'GET',
            data: { store_id: storeId }, // storeId 전달
            dataType: 'json',
            success: function(reviews) {
            	const existingReview = reviews.find(review => review.memberId === userId); // userId 변수는 세션에서 가져온 사용자 ID
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
    
    function editReview(reviewId, currentContent) {
        var reviewContent = $('#review-content-' + reviewId);
        reviewContent.html('<textarea id="edit-content-' + reviewId + '">' + currentContent + '</textarea><br>'
            + '<button onclick="saveReview(' + reviewId + ')">저장</button>'
            + '<button onclick="cancelEdit(' + reviewId + ', \'' + currentContent + '\')">취소</button>');
    }

    function saveReview(reviewId) {
        var newContent = $('#edit-content-' + reviewId).val();
        $.ajax({
            url: '/updateReview',  // 리뷰 수정 요청 URL
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ id: reviewId, content: newContent }),
            success: function(response) {
                alert("리뷰가 수정되었습니다.");
                loadReviews();
            },
            error: function(xhr, status, error) {
                alert("리뷰 수정에 실패했습니다: " + error);
            }
        });
    }

    function cancelEdit(reviewId, originalContent) {
        $('#review-content-' + reviewId).text(originalContent);
    }

    function deleteReview(reviewId, memberId) {
        const reviewDetails = {
            id: reviewId,
            member_id: memberId
        };
    }
	
	
    // 리뷰 삭제 함수
    function deleteReview(reviewId, memberId) {
        const reviewDetails = {
                id: reviewId,
                member_id: memberId
            };

            $.ajax({
                url: '/deleteReview',  // 삭제 요청 URL
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(reviewDetails),
                success: function(response) {
                    alert("리뷰가 삭제되었습니다.");
                    loadReviews(); // 삭제 후 리뷰 목록 갱신
                },
                error: function(xhr, status, error) {
                    alert("리뷰 삭제에 실패했습니다: " + error);
                }
            });
        }
    
    // 유저가 리뷰 삭제버튼을 누르면 숨김처리되는 로직
    function hiddenReview(reviewId, memberId) {
        const reviewDetails = {
                id: reviewId,
                member_id: memberId
            };

            $.ajax({
                url: '/hiddenReview',  // 삭제 요청 URL
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(reviewDetails),
                success: function(response) {
                    alert("리뷰가 삭제되었습니다.");
                    loadReviews(); // 삭제 후 리뷰 목록 갱신
                },
                error: function(xhr, status, error) {
                    alert("리뷰 삭제에 실패했습니다: " + error);
                }
            });
        }
</script>

</head>
<body>
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