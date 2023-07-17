package org.zerock.mapper;

import org.zerock.domain.Member;

public interface MemberMapper {
	
	public Member selectMemberaslogin(String id);
	
	public Member selectMember(String id);
	
	public void insertMember(Member member);
	
	public void updateMember(Member member);
	
	public void deleteMember(String id);

}
