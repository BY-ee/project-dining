<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채팅방 관리</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
        <style>
        /* 채팅방 생성 팝업 스타일 */
        #create-form-popup {
            position: fixed;
            top: 20%;
            left: 30%;
            width: 40%;
            background: white;
            border: 1px solid #ccc;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            z-index: 1000;
            padding: 20px;
            display: none;
        }

        #create-form-popup h2 {
            margin-top: 0;
        }

        #create-form-popup-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
            display: none;
        }

        /* 일반 스타일 */
        #chat-room-list {
            margin-top: 20px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        th {
            background-color: #f4f4f4;
            text-align: left;
        }

        button {
            cursor: pointer;
        }
        
		.chat-message {
		    margin-bottom: 10px; /* 메시지 간 간격 */
		    display: flex;
		    flex-direction: column; /* 위아래로 배치 */
		    align-items: flex-start; /* 기본적으로 왼쪽 정렬 */
		}
		
		.chat-message.message-right {
		    align-items: flex-end; /* 오른쪽 정렬 */
		}
		
		.chat-sender {
		    font-weight: bold; /* 닉네임 강조 */
		    margin-bottom: 5px; /* 닉네임과 메시지 간격 */
		    font-size: 0.9em;
		    color: #555; /* 닉네임 색상 */
		}
		
		.chat-content {
		    padding: 10px;
		    border-radius: 10px;
		    max-width: 70%;
		    word-wrap: break-word;
		}
		
		.chat-message.message-right .chat-content {
		    background-color: #F5E9E9; /* 오른쪽 메시지 색상 */
		    border: 1px solid #F5E9E9;
		}
		
		.chat-message.message-left .chat-content {
		    background-color: #ffffff; /* 왼쪽 메시지 색상 */
		    border: 1px solid #ddd;
		}
		
		.chat-timestamp {
		    font-size: 0.8em;
		    color: #999;
		    margin-top: 5px; /* 메시지와 타임스탬프 간격 */
		}
    </style>
</head>
<body>
    <h1>채팅방 관리</h1>
    
    <!-- 채팅방 생성 팝업 -->
    <div id="create-form-popup">
        <h2>채팅방 생성</h2>
        <form id="chat-room-form">
            <label for="roomName">채팅방 이름:</label>
            <input type="text" id="roomName" name="roomName" required><br><br>
            <input type="hidden" id="memberId" name="memberId" value="${sessionScope.loginUser.id}">
            <label for="location">지역:</label>
            <input type="text" id="location" name="location"><br><br>
            <label for="maxParticipants">정원:</label>
            <input type="number" id="maxParticipants" name="maxParticipants" required><br><br>
            <label for="theme">테마:</label>
            <input type="text" id="theme" name="theme"><br><br>
            <label for="recruitmentDuration">모집 기간(분):</label>
            <input type="number" id="recruitmentDuration" name="recruitmentDuration" required><br><br>
            <label for="additionalDescription">추가 설명:</label>
            <textarea id="additionalDescription" name="additionalDescription"></textarea><br><br>
            <button type="submit">생성</button>
            <button type="button" id="cancel-create-popup">취소</button>
        </form>
    </div>
    <div id="create-form-popup-overlay"></div>
    

    <div id="chat-room-list">
        <h2>채팅방 목록</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>채팅방 이름</th>
                    <th>지역</th>
                    <th>정원</th>
                    <th>테마</th>
                    <th>마감 시간</th>
                    <th>생성자</th>
                    <th>액션</th>
                </tr>
            </thead>
            <tbody id="chat-room-table-body"></tbody>
        </table>
    </div>
    
    <button id="show-create-popup">채팅방 생성</button>

    <script>
    
	    $("#show-create-popup").click(function () {
	        $("#create-form-popup, #create-form-popup-overlay").fadeIn();
	    });
	
	    // 팝업 닫기
	    $("#cancel-create-popup").click(function () {
	        $("#create-form-popup, #create-form-popup-overlay").fadeOut();
	    });
	    
        let stompClient = null;

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
        
        function sendMessageToChatRoom(roomId) {
            if (!stompClient || !stompClient.connected) {
                alert("WebSocket 연결이 아직 완료되지 않았습니다. 잠시 후 다시 시도해주세요.");
                return;
            }

            const sender = "${sessionScope.loginUser.nickname}";
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

        function displayMessage(message) {
            const chatContent = $("#chat-content");

            // 현재 로그인한 사용자 닉네임 가져오기 (서버에서 전달받거나 설정)
            const currentUser = "${sessionScope.loginUser.nickname}";

            // 메시지 구분
            const messageClass = message.sender === currentUser ? "message-right" : "message-left";

            // 메시지 HTML 생성
		    const messageHtml =
			    '<div class="chat-message ' + messageClass + '">' +
			        '<div class="chat-sender">' + message.sender + '</div>' + // 닉네임
			        '<div class="chat-content">' + message.content + '</div>' +
			        '<div class="chat-timestamp">' + message.timestamp + '</div>' +
			    '</div>';

            // 메시지 추가
            chatContent.append(messageHtml);

            // 스크롤 하단으로 이동
            chatContent.scrollTop(chatContent[0].scrollHeight);
        }

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

            $("#close-chat-popup").click(function () {
                $("#chat-popup, #chat-popup-overlay").remove();
                if (stompClient) {
                    stompClient.disconnect();
                }
            });

            connectToChatRoom(roomId);

            $("#send-chat").click(function () {
                sendMessageToChatRoom(roomId);
            });
        }

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
		                            '<td>' + (room.creatorNickname || '') + '</td>' + // 생성자 닉네임 표시
		                            '<td>' +
		                                '<button class="enter-room" data-room-id="' + room.id + '"data-room-name="' + room.roomName+ '">입장</button>' +
		                            '</td>' +
		                        '</tr>';
		            });

		            tableBody.html(html); // DOM에 추가 후 이벤트 바인딩

		            // 이벤트 바인딩은 DOM이 업데이트된 후 수행
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
                    fetchChatRooms(); // 채팅방 목록 업데이트
                },
                error: function (error) {
                    console.error("채팅방 생성 실패:", error);
                    alert("채팅방 생성에 실패했습니다.");
                }
            });
        });
        
        function deleteExpiredChatRooms() {
            $.ajax({
                url: "/delete-expired",
                type: "DELETE",
                success: function () {
                    console.log("만료된 채팅방 삭제 완료");
                    fetchChatRooms(); // 채팅방 목록 갱신
                },
                error: function (error) {
                    console.error("만료된 채팅방 삭제 실패:", error);
                }
            });
        }
        
        $(document).ready(function () {
            deleteExpiredChatRooms();
            fetchChatRooms();
        });
    </script>
</body>
</html>