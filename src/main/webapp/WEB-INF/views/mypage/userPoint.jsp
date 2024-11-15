<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 콘텐츠 시작 -->
<h2>포인트 내역</h2>
<div id="point-list-container">
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

<%
    // 세션에서 memberId 가져오기
    Long memberId = (Long) session.getAttribute("user_ID");
%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQuery 라이브러리 추가 -->
<script type="text/javascript">
    // 세션에서 가져온 memberId를 JavaScript 변수로 선언
    var memberId = <%= memberId != null ? memberId : "null" %>;

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