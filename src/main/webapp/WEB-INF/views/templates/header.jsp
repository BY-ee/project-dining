<!-- header.jsp -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <!-- 한글 인코딩 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="/css/templates/header.css"> <!-- header css -->
<link rel="stylesheet" href="/css/community/community.css">
<link rel="stylesheet" href="/css/community/chat.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">


<!-- 헤더 -->
<header class="header">
    <!-- 로고 -->
    <div class="page-name">
        <a href="/"><img src="/images/home/NYUMINYUMI.png" style="width: 60%;" alt="냐미냐미"></a>
    </div>
    
    <!-- 인증 버튼 -->
    <div class="auth-buttons">
        <c:choose>
            <c:when test="${not empty sessionScope.loginUser}">
                <!-- 로그인된 사용자를 위한 메뉴 -->
                <div class="user-popup-container">
                    <a href="/community">커뮤니티</a>
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
                <!-- 로그인된 사용자의 ID와 닉네임을 저장 -->
                <input type="hidden" id="memberId" value="${sessionScope.loginUser.id}">
                <input type="hidden" id="nickname" value="${sessionScope.loginUser.nickname}">
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

<script src="/js/community/chat.js"></script> <!-- 채팅 관련 JS 파일 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
 
<!-- 채팅 팝업 HTML 추가 -->
<div id="chat-popup">
    <!-- 상단 헤더 -->
    <div id="chat-room-header">
        <h2 id="chat-room-name">Chat Room</h2>
        <button id="close-chat-popup">X</button>
    </div>

    <!-- 채팅 내용 -->
    <div id="chat-content"></div>

    <!-- 입력창과 도구 -->
    <div id="chat-input-container">
        <input type="text" id="chat-input" placeholder="메시지 입력">
        <div id="chat-tools">
            <div>
                <button>사진 첨부</button>
                <button>이모티콘</button>
            </div>
            <button id="send-chat">전송</button>
        </div>
    </div>
</div>

