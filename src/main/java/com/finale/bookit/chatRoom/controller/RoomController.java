package com.finale.bookit.chatRoom.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finale.bookit.chatRoom.model.service.ChatRoomService;
import com.finale.bookit.chatRoom.model.vo.ChatRoom;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping(value = "/chatroom")
public class RoomController {

	@Autowired
	private ChatRoomService service;

	
	// 채팅방 목록 조회
	@GetMapping(value = "/list")
	public ModelAndView rooms(@RequestParam String loginMember) {
		

        ModelAndView mv = new ModelAndView("chat/chatMain");
        List<ChatRoom> result = service.findAllRooms(loginMember);
        
        for(ChatRoom room : result) {
        	String memberId = room.getMemberId();
        	
        	memberId = memberId.replace(loginMember, "");
        	memberId = memberId.replace(",","");
        	
        	room.setMemberId(memberId);
        	
        	log.debug("newId = {}",room.getMemberId());
        	
        	
        }
        log.debug("list = {}", result);
        mv.addObject("list", result);
        
        return mv;
	}
	 //채팅방 개설
    @PostMapping(value = "/create")
    public String create(@RequestParam("name") String name,@RequestParam("loginMember") String loginMember,RedirectAttributes rttr){

    
        
        StringBuilder sb = new StringBuilder();
        sb.append(name);
        sb.append(",");
        sb.append(loginMember);
        
        String chatParticipants = sb.toString();
        log.debug("chatParticipants = {}",chatParticipants);
        
        int result = service.createChatRoom(chatParticipants);
        
    
        
        return "redirect:/chatroom/list?loginMember="+loginMember;
    }
    
    
    // 채팅방 조회
    @GetMapping("/detail.do")
    public void getRoom(@RequestParam String id,Model model) {
    	
    	log.debug("id = {}",id);
    	
    	model.addAttribute("chatRoom", service.findRoomById(id));
    }
}
