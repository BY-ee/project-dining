<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/admin/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>가게 관리</title>
    
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="/js/admin/adminStore.js"></script>
</head>
<body>
    <div class="main-content">
        <h2>가게 관리</h2>

        <div class="search-box">
            <form method="get" action="/admin/stores">
                <select name="column">
                    <option value="id">ID</option>
                    <option value="storeName">가게 이름</option>
                    <option value="address">주소</option>
                    <option value="tel">전화번호</option>
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
                    <th>가게 이름</th>
                    <th>주소</th>
                    <th>전화번호</th>
                    <th>메뉴</th>
                    <th>조회수</th>
                    <th>게시중단</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="store" items="${pagination.content}">
                    <tr>
                        <td>${store.id}</td>
                        <td>${store.storeName}</td>
                        <td>${store.address}</td>
                        <td>${store.phoneNumber}</td>
                        <td><a href="#" class="menu-link">확인</a></td>
                        <td>${store.views}</td>
                        <td>
                            <button class="delete-btn inactivate-btn" data-id="${store.id}">게시중단</button>
                            <button class="edit-btn reactivate-btn" data-id="${store.id}">재게시</button>
                        </td>
                        <td class="store-status" data-id="${store.id}" data-status="${store.postStatus}">${store.postStatus}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Pagination -->
        <div class="pagination">
            <!-- 클래스명을 동적으로 변경 -->
            <div class="move-page-link">
                <a class="page-link ${pagination.isFirstPageBtnVisible() ? '' : 'disabled'}" href="/admin/stores?page=1">처음</a>
                <a class="page-link ${pagination.page > 1 ? '' : 'disabled'}" href="/admin/stores?page=${pagination.page - 1}">이전</a>
            </div>

            <div class="page">
                <c:forEach var="page" begin="${pagination.start}" end="${pagination.end}">
                    <c:choose>
                        <c:when test="${page == pagination.page}">
                            <span class="current-page">${page}</span>
                        </c:when>
                        <c:otherwise>
                            <a class="page-link" href="/admin/stores?page=${page}">${page}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>

            <div class="move-page-link">
                <a class="page-link ${pagination.page < pagination.totalPages ? '' : 'disabled'}" href="/admin/stores?page=${pagination.page + 1}">다음</a>
                <a class="page-link ${pagination.isLastPageBtnVisible() ? '' : 'disabled'}" href="/admin/stores?page=${pagination.totalPages}">끝</a>
            </div>
        </div>

    <!-- 메뉴 팝업 -->
    <div class="popup-overlay" id="popup-overlay">
        <div class="popup-content">
            <button class="popup-close" onclick="closePopup()">X</button>
            <h3 class="popup-title">가게 이름</h3>
            <div id="menu-content"></div>
        </div>
    </div>
</body>
</html>
