<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div id="my-check-content">
	<!-- 좋아요 섹션 -->
	<h3>좋아요</h3>
	<div class="likes-slider">
		<div class="item">좋아요(가게1)</div>
		<div class="item">좋아요(가게2)</div>
		<div class="item">좋아요(가게3)</div>
		<div class="item">좋아요(가게4)</div>
	</div>
	
	<!-- 좋아요 페이지네이션 -->
	<div class="pagination" id="likes-pagination">
		<button onclick="loadLikesPage('prev')">이전</button>
		<button onclick="loadLikesPage(1)">1</button>
		<button onclick="loadLikesPage(2)">2</button>
		<button onclick="loadLikesPage(3)">3</button>
		<button onclick="loadLikesPage(4)">4</button>
		<button onclick="loadLikesPage('next')">다음</button>
	</div>

	<!-- 리뷰 섹션 -->
	<h3>리뷰</h3>
	<div class="review-slider">
		<div class="item">리뷰(가게1)</div>
		<div class="item">리뷰(가게2)</div>
		<div class="item">리뷰(가게3)</div>
		<div class="item">리뷰(가게4)</div>
	</div>
	
	<!-- 리뷰 페이지네이션 -->
	<div class="pagination" id="reviews-pagination">
		<button onclick="loadReviewsPage('prev')">이전</button>
		<button onclick="loadReviewsPage(1)">1</button>
		<button onclick="loadReviewsPage(2)">2</button>
		<button onclick="loadReviewsPage(3)">3</button>
		<button onclick="loadReviewsPage(4)">4</button>
		<button onclick="loadReviewsPage('next')">다음</button>
	</div>

	<!-- 내 가게 신청현황 (사업자 회원에게만 표시) -->
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

<script>
    function loadLikesPage(page) {
        // 좋아요 페이지네이션 기능을 위한 함수 - AJAX 로직을 추가하여 특정 페이지를 불러올 수 있습니다.
        console.log("좋아요 페이지:", page);
    }

    function loadReviewsPage(page) {
        // 리뷰 페이지네이션 기능을 위한 함수 - AJAX 로직을 추가하여 특정 페이지를 불러올 수 있습니다.
        console.log("리뷰 페이지:", page);
    }
</script>