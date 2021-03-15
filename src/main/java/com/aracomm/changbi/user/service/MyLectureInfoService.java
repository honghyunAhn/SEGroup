package com.aracomm.changbi.user.service;

import java.util.HashMap;
import java.util.List;


import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.aracomm.base.common.AraCommConst;
import com.aracomm.changbi.user.dao.MyLectureInfoDao;
import com.aracomm.changbi.user.vo.UserScoreVO;

import global.segroup.util.FileService;

import com.aracomm.changbi.user.vo.AttendanceInfoTime;
import com.aracomm.changbi.user.vo.GisuCategoryVO;
import com.aracomm.changbi.user.vo.SurveyAnswerVO;
import com.aracomm.changbi.user.vo.SurveyQuestionVO;


@Service
public class MyLectureInfoService {

	@Autowired
	MyLectureInfoDao infoDao;
	
	@Value("#{props['user.attendance.cert']}")
	private String certSavedLocation;
	
	public List<HashMap<String,String>> searchtUserTestInfo(UserScoreVO vo){
		List<HashMap<String, String>> List = infoDao.searchtUserTestInfo(vo);
		return List;
	}
	
	public List<HashMap<String,String>> searchtCategoryInfo(UserScoreVO vo){
		List<HashMap<String, String>> List = infoDao.searchtCategoryInfo(vo);
		return List;
	}
	
	public List<HashMap<String, String>> TestListAll(GisuCategoryVO testVO) {
		List<HashMap<String, String>> List = infoDao.TestListAll(testVO);
		return List;
	}
	public List<HashMap<String, String>> createUpperCategory(GisuCategoryVO vo) throws Exception {
		List<HashMap<String, String>> List = infoDao.createUpperCategory(vo);
		return List;
	}
	
	public List<HashMap<String, String>> searchGrade(HashMap<String,Object> params) {
		List<HashMap<String, String>> map = infoDao.searchGrade(params);
		return map;
	}
	
	public List<HashMap<String, Object>> selectSurveyList(HashMap<String, Object> params) {
		return infoDao.selectSurveyList(params);
	}

	public List<HashMap<String, Object>> selectSurveyDetail(HashMap<String, Object> params) {
		return infoDao.selectSurveyDetail(params);
	}

	public int insertSurveyAnswer(List<SurveyAnswerVO> list) {
		return infoDao.insertSurveyAnswer(list);
	}

	public int insertSurveyComplete(SurveyAnswerVO vo) {
		return infoDao.insertSurveyComplete(vo);
	}

	public int updateSurveyAnswer(List<SurveyAnswerVO> list) {
		return infoDao.updateSurveyAnswer(list);
	}

	public String selectCheckOnline(String course_id) {
		return infoDao.selectCheckOnline(course_id);
	}

	// 김태원
	public List<HashMap<String, Object>> attendance(HashMap<String, Object> params) {
		return infoDao.attendance(params);
	}
	
	// 20 09 23 김태원
	public int allSisuCount(HashMap<String, Object> param) {
		return infoDao.allSisuCount(param);
	}
	
	public int monthSisuCount(HashMap<String, Object> param) {
		return infoDao.monthSisuCount(param);
	}
	
	public int allAttendStatus(HashMap<String, Object> param) {
		return infoDao.allAttendStatus(param);
	}
	
	public int monthAttendStatus(HashMap<String, Object> param) {
		return infoDao.monthAttendStatus(param);
	}
	
	// 20 09 28 김태원
	public ArrayList<HashMap<String, Object>> getAllAttend(HashMap<String, Object> param) {
		return infoDao.getAllAttend(param);
	}
	
	public ArrayList<HashMap<String, Object>> getMonthAttend(HashMap<String, Object> param) {
		return infoDao.getMonthAttend(param);
	}
	
	public int getAttendCount(HashMap<String, Object> map) {
		return infoDao.getAttendCount(map);
	}
	
	public int getMissedCount(HashMap<String, Object> temp) {
		return infoDao.getMissedCount(temp);
	}
	
	public HashMap<String, Object> getAllSisuCheck(HashMap<String, Object> param) {
		return infoDao.getAllSisuCheck(param);
	}
	
	public int getAllSisu(HashMap<String, Object> param) {
		return infoDao.getAllSisu(param);
	}
	
	public int getMonthSisu(HashMap<String, Object> param) {
		return infoDao.getMonthSisu(param);
	}
	
