<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>에러 발생</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
            padding: 20px;
        }
        .error-container {
            background: #fff;
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin: 20px auto;
            max-width: 800px;
        }
        h1 {
            color: #e74c3c;
        }
        pre {
            background: #f4f4f4;
            padding: 10px;
            border-radius: 5px;
            overflow-x: auto;
            max-height: 300px;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>에러가 발생했습니다!</h1>
        <p>요청 처리 중 문제가 발생했습니다. 아래 정보를 확인해 주세요.</p>
        <h3>에러 메시지</h3>
        <p>${exception.message}</p>
        <h3>Stack Trace</h3>
        <pre>${exception.stackTrace}</pre>
    </div>
</body>
</html>