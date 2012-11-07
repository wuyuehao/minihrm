package com.tony.minihrm.beans.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import com.tony.minihrm.beans.Employee;

public interface EmployeeDAO extends JpaRepository<Employee, Long> {

	public Employee findById(Long id);

	@Transactional(timeout = 10)
	public List<Employee> findAll();
	
}
