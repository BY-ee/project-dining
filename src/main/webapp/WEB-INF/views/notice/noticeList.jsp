<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<%@ include file="/WEB-INF/views/templates/head.jsp" %>
    <link rel="stylesheet" href="css/notice/commonStyles.css">
    <link rel="stylesheet" href="css/notice/noticeCommonStyles.css">
    <link rel="stylesheet" href="css/notice/noticeListStyles.css">
</head>
<body>
    <%@ include file="/WEB-INF/views/templates/header.jsp" %>
	<nav class="navbar-menu">
        <a href="/noticeList" class="menu-item active">공지사항</a>
        <a href="/eventOnList" class="menu-item">이벤트</a>
    </nav>
	<h3>${member.nickname}</h3>
    <!-- 공지사항 컨테이너 -->
    <div class="container">
        <h1 class="page-title">공지사항</h1>

        <!-- 검색바 -->
        <div class="search-bar">
        	<form action="/noticeList" method="get">
        		<select name="searchType" class="searchType-input">
                	<option value="제목" ${noticePageResponse.searchType == "제목" ? "selected" : ""}>제목</option>
                	<option value="내용" ${noticePageResponse.searchType == "내용" ? "selected" : ""}>내용</option>
                	<option value="제목+내용" ${noticePageResponse.searchType == "제목+내용" ? "selected" : ""}>제목 + 내용</option>
            	</select>
	            <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요." value="${noticePageResponse.searchKeyword}" class="search-input">
	            <button type="submit" class="search-button">검색</button>
        	</form>
        </div>

		<c:forEach var = "notice" items = "${noticePageResponse.list}">
			<div class="notice-item">
                <span class="notice-category">[공지]</span>
                <a href="/notice/${notice.id}" class="notice-title">${notice.title}</a>
                <span class="notice-date">${notice.createdAt}</span>
                <span class="notice-views">${notice.views}</span>
            </div>
		</c:forEach>
        <!-- 페이지네이션 -->
        <div class="pagination">
        	<c:if test="${noticePageResponse.startPage > 1}">
        		<a href="/noticeList?page=${noticePageResponse.startPage-1}&searchType=${noticePageResponse.searchType}&searchKeyword=${noticePageResponse.searchKeyword}">이전</a>
        	</c:if>
        	<c:forEach var="i" begin="${noticePageResponse.startPage}" end ="${noticePageResponse.endPage}">
        		<a href="/noticeList?page=${i}&searchType=${noticePageResponse.searchType}&searchKeyword=${noticePageResponse.searchKeyword}" 
        		 class = "${i == noticePageResponse.currentPage ? 'active' : ''}">${i}</a>
        	</c:forEach>
        	<c:if test="${noticePageResponse.endPage < noticePageResponse.totalPage}">
        		<a href="/noticeList?page=${noticePageResponse.endPage+1}&searchType=${noticePageResponse.searchType}&searchKeyword=${noticePageResponse.searchKeyword}">다음</a>
        	</c:if>
        </div>
    </div>
    <%@ include file="/WEB-INF/views/templates/footer.jsp" %>
</body>
</html>