<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ include file="/WEB-INF/views/admin/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <title>회원관리</title>

    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <script src="/js/admin/adminMember.js"></script>
  </head>
  <body>
    <div class="main-content">
      <h2>회원관리</h2>

      <div class="search-box">
        <form method="get" action="/admin/members">
          <select name="column">
            <option value="id">ID</option>
            <option value="member_id">유저 아이디</option>
            <option value="nickname">닉네임</option>
            <option value="email">이메일</option>
            <option value="status">상태</option>
          </select>
          <input type="text" name="keyword" placeholder="검색" />
          <button>검색</button>
        </form>
      </div>

      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>유저 아이디</th>
            <th>닉네임</th>
            <th>이메일</th>
            <th>가입일</th>
            <th>차단해제일</th>
            <th>차단</th>
            <th>상태</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="member" items="${pagination.content}">
            <tr>
              <td>${member.id}</td>
              <td><a href="#" class="member-link" data-id="${member.id}">${member.memberId}</a></td>
              <td>${member.nickname}</td>
              <td>${member.email}</td>
              <td><fmt:formatDate value="${member.createdAt}" pattern="yy.MM.dd hh:mm:ss (EEE)" /></td>
              <td><fmt:formatDate value="${member.reactiveDate}" pattern="yy.MM.dd (EEE)" /></td>
              <td>
                <select class="member-ban-time" data-id="${member.id}" name="member-ban-time">
                  <option value="1">1일</option>
                  <option value="3">3일</option>
                  <option value="7">7일</option>
                  <option value="30">30일</option>
                  <option value="9999">영구</option>
                </select>
                <button class="delete-btn block-btn" data-id="${member.id}">차단</button>
                <button class="edit-btn unblock-btn" data-id="${member.id}">차단 해제</button>
              </td>
              <td class="member-status" data-id="${member.id}" data-status="${member.status}">${member.status}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>

      <!-- Pagination -->
      <div class="pagination">
        <!-- 클래스명을 동적으로 변경 -->
        <div class="move-page-link">
          <a class="page-link ${pagination.isFirstPageBtnVisible() ? '' : 'disabled'}" href="/admin/members?page=1">처음</a>
          <a class="page-link ${pagination.page > 1 ? '' : 'disabled'}" href="/admin/members?page=${pagination.page - 1}">이전</a>
        </div>

        <div class="page">
          <c:forEach var="page" begin="${pagination.start}" end="${pagination.end}">
            <c:choose>
              <c:when test="${page == pagination.page}">
                <span class="current-page">${page}</span>
              </c:when>
              <c:otherwise>
                <a class="page-link" href="/admin/members?page=${page}">${page}</a>
              </c:otherwise>
            </c:choose>
          </c:forEach>
        </div>

        <div class="move-page-link">
          <a class="page-link ${pagination.page < pagination.totalPages ? '' : 'disabled'}" href="/admin/members?page=${pagination.page + 1}">다음</a>
          <a class="page-link ${pagination.isLastPageBtnVisible() ? '' : 'disabled'}" href="/admin/members?page=${pagination.totalPages}">끝</a>
        </div>
      </div>
    </div>

    <!-- 자기소개 팝업 -->
    <div class="popup-overlay" id="popup-overlay">
      <div class="popup-content">
        <button class="popup-close" onclick="closePopup()">X</button>
        <div id="member-content"></div>
      </div>
    </div>
  </body>
</html>
