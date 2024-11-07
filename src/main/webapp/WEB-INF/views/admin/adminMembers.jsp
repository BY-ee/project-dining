<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/WEB-INF/views/admin/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>회원관리</title>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="/js/admin/adminMember.js"></script>
</head>
<body>

    <!-- Main Content -->
    <div class="main-content">
        <h2>회원관리</h2>

        <!-- Search Box -->
        <div class="search-box">
            <select name="search-keywords">
                <option value="id">ID</option>
                <option value="userid">유저 아이디</option>
                <option value="nickname">닉네임</option>
                <option value="email">이메일</option>
                <option value="status">상태</option>
            </select>
            <input type="text" placeholder="검색">
            <button>검색</button>
        </div>

        <!-- Table -->
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>유저 아이디</th>
                    <th>닉네임</th>
                    <th>이메일</th>
                    <th>자기소개</th>
                    <th>가입일자</th>
                    <th>탈퇴일자</th>
                    <th>차단</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="member" items="${members.content}">
                    <tr>
                        <td>${member.id}</td>
                        <td>${member.memberId}</td>
                        <td>${member.nickname}</td>
                        <td>${member.email}</td>
                        <td><a href="#" class="intro-link">확인</a></td>
                        <td><fmt:formatDate value="${member.createdAt}" pattern="yy.MM.dd hh:mm:ss (EEE)" /></td>
                        <td><fmt:formatDate value="${member.deletedDate}" pattern="yy.MM.dd hh:mm:ss (EEE)" /></td>
                        <td>
                            <select name="user-ban-time">
                                <option value="1">1일</option>
                                <option value="3">3일</option>
                                <option value="7">7일</option>
                                <option value="30">30일</option>
                                <option value="0">영구</option>
                            </select>
                            <button class="delete-btn">차단</button>
                            <button class="edit-btn">차단 해제</button>
                        </td>
                        <td style="color: #5a7beb;">${member.status}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Pagination -->
        <div class="pagination">
            <div class="move-page-link">
                <c:if test="${members.currentPage > members.start}">
                    <a class="page-link" href="#">처음</a>
                </c:if>

                <a class="page-link" href="#">이전</a>
            </div>

            <div class="page">
                <c:forEach var="page" begin="${members.start}" end="${members.totalPages}">
                    <c:choose>
                        <c:when test="${page == members.currentPage}">
                            <span class="current-page">${page}</span>
                        </c:when>
                        <c:otherwise>
                            <a class="page-link" href="#">${page}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>

            <div class="move-page-link">
                <a class="page-link" href="#">다음</a>

                <c:if test="${members.currentPage < members.end}">
                    <a class="page-link" href="#">끝</a>
                </c:if>
            </div>
        </div>
    </div>

    <!-- 자기소개 팝업 -->
    <div class="popup-overlay" id="popup-overlay">
        <div class="popup-content">
            <button class="popup-close" onclick="closePopup()">X</button>
            <h3 class="popup-title">자기소개</h3>
            <div id="intro-content"></div>
        </div>
    </div>
</body>
</html>
