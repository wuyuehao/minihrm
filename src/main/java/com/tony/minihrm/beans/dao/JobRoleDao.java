package com.tony.minihrm.beans.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tony.minihrm.beans.JobRole;

@Repository
public interface JobRoleDao extends JpaRepository<JobRole, Long>{
	public List<JobRole> findAll(); 

}
