package com.aracomm.changbi.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.aracomm.changbi.mypage.vo.PointSearchVo;

public interface PointDao {
	public int insertPoint(Map<String, Object> param);
	public int insertPointForApplyCancel(Map<String, Object> param);
	public Map<String, Object> selectMemberPointList(String user_id);
	public Map<String, Object> selectPolicyPoint();

	public int selectPointListCnt(PointSearchVo searchVO);
	public List<HashMap<String, Object>> selectPointList(PointSearchVo searchVO);
	public HashMap<String, Object> selectPointSummary(String user_id);
	
}
