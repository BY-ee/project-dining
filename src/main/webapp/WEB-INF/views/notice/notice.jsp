<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 상세</title>
    <link rel="stylesheet" href="/css/notice/commonStyles.css">
    <link rel="stylesheet" href="/css/notice/noticeCommonStyles.css">
    <link rel="stylesheet" href="/css/notice/noticeStyles.css">
</head>
<body>
    <!-- 상단바 -->
    <header class="navbar">
        <div class="navbar-left">
            <a class="navbar-logo">냐미</a>
        </div>
        <div class="navbar-right">
            <a href="#" class="icon">로그아웃</a>
            <a href="/" class="icon">홈</a>
        </div>
    </header>
	<nav class="navbar-menu">
        <a href="/noticeList" class="menu-item active">공지사항</a>
        <a href="/eventOnList" class="menu-item">이벤트</a>
    </nav>

    <div class="content">
        <!-- 제목과 날짜 -->
        <div class="notice-header">
            <h1 class="title">${notice.title}</h1>
            <p class="date">${notice.createdAt} 조회수 ${notice.views}</p>
        </div>

        <!-- 본문 내용 -->
        <div class="notice-content">
            <p>
            	${notice.content}
            </p>
        </div>

        <!-- 관련 공지사항 -->
        <div class="related-notices">
            <p><strong>관련 공지</strong></p>
            <ul>
                <li>이전글<a href="/notice/${nextNotice.id}">${nextNotice.title}</a></li>
                <li>다음글<a href="/notice/${preNotice.id}">${preNotice.title}</a></li>
            </ul>
        </div>

        <!-- 목록으로 돌아가기 버튼 -->
        <div class="back-button">
            <button onclick="location.href='/noticeList'">목록</button>
        </div>
    </div>
</body>
</html>