package com.tony.minihrm.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tony.minihrm.beans.Employee;
import com.tony.minihrm.beans.dao.EmployeeDao;

public class EmployeeService {

	@Autowired
	EmployeeDao employeeDao;

	public void create(Employee e) {
		employeeDao.save(e);
	}

	public List<Employee> retrieve() {
		return employeeDao.findAll();
	}

	public void update(Employee e) {
		employeeDao.save(e);
	}

	public void delete(Long id) {

	}
}
