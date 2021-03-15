package com.aracomm.changbi.serviceCenter.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aracomm.changbi.serviceCenter.dao.EventDao;
import com.aracomm.changbi.serviceCenter.vo.EventSearchVo;

@Service
public class EventService {
	@Autowired
	private EventDao dao;

	public List<Map<String, Object>> selectEventList(EventSearchVo searchVo) {
		searchVo.setTotalCnt(dao.selectEventListTotCnt(searchVo));
		return dao.selectEventList(searchVo);
	}

	public Map<String, Object> selectEvent(String id) {
		return dao.selectEvent(id);
	}


}
