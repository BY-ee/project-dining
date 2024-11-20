package com.project.domain;

import java.util.Date;
import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("chatroomuser")
public class ChatRoomUser {
    private Long chatRoomId; // 채팅방 ID
    private Long userId;     // 유저 ID
    private Date joinedAt;   // 참여 시간
}