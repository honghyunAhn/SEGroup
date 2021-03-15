package com.aracomm.changbi.mypage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aracomm.changbi.member.dao.PointDao;
import com.aracomm.changbi.mypage.dao.CouponDao;
import com.aracomm.changbi.mypage.vo.CouponSearchVo;
import com.aracomm.changbi.mypage.vo.PointSearchVo;


@Service
public class PointService {

	@Autowired
	private PointDao pointDao;

	@Autowired
	private CouponDao couponDao;

	public List<HashMap<String, Object>> selectPointList(PointSearchVo searchVO) {
		searchVO.setPointTotalCnt(pointDao.selectPointListCnt(searchVO));
		return pointDao.selectPointList(searchVO);
	}

	public HashMap<String, Object> selectPointSummary(String user_id) {
		return pointDao.selectPointSummary(user_id);
	}


	public List<HashMap<String, Object>> selectCouponList(PointSearchVo searchVO) {
		searchVO.setCouponTotalCnt(couponDao.selectUserCouponListTotCnt(new CouponSearchVo(searchVO.getUser_id())));
		return couponDao.selectCouponList(searchVO);
	}

	public int selectUserCouponListTotCnt(CouponSearchVo searchVo) {
		return couponDao.selectUserCouponListTotCnt(searchVo);
	}

	public Map<String, Object> selectPolicyPoint() {
		return pointDao.selectPolicyPoint();
	}

	public HashMap<String, Object> selectValidCouponInfo(HashMap<String, Object> params) {
		return couponDao.selectValidCouponInfo(params);
	}

	public int registCouponInfo(HashMap<String, Object> params) {
		return couponDao.registCouponInfo(params);
	}
	
	public int insertPoint(Map<String, Object> param) {
		return pointDao.insertPoint(param);
	}
	

}