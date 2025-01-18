<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ include file="/WEB-INF/views/admin/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <title>이벤트 상세</title>
    <link rel="stylesheet" href="/css/admin/adminNotice.css" />
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <script src="/js/admin/adminEvent.js"></script>
  </head>
  <body>
    <div class="content">
      <div class="notice-header">
        <h1 class="title">${event.title}</h1>
        <p class="date"><fmt:formatDate value="${event.createdAt}" pattern="yyyy.MM.dd(EEE) HH:mm:ss" /> | 조회수 ${event.views}</p>
      </div>

      <div class="notice-content">
        <c:if test="${not empty event.eventImage}">
          <img src="${event.eventImage}" style="width: 80%; margin: 0 10%" alt="event" />
        </c:if>
        ${event.content}
      </div>

      <div class="button-container">
        <c:choose>
          <c:when test="${event.status == 'active'}">
            <a class="active-btn" href="/admin/events/${event.id}/edit">수정</a>
            <a class="inactive-btn inactive-event" data-id="${event.id}" href="#">게시중단</a>
            <a class="active-btn" href="/admin/events">목록</a>
          </c:when>
          <c:otherwise>
            <a class="active-btn" href="/admin/events/${event.id}/edit">수정</a>
            <a class="active-btn reactive-event" data-id="${event.id}" href="#">재게시</a>
            <a class="active-btn" href="/admin/events">목록</a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </body>
</html>
