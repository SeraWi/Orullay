package com.bitcamp.orl.feed.controller;

import java.io.*;
import java.util.*;

import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import com.bitcamp.orl.feed.domain.*;
import com.bitcamp.orl.feed.service.*;
import com.bitcamp.orl.member.domain.*;

@Controller
@RequestMapping("/feed/feedmain")
public class FeedMainController {

	@Autowired
	private CreateFeedService createService;
	
	@Autowired
	private FeedListService listService;
	
	@RequestMapping(method = RequestMethod.GET)
	public String getFeedMain(
			Model model,
			HttpServletRequest request) {
		
		// 피드 인기순 정렬
	    List<NewFeedList> feedOrderByLike = listService.selectFeedOrderByLike();
	    model.addAttribute("feedOrderByLike",feedOrderByLike);
	    
	    //추가 (09.16.우리)
	    Member member = listService.getMember(request);
	    model.addAttribute("member", member);	//추가 (09.16.우리)
		
		return "feed/feedmain";
	}	
	
	@RequestMapping(method = RequestMethod.POST)
	public String postFeedMain(
			FeedCreateRequest feedrequest, 
			HttpServletRequest request,
			Model model)
			throws IllegalStateException, IOException {
		
		//작성 피드 insert
		createService.insert(feedrequest, request);
	    
		return "redirect:/feed/feedmain";
	}
	
}