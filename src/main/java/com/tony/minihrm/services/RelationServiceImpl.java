package com.tony.minihrm.services;

import java.util.HashSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tony.minihrm.beans.Relation;
import com.tony.minihrm.beans.dao.RelationDao;

@Service
public class RelationServiceImpl implements RelationService {

	@Autowired
	private RelationDao relationDao;

	public Relation findByName(String name) {
		return relationDao.findByUsername(name);
	}

	public HashSet<String> getFollowing(String name) {
		return findByName(name).getFollowing();
	}

	public HashSet<String> getFans(String name) {
		return findByName(name).getFans();
	}
}
