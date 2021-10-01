package com.bitcamp.orl.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bitcamp.orl.member.service.MemberDeleteService;

@Controller
public class MemberDeleteController {

    @Autowired
    private MemberDeleteService service;


    @RequestMapping("/member/delete")
    public String MemberUnreg(HttpServletRequest request, Model model) {

        model.addAttribute("idx",request.getParameter("memberIdx"));
        int memberIdx= Integer.parseInt(request.getParameter("memberIdx"));
        int result =service.deleteMember(memberIdx,request);
        model.addAttribute("result",result);

        return "member/memberDelete";
    }
}