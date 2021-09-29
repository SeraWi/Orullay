package com.bitcamp.orl.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bitcamp.orl.admin.domain.AdminMemberInfo;
import com.bitcamp.orl.admin.service.RestAdminMemberService;

@RestController
public class RestAdminMemberController {

	@Autowired
	private RestAdminMemberService service;
	
	@CrossOrigin
	@RequestMapping("/admin/member/getAllInfo")
	public AdminMemberInfo getAllMemberList() {
		return new AdminMemberInfo(service.getMemberList(),service.selectAllFeed());
	}
	
	
	@RequestMapping("/admin/member/deleteMember")
	@CrossOrigin
	public int deleteCrew(@RequestParam("memberIdx")int memberIdx) {
		return service.deleteMember(memberIdx);
	}
	
	
}
