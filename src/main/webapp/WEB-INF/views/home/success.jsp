<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>등록 성공</title>
    <style>
        /* 전체 페이지 스타일 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        header {
            text-align: center;
            margin-bottom: 20px;
        }

        header h1 {
            color: #4CAF50;
            font-size: 36px;
            margin: 0;
        }

        main {
            text-align: center;
        }

        main p {
            font-size: 18px;
            margin: 10px 0;
        }

        .btn {
            display: inline-block;
            margin: 10px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #45a049;
        }

        footer {
            margin-top: 20px;
            font-size: 14px;
            color: #777;
        }
    </style>
</head>
<body>
    <header>
        <h1>가게 등록 성공</h1>
    </header>

    <main>
        <p>가게 등록이 성공적으로 완료되었습니다!</p>
        <p>검토 후 등록이 승인되면 알려드리겠습니다.</p>

        <a href="/" class="btn">홈으로 돌아가기</a>
        <a href="/storeRegistration" class="btn">다른 가게 등록하기</a>
    </main>

    <footer>
        <p>&copy; 2024 Nyami Project. All rights reserved.</p>
    </footer>
</body>
</html>
