package com.bitcamp.orl.member.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.bitcamp.orl.member.dao.Dao;
import com.bitcamp.orl.member.domain.Member;
import com.bitcamp.orl.member.util.AES256Util;

@Service
public class ForgotPwService {


	private Dao dao;

	@Autowired
	private SqlSessionTemplate template;

	@Autowired
	private JavaMailSender sender;

	//암호화처리
	@Autowired
	private AES256Util aes256Util;

	public Member FindPw( HttpServletRequest request,String memberId, String membername,
						  String memberEmail
	) {

		Member member = null;

		dao=template.getMapper(Dao.class);

		if(memberId!=null && membername != null && memberEmail != null&&
				memberId.trim().length() > 1 && membername.trim().length() > 1
				&& memberEmail.trim().length() > 2) {


			member=dao.selectPw(memberId,membername, memberEmail);
		}

		System.out.println("비번서비스"+member);
		return member;
	}

	public int mailSender(Member member, String password) {

		MimeMessage message = sender.createMimeMessage();
		dao = template.getMapper(Dao.class);
		int check = 0;
		try {

			// 메일 제목
			message.setSubject("Orullay 비밀번호 안내", "UTF-8");

			// 메일 내용 컨텐츠 html
			String html = "<h1>Orullay 비밀번호 안내드립니다.</h1>";
			html += "<h3>" + member.getMemberName() + " 회원님의 임시 비밀번호는 '" + password + "'입니다.</h3><br>";
			html += "<h3>회원 수정 부탁드립니다.</h3>";

			// message에 내용 적용
			message.setText(html, "utf-8", "html");

			// from 설정
			message.setFrom(new InternetAddress("orullay@naver.com"));

			// to 설정
			message.addRecipient(MimeMessage.RecipientType.TO, new InternetAddress(member.getMemberEmail()));

			// 메일 발송
			sender.send(message);
			System.out.println("메일센더 메일발송 + mememail = " + member.getMemberEmail());
			try {
				member.setMemberPw(aes256Util.encrypt(password));
				dao.updateMember(member);
				check = 1;

			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}

		} catch (MessagingException e) {
			e.printStackTrace();
		} catch (Exception e){
			e.printStackTrace();
		}
		return check;
	}

	public String getRamdomPassword(String str) {
		char[] charSet = new char[]{'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G',
				'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
				'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};
		int idx = 0;
		StringBuffer sb = new StringBuffer();
		System.out.println("charSet.length :::: " + charSet.length);
		for (int i = 0; i < 8; i++) {
			idx = (int) (charSet.length * Math.random()); //
			sb.append(charSet[idx]);
		}
		return sb.toString();
	}


}
