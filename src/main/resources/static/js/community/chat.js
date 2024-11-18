// 전역 변수 선언
let stompClient = null;
let currentRoomId = null;

// 페이지 로드 시 실행
$(document).ready(function () {
	console.log("jQuery 로드 확인:", $.fn.jquery);
    initializeChat(); // 초기화 함수 호출
});

// 채팅 초기화 함수
function initializeChat() {
    initializeChatPopup();

    // 이전 채팅창 상태 복원
    const chatPopupState = JSON.parse(localStorage.getItem('chatPopupState'));
    if (chatPopupState && chatPopupState.isOpen) {
        const { roomId, position } = chatPopupState;
        enterChatRoom(roomId, 'Chat Room');
        $("#chat-popup").css({
            top: position.top,
            left: position.left,
        });
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
            // 연결 실패 시 재시도 로직
            setTimeout(() => connectToChatRoom(roomId), 5000);
        }
    );
}

// 메시지 전송 함수
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
        timestamp: new Date().toLocaleTimeString("ko-KR", {
            hour: "2-digit",
            minute: "2-digit",
            second: "2-digit",
        }),
        roomId: roomId,
        memberId: $("#memberId").val() || "defaultMemberId",
        type: "TEXT",
    };

    $.ajax({
        url: "/chat/message",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(message),
        success: function () {
            console.log("메시지 저장 완료");
        },
        error: function (error) {
            console.error("메시지 저장 실패:", error);
        },
    });

    stompClient.send(`/app/sendMessage/${roomId}`, {}, JSON.stringify(message));
    $("#chat-input").val(""); // 입력창 초기화
}

// 메시지 표시 함수
function displayMessage(message) {
    if (!message || !message.content) {
        console.warn("유효하지 않은 메시지입니다.", message);
        return;
    }

    const currentUser = $("#nickname").val();
    const messageClass = message.sender === currentUser ? "message-right" : "message-left";

    const messageHtml = `
        <div class="chat-message ${messageClass}">
            <div class="chat-sender">${message.sender}</div>
            <div class="chat-content">${message.content}</div>
            <div class="chat-timestamp">${message.timestamp}</div>
        </div>
    `;

    const chatContent = $("#chat-content");
    chatContent.append(messageHtml);
    chatContent.scrollTop(chatContent.prop("scrollHeight"));
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

            messages.forEach(function (message) {
                displayMessage(message);
            });

            console.log("메시지 불러오기 성공:", messages);
        },
        error: function (error) {
            console.error("메시지 불러오기 실패:", error);
        },
    });
}

// 채팅창 상태 저장 함수
function saveChatPopupState(roomId, position, isOpen) {
    const chatState = {
        roomId: roomId,
        position: position || { top: "20%", left: "30%" },
        isOpen: isOpen,
    };
    localStorage.setItem("chatPopupState", JSON.stringify(chatState));
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

    connectToChatRoom(roomId);
    loadChatMessages(roomId);

    saveChatPopupState(roomId, $("#chat-popup").position(), true);
}
