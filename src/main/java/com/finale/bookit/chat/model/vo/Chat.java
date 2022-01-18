package com.finale.bookit.chat.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Chat implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private int no;
	private String memberId;
	private int srNo;
	private String chatContent;
	private Date sendDate;
	
	private String vaildYN;
	
	
}