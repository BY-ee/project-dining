package com.project.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.domain.ChatMessage;
import com.project.domain.ChatRoom;
import com.project.domain.Member;
import com.project.dto.CustomUserDetails;
import com.project.service.ChatRoomService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ChatRoomController {
	
	private final ChatRoomService chatRoomService;
	
    @GetMapping("/community")
    public String community(@AuthenticationPrincipal CustomUserDetails userDetails,
    						Model model) {
    	Member loginUser = userDetails.getMember();
    	
	    if (loginUser != null) {
	        System.out.println("로그인된 유저 정보: " + loginUser);	     
	        model.addAttribute("user", loginUser);
	    } else {
	        System.out.println("로그인된 유저가 없습니다.");
	        return "redirect:/"; 
	    }
	    
    	return "community/chatRoom";
    }
    
    //=================================================================
    // Use ChatRoom Domain 
    //=================================================================
    
    @PostMapping("/create")
    @ResponseBody
    public ResponseEntity<?> createChatRoom(@RequestBody ChatRoom chatRoom) {
        // 요청 데이터 로그 출력
        System.out.println("Received Chat Room Data: " + chatRoom);

        Long memberId = chatRoom.getMemberId(); 
        Long chatRoomId = chatRoomService.createChatRoom(chatRoom);

        System.out.println("Created Chat Room ID: " + chatRoomId);

        chatRoomService.addUserToChatRoom(chatRoomId, memberId);

        return ResponseEntity.ok("Chat room created and user added.");
    }
    
    @PostMapping("/join")
    public ResponseEntity<?> joinChatRoom(@RequestBody ChatRoom joinRequest) {
        Long chatRoomId = joinRequest.getChatRoomId();
        Long memberId = joinRequest.getMemberId();

        // 1. 현재 참여 인원 확인
        int userCount = chatRoomService.getChatRoomUserCount(chatRoomId);

        // 2. 최대 인원 제한 확인
        int maxParticipants = chatRoomService.getChatRoomMaxParticipants(chatRoomId);
        if (userCount >= maxParticipants) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("Chat room is full.");
        }

        // 3. 참여 인원 추가
        chatRoomService.addUserToChatRoom(chatRoomId, memberId);

        return ResponseEntity.ok("User joined the chat room.");
    }
    
    @GetMapping("/{chatRoomId}/participants")
    public ResponseEntity<Integer> getCurrentParticipants(@PathVariable Long chatRoomId) {
        int currentParticipants = chatRoomService.getChatRoomUserCount(chatRoomId);
        return ResponseEntity.ok(currentParticipants);
    }
    
    @GetMapping("/list")
    @ResponseBody
    public List<ChatRoom> listChatRoom(){
    	return chatRoomService.getAllChatRooms();
    }
    
    
    @GetMapping("/my-rooms-list")
    @ResponseBody
    public ResponseEntity<List<ChatRoom>> getMyChatRooms(@AuthenticationPrincipal CustomUserDetails userDetails) {
        Long userId = userDetails.getMember().getId();
        List<ChatRoom> chatRooms = chatRoomService.getChatRoomsByUser(userId);
        return ResponseEntity.ok(chatRooms);
    }
    
    @DeleteMapping("/delete-expired")
    @ResponseBody
    public ResponseEntity<?> deleteExpiredChatRooms() {
        chatRoomService.deleteExpiredChatRooms(); // 서비스에서 만료된 채팅방 삭제
        System.out.println("마감된 채팅방 삭제 완료.");
        return ResponseEntity.ok().build();
    }
    
    
    
    //=================================================================
    // Use ChatMessage Domain 
    //=================================================================
    
    @MessageMapping("/sendMessage/{roomId}")
    @SendTo("/topic/messages/{roomId}")
    public ChatMessage broadcastMessage(@DestinationVariable("roomId") String roomId, @Payload ChatMessage message) {
        System.out.println("브로드캐스트 메시지: " + message);
        return message; // 메시지 전송만 담당
    }
    
    
    @PostMapping("/chat/message")
    @ResponseBody
    public ResponseEntity<?> saveMessage(@RequestBody ChatMessage chatMessage) {
        try {
            chatRoomService.saveMessage(chatMessage); // DB 저장
            System.out.println("메시지 저장 완료: " + chatMessage);
            return ResponseEntity.ok("메시지 저장 성공");
        } catch (Exception e) {
            System.err.println("메시지 저장 실패: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("메시지 저장 실패");
        }
    }
    
    
    @GetMapping("/messages/{roomId}")
    @ResponseBody
    public ResponseEntity<List<ChatMessage>> getMessagesByRoom(@PathVariable("roomId") Long roomId) {
        List<ChatMessage> messages = chatRoomService.getMessagesByRoomId(roomId);
        return ResponseEntity.ok(messages);
    }
   
    
    
    
}
