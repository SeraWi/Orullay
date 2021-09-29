package com.bitcamp.orl.feed.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.web.bind.annotation.*;

import com.bitcamp.orl.feed.domain.*;
import com.bitcamp.orl.feed.service.*;

@RestController
public class FeedRestController {
	
	@Autowired
	FeedManageService manageService;
	
	//피드 삭제
	@RequestMapping("/feed/feedview/deletefeed/{memberIdx}&{boardIdx}")
	@CrossOrigin
	public int deleteFeed(
		@PathVariable("memberIdx") int memberIdx,
		@PathVariable("boardIdx") int boardIdx
		) {
		
		int result = 0;
		
		result = manageService.deleteFeed(memberIdx, boardIdx);
		System.out.println("삭제 피드 : " + boardIdx);
		
		return result;
	}	
	
	//피드 댓글 삭제
	@RequestMapping("/feed/feedview/deletecomment/{boardCommentIdx}&{boardIdx}")
	@CrossOrigin
	public List<FeedComment> deleteComment(
			@PathVariable("boardCommentIdx") int boardCommentIdx,
			@PathVariable("boardIdx") int boardIdx
			) {
		
		manageService.deleteComment(boardCommentIdx);
		
		System.err.println("삭제 댓글 : " + boardCommentIdx);
		List<FeedComment> feedComment = manageService.selectFeedComment(boardIdx);
		
		return feedComment;
	}
	
	//피드 리스트 (최신순)
	@RequestMapping("/feed/feedmain/selectNewFeed")
	@CrossOrigin
	public List<NewFeedList> newFeedList (){
		
		List<NewFeedList> feedlist = manageService.selectNewFeed();
		System.out.println("rest controller =>" + feedlist);
		
		return feedlist;
	}
	
	//댓글 리스트
	@GetMapping("/feed/feedview/selectcomment")
	@CrossOrigin
	public List<FeedComment> selectComments(
			@RequestParam("boardIdx") int boardIdx
			) {
		
		List<FeedComment> feedComment = manageService.selectFeedComment(boardIdx);
		System.out.println("rest controller => "+feedComment);
		
		return feedComment;
		
	}

	//추가 (09.18.우리)
	//닉네임 중복 체크
	@GetMapping("/feed/createfeed/nicknameCheck")
	@CrossOrigin
	public String nicknameCheck(
			@RequestParam("memberNickname") String memberNickname
			) {
		
		String result = null;
		result = manageService.nicknameCheck(memberNickname);
		//닉네임 있으면 Y / 없으면 N 반환
		
		return result;
		
	}
	
	//추가 (09.22.우리)
	//memberNickname으로 memberIdx 찾기
	@GetMapping("/feed/feedview/memberIdxCheck")
	@CrossOrigin
	public int memberIdxCheck(
			@RequestParam("memberNickname") String memberNickname
			) {
		
		int result = 0;
		result = manageService.selectIdx(memberNickname);
		
		System.out.println("restcontroller in!!!!");
		
		return result;
		
	}
	
	
}