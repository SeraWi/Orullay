package com.bitcamp.orl.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdminFeedController {

	@RequestMapping("/admin/feed")
	public String FeedList() {
		
		return "admin/admin_feed";
	}
	
	
}
