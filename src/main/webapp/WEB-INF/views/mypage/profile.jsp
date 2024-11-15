<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 콘텐츠 시작 -->
<div class="user-info">
    <h3>회원정보</h3>
    <label for="name">이름</label>
    <input type="text" id="name" value="최준혁">

    <label for="nickname">닉네임</label>
    <input type="text" id="nickname" value="준최">

    <label for="location">사는 곳</label>
    <select id="location">
        <option value="마포구" selected>마포구</option>
    </select>
    <select id="sub-location">
        <option value="홍대" selected>홍대</option>
    </select>
    
    <label for="introduction">한 줄 소개</label>
    <textarea id="introduction" rows="3" maxlength="150">나를 소개해주세요</textarea>
</div>