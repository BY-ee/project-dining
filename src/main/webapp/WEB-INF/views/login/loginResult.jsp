<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 결과</title>
</head>
<body>

<c:if test="${result == 1 }">
	<script>
		alert("로그인 성공");
		location.href="home.do";
	</script>
</c:if>

<c:if test="${result != 1 }">
	<script>
		alert("아이디와 비밀번호를 확인해주세요.");
		history.go(-1);
	</script>
</c:if>

</body>
</html>