// community.js

$(document).ready(function () {
	
	function checkLoginStatus(callback) {
	        $.ajax({
	            url: "/isLoggedIn",
	            type: "GET",
	            success: function (isLoggedIn) {
	                callback(isLoggedIn);
	            },
	            error: function () {
	                console.error("로그인 상태 확인 실패");
	                callback(false); // 기본적으로 비로그인 상태로 처리
	            }
	        });
	    }
		
    // 팝업 열기
    $("#show-create-popup").click(function () {
        $("#create-form-popup, #create-form-popup-overlay").fadeIn();
    });

    // 팝업 닫기
    $("#cancel-create-popup").click(function () {
        $("#create-form-popup, #create-form-popup-overlay").fadeOut();
    });

    // 채팅방 생성
	$("#chat-room-form").submit(function (event) {
	    event.preventDefault(); // 기본 동작 방지

	    checkLoginStatus(function (isLoggedIn) {
	        if (isLoggedIn) {
	            // 로그인 상태일 때만 채팅방 생성 요청 진행
	            const themeString = getSelectedThemeString();

	            const formData = {
	                roomName: $("#roomName").val(),
	                memberId: $("#memberId").val(),
	                location: $("#location").val(),
	                maxParticipants: $("#maxParticipants").val(),
	                theme: themeString,
	                recruitmentDuration: $("#recruitmentDuration").val(),
	                additionalDescription: $("#additionalDescription").val(),
	            };

	            console.log("Form Data:", formData);

	            $.ajax({
	                url: "/create",
	                type: "POST",
	                contentType: "application/json",
	                data: JSON.stringify(formData),
	                success: function () {
	                    alert("채팅방이 생성되었습니다!");
	                    window.location.reload(); // 페이지 새로고침
	                    $("#create-form-popup, #create-form-popup-overlay").fadeOut();
	                    fetchChatRooms();
	                },
	                error: function (error) {
	                    console.error("채팅방 생성 실패:", error);
	                    alert("채팅방 생성에 실패했습니다.");
	                }
	            });
	        } else {
	            // 비로그인 상태일 때 알림 표시
	            alert("로그인 후 사용 가능합니다.");
	        }
	    });
	});
	
	// 채팅방 입장 버튼 클릭
	    $(".chat-list").on("click", ".enter-btn", function (event) {
	        event.stopPropagation();

	        checkLoginStatus(function (isLoggedIn) {
	            if (isLoggedIn) {
	                const roomId = $(event.target).data("room-id");
	                const roomName = $(event.target).data("room-name");
	                joinChatRoom(roomId, roomName);
	            } else {
	                alert("로그인 후 사용 가능합니다.");
	            }
	        });
	    });

    // 만료된 채팅방 삭제
    deleteExpiredChatRooms();

    // 채팅방 목록 불러오기
    fetchChatRooms();
	
});

// 채팅방 목록 불러오기
function fetchChatRooms() {
    $.ajax({
        url: "/list",
        type: "GET",
        success: function (chatRooms) {
            const chatList = $(".chat-list"); // chat-item들이 들어갈 컨테이너
            chatList.empty(); // 기존 목록 초기화

            chatRooms.forEach(function (room) {
                const formattedDate = room.recruitmentDeadline
                    ? new Date(room.recruitmentDeadline).toLocaleString()
                    : '없음';

                const html = `
                    <div class="chat-item" 
                         data-room-id="${room.chatRoomId}" 
                         data-creator="${room.creatorNickname || '알 수 없음'}" 
                         data-deadline="${formattedDate}"
						 data-theme="${room.theme}">
                        <div class="chat-info">
                            <span class="chat-location">${room.location || "없음"}</span>
                            <span class="chat-name">${room.roomName || "없음"}</span>
                        </div>
                        <div class="chat-status">
                            <span>(${room.currentParticipants} / ${room.maxParticipants})</span>
                            <button class="enter-btn" 
                                    data-room-id="${room.chatRoomId}" 
                                    data-room-name="${room.roomName}">
                                입장
                            </button>
                        </div>
                    </div>
                `;

                chatList.append(html);
            });

            // 입장 버튼 이벤트 핸들러 추가
			$(".chat-list").on("click", ".enter-btn", function (event) {
			    event.stopPropagation(); // 클릭 이벤트 전파 방지

			    checkLoginStatus(function (isLoggedIn) {
			        if (isLoggedIn) {
			            const roomId = $(event.target).data("room-id");
			            const roomName = $(event.target).data("room-name");
			            joinChatRoom(roomId, roomName); // 입장 로직 호출
			        } else {
			            alert("로그인 후 사용 가능합니다.");
			        }
			    });
			});

            // chat-item 클릭 시 토글
            $(".chat-item").off("click").on("click", function (event) {
                if ($(event.target).hasClass("enter-btn")) {
                    return; // 입장 버튼 클릭 시 토글 방지
                }

                const chatItem = $(this);
                const roomId = chatItem.data("room-id");
                const creator = chatItem.data("creator");
                const deadline = chatItem.data("deadline");
				const theme = chatItem.data("theme");

                // 토글 대상 컨테이너 찾기
                let detailsContainer = $(`.chat-details-container[data-room-id="${roomId}"]`);

                // 세부정보 컨테이너가 없으면 생성
                if (detailsContainer.length === 0) {
                    detailsContainer = $(`
                        <div class="chat-details-container" data-room-id="${roomId}">
                            <p>생성자: ${creator}</p>
                            <p>마감일: ${deadline}</p>
							<p>테마: ${theme}</p>
                        </div>
                    `);

                    // `.chat-item` 아래에 추가
                    chatItem.after(detailsContainer);
                }

                // 토글 애니메이션
                detailsContainer.slideToggle(200);
            });
        },
        error: function (error) {
            console.error("채팅방 목록 불러오기 실패:", error);
        },
    });
}
function joinChatRoom(roomId, roomName) {
    const memberId = $("#memberId").val(); // 사용자 ID를 가져옴

    const requestData = {
        chatRoomId: roomId,
        memberId: memberId,
    };
	
	console.log(roomId, memberId)

    // 서버에 입장 요청
    $.ajax({
        url: "/join",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(requestData),
        success: function (res) {
            alert("채팅방에 입장했습니다: " + roomName);
            window.location.reload(); // 페이지 새로고침
			enterChatRoom(roomId, roomName);
        },
        error: function (xhr) {
            alert(xhr.responseText || "입장 실패");
        },
    });
}

// 만료된 채팅방 삭제
function deleteExpiredChatRooms() {
    $.ajax({
        url: "/delete-expired",
        type: "DELETE",
        success: function () {
            console.log("만료된 채팅방 삭제 완료");
            fetchChatRooms();
        },
        error: function (error) {
            console.error("만료된 채팅방 삭제 실패:", error);
        }
    });
}


