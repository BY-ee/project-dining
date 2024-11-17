<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/views/templates/head.jsp" %>
<link rel="stylesheet" href="css/mypage/myPageStyles.css">
<link rel="stylesheet" href="css/mypage/commonStyles.css">

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
	                <!-- 내 활동 섹션 -->
	                <div id="my-check" class="section">
						<h3>좋아요</h3>
						<div class="likes-slider">
							<c:forEach var="mypageLike" items= "${likePageResponse.list}">
								<div class="item">
									<a href="/store/${mypageLike.storeId}">
										<img src="/images/${mypageLike.mainImage1}">
									</a>
									${mypageLike.storeName }
								</div>
							</c:forEach>
						</div>
						<!-- 페이지네이션 -->
						<div class="pagination" id="likes-pagination">
							<c:if test="${likPageResponse.startPage > 1}">
								<button onclick="location.href='/mypage?${likePageResponse.startPage-1}'">이전</button>
							</c:if>
							<c:forEach var="i" begin="${likePageResponse.startPage}" end="${likePageResponse.endPage}">
								<button onclick="location.href='/mypage?likePage=${i}&reviewPage=${reviewPageResponse.currentPage}'" 
								class = "${i == likePageResponse.currentPage ? 'active' : ''}">${i}</button>
							</c:forEach>
							<c:if test="${likePageResponse.endPage < likePageResponse.totalPage}">
								<button onclick="location.href='/mypage?${likePageResponse.endPage+1}'">다음</button>
							</c:if>
						</div>
						<h3>리뷰</h3>
						<div class="review-slider">
							<c:forEach var="mypageReview" items= "${reviewPageResponse.list}">
								<div class="item">
									<a href="/store/${mypageReview.storeId}">
										<img src="images/${mypageReview.mainImage1}">
									</a>
									${mypageReview.storeName}
								</div>
							</c:forEach>
						</div>
						<!-- 페이지네이션 -->
						<div class="pagination" id="likes-pagination">
							<c:if test="${reviewPageResponse.startPage > 1}">
								<button onclick="location.href='/mypage?${reviewPageResponse.startPage-1}'">이전</button>
							</c:if>
							<c:forEach var="i" begin="${reviewPageResponse.startPage}" end="${reviewPageResponse.endPage}">
								<button onclick="location.href='/mypage?likePage=${likePageResponse.currentPage}&reviewPage=${i}'" 
								class = "${i == reviewPageResponse.currentPage ? 'active' : ''}">${i}</button>
							</c:forEach>
							<c:if test="${likePageResponse.endPage < likePageResponse.totalPage}">
								<button onclick="location.href='/mypage?${reviewPageResponse.endPage+1}'">다음</button>
							</c:if>
						</div>
						<!-- 사업자 회원에게만 보이는 가게 등록 바 -->
						<c:if test="${store != null}">
							<h3>내 가게 신청현황</h3>
							<div class="progress-bar">
								<div class="${store.enrollStatus=='wait' ? 'step completed': 'step'}">
									<div class="progress-icon">1</div>
									<p>가게 등록 요청</p>
								</div>
								<div class="line"></div>
								<div class="${store.enrollStatus=='read' ? 'step completed': 'step'}">
									<div class="progress-icon">2</div>
									<p>서류 심사 중</p>
								</div>
								<div class="line"></div>
								<div class="${store.enrollStatus=='enrolled' ? 'step completed':'step'}">
									<div class="progress-icon">3</div>
									<p>승인</p>
								</div>
								<div class="lineNo"></div>
								<div class="${store.enrollStatus=='withdrawal' ? 'step failed':'step'}">
									<div class="progress-icon">4</div>
									<p>거절</p>
								</div>
							</div>
							<div>
								<p>신청 가게 이름: ${store.storeName}</p>
								<br> 
								<p>가게 설명 : ${store.storeDescription}</p> 
							</div>
							<div>
								내 가게 보러가기 : <button onclick="location.href='/store/${store.id}'">바로가기</button>
							</div>
						</c:if>
					</div>    
                </div>
            </div>
        </div>
    </div>
<%@ include file="/WEB-INF/views/templates/footer.jsp" %>
</body>
</html>