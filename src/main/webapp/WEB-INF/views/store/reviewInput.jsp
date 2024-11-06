<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>
</head>
<body>

<!-- 리뷰 섹션 -->
<div class="review-input-section">
    <h3>리뷰 작성하기</h3>
    <!-- form 태그에 있는 action 속성으로 서버에 데이터를 전송 -->
    <form action="/submitReview" method="post">
        <!-- 숨겨진 필드: userId, storeId -->
        <input type="hidden" name="userId" value="${loggedInUserId}">
        <input type="hidden" name="storeId" value="${currentStoreId}">
        
        <!-- 사용자 입력 필드 -->
        <select name="score">
            <option value="5">5점 - 아주 좋아요</option>
            <option value="4">4점 - 좋아요</option>
            <option value="3">3점 - 보통이에요</option>
            <option value="2">2점 - 별로에요</option>
            <option value="1">1점 - 싫어요</option>
        </select>
        <textarea name="review" placeholder="리뷰 내용을 입력하세요" required></textarea>

        <!-- 폼 제출 시 자동으로 새로고침하여 서버에 전송 -->
        <button type="submit">리뷰 작성</button>
    </form>
</div>

</body>
</html>
