package com.aracomm.changbi.support.dao;

import java.util.HashMap;
import java.util.List;

public interface SupportDao {
	public List<HashMap<String, String>> selectFaqListLms(HashMap<String, String> param);
	public List<HashMap<String, Object>> selectFaqList(HashMap<String, Object> param);
}
