package com.aracomm.changbi.mypage.dao;

import java.util.Map;

public interface BookAppDao {
	int insertBookApp(Map<String, String> param);
	int insertBookAppFromLearnApp(Map<String, String> param);
	int updateDonePayment(String appId);
}
