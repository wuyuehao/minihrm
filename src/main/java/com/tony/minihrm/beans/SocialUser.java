package com.tony.minihrm.beans;

// domain modal for social portal
public class SocialUser {
	
	private String username;
	
	private boolean followed;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public boolean isFollowed() {
		return followed;
	}

	public void setFollowed(boolean followed) {
		this.followed = followed;
	}
	
}
