package com.finale.bookit.member.model.dao;

import java.util.Map;

import com.finale.bookit.member.model.vo.Address;
import com.finale.bookit.member.model.vo.MemberEntity;

public interface MemberDao {

	int insertMember(MemberEntity member);

	MemberEntity selectOneMember(String id);

	int insertAddress(Address address);

	int memberUpdate(Map<String, Object> param);

	int selectOneMemberCount(String id);

	int selectOneMemberNicknameCount(String nickname);

}
