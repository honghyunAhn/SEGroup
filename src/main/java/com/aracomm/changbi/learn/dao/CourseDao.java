package com.aracomm.changbi.learn.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.aracomm.changbi.learn.vo.CardinalSearchVo;
import com.aracomm.changbi.learn.vo.CourseSearchVo;

public interface CourseDao {

	// 연수신청 LEFT메뉴 데이터 조회
	List<Map<String, String>> selectCourseCategoryListForMenu();


	List<HashMap<String, String>> code(String course);
	List<HashMap<String, String>> slide();
	List<HashMap<String, String>> selectCourseList(HashMap<String,String> param);
	int selectCourseListTotCnt(HashMap<String,String> param);

	HashMap<String, Object> selectCourseDetail(HashMap<String, String> param);
	HashMap<String, Object> selectCardinalCourseDetail(HashMap<String, String> param);
	HashMap<String, Object> selectCourseMainBookInfo(String course_id);

	List<HashMap<String, Object>> selectCourseCardinalListAll(String course_id);
	List<HashMap<String, String>> selectCourseChapterListAll(String course_id);
	List<HashMap<String, Object>> selectCourseCardinalList(CardinalSearchVo searchVo);
	int selectCourseCardinalListTotCnt(CardinalSearchVo searchVo);

	List<HashMap<String, String>> groupList(HashMap<String,String> param);
	HashMap<String, String> groupDetail(HashMap<String,String> param);

	List<HashMap<String, Object>> selectGroupLearnList(Map<String, String> param);
	HashMap<String, Object> selectGroupLearn(Map<String, String> param);

	// 순위갱신
	int updateCourseHitsOrderPlus(String course_id);
	int updateCourseSellOrderPlus(String course_id);

	// main 화면
	int selectMainRecommCourseListTotCnt(CourseSearchVo searchVo);
	List<Map<String, Object>> selectMainRecommCourseList(CourseSearchVo searchVo);
	List<Map<String, Object>> selectMainCourseListAllByCourse(CourseSearchVo searchVo);
	List<Map<String, Object>> selectMainGroupLearnBannerList();


	List<HashMap<String, Object>> selectCardinalBySeq(String cardinal_seq);


}
