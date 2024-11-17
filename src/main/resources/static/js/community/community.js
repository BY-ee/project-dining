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

        $.ajax({
            url: "/create",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(formData),
            success: function () {
                alert("채팅방이 생성되었습니다!");
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

                html += '<tr>' +
                            '<td>' + (room.chatRoomId || '') + '</td>' +
                            '<td>' + (room.roomName || '') + '</td>' +
                            '<td>' + (room.location || '') + '</td>' +
                            '<td>' + (room.maxParticipants || '') + '</td>' +
                            '<td>' + (room.theme || '') + '</td>' +
                            '<td>' + formattedDate + '</td>' +
                            '<td>' + (room.creatorNickname || '') + '</td>' +
                            '<td>' +
                                '<button class="enter-room" data-room-id="' + room.chatRoomId + '" data-room-name="' + room.roomName + '">입장</button>' +
                            '</td>' +
                        '</tr>';
            });

            tableBody.html(html);

            // 이벤트 바인딩
            $(".enter-room").off("click").on("click", function () {
                const roomId = $(this).data("room-id");
                const roomName = $(this).data("room-name");
                enterChatRoom(roomId, roomName); // chat.js에 정의된 함수 호출
            });
        },
        error: function (error) {
            console.error("채팅방 목록 불러오기 실패:", error);
        }
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