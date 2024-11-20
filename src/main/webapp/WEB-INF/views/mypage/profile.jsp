<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/WEB-INF/views/templates/head.jsp" />
	<link rel="stylesheet" href="css/mypage/myPageStyles.css">
	<link rel="stylesheet" href="css/mypage/commonStyles.css">
</head>
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
                    <button class="tab" id="defaultTab" onclick="location.href='/mypage'">활동내역</button>
                    <button class="tab" onclick="location.href='/profile'">프로필</button>
                    <button class="tab" onclick="location.href='/account'">계정 정보</button>
                    <button class="tab" onclick="location.href='/userPoint'">포인트</button>
                </div>
                
                <div class="expanded-content">
		            <!-- 프로필 섹션 -->
		    		<div id="profile" class="section">
						<div class="user-info">
					        <h3>회원정보</h3>
					        <form action = "/profile" method = "post">
						        <label for="nickname">닉네임</label>
						        <input type="text" id="nickname" name="nickname" value="${sessionMember.nickname}">
						        <label for="age">나이</label>
						        <input type="number" id="age" name="age" min="1" max="100" value="${sessionMember.age}"> 
						        <label for="mbti">MBTI</label>
						        <select id="mbti" name="mbti">
						        	<option value="선택 안함" ${sessionMember.mbti == "" ? "selected" : ""}>선택안함</option>
						            <option value="ESTJ" ${sessionMember.mbti == "ESTJ" ? "selected" : ""}>ESTJ</option>
						            <option value="ESTP" ${sessionMember.mbti == "ESTP" ? "selected" : ""}>ESTP</option>
				                	<option value="ESFJ" ${sessionMember.mbti == "ESFJ" ? "selected" : ""}>ESFJ</option>
				                	<option value="ESFP" ${sessionMember.mbti == "ESFP" ? "selected" : ""}>ESFP</option>
				                	<option value="ENTJ" ${sessionMember.mbti == "ENTJ" ? "selected" : ""}>ENTJ</option>
				                	<option value="ENTP" ${sessionMember.mbti == "ENTP" ? "selected" : ""}>ENTP</option>
				                	<option value="ENFJ" ${sessionMember.mbti == "ENFJ" ? "selected" : ""}>ENFJ</option>
				                	<option value="ENFP" ${sessionMember.mbti == "ENFP" ? "selected" : ""}>ENFP</option>
				                	<option value="ISTJ" ${sessionMember.mbti == "ISTJ" ? "selected" : ""}>ISTJ</option>
						            <option value="ISTP" ${sessionMember.mbti == "ISTP" ? "selected" : ""}>ISTP</option>
				                	<option value="ISFJ" ${sessionMember.mbti == "ISFJ" ? "selected" : ""}>ISFJ</option>
				                	<option value="ISFP" ${sessionMember.mbti == "ISFP" ? "selected" : ""}>ISFP</option>
				                	<option value="INTJ" ${sessionMember.mbti == "INTJ" ? "selected" : ""}>INTJ</option>
				                	<option value="INTP" ${sessionMember.mbti == "INTP" ? "selected" : ""}>INTP</option>
				                	<option value="INFJ" ${sessionMember.mbti == "INFJ" ? "selected" : ""}>INFJ</option>
				                	<option value="INFP" ${sessionMember.mbti == "INFP" ? "selected" : ""}>INFP</option>
						        </select>
						        <label for="residence">거주지</label>
						        <input type="text" name="residence" value="${sessionMember.residence}">
						        <label for="introduction">한 줄 소개</label>
						        <textarea id="introduction" name="introduction" rows="3" maxlength="150" placeholder="나를 소개하세요..">${sessionMember.introduction}</textarea>
						        <button type="submit">변경</button>
					        </form>
					   	</div>
					</div>    
                </div>
            </div>
        </div>
    </div>
		<c:if test="${not empty message}">
		    <script type="text/javascript">
				    alert("${message}");
			</script>
		</c:if>
<%@ include file="/WEB-INF/views/templates/footer.jsp" %>
</body>
</html>
