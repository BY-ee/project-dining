<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/admin/templates/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>공지사항 상세</title>
    <link rel="stylesheet" href="/css/admin/adminNotice.css">
</head>
<body>
    
    <div class="content">
        <!-- 제목과 날짜 -->
        <div class="notice-header">
            <h1 class="title">10/31(목) 넥슨 정기점검 안내</h1>
            <p class="date">2024-10-29 | 조회수 32258</p>
        </div>

        <!-- 본문 내용 -->
        <div class="notice-content">
            <p>안녕하세요, 넥슨 고객 여러분.</p>
            <p>매주 목요일은 넥슨 정기점검으로 10월 31일(목) 오전 7시부터 오전 9시까지 직접결제 서비스 이용이 원활하지 않습니다.</p>
            <p>고객 여러분들의 너그러운 양해 부탁드리며 자세한 점검 시간과 작업 영향을 아래 내용을 확인해 주시기 바랍니다.</p>
            <p class="highlight">점검시간과 작업영향:</p>
            <ul>
                <li>오전 7시 ~ 오전 9시 (2시간)</li>
                <li>직접결제 서비스 이용이 원활하지 않습니다.</li>
                <li>상점 이용이 일시적으로 제한됩니다.</li>
            </ul>
            <p>감사합니다.</p>
        </div>

        <!-- 관련 공지사항 -->
        <div class="related-notices">
            <p><strong>관련 공지</strong></p>
            <ul>
                <li><a href="#">11월 넥슨플레이 바코드캐시충전 이벤트</a></li>
                <li><a href="#">10/29(화) 도서문화상품권 결제서비스 점검 안내</a></li>
            </ul>
        </div>

        <!-- 버튼 -->
        <div class="back-button">
            <button onclick="location.href='/admin/edit/id'">수정</button>
            <button onclick="location.href='/admin/delete/id'">삭제</button>
            <button onclick="location.href='/admin/notice'">목록</button>
        </div>
    </div>
</body>
</html>