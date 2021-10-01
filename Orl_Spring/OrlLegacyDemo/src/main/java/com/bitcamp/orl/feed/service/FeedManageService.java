package com.bitcamp.orl.feed.service;

import java.io.*;
import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.bitcamp.orl.feed.dao.*;
import com.bitcamp.orl.feed.domain.*;

@Service
public class FeedManageService {
	
	FeedDao dao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	//추가 (09.22.우리)
	//nickname으로 memberIdx 찾기
	public int selectIdx(String memberNickname) {
		
		int result = 0;
		
		dao = template.getMapper(FeedDao.class);
		result = dao.selectMemberIdx(memberNickname);
		//memberIdx 반환
		
		System.out.println("service in!!!!");
		
		return result;
	}
	
	//추가 (09.18.우리)
	//닉네임 중복 체크
	public String nicknameCheck(String memberNickname) {
		
		String result = "N";
		
		dao = template.getMapper(FeedDao.class);
		
		if(dao.selectNickname(memberNickname)>0) {
			result="Y";	//존재하는 닉네임
		}
		System.out.println("service : " + memberNickname + ", " + result);
		
		return result;
	}
	
	//수정 (09.18.우리)
	//피드 삭제
	public int deleteFeed(int memberIdx, int boardIdx) {
			
		int result = 0;		
		
		dao = template.getMapper(FeedDao.class);
				
		selectFile(boardIdx).delete();	//피드 사진 삭제
		result = dao.deleteFeed(memberIdx, boardIdx); //피드 삭제
		
		return result;
	}
	
	//추가 (09.18.우리)
	//피드 업로드 파일 선택
	public File selectFile(
			int boardIdx
			) {
		
		dao = template.getMapper(FeedDao.class);
		String path = "//Users//apple//Desktop//Documents//java205//spring_project//.metadata//.plugins//org.eclipse.wst.server.core//tmp0//wtpwebapps//Orl//images//feed//feedw//uploadfile";
		
		File Dir = new File(path);
		File file = null;
		Feed feed = dao.selectFeed(boardIdx);
		try {
			String boardPhoto = feed.getBoardPhoto();
			file = new File(Dir, boardPhoto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return file;
		
	}
	
	//피드 댓글 삭제
	public int deleteComment(int boardCommentIdx) {
			
		int result = 0;
			
		dao = template.getMapper(FeedDao.class);
		result = dao.deleteComment(boardCommentIdx);
			
		return result;
	}
	
	//피드 리스트 (최신순)
	public List<NewFeedList> selectNewFeed(){
		
		System.out.println("FeedManageService - New Feed List");
		List<NewFeedList> newList = null;
		
		dao = template.getMapper(FeedDao.class);
		newList = dao.selectNewFeed();
		
		System.out.println("manage service load");
		
		return newList;
		
	}
	
	//댓글 리스트
	public List<FeedComment> selectFeedComment(int boardIdx) {
		
		System.out.println("FeedManageService - selectFeedComment in");
		List<FeedComment> feedComments = null;
		
		dao = template.getMapper(FeedDao.class);
		feedComments = dao.selectFeedComment(boardIdx);
		
		System.out.println("manage service load 댓글");
		
		return feedComments;
	}
	
	

    // 산별 피드보기 (용민 작성)
    public List<NewFeedList> getNewFeedByMountain(String mName) {
		System.out.println("FeedManageService - New Feed List");
		List<NewFeedList> newList = null;

		dao = template.getMapper(FeedDao.class);
		newList = dao.selectNewFeedByMountain(mName);

		System.out.println("manage service load");

		return newList;

	}
}
