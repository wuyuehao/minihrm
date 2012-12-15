package com.tony.minihrm.beans.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tony.minihrm.beans.BandData;

@Repository
public interface BandDataDao extends JpaRepository<BandData, Long> {

	public List<BandData> findAll();

}
