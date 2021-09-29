package com.bitcamp.orl.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bitcamp.orl.admin.service.RestAdminFeedService;
import com.bitcamp.orl.feed.domain.FeedView;

@RestController
public class RestAdminFeedController {
	
	@Autowired
	private RestAdminFeedService service;
	
	@CrossOrigin
	@RequestMapping("/admin/feed/getAllInfo")
	public List<FeedView> getAllFeedList() {
		return service.selectAllFeed();
	}
	@RequestMapping("/admin/crew/deleteFeed")
	@CrossOrigin
	public int deleteCrew(@RequestParam("boardIdx")int boardIdx) {
		return service.getDeleteFeed(boardIdx);
	}
	
}
