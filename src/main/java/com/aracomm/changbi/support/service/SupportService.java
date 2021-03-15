package com.aracomm.changbi.support.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aracomm.changbi.support.dao.SupportDao;

@Service
public class SupportService {

	@Autowired
	SupportDao dao;
	
	public List<HashMap<String, String>> selectFaqListLms(HashMap<String, String> param){
		
		return dao.selectFaqListLms(param);
		
	};
	
}
