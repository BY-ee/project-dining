<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <link rel="stylesheet" href="css/mypage/myPageStyles.css">
    <link rel="stylesheet" href="css/mypage/commonStyles.css">
    <script src="/js/home/userdropdown.js" defer></script>
    <script>
        function openTab(event, tabName) {
            // 모든 섹션을 숨기기
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("section");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            
            // 모든 탭의 활성 상태를 제거
            tablinks = document.getElementsByClassName("tab");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }

            // 클릭한 탭과 일치하는 섹션을 표시하고 해당 탭을 활성화
            document.getElementById(tabName).style.display = "block";
            event.currentTarget.className += " active";
        }

        document.addEventListener("DOMContentLoaded", function() {
            document.getElementById("defaultTab").click(); // 기본으로 표시할 탭
        });
    </script>
</head>
<body>
    <!-- 상단바 -->
    <jsp:include page="/WEB-INF/views/templates/header.jsp" /> <!-- header -->

    <div class="container">
        <div class="content">
            <!-- 사이드바: 프로필 사진과 이름 표시 -->
            <div class="sidebar">
                <div class="profile-pic" onclick="document.getElementById('fileInput').click()">
                	<span class="profile-overlay">프로필 변경</span>
                </div>
                <div class="profile-name">${sessionScope.loginUser.nickname}</div>
                <input type="file" id="fileInput" style="display:none">
                <div class="profile-point">내 포인트 : ${totalPoints}p</div>
                <div class="profile-intro">안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.안녕하세요.</div>
            </div>

            <!-- 메인 콘텐츠 부분 -->
            <div class="main-content">
                <!-- 탭 메뉴 -->
                <div class="tabs">
                    <button class="tab" id="defaultTab" onclick="openTab(event, 'my-check')">내 활동</button>
                    <button class="tab" onclick="openTab(event, 'profile')">프로필</button>
                    <button class="tab" onclick="openTab(event, 'account-settings')">계정 정보</button>
                    <button class="tab" onclick="openTab(event, 'userPoint')">포인트</button>
                </div>
                
                <div class="expanded-content">
	                <!-- 내 활동 섹션 -->
	                <div id="my-check" class="section" style="display:none;]">
	                    <jsp:include page="myCheck.jsp" />
	                </div>
	                <!-- 프로필 섹션 -->
	                <div id="profile" class="section" style="display:none;">
	                    <jsp:include page="profile.jsp" />
	                </div>
	                <!-- 계정 정보 섹션 -->
	                <div id="account-settings" class="section" style="display:none;">
	                    <jsp:include page="accountSettings.jsp" />
	                </div>
	                <!-- 유저 포인트 섹션 -->
	                <div id="userPoint" class="section" style="display:none;">
	                    <jsp:include page="userPoint.jsp"/>
	                </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>