package com.aracomm.changbi.user.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aracomm.base.common.vo.FileVo;
import com.aracomm.changbi.user.dao.MyLectureDao;

@Service
public class MyLectureService {
	/**LMS 나의 강의실 Service **/
	
	@Autowired
	MyLectureDao dao;
	
	
	public List<HashMap<String,Object>> selectProgressList(HashMap<String, Object> params) {
		return dao.selectProgressList(params);
	}
	public int selectProgressListTotalCnt (HashMap<String, Object> params) {
		return dao.selectProgressListTotalCnt(params);
	}
	public List<HashMap<String,Object>> selectWaitingList(HashMap<String, Object> params) {
		return dao.selectWaitingList(params);
	}
	public int selectWaitingListTotalCnt (HashMap<String, Object> params) {
		return dao.selectWaitingListTotalCnt(params);
	}
	public List<HashMap<String,Object>> selectCompleteList(HashMap<String, Object> params) {
		return dao.selectCompleteList(params);
	}
	public int selectCompleteListTotalCnt (HashMap<String, Object> params) {
		return dao.selectCompleteListTotalCnt(params);
	}
	public List<HashMap<String, Object>> selectChapterList(HashMap<String, String> params) {
		return dao.selectChapterList(params);
	}
	public List<HashMap<String, Object>> selectChapPageList(HashMap<String, String> params) {
		return dao.selectChapPageList(params);
	}
	public HashMap<String, Object> selectChapterInfo(HashMap<String, Object> params) {
		//서브챕터가 있는 과목(포팅방식)
		if(params.get("portYn").equals("Y")) return dao.selectChapterInfo(params);
		else return dao.selectChapterInfo2(params);
	}
	public List<HashMap<String,Object>> courseBoardList(HashMap<String,Object> params) {
		return dao.courseBoardList(params);
	}
	public List<HashMap<String,Object>> surveyList(HashMap<String,Object> params) {
		return dao.surveyList(params);
	}
	public List<HashMap<String,Object>> attendanceList(HashMap<String,Object> params) {
		return dao.attendanceList(params);
	}
	public void insertAttLecHistory(HashMap<String,Object> params) {
		//서브챕터가 있는 과목(포팅방식)
		if(params.get("SEQ") != null) dao.insertAttLecHistory(params);
		//서브챕터가 없는 과목(링크방식)
		else dao.insertAttLecHist(params);
	}
	/* smtp */
	public List<HashMap<String,Object>> smtpSelectProgressList(HashMap<String, Object> params) {
		return dao.smtpSelectProgressList(params);
	}
	public int smtpSelectProgressListTotalCnt (HashMap<String, Object> params) {
		return dao.smtpSelectProgressListTotalCnt(params);
	}
	public List<HashMap<String,Object>> smtpSelectWaitingList(HashMap<String, Object> params) {
		return dao.smtpSelectWaitingList(params);
	}
	public int smtpSelectWaitingListTotalCnt (HashMap<String, Object> params) {
		return dao.smtpSelectWaitingListTotalCnt(params);
	}
	public List<HashMap<String,Object>> smtpSelectCompleteList(HashMap<String, Object> params) {
		return dao.smtpSelectCompleteList(params);
	}
	public int smtpSelectCompleteListTotalCnt (HashMap<String, Object> params) {
		return dao.smtpSelectCompleteListTotalCnt(params);
	}
	
	//파일 다운로드
	public FileVo attachFileInfo(String file_id) {
		return dao.attachFileInfo(file_id);
	}
	
	public void insertStudyHistory(HashMap<String, Object> param) {
		dao.insertAttLec(param);
		dao.insertAttLecHist(param);
	}
	public boolean setProgYn(HashMap<String, Object> param) {
		if(dao.setProgYn(param)>0) return true;
		else return false;
	}
	public boolean setProgYnLink(HashMap<String, Object> param) {
		if(dao.setProgYnLink(param)>0) return true;
		else return false;
	}
	// 입과확인
	public HashMap<String, String> learnCheck(HashMap<String, String> params) {
		return dao.learnCheck(params);
	}
}
