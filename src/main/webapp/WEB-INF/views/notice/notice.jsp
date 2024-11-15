<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/templates/head.jsp" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="/css/notice/commonStyles.css">
<link rel="stylesheet" href="/css/notice/noticeCommonStyles.css">
<link rel="stylesheet" href="/css/notice/noticeStyles.css">
<body>
    <%@ include file="/WEB-INF/views/templates/header.jsp" %>
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
            	<c:if test="${nextNotice.id != null}">
            		<li class="related-notices-item">
            			이전글<a href="/notice/${nextNotice.id}"> ${nextNotice.title}</a>
            		</li>
            	</c:if>
                <c:if test="${preNotice.id != null}">
                	<li class="related-notices-item">
                		다음글<a href="/notice/${preNotice.id}"> ${preNotice.title}</a>
                	</li>
                </c:if>
            </ul>
        </div>

        <!-- 목록으로 돌아가기 버튼 -->
        <div class="back-button">
            <button onclick="location.href='/noticeList'">목록</button>
        </div>
    </div>
    <%@ include file="/WEB-INF/views/templates/footer.jsp" %>
</body>
</html>