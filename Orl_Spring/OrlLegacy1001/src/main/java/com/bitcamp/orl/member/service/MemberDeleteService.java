package com.bitcamp.orl.member.service;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.orl.member.dao.Dao;
import com.bitcamp.orl.member.domain.Member;

@Service
public class MemberDeleteService {

		final String PROFILE_URI ="/images/member/profile";

	
		//멤버의 Dao
		private Dao dao;
		
		@Autowired
		private SqlSessionTemplate template;
		
		 //멤버 삭제하기
	    public int deleteMember(int memberIdx, HttpServletRequest request) {
	    	if(selectThatFile(memberIdx,request) != null) {
	    		selectThatFile(memberIdx,request).delete();
	    	}
	        return template.getMapper(Dao.class).deleteMember(memberIdx);
	    }
	    
	    public File selectThatFile(int memberIdx, HttpServletRequest request) {
	    	dao = template.getMapper(Dao.class);
	    	Member member = dao.selectByIdx(memberIdx);
	    	String fileName = member.getMemberProfile();
	    	String dirpath = request.getSession().getServletContext().getRealPath(PROFILE_URI);
	    	
	    	File thatFile = null;
	    	if(!fileName.equals("default.jpg")) {
	    		thatFile = new File(dirpath, fileName);
	    	}
	    	return thatFile;
	    }
}
