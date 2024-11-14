<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이벤트 상세</title>
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
        <a href="/noticeList" class="menu-item">공지사항</a>
        <a href="/eventOnList" class="menu-item active">이벤트</a>
    </nav>

    <div class="content">
        <!-- 제목과 날짜 -->
        <div class="notice-header">
            <h1 class="title">${event.title}</h1>
            <p class="date">${event.startDate} ~ ${event.endDate} | 조회수 ${event.views}</p>
        </div>

        <!-- 본문 내용 -->
        <div class="notice-content">
            <p>
            	${event.content}
            </p>
        </div>

        <!-- 관련 공지사항 -->
        <div class="related-notices">
            <p><strong>관련 공지</strong></p>
            <ul>
                <li><a href="#">11월 넥슨플레이 바코드캐시충전 이벤트</a></li>
                <li><a href="#">10/29(화) 도서문화상품권 결제서비스 점검 안내</a></li>
            </ul>
        </div>

        <!-- 목록으로 돌아가기 버튼 -->
        <div class="back-button">
            <button onclick="location.href='/eventOnList'">목록</button>
        </div>
    </div>
</body>
</html>