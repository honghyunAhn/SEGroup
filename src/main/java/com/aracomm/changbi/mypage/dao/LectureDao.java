package com.aracomm.changbi.mypage.dao;

import java.util.HashMap;
import java.util.List;

import com.aracomm.changbi.user.vo.SurveyAnswerVO;

public interface LectureDao {

	HashMap<String,Object> selectPointInfo(HashMap<String, Object> params);
	HashMap<String,Object> selectUserInfo(HashMap<String, Object> params);
	List<HashMap<String,Object>> selectProgressList(HashMap<String, Object> params);
	List<HashMap<String,Object>> selectWaitingList(HashMap<String, Object> params);
	List<HashMap<String,Object>> selectCompleteList(HashMap<String, Object> params);
	String selectBookPayCheck(HashMap<String, Object> params);
	String selectBookDeliveryCheck(HashMap<String, Object> params);
	String selectBookPayment(HashMap<String, Object> params);

	HashMap<String,Object> selectClassInfo(HashMap<String, Object> params);
	String selectTotLearnTime(HashMap<String, Object> params);
	String selectAvgLearnTime(HashMap<String, Object> params);
	String selectBaseLearnTime(HashMap<String, Object> params);

	String selectUserJindo(HashMap<String, Object> params);
	String selectBaseJindo(HashMap<String, Object> params);
	HashMap<String, Object> selectClassStudyHist(HashMap<String, Object> params);
	String selectClassAvgStudyTime(HashMap<String, Object> params);
	String selectClassAvgChapter(HashMap<String, Object> params);
	List<HashMap<String, Object>> selectJindoList(HashMap<String, Object> params);

	List<HashMap<String, Object>> selectChapterList(HashMap<String, Object> params);
	HashMap<String, Object> selectChapterInfo(HashMap<String, Object> params);

	HashMap<String, String> selectAttLec(HashMap<String, Object> params);
	void insertAttLec(HashMap<String, Object> params);
	void insertAttLecHist(HashMap<String, Object> params);
	void updateAttLec(HashMap<String, Object> params);
	void updateAttLecHist(HashMap<String, Object> params);

	List<HashMap<String, Object>> selectExamList(HashMap<String, Object> params);
	List<HashMap<String, Object>> selectExamItemList(HashMap<String, Object> params);
	HashMap<String, Object> selectExamInfo(HashMap<String, Object> params);
	int selectExamTakeCount(HashMap<String, Object> params);
	int insertExamTakeHistory(HashMap<String, Object> params);
	int insertExamReport(HashMap<String, Object> reportMap);
	void insertExamReply(HashMap<String, Object> answerMap);
	void updateLocaleCode(HashMap<String, Object> params);

	List<HashMap<String, Object>> selectOrderBookList(HashMap<String, Object> params);
	int selectLessonReviewCnt(HashMap<String, Object> params);
	int insertLessonReview(HashMap<String, Object> params);
	HashMap<String, Object> selectClassPollInfo(HashMap<String, Object> params);
	List<HashMap<String, Object>> selectClassPollList(HashMap<String, Object> params);
	int insertSurveyResponse(HashMap<String, Object> params);
	List<HashMap<String, Object>> selectExamSpotList(HashMap<String, Object> params);
	int insertExamSpot(HashMap<String, Object> params);
	HashMap<String, Object> selectExamPrintInfo(HashMap<String, Object> params);
	HashMap<String, Object> selectReportInfo(HashMap<String, Object> params);
	List<HashMap<String, Object>> selectExamReplyList(HashMap<String, Object> params);

	void deleteExamReport(HashMap<String, Object> deleteMap);
	void deleteExamReply(HashMap<String, Object> deleteMap);
	List<HashMap<String, Object>> selectCopyRatioList(HashMap<String, Object> hashMap);
	int updateCancelWaitingApp(HashMap<String, Object> params);
	
	List<HashMap<String, Object>> selectSurveyDetail(HashMap<String, Object> params);
	int insertSurveyAnswer(List<SurveyAnswerVO> list);
	int insertSurveyComplete(SurveyAnswerVO vo);
	int updateSurveyAnswer(List<SurveyAnswerVO> list);
}
