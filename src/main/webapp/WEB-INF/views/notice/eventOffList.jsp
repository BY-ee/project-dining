<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/WEB-INF/views/templates/head.jsp" %>
<link rel="stylesheet" href="css/notice/commonStyles.css">
<link rel="stylesheet" href="css/notice/noticeCommonStyles.css">
<link rel="stylesheet" href="css/notice/eventListStyles.css">
<body>
	<%@ include file="/WEB-INF/views/templates/header.jsp" %>
	<nav class="navbar-menu">
		<a href="/noticeList" class="menu-item">공지사항</a> 
		<a href="/eventList" class="menu-item active">이벤트</a>
	</nav>
	<!-- 이벤트 콘텐츠 -->
	<div class="event-section">
	<h3>${member.nickname }</h3>
		<div class="tab-header">
			<a href="/eventOnList">진행중 이벤트</a>
			<a class="active" href="/eventOffList">종료된 이벤트</a>
		</div>
		<div class="category-tabs">
			<button onclick = "location.href='/eventOffList'" class="${empty param.category ? 'active' : ''}">전체</button>
			<button onclick = "location.href='/eventOffList?category=할인'" class="${param.category == '할인' ? 'active' : ''}">할인</button>
			<button onclick = "location.href='/eventOffList?category=포인트'" class="${param.category == '포인트'? 'active' : ''}">포인트</button>
			<button onclick = "location.href='/eventOffList?category=기타'" class="${param.category == '기타'? 'active' : ''}">기타</button>
		</div>

		<div class="event-items">
			<c:forEach var = "event" items = "${eventPageResponse.list}">
				<a href="/event/${event.id}" class="event-item">
					<img src="images/image2.png">
                	<h3>${event.title}</h3>
                	<span><fmt:formatDate value="${event.startDate}" pattern="yyyy/MM/dd" /> ~ <fmt:formatDate value="${event.endDate}" pattern="yyyy/MM/dd" /></span>
                	<span>조회수${event.views}</span>
                	<span class="category">${event.category}</span>
                </a>	
			</c:forEach>
		</div>
		<!-- 페이지네이션 -->
        <div class="pagination">
        	<c:if test="${eventPageResponse.startPage > 1}">
        		<a href="/eventOffList?page=${eventPageResponse.startPage-1}&category=${eventPageResponse.category}">이전</a>
        	</c:if>
        	<c:forEach var="i" begin="${eventPageResponse.startPage}" end ="${eventPageResponse.endPage}">
        		<a href="/eventOffList?page=${i}&category=${eventPageResponse.category}" 
        		 class = "${i == eventPageResponse.currentPage ? 'active' : ''}">${i}</a>
        	</c:forEach>
        	<c:if test="${eventPageResponse.endPage < eventPageResponse.totalPage}">
        		<a href="/eventOffList?page=${eventPageResponse.endPage+1}&category=${eventPageResponse.category}">다음</a>
        	</c:if>
        </div>
	</div>
<%@ include file="/WEB-INF/views/templates/footer.jsp" %>
</body>
</html>