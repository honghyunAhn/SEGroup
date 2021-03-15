package com.aracomm.changbi.learn.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aracomm.changbi.learn.dao.CourseDao;
import com.aracomm.changbi.learn.vo.CardinalSearchVo;
import com.aracomm.changbi.learn.vo.CourseSearchVo;

@Service
public class CourseService {
	private static final Logger logger = LoggerFactory.getLogger(CourseService.class);

	@Autowired
	private CourseDao dao;

	public List<HashMap<String,String>> code(String param) {
		return dao.code(param);
	}
	public List<HashMap<String,String>> slide() {
		return dao.slide();
	}
	public List<HashMap<String,String>> selectCourseList(HashMap<String,String> param) {
		return dao.selectCourseList(param);
	}
	public int selectCourseListTotCnt(HashMap<String,String> param) {
		return dao.selectCourseListTotCnt(param);
	}

	public List<HashMap<String, Object>> selectCourseCardinalListAll(String course_id) {
		return dao.selectCourseCardinalListAll(course_id);
	}

	public List<HashMap<String, Object>> selectCardinalBySeq(String cardinal_seq) {
		return dao.selectCardinalBySeq(cardinal_seq);
	}

	public List<HashMap<String,Object>> selectCourseCardinalList(CardinalSearchVo searchVo) {
		searchVo.setTotalCnt(dao.selectCourseCardinalListTotCnt(searchVo));
		return dao.selectCourseCardinalList(searchVo);
	}

	public List<HashMap<String,String>> selectCourseChapterListAll(String course_id) {
		return dao.selectCourseChapterListAll(course_id);
	}

	public List<HashMap<String, Object>> selectGroupLearnList(Map<String, String> param) {
		return dao.selectGroupLearnList(param);
	}

	public HashMap<String, Object> selectGroupLearn(Map<String, String> param) {
		return dao.selectGroupLearn(param);
	}

	public List<Map<String, Object>> selectMainRecommCourseList(CourseSearchVo searchVo) {
		searchVo.setTotalCnt(dao.selectMainRecommCourseListTotCnt(searchVo));
		return dao.selectMainRecommCourseList(searchVo);
	}

	public List<Map<String, Object>> selectMainCourseListAllByCourse(CourseSearchVo searchVo) {
		return dao.selectMainCourseListAllByCourse(searchVo);
	}

	public List<Map<String, Object>> selectMainGroupLearnBannerList() {
		return dao.selectMainGroupLearnBannerList();
	}

	public Map<String, Object> selectCourseDetail(HashMap<String, String> param) {
		return dao.selectCourseDetail(param);
	}
	public Map<String, Object> selectCardinalCourseDetail(HashMap<String, String> param) {
		return dao.selectCardinalCourseDetail(param);
	}
	public int updateCourseHitsOrderPlus(String course_id) {
		return dao.updateCourseHitsOrderPlus(course_id);
	}
	public int updateCourseSellOrderPlus(String course_id) {
		return dao.updateCourseSellOrderPlus(course_id);
	}
	public List<Map<String, String>> selectCourseCategoryListForMenu() {
		return dao.selectCourseCategoryListForMenu();
	}
	public Map<String, Object> selectCourseMainBookInfo(String course_id) {
		return dao.selectCourseMainBookInfo(course_id);
	}

}
