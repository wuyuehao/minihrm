package com.tony.minihrm.beans.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tony.minihrm.beans.PBC;

public interface PBCDao extends JpaRepository<PBC, Long> {
	public List<PBC> findAll();
}
