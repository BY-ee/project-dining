<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>공지사항 관리</title>
</head>
<body>

    <!-- Main Content -->
    <div class="main-content">
        <h2>이벤트 관리</h2>

        <!-- Search Box -->
        <div class="search-box">
            <select name="search-keywords">
                <option value="id">ID</option>
                <option value="title">제목</option>
                <option value="status">상태</option>
            </select>
            <input type="text" placeholder="검색">
            <button>검색</button>
        </div>

        <!-- Product Table -->
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>제목</th>
                    <th>날짜</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>2</td>
                    <td><a href="#">[할인] 30주년 기념, 소주 3천원!</a></td>
                    <td>24.10.31 15:12</td>
                    <td style="color: #5a7beb;">진행중</td>
                </tr>

                <tr>
                    <td>1</td>
                    <td><a href="#">[포인트] 1주년 이벤트</a></td>
                    <td>24.09.01 12:31</td>
                    <td style="color: #f44;">종료</td>
                </tr>
            </tbody>
        </table>

        <button class="btn edit-btn" style="margin-top: 40px;"
            onclick="location.href='/admin/event/write'">이벤트 작성</button>
    </div>
</body>
</html>
