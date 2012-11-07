package com.tony.minihrm.beans;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Version;
import javax.validation.constraints.NotNull;

import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.format.annotation.DateTimeFormat;

import com.tony.minihrm.enums.Gender;
import com.tony.minihrm.enums.JobRole;
import com.tony.minihrm.enums.PBC;
import com.tony.minihrm.enums.Team;

@Entity
@Configurable
public class Employee {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id")
	private Long id;

	@Version
	@Column(name = "version")
	private Integer version;

	@NotNull
	private String name;

	@NotNull
	private String sn;

	private String personelId;

	private String notesid;

	private String email;

	private String englishName;

	private float salary;

	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(style = "M-")
	private Date onboardDate;

	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(style = "M-")
	private Date onbandDate;

	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(style = "M-")
	private Date onteamDate;

	@ManyToOne
	private Manager manager;

	private Gender gender;

	private JobRole jobRole;

	private Team team;

	private PBC pbc1;

	private PBC pbc2;

	private PBC pbc3;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getVersion() {
		return version;
	}

	public void setVersion(Integer version) {
		this.version = version;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public String getPersonelId() {
		return personelId;
	}

	public void setPersonelId(String personelId) {
		this.personelId = personelId;
	}

	public String getNotesid() {
		return notesid;
	}

	public void setNotesid(String notesid) {
		this.notesid = notesid;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEnglishName() {
		return englishName;
	}

	public void setEnglishName(String englishName) {
		this.englishName = englishName;
	}

	public float getSalary() {
		return salary;
	}

	public void setSalary(float salary) {
		this.salary = salary;
	}

	public Date getOnboardDate() {
		return onboardDate;
	}

	public void setOnboardDate(Date onboardDate) {
		this.onboardDate = onboardDate;
	}

	public Date getOnbandDate() {
		return onbandDate;
	}

	public void setOnbandDate(Date onbandDate) {
		this.onbandDate = onbandDate;
	}

	public Date getOnteamDate() {
		return onteamDate;
	}

	public void setOnteamDate(Date onteamDate) {
		this.onteamDate = onteamDate;
	}

	public Manager getManager() {
		return manager;
	}

	public void setManager(Manager manager) {
		this.manager = manager;
	}

	public Gender getGender() {
		return gender;
	}

	public void setGender(Gender gender) {
		this.gender = gender;
	}

	public JobRole getJobRole() {
		return jobRole;
	}

	public void setJobRole(JobRole jobRole) {
		this.jobRole = jobRole;
	}

	public Team getTeam() {
		return team;
	}

	public void setTeam(Team team) {
		this.team = team;
	}

	public PBC getPbc1() {
		return pbc1;
	}

	public void setPbc1(PBC pbc1) {
		this.pbc1 = pbc1;
	}

	public PBC getPbc2() {
		return pbc2;
	}

	public void setPbc2(PBC pbc2) {
		this.pbc2 = pbc2;
	}

	public PBC getPbc3() {
		return pbc3;
	}

	public void setPbc3(PBC pbc3) {
		this.pbc3 = pbc3;
	}

}
