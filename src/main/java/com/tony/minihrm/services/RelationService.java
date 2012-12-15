package com.tony.minihrm.services;

import java.util.HashSet;

import com.tony.minihrm.beans.Relation;

public interface RelationService {

	public Relation findByName(String name);

	public HashSet<String> getFollowing(String name);

	public HashSet<String> getFans(String name);

}
