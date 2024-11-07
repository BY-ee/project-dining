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
    Long userIdLong = (Long) session.getAttribute("user_ID");
    String userId = (userIdLong != null) ? userIdLong.toString() : null;
    String nickname = (String) session.getAttribute("user_nickname");
%>

<script src="http://code.jquery.com/jquery-latest.js"></script>

<script>
    // URL에서 store_ID 파라미터 추출 함수
    function getParameterByName(name) {
        const url = new URL(window.location.href);
        return url.searchParams.get(name);
    }

    // URL에서 store_ID 파라미터 가져오기
    var storeId = getParameterByName("store_ID");
    var userId = "<%= userId %>";
    var nickname = "<%= nickname %>";

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
                renderReviews(reviews);
                $('#reviewCount').text(reviews.length);
            },
            error: function(xhr, status, error) {
                console.error('리뷰 데이터를 불러오는 중 오류가 발생했습니다: ', error);
            }
        });
    }

    // 리뷰 데이터를 화면에 렌더링하는 함수
    function renderReviews(reviews) {
        var reviewList = $('#review-list');
        reviewList.empty();

        $.each(reviews, function(index, review) {
            var reviewItem = '<div class="review-item">'
                + '<div class="review-header">'
                + '<span class="review-author">' + review.nickname + '</span>'
                + '<br>'
                + '<span class="review-date">' + review.created_at + '</span>'
                + '<div class="review-rating">' + generateStars(review.score) + '</div>'
                + '</div>'
                + '<div class="review-content">' + review.content + '</div>'
                + '</div>';
            reviewList.append(reviewItem);
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
                reviews.sort((a, b) => new Date(b.created_at) - new Date(a.created_at));
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