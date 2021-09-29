package com.bitcamp.orl.feed.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.bitcamp.orl.feed.domain.FeedCommentRequest;
import com.bitcamp.orl.feed.domain.FeedEdit;
import com.bitcamp.orl.feed.service.*;
import com.bitcamp.orl.member.domain.*;

@Controller
public class FeedViewController {
	
	@Autowired
	private FeedViewService viewService;
	
	@Autowired
	private UserFeedService feedService;

	@RequestMapping("/feed/feedview/{memberIdx}&{boardIdx}")
	public String getFeedView(
			@PathVariable("memberIdx") int memberIdx,
			@PathVariable("boardIdx") int boardIdx,
			HttpServletRequest request,
			Model model) {
		
		String feedpath = null;
		
		//memberIdx
		int myIdx = ((MemberDto) request.getSession().getAttribute("memberVo")).getMemberIdx();
		//피드 존재여부 체크
		int feedChk = viewService.selectFeedChk(memberIdx, boardIdx);
		
		if(feedChk != 0) {
			
			//피드 상세
			model.addAttribute("selectFeedView", viewService.getFeedView(boardIdx));
			model.addAttribute("boardMemberIdx", memberIdx);

			//좋아요
			int likeStatus = viewService.getLikeStatus(myIdx, boardIdx);
			int totalLikeCount = viewService.getTotalLikeCount(boardIdx);
			model.addAttribute("totalLikeCount", totalLikeCount);
			model.addAttribute("likeStatus", likeStatus);
			
			feedpath = "/feed/feedview";
			
		} else {
			throw new NullPointerException();
		}
		
		return feedpath;
		
	}

	@RequestMapping(value="/feed/feedview/{memberIdx}&{boardIdx}", method = RequestMethod.POST)
	public String postFeedView(
			@PathVariable("memberIdx") int memberIdx,
			@PathVariable("boardIdx") int boardIdx,
			FeedCommentRequest commentRequest,
			HttpServletRequest request,
			Model model) {
		
		// 댓글 작성 insert
		viewService.insertComment(commentRequest, request);

		return "redirect:/feed/feedview/"+memberIdx+"&"+boardIdx;
	}
	
	@ExceptionHandler(NullPointerException.class)
	public String handleNullPointerException(NullPointerException e) {

		e.printStackTrace();
		return "error/pageNotFound";
		
	}

}