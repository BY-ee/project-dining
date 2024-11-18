<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<jsp:include page="/WEB-INF/views/templates/head.jsp" /> <!-- header -->
</head>
<body>
회원가입
<form action="/join.do" method="post">
	<input type="email" placeholder="Email" name="email" required>
	<input type="password" placeholder="Password" name="password" required>
	<input type="text" placeholder="Username" name="username" required>
	<button type="submit">회원가입</button>
	<button onclick="location.href='/login'">로그인</button>
</form>
<button onclick="location.href='/'">홈</button>
</body>
</html>