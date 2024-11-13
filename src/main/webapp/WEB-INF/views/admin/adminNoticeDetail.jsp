<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/WEB-INF/views/admin/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>공지사항 상세</title>
    <link rel="stylesheet" href="/css/admin/adminNotice.css">
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="/js/admin/notice.js"></script>
</head>
<body>
    <div class="content">
        <div class="notice-header">
            <h1 class="title">${notice.title}</h1>
            <p class="date"><fmt:formatDate value="${notice.createdAt}" pattern="yyyy.MM.dd(EEE) HH:mm:ss" /> | 조회수 ${notice.views}</p>
        </div>

        <div class="notice-content">
            ${notice.content}
        </div>

        <div class="button-container">
            <c:choose>
                <c:when test="${notice.status == 'active'}">
                    <a class="active-btn" href='/admin/notice/${notice.id}/edit'>수정</a>
                    <a class="inactive-btn inactive-notice" data-id="${notice.id}" href='#'>게시중단</a>
                    <a class="active-btn" href='/admin/notice'>목록</a>
                </c:when>
                <c:otherwise>
                    <a class="active-btn reactive-notice" data-id="${notice.id}" href='#'>재게시</a>
                    <a class="active-btn" href='/admin/notice'>목록</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>