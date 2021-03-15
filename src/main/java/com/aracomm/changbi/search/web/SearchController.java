package com.aracomm.changbi.search.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.learn.service.CourseService;
import com.aracomm.changbi.serviceCenter.service.BbsService;
import com.aracomm.changbi.teacher.service.TeacherService;
import com.aracomm.changbi.teacher.vo.TeacherSearchVo;

@Controller
public class SearchController extends BaseController {
	@Autowired
	BbsService bbsService;

	@Autowired
	TeacherService teacherService;

	@Autowired CourseService courseService;


	@RequestMapping(value = "/search")
	public String join3(@RequestParam(required=false) String keyword, Model model) {
		if (StringUtils.isBlank(keyword)) {
			return "redirect:/";
		}

		// 직무과정
		HashMap<String, String> param2 = new HashMap<String, String>();
		param2.put("learn_types", "J");
		param2.put("searchbox", "se");
		param2.put("search", keyword);
		List<HashMap<String, String>> courseList = courseService.selectCourseList(param2);
		model.addAttribute("courseList", courseList);

		// 강사
		TeacherSearchVo teacherSearchVo = new TeacherSearchVo();
		teacherSearchVo.setSearchCondition("NMC");
		teacherSearchVo.setSearchKeyword(keyword);
		teacherSearchVo.setSearchall("nopaging");
		List<Map<String, Object>> teacherList = teacherService.selectTeacherList(teacherSearchVo);
		model.addAttribute("teacherList", teacherList);

		// 연수후기
		HashMap<String,String> param = new HashMap<String, String>();
		param.put("search", keyword);
		List<HashMap<String, String>> bbsList = bbsService.selectSearchReviewListAll(param);
		model.addAttribute("bbsList", bbsList);

		return "search/search";
	}
}
