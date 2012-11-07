package com.tony.minihrm.beans.dao;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import com.tony.minihrm.beans.Manager;

public interface ManagerDAO extends JpaRepository<Manager, Serializable> {
	
	public Manager findById(Long id);

	@Transactional(timeout = 10)
	public List<Manager> findAll();

}
