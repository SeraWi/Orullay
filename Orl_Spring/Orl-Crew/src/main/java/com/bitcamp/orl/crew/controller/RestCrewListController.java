package com.bitcamp.orl.crew.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bitcamp.orl.crew.domain.Crew;
import com.bitcamp.orl.crew.domain.CrewForPaging;
import com.bitcamp.orl.crew.domain.CrewListCriteria;
import com.bitcamp.orl.crew.domain.PageMaker;
import com.bitcamp.orl.crew.domain.SearchType;
import com.bitcamp.orl.crew.service.CrewListViewService;

@RestController
public class RestCrewListController {

	@Autowired
	CrewListViewService service;

	// My Crew List 가져오는 method
	@RequestMapping("/crew/getMyCrewList")
	@CrossOrigin
	public List<Crew> getMyCrewList(
			@RequestParam(value = "memberIdx", required = false) int memberIdx) {
		List<Crew> myCrewList = null;
		if (memberIdx != 0) {
			myCrewList = service.getMyCrewList(memberIdx);
		}
		return myCrewList;
	}

	// Crew List Page에서 Page정보와 List<Crew>객체를 같이 넘겨주는 method
	@RequestMapping(value = "/crew/searchList", produces = "application/json; charset=utf8")
	@CrossOrigin
	public CrewForPaging getCrewList(@RequestParam(value = "searchType", required = false) String searchType,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page
			)throws UnsupportedEncodingException {
		// PageMaker+List<Crew>담는 객체인 CrewForPaging 생성
		CrewForPaging crewForPaging = null;
		// 현재 페이지 값을 받아서 페이징에 필요한 값을 계산하기 위한 Criteria 객체 생성
		CrewListCriteria cri = new CrewListCriteria(page);
		
		SearchType st;

		if (keyword != null) {
			String keywordK = URLDecoder.decode(keyword, "UTF-8");
			System.out.println(keywordK);
			st = new SearchType(searchType, keywordK, cri.getPageStart(), cri.getPerPageNum());
		} else {
			st = new SearchType(searchType, keyword, cri.getPageStart(), cri.getPerPageNum());
		}

		// 페이징 처리
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);

		// 총 게시물 수
		int totalNum;

		List<Crew> allCrewList;

		// 검색 keyword가 있는 경우
		if (st.getKeyword() != null && st.getKeyword().trim().length() > 0) {
			allCrewList = service.getCrewListAll(st);
			totalNum = service.getCrewCountForSearching(st);
			pageMaker.setTotalCount(totalNum);
		} else { // 검색 keyword가 없는 경우
			allCrewList = service.getCrewListAll(cri.getPageStart(), cri.getPerPageNum());
			totalNum = service.getCrewCount();
			pageMaker.setTotalCount(totalNum);
		}

		crewForPaging = new CrewForPaging(allCrewList, pageMaker);

		return crewForPaging;
	}
}
