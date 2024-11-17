package com.project.mapper;

import com.project.domain.ChatMessage;
import com.project.domain.ChatRoom;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatRoomMapper {
    //=================================================================
    // Use ChatRoom Domain 
    //=================================================================
	
	// 채팅방 저장
	void insertChatRoom(ChatRoom chatRoom);
    
	// 채팅방 목록 조회
	List<ChatRoom> getAllChatRooms();
	
	// 채팅방 삭제
    void deleteExpiredChatRooms();
    
    
    
    //=================================================================
    // Use ChatMessage Domain 
    //=================================================================
    
    // 메세지 저장
    void insertMessage(ChatMessage message);
    
    // 특정 채팅방 메세지 조회
    List<ChatMessage> findMessagesByRoomId(Long roomId);
}
