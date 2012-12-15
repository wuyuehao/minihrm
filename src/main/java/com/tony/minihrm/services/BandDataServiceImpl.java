package com.tony.minihrm.services;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tony.minihrm.beans.BandData;
import com.tony.minihrm.beans.dao.BandDataDao;

@Service
public class BandDataServiceImpl implements BandDataService {
	
	@Autowired
	private BandDataDao bandDao;
	
	public HashMap<String, Long> getBandData(){
		List<BandData> list = bandDao.findAll();
		HashMap<String, Long> bandmidMap = new HashMap<String, Long>();
		for (BandData bandData : list) {
			bandmidMap.put(bandData.getBand(), bandData.getMid());
		}
		return bandmidMap;
	}

}
