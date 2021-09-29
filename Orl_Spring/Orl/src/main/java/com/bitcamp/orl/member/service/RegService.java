package com.bitcamp.orl.member.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.orl.member.dao.Dao;
import com.bitcamp.orl.member.domain.Member;
import com.bitcamp.orl.member.domain.MemberRequest;
import com.bitcamp.orl.member.util.AES256Util;

@Service
public class RegService {
	
	private Dao dao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	//암호화처리
	@Autowired
	private AES256Util aes256Util; 
	
	
	public int reg(MemberRequest memberRequest) {
		
		int resultCnt=0;
		
		Member member= new Member();
		
		try {
			member.setMemberId(memberRequest.getMemberId());
	        member.setMemberName(memberRequest.getMemberName());
	        member.setMemberEmail(memberRequest.getMemberEmail());
	        member.setMemberNickname(memberRequest.getMemberNickname());
			member.setMemberBirth(memberRequest.getMemberBirth());
			
			
			
			
			// AES256 으로 암호화된 문자열 : insert or update
			String epw = aes256Util.encrypt(memberRequest.getMemberPw());
			 member.setMemberPw(epw);
			 dao =template.getMapper(Dao.class);
			// AES256으로 복호화된 문자열 : select
			String ppw = aes256Util.decrypt(epw);
			
			System.out.println("---------------------");
			System.out.println("AES256 으로 암호화된 문자열");
			System.out.println(epw);
			System.out.println("AES256으로 복호화된 문자열");
			System.out.println(ppw);
			
			
			
			resultCnt=dao.insertMember(member);
			
			
		
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		return resultCnt;
	}
	
	public int regNaver(Member member) {
		
		int resultCnt=0;
		
		dao = template.getMapper(Dao.class);
			
		resultCnt=dao.insertMember(member);
			
		
		return resultCnt;
	}
}
