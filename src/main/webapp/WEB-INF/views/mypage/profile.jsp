<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/templates/head.jsp" %>
<link rel="stylesheet" href="css/mypage/myPageStyles.css">
<link rel="stylesheet" href="css/mypage/commonStyles.css">
<script type="text/javascript">
        function showAlert(message) {
            alert(message);
        }
</script>
<body>
	<!-- 상단바 -->
    <%@ include file="/WEB-INF/views/templates/header.jsp" %>
    <div class="container">
        <div class="content">
            <!-- 사이드바: 프로필 사진과 이름 표시 -->
            <%@ include file="/WEB-INF/views/mypage/templates/sidebar.jsp" %>
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
						        <label for="age">나이</label>
						        <input type="text" name="age" value="${member.age}"> 
						        <label for="mbti">MBTI</label>
						        <select id="mbti" name="mbti">
						        	<option value="선택 안함" ${member.mbti == "" ? "selected" : ""}>선택안함</option>
						            <option value="ESTJ" ${member.mbti == "ESTJ" ? "selected" : ""}>ESTJ</option>
						            <option value="ESTP" ${member.mbti == "ESTP" ? "selected" : ""}>ESTP</option>
				                	<option value="ESFJ" ${member.mbti == "ESFJ" ? "selected" : ""}>ESFJ</option>
				                	<option value="ESFP" ${member.mbti == "ESFP" ? "selected" : ""}>ESFP</option>
				                	<option value="ENTJ" ${member.mbti == "ENTJ" ? "selected" : ""}>ENTJ</option>
				                	<option value="ENTP" ${member.mbti == "ENTP" ? "selected" : ""}>ENTP</option>
				                	<option value="ENFJ" ${member.mbti == "ENFJ" ? "selected" : ""}>ENFJ</option>
				                	<option value="ENFP" ${member.mbti == "ENFP" ? "selected" : ""}>ENFP</option>
				                	<option value="ISTJ" ${member.mbti == "ISTJ" ? "selected" : ""}>ISTJ</option>
						            <option value="ISTP" ${member.mbti == "ISTP" ? "selected" : ""}>ISTP</option>
				                	<option value="ISFJ" ${member.mbti == "ISFJ" ? "selected" : ""}>ISFJ</option>
				                	<option value="ISFP" ${member.mbti == "ISFP" ? "selected" : ""}>ISFP</option>
				                	<option value="INTJ" ${member.mbti == "INTJ" ? "selected" : ""}>INTJ</option>
				                	<option value="INTP" ${member.mbti == "INTP" ? "selected" : ""}>INTP</option>
				                	<option value="INFJ" ${member.mbti == "INFJ" ? "selected" : ""}>INFJ</option>
				                	<option value="INFP" ${member.mbti == "INFP" ? "selected" : ""}>INFP</option>
						        </select>
						        <label for="residence">거주지</label>
						        <input type="text" name="residence" value="${member.residence}">
						        <label for="introduction">한 줄 소개</label>
						        <textarea id="introduction" name="introduction" rows="3" maxlength="150" placeholder="나를 소개하세요..">${member.introduction}</textarea>
						        <button type="submit">변경</button>
					        </form>
					   	</div>
					</div>    
                </div>
            </div>
        </div>
    </div>
<%@ include file="/WEB-INF/views/templates/footer.jsp" %>
<c:if test="${not empty message}">
       <script type="text/javascript">
           showAlert("${message}");
       </script>
</c:if>
</body>
</html>