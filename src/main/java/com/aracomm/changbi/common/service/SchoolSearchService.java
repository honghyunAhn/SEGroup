package com.aracomm.changbi.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aracomm.changbi.common.base.BaseSearchVo;
import com.aracomm.changbi.common.dao.SchoolSearchDao;

@Service
public class SchoolSearchService {
	@Autowired
	private SchoolSearchDao dao;

	public List<Map<String, Object>> selectSchoolList(BaseSearchVo searchVo) {
		searchVo.setTotalCnt(dao.selectSchoolListTotCnt(searchVo));
		return dao.selectSchoolList(searchVo);
	}
}
