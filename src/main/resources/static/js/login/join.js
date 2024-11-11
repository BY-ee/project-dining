$(document).ready(function() {
  	
	// 아이디 중복검사
	$("#idCheck-btn").on('click', function() {
	           var member_id = $('#member_id').val().trim();

	           if (member_id === "") {
	               $('#id-check-result').text("아이디를 입력해 주세요.").css("color", "red");;
	               return;
	           }

	           $.ajax({
	               type: 'POST', 
	               url: '/idCheck', 
	               data: { member_id: member_id }, 
	               success: function(response) {
	                   if (response === 1) { 
	                       $('#id-check-result').text("이미 사용 중인 아이디입니다.").css("color", "red");;
	                   } else {
	                       $('#id-check-result').text("사용 가능한 아이디입니다.").css("color", "green");;
	                   }
	               },
	               error: function() {
	                   $('#id-check-result').text("오류가 발생했습니다. 다시 시도해 주세요.").css("color", "red");
	               }
	           });
	       });
	
	// 닉네임 중복검사
	$("#nicknameCheck-btn").on('click', function() {
		var nickname = $('#nickname').val().trim();

		if (nickname === "") {
			$('#nickname-check-result').text("아이디를 입력해 주세요.").css("color", "red");;
			return;
		}

		$.ajax({
			type: 'POST', 
			url: '/nicknameCheck', 
			data: { nickname: nickname },
			success: function(response) {
				// 서버 응답에 따라 결과 표시
				if (response === 1) { 
					$('#nickname-check-result').text("이미 사용 중인 닉네임입니다.").css("color", "red");;
				} else {
					$('#nickname-check-result').text("사용 가능한 닉네임입니다.").css("color", "green");
				}
			},
			error: function() {
				$('#nickname-check-result').text("오류가 발생했습니다. 다시 시도해 주세요.").css("color", "red");
			}
		});
	});	
	
	// 비밀번호 일치 체크
	$('#passwd, #passwdCheck').on('input', function() {
	       var passwd = $('#passwd').val();
	       var passwdCheck = $('#passwdCheck').val();

	       // 비밀번호와 비밀번호 확인 값이 일치하는지 확인
		   if (passwd === passwdCheck) {
		       $('#passwd-check-result').text("비밀번호 일치").css("color", "green");
		   } else {
		       $('#passwd-check-result').text("비밀번호 불일치").css("color", "red");
		   }
	   });
	
	
	
	
	// Domain 선택
	$("#email").change(function() {
    if ($("#email").val() === "") {
      $("#domain").removeAttr("readonly");
      $("#domain").val("").focus();
    } else {
      $("#domain").val($("#email").val());
      $("#domain").attr("readonly", "readonly");
    }
  });
  
  
  
  
  
  
    // 이메일 인증
 	 $('#verifyButton').on('click', function() {
    // 이메일 주소 합치기
    const mailid = $('#mailid').val().trim();
    let domain = $('#domain').val().trim();
    const emailSelect = $('#email').val();
	
    if (emailSelect) {
      domain = emailSelect; // select에서 선택한 도메인으로 설정
    }

    const fullEmail = `${mailid}@${domain}`;

    if ($('#verificationCode').length === 0) {
      $('#verification-input-container').html(
        `<input type="text" id="verificationCode"  placeholder="인증 코드">
         <button type="button" id="confirmButton">확인</button>`
      );
    }
    // AJAX 요청으로 이메일 서버에 전송
    $.ajax({
      url: '/send-verification-email',  // 서버의 이메일 전송 엔드포인트
      type: 'POST',
      data: { userEmail : fullEmail },
      success: function(response) {
        alert(response);
      },
      error: function(error) {
        alert(response);
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
	    url: '/verifyCode',  // 인증 코드 확인을 위한 서버 엔드포인트
	    type: 'POST',
	    data: { userEmail: fullEmail, code: verificationCode },
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
  
	
	
	$('#ownerValidation').click(function() {
		 var ownerCode1 = $('#ownerCode1').val().trim();
		 var ownerCode2 = $('#ownerCode2').val().trim();
		 var ownerCode3 = $('#ownerCode3').val().trim();

		  var businessNumber = ownerCode1 + ownerCode2 + ownerCode3;
	
	        // 입력값 검증(사업자 번호는 10자리임)
	        if (businessNumber.length !== 10 || isNaN(businessNumber)) {
	            $('#validationMessage').text('유효한 사업자등록번호를 입력해주세요.');
	            return;
	        }

	        // API 요청 데이터
	        var requestData = {
	            "b_no": [businessNumber]
	        };
	
			
	        $.ajax({
	            url: 'https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=4ZDFaX88OAD5ZwPJ%2FVnHtfRxa9MVdW9%2Bxtl4BP%2FKCuxqGZnSajTjNU2a%2FfzV9Qwuv5cF%2F%2BJIS0Kh%2FJi6qhWvuA%3D%3D',
	            type: 'POST',
	            data: JSON.stringify(requestData),
	            dataType: 'json',
	            contentType: 'application/json',
	            success: function(response) {
	                if (response.data && response.data.length > 0) {
	                    var status = response.data[0].b_stt_cd;
						console.log(status);
	                    if (status === '01') { // 01: 계속사업자
	                        $('#validationMessage').text('인증되었습니다.');
	                    } else {
	                        $('#validationMessage').text('영업 중인 사업자가 아닙니다.');
	                    }
	                } else {
	                    $('#validationMessage').text('유효하지 않은 사업자등록번호입니다.');
	                }
	            },
	            error: function() {
	                $('#validationMessage').text('인증 중 오류가 발생했습니다. 다시 시도해주세요.');
	            }
	        });
	    });
		
		
  
}); // js end
