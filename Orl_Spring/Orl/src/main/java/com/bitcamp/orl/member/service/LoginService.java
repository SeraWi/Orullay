package com.bitcamp.orl.member.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.orl.member.dao.Dao;
import com.bitcamp.orl.member.domain.Member;
import com.bitcamp.orl.member.domain.MemberDto;
import com.bitcamp.orl.member.util.AES256Util;
import com.bitcamp.orl.member.util.CookieBox;

@Service
public class LoginService {
   
   private Dao dao;
   
   @Autowired
   private SqlSessionTemplate template;
   
   //암호화처리코드
   @Autowired
	private AES256Util aes256Util; 
   
   boolean loginChk;

   public boolean login(
         HttpServletRequest request, 
         HttpServletResponse response,
         String memberId,
         String memberPw,
         String reid
         ) {
      
      cookieChk(response, reid, memberId);
      loginChk=false;
      
      dao = template.getMapper(Dao.class);
      Member member=null;
      if (memberId != null && memberPw != null && memberId.trim().length() > 2 && memberPw.trim().length() > 2) {
    	 try {
			memberPw = aes256Util.encrypt(memberPw);
			member = dao.selectByIdPw(memberId, memberPw);
			if (member != null) {
				MemberDto  memberVo= member.memberToMemberVo();
				request.getSession().setAttribute("memberVo", memberVo);
				loginChk = true;
			}
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
      }
      return loginChk;
   }
   
   
   public boolean naverLogin(
	         HttpServletRequest request, 
	         String memberId,
	         String memberPw
	         ) {
	      
	      loginChk=false;
	      
	      dao = template.getMapper(Dao.class);
	      Member member=null;
	      if (memberId != null && memberPw != null && memberId.trim().length() > 2 && memberPw.trim().length() > 2) {
	    	  try {
				memberPw = aes256Util.encrypt(memberPw);
				System.out.println(memberPw);
				member = dao.selectByIdPw(memberId, memberPw);
				if (member != null) {
					MemberDto  memberVo= member.memberToMemberVo();
					request.getSession().setAttribute("memberVo", memberVo);
					loginChk = true;
				}
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (GeneralSecurityException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	      }
	      return loginChk;
	   }
   
   
   
   
   
   public void cookieChk(HttpServletResponse response, String reid, String id) {

      if (reid != null && reid.equals("on")) {
         // 쿠키 저장: 사용자 ID를 저장(1년)
         try {
            response.addCookie(CookieBox.createCookie("reid", id, "/", 60 * 60 * 24 * 365));
         } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
         }
      } else {
         // 쿠키값을 저장하지 않는다
         try {
            response.addCookie(CookieBox.createCookie("reid", id, "/", 0));
         } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
         }
      }
   }

   public boolean chkURI(String uri) {
      boolean chk = true;
      if (uri.startsWith("/orl/member/login")) {
         chk = false;
      }
      return chk;
   }
}