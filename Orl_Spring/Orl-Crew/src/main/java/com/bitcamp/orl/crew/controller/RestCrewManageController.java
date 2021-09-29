package com.bitcamp.orl.crew.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bitcamp.orl.crew.domain.CrewEditInfo;
import com.bitcamp.orl.crew.domain.CrewInfo;
import com.bitcamp.orl.crew.domain.CrewInsertRequest;
import com.bitcamp.orl.crew.service.CrewDetailService;
import com.bitcamp.orl.crew.service.CrewManageService;

@RestController
public class RestCrewManageController {

	@Autowired
	private CrewManageService service;

	@Autowired
	private CrewDetailService detailService;

	@RequestMapping("/crew/edit/getcrewinfo")
	@CrossOrigin
	public CrewEditInfo editCrewForm(
			@RequestParam("crewIdx") int crewIdx, 
			@RequestParam("memberIdx") int memberIdx) {
		boolean chk = service.isHaveAuth(crewIdx, memberIdx);
		CrewInfo crewinfo = detailService.getCrewInfo(memberIdx, crewIdx);

		return new CrewEditInfo(chk, crewinfo, 0);
	}

	@PostMapping("/crew/edit/editcrew")
	@CrossOrigin
	public CrewEditInfo editCrew(
			CrewInsertRequest crewRequest
			) {
		boolean chk = service.isHaveAuth(crewRequest.getCrewIdx(), crewRequest.getMemberIdx());
		CrewInfo info = detailService.getCrewInfo(crewRequest.getMemberIdx(), crewRequest.getCrewIdx());
		int result = service.updateCrew(crewRequest, crewRequest.getCrewIdx());
		
		return new CrewEditInfo(chk, info, result);
	}
	
	@RequestMapping("/crew/remove/removecrew")
	@CrossOrigin
	public CrewEditInfo crewRemove(
			@RequestParam("crewIdx")int crewIdx,
			@RequestParam("crewName")String crewName,
			@RequestParam("memberIdx")int memberIdx
			) {
		boolean chk = service.isHaveAuth(crewIdx, memberIdx);
		CrewInfo info = detailService.getCrewInfo(memberIdx, crewIdx);
		int result = service.deleteCrew(crewIdx, crewName);
		
		return new CrewEditInfo(chk, info, result);
	}
}
