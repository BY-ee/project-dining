<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/admin/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>작성폼</title>
    <link rel="stylesheet" href="/css/admin/adminNotice.css">
    <style>
        .mb-0 {
            margin-bottom: 0;
        }
    </style>
    
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="/js/admin/notice.js"></script>
</head>
<body>
    <div class="content">        
        <div class="form-group">
            <div class="notice-header mb-0">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" value="${notice.title}" placeholder="제목을 입력하세요." />
            </div>
        </div>

        <div class="form-group">
            <div class="notice-content">
                <label for="content">내용</label>
                <textarea id="content" name="content" placeholder="내용을 입력하세요.">${notice.content}</textarea>
            </div>
        </div>

        <div class="upload-form text-left">
            <label for="notice-image" class="custom-file-upload">파일 선택</label>
            <input id="notice-image" type="file" name="noticeImage">
            <div class="file-name" id="file-name">${notice.noticeImage}</div>
        </div>

        <div class="button-container">
            <a class="active-btn" id="edit-notice-btn">수정</a>
            <a class="active-btn" href='/admin/notice'>목록</a>
        </div>
    </div>
</body>
</html>
