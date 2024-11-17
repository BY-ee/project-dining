$(document).ready(function () {
    // 팝업 열기
    $("#show-create-popup").click(function () {
        $("#create-form-popup, #create-form-popup-overlay").fadeIn();
    });

    // 팝업 닫기
    $("#cancel-create-popup").click(function () {
        $("#create-form-popup, #create-form-popup-overlay").fadeOut();
    });

    let stompClient = null;
	

    // WebSocket 연결
    function connectToChatRoom(roomId) {
        const socket = new SockJS('/chat-websocket');
        stompClient = Stomp.over(socket);

        stompClient.connect({}, function (frame) {
            console.log('WebSocket 연결 성공! Room ID:', roomId);
            console.log('Connected: ' + frame);

            // 메시지 구독
            stompClient.subscribe('/topic/messages/' + roomId, function (message) {
                const chatMessage = JSON.parse(message.body);
                console.log('수신된 메시지:', chatMessage); // 메시지 확인
                displayMessage(chatMessage);
            }, function (error) {
                console.error('메시지 구독 에러:', error);
            });
        }, function (error) {
            console.error('WebSocket 연결 실패:', error);
            alert("WebSocket 연결에 실패했습니다. 다시 시도해주세요.");
        });
    }

    // 메시지 전송
    function sendMessageToChatRoom(roomId) {
        if (!stompClient || !stompClient.connected) {
            alert("WebSocket 연결이 아직 완료되지 않았습니다. 잠시 후 다시 시도해주세요.");
            return;
        }

		const sender = $("#nickname").val(); // 닉네임 가져오기
        const content = $("#chat-input").val();

        if (content.trim() === "") {
            alert("메시지를 입력해주세요.");
            return;
        }

        const message = {
            sender: sender,
            content: content,
            timestamp: new Date().toLocaleTimeString(),
            roomId: roomId,
        };

        console.log('보내는 메시지:', message); // 메시지 확인
        stompClient.send('/app/sendMessage/' + roomId, {}, JSON.stringify(message));
        $("#chat-input").val(""); // 입력창 초기화
    }

    // 메시지 표시
    function displayMessage(message) {
        const chatContent = $("#chat-content");

        // 현재 로그인한 사용자 닉네임 가져오기
        const currentUser = $("#nickname").val(); 

        // 메시지 구분
        const messageClass = message.sender === currentUser ? "message-right" : "message-left";

        // 메시지 HTML 생성
        const messageHtml =
            '<div class="chat-message ' + messageClass + '">' +
                '<div class="chat-sender">' + message.sender + '</div>' +
                '<div class="chat-content">' + message.content + '</div>' +
                '<div class="chat-timestamp">' + message.timestamp + '</div>' +
            '</div>';

        // 메시지 추가
        chatContent.append(messageHtml);

        // 스크롤 하단으로 이동
        chatContent.scrollTop(chatContent[0].scrollHeight);
    }

    // 채팅방 입장
    function enterChatRoom(roomId, roomName) {
        const chatPopup =
            '<div id="chat-popup" style="position: fixed; top: 20%; left: 30%; width: 40%; height: 50%; background: white; border: 1px solid #ccc; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); z-index: 1000; overflow: auto; padding: 20px;">' +
                '<div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #ccc; padding-bottom: 10px;">' +
                    '<h2>' + roomName + '</h2>' +
                    '<button id="close-chat-popup" style="background: red; color: white; border: none; padding: 5px 10px; cursor: pointer;">X</button>' +
                '</div>' +
                '<div id="chat-content" style="margin-top: 20px; height: 70%; overflow-y: auto;"></div>' +
                '<div style="position: absolute; bottom: 10px; width: 100%; display: flex; gap: 10px;">' +
                    '<input type="text" id="chat-input" placeholder="메시지를 입력하세요" style="flex: 1; padding: 5px; border: 1px solid #ccc;">' +
                    '<button id="send-chat" style="background: blue; color: white; border: none; padding: 5px 10px; cursor: pointer;">전송</button>' +
                '</div>' +
            '</div>' +
            '<div id="chat-popup-overlay" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 999;"></div>';

        $("body").append(chatPopup);

        // 팝업 닫기
        $("#close-chat-popup").click(function () {
            $("#chat-popup, #chat-popup-overlay").remove();
            if (stompClient) {
                stompClient.disconnect();
            }
        });

        connectToChatRoom(roomId);

        // 메시지 전송 버튼 클릭
        $("#send-chat").click(function () {
            sendMessageToChatRoom(roomId);
        });
    }

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
                    enterChatRoom(roomId, roomName);
                });
            },
            error: function (error) {
                console.error("채팅방 목록 불러오기 실패:", error);
            }
        });
    }

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

    // 초기화
    deleteExpiredChatRooms();
    fetchChatRooms();
});