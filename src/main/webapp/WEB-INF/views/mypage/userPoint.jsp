<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/views/templates/head.jsp" />
<link rel="stylesheet" href="css/mypage/myPageStyles.css">
<link rel="stylesheet" href="css/mypage/commonStyles.css">
<body>
<%@ include file="/WEB-INF/views/templates/header.jsp" %>
	<div class="container">
        <div class="content">
            <!-- 사이드바: 프로필 사진과 이름 표시 -->
            <%@ include file="/WEB-INF/views/mypage/templates/sidebar.jsp" %>
            <!-- 메인 콘텐츠 부분 -->
            <div class="main-content">
                <!-- 탭 메뉴 -->
                <div class="tabs">
                    <button class="tab" id="defaultTab" onclick="location.href='/mypage'">활동내역</button>
                    <button class="tab" onclick="location.href='/profile'">프로필</button>
                    <button class="tab" onclick="location.href='/account'">계정 정보</button>
                    <button class="tab" onclick="location.href='/userPoint'">포인트</button>
                </div>
                <div class="expanded-content">
				<!-- 콘텐츠 시작 -->
					<div id="point-list-container">
					<h2>포인트 내역</h2>
					    <!-- 포인트 정보가 여기 표시됩니다 -->
					    <table class="point-table">
					        <thead>
					            <tr>
					                <th>카테고리</th>
					                <th>포인트</th>
					                <th>유형</th>
					                <th>생성일</th>
					            </tr>
					        </thead>
					        <tbody id="point-table-body">
					            <!-- 데이터 로드 후 여기에 행이 추가됩니다 -->
					        </tbody>
					    </table>
					</div>
					</div>
				</div>
			</div>
		</div>
			<%@ include file="/WEB-INF/views/templates/footer.jsp" %>
			<script type="text/javascript">
			
			    // 세션에서 가져온 memberId를 JavaScript 변수로 선언
			    var memberId = ${sessionMember.id != null ? sessionMember.id : "null"};
			
			     $(document).ready(function() {
			        // memberId가 null이 아니면 포인트 정보를 자동으로 불러옵니다.
			        if (memberId !== null) {
			            findPointByMemberId(memberId);
			        } else {
			            alert("로그인이 필요합니다."); // 로그인하지 않은 경우 경고 메시지 표시
			        }
			    });
			    
			    function formatDate(dateString) {
			        var options = { year: 'numeric', month: 'short', day: 'numeric' };
			        return new Date(dateString).toLocaleDateString('ko-KR', options);
			    }
			
			    function findPointByMemberId(memberId) {
			        $.ajax({
			            url: "/findPointByMemberId",
			            type: "GET",
			            data: { member_id: memberId },
			            success: function(points) {
			                let html = '';
			                points.forEach(function(point) {
			                    html += '<tr>' +
			                                '<td>' + point.category + '</td>' +
			                                '<td>' + point.point + '</td>' +
			                                '<td>' + point.type + '</td>' +
			                                '<td>' + formatDate(point.createdAt) + '</td>'
			                            '</tr>';
			                });
			                $("#point-table-body").html(html); // 결과를 테이블에 표시
			            },
			            error: function() {
			                alert("포인트 데이터를 불러오는 중 문제가 발생했습니다.");
			            }
			        });
			    }
</script>
</body>
</html>