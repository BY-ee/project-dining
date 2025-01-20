$(() => {
  $('.login-form').on('submit', function (e) {
    e.preventDefault(); // 기본 폼 제출 방지

    const formData = $(this).serialize(); // 폼 데이터 직렬화

    $.ajax({
      url: '/login', // 로그인 요청 경로
      type: 'POST',
      data: formData,
      dataType: 'json', // 응답 데이터를 json으로 자동 파싱
      success: function (response) {
        console.log(response.message);
        location.href = location.origin;
      },
      error: function (xhr) {
        const response = xhr.responseJSON;
        alert(response.message || '로그인에 실패하였습니다.');
      },
    });
  });
});
