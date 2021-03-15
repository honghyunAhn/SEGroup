package com.aracomm.changbi.mypage.dao;

import java.util.HashMap;
import java.util.List;

import com.aracomm.changbi.mypage.vo.ChangePolicyVo;
import com.aracomm.changbi.mypage.vo.LectureSearchVo;

public interface ChangeDao {

	int selectChangeableLectureCnt(LectureSearchVo searchVO);
	List<HashMap<String, Object>> selectChangeableLectureList(LectureSearchVo searchVO);

	int selectChangedLectureCnt(LectureSearchVo searchVO);
	List<HashMap<String, Object>> selectChangedLectureList(LectureSearchVo searchVO);
	ChangePolicyVo selectChangePolicy();
	HashMap<String, Object> selectCurrentLecture(HashMap<String, Object> params);
	List<HashMap<String, Object>> selectOtherChangeableLectureList(HashMap<String, Object> params);
	List<HashMap<String, Object>> selectOtherDelayableLectureList(HashMap<String, Object> params);
	void updateLearnAppMaster(HashMap<String, Object> params);
	int insertLearnChangeApp(HashMap<String, Object> params);
	int insertLearnDelayApp(HashMap<String, Object> params);
	int insertLearnCancelApp(HashMap<String, Object> params);
}
