<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>회원관리</title>
</head>

<style>
    /* 팝업 스타일 */
    .popup-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        justify-content: center;
        align-items: center;
        z-index: 1000;
    }
    .popup-content {
        background: #fff;
        padding: 20px;
        border-radius: 8px;
        width: 300px;
        max-width: 80%;
        text-align: center;
    }
    .popup-close {
        background: #f00;
        color: #fff;
        border: none;
        padding: 5px 10px;
        cursor: pointer;
        float: right;
        margin-top: -10px;
        margin-right: -10px;
    }
</style>

<script>
    window.onload = () => {
        document.querySelectorAll('.intro-link').forEach(link => {
            link.addEventListener('click', function(event) {
                event.preventDefault();
                const intro = event.target.getAttribute('data-intro');
                document.getElementById('introText').innerText = intro;
                document.getElementById('popupOverlay').style.display = 'flex';
            });
        });
    }

    function closePopup() {
        document.getElementById('popupOverlay').style.display = 'none';
    }
</script>
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
                <tr>
                    <td>3</td>
                    <td>user1</td>
                    <td>닉네임123</td>
                    <td>user1@kakao.com</td>
                    <td><a href="#" class="intro-link" data-intro="자기소개에 들어갈 내용을 jstl로 넣음">테스트</a></td>
                    <td>2024-10-29</td>
                    <td></td>
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
                    <td style="color: #5a7beb;">활동</td>
                </tr>

                <tr>
                    <td>2</td>
                    <td>tnmm123</td>
                    <td>tnmm11</td>
                    <td>tnmm123@gmail.com</td>
                    <td><a href="#">ㅇㅉ</a></td>
                    <td>2024-01-05</td>
                    <td>2024-10-30</td>
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
                    <td style="color: #ff4b4b;">영구차단</td>
                </tr>

                <tr>
                    <td>1</td>
                    <td>dkdlel</td>
                    <td>Nickname1</td>
                    <td>dkdlel@naver.com</td>
                    <td><a href="#">자기소개입니다</a></td>
                    <td>2012-05-05</td>
                    <td></td>
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
                    <td>차단 ( ~ 24.11.01 15:25)</td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- 자기소개 팝업 -->
    <div class="popup-overlay" id="popupOverlay">
        <div class="popup-content">
            <button class="popup-close" onclick="closePopup()">X</button>
            <p id="introText"></p>
        </div>
    </div>
</body>
</html>
