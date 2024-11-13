<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/mypage/myPageStyles.css">
<link rel="stylesheet" href="css/mypage/commonStyles.css">
</head>
<body>
	<!-- 상단바 -->
    <header class="navbar">
        <div class="navbar-left">
            <a class="navbar-logo">냐미</a>
        </div>
        <div class="navbar-right">
            <a href="#" class="icon">로그아웃</a>
            <a href="/" class="icon">홈</a>
        </div>
    </header>
    <div class="container">
        <div class="content">
            <!-- 사이드바: 프로필 사진과 이름 표시 -->
            <div class="sidebar">
                <div class="profile-pic" onclick="document.getElementById('fileInput').click()">
                	<span class="profile-overlay">프로필 변경</span>
                </div>
                <div class="profile-name">${member.nickname}</div>
                <input type="file" id="fileInput" style="display:none">
                <div class="prifile-point">내 포인트 : 500p</div>
                <div class="profile-intro">${member.introduction}</div>
            </div>

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
							<c:forEach var="mypageLike" items= "${mypageLike}">
								<div class="item">
									<a href="/store/${myPageLike.storeId}">
										<img src="images/${myPageLike.storeImage}">
									</a>
								</div>
							</c:forEach>
						</div>
						<!-- 페이지네이션 -->
						<div class="pagination" id="likes-pagination">
							<button onclick="loadLikesPage('prev')">이전</button>
							<button onclick="loadLikesPage(1)">1</button>
							<button onclick="loadLikesPage(2)">2</button>
							<button onclick="loadLikesPage(3)">3</button>
							<button onclick="loadLikesPage(4)">4</button>
							<button onclick="loadLikesPage('next')">다음</button>
						</div>
						<h3>리뷰</h3>
						<div class="review-slider">
							<div class="item">리뷰(가게1)</div>
							<div class="item">리뷰(가게2)</div>
							<div class="item">리뷰(가게3)</div>
							<div class="item">리뷰(가게4)</div>
						</div>
						<!-- 페이지네이션 -->
						<div class="pagination" id="reviews-pagination">
							<button onclick="loadReviewsPage('prev')">이전</button>
							<button onclick="loadReviewsPage(1)">1</button>
							<button onclick="loadReviewsPage(2)">2</button>
							<button onclick="loadReviewsPage(3)">3</button>
							<button onclick="loadReviewsPage(4)">4</button>
							<button onclick="loadReviewsPage('next')">다음</button>
						</div>
						<!-- 사업자 회원에게만 보이는 가게 등록 바 -->
						<h3>내 가게 신청현황</h3>
						<div class="progress-bar">
							<div class="step completed">
								<div class="progress-icon">1</div>
								<p>가게 등록 요청</p>
							</div>
							<div class="line"></div>
							<div class="step">
								<div class="progress-icon">2</div>
								<p>서류 심사 중</p>
							</div>
							<div class="line"></div>
							<div class="step">
								<div class="progress-icon">3</div>
								<p>등록 승인</p>
							</div>
							<div class="line"></div>
							<div class="step">
								<div class="progress-icon">4</div>
								<p>등록 완료</p>
							</div>
						</div>
					</div>    
                </div>
            </div>
        </div>
    </div>
</body>
</html>