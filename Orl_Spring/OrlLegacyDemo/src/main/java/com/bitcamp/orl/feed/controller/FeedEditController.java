package com.bitcamp.orl.feed.controller;

import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import com.bitcamp.orl.feed.domain.*;
import com.bitcamp.orl.feed.service.*;
import com.bitcamp.orl.member.domain.*;

@Controller
@RequestMapping("/feed/feededit/{memberIdx}&{boardIdx}")
public class FeedEditController {
	
	@Autowired
	private FeedViewService viewService;
	
	@Autowired
	private UserFeedService feedService;
	
	// 수정 페이지 보여주기
	@RequestMapping(method = RequestMethod.GET)
	public String getFeedEdit(
			@PathVariable("memberIdx") int memberIdx,
			@PathVariable("boardIdx") int boardIdx,
			HttpServletRequest request,
			Model model
			) {
		
		String feedpath = null;
		
		//session에 저장된 memberIdx
		int myIdx = ((MemberDto) request.getSession().getAttribute("memberVo")).getMemberIdx();
		//memberIdx에 해당하는 member객체 찾기
		Member member = feedService.getOneMember(memberIdx);
		
		int feedChk = viewService.selectFeedChk(memberIdx, boardIdx);
		System.out.println("feedChk : "+feedChk);
		
		if(feedChk != 0) {
			//session memberIdx == pathvariable memberIdx
			if(myIdx==memberIdx && member!=null) {
				
				int likeStatus = viewService.getLikeStatus(myIdx, boardIdx);
				
				// 수정할 피드 정보가져오기
				FeedView feedview = viewService.getFeedView(boardIdx);
				
				//모델에 전달
				// 피드 정보
				model.addAttribute("selectFeedView", viewService.getFeedView(boardIdx));
				// 좋아요 상태
				model.addAttribute("likeStatus", likeStatus);
				
				feedpath = "/feed/feedEdit";
				
			} else {
				//member 객체 없을경우
				throw new NullPointerException();
			} 
			
		} else {
			throw new NullPointerException();
		}
		
		return feedpath;
	}
	// 수정하기 누르고 나서 
	@RequestMapping(method = RequestMethod.POST)
	public String postFeedEdit(
			@PathVariable("boardIdx") int boardIdx,
			@PathVariable("memberIdx") int memberIdx,
			FeedEdit feedEdit,
			HttpServletRequest request,
			Model model
			) {
		
		// 피드 수정
		viewService.editFeed(boardIdx, feedEdit, request);
		model.addAttribute("boardDiscription", feedEdit.getBoardDiscription());
		model.addAttribute("hashtag", feedEdit.getHashtag());
		model.addAttribute("tag", feedEdit.getTag());
		
		// 피드 상세보기 (피드 수정 후)
		FeedView feedview = viewService.getFeedView(boardIdx);
		model.addAttribute("selectFeedView", viewService.getFeedView(boardIdx));
		
		// 좋아요
		int myIdx = ((MemberDto) request.getSession().getAttribute("memberVo")).getMemberIdx();
		int likeStatus = viewService.getLikeStatus(myIdx, boardIdx);
		int totalLikeCount = viewService.getTotalLikeCount(boardIdx);
		model.addAttribute("likeStatus", likeStatus);
		model.addAttribute("totalLikeCount", totalLikeCount);
		
		//수정완료 후 피드 상세보기로 이동
		return "redirect:/feed/feedview/"+memberIdx+"&"+boardIdx;

	}
	
	@ExceptionHandler(NullPointerException.class)
	public String handleNullPointerException(NullPointerException e) {

		e.printStackTrace();
		return "error/pageNotFound";
		
	}
	
}
