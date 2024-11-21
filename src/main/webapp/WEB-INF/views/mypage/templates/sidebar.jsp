<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/mypage/myPageStyles.css">
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

function memberCategoryChange() {

    const category = "${sessionMember.category}"; // 서버에서 전달받은 값

    if (category === "일반") { 
        
    	 // 팝업 크기 설정
        const popupWidth = 600; // 팝업 창 가로 크기
        const popupHeight = 400; // 팝업 창 세로 크기

        // 화면 크기 가져오기
        const screenWidth = window.screen.availWidth; // 사용 가능한 화면 너비
        const screenHeight = window.screen.availHeight; // 사용 가능한 화면 높이
        
        // 팝업 창을 화면 중앙에 배치
        const left = Math.max((screenWidth - popupWidth) / 2, 0);
        const top = Math.max((screenHeight - popupHeight) / 2, 0);
        
        // 팝업 창 열기
        window.open(
            "/businessVerificationPage", // 팝업 창 경로
            "사업자 변경", // 팝업 창 이름
            `width=600,height=400,top=${top},left=${left},resizable=no`
        );
        
    } else {
        // 사업자 회원일 경우 아무 동작도 하지 않음
        console.log("사업자 회원입니다. 팝업 창을 띄우지 않습니다.");
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
	<div class="memberChange" id="memberChange"  onclick="memberCategoryChange()">${sessionMember.category}회원</div>
	<div class="profile-name">${sessionMember.nickname}</div>
	<div class="profile-point">내 포인트 : ${point}</div>
	<div class="profile-intro">${sessionMember.introduction}</div>
</div>