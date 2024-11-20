<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
function uploadFile(event){
	const file = event.target.files[0];
	
	if(file){
		const formData = new FormData();
		formData.append("file",file);
		
		// ajax 요청으로 서버에 파일 업로드
		fetch('/profile/upload',{
			method:'POST',
			body:formData
		})
		.then(response => response.json())
		.then(data => {
			if(data.success){
				document.querySelector('.profile-pic img').src = data.profilePicUrl;
				location.reload();
			} else{
				alert("업로드에 실패했습니다.다시 시도해주세요");
			}
		})
		.catch(error => console.error('Error:',error));
	}
}
</script>
<div class="sidebar">
	<div class="profile-pic"
		onclick="document.getElementById('fileInput').click()">
		<img src="${sessionMember.profileImage}" alt="프로필 사진" /> <span
			class="profile-overlay">프로필 변경</span> <input type="file"
			id="fileInput" style="display: none" onchange="uploadFile(event)" />
	</div>
	<div class="profile-name">${sessionMember.nickname}</div>
	<div class="profile-point">내 포인트 : ${point}</div>
	<div class="profile-intro">${sessionMember.introduction}</div>
</div>