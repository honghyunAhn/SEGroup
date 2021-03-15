package com.aracomm.changbi.mypage.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aracomm.changbi.mypage.dao.DeliveryDAO;
import com.aracomm.changbi.mypage.vo.DeliverySearchVo;

@Service
public class DeliveryService {

	@Autowired
	private DeliveryDAO dao;

	public List<HashMap<String, Object>> selectDeliveryList(DeliverySearchVo searchVO) {
		searchVO.setTotalCnt(dao.selectDeliveryListCnt(searchVO));
		return dao.selectDeliveryList(searchVO);
	}

}
