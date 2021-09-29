package com.bitcamp.orl.feed.dao;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.bitcamp.orl.crew.domain.Crew;
import com.bitcamp.orl.feed.domain.*;
import com.bitcamp.orl.member.domain.*;

public interface FeedDao {

// 우리
	// 피드 작성
	int createFeed(Feed feed);

	// 피드 수정
	int editFeed(@Param("boardDiscription") String boardDiscription, @Param("hashtag") String hashtag,
			@Param("tag") String tag, @Param("boardIdx") int boardIdx);

	// 피드 댓글 작성
	int insertFeedComment(FeedComment feedcomment);

	// 피드 상세보기
	FeedView selectFeedView(int boardIdx);

	// 추가 (09.25.우리)
	// 피드 존재 여부 체크
	int selectFeedChk(@Param("memberIdx") int memberIdx, @Param("boardIdx") int boardIdx);

//세라
	// 1. follower수 가져오기
	int selectFollowerCount(@Param("memberIdx") int memberIdx);

	// 2. following 수 가져오기
	int selectFollowingCount(@Param("memberIdx") int memberIdx);

	// 3. 게시물 갯수 가져오기
	int selectFeedCount(@Param("memberIdx") int memberIdx);

	// 4. 남피드 출력 위해 필요한 member 객체 가져오기(한행)
	Member selectOneMember(@Param("memberIdx") int memberIdx);

	// 5. 팔로우하기와 팔로우 끊기 버튼을 위해 나와 남이 팔로우 상태인지 체크하기
	int selectFollowRelation(@Param("myIdx") int myIdx, @Param("yourIdx") int yourIdx);

	// 6. 내 피드 기본 정렬 가져오기
	List<FeedGallery> selectFeedGallery(@Param("memberIdx") int memberIdx);

	// 7. 내 피드 좋아요 정렬 가져오기
	List<FeedLikeGallery> selectFeedLikeGallery(@Param("memberIdx") int memberIdx);

	// 8. 좋아요 누른 상태인지 아닌지
	int selectLikeStatus(@Param("myIdx") int myIdx, @Param("boardIdx") int boardIdx);

	// 9. 피드 상세 보기에 좋아요 갯수(0910)
	int selectTotalLikeCount(@Param("boardIdx") int boardIdx);

	// 10. 피드 인기순 정렬(0910)
	List<NewFeedList> selectFeedOrderByLike();

	// 11. 해시태그 검색 결과 (0911)
	List<NewFeedList> selectByHashtag(@Param("hashtag") String hashtag);

	// 12. 닉네임 검색 결과 (0911)
	List<FeedSearchByNickname> selectByNickname(@Param("nickname") String nickname);

// 관리자용 추가 0915

	// 전체 피드 리스트
	List<FeedView> selectAllFeed();

	// 피드 삭제
	int deleteFeedByAdmin(@Param("boardIdx") int boardIdx);

	// 산별 피드보기(용민)
//	List<NewFeedList> selectNewFeedByMountain(@Param("mName") String mName);

	// crew 민주 추가 09 24
	// session의 memberIdx을 이용하여 내가 가입한 crew 리스트
	List<Crew> selectMyCrewList(@Param("memberIdx") int memberIdx);
}
