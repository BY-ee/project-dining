<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
function uploadFile(event) {
    const file = event.target.files[0];
    
    if (file) {
        const formData = new FormData();
        formData.append("file", file);
        
        // jQuery를 이용한 파일 업로드 요청
        $.ajax({
            url: '/profile/upload',
            type: 'POST',
            data: formData,
            processData: false, // 파일 데이터를 query string으로 변환하지 않음
            contentType: false, // Content-Type 헤더를 multipart/form-data로 설정
            success: function(data) {
                if (data.success) {
                    // 프로필 이미지를 업데이트
                    $('.profile-pic img').attr('src', data.profilePicUrl);
                    location.reload(); // 페이지 새로고침
                } else {
                    alert("업로드에 실패했습니다. 다시 시도해주세요.");
                }
            },
            error: function(xhr, status, error) {
                console.error('Error:', error); // 에러 로그 출력
            }
        });
    }
}
</script>
<div class="sidebar">
	<div class="profile-pic"
		onclick="document.getElementById('fileInput').click()">
		<c:if test="${not empty sessionMember.profileImage}">
			<img src="${sessionMember.profileImage}" alt="프로필 사진" /> <span
				class="profile-overlay">프로필 변경</span> <input type="file"
				id="fileInput" style="display: none" onchange="uploadFile(event)" />
		</c:if>
		<c:if test="${empty sessionMember.profileImage}">
			<img src="/images/profile.png" alt="프로필 사진" /> <span
				class="profile-overlay">프로필 변경</span> <input type="file"
				id="fileInput" style="display: none" onchange="uploadFile(event)" />
		</c:if>
	</div>	
	<div class="profile-name">${sessionMember.category}회원</div>
	<div class="profile-name">${sessionMember.nickname}</div>
	<div class="profile-point">내 포인트 : ${point}</div>
	<div class="profile-intro">${sessionMember.introduction}</div>
</div>