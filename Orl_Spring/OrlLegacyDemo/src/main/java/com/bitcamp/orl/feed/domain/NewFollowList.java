package com.bitcamp.orl.feed.domain;

public class NewFollowList {
	// 수정1012
	// 팔로잉, 팔로우 리스트 ->view 사용해서 가져오는 버전
	
	private int memberIdx; //팔로우버튼을 누른 사람
	private String memberNickname; //닉네임
	private String memberProfile; //프사
	private int memberIdx2; //팔로우를 당하거나 취소당한 사람
	private String memberNickname2; // 닉네임
	private String memberProfile2;// 프사
	
	private String followStatus; // 나의 기준 팔로우 버튼 상태 (내기준 팔로우 하지 않은 상태==null)
	
	
	// 기본 생성자
	
	public NewFollowList(){};

	public NewFollowList(int memberIdx, String memberNickname, String memberProfile, int memberIdx2,
			String memberNickname2, String memberProfile2, String followStatus) {
		this.memberIdx = memberIdx;
		this.memberNickname = memberNickname;
		this.memberProfile = memberProfile;
		this.memberIdx2 = memberIdx2;
		this.memberNickname2 = memberNickname2;
		this.memberProfile2 = memberProfile2;
		this.followStatus = followStatus;
	}

	public int getMemberIdx() {
		return memberIdx;
	}

	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
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

	public int getMemberIdx2() {
		return memberIdx2;
	}

	public void setMemberIdx2(int memberIdx2) {
		this.memberIdx2 = memberIdx2;
	}

	public String getMemberNickname2() {
		return memberNickname2;
	}

	public void setMemberNickname2(String memberNickname2) {
		this.memberNickname2 = memberNickname2;
	}

	public String getMemberProfile2() {
		return memberProfile2;
	}

	public void setMemberProfile2(String memberProfile2) {
		this.memberProfile2 = memberProfile2;
	}

	public String getFollowStatus() {
		return followStatus;
	}

	public void setFollowStatus(String followStatus) {
		this.followStatus = followStatus;
	}

	@Override
	public String toString() {
		return "NewFollowList [memberIdx=" + memberIdx + ", memberNickname=" + memberNickname + ", memberProfile="
				+ memberProfile + ", memberIdx2=" + memberIdx2 + ", memberNickname2=" + memberNickname2
				+ ", memberProfile2=" + memberProfile2 + ", followStatus=" + followStatus + "]";
	}
	
	
	
}
