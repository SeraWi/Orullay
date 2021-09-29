package com.bitcamp.orl.crew.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.orl.crew.domain.Crew;
import com.bitcamp.orl.crew.domain.CrewMemberList;
import com.bitcamp.orl.crew.domain.SearchType;
import com.bitcamp.orl.crew.mapper.CrewMapper;
import com.bitcamp.orl.s3.util.S3Util;

@Service
public class CrewListViewService {

	private CrewMapper dao;

	@Autowired
	private SqlSessionTemplate template;

	//내가 가입한 크루 리스트 가져오기
	public List<Crew> getMyCrewList(int memberIdx) {
		return template.getMapper(CrewMapper.class).selectMyCrewList(memberIdx);
	}
	
	//검색하지 않았을 때 크루 리스트 가져오기(페이징 처리)
	public List<Crew> getCrewListAll(int pageStart, int perPageNum) {
		dao = template.getMapper(CrewMapper.class);
		return dao.selectAll(pageStart, perPageNum);
	}

	//검색 결과가 있을 때 크루 리스트 가져오기(페이징 처리)
	public List<Crew> getCrewListAll(SearchType searchType){
		dao = template.getMapper(CrewMapper.class);
		return dao.selectCrewAll(searchType);
	}
	
	//크루 총 개수 계산(검색하지 않았을 때)
	public int getCrewCount() {
		return template.getMapper(CrewMapper.class).CrewCount();
	}
	
	//크루 총 개수 계산(검색했을 때)
	public int getCrewCountForSearching(SearchType searchType) {
		return template.getMapper(CrewMapper.class).CrewCountForSearching(searchType);
	}
	
	
	///////////관리자용///////////
	
	// 크루reg테이블- 가입크루 모두 읽어오는 리스트
	public List<CrewMemberList> getCrewRegList() {
		return template.getMapper(CrewMapper.class).selectAllCrewMemberList();
	}
	
	// 관리자용 크루 리스트 가져오기
	public List<Crew> getCrewListAdmin(){
		return template.getMapper(CrewMapper.class).selectCrewListByAdmin();
	}
	
	// 관리자용 크루 삭제
	public int deleteCrew(int crewIdx) {
		CrewMapper dao = template.getMapper(CrewMapper.class);
		S3Util s3 = new S3Util();
		Crew crew = dao.selectCrew(crewIdx);
		s3.fileDelete(crew.getCrewPhoto());
		return dao.deleteCrew(crewIdx);
	}
	
}
