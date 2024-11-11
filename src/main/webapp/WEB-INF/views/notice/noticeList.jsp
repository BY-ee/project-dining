<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <a href="/eventOnList" class="menu-item">이벤트</a>
    </nav>

    <!-- 공지사항 컨테이너 -->
    <div class="container">
        <h1 class="page-title">공지사항</h1>

        <!-- 검색바 -->
        <div class="search-bar">
            <input type="text" placeholder="검색어를 입력하세요." class="search-input">
            <button class="search-button">검색</button>
        </div>

		<c:forEach var = "notice" items = "${noticePageResponse.list}">
			<div class="notice-item">
                <span class="notice-category">[공지]</span>
                <a href="/notice" class="notice-title">${notice.title}</a>
                <span class="notice-date">${notice.createdAt}</span>
                <span class="notice-views">${notice.views}</span>
            </div>
		</c:forEach>
        <!-- 페이지네이션 -->
        <div class="pagination">
        	<c:if test="${noticePageResponse.startPage > 1}">
        		<a href="/noticeList?page=${noticePageResponse.startPage-1}">이전</a>
        	</c:if>
        	<c:forEach var="i" begin="${noticePageResponse.startPage}" end ="${noticePageResponse.endPage}">
        		<a href="/noticeList?page=${i}" 
        		 class = "${i == noticePageResponse.currentPage ? 'active' : ''}">${i}</a>
        	</c:forEach>
        	<c:if test="${noticePageResponse.endPage < noticePageResponse.totalPage}">
        		<a href="/noticeList?page=${noticePageResponse.endPage+1}">다음</a>
        	</c:if>
        </div>
    </div>
</body>
</html>