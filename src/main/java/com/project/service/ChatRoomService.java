package com.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.project.mapper.ChatRoomMapper;
import com.project.domain.ChatMessage;
import com.project.domain.ChatRoom; 
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatRoomService {
	private final ChatRoomMapper chatRoomMapper;
	
    //=================================================================
    // Use ChatRoom Domain 
    //=================================================================
	
    public Long createChatRoom(ChatRoom chatRoom) {
    	chatRoomMapper.insertChatRoom(chatRoom);
        Long chatRoomId = chatRoomMapper.selectLastInsertedId(chatRoom.getMemberId());        
        return chatRoomId; 
    }
    
    public void addUserToChatRoom(Long chatRoomId, Long userId) {
        Map<String, Object> params = new HashMap<>();
        params.put("chatRoomId", chatRoomId);
        params.put("userId", userId);

        chatRoomMapper.insertChatRoomUser(params);
    }
    
    // 특정 채팅방의 현재 참여 인원 수 조회
    public int getChatRoomUserCount(Long chatRoomId) {
        return chatRoomMapper.getChatRoomUserCount(chatRoomId);
    }

    // 특정 채팅방 최대 참여 인원 조회
    public int getChatRoomMaxParticipants(Long chatRoomId) {
        return chatRoomMapper.getChatRoomMaxParticipants(chatRoomId);
    }
	
    // 모든 체팅방 목록을 조회
	public List<ChatRoom> getAllChatRooms(){
		return chatRoomMapper.getAllChatRooms();
	}
	
	// 채팅방 강제 삭제 필요시 사용
    public void deleteExpiredChatRooms() {
        chatRoomMapper.deleteExpiredChatRooms();
    }
    
    public boolean isUserInRoom(Long chatRoomId, Long userId) {
    	return chatRoomMapper.isUserInRoom(chatRoomId, userId);
    }
    
    @Scheduled(cron = "0 * * * * ?") 
    public void deleteExpiredChatRoomsDaily() {
        System.out.println("마감일이 지난 채팅방 삭제 작업 실행 중...");
        this.deleteExpiredChatRooms(); // 자기 자신 주입 대신 메서드 직접 호출
        System.out.println("마감일이 지난 채팅방이 삭제되었습니다.");
    }
    
    public List<ChatRoom> getChatRoomsByUser(Long userId){
    	return chatRoomMapper.getChatRoomsByUserId(userId);
    }
    
    public List<ChatRoom> searchChatRooms(String location, String industry, String subCategory, List<String> themes) {
        return chatRoomMapper.findChatRoomsByFilters(location, industry, subCategory, themes);
    }
    
    
    //=================================================================
    // Use ChatMessage Domain 
    //=================================================================
    
    // 메시지 저장
    public void saveMessage(ChatMessage message) {
    	chatRoomMapper.insertMessage(message);
    }

    // 특정 채팅방 메시지 조회
    public List<ChatMessage> getMessagesByRoomId(Long roomId) {
        return chatRoomMapper.findMessagesByRoomId(roomId);
    }
}
