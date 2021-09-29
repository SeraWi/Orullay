package com.bitcamp.orl.crew.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bitcamp.orl.crew.domain.CrewInfo;
import com.bitcamp.orl.crew.service.CrewDetailService;

@RestController
public class RestCrewDetailController {
	
	@Autowired
	private CrewDetailService service;
	
	@RequestMapping("/crew/getCrewInfo")
	@CrossOrigin
	public CrewInfo getCrewInfo(
			@RequestParam(value="memberIdx", required = false, defaultValue = "0")int memberIdx,
			@RequestParam("crewIdx")int crewIdx
			) {
		CrewInfo info = null;
		info = service.getCrewInfo(memberIdx, crewIdx);
		return info;
	}
}
