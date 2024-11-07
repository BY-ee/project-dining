<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>

<%
    String userId = (String) session.getAttribute("user_ID");
    String nickname = (String) session.getAttribute("user_nickname");
%>

</head>
<body>

<!-- 리뷰 섹션 -->
<div class="review-input-section">
    <h3>리뷰 작성하기</h3>
    <!-- form 태그에 있는 action 속성으로 서버에 데이터를 전송 -->
    <form action="/submitReview" method="post">
        <!-- 숨겨진 필드: storeId -->
        <input type="hidden" name="storeId" value="${store_ID}">

        <!-- 작성자 이름 필드에 nickname 값 자동 표시 -->
        <% if (userId != null) { %>
            <!-- 로그인된 사용자의 경우 닉네임을 텍스트로 출력 -->
            <p>작성자: <%= nickname %></p>
        <% } %>
        <select name="score" <%= userId == null ? "disabled" : "" %>>
            <option value="5">5점 - 아주 좋아요</option>
            <option value="4">4점 - 좋아요</option>
            <option value="3">3점 - 보통이에요</option>
            <option value="2">2점 - 별로에요</option>
            <option value="1">1점 - 싫어요</option>
        </select>
		<textarea name="review"
		          placeholder="<%= userId == null ? "리뷰를 작성하려면 로그인을 해주세요" : "리뷰를 입력해주세요" %>"
		          required <%= userId == null ? "disabled" : "" %>></textarea>
		             
        <% if (userId != null) { %>
            <button type="submit" onclick="checkDuplicateReview()">리뷰 작성</button>
        <% } %>
    </form>
</div>

</body>
</html>