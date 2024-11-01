<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>리뷰 관리</title>
</head>
<body>

    <!-- Main Content -->
    <div class="main-content">
        <h2>리뷰 관리</h2>

        <!-- Search Box -->
        <div class="search-box">
            <select name="search-keywords">
                <option value="id">ID</option>
                <option value="userId">유저 ID</option>
                <option value="storeId">가게 ID</option>
                <option value="score">평점</option>
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
                    <th>유저 ID</th>
                    <th>가게 ID</th>
                    <th>평점</th>
                    <th>리뷰</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>2</td>
                    <td><a href="/admin/members">2</a></td>
                    <td><a href="/admin/posts">2</a></td>
                    <td class="star-rating">★☆☆☆☆</td>
                    <td><a href="#">ㅇㅉ</a></td>
                    <td style="color: #f44;">게시중단</td>
                </tr>

                <tr>
                    <td>1</td>
                    <td><a href="/admin/members">1</a></td>
                    <td><a href="/admin/posts">3</a></td>
                    <td class="star-rating">★★★★★</td>
                    <td><a href="#">맛있었습니다</a></td>
                    <td style="color: #5a7beb;">게시</td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>
