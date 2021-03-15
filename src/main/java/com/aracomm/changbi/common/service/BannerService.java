package com.aracomm.changbi.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aracomm.changbi.common.dao.BannerDao;

@Service
public class BannerService {
	@Autowired
	BannerDao dao;

	public List<Map<String, Object>> selectBannerList(String position) {
		return dao.selectBannerList(position);
	}

}
