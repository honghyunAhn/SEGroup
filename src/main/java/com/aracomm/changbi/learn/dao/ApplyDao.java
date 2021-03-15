package com.aracomm.changbi.learn.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.aracomm.changbi.user.vo.UserVo;

public interface ApplyDao {

	int insertApply(HashMap<String,String> param);
	int updateDonePayment(String appId);
	int updatePartialPayment(String appId);

	int selectUserApplyCourseCount(Map<String, String> param);

	Map<String, Object> selectApplyByOrderIdx(String ordr_idxx);
	int selectApplyCountByDesNum(Map<String, String> param);
	Map<String, Object> selectUserAddress(String user_id);
}
