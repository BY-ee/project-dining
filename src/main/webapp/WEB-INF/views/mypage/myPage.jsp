<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>페이지 이름</title>
    <link rel="stylesheet" href="css/mypage/myPageStyles.css">
    <link rel="stylesheet" href="css/mypage/commonStyles.css">
    <script>
        function openTab(event, tabName) {
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("section");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tab");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(tabName).style.display = "block";
            event.currentTarget.className += " active";
        }

        document.addEventListener("DOMContentLoaded", function() {
            document.getElementById("defaultTab").click();
        });
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
	                <!-- 내 활동 섹션 -->
	                <jsp:include page="myCheck.jsp" />
	                <!-- 프로필 섹션 -->
	    			<jsp:include page="profile.jsp" />
	    			<!-- 계정 정보 섹션 -->
	    			<jsp:include page="accountSettings.jsp" />    
                </div>
            </div>
        </div>
    </div>
    <script>
        // 클릭 시 `redirectUrl`을 세션에 저장하기 위한 함수
        function setRedirectUrl(url) {
            fetch('/setRedirectUrl', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ redirectUrl: url })
            });
        }
    </script>
</body>
</html>