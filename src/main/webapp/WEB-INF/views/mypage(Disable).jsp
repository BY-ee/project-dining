<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <link rel="stylesheet" href="/css/mypage.css">
</head>
<body>
    <div class="header">
        <div class="page-name">
			<a href="/">페이지 이름</a>
		</div>
        <form action="/logout" method="post" class="logout-form">
            <button type="submit">로그아웃</button>
        </form>
    </div>
    
    <div class="container">
        <!-- 왼쪽 프로필 영역 -->
        <div class="profile-sidebar">
            <div class="profile-picture"></div>
            <% 
                String username = (String) session.getAttribute("username"); 
                if (username != null) { 
            %>
                <div class="profile-username"><%= username %></div>
            <% 
                } else { 
            %>
                <div class="profile-username">로그인이 필요합니다</div>
            <% 
                } 
            %>
        </div>

        <!-- 오른쪽 컨텐츠 영역 -->
        <div class="main-content">
            <!-- 탭 메뉴 -->
            <div class="tab-menu">
                <button class="tab-button active" onclick="openTab(event, 'account-settings')">계정 설정</button>
                <button class="tab-button" onclick="openTab(event, 'points')">포인트 확인</button>
                <button class="tab-button" onclick="openTab(event, 'notifications')">공지 사항</button>
            </div>

            <!-- 탭 내용 -->
            <div id="account-settings" class="tab-content active">
                <!-- 계정 설정 내용 -->
            </div>

            <div id="points" class="tab-content">
                <h3>포인트 확인</h3>
                <!-- 포인트 확인 내용 -->
            </div>

            <div id="notifications" class="tab-content">
                <h3>공지 사항</h3>
                <!-- 공지 사항 내용 -->
            </div>

            <!-- 좋아요와 리뷰 섹션 -->
            <div class="interaction-section">
			   <div class="likes-section">
                    <h4 class="section-title">좋아요</h4>
                    <div class="like-items-container">
                        <div class="like-store-item">
                            <div class="like-store-image"></div>
                            <div class="like-store-name">좋아요(가게1)</div>
                        </div>
                        <div class="like-store-item">
                            <div class="like-store-image"></div>
                            <div class="like-store-name">좋아요(가게2)</div>
                        </div>
                        <div class="like-store-item">
                            <div class="like-store-image"></div>
                            <div class="like-store-name">좋아요(가게3)</div>
                        </div>
                        <div class="like-store-item">
                            <div class="like-store-image"></div>
                            <div class="like-store-name">좋아요(가게4)</div>
                        </div>
                        <div class="like-store-item">
                            <div class="like-store-image"></div>
                            <div class="like-store-name">좋아요(가게5)</div>
                        </div>
                        <div class="like-store-item">
                            <div class="like-store-image"></div>
                            <div class="like-store-name">좋아요(가게6)</div>
                        </div>
                        <div class="like-store-item">
                            <div class="like-store-image"></div>
                            <div class="like-store-name">좋아요(가게7)</div>
                        </div>
                        <div class="like-store-item">
                            <div class="like-store-image"></div>
                            <div class="like-store-name">좋아요(가게8)</div>
                        </div>
                        <div class="like-store-item">
                            <div class="like-store-image"></div>
                            <div class="like-store-name">좋아요(가게9)</div>
                        </div>
                        <div class="like-store-item">
                            <div class="like-store-image"></div>
                            <div class="like-store-name">좋아요(가게10)</div>
                        </div>
                        <!-- 추가 좋아요 항목 -->
                    </div>
                </div>
			    
			    <div class="reviews-section">
			        <h4 class="section-title">리뷰</h4>
			        <div class="review-items-container">
			            <div class="review-store-item">
			                <div class="review-store-image"></div>
			                <div class="review-store-name">리뷰(가게1)</div>
			            </div>
			            <div class="review-store-item">
			                <div class="review-store-image"></div>
			                <div class="review-store-name">리뷰(가게2)</div>
			            </div>
			            <div class="review-store-item">
			                <div class="review-store-image"></div>
			                <div class="review-store-name">리뷰(가게3)</div>
			            </div>
			            <div class="review-store-item">
			                <div class="review-store-image"></div>
			                <div class="review-store-name">리뷰(가게4)</div>
			            </div>
			            <div class="review-store-item">
			                <div class="review-store-image"></div>
			                <div class="review-store-name">리뷰(가게5)</div>
			            </div>
			            <div class="review-store-item">
			                <div class="review-store-image"></div>
			                <div class="review-store-name">리뷰(가게6)</div>
			            </div>
			            <div class="review-store-item">
			                <div class="review-store-image"></div>
			                <div class="review-store-name">리뷰(가게7)</div>
			            </div>
			            <div class="review-store-item">
			                <div class="review-store-image"></div>
			                <div class="review-store-name">리뷰(가게8)</div>
			            </div>
			            <div class="review-store-item">
			                <div class="review-store-image"></div>
			                <div class="review-store-name">리뷰(가게9)</div>
			            </div>
			            <!-- 추가 리뷰 항목 -->
			        </div>
			    </div>
			</div>
        </div>
    </div>

    <script src="/js/myPage.js"></script>
</body>
</html> --%>