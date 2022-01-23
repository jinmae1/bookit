package com.finale.bookit.chatRoom.model.service;

import java.util.List;

import com.finale.bookit.chatRoom.model.vo.ChatRoom;

public interface ChatRoomService {

	int createChatRoom(String chatParticipants);

	List<ChatRoom> findAllRooms(String loginMember);

	ChatRoom findRoomById(String id);

	
}
