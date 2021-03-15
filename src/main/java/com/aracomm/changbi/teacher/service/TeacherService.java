package com.aracomm.changbi.teacher.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aracomm.changbi.teacher.dao.TeacherDao;
import com.aracomm.changbi.teacher.vo.TeacherSearchVo;

@Service
public class TeacherService {

	@Autowired
	TeacherDao dao;

	public List<Map<String, Object>> selectTeacherList(TeacherSearchVo searchVo) {
		searchVo.setTotalCnt(dao.selectTeacherListTotCnt(searchVo));
		return dao.selectTeacherList(searchVo);
	}

	public Map<String, Object> selectTeacher(String id) {
		return dao.selectTeacher(id);
	}

	public List<Map<String, Object>> selectTeacherCourseListAll(String teacher_id) {
		return dao.selectTeacherCourseListAll(teacher_id);
	}

	public List<Map<String, Object>> selectTeacherTccListAll(String teacher_id) {
		return dao.selectTeacherTccListAll(teacher_id);
	}

	public List<Map<String, Object>> selectMainTeacherList(int top) {
		return dao.selectMainTeacherList(top);
	}

}
