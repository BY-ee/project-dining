<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/WEB-INF/views/admin/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>포인트관리</title>
    
    <script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
    <div class="main-content">
        <h2>포인트관리</h2>

        <div class="search-box">
<form method="get" action="/admin/searchPoints">
    <select name="column">
        <option value="member_id" ${column == 'member_id' ? 'selected' : ''}>유저 아이디</option>
        <option value="nickname" ${column == 'nickname' ? 'selected' : ''}>유저 닉네임</option>
    </select>
    <input type="text" name="keyword" placeholder="검색" value="${keyword}">
    <button>검색</button>
</form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>유저 아이디</th>
                    <th>유저 닉네임</th>
                    <th>지급이유</th>
                    <th>포인트</th>
                    <th>내역</th>
                    <th>수령일자</th>
                    <th>만료일자</th>
                    <th>상태</th>
                </tr>
            </thead>
           <tbody>
    <c:choose>
        <c:when test="${not empty searchResults}">
            <c:forEach var="point" items="${searchResults}">
                <tr>
                    <td>${point.id}</td>
                    <td>${point.joinMemberId}</td>
                    <td>${point.joinNickname}</td>
                    <td>${point.category}</td>
                    <td>${point.point}</td>
                    <td>${point.type}</td>
                    <td><fmt:formatDate value="${point.createdAt}" pattern="yy.MM.dd hh:mm:ss (EEE)" /></td>
                    <td><fmt:formatDate value="${point.deletedAt}" pattern="yy.MM.dd hh:mm:ss (EEE)" /></td>
                    <td class="member-status" data-id="${point.id}" data-status="${point.status}">${point.status}</td>
                </tr>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <c:forEach var="point" items="${pagination.content}">
                <tr>
                    <td>${point.id}</td>
                    <td>${point.joinMemberId}</td>
                    <td>${point.joinNickname}</td>
                    <td>${point.category}</td>
                    <td>${point.point}</td>
                    <td>${point.type}</td>
                    <td><fmt:formatDate value="${point.createdAt}" pattern="yy.MM.dd hh:mm:ss (EEE)" /></td>
                    <td><fmt:formatDate value="${point.deletedAt}" pattern="yy.MM.dd hh:mm:ss (EEE)" /></td>
                    <td class="member-status" data-id="${point.id}" data-status="${point.status}">${point.status}</td>
                </tr>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</tbody>
        </table>

        <!-- Pagination -->
        <div class="pagination">
            <!-- 클래스명을 동적으로 변경 -->
            <div class="move-page-link">
                <a class="page-link ${pagination.isFirstPageBtnVisible() ? '' : 'disabled'}" href="/admin/points?page=1">처음</a>
                <a class="page-link ${pagination.page > 1 ? '' : 'disabled'}" href="/admin/points?page=${pagination.page - 1}">이전</a>
            </div>

            <div class="page">
                <c:forEach var="page" begin="${pagination.start}" end="${pagination.end}">
                    <c:choose>
                        <c:when test="${page == pagination.page}">
                            <span class="current-page">${page}</span>
                        </c:when>
                        <c:otherwise>
                            <a class="page-link" href="/admin/points?page=${page}">${page}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>

            <div class="move-page-link">
                <a class="page-link ${pagination.page < pagination.totalPages ? '' : 'disabled'}" href="/admin/points?page=${pagination.page + 1}">다음</a>
                <a class="page-link ${pagination.isLastPageBtnVisible() ? '' : 'disabled'}" href="/admin/points?page=${pagination.totalPages}">끝</a>
            </div>
        </div>
    </div>

</body>
</html>