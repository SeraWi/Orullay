package com.bitcamp.orl.feed.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.bitcamp.orl.feed.domain.*;

public interface FeedDao {

	// 피드 삭제
	int deleteFeed(@Param("memberIdx") int memberIdx, @Param("boardIdx") int boardIdx);

	// 댓글 삭제
	int deleteComment(@Param("boardCommentIdx") int boardCommentIdx);

	// 피드 댓글 리스트
	List<FeedComment> selectFeedComment(@Param("boardIdx") int boardIdx);

	// 전체 피드 리스트 (최신순)
	List<NewFeedList> selectNewFeed();
	
	// 추가 (09.18.우리)
	// 특정 피드 선택
	Feed selectFeed(@Param("boardIdx") int boardIdx);
	
	// 추가 (09.18.우리)
	// 닉네임 중복 체크
	int selectByNickname(@Param("memberNickname") String memberNickname);
	
	// 추가 (09.22.우리)
	// 닉네임으로 memberIdx 찾기
	int selectMemberIdx(@Param("memberNickname") String memberNickname);
	
	
	
	
	
	// 1. follower 리스트 가져오기
	   List<FollowList> selectFollowerList(@Param("memberIdx") int memberIdx);

	   // 2. follwing 리스트 가져오기
	   List<FollowList> selectFollowingList(@Param("memberIdx") int memberIdx);
	   
	   // 3. 팔로우 시작하기
	   int insertFollowMember(@Param("myIdx") int myIdx, @Param("yourIdx") int yourIdx);

	   // 4. 팔로우 그만하기
	   int deleteFollowMember(@Param("myIdx") int myIdx, @Param("yourIdx") int yourIdx);
	   
	   // 5. 좋아요 누르기
	   int insertLike(@Param("memberIdx") int memberIdx, @Param("boardIdx") int boardIdx);

	   // 6. 좋아요 취소 
	   int deleteLike(@Param("memberIdx") int memberIdx, @Param("boardIdx") int boardIdx);
	   
	   
	   
	   
		// 전체 피드 리스트
		List<FeedView> selectAllFeed();
		// 피드 삭제
		int deleteFeedByAdmin(@Param("boardIdx") int boardIdx);
		// 산별 피드보기(용민)
		List<NewFeedList> selectNewFeedByMountain(@Param("mName") String mName);

}
