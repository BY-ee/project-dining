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
<script type="text/javascript">
        function showAlert(message) {
            alert(message);
        }
    </script>
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
                    <button class="tab" id="defaultTab" onclick="location.href='/mypage'">내 활동</button>
                    <button class="tab" onclick="location.href='/profile'">프로필</button>
                    <button class="tab" onclick="location.href='/accountSettings'">계정 정보</button>
                </div>
                
                <div class="expanded-content">
		            <!-- 프로필 섹션 -->
		    		<div id="profile" class="section">
						<div class="user-info">
					        <h3>회원정보</h3>
					        <form action = "/profile" method = "post">
						        <label for="nickname">닉네임</label>
						        <input type="text" id="nickname" name="nickname" value="${member.nickname}" readonly>
						        <%-- <label for="likePlace">즐겨가는 곳</label>
						        <select id="likePlace">
						        	<option value="선택 안함" ${member.likePlace == "" ? "selected" : ""}>선택안함</option>
						            <option value="마포구" ${member.likePlace == "마포구" ? "selected" : ""}>마포구</option>
						            <option value="광진구" ${member.likePlace == "강남구" ? "selected" : ""}>강남구</option>
				                	<option value="송파구" ${member.likePlace == "송파구" ? "selected" : ""}>송파구</option>
				                	<option value="성북구" ${member.likePlace == "성북구" ? "selected" : ""}>성북구</option>
				                	<option value="종로구" ${member.likePlace == "종로구" ? "selected" : ""}>종로구</option>
						        </select>
						        <label for="age">나이</label>
						        <input type="text" name="age" value="${member.age}"> --%>
						        <label for="introduction">한 줄 소개</label>
						        <textarea id="introduction" name="introduction" rows="3" maxlength="150" placeholder="나를 소개하세요..">${member.introduction}</textarea>
						        <button type="submit">변경</button>
					        </form>
					   	</div>
					</div>    
                </div>
            </div>
        </div>
    <c:if test="${not empty message}">
           <script type="text/javascript">
               showAlert("${message}");
           </script>
    </c:if>
    </div>
</body>
</html>