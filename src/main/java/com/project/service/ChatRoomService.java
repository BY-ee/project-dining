package com.project.service;

import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.project.mapper.ChatRoomMapper;
import com.project.domain.ChatRoom; 
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatRoomService {
	private final ChatRoomMapper chatRoomMapper;
	
	public void insertChatRoom(ChatRoom chatRoom) {
		chatRoomMapper.insertChatRoom(chatRoom);
	}
	
	public List<ChatRoom> getAllChatRooms(){
		return chatRoomMapper.getAllChatRooms();
	}
	
    public void deleteExpiredChatRooms() {
        chatRoomMapper.deleteExpiredChatRooms();
    }
    
    @Scheduled(cron = "0 * * * * ?") 
    public void deleteExpiredChatRoomsDaily() {
        System.out.println("마감일이 지난 채팅방 삭제 작업 실행 중...");
        this.deleteExpiredChatRooms(); // 자기 자신 주입 대신 메서드 직접 호출
        System.out.println("마감일이 지난 채팅방이 삭제되었습니다.");
    }
}
