package com.aracomm.changbi.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aracomm.changbi.common.dao.HitKeywordDao;

@Service
public class HitKeywordService {
	@Autowired
	HitKeywordDao dao;

	public List<String> selectHitKeywordList() {
		return dao.selectHitKeywordList();
	}

}
