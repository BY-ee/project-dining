// community.js

$(document).ready(function () {
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
        event.preventDefault();

        const formData = {
            roomName: $("#roomName").val(),
            memberId: $("#memberId").val(),
            location: $("#location").val(),
            maxParticipants: $("#maxParticipants").val(),
            theme: $("#theme").val(),
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
            const tableBody = $("#chat-room-table-body");
            tableBody.empty(); // 기존 목록 초기화

            let html = '';
            chatRooms.forEach(function (room) {
                const formattedDate = room.recruitmentDeadline
                    ? new Date(room.recruitmentDeadline).toLocaleString()
                    : '없음';

                html += '<tr class="join-room" data-room-id="' + room.chatRoomId + '">' +
                            '<td>' + (room.chatRoomId || '') + '</td>' +
                            '<td>' + (room.roomName || '') + '</td>' +
                            '<td>' + (room.location || '') + '</td>' +
                            '<td>' + (room.currentParticipants + ' / ' + room.maxParticipants || '') + '</td>' +
                            '<td>' + (room.theme || '') + '</td>' +
                            '<td>' + formattedDate + '</td>' +
                            '<td>' + (room.creatorNickname || '') + '</td>' +
                            '<td>' +
                                '<button class="join-room-btn" data-room-id="' + room.chatRoomId + '" data-room-name="' + room.roomName + '">입장</button>' +
                            '</td>' +
                        '</tr>';
            });

            tableBody.html(html);

            // 이벤트 핸들러 추가
            $(".join-room-btn").off("click").on("click", function () {
                const roomId = $(this).data("room-id");
                const roomName = $(this).data("room-name");

                joinChatRoom(roomId, roomName);
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


