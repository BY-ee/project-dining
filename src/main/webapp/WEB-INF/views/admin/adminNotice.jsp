<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/WEB-INF/views/admin/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>공지사항 관리</title>
    
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="/js/admin/adminNotice.js"></script>
</head>
<body>
    <div class="main-content">
        <h2>공지사항 관리</h2>

        <div class="search-box">
            <form method="get" action="/admin/notice">
                <select name="column">
                    <option value="id">ID</option>
                    <option value="title">제목</option>
                    <option value="category">분류</option>
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
                    <th>제목</th>
                    <th>게시일</th>
                    <th>사진유무</th>
                    <th>조회수</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="notice" items="${pagination.content}">
                    <tr>
                        <td>${notice.id}</td>
                        <td><a href="/admin/notice/${notice.id}">${notice.title}</a></td>
                        <td><fmt:formatDate value="${notice.createdAt}" pattern="yy.MM.dd hh:mm:ss (EEE)" /></td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty notice.noticeImage}">O</c:when>
                                <c:otherwise>X</c:otherwise>
                            </c:choose>
                        </td>                        
                        <td>${notice.views}</td>
                        <td class="notice-status" data-id="${notice.id}" data-status="${notice.status}">${notice.status}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Pagination -->
        <div class="pagination">
            <!-- 클래스명을 동적으로 변경 -->
            <div class="move-page-link">
                <a class="page-link ${pagination.isFirstPageBtnVisible() ? '' : 'disabled'}" href="/admin/notice?page=1">처음</a>
                <a class="page-link ${pagination.page > 1 ? '' : 'disabled'}" href="/admin/notice?page=${pagination.page - 1}">이전</a>
            </div>

            <div class="page">
                <c:forEach var="page" begin="${pagination.start}" end="${pagination.end}">
                    <c:choose>
                        <c:when test="${page == pagination.page}">
                            <span class="current-page">${page}</span>
                        </c:when>
                        <c:otherwise>
                            <a class="page-link" href="/admin/notice?page=${page}">${page}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>

            <div class="move-page-link">
                <a class="page-link ${pagination.page < pagination.totalPages ? '' : 'disabled'}" href="/admin/notice?page=${pagination.page + 1}">다음</a>
                <a class="page-link ${pagination.isLastPageBtnVisible() ? '' : 'disabled'}" href="/admin/notice?page=${pagination.totalPages}">끝</a>
            </div>
        </div>

        <button class="btn edit-btn" style="margin-top: 40px;"
            onclick="location.href='/admin/notice/write'">공지작성</button>
    </div>
</body>
</html>
