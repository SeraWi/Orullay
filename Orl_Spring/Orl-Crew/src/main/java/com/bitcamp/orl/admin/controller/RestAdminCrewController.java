package com.bitcamp.orl.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bitcamp.orl.admin.domain.AdminCrewInfo;
import com.bitcamp.orl.crew.service.CrewListViewService;

@RestController
public class RestAdminCrewController {
	
	@Autowired
	private CrewListViewService service;
	
	@RequestMapping("/admin/crew/getAllInfo")
	@CrossOrigin
	public AdminCrewInfo getAllCrewList() {
		return new AdminCrewInfo(service.getCrewListAdmin(), service.getCrewRegList());
	}
	
	@RequestMapping("/admin/crew/deleteCrew")
	@CrossOrigin
	public int deleteCrew(@RequestParam("crewIdx")int crewIdx) {
		return service.deleteCrew(crewIdx);
	}
}
