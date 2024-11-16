package com.project.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatMessage {
    private String sender;      // 메시지 보낸 사람
    private String content;     // 메시지 내용
    private String timestamp;   // 메시지 전송 시간
    private String roomId;
}
