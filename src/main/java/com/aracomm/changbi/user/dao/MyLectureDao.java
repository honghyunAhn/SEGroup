package com.aracomm.changbi.user.dao;

import java.util.HashMap;
import java.util.List;

import com.aracomm.base.common.vo.FileVo;

public interface MyLectureDao {
	/** LMS 나의강의실 DAO **/
	public List<HashMap<String,Object>> selectProgressList(HashMap<String, Object> params);
	public int selectProgressListTotalCnt (HashMap<String, Object> params);
	
	public List<HashMap<String,Object>> selectWaitingList(HashMap<String, Object> params);
	public int selectWaitingListTotalCnt (HashMap<String, Object> params);
	
	public List<HashMap<String,Object>> selectCompleteList(HashMap<String, Object> params);
	public int selectCompleteListTotalCnt (HashMap<String, Object> params);
	
	public List<HashMap<String, Object>> selectChapterList(HashMap<String, String> params);
	public List<HashMap<String, Object>> selectChapPageList(HashMap<String, String> params);
	public HashMap<String, Object> selectChapterInfo(HashMap<String, Object> params);
	public HashMap<String, Object> selectChapterInfo2(HashMap<String, Object> params);
	public List<HashMap<String,Object>> courseBoardList(HashMap<String,Object> params);
	public List<HashMap<String,Object>> surveyList(HashMap<String,Object> params);
	public List<HashMap<String,Object>> attendanceList(HashMap<String,Object> params);
	public int insertAttLecHistory(HashMap<String,Object> params);
	/** smt **/
	public List<HashMap<String,Object>> smtpSelectProgressList(HashMap<String, Object> params);
	public int smtpSelectProgressListTotalCnt (HashMap<String, Object> params);
	
	public List<HashMap<String,Object>> smtpSelectWaitingList(HashMap<String, Object> params);
	public int smtpSelectWaitingListTotalCnt (HashMap<String, Object> params);
	
	public List<HashMap<String,Object>> smtpSelectCompleteList(HashMap<String, Object> params);
	public int smtpSelectCompleteListTotalCnt (HashMap<String, Object> params);
	
	 //파일 다운로드
	public FileVo attachFileInfo(String file_id);
	public int setProgYn(HashMap<String, Object> param);
	public int setProgYnLink(HashMap<String, Object> param);
	public void insertAttLec(HashMap<String, Object> param);
	public void insertAttLecHist(HashMap<String, Object> param);
	public HashMap<String, String> learnCheck(HashMap<String, String> params);
}
