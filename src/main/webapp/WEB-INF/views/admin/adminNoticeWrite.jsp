<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/admin/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>작성폼</title>
    <link rel="stylesheet" href="/css/admin/adminNotice.css" />
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="/js/admin/notice.js"></script>
</head>
<body>
    <!-- Main Content -->
    <div class="main-content">
        <h2>공지 작성</h2>

        <div class="form-container">
            <div class="form-group">
                <label for="category">주제</label>
                <select id="category" name="category">
                    <option value="">주제 선택</option>
                    <option value="notice">공지</option>
                    <option value="event">이벤트</option>
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

            <div class="upload-form text-left">
                <label for="file-upload" class="custom-file-upload">파일 선택</label>
                <input id="file-upload" type="file" name="file" onchange="showFileName()">
                <div class="file-name" id="file-name">선택된 파일이 없습니다.</div>
            </div>

            <div>
                <button class="btn edit-btn" id="write-notice-btn">작성</button>
                <button class="btn delete-btn" onclick="location.href='/admin/notice'">돌아가기</button>
            </div>
        </div>
    </div>
</body>
</html>
