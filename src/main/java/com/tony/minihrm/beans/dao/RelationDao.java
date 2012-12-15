package com.tony.minihrm.beans.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tony.minihrm.beans.Relation;

@Repository
public interface RelationDao extends JpaRepository<Relation, Long> {

	Relation findByUsername(String name);

}
