package com.bitcamp.orl.admin.service;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.orl.crew.dao.Dao;
import com.bitcamp.orl.crew.domain.Crew;
import com.bitcamp.orl.crew.domain.CrewMemberList;

@Service
public class AdminCrewService {

   final String UPLOAD_URI = "/images/crew";

   // 크루의 Dao
   private Dao dao;

   @Autowired
   private SqlSessionTemplate template;

   // 크루reg테이블- 가입크루 모두 읽어오는 리스트
   public List<CrewMemberList> getCrewRegList() {
      dao = template.getMapper(Dao.class);
      List<CrewMemberList> list = dao.selectAllCrewMemberList();
      return list;
   }

   // 크루 삭제
   public int deleteCrew(int crewIdx, HttpServletRequest request) {
      int resultCnt = 0;
      dao = template.getMapper(Dao.class);
      selectThatFile(request, crewIdx).delete();
      resultCnt = dao.deleteCrew(crewIdx);
      return resultCnt;
   }

   // 크루 idx로 현재 크루 사진 파일 선택
   public File selectThatFile(HttpServletRequest request, int crewIdx) {
      dao = template.getMapper(Dao.class);
      String path = request.getSession().getServletContext().getRealPath(UPLOAD_URI);
      File Dir = new File(path);
      File file = null;
      Crew crew = dao.selectCrew(crewIdx);
      try {
         String crewPhoto = crew.getCrewPhoto();
         file = new File(Dir, crewPhoto);
      } catch (NullPointerException e) {
         e.printStackTrace();
      }
      return file;
   }

}