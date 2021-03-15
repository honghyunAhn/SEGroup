package com.aracomm.changbi.mypage.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aracomm.changbi.mypage.dao.ReceiptDao;
import com.aracomm.changbi.mypage.vo.LectureSearchVo;

@Service
public class ReceiptService {

	@Autowired
	private ReceiptDao dao;

	public List<HashMap<String, Object>> selectLectureReceiptList(LectureSearchVo searchVO) {
		searchVO.setTotalCnt(dao.selectLectureReceiptListCnt(searchVO));
		return dao.selectLectureReceiptList(searchVO);
	}

	public HashMap<String, Object> selectReceiptInfo(HashMap<String, Object> params) {
		return dao.selectReceiptInfo(params);
	}
	
	public HashMap<String, Object> selectKcpRecieptParam(HashMap<String, Object> params) {
		return dao.selectKcpRecieptParam(params);
	}
}
