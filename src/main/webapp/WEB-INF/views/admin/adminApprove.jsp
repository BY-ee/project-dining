<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/admin/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>게시글 승인</title>
</head>
<body>

    <!-- Main Content -->
    <div class="main-content">
        <h2>게시글 승인</h2>

        <!-- Search Box -->
        <div class="search-box">
            <select name="search-keywords">
                <option value="id">ID</option>
                <option value="storeName">가게 이름</option>
                <option value="address">주소</option>
                <option value="tel">전화번호</option>
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
                    <th>가게 이름</th>
                    <th>주소</th>
                    <th>전화번호</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>2</td>
                    <td><a href="#">모수</a></td>
                    <td>서울특별시 용산구</td>
                    <td>02-111-1111</td>
                    <td>대기</td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>
