<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/admin/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>리뷰 관리</title>
    <link rel="stylesheet" href="/css/admin/adminStore.css">
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="/js/admin/adminReview.js"></script>
    <script src="/js/admin/adminMember.js"></script>
    <script src="/js/admin/adminStore.js"></script>
</head>
<body>
    <div class="main-content">
        <h2>리뷰 관리</h2>
        
        <div class="search-box">
            <form method="get" action="/admin/reviews">
                <select name="column">
                    <option value="id">ID</option>
                    <option value="user_id">유저 ID</option>
                    <option value="store_id">가게 ID</option>
                    <option value="score">평점</option>
                    <option value="status">상태</option>
                </select>
                <input type="text" name="keyword" placeholder="검색">
                <button>검색</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>유저 ID</th>
                    <th>가게 ID</th>
                    <th>평점</th>
                    <th>리뷰</th>
                    <th>관리</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="review" items="${pagination.content}">
                    <tr>
                        <td>${review.id}</td>
                        <td><a class="member-link" href="#" data-id="${review.memberId}" data-review="true">${review.nickname}</a></td>
                        <td><a class="store-link" href="#" data-id="${review.storeId}" data-review="true">${review.storeName}</a></td>
                        <td>${review.score}</td>
                        <td>
                            <a href="#" class="review-link" data-store-name="${review.storeName}"
                                data-content="${review.content}" data-image="${review.reviewImage}" data-nickname="${review.nickname}"
                                >확인
                            </a>
                        </td>
                        <td>
                            <button class="delete-btn inactivate-btn" data-id="${review.id}">게시중단</button>
                            <button class="edit-btn reactivate-btn" data-id="${review.id}">재게시</button>
                        </td>
                        <td class="review-status" data-id="${review.id}" data-status="${review.status}">${review.status}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Pagination -->
        <div class="pagination">
            <!-- 클래스명을 동적으로 변경 -->
            <div class="move-page-link">
                <a class="page-link ${pagination.isFirstPageBtnVisible() ? '' : 'disabled'}" href="/admin/reviews?page=1">처음</a>
                <a class="page-link ${pagination.page > 1 ? '' : 'disabled'}" href="/admin/reviews?page=${pagination.page - 1}">이전</a>
            </div>

            <div class="page">
                <c:forEach var="page" begin="${pagination.start}" end="${pagination.end}">
                    <c:choose>
                        <c:when test="${page == pagination.page}">
                            <span class="current-page">${page}</span>
                        </c:when>
                        <c:otherwise>
                            <a class="page-link" href="/admin/reviews?page=${page}">${page}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>

            <div class="move-page-link">
                <a class="page-link ${pagination.page < pagination.totalPages ? '' : 'disabled'}" href="/admin/reviews?page=${pagination.page + 1}">다음</a>
                <a class="page-link ${pagination.isLastPageBtnVisible() ? '' : 'disabled'}" href="/admin/reviews?page=${pagination.totalPages}">끝</a>
            </div>
        </div>
    </div>

    <!-- 리뷰 팝업 -->
    <div class="popup-overlay" id="popup-overlay">
        <div class="popup-content">
            <button class="popup-close" onclick="closePopup()">X</button>
            <div id="review-content"></div>
        </div>
    </div>
</body>
</html>
