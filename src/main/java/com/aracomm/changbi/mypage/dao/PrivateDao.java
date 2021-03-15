package com.aracomm.changbi.mypage.dao;

import java.util.Map;

public interface PrivateDao {

	Map<String, Object> selectMyInfo(String user_id);
	int updateMember(Map<String, String> param);
	int updateMemberOut(String user_id);
	int insertMemberOut(Map<String, String> param);
	Map<String, String> selectMyInfoForWithdraw(String user_id);
}
