package com.project.mapper;

import com.project.domain.ChatRoom;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatRoomMapper {
	void insertChatRoom(ChatRoom chatRoom);
    List<ChatRoom> getAllChatRooms(); // 채팅방 목록 조회
}
