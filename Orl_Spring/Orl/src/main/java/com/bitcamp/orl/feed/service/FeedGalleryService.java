package com.bitcamp.orl.feed.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitcamp.orl.crew.domain.Crew;
import com.bitcamp.orl.feed.dao.FeedDao;
import com.bitcamp.orl.feed.domain.FeedGallery;
import com.bitcamp.orl.feed.domain.FeedLikeGallery;

@Service
public class FeedGalleryService {
	// 1) 피드에 처음 들어왔을 때 모든 사진 보여주기
	// 2) 좋아요 정렬 사진 보여주기

	private FeedDao dao;

	@Autowired
	SqlSessionTemplate template;

	// 1) 내 피드 보여주기
	public List<FeedGallery> getFeedGallery(int memberIdx) {

		List<FeedGallery> feedGallery = null;

		dao = template.getMapper(FeedDao.class);
		feedGallery = dao.selectFeedGallery(memberIdx);

		return feedGallery;
	}

	// 2) 좋아요 정렬 보여주기
	public List<FeedLikeGallery> getFeedLikeGallery(int memberIdx) {
		// TODO Auto-generated method stub

		List<FeedLikeGallery> feedLikeGallery = null;

		dao = template.getMapper(FeedDao.class);
		feedLikeGallery = dao.selectFeedLikeGallery(memberIdx);

		return feedLikeGallery;
	}

	// 3) 내가 가입한 크루 리스트 보여주기 (민주 추가 09 24)
	public List<Crew> getMyCrewList(int memberIdx) {
		return template.getMapper(FeedDao.class).selectMyCrewList(memberIdx);
	}
}
