package com.bitcamp.orl.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdminCrewController {

	@RequestMapping("/admin/crew")
	public String CrewList() {
		
		return "admin/admin_crew";
	}
	
}
