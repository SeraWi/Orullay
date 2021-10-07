package com.bitcamp.orl.feed.domain;

public class FeedCommentRequest {
	
	//피드 상세보기 (댓글 입력)
	//댓글 게시하면 ->command객체로 저장
	
	private int boardCommentIdx; //댓글table idx
	private String comment; //댓글
	private int boardIdx; //게시글 idx
	private int memberIdx; 
	
	public FeedCommentRequest() {
		
	}

	public FeedCommentRequest(int boardCommentIdx, String comment, int boardIdx, int memberIdx) {
		super();
		this.boardCommentIdx = boardCommentIdx;
		this.comment = comment;
		this.boardIdx = boardIdx;
		this.memberIdx = memberIdx;
	}

	public int getBoardCommentIdx() {
		return boardCommentIdx;
	}

	public void setBoardCommentIdx(int boardCommentIdx) {
		this.boardCommentIdx = boardCommentIdx;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getBoardIdx() {
		return boardIdx;
	}

	public void setBoardIdx(int boardIdx) {
		this.boardIdx = boardIdx;
	}

	public int getMemberIdx() {
		return memberIdx;
	}

	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}

	@Override
	public String toString() {
		return "FeedCommentRequest [boardCommentIdx=" + boardCommentIdx + ", comment=" + comment + ", boardIdx="
				+ boardIdx + ", memberIdx=" + memberIdx + "]";
	}
	
	//FeedCommentRequest -> FeedComment
	public FeedComment toFeedComment() {
		//                                                                   membernickname, memberProfile
		return new FeedComment(boardCommentIdx, comment, boardIdx, memberIdx, null, null);
	}
	

}
