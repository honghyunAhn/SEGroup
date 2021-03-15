package com.aracomm.changbi.guide.dao;

import java.util.List;
import java.util.Map;

public interface CardinalDao {
	public List<Map<String, Object>> selectCardinalList(Map<String, String> param);
	public int selectCardinalListTotCnt(String appPossibles);

	// main 화면
	public List<Map<String, Object>> selectMainCardinalList();
}
