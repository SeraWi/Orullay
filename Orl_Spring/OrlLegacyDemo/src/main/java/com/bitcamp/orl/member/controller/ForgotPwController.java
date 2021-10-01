package com.bitcamp.orl.member.controller;

import javax.servlet.http.HttpServletRequest;

import com.bitcamp.orl.member.domain.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bitcamp.orl.member.service.ForgotPwService;

@Controller
@RequestMapping("/member/forgotPw")
public class ForgotPwController {

	@Autowired
	private ForgotPwService service;


	@RequestMapping(method = RequestMethod.GET)
	public String getForgotPw() {
		return "member/forgotPw";
	}



	@RequestMapping(method = RequestMethod.POST)
	public String getFindPw(HttpServletRequest request, Model model,
							@RequestParam("memberId") String memberId,
							@RequestParam("memberName") String memberName,
							@RequestParam("memberEmail") String memberEmail) {

		Member member= service.FindPw(request,memberId, memberName, memberEmail);
		String newPw = null;
		int checkNum = 0;
		try {
			newPw = service.getRamdomPassword(member.getMemberPw());
			checkNum = service.mailSender(member, newPw);
		}catch (NullPointerException e){
			System.out.println("null");
			e.printStackTrace();
		}

		model.addAttribute("findPw",newPw);
		model.addAttribute("checkNum",checkNum);



		return "member/findPw";
	}



}
