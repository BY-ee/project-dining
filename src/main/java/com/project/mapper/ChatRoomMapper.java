package com.project.mapper;

import com.project.domain.ChatMessage;
import com.project.domain.ChatRoom;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ChatRoomMapper {
    //=================================================================
    // Use ChatRoom Domain 
    //=================================================================
	
	// 채팅방 저장
    void insertChatRoom(ChatRoom chatRoom);
	
    int getChatRoomUserCount(Long chatRoomId);
    
    int getChatRoomMaxParticipants(Long chatRoomId);
    
    void insertChatRoomUser(Map<String, Object> params);
    
    void deleteChatRoomUser(Map<String, Object> params);
    
    Long selectLastInsertedId(@Param("memberId") Long memberId);
    
    boolean isUserInRoom(@Param("chatRoomId") Long chatRoomId, @Param("userId") Long userId);
    
	// 채팅방 목록 조회
	List<ChatRoom> getAllChatRooms();
	
	// 채팅방 삭제
    void deleteExpiredChatRooms();
    
    // 참여중인 채팅방 목록 조회
    List<ChatRoom> getChatRoomsByUserId(@Param("userId") Long userId);
    
    
    
    //=================================================================
    // Use ChatMessage Domain 
    //=================================================================
    
    // 메세지 저장
    void insertMessage(ChatMessage message);
    
    // 특정 채팅방 메세지 조회
    List<ChatMessage> findMessagesByRoomId(Long roomId);
}
