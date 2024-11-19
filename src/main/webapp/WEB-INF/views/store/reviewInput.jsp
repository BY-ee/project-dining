<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <!-- 한글 인코딩 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
    <title>리뷰 작성</title>
    <jsp:include page="/WEB-INF/views/templates/head.jsp" /> <!-- header -->
    <link rel="stylesheet" type="text/css" href="/css/store/reviewInput.css">
</head>
<body>

<!-- 리뷰 섹션 -->
<div class="review-input-section">
    <h3>리뷰 작성하기</h3>
    <!-- form 태그에 있는 action 속성으로 서버에 데이터를 전송 -->
    <form action="submitReview" method="post" enctype="multipart/form-data">
        <!-- 숨겨진 필드: storeId -->
        <input type="hidden" name="storeId" value="${storeId}">

        <!-- 작성자 이름 필드에 nickname 값 자동 표시 -->
        <c:choose>
            <c:when test="${sessionMember.memberId != 'anonymousUser'}">
                <!-- 로그인된 사용자의 경우 닉네임을 텍스트로 출력 -->
                <div class="nickname-container">
                    <p>${sessionMember.nickname}님</p>
                </div>
            </c:when>
        </c:choose>
        
        <!-- 리뷰 점수 선택 -->
        <select name="score" ${sessionMember.memberId == 'anonymousUser' ? 'disabled' : ''}>
            <option value="5">5점 - 아주 좋아요</option>
            <option value="4">4점 - 좋아요</option>
            <option value="3">3점 - 보통이에요</option>
            <option value="2">2점 - 별로에요</option>
            <option value="1">1점 - 싫어요</option>
        </select>
        
        <!-- 리뷰 내용 입력 -->
        <textarea class="review-input" name="content"
                  placeholder="${empty sessionMember.memberId ? '리뷰를 작성하려면 로그인을 해주세요' : '리뷰를 입력해주세요'}"
                  required ${sessionMember.memberId == 'anonymousUser' ? 'disabled' : ''}></textarea>
                     
        <!-- 이미지 파일 업로드 -->
        <input type="file" name="images" accept="image/*" multiple ${sessionMember.memberId == 'anonymousUser' ? 'disabled' : ''}>
                     
        <!-- 리뷰 작성 버튼 -->
        <c:if test="${sessionMember.memberId != 'anonymousUser'}">
            <button type="submit">리뷰 작성</button>
        </c:if>
    </form>
</div>

</body>
</html>