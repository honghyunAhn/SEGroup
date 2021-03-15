package com.aracomm.changbi.guide.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aracomm.changbi.guide.dao.CardinalDao;

@Service
public class CardinalService {
	@Autowired
	CardinalDao dao;

	public List<Map<String, Object>> selectCardinalList(String appPossibles) {
		Map<String,String> param = new HashMap<String, String>();
		param.put("appPossibles", appPossibles);
		return dao.selectCardinalList(param);
	}

	public List<Map<String, Object>> selectMainCardinalList() {
		return dao.selectMainCardinalList();
	}
}
