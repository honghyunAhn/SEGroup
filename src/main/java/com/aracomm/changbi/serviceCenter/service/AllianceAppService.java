package com.aracomm.changbi.serviceCenter.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aracomm.changbi.serviceCenter.dao.AllianceAppDao;

@Service
public class AllianceAppService {
	@Autowired
	private AllianceAppDao dao;

	public int insertAllianceApp(Map<String, String> param) {
		return dao.insertAllianceApp(param);
	}
}
