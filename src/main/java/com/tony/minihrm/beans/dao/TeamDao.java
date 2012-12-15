package com.tony.minihrm.beans.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tony.minihrm.beans.Team;

public interface TeamDao extends JpaRepository<Team, Long> {

	public List<Team> findAll();
}
