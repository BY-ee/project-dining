package com.project.service;

import java.util.List;

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
}
