<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/admin/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>리뷰 관리</title>

    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="/js/admin/adminReview.js"></script>
</head>
<body>

    <!-- Main Content -->
    <div class="main-content">
        <h2>리뷰 관리</h2>

        <!-- Search Box -->
        <div class="search-box">
            <select name="search-keywords">
                <option value="id">ID</option>
                <option value="userId">유저 ID</option>
                <option value="storeId">가게 ID</option>
                <option value="score">평점</option>
                <option value="status">상태</option>
            </select>
            <input type="text" placeholder="검색">
            <button>검색</button>
        </div>

        <!-- Product Table -->
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>유저 ID</th>
                    <th>가게 ID</th>
                    <th>평점</th>
                    <th>리뷰</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="review" items="${reviews.content}">
                    <tr>
                        <td>${review.id}</td>
                        <td><a href="/admin/members/${review.memberId}">${review.memberId}</a></td>
                        <td><a href="/admin/posts/${review.storeId}">${review.storeId}</a></td>
                        <td>${review.score}</td>
                        <td><a href="#" class="review-link">확인</a></td>
                        <td style="color: #f44;">게시중단</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Pagination -->
        <div class="pagination">
            <div class="move-page-link">
                <c:if test="${reviews.page > reviews.start}">
                    <a class="page-link" href="#">처음</a>
                </c:if>

                <a class="page-link" href="#">이전</a>
            </div>

            <div class="page">
                <c:forEach var="page" begin="${reviews.start}" end="${reviews.totalPages}">
                    <c:choose>
                        <c:when test="${page == reviews.page}">
                            <span class="current-page">${page}</span>
                        </c:when>
                        <c:otherwise>
                            <a class="page-link" href="#">${page}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>

            <div class="move-page-link">
                <a class="page-link" href="#">다음</a>

                <c:if test="${reviews.page < reviews.end}">
                    <a class="page-link" href="#">끝</a>
                </c:if>
            </div>
        </div>
    </div>

    <!-- 리뷰 팝업 -->
    <div class="popup-overlay" id="popup-overlay">
        <div class="popup-content">
            <button class="popup-close" onclick="closePopup()">X</button>
            <h3 class="popup-title">유저 닉네임</h3>
            <div id="review-content"></div>
        </div>
    </div>
</body>
</html>
