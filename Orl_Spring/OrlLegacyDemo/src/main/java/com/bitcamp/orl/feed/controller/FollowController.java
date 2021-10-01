package com.bitcamp.orl.feed.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bitcamp.orl.feed.domain.FollowList;
import com.bitcamp.orl.feed.service.FollowService;
import com.bitcamp.orl.member.domain.MemberDto;

@RestController
public class FollowController {
	// 비동기 통신 처리
	// 비동기 통신으로 팔로워 리스트 출력
	// 비동기 통신으로 팔로잉 리스트 출력
	// 비동기 통신으로 팔로우 시작하기 그만하기 

	@Autowired
	private FollowService followService;
	
	// 1) 비동기 통신 팔로워 리스트 출력 기존에 get방식에서 -->post 로 바꿈 0915
	@GetMapping("/feed/followerList")
	@CrossOrigin
	public List<FollowList> getFollowerList2(
			@RequestParam("memberIdx") int memberIdx,
			Model model
			) {

		//팔로잉 리스트 가져오기
		List<FollowList> followerList =followService.getFollowerList(memberIdx);
		System.out.println(followerList); //확인!

		return followerList;
	}

	
	// 2) 비동기 통신으로 팔로잉 리스트 출력, 기존의 get 방식에서 post로 바꿈 0915
	@GetMapping("/feed/followingList")
	@CrossOrigin
	public List<FollowList> getFollowingList2(
			@RequestParam("memberIdx") int memberIdx,
			Model model
			) {

		//팔로잉 리스트 가져오기
		List<FollowList> followingList =followService.getFollowingList(memberIdx);
		System.out.println(followingList); 

		//비동기 통신의 결과 데이터 json
		return followingList;
	}
	
	
	// myIdx 파라미터로 받아서 처리 0918 수정
	@PostMapping("/feed/followButtonClick")
	@CrossOrigin
	public int startFollow(
			@RequestParam("yourIdx") int yourIdx,
			@RequestParam("followStatus") int followStatus,
			@RequestParam("myIdx") int myIdx
			//HttpServletRequest request
			) {
		//반환하는 결과 데이터
		int followResult = 0;

		// session에 저장된 myIdx 가져오기
		//int myIdx = ((MemberDto) request.getSession().getAttribute("memberVo")).getMemberIdx();

		if(followStatus == -1) {
			// -1: 팔로우 그만하기를 눌렀다. -->delete
			followResult = followService.followCancle(myIdx,yourIdx);
			//결과 성공이면 1
		}else {
			// 1: 팔로우 시작하기를 눌렀다. -->insert 
			followResult = followService.followStart(myIdx, yourIdx);
		}

		//결과 json
		return followResult;
	}
	
}	





