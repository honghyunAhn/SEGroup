package com.aracomm.changbi.course.dao;

import java.util.HashMap;
import java.util.List;

public interface LmsCourseDao {

	public List<HashMap<String, String>> selectCourseList();
	
	public List<HashMap<String, String>> selectCourseBoardList(HashMap<String, String> param);

	public int selectCourseListTotCnt(HashMap<String, String> param);
	
	public HashMap<String, String> getUserInfo(String user_id);
	
	public List<HashMap<String, String>> checkCardinalMatched(String course_id);

	public int checkValidCardinalExist(HashMap<String, String> param);
	
	public int insertCardinal(HashMap<String, Object> param);
	
	public int insertCardinalCourseInfo(HashMap<String, String> param);
	
	public Integer selectMaxCardinalSeq();
	
	public String selectCardinalId(HashMap<String, String> param);
	
	public int insertApply(HashMap<String, String> param);
	
	public HashMap<String, Object> selectCourseDetail(String course_id);
	
	public List<HashMap<String, String>> selectCourseChapterListAll(String course_id);
	
	public List<HashMap<String, String>> selectCardinalList(HashMap<String, String> param);
	
	public List<HashMap<String, String>> selectSearchCourseList(HashMap<String, String> param);
	
	public int searchCourseListTotCnt(HashMap<String, String> param);
	
	public int selectLearnAppId(HashMap<String, String> param);
	
	public int selectEnrolledListCnt(HashMap<String, String> param);
	
	public int selectCbCnCardinalCnt(HashMap<String, String> param);

	public int insertLearnCancelApp(HashMap<String, Object> param);

	public int changeLearnPaymentState(String id);

	public HashMap<String, String> selectLearnCancelInfo(HashMap<String, String> param);

	public int updateLearnCancelInfo(HashMap<String, Object> param);

	public int deleteRefundInfo(String learn_id);

	public int updateLearnAppState(String learn_id);

	public int updateUserInfo(HashMap<String, String> param);

	public int updateAdditionalUserInfo(HashMap<String, String> param);

	public int insertAdditionalUserInfo(HashMap<String, String> param);

	public String getCourse(String gisu);
	
	public HashMap<String, Object> getCardinalDetail(String cardinalId);
	
	//목차/페이지 조회(포팅)
	public List<HashMap<String, String>> getChapPage(HashMap<String, String> param);
	//목차/페이지 조회(링크)
	public List<HashMap<String, String>> getChapPage2(HashMap<String, String> param);
	//입과시 수강정보 생성
	public int insertAttLec(HashMap<String, Object> param);
	
	/* public String searchCoursePage(String course_id); */
	
	public int insertEduUserRefundTb(HashMap<String, Object> param);
	public int deletePayUserRefundTb(String pay_user_seq);
	public int updateEduUserPayTb(String pay_user_seq);
	public int refundUpdate(String pay_user_seq);
	public int payBackUpdateSubmit(HashMap<String, Object> param);
	
	public int insertCurriculumPayInfo(HashMap<String, Object> param);
	
	public int selectCurriculumPayInfo(HashMap<String, Object> param);
	
	public List<HashMap<String, Object>> selectAvailableCourse();
	
	// 토플 리스트 조회
	public List<HashMap<String, String>> selectToefl(HashMap<String, String> map);
	
	// 토플 리스트 갯수
	public int selectToeflCnt(HashMap<String, String> map);
	
	// 토플 결제
	public int user_pay_toefl(HashMap<String, String> map);
	
	// 토플 결제 리스트 조회
	public List<HashMap<String, String>> selectToeflPay(HashMap<String, String> map);
	
	// 토플 결제 리스트 갯수
	public int selectToeflPayCnt(HashMap<String, String> map);
	
	// 토플 결제 리스트 갯수
	public int insertToeflUserRefundTb(HashMap<String, Object> map);
		
	// 토플 결제 리스트 갯수
	public int refundToeflUpdate(HashMap<String, Object> param);
	
}