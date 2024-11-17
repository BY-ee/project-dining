// chat.js

// 전역 변수 선언
let stompClient = null;
let currentRoomId = null;

// 페이지 로드 시 실행
$(document).ready(function () {
    // 채팅창 초기화
    initializeChatPopup();

    // 이전 채팅창 상태 복원
    const chatPopupState = JSON.parse(localStorage.getItem('chatPopupState'));
    if (chatPopupState && chatPopupState.isOpen) {
        const { roomId, position } = chatPopupState;
        enterChatRoom(roomId, 'Chat Room'); // 실제 방 이름을 저장하도록 수정 필요
        $("#chat-popup").css({
            top: position.top,
            left: position.left
        });
    }
});

// 채팅창 초기화 함수
function initializeChatPopup() {
    // 채팅창 드래그 가능하도록 설정
    $("#chat-popup").draggable({
        handle: "div:first-child",
        stop: function (event, ui) {
            const position = ui.position;
            saveChatPopupState(currentRoomId, position, true);
        }
    });

    // 채팅창 닫기 버튼 이벤트
    $("#close-chat-popup").click(function () {
        $("#chat-popup, #chat-popup-overlay").hide();
        saveChatPopupState(null, null, false);
        if (stompClient) {
            stompClient.disconnect();
        }
    });

    // 메시지 전송 버튼 클릭 이벤트
    $("#send-chat").click(function () {
        sendMessageToChatRoom(currentRoomId);
    });
}

// 채팅방 입장 함수
function enterChatRoom(roomId, roomName) {
    currentRoomId = roomId;
    $("#chat-popup").show(); // 채팅창 표시
    $("#chat-popup-overlay").show();
    $("#chat-room-name").text(roomName);

    connectToChatRoom(roomId);
    loadChatMessages(roomId); // 메시지 불러오기

    // 채팅창이 열려 있음을 상태에 저장
    saveChatPopupState(roomId, $("#chat-popup").position(), true);
}

// 채팅창 상태 저장 함수
function saveChatPopupState(roomId, position, isOpen) {
    const chatState = {
        roomId: roomId,
        position: position || { top: '20%', left: '30%' },
        isOpen: isOpen
    };
    localStorage.setItem('chatPopupState', JSON.stringify(chatState));
}

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

    const timeWithoutYear = new Date().toLocaleTimeString('ko-KR', {
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
    });

    const message = {
        sender: sender,
        content: content,
        timestamp: timeWithoutYear,
        roomId: roomId,
        memberId: $("#memberId").val() || "defaultMemberId", // 기본 memberId
        type: "TEXT", // 기본 메시지 유형
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
        }
    });

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

// 메시지 불러오기
function loadChatMessages(roomId) {
    $.ajax({
        url: "/messages/" + roomId,
        type: "GET",
        success: function (messages) {
            const chatContent = $("#chat-content");
            chatContent.empty(); // 기존 메시지 초기화

            messages.forEach(function (message) {
                displayMessage(message); // 메시지 표시 함수 호출
            });

            console.log("메시지 불러오기 성공:", messages);
        },
        error: function (error) {
            console.error("메시지 불러오기 실패:", error);
        }
    });
}