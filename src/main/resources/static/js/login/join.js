$(document).ready(function() {
  
	
	// Domain 선택 js
	$("#email").change(function() {
    if ($("#email").val() === "") {
      $("#domain").removeAttr("readonly");
      $("#domain").val("").focus();
    } else {
      $("#domain").val($("#email").val());
      $("#domain").attr("readonly", "readonly");
    }
  });
  
  $('#verifyButton').on('click', function() {
    // 이메일 주소 합치기
    const mailid = $('#mailid').val().trim();
    let domain = $('#domain').val().trim();
    const emailSelect = $('#email').val();

    if (emailSelect) {
      domain = emailSelect; // select에서 선택한 도메인으로 설정
    }

    const fullEmail = `${mailid}@${domain}`;

    // 1. 인증 입력 필드와 확인 버튼 추가
    if ($('#verificationCode').length === 0) {
      $('#verification-input-container').html(
        `<input type="text" id="verificationCode" class="email-input" placeholder="인증 코드를 입력하세요">
         <button type="button" id="confirmButton">확인</button>`
      );
    }

    // 2. AJAX 요청으로 이메일 서버에 전송
    $.ajax({
      url: 'sendVerificationEmail.do',  // 서버의 이메일 전송 엔드포인트
      type: 'POST',
      data: { email: fullEmail },
      success: function(response) {
        alert("인증 이메일이 전송되었습니다.");
      },
      error: function(error) {
        alert("이메일 전송에 실패했습니다. 이메일을 다시 확인해주세요.");
      }
    });
  });  
  

  // 확인 버튼 클릭 시 인증 코드 확인 요청
  $(document).on('click', '#confirmButton', function() {
			
    const verificationCode = $('#verificationCode').val().trim();
    const mailid = $('#mailid').val().trim();
    const domain = $('#domain').val().trim();
    const fullEmail = `${mailid}@${domain}`;

	 $.ajax({
	    url: 'verifyCode.do',  // 인증 코드 확인을 위한 서버 엔드포인트
	    type: 'POST',
	    data: { email: fullEmail, code: verificationCode },
	    success: function(response) {
	      // 인증 성공 메시지를 표시
	      $('#verificationMessage').text(response);  // 서버에서 반환한 메시지를 표시
	      $('#verificationMessage').css('color', 'green');  // 성공 메시지를 녹색으로 표시
	    },
	    error: function(error) {
	      // 인증 실패 메시지를 표시
	      $('#verificationMessage').text("인증 확인에 실패했습니다. 다시 시도해 주세요.");
	      $('#verificationMessage').css('color', 'red');  // 실패 메시지를 빨간색으로 표시
	    }
	  });
	});
  
  
}); // js end
