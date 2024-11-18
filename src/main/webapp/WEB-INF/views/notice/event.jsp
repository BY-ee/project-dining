<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/templates/head.jsp" %>
<link rel="stylesheet" href="/css/notice/commonStyles.css">
<link rel="stylesheet" href="/css/notice/noticeCommonStyles.css">
<link rel="stylesheet" href="/css/notice/noticeStyles.css">
<body>
    <!-- 상단바 -->
    <%@ include file="/WEB-INF/views/templates/header.jsp" %>
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
            	<c:if test="${nextEvent.id != null}">
            		<li class="related-notices-item">
            			이전글<a href="/event/${nextEvent.id}"> ${nextEvent.title}</a>
            		</li>
            	</c:if>
                <c:if test="${preEvent.id != null}">
                	<li class="related-notices-item">
                		다음글<a href="/event/${preEvent.id}"> ${preEvent.title}</a>
                	</li>
                </c:if>
            </ul>
        </div>

        <!-- 목록으로 돌아가기 버튼 -->
        <div class="back-button">
            <button onclick="location.href='/eventOnList'">목록</button>
        </div>
    </div>
<%@ include file="/WEB-INF/views/templates/footer.jsp" %>
</body>
</html>