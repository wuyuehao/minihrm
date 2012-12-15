package com.tony.minihrm.beans.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tony.minihrm.beans.Message;


@Repository
public interface MessageDao extends JpaRepository<Message, Long> {

	List<Message> findByReceiver(String currentUsername);

	List<Message> findByReceiverOrderByIdDesc(String currentUsername);

	
}
