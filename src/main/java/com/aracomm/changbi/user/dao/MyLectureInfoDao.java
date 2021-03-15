package com.aracomm.changbi.user.dao;

import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;

import com.aracomm.changbi.user.vo.SurveyAnswerVO;
import com.aracomm.changbi.user.vo.SurveyQuestionVO;

import com.aracomm.changbi.user.vo.UserScoreVO;

import com.aracomm.changbi.user.vo.AttendanceInfoTime;
import com.aracomm.changbi.user.vo.GisuCategoryVO;


public interface MyLectureInfoDao {
	List<HashMap<String,String>> searchtUserTestInfo(UserScoreVO vo);
	
	List<HashMap<String,String>> searchtCategoryInfo(UserScoreVO vo);
	
	List<HashMap<String, String>> TestListAll(GisuCategoryVO testVO);
	
	List<HashMap<String, String>> createUpperCategory(GisuCategoryVO testVO) throws Exception;

	List<HashMap<String, Object>> selectSurveyList(HashMap<String, Object> params);

	List<HashMap<String, Object>> selectSurveyDetail(HashMap<String, Object> params);

	int insertSurveyAnswer(List<SurveyAnswerVO> list);

	int insertSurveyComplete(SurveyAnswerVO vo);

	int updateSurveyAnswer(List<SurveyAnswerVO> list);

	String selectCheckOnline(String crc_id);

	List<HashMap<String, String>> searchGrade(HashMap<String,Object> params);
	
	int updateReportReply(HashMap<String, Object> params);
	
	String selectLearnAppId(HashMap<String, Object> params);
	
	List<HashMap<String, Object>> selectExamTime(HashMap<String, Object> params);
	
	int updateReport(HashMap<String, Object> params);
	
	// 김태원
	List<HashMap<String, Object>> attendance(HashMap<String, Object> params);
	
	// 20 09 23 김태원
	int allSisuCount(HashMap<String, Object> param);
	int monthSisuCount(HashMap<String, Object> param);
	
	int allAttendStatus(HashMap<String, Object> param);
	int monthAttendStatus(HashMap<String, Object> param);
	
	// 20 09 25 김태원
	HashMap<String, Object> getAllSisuCheck(HashMap<String, Object> param);
	int getAllRestSisu(HashMap<String, Object> dateMap);
	int getRestSisu(HashMap<String, Object> dateMap);
	
	// 20 09 28 김태원
	ArrayList<HashMap<String, Object>> getAllAttend(HashMap<String, Object> param);
	int getAttendCount(HashMap<String, Object> map);
	int getMissedCount(HashMap<String, Object> temp);
	
	// 20 09 29 김태원
	ArrayList<HashMap<String, Object>> getMonthAttend(HashMap<String, Object> param);
	
	ArrayList<HashMap<String, Object>> selectSurveyAnswer(HashMap<String, Object> params);

	ArrayList<SurveyQuestionVO> selectClosedSurvey(HashMap<String, Object> params);
	
	// 200929 양승균
	int testCount(String seq);
	
	List<HashMap<String, String>> callSmallCategory(GisuCategoryVO testVO);
	
	int getAllSisu(HashMap<String, Object> param);
	int getMonthSisu(HashMap<String, Object> param);
	int allCheckAttendCount(HashMap<String, Object> test);
	int allMissedAttendCount(HashMap<String, Object> test);
	
	HashMap<String, Object> getInfoTime(HashMap<String, Object> paramMap);
	List<HashMap<String, Object>> getInfoList(HashMap<String, Object> paramMap);
	
	void subCertification(AttendanceInfoTime infoTime);
}
