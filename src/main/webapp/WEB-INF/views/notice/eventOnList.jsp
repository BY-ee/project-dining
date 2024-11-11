<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>이벤트 페이지</title>
<link rel="stylesheet" href="css/notice/commonStyles.css">
<link rel="stylesheet" href="css/notice/noticeCommonStyles.css">
<link rel="stylesheet" href="css/notice/eventListStyles.css">
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
	<nav class="navbar-menu">
		<a href="/noticeList" class="menu-item">공지사항</a> 
		<a href="/eventOnList" class="menu-item active">이벤트</a>
	</nav>
	<!-- 이벤트 콘텐츠 -->
	<div class="event-section">
		<div class="tab-header">
			<a class="active" href="/eventOnList">진행중 이벤트</a>
			<a href="/eventOffList">종료된 이벤트</a>
		</div>
		<div class="category-tabs">
			<button class="active">전체</button>
			<button>할인</button>
			<button>포인트</button>
			<button>기타</button>
		</div>

		<div class="event-items">
			<c:forEach var = "event" items = "${eventPageResponse.list}">
				<div class="event-item">
					<a href="/event" class="event-item">
						<img src="images/image2.png">
	                	<h3>${event.title}</h3>
	                	<span>${event.startDate} ~ ${event.endDate}</span>
	                	<span class="category">${event.category}</span>
	                </a>	
	            </div>
			</c:forEach>	
			<a href="/event" class="event-item">
				<img src="images/image1.jpeg" alt="이벤트 이미지">
				<h3>30주년 기념, 소주 3천원!</h3>
				<p>가게 정보를 확인하세요</p>
				<span>2024-09-02 ~ 2024-12-31</span> <span class="category">할인</span>
			</a>
			<!-- 반복해서 아이템 6개 생성 -->
			<a href="/event" class="event-item">
				<img src="images/image2.png" alt="이벤트 이미지">
				<h3>1주년 이벤트</h3>
				<p>포인트 받아가세요~!</p>
				<span>2024-10-31 ~ 2024-12-09</span> <span class="category">포인트</span>
			</a>
			<!-- 추가 아이템들 -->
			<a href="/event" class="event-item">
				<img src="images/image2.png" alt="이벤트 이미지">
				<h3>1주년 이벤트</h3>
				<p>포인트 받아가세요~!</p>
				<span>2024-10-31 ~ 2024-12-09</span> <span class="category">포인트</span>
			</a>
			<a href="/event" class="event-item">
				<img src="images/image2.png" alt="이벤트 이미지">
				<h3>1주년 이벤트</h3>
				<p>포인트 받아가세요~!</p>
				<span>2024-10-31 ~ 2024-12-09</span> <span class="category">포인트</span>
			</a>
			<a href="/event" class="event-item">
				<img src="images/image2.png" alt="이벤트 이미지">
				<h3>1주년 이벤트</h3>
				<p>포인트 받아가세요~!</p>
				<span>2024-10-31 ~ 2024-12-09</span> <span class="category">포인트</span>
			</a>
			<a href="/event" class="event-item">
				<img src="images/image2.png" alt="이벤트 이미지">
				<h3>1주년 이벤트</h3>
				<p>포인트 받아가세요~!</p>
				<span>2024-10-31 ~ 2024-12-09</span> <span class="category">포인트</span>
			</a>
			<a href="/event" class="event-item">
				<img src="images/image2.png" alt="이벤트 이미지">
				<h3>1주년 이벤트</h3>
				<p>포인트 받아가세요~!</p>
				<span>2024-10-31 ~ 2024-12-09</span> <span class="category">포인트</span>
			</a>
			<a href="/event" class="event-item">
				<img src="images/image2.png" alt="이벤트 이미지">
				<h3>1주년 이벤트</h3>
				<p>포인트 받아가세요~!</p>
				<span>2024-10-31 ~ 2024-12-09</span> <span class="category">포인트</span>
			</a>
			<a href="/event" class="event-item">
				<img src="images/image2.png" alt="이벤트 이미지">
				<h3>1주년 이벤트</h3>
				<p>포인트 받아가세요~!</p>
				<span>2024-10-31 ~ 2024-12-09</span> <span class="category">포인트</span>
			</a>
		</div>
	</div>
</body>
</html>