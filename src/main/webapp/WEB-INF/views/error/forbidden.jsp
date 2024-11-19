<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>forbidden</title>
    <link rel="stylesheet" href="/css/admin/admin.css" />
    <link rel="stylesheet" href="/css/admin/error.css" />
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script>
        $(() => {
            // 3초 후에 이전 페이지로 이동
            setTimeout(function() {
                history.back();
            }, 3000);

            // 홈 버튼
            $('#home-btn').on('click', function() {
                location.href = location.origin;
            });
        });
    </script>
</head>
<body>
    <div class="main-container">
        <h2 class="main-title">Error</h2>

        <div class="main-content">
            <h4>잘못된 페이지에 접근을 시도하였습니다.</h4>

            <h4>3초 후에 홈페이지로 이동합니다.</h4>

            <h4>즉시 이동하시려면 홈 버튼을 눌러주세요.</h4>

            <button class="btn" id="home-btn" type="button">홈</button>
        </div>
    </div>
</body>
</html>