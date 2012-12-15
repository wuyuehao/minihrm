package com.tony.minihrm.beans;

import java.util.HashSet;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;

@Entity
public class Relation {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id")
	private Long id;

	@NotNull
	private String username;

	private HashSet<String> following;

	private HashSet<String> fans;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public HashSet<String> getFollowing() {
		return following;
	}

	public void setFollowing(HashSet<String> following) {
		this.following = following;
	}

	public HashSet<String> getFans() {
		return fans;
	}

	public void setFans(HashSet<String> fans) {
		this.fans = fans;
	}
}
