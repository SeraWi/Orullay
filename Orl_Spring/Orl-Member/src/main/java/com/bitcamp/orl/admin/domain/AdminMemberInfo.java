package com.bitcamp.orl.admin.domain;

import java.util.List;

import com.bitcamp.orl.member.domain.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminMemberInfo {
	
	private List<Member> list;
	private List<FeedView> feedList;
}
