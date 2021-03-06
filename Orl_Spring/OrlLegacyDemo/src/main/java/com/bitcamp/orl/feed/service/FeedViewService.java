package com.bitcamp.orl.feed.service;

import javax.servlet.http.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.bitcamp.orl.feed.dao.*;
import com.bitcamp.orl.feed.domain.*;
import com.bitcamp.orl.member.domain.*;

@Service
public class FeedViewService {

	private FeedDao dao;

	@Autowired
	private SqlSessionTemplate template;

	// 피드 상세보기
	public FeedView getFeedView(int boardIdx) {

		FeedView feedview = null;

		dao = template.getMapper(FeedDao.class);
		feedview = dao.selectFeedView(boardIdx);

		return feedview;
		
	}

	// 피드 수정
	public int editFeed(
			int boardIdx,
			FeedEdit feedEdit,
			HttpServletRequest request) {

		int result = 0;

		dao = template.getMapper(FeedDao.class);
		result = dao.editFeed(
				feedEdit.getBoardDiscription(),
				feedEdit.getHashtag(),
				feedEdit.getTag(),
				boardIdx);

		return result;

	}
	
	//피드 댓글 작성 (우리- 기존코드)
//	public int insertComment(FeedCommentRequest commentRequest, HttpServletRequest request) {
//
//		int result = 0;
//			
//		try {
//				
//			FeedComment feedComment = commentRequest.toFeedComment();
//				
//			MemberDto memberVo = (MemberDto)(request.getSession().getAttribute("memberVo"));
//				
//			//로그인한 상태
//			if(memberVo != null) {
//				// 세션에 있는memberIdx로 세팅
//				feedComment.setMemberIdx(memberVo.getMemberIdx());
//			}
//
//			dao = template.getMapper(FeedDao.class);
//			result = dao.insertFeedComment(feedComment);
//				
//			System.out.println(feedComment);
//				
//		} catch (Exception e) {
//			e.printStackTrace();
//			System.out.println("예외발생");
//		}
//
//		return result;
//
//	}
	
	// 피드 댓글 작성(세라 수정)
	// 기존에 command객체로 받던 정보를 하나씩 받음 (게시물 idx, 댓글, request)
	public int insertComment(int boardIdx, String comment, HttpServletRequest request) {

		int result = 0;
			
		try {
			//세션에 저장된 정보
			MemberDto memberVo = (MemberDto)(request.getSession().getAttribute("memberVo"));
			
			int memberIdx = 0;
			//로그인한 상태
			if(memberVo != null) {
				// 세션에 있는memberIdx가져오기
				memberIdx = memberVo.getMemberIdx();
			}
			dao = template.getMapper(FeedDao.class);
			result = dao.insertFeedComment(comment,boardIdx,memberIdx);
				
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("예외발생");
		}

		return result;

	}
	
	
	// 추가 (09.25.우리)
	//피드 존재 여부 체크
	public int selectFeedChk(int memberIdx, int boardIdx) {
		
		int result = 0;
		
		dao = template.getMapper(FeedDao.class);
		result = dao.selectFeedChk(memberIdx, boardIdx);
		
		return result;
	}

	// 3) 좋아요 상태인지 아닌지 확인 (세라 추가)
	public int getLikeStatus(int myIdx, int boardIdx) {
		
		int likeStatus = 0;

		dao = template.getMapper(FeedDao.class);
		likeStatus = dao.selectLikeStatus(myIdx, boardIdx);

		return likeStatus;
	}

	// 4) 좋아요 갯수 가져오기 (세라 추가)
	public int getTotalLikeCount(int boardIdx) {

		int totalLikeCount = 0;

		dao = template.getMapper(FeedDao.class);
		totalLikeCount = dao.selectTotalLikeCount(boardIdx);

		return totalLikeCount;
	}

}
