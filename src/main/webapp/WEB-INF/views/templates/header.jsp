<!-- header.jsp -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <!-- 한글 인코딩 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- 헤더 -->
<header class="header">
    <!-- 로고 -->
    <div class="page-name">
        <a href="/"><img src="/images/home/NYUMINYUMI.png" style="width: 60%;" alt="냐미냐미"></a>
    </div>
    
    <!-- 인증 버튼 -->
    <div class="auth-buttons">
        <c:choose>
            <c:when test="${sessionMember.role != 'ROLE_ANONYMOUS'}">
                <!-- 로그인된 사용자를 위한 메뉴 -->
                <div class="user-popup-container">
                    <a class="link-btn" href="/community">커뮤니티</a>
                    <button class="menu-btn"> ☰ </button>
                    <div class="user-popup" style="display: none;">
                        <span class="welcome-message">환영합니다, ${sessionMember.nickname}님!</span>
                        <a href="/profile">프로필</a>
                        <a href="/mypage">활동내역</a>
                        <a href="/account">계정정보</a>
                        <a href="/recommendations">1:1 추천</a>
                        <form action="/logout" method="post" style="display:inline;">
                            <button type="submit">로그아웃</button>
                        </form>
                    </div>
                </div>
                <!-- 로그인된 사용자의 ID와 닉네임을 저장 -->
                <input type="hidden" id="memberId" value="${sessionMember.id}">
                <input type="hidden" id="nickname" value="${sessionMember.nickname}">
            </c:when>
            <c:otherwise>
                <!-- 비로그인 사용자를 위한 로그인/회원가입 버튼 -->
                <!-- <form action="/login" method="get" style="display:inline;"> -->
                    <!-- <button type="submit">로그인 / 회원가입</button> -->
                <!-- </form> -->
                 <a class="link-btn" href="/login">로그인 / 회원가입</a>
            </c:otherwise>
        </c:choose>
    </div>
</header>

 
<!-- 채팅 팝업 HTML 추가 -->
<!-- <div id="chat-popup">
    상단 헤더
    <div id="chat-room-header">
        <h2 id="chat-room-name">Chat Room</h2>
        <button id="close-chat-popup">X</button>
    </div>

    채팅 내용
    <div id="chat-content"></div>

    입력창과 도구
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
 -->
 
<div id="chat-list-container">
    <!-- 채팅 목록 UI -->
    <div id="chat-list-header">
        <h2 id="chat-list-name">채팅 목록</h2>
    </div>
    <div id="chat-list">
        <!-- 채팅 목록이 동적으로 추가됩니다 -->
    </div>
</div>

<div id="chat-room-container" style="display: none;">
    <!-- 채팅 방 UI -->
    <div id="chat-room-header">
        <h2 id="chat-room-name">채팅방</h2>
        <button id="close-chat-room">X</button>
    </div>
    <div id="chat-content"></div>
    <div id="chat-input-container" style="display: none;">
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