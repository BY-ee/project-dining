<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/mypage/myPageStyles.css">
<link rel="stylesheet" href="css/mypage/commonStyles.css">
</head>
<body>
	<!-- 상단바 -->
    <header class="navbar">
        <div class="navbar-left">
            <a class="navbar-logo">냐미</a>
        </div>
        <div class="navbar-right">
            <a href="#" class="icon">로그아웃</a>
            <a href="/" class="icon">홈</a>
        </div>
    </header>
    <div class="container">
        <div class="content">
            <!-- 사이드바: 프로필 사진과 이름 표시 -->
            <div class="sidebar">
                <div class="profile-pic" onclick="document.getElementById('fileInput').click()">
                	<span class="profile-overlay">프로필 변경</span>
                </div>
                <div class="profile-name">야미</div>
                <input type="file" id="fileInput" style="display:none">
                <div class="prifile-point">내 포인트 : 500p</div>
                <div class="profile-intro">안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.</div>
            </div>

            <!-- 메인 콘텐츠 부분 -->
            <div class="main-content">
                <!-- 탭 메뉴 -->
                <div class="tabs">
                    <button class="tab" id="defaultTab" onclick="openTab(event, 'my-check')">내 활동</button>
                    <button class="tab" onclick="openTab(event, 'profile')">프로필</button>
                    <button class="tab" onclick="openTab(event, 'account-settings')">계정 정보</button>
                </div>
                
                <div class="expanded-content">
		            <!-- 프로필 섹션 -->
		    		<div id="profile" class="section">
						<div class="user-info">
					        <h3>회원정보</h3>
					        <label for="name">이름</label>
					        <input type="text" id="name" value="최준혁">
					
					        <label for="nickname">닉네임</label>
					        <input type="text" id="nickname" value="준최">
					
					        <label for="job">사는 곳</label>
					        <select id="job">
					            <option value="마포구" selected>마포구</option>
					        </select>
					        <select id="sub-job">
					            <option value="홍대" selected>홍대</option>
					        </select>
					        
					        <label for="introduction">한 줄 소개</label>
					        <textarea id="introduction" rows="3" maxlength="150">나를 소개해주세요</textarea>
					   	</div>
					</div>    
                </div>
            </div>
        </div>
    </div>
</body>
</html>