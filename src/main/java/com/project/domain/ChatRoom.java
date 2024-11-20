package com.project.domain;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("chatroom")
public class ChatRoom {
    private Long id;   
    private Long chatRoomId;// 고유 방 ID
    private Long memberId;                // 방장의 member ID
    private String roomName;              // 채팅방 제목
    private String location;              // 지역
    private Integer maxParticipants;      // 정원
    private Integer minParticipants;      // 최소 인원
    private String theme;                 // 테마
    private Integer recruitmentDuration;  // 모집 기간 (분 단위)
    private Date recruitmentDeadline;     // 모집 마감 일시
    private String additionalDescription; // 추가 설명
    private String status;                // 모집 상태
    private Date createdAt;               // 생성일
    private String password;              // 비밀번호 (선택)
    private String creatorNickname;       // m.nickname 매핑
    private Date joinedAt;               // 유저 참여 시간
    private int currentParticipants; // 참여 총인원 추가
    private String lastMessage;           // 마지막 메시지 내용
    private Date lastMessageSentAt;       // 마지막 메시지 전송 시간
}