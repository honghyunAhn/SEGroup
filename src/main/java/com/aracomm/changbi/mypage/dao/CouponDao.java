package com.aracomm.changbi.mypage.dao;

import java.util.HashMap;
import java.util.List;

import com.aracomm.changbi.mypage.vo.CouponSearchVo;
import com.aracomm.changbi.mypage.vo.PointSearchVo;

public interface CouponDao {

	HashMap<String, Object> selectCouponInfo(HashMap<String, Object> params);
	List<HashMap<String, Object>> selectCouponList(PointSearchVo searchVO);
	List<HashMap<String, Object>> selectUserCouponList(CouponSearchVo searchVo);
	int selectUserCouponListTotCnt(CouponSearchVo searchVo);
	HashMap<String, Object> selectCouponByCouponNum(String coupon_num);

	int updateCouponUse(String coupon_num);
	HashMap<String, Object> selectValidCouponInfo(HashMap<String, Object> params);
	int registCouponInfo(HashMap<String, Object> params);
}
