package com.tony.minihrm.beans.dao;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tony.minihrm.beans.Employee;

@Repository
public interface EmployeeDao extends JpaRepository<Employee, Long> {

	public Employee findById(Long long1);

	public List<Employee> findByManager(String s);

	public List<Employee> findByManager(String s, Sort sort);

	public List<Employee> findByManagerOrderByNameAsc(String s);

	public List<Employee> findByManagerOrderByNameDesc(String s);

	public List<Employee> findByManagerOrderByBandAsc(String s);

	public List<Employee> findByManagerOrderByBandDesc(String s);

	public List<Employee> findByManagerOrderByOnboardDateAsc(String s);

	public List<Employee> findByManagerOrderByOnboardDateDesc(String s);

	public List<Employee> findByManagerOrderByOnbandDateAsc(String s);

	public List<Employee> findByManagerOrderByOnbandDateDesc(String s);

	public List<Employee> findByManagerOrderByOnteamDateAsc(String s);

	public List<Employee> findByManagerOrderByOnteamDateDesc(String s);

	public List<Employee> findByManagerOrderByManagerAsc(String s);

	public List<Employee> findByManagerOrderByManagerDesc(String s);

	public List<Employee> findByManagerOrderByJobRoleAsc(String s);

	public List<Employee> findByManagerOrderByJobRoleDesc(String s);

	public List<Employee> findByManagerOrderByTeamAsc(String s);

	public List<Employee> findByManagerOrderByTeamDesc(String s);

	public List<Employee> findByManagerOrderBySalaryAsc(String s);

	public List<Employee> findByManagerOrderBySalaryDesc(String s);

	public List<Employee> findByManagerNot(String s);

	public List<Employee> findByEmail(String s);
}