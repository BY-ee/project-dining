<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/admin/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>공지사항 관리</title>
</head>
<body>

    <!-- Main Content -->
    <div class="main-content">
        <h2>공지사항 관리</h2>

        <!-- Search Box -->
        <div class="search-box">
            <select name="search-keywords">
                <option value="id">ID</option>
                <option value="title">제목</option>
                <option value="category">분류</option>
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
                    <td>4</td>
                    <td><a href="#">[이벤트] 30주년 기념, 소주 3천원!</a></td>
                    <td>24.10.31 ~ 24.11.01</td>
                    <td style="color: #5a7beb;">진행중</td>
                </tr>

                <tr>
                    <td>3</td>
                    <td><a href="#">[이벤트] 1주년 이벤트</a></td>
                    <td>24.09.01 ~ 24.12.31</td>
                    <td style="color: #f44;">종료</td>
                </tr>

                <tr>
                    <td>2</td>
                    <td><a href="#">[공지] 악질 유저의 대응 방침 안내</a></td>
                    <td>24.10.30 17:01</td>
                    <td style="color: #5a7beb;">게시</td>
                </tr>

                <tr>
                    <td>1</td>
                    <td><a href="#">[공지] 11월 19일(일) 사이트 점검 안내</a></td>
                    <td>24.10.30 15:23</td>
                    <td style="color: #f44;">게시중단</td>
                </tr>
            </tbody>
        </table>

        <button class="btn edit-btn" style="margin-top: 40px;"
            onclick="location.href='/admin/notice/write'">공지작성</button>
    </div>
</body>
</html>
