package com.bitcamp.orl.crew.domain;

public class CrewEditInfo {
	boolean isAuth;
	CrewInfo info;
	int result;
	
	public CrewEditInfo(boolean isAuth, CrewInfo info, int result) {
		super();
		this.isAuth = isAuth;
		this.info = info;
		this.result = result;
	}
	
	public boolean isAuth() {
		return isAuth;
	}
	public void setAuth(boolean isAuth) {
		this.isAuth = isAuth;
	}
	public CrewInfo getInfo() {
		return info;
	}
	public void setInfo(CrewInfo info) {
		this.info = info;
	}
	
	
}
