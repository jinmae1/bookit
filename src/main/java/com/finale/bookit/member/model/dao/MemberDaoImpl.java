package com.finale.bookit.member.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finale.bookit.member.model.vo.Address;
import com.finale.bookit.member.model.vo.MemberEntity;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public int insertMember(MemberEntity member) {
		return session.insert("member.insertMember", member);
	}

	@Override
	public MemberEntity selectOneMember(String id) {
		return session.selectOne("member.selectOneMember", id);
	}

	@Override
	public int insertAddress(Address address) {
		return session.insert("member.insertAddress", address);
	}

	@Override
	public int memberUpdate(Map<String, Object> param) {
		return session.update("member.memberUpdate", param);
	}

	@Override
	public int selectOneMemberCount(String id) {
		return session.selectOne("member.selectOneMemberCount", id);
	}

	@Override
	public int selectOneMemberNicknameCount(String nickname) {
		return session.selectOne("member.selectOneMemberNicknameCount", nickname);
	}

}
