<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
    <link rel="stylesheet" href="css/notice/commonStyles.css">
    <link rel="stylesheet" href="css/notice/noticeCommonStyles.css">
    <link rel="stylesheet" href="css/notice/noticeListStyles.css">
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
        <a href="#" class="menu-item active">공지사항</a>
        <a href="/eventList" class="menu-item">이벤트</a>
    </nav>

    <!-- 공지사항 컨테이너 -->
    <div class="container">
        <h1 class="page-title">공지사항</h1>

        <!-- 검색바 -->
        <div class="search-bar">
            <input type="text" placeholder="검색어를 입력하세요." class="search-input">
            <button class="search-button">검색</button>
        </div>

        <!-- 공지사항 리스트 -->
        <div class="notice-list">
            <div class="notice-item">
                <span class="notice-category">[공지]</span>
                <a href="/notice" class="notice-title">11월 넥슨플레이 바코드캐시충전 이벤트</a>
                <span class="notice-date">2024-10-31</span>
                <span class="notice-views">7533</span>
            </div>
            <!-- 더 많은 공지사항 항목들 -->
            <div class="notice-item">
                <span class="notice-category">[공지]</span>
                <a href="#" class="notice-title">11월 넥슨플레이 바코드캐시충전 이벤트</a>
                <span class="notice-date">2024-10-31</span>
                <span class="notice-views">7533</span>
            </div>
            <div class="notice-item">
                <span class="notice-category">[공지]</span>
                <a href="#" class="notice-title">11월 넥슨플레이 바코드캐시충전 이벤트</a>
                <span class="notice-date">2024-10-31</span>
                <span class="notice-views">7533</span>
            </div>
            <div class="notice-item">
                <span class="notice-category">[공지]</span>
                <a href="#" class="notice-title">11월 넥슨플레이 바코드캐시충전 이벤트</a>
                <span class="notice-date">2024-10-31</span>
                <span class="notice-views">7533</span>
            </div>
            <div class="notice-item">
                <span class="notice-category">[공지]</span>
                <a href="#" class="notice-title">11월 넥슨플레이 바코드캐시충전 이벤트</a>
                <span class="notice-date">2024-10-31</span>
                <span class="notice-views">7533</span>
            </div>
            <div class="notice-item">
                <span class="notice-category">[공지]</span>
                <a href="#" class="notice-title">11월 넥슨플레이 바코드캐시충전 이벤트</a>
                <span class="notice-date">2024-10-31</span>
                <span class="notice-views">7533</span>
            </div>
            <div class="notice-item">
                <span class="notice-category">[공지]</span>
                <a href="#" class="notice-title">11월 넥슨플레이 바코드캐시충전 이벤트</a>
                <span class="notice-date">2024-10-31</span>
                <span class="notice-views">7533</span>
            </div>
            <div class="notice-item">
                <span class="notice-category">[공지]</span>
                <a href="#" class="notice-title">11월 넥슨플레이 바코드캐시충전 이벤트</a>
                <span class="notice-date">2024-10-31</span>
                <span class="notice-views">7533</span>
            </div>
            <div class="notice-item">
                <span class="notice-category">[공지]</span>
                <a href="#" class="notice-title">11월 넥슨플레이 바코드캐시충전 이벤트</a>
                <span class="notice-date">2024-10-31</span>
                <span class="notice-views">7533</span>
            </div>
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination">
            <a href="#" class="page-link">1</a>
            <a href="#" class="page-link">2</a>
            <a href="#" class="page-link">3</a>
            <span class="page-link">...</span>
            <a href="#" class="page-link">10</a>
        </div>
    </div>
</body>
</html>