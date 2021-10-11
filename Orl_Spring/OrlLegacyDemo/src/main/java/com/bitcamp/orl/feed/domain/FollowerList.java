package com.bitcamp.orl.feed.domain;

public class FollowerList {
	
	//follower리스트 가져올때 사용
	
	private int yourFollowerIdx; //해당 유저의 팔로워 idx 남남 idx
	private String memberNickname; // 팔로워의 닉네임  남남 닉네임
	private String memberProfile; //팔로워의 프로필 사진  남남 사진
	private String followStatus; // 팔로워를 내가 팔로우 하는지
	
	public FollowerList(){};
	
	public FollowerList(int yourFollowerIdx, String memberNickname, String memberProfile, String followStatus) {
		super();
		this.yourFollowerIdx = yourFollowerIdx;
		this.memberNickname = memberNickname;
		this.memberProfile = memberProfile;
		this.followStatus = followStatus;
	}

	public int getYourFollowerIdx() {
		return yourFollowerIdx;
	}

	public void setYourFollowerIdx(int yourFollowerIdx) {
		this.yourFollowerIdx = yourFollowerIdx;
	}

	public String getMemberNickname() {
		return memberNickname;
	}

	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}

	public String getMemberProfile() {
		return memberProfile;
	}

	public void setMemberProfile(String memberProfile) {
		this.memberProfile = memberProfile;
	}

	public String getFollowStatus() {
		return followStatus;
	}

	public void setFollowStatus(String followStatus) {
		this.followStatus = followStatus;
	}

	@Override
	public String toString() {
		return "FollowerList [yourFollowerIdx=" + yourFollowerIdx + ", memberNickname=" + memberNickname
				+ ", memberProfile=" + memberProfile + ", followStatus=" + followStatus + "]";
	}
	
	
	
	
	
	

}
