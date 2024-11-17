package com.project.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.ui.Model;
import com.project.domain.Login;



import com.project.domain.ChatMessage;
import com.project.domain.ChatRoom;
import com.project.service.ChatRoomService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ChatRoomController {
	
	private final ChatRoomService chatRoomService;
	
    @GetMapping("/community")
    public String community(HttpSession session, Model model) {
    	Login loginUser = (Login) session.getAttribute("loginUser");
    	
	    if (loginUser != null) {
	        System.out.println("로그인된 유저 정보: " + loginUser);	     
	        model.addAttribute("user", loginUser);
	    } else {
	        System.out.println("로그인된 유저가 없습니다.");
	        return "redirect:/"; 
	    }
	    
    	return "community/chatRoom";
    }
    
    @PostMapping("/create")
    @ResponseBody
    public ResponseEntity<?> createChatRoom(@RequestBody ChatRoom chatRoom) {
        chatRoomService.insertChatRoom(chatRoom);
        return ResponseEntity.ok().build();
    }
    
    @GetMapping("/list")
    @ResponseBody
    public List<ChatRoom> listChatRoom(){
    	return chatRoomService.getAllChatRooms();
    }
    
    @MessageMapping("/sendMessage/{roomId}")
    @SendTo("/topic/messages/{roomId}")
    public ChatMessage broadcastMessage(@DestinationVariable("roomId") String roomId, @Payload ChatMessage message) {
        System.out.println("Received message: " + message + " in room: " + roomId);
        return message;
    }
    
    @DeleteMapping("/delete-expired")
    @ResponseBody
    public ResponseEntity<?> deleteExpiredChatRooms() {
        chatRoomService.deleteExpiredChatRooms(); // 서비스에서 만료된 채팅방 삭제
        System.out.println("마감된 채팅방 삭제 완료.");
        return ResponseEntity.ok().build();
    }
    
    
}
