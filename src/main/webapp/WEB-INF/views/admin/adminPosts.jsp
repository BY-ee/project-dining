<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/admin/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>게시글 관리</title>

    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="/js/admin/adminPost.js"></script>
</head>
<body>

    <!-- Main Content -->
    <div class="main-content">
        <h2>게시글 관리</h2>

        <!-- Search Box -->
        <div class="search-box">
            <select name="search-keywords">
                <option value="id">ID</option>
                <option value="storeName">가게 이름</option>
                <option value="address">주소</option>
                <option value="tel">전화번호</option>
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
                <c:forEach var="store" items="${stores.content}">
                    <tr>
                        <td>${store.id}</td>
                        <td>${store.storeName}</td>
                        <td>${store.address}</td>
                        <td>${store.phoneNumber}</td>
                        <td><a href="#" class="menu-link">확인</a></td>
                        <td>${store.views}</td>
                        <td>
                            <button class="delete-btn">게시중단</button>
                            <button class="edit-btn">재게시</button>
                        </td>
                        <td style="color: #f44;">게시중단</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Pagination -->
        <div class="pagination">
            <div class="move-page-link">
                <c:if test="${stores.page > stores.start}">
                    <a class="page-link" href="#">처음</a>
                </c:if>

                <a class="page-link" href="#">이전</a>
            </div>

            <div class="page">
                <c:forEach var="page" begin="${stores.start}" end="${stores.totalPages}">
                    <c:choose>
                        <c:when test="${page == stores.page}">
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

                <c:if test="${stores.page < stores.end}">
                    <a class="page-link" href="#">끝</a>
                </c:if>
            </div>
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
