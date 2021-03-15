package com.aracomm.changbi.teacher.dao;

import java.util.List;
import java.util.Map;

import com.aracomm.changbi.teacher.vo.TeacherSearchVo;

public interface TeacherDao {
	int selectTeacherListTotCnt(TeacherSearchVo searchVo);
	List<Map<String, Object>> selectTeacherList(TeacherSearchVo searchVo);
	Map<String, Object> selectTeacher(String id);
	List<Map<String, Object>> selectTeacherCourseListAll(String id);
	List<Map<String, Object>> selectTeacherTccListAll(String id);

	// main화면 노출 강사
	List<Map<String, Object>> selectMainTeacherList(int top);
}
