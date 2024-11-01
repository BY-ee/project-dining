<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>이벤트 작성폼</title>
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

        /* 파일 업로드 폼 */
        .upload-form {
            margin-bottom: 20px;
        }

        .upload-form h2 {
            margin-bottom: 20px;
            font-size: 1.2em;
            color: #333;
        }

        .upload-form input[type="file"] {
            display: none;
        }

        .custom-file-upload {
            display: inline-block;
            padding: 10px;
            color: #fff;
            background-color: #007bff;
            border-radius: 4px;
            cursor: pointer;
            margin-bottom: 5px;
        }

        .upload-form button {
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 1em;
            color: #fff;
            background-color: #28a745;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .upload-form button:hover {
            background-color: #218838;
        }
    </style>
    <script>
        function showFileName() {
            const fileInput = document.getElementById('file-upload');
            const fileNameDisplay = document.getElementById('file-name');
            
            // 선택된 파일의 이름을 표시
            if (fileInput.files.length > 0) {
                fileNameDisplay.textContent = fileInput.files[0].name;
            } else {
                fileNameDisplay.textContent = '선택된 파일이 없습니다.';
            }
        }
    </script>
</head>
<body>

    <!-- Main Content -->
    <div class="main-content">
        <h2>이벤트 작성</h2>

        <div style="width: 400px; margin: 0 auto;">
            <div class="form-group">
                <label for="topic">주제</label>
                <select id="topic" name="topic">
                    <option value="">주제 선택</option>
                    <option value="notice">할인</option>
                    <option value="event">포인트</option>
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
            
            <div class="upload-form" style="text-align: start;">
                <label for="file-upload" class="custom-file-upload">파일 선택</label>
                <input id="file-upload" type="file" name="file" onchange="showFileName()">
                <div class="file-name" id="file-name">선택된 파일이 없습니다.</div>
            </div>

            <div>
                <button class="btn edit-btn">작성</button>
                <button class="btn delete-btn" onclick="location.href='/admin/event'">돌아가기</button>
            </div>
        </div>
    </div>
</body>
</html>
