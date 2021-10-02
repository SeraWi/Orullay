package com.bitcamp.orl.member.service;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bitcamp.orl.member.dao.Dao;
import com.bitcamp.orl.member.domain.Member;
import com.bitcamp.orl.member.domain.MemberEditRequest;
import com.bitcamp.orl.member.util.AES256Util;

@Service
public class MypageService {
   final String PROFILE_URI ="/images/member/profile";

   private Dao dao;
   
   @Autowired
   private SqlSessionTemplate template;
   
 //암호화처리
 	@Autowired
 	private AES256Util aes256Util; 
 	
 	// memberIdx로 member객체 찾기
   public Member getMemberSelectByIdx(int memberIdx){

      Member member = null;
      dao = template.getMapper(Dao.class);

      member = dao.selectByIdx(memberIdx);

      return member;
   }
   //내 정보 수정하기
   public int editMember(
         HttpServletRequest request,
         Member member,
         MemberEditRequest memberEditRequest) {

      File newFile = null;
      int resultCnt = 0;

      try {
         Member editMember = member;
         // 내정보 수정에서 프로필 사진을 변경하는 경우(업로드하는 프사가 not null이다)
         if (memberEditRequest.getMemberPhoto() != null && !memberEditRequest.getMemberPhoto().isEmpty()) {
        	 // 해당 멤버를 찾아서 현재 프로필 사진파일이 있는지 확인
        	 if(selectThatFile(member.getMemberIdx(),request) != null) {
         		// 현재 프로필 사진 있으면 파일 삭제
        		 selectThatFile(member.getMemberIdx(),request).delete();
         	}
        	 // 새 프로필 사진 저장하기
            newFile = saveProfileFile(request,memberEditRequest.getMemberPhoto());
            editMember.setMemberProfile(newFile.getName());
         }
         //수정내용 세팅해주기
         editMember.setMemberName(memberEditRequest.getMemberName());
         editMember.setMemberEmail(memberEditRequest.getMemberEmail());
         editMember.setMemberNickname(memberEditRequest.getMemberNickname());
         editMember.setMemberBirth(memberEditRequest.getBirth());

         dao = template.getMapper(Dao.class);
         //수정된 member정보 업데이트 하기 -> 수정 성공시 반환 1
         resultCnt = dao.updateMember(member);

      } catch (IllegalStateException e) {
         e.printStackTrace();
      } catch (Exception e) {
         e.printStackTrace();
         if(newFile != null & newFile.exists()) {
            newFile.delete();
            System.out.println("파일 삭제");
         }
      }
      return resultCnt;
   }
   //비밀번호 변경하기
   public int editPw(String oldPw,String newPw,String newPw2,Member member) {
	   int resultCnt = 0;
	   try {
		oldPw= aes256Util.encrypt(oldPw);
		//이전 비밀번호와 일치하는지 확인
		if( member.getMemberPw().equals(oldPw)) {
			// 새 비밀번호 입력 두번하는거 같은지 확인
			if(newPw.equals(newPw2)) {
				member.setMemberPw(aes256Util.encrypt(newPw));
				dao=template.getMapper(Dao.class);
				//member정보 업데이트
				resultCnt=dao.updateMember(member);
			}
		}
	} catch (UnsupportedEncodingException | GeneralSecurityException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	   
	   
	   return resultCnt;
   }
   
   
   //프로필 사진 저장하기
   public File saveProfileFile(
         HttpServletRequest request,
         MultipartFile file) {
	   //프로필 사진이 저장된 path가져오기
      String path = request.getSession().getServletContext().getRealPath(PROFILE_URI);
      File newDir = new File(path);
      //저장 디렉토리 없는 경우 생성
      if(!newDir.exists()) {
         newDir.mkdir();
         System.out.println("저장 폴더를 생성했습니다.");
      }
      //file 이름은 현재시간 + 파일 이름으로 저장
      String newFileName = System.currentTimeMillis() + file.getOriginalFilename();
      File newFile = new File(newDir, newFileName);

      try {
         file.transferTo(newFile);
      } catch (IllegalStateException e) {
         e.printStackTrace();
      } catch (IOException e) {
         e.printStackTrace();
      }
      return newFile;
   }
   // memberIdx에 해당하는 프로필 사진파일 가져오기
   public File selectThatFile(int memberIdx, HttpServletRequest request) {
	   	dao = template.getMapper(Dao.class);
	   	//memberIdx 에 해당하는 member 객체 찾기
	   	Member member = dao.selectByIdx(memberIdx);
	   	// member 객체에 프로필 사진명
	   	String fileName = member.getMemberProfile();
	   	// image가 저장된 path를 찾기
	   	String dirpath = request.getSession().getServletContext().getRealPath(PROFILE_URI);
	   	return new File(dirpath, fileName);
	   }
   
}