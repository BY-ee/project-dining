<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>공지 작성폼</title>
    <style>
        .form-group {
            display: flex;
            flex-direction: column;
            margin-bottom: 20px;
        }

        .form-group label {
            display: inline-block;
            margin-bottom: 4px;
            font-weight: bold;
            align-self: start;
            padding: 5px;
        }

        .form-group select {
            width: 30%;
            padding: 5px;
        }

        .form-group input {
            width: 100%;
            padding: 5px;
        }

        .form-group textarea {
            width: 100%;
            height: 200px;
            resize: none;
            padding: 5px;
        }
    </style>
</head>
<body>

    <!-- Main Content -->
    <div class="main-content">
        <h2>공지 작성</h2>

        <div style="width: 400px; margin: 0 auto;">
            <div class="form-group">
                <label for="topic">주제</label>
                <select id="topic" name="topic">
                    <option value="">주제 선택</option>
                    <option value="notice">공지</option>
                    <option value="maintainance">점검</option>
                </select>
            </div>

            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" placeholder="제목을 입력하세요." />
            </div>

            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content" name="content" placeholder="내용을 입력하세요."></textarea>
            </div>

            <div>
                <button class="btn edit-btn">작성</button>
                <button class="btn delete-btn" onclick="location.href='/admin/notice'">돌아가기</button>
            </div>
        </div>
    </div>
</body>
</html>
