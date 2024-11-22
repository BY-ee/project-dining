$(document).ready(function() {
		
	
	let isIdValid = false; // ID 중복 확인 상태
	let isNicknameValid = false; // ID 중복 확인 상태
	let isPasswordValid = false; // 비밀번호 확인 상태
	let isEmailVerified = false; // 이메일 인증 상태
	let verifiedEmail = ""; // 인증된 이메일 주소를 저장
	
	// 아이디 중복검사
	$("#idCheck-btn").on('click', function() {
		var memberId = $('#memberId').val().trim();

		if (memberId === "") {
			$('#id-check-result').text("아이디를 입력해 주세요.").css("color", "red");
			return;
		}

		$.ajax({
			type: 'POST', 
			url: '/idCheck', 
			data: { memberId: memberId }, 
			success: function(response) {
				if (response === 1) { 
					$('#id-check-result').text("이미 사용 중인 아이디입니다.").css("color", "red");
				} else {
					$('#id-check-result').text("사용 가능한 아이디입니다.").css("color", "green");
					isIdValid = true;
				}	
			},
			error: function() {
				$('#id-check-result').text("오류가 발생했습니다. 다시 시도해 주세요.").css("color", "red");
			}
		});
	});
				
	$("#memberId").on('keyup', function() {
		$('#id-check-result').text(""); // 중복 확인 메시지를 초기화
		isIdValid = false; 
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
					$('#nickname-check-result').text("이미 사용 중인 닉네임입니다.").css("color", "red");
				} else {
					$('#nickname-check-result').text("사용 가능한 닉네임입니다.").css("color", "green");
					isNicknameValid = true;
				}
			},
			error: function() {
				$('#nickname-check-result').text("오류가 발생했습니다. 다시 시도해 주세요.").css("color", "red");
			}
		});
	});	
	
	$("#nickname").on('keyup', function() {
		$('#nickname-check-result').text(""); // 중복 확인 메시지를 초기화
		isNicknameValid = false; // 닉네임 검증 상태를 초기화
	});
	
	// 비밀번호 일치 체크
	$('#passwdCheck').on('input', function() {
		var passwd = $('#passwd').val();
		var passwdCheck = $('#passwdCheck').val();

		// 비밀번호와 비밀번호 확인 값이 일치하는지 확인
		if (passwd === passwdCheck) {
			$('#passwd-check-result').text("비밀번호 일치").css("color", "green");
		isPasswordValid = true;
		} else {
			$('#passwd-check-result').text("비밀번호 불일치").css("color", "red");
		}
	});
	

	// Domain 선택
	$("#emailSelect").change(function() { // select 요소의 ID를 #emailSelect로 변경
		if ($("#emailSelect").val() === "") {
			$("#domain").removeAttr("readonly");
			$("#domain").val("").focus();
		} else {
			$("#domain").val($("#emailSelect").val());
			$("#domain").attr("readonly", "readonly");
		}
	});
	
	



	    $('#verifyButton').on('click', function () {
	        const mailid = $('#mailid').val().trim();
	        let domain = $('#domain').val().trim();
	        const emailSelect = $('#emailSelect').val();

	        if (emailSelect) {
	            domain = emailSelect; // select에서 선택한 도메인으로 설정
	        }

	        const fullEmail = `${mailid}@${domain}`;

	        if (!mailid || !domain) {
	            alert("이메일을 입력해주세요.");
	            return;
	        }

	        // 서버로 이메일 존재 여부 확인 요청
	        $.ajax({
	            url: '/checkEmailExists', // 이메일 존재 여부 확인 엔드포인트
	            type: 'POST',
	            data: { userEmail : fullEmail },
	            success: function (response) {
	                if (response === 1) { // 이메일이 존재하는 경우
	                    alert("해당 이메일로 가입된 아이디가 있습니다.");
	                } else {
						
						if ($('#verificationCode').length === 0) {
									$('#verification-input-container').html(
										`<input type="text" id="verificationCode" placeholder="인증 코드">
											<button type="button" id="confirmButton">확인</button>`
									);
								}
								
	                    // 이메일이 존재하지 않는 경우 인증 코드 발송
	                    $.ajax({
	                        url: '/sendVerificationEmail', // 인증 코드 발송 엔드포인트
	                        type: 'POST',
	                        data: { userEmail: fullEmail },
	                        success: function () {
	                            alert("인증 코드가 이메일로 발송되었습니다.");
	                        },
	                        error: function () {
	                            alert("인증 코드 전송 중 오류가 발생했습니다. 다시 시도해 주세요.");
	                        }
	                    });
	                }
	            },
	            error: function () {
	                alert("이메일 확인 중 오류가 발생했습니다. 다시 시도해 주세요.");
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
				$('#verificationMessage').text(response).css('color', 'green');  // 인증 성공 메시지
				isEmailVerified = true;
				verifiedEmail = fullEmail; // 인증된 이메일 저장
			},
			error: function(error) {
				$('#verificationMessage').text("인증 확인에 실패했습니다. 다시 시도해 주세요.").css('color', 'red');
			}
		});
	});
	
	let validatedBusinessNumber = ""; // 인증된 사업자등록번호를 저장

	$('#ownerCode1').on('input', function() {
	    if ($(this).val().length === 3) {
	        $('#ownerCode2').focus(); // ownerCode1에 3글자가 입력되면 ownerCode2로 이동
	    }
	});

	$('#ownerCode2').on('input', function() {
	    if ($(this).val().length === 2) {
	        $('#ownerCode3').focus(); // ownerCode2에 2글자가 입력되면 ownerCode3으로 이동
	    }
	});
	
	$('#ownerCode3').on('input', function() {
	    // ownerCode3은 5글자까지만 입력 받도록 제한
	    if ($(this).val().length > 5) {
	        $(this).val($(this).val().substring(0, 5)); // 5글자 이상 입력되지 않도록 자르기
	    }
	});
	

			$('#ownerValidation').click(function() {

				
				
			    const ownerCode1 = $('#ownerCode1').val().trim();
			    const ownerCode2 = $('#ownerCode2').val().trim();
			    const ownerCode3 = $('#ownerCode3').val().trim();

			    const businessNumber = ownerCode1 + ownerCode2 + ownerCode3;

			    // 입력값 검증(사업자 번호는 10자리임)
			    if (businessNumber.length !== 10 || isNaN(businessNumber)) {
			        $('#validationMessage').text('유효한 사업자등록번호를 입력해주세요.');
			        return;
			    }

			    // 입력값이 이전에 인증된 값과 다를 경우 인증 상태 초기화
			    if (businessNumber !== validatedBusinessNumber) {
			        $('#validationMessage').text(""); // 메시지 초기화
			        validatedBusinessNumber = ""; // 인증 상태 초기화
			        $('#registrationNumber').val(""); // hidden 필드 초기화
			    }

			    // API 요청 데이터
			    const requestData = {
			        "b_no": [businessNumber]
			    };

			    $.ajax({
			        url: '/proxy/nts-businessman',
			        type: 'POST',
			        data: JSON.stringify(requestData),
			        dataType: 'json',
			        contentType: 'application/json',
			        success: function(response) {
			            if (response.data && response.data.length > 0) {
			                const status = response.data[0].b_stt_cd;
			                console.log(status);
			                if (status === '01') { // 01: 계속사업자
			                    $('#validationMessage').text('인증되었습니다.');
			                    validatedBusinessNumber = businessNumber; // 인증된 사업자등록번호 저장
			                    $('#registrationNumber').val(businessNumber); // hidden 필드에 값 설정
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
		// 모든 회원가입 상태가 통과 시에만 회원가입 진행
		$('#member-signup-button').on('click', function(e) {
			const mailid = $("#mailid").val().trim();
			const domain = $("#domain").val().trim();
			const fullEmail = `${mailid}@${domain}`;
			
			if (!isIdValid) {
				e.preventDefault();
				alert("아이디 중복 확인을 해주세요.");
				return;
			}

			if (!isNicknameValid) {
				e.preventDefault();
				alert("닉네임 중복 확인을 해주세요.");
				return;
			}

			if ($('#passwd').val().trim() === "") {
				e.preventDefault();
				alert("비밀번호를 입력해주세요.");
				return;
			}

			if (!isPasswordValid) {
				e.preventDefault();
				alert("비밀번호가 일치하지 않습니다.");
				return;
			}

			if (!isEmailVerified || fullEmail !== verifiedEmail) {
				e.preventDefault();
				alert("이메일 인증을 완료해 주세요.");
				return;
			}
			
			if (isEmailVerified && fullEmail === verifiedEmail) {
				$("#email").val(fullEmail); // hidden 필드에 합쳐진 이메일을 설정
			}

		});

	// 모든 회원가입 상태가 통과 시에만 회원가입 진행
	$('#owner-signup-button').on('click', function(e) {
		const mailid = $("#mailid").val().trim();
		const domain = $("#domain").val().trim();
		const fullEmail = `${mailid}@${domain}`;
		
		const ownerCode1 = $('#ownerCode1').val().trim();
		const ownerCode2 = $('#ownerCode2').val().trim();
		const ownerCode3 = $('#ownerCode3').val().trim();
		const businessNumber = ownerCode1 + ownerCode2 + ownerCode3;
		
		// 사업자 등록번호 인증 확인
		if (!validatedBusinessNumber || businessNumber !== validatedBusinessNumber) {
			e.preventDefault();
			alert("사업자 등록번호 인증을 완료해 주세요.");
			return;
		}
		
		if (!isIdValid) {
			e.preventDefault();
			alert("아이디 중복 확인을 해주세요.");
			return;
		}

		if (!isNicknameValid) {
			e.preventDefault();
			alert("닉네임 중복 확인을 해주세요.");
			return;
		}

		if ($('#passwd').val().trim() === "") {
			e.preventDefault();
			alert("비밀번호를 입력해주세요.");
			return;
		}

		if (!isPasswordValid) {
			e.preventDefault();
			alert("비밀번호가 일치하지 않습니다.");
			return;
		}

		if (!isEmailVerified || fullEmail !== verifiedEmail) {
			e.preventDefault();
			alert("이메일 인증을 완료해 주세요.");
			return;
		}

		// hidden 필드에 이메일과 사업자 등록번호 설정
		if (isEmailVerified && fullEmail === verifiedEmail) {
			$("#email").val(fullEmail); // 이메일 설정
		}
		if (validatedBusinessNumber && businessNumber === validatedBusinessNumber) {
			$("#registrationNumber").val(businessNumber); // 사업자 등록번호 설정
		}
	});

	// 비밀번호 찾기
	$('#findPwd-btn').on('click', function() {
		const mailid = $('#mailid').val().trim();
		const domain = $('#domain').val().trim();
		const memberId = $('#memberId').val().trim();
		const fullEmail = `${mailid}@${domain}`;

		// 이메일 서버에 전송
		$.ajax({
			url: '/sendPwdResetEmail',
			type: 'POST',
			data: { memberId : memberId,
						userEmail: fullEmail },
			success: function(response) {
				alert(response);
			},
			error: function(error) {
				alert("이메일 전송에 실패했습니다. 다시 시도해 주세요.");
			}
		});
	});

	// 비밀번호 변경
	$('#updatePwd-btn').on('click', function() {
		const memberId = $('#memberId').val().trim();
		const passwd = $('#passwd').val().trim();    
		const passwdCheck = $('#passwdCheck').val().trim();

		// 비밀번호 확인
		if (passwd !== passwdCheck) {
			alert("비밀번호가 일치하지 않습니다.");
			return; // 일치하지 않으면 AJAX 요청을 보내지 않음
		}

		// 이메일 서버에 전송
		$.ajax({
			url: '/updatePassword',
			type: 'POST',
			data: {
				memberId: memberId,
				passwd: passwd,
			},
			success: function(response) {
				alert(response);
				window.close();
			},
			error: function(error) {
				alert("비밀번호 변경에 실패하였습니다.");
			}
		});
	});

	// 아이디 찾기
	$('#findId-btn').on('click', function() {
		const mailid = $('#mailid').val().trim();
		const domain = $('#domain').val().trim();
		const fullEmail = `${mailid}@${domain}`;


		// 아이디 알림창 띄우기
		$.ajax({
			url: '/showId',
			type: 'POST',
			data: {
				email : fullEmail
			},
			success: function(response) {
				alert(response);
			},
			error: function(error) {
				alert("아이디 조회에 실패하였습니다.");
			}
		});
	});

	$('#memberChange-button').on('click', function(e) {
	    e.preventDefault(); 
		
		const businessNumber = $('#registrationNumber').val();

	    $.ajax({
	        url: '/businessVerification',
	        type: 'POST',
	        data: { registrationNumber: businessNumber },
	        success: function(response) {
	            alert("사업자 회원 전환이 완료되었습니다.");
	            window.close(); // 팝업 창 닫기
	            opener.location.reload(); // 부모 창(마이페이지) 새로고침
	        },
	        error: function() {
	            alert("회원 전환 중 오류가 발생했습니다. 다시 시도해주세요.");
	        }
	    });
	});
	
	
}); // js end
