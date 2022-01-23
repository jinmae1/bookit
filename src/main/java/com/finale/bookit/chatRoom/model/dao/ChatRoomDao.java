package com.finale.bookit.chatRoom.model.dao;

import java.util.List;

import com.finale.bookit.chatRoom.model.vo.ChatRoom;

public interface ChatRoomDao {

	int createChatRoom(String chatParticipants);

	List<ChatRoom> findAllRooms(String loginMember);

	ChatRoom findRoomById(String id);

}
