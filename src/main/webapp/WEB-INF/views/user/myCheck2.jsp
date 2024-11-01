<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script>
    function showTab(tabName) {
        // 모든 탭 옵션에서 active 클래스 제거
        document.querySelectorAll('.tab-option').forEach(tab => tab.classList.remove('active'));

        // 클릭한 탭에 active 클래스 추가
        event.target.classList.add('active');

        // 모든 콘텐츠에서 active 클래스 제거
        document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));

        // 선택된 콘텐츠에 active 클래스 추가
        document.getElementById(tabName + '-tab').classList.add('active');
    }
</script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="my-check" class="section">
		<!-- 탭 버튼 -->
		<div class="content-tabs">
			<span class="tab-option active" onclick="showTab('likes')">좋아요</span>
			<span class="tab-option" onclick="showTab('reviews')">리뷰</span>
		</div>
		<!-- 좋아요 탭 콘텐츠 -->
		<div id="likes-tab" class="tab-content active">
			<h3>좋아요</h3>
			<div class="likes-slider">
				<div class="item">좋아요(가게1)</div>
				<div class="item">좋아요(가게2)</div>
				<div class="item">좋아요(가게3)</div>
				<div class="item">좋아요(가게4)</div>
				<div class="item">좋아요(가게5)</div>
				<div class="item">좋아요(가게6)</div>
				<div class="item">좋아요(가게7)</div>
				<div class="item">좋아요(가게8)</div>
				<div class="item">좋아요(가게9)</div>
				<div class="item">좋아요(가게10)</div>
			</div>
			<!-- 페이지네이션 -->
			<div class="pagination" id="likes-pagination">
				<button onclick="loadLikesPage('prev')">이전</button>
				<button onclick="loadLikesPage(1)">1</button>
				<button onclick="loadLikesPage(2)">2</button>
				<button onclick="loadLikesPage(3)">3</button>
				<button onclick="loadLikesPage(4)">4</button>
				<button onclick="loadLikesPage(5)">5</button>
				<button onclick="loadLikesPage('next')">다음</button>
			</div>
		</div>
		<!-- 리뷰 탭 콘텐츠 -->
		<div id="reviews-tab" class="tab-content">
			<h3>리뷰</h3>
			<div class="review-slider">
				<div class="item">리뷰(가게1)</div>
				<div class="item">리뷰(가게2)</div>
				<div class="item">리뷰(가게3)</div>
				<div class="item">리뷰(가게4)</div>
				<div class="item">리뷰(가게5)</div>
				<div class="item">리뷰(가게6)</div>
				<div class="item">리뷰(가게7)</div>
				<div class="item">리뷰(가게8)</div>
				<div class="item">리뷰(가게9)</div>
				<div class="item">리뷰(가게10)</div>
			</div>
			<!-- 페이지네이션 -->
			<div class="pagination" id="reviews-pagination">
				<button onclick="loadReviewsPage('prev')">이전</button>
				<button onclick="loadReviewsPage(1)">1</button>
				<button onclick="loadReviewsPage(2)">2</button>
				<button onclick="loadReviewsPage(3)">3</button>
				<button onclick="loadReviewsPage(4)">4</button>
				<button onclick="loadReviewsPage(5)">5</button>
				<button onclick="loadReviewsPage('next')">다음</button>
			</div>
		</div>
	</div>
</body>
</html>