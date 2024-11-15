<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <!-- 한글 인코딩 -->

<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/views/templates/head.jsp" %> <!-- head -->

<head>
    <title>이메일 문의</title>
    <link rel="stylesheet" href="css/home/emailInquiry.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/templates/header.jsp" /> <!-- header -->
    
    <main class="container"> <!-- main content start -->

        <h2>이메일 문의</h2>
        <p>문의사항을 남겨주시면 빠른 시일 내에 답변 드리겠습니다.</p>
        
        <form class="inquiry-form">
            <label for="name">이름</label>
            <input type="text" id="name" name="name" required>
            
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" required>
            
            <label for="phone">전화번호</label>
            <input type="tel" id="phone" name="phone">
            
            <label for="subject">제목</label>
            <input type="text" id="subject" name="subject" required>
            
            <label for="message">문의 내용</label>
            <textarea id="message" name="message" maxlength="500"></textarea>
            <div class="char-limit">0자 / 최대 500자</div>
            
            <label for="file">첨부 파일</label>
            <input type="file" id="file" name="file">
            
            <div class="consent-section">
                <label>
                    <input type="checkbox" required> 정보 수집 및 이용 동의
                </label>
                <p class="consent-text">
                    개인정보는 문의에 대한 답변을 위해서만 사용되며, 문의 접수 후 1개월 이내에 파기됩니다.
                </p>
            </div>
            
            <button type="submit" class="submit-btn">제출하기</button>
        </form>
    </main>

	<jsp:include page="/WEB-INF/views/templates/footer.jsp" /> <!-- footer -->
</body>
</html>