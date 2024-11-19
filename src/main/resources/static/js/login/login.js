$(() => {
	$('.login-form').on('submit', function (e) {
		e.preventDefault(); // 기본 폼 제출 방지
	
		const formData = $(this).serialize(); // 폼 데이터 직렬화
	
		$.ajax({
			url: '/login', // 로그인 요청 경로
			type: 'POST',
			data: formData,
			success: function () {
				// 로그인 성공 시 처리
				window.location.href = '/';
			},
			error: function (xhr) {
				// 로그인 실패 시 JSON 메시지 처리
				const response = JSON.parse(xhr.responseText);
				alert(response.message); // "로그인 실패. 아이디와 비밀번호를 확인하세요."
				$('#memberId').val('');
				$('#passwd').val('');
			}
		});
	});
})