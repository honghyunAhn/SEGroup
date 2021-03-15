package com.aracomm.changbi.mypage.dao;

import java.util.HashMap;
import java.util.List;

import com.aracomm.changbi.mypage.vo.LectureSearchVo;

public interface ReceiptDao {

	int selectLectureReceiptListCnt(LectureSearchVo searchVO);

	List<HashMap<String, Object>> selectLectureReceiptList(LectureSearchVo searchVO);

	HashMap<String, Object> selectScorecard(HashMap<String, Object> params);

	HashMap<String, Object> selectRegister(HashMap<String, Object> params);

	HashMap<String, Object> selectReceipt(HashMap<String, Object> params);

	HashMap<String, Object> selectCertificate(HashMap<String, Object> params);

	HashMap<String, Object> selectReceiptInfo(HashMap<String, Object> params);
	
	HashMap<String, Object> selectKcpRecieptParam(HashMap<String, Object> params);
	
}