	public int getAllRestSisu(HashMap<String, Object> dateMap) {
		return infoDao.getAllRestSisu(dateMap);
	}
	
	public int getRestSisu(HashMap<String, Object> dateMap) {
		return infoDao.getRestSisu(dateMap);
	}
	
	public ArrayList<HashMap<String, Object>> selectSurveyAnswer(HashMap<String, Object> params) {
		return infoDao.selectSurveyAnswer(params);
	}

	public ArrayList<SurveyQuestionVO> selectClosedSurvey(HashMap<String, Object> params) {
		return infoDao.selectClosedSurvey(params);
	}
	
	public String updateReportReply(HashMap<String, Object> params) {
		int value = Integer.parseInt(String.valueOf(params.get("value")));

		HashMap<String, Object> answerChange = new HashMap<>();

		answerChange.put("report", params.get("report_id"));
		answerChange.put("bank", params.get("bank"));

		if(params.get("answer"+value) != null) {
			answerChange.put("reply", params.get("answer"+value));
		} else {
			answerChange.put("reply", "0");
		}

/*		System.out.println(answerChange.toString());*/
		
		if(infoDao.updateReportReply(answerChange) > 0) {
			return AraCommConst.TEXT_SUCCESS;
		} 
		else {
			return AraCommConst.TEXT_FAIL;
		}
	}
	
	public String SelectLearnAppId(HashMap<String, Object> params) {
		return infoDao.selectLearnAppId(params);
	}

	public List<HashMap<String, Object>> selectExamTime(HashMap<String, Object> params) {
		return infoDao.selectExamTime(params);
	}
	
	// 200929 양승균
	public int testCount(String seq) {
		return infoDao.testCount(seq);
	}
	
	public List<HashMap<String, String>> callSmallCategory(GisuCategoryVO testVO) {
		List<HashMap<String, String>> List = infoDao.callSmallCategory(testVO);
		return List;
	}
	
	public int allCheckAttendCount(HashMap<String, Object> test) {
		return infoDao.allCheckAttendCount(test);
	}
	
	public int allMissedAttendCount(HashMap<String, Object> test) {
		int allMissedAttendCount = infoDao.allMissedAttendCount(test);
		
		return allMissedAttendCount;
	}
	
	public HashMap<String, Object> getInfoTime(HashMap<String, Object> paramMap) {
		HashMap<String, Object> map = infoDao.getInfoTime(paramMap);
		
		return map;
	}
	
	public List<HashMap<String, Object>> getInfoList(HashMap<String, Object> paramMap) {
		List<HashMap<String, Object>> mapList = infoDao.getInfoList(paramMap);
		
		return mapList;
	}
	
	public void subCertification(AttendanceInfoTime infoTime) {
		
		String fullPath = "/" + infoTime.getUserId() + "_" + String.valueOf(infoTime.getCardinalId());
		
		System.out.println("Full Path Check : " + fullPath);
		if(!infoTime.getRegSavedFile().equals("") || infoTime.getRegSavedFile() != null) {
			if(!infoTime.getRegFile().isEmpty()) {
				String saved = infoTime.getRegSavedFile();
				FileService.deleteFile(saved, certSavedLocation + fullPath);
				
				String certificateSaved = FileService.saveFile(infoTime.getRegFile(), certSavedLocation + fullPath);
				infoTime.setRegSavedFile(certificateSaved);
				infoTime.setRegOriginFile(infoTime.getRegFile().getOriginalFilename());
			}
			infoDao.subCertification(infoTime);
		} else {
			String certificateSaved = FileService.saveFile(infoTime.getRegFile(), certSavedLocation + fullPath);
			infoTime.setRegSavedFile(certificateSaved);
			infoTime.setRegOriginFile(infoTime.getRegFile().getOriginalFilename());
			infoDao.subCertification(infoTime);
		}
	}
	
	public void deleteCertification(AttendanceInfoTime infoTime) {
		
		String fullPath = "/" + infoTime.getUserId() + "_" + String.valueOf(infoTime.getCardinalId());
		
		String saved = infoTime.getRegSavedFile();
		FileService.deleteFile(saved, certSavedLocation + fullPath);
		
		infoTime.setRegSavedFile(null);
		infoTime.setRegOriginFile(null);
		infoDao.subCertification(infoTime);
	}
}
