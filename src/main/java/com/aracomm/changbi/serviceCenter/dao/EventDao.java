package com.aracomm.changbi.serviceCenter.dao;

import java.util.List;
import java.util.Map;

import com.aracomm.changbi.serviceCenter.vo.EventSearchVo;

public interface EventDao {
	public List<Map<String, Object>> selectEventList(EventSearchVo searchVo);
	public Map<String, Object> selectEvent(String id);
	public int selectEventListTotCnt(EventSearchVo searchVo);
}
