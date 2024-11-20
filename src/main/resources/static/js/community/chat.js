let stompClient = null;
let currentRoomId = null;

$(document).ready(function () {
    // 페이지 로드 시 "내 채팅방 목록" 표시
    loadChatRooms();
	initializeChat()

    // 팝업 닫기 버튼 클릭 이벤트
    $("#close-chat-popup").click(function () {
        $("#chat-popup").hide(); // 팝업 닫기
    });

    // 메시지 전송 이벤트 추가
    $("#send-chat").click(function () {
        sendMessageToChatRoom(currentRoomId);
    });

    // Enter 키로 메시지 전송
    $("#chat-input").on("keypress", function (e) {
        if (e.which === 13 && !e.shiftKey) {
            e.preventDefault();
            sendMessageToChatRoom(currentRoomId);
        }
    });
});

function initializeChat() {
    initializeChatPopup();

    // 이전 채팅창 상태 복원
    const chatPopupState = JSON.parse(localStorage.getItem('chatPopupState'));

    if (chatPopupState && chatPopupState.isOpen && chatPopupState.roomId) {
        const { roomId, position } = chatPopupState;

        // 채팅방 입장
        enterChatRoom(roomId, "Chat Room");

        // 위치 복원
        if (position) {
            $("#chat-popup").css({
                top: position.top,
                left: position.left,
            });
        }
    } else {
        // 저장된 상태가 없으면 기본값으로 초기화
        $("#chat-popup").hide();
        $("#chat-popup-overlay").hide();
    }
}

// 채팅창 초기화 함수
function initializeChatPopup() {
    $("#chat-popup").draggable({
        handle: "div:first-child",
        containment: "window", // 화면 밖으로 벗어나지 않도록 설정
        stop: function (event, ui) {
            const position = ui.position;
            saveChatPopupState(currentRoomId, position, true);
        },
    });

    $("#close-chat-popup").click(function () {
        $("#chat-popup, #chat-popup-overlay").hide();
        saveChatPopupState(null, null, false);
        if (stompClient) {
            stompClient.disconnect();
            console.log("WebSocket 연결 해제");
        }
    });

    $("#send-chat").click(function () {
        sendMessageToChatRoom(currentRoomId);
    });
}

// 채팅방 목록 로드 함수
function loadChatRooms() { 	
    const chatContent = $("#chat-content");
    chatContent.empty(); // 기존 콘텐츠 초기화

    // 서버에 AJAX 요청
    $.ajax({
        url: "/my-rooms-list", // 서버 API 엔드포인트
        type: "GET",
        dataType: "json",
        success: function (rooms) {
            if (rooms.length === 0) {
                chatContent.append("<p>참여 중인 채팅방이 없습니다.</p>");
                return;
            }

            // 채팅방 목록 생성
            rooms.forEach((room) => {
                const roomHtml = `
				    <div class="chat-room" data-room-id="${room.chatRoomId}">
				        <div class="chat-room-header">
				            <div class="room-name">${room.roomName} (${room.currentParticipants}/${room.maxParticipants})</div>
				            <div class="last-time">${room.lastMessageTime || "없음"}</div>
				        </div>
				        <div class="last-message">${room.lastMessage || "마지막 메시지가 없습니다."}</div>
				    </div>
				`;
                chatContent.append(roomHtml);
            });

            // 채팅방 클릭 이벤트 추가
            $(".chat-room").off("click").on("click", function () {
                const roomId = $(this).data("room-id");
                const roomName = $(this).find(".room-name").text();
				enterChatRoom(roomId, roomName); // 채팅방 입장
            });
        },
        error: function (xhr, status, error) {
            console.error("채팅방 목록 로드 실패:", error);
        },
    });
}

// 채팅방 입장 함수
function enterChatRoom(roomId, roomName) {
    if (!roomId) {
        console.error("유효하지 않은 Room ID입니다.");
        return;
    }
	
    currentRoomId = roomId;
    $("#chat-popup").show();
    $("#chat-popup-overlay").show();
    $("#chat-room-name").text(roomName);
	
	// 채팅 입력창 표시
	$("#chat-input-container").show();


    connectToChatRoom(roomId);
    loadChatMessages(roomId);

    saveChatPopupState(roomId, $("#chat-popup").position(), true);
}

// WebSocket 연결 함수
function connectToChatRoom(roomId) {
    if (!roomId) {
        console.error("Room ID가 필요합니다.");
        return;
    }

    const socket = new SockJS("/chat-websocket");
    stompClient = Stomp.over(socket);

    stompClient.connect({}, function (frame) {
            console.log("WebSocket 연결 성공!", frame);

			stompClient.subscribe(`/topic/messages/${roomId}`, function (message) {
			    const chatMessage = JSON.parse(message.body);
			    displayMessage(chatMessage);
			    console.log("실시간 메시지 수신:", chatMessage);
			}, function (error) {
			    console.error("구독 실패:", error);
			});
        },
        function (error) {
            console.error("WebSocket 연결 실패:", error);
            alert("WebSocket 연결에 실패했습니다. 다시 시도해주세요.");
            setTimeout(() => connectToChatRoom(roomId), 5000);
        }
    );
}

// 메시지 불러오기 함수
function loadChatMessages(roomId) {
    if (!roomId) {
        console.error("Room ID가 필요합니다.");
        return;
    }

    $.ajax({
        url: `/messages/${roomId}`,
        type: "GET",
        success: function (messages) {
            const chatContent = $("#chat-content");
            chatContent.empty();

            console.log("메시지 불러오기 성공:", messages);
        },
        error: function (error) {
            console.error("메시지 불러오기 실패:", error);
        },
    });
}

// 메시지 표시 함수
function displayMessage(message) {
    if (!message || !message.content) {
        console.warn("유효하지 않은 메시지입니다.", message);
        return;
    }
	
	// 중복 메시지 표시 방지
	if ($("#message-" + message.timestamp).length > 0) {
	    return;
	}

    const currentUser = $("#nickname").val();
    const messageClass = message.sender === currentUser ? "message-right" : "message-left";
	
	const formattedTimestamp = new Date(message.timestamp).toLocaleTimeString("ko-KR", {
	    hour: "2-digit",
	    minute: "2-digit",
	    second: "2-digit",
	});

	const messageHtml = `
	    <div id="message-${message.timestamp}" class="chat-message ${messageClass}">
	        <div class="chat-sender">${message.sender}</div>
	        <div class="chat-content">${message.content}</div>
	        <div class="chat-timestamp">${formattedTimestamp}</div>
	    </div>
	`;

    const chatContent = $("#chat-content");
    chatContent.append(messageHtml);
    chatContent.scrollTop($("#chat-content")[0].scrollHeight); 
}

function sendMessageToChatRoom(roomId) {
    if (!stompClient || !stompClient.connected) {
        alert("WebSocket 연결이 아직 완료되지 않았습니다.");
        return;
    }

    const content = $("#chat-input").val().trim();
    if (!content) {
        alert("메시지를 입력해주세요.");
        return;
    }

    const message = {
        sender: $("#nickname").val() || "익명",
        content: content,
        timestamp: new Date().toISOString(), // 서버에서 타임스탬프 처리 가능
        roomId: roomId,
        type: "TEXT",
    };

    // 서버로 메시지 전송
    stompClient.send(`/app/sendMessage/${roomId}`, {}, JSON.stringify(message));

    // 메시지 클라이언트에 표시
/*    displayMessage(message);*/

    // 입력 필드 초기화
    $("#chat-input").val("");
}
