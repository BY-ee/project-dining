let stompClient = null;
let currentRoomId = null;

$(document).ready(function () {
    // 페이지 로드 시 "내 채팅방 목록" 표시
    initializeChat();
    loadChatRooms();

    // 채팅방 닫기 버튼 클릭 이벤트
    $("#close-chat-room").click(function () {
        $("#chat-room-container").hide(); // 채팅방 숨기기
        $("#chat-list-container").show(); // 채팅 목록 표시
        currentRoomId = null; // 현재 방 ID 초기화
        if (stompClient) {
            stompClient.disconnect(); // WebSocket 연결 해제
        }
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

    // 드래그 가능 설정
    $("#chat-room-container, #chat-list-container").draggable({
        handle: "#chat-room-header, #chat-list-header",
        containment: "window",
        stop: function (event, ui) {
            const position = ui.position;
            saveChatPopupState(position); // 위치를 공유하도록 저장
        },
    });
	
	connectToGlobalChannel();
});

function initializeChat() {
    initializeChatPopup();

    // 채팅 목록만 표시
    $("#chat-list-container").show();
    $("#chat-room-container").hide();
}

function initializeChatPopup() {
	
    const chatPopupState = JSON.parse(localStorage.getItem("chatPopupState"));

    if (chatPopupState && chatPopupState.position) {
        const { position } = chatPopupState;

        // 동일한 위치를 두 컨테이너에 적용
        $("#chat-list-container, #chat-room-container").css({
            top: position.top,
            left: position.left,
        });
    }
}

function saveChatPopupState(position) {
    const chatState = {
        position: position || { top: "20%", left: "30%" }, // 기본 위치 설정
    };

    // 상태를 localStorage에 저장
    localStorage.setItem("chatPopupState", JSON.stringify(chatState));
    console.log("채팅창 위치 상태 저장:", chatState);
}

// 채팅방 목록 로드 함수
function loadChatRooms() { 	
    const chatList  = $("#chat-list");
    chatList .empty(); // 기존 콘텐츠 초기화

    // 서버에 AJAX 요청
    $.ajax({
        url: "/my-rooms-list", // 서버 API 엔드포인트
        type: "GET",
        dataType: "json",
        success: function (rooms) {
            if (rooms.length === 0) {
                chatListContainer .append("<p>참여 중인 채팅방이 없습니다.</p>");
                return;
            }

            // 채팅방 목록 생성
			rooms.forEach((room) => {
			    const roomHtml = `
			        <div class="chat-room" data-room-id="${room.chatRoomId}">
			            <div class="chat-room-header">
			                <div class="room-name">${room.roomName} (${room.currentParticipants}/${room.maxParticipants})</div>
			                <div class="last-time">${formatTimestamp(room.lastMessageSentAt) || "없음"}</div>
			            </div>
			            <div class="last-message">${room.lastMessage || "마지막 메시지가 없습니다."}</div>
			        </div>
			    `;
			    chatList.append(roomHtml);
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

function formatTimestamp(timestamp) {
    if (!timestamp) return null;

    const date = new Date(timestamp);

    return date.toLocaleTimeString("ko-KR", {
        hour: "2-digit",
        minute: "2-digit",
        second: "2-digit",
    });
}


// 채팅방 입장 함수
function enterChatRoom(roomId, roomName) {
    if (!roomId) {
        console.error("유효하지 않은 Room ID입니다.");
        return;
    }
	
    currentRoomId = roomId;
	
	// 채팅 입력창 표시
	$("#chat-list-container").hide();
	$("#chat-room-container").show();
	$("#chat-room-name").text(roomName);

    connectToChatRoom(roomId);
	loadChatMessages(roomId);

	$("#chat-input-container").show();
}

// WebSocket 글로벌 연결 함수
function connectToGlobalChannel() {
    const socket = new SockJS("/chat-websocket");
    stompClient = Stomp.over(socket);

    stompClient.connect({}, function (frame) {
        console.log("WebSocket 글로벌 연결 성공!", frame);

        // 글로벌 채널 구독
        stompClient.subscribe("/topic/messages/global", function (message) {
            const chatMessage = JSON.parse(message.body);
            console.log("브로드캐스트 메시지 수신:", chatMessage);

            // 목록 UI 업데이트
            updateLastMessageInChatList(chatMessage.roomId, chatMessage);
        });
    });
}

function connectToParticipantsChannel(roomId) {
    if (!stompClient || !roomId) {
        console.error("WebSocket 클라이언트 또는 Room ID가 없습니다.");
        return;
    }

    // 채팅방 참여자 수 채널 구독
    stompClient.subscribe(`/topic/participants/${roomId}`, function (message) {
        const updatedParticipants = JSON.parse(message.body);
        console.log(`참여자 수 업데이트 수신 - Room ID: ${roomId}, Participants: ${updatedParticipants}`);

        // UI 업데이트
        updateParticipantsInChatList(roomId, updatedParticipants);
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

	        // 메시지 실시간 구독
	        stompClient.subscribe(`/topic/messages/${roomId}`, function (message) {
	            const chatMessage = JSON.parse(message.body);
	            displayMessage(chatMessage);
	            console.log("실시간 메시지 수신:", chatMessage);
	        });
	    },
	    function (error) {
	        console.error("WebSocket 연결 실패:", error);
	        alert("WebSocket 연결에 실패했습니다. 다시 시도해주세요.");
	        setTimeout(() => connectToChatRoom(roomId), 5000);
	    }
	);
}

// 메시지 표시 함수
function displayMessage(message) {
    if (!message || !message.content) {
        console.warn("유효하지 않은 메시지입니다.", message);
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

// 채팅 목록의 최신 메시지 업데이트
function updateLastMessageInChatList(roomId, chatMessage) {
    const chatRoomElement = $(`[data-room-id='${roomId}']`);
    if (chatRoomElement.length) {
        const lastMessageElement = chatRoomElement.find(".last-message");
        const lastTimeElement = chatRoomElement.find(".last-time");

        lastMessageElement.text(chatMessage.content || "메시지가 없습니다.");
        lastTimeElement.text(formatTimestamp(chatMessage.timestamp) || "없음");
    }
}

// 참여자 수 UI 업데이트 함수
function updateParticipantsInChatList(roomId, participants) {
    const chatRoomElement = $(`[data-room-id='${roomId}']`);
    if (chatRoomElement.length) {
        const roomNameElement = chatRoomElement.find(".room-name");

        // 기존 텍스트에서 참여자 수 부분만 갱신
        const roomNameText = roomNameElement.text();
        const updatedText = roomNameText.replace(/\(\d+\/\d+\)/, `(${participants}/${roomNameElement.data('max-participants')})`);
        roomNameElement.text(updatedText);
    }
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
			messages.forEach((message) => displayMessage(message));
            console.log("메시지 불러오기 성공:", messages);
        },
        error: function (error) {
            console.error("메시지 불러오기 실패:", error);
        },
    });
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
		memberId: $("#memberId").val(),
        content: content,
        timestamp: new Date().toISOString(), // 서버에서 타임스탬프 처리 가능
        roomId: roomId,
        type: "TEXT",
    };

    // 서버로 WebSocket 메시지 전송 (브로드캐스트)
    stompClient.send(`/app/sendMessage/${roomId}`, {}, JSON.stringify(message));
	stompClient.send("/app/sendGlobalMessage", {}, JSON.stringify(message));

	
    // 메시지 저장 요청
    saveMessageToServer(message);

    // 입력 필드 초기화
    $("#chat-input").val("");
}

// 메시지 저장 함수
function saveMessageToServer(message) {
    $.ajax({
        url: "/chat/message",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(message),
        success: function () {
            console.log("메시지 저장 성공");
        },
        error: function (error) {
			console.log("message")
            console.error("메시지 저장 실패:", error);
        },
    });
}
