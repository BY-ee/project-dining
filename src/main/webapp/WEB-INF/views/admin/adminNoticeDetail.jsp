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
            <a class="active-btn" href='/admin/notice/${notice.id}/edit'>수정</a>
            <a class="inactive-btn" href='/admin/notice/${notice.id}/inactivate'>게시중단</a>
            <a class="active-btn" href='/admin/notice'>목록</a>
        </div>
    </div>
</body>
</html>