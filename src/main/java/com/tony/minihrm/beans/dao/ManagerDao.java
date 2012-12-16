package com.tony.minihrm.beans.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tony.minihrm.beans.Manager;

@Repository
public interface ManagerDao extends JpaRepository<Manager, Long> {

	public List<Manager> findAll();

	public Manager findById(Long long1);

	public List<Manager> findByUsername(String s);
}