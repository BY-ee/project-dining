<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <!-- 한글 인코딩 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/css/templates/header.css"> <!-- header css -->


<!-- header 태그 템플릿 -->
<header class="header">
    <!-- 페이지 이름 및 로고 -->
    <div class="page-name">
        <a href="/"><img src="/images/home/NYUMINYUMI.png" style="width: 60%;" alt="냐미냐미"></a>
    </div>
    
    <!-- 인증 버튼 -->
    <div class="auth-buttons">
        <c:choose>
            <c:when test="${not empty sessionScope.loginUser}">
                <!-- 로그인된 사용자를 위한 메뉴 -->
                <div class="user-popup-container">
                    <button class="menu-btn"> ☰ </button>
                    <div class="user-popup" style="display: none;">
                        <span class="welcome-message">환영합니다, ${sessionScope.loginUser.nickname}님!</span>
                        <a href="/profile">프로필</a>
                        <a href="/myPage">마이페이지</a>
                        <a href="/settings">환경설정</a>
                        <a href="/recommendations">1:1 추천</a>
                        <form action="/logout" method="post" style="display:inline;">
                            <button type="submit">로그아웃</button>
                        </form>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- 비로그인 사용자를 위한 로그인/회원가입 버튼 -->
                <form action="/loginForm.do" method="get" style="display:inline;">
                    <button type="submit">로그인/회원가입</button>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</header>