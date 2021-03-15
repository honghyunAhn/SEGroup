package com.aracomm.changbi.teacher.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.aracomm.base.common.vo.FileVo;
import com.aracomm.changbi.board.vo.BoardSearchVo;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.common.service.CommonService;
import com.aracomm.changbi.learn.service.CourseService;
import com.aracomm.changbi.serviceCenter.service.BbsService;
import com.aracomm.changbi.teacher.service.TeacherService;
import com.aracomm.changbi.teacher.vo.TeacherSearchVo;

@Controller
@RequestMapping(value="/teacher")
public class TeacherController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(TeacherController.class);

	@Autowired
	private TeacherService service;

	@Autowired
	private CommonService commonService;

	@Autowired
	private BbsService bbsService;

	@Autowired
	private CourseService courseService;

	@RequestMapping(value = "/list")
	public String v(TeacherSearchVo searchVo, Model model) {

		searchVo.setVisiblePages(12); // 12개씩 페이징
		model.addAttribute("courseList", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_COURSE));
		model.addAttribute("searchVo", searchVo);
		model.addAttribute("teacherList", service.selectTeacherList(searchVo));
        model.addAttribute("courseCategoryList", courseService.selectCourseCategoryListForMenu());

		return "teacher/teacher";
	}

	@RequestMapping(value = "/detail")
	public String detail(TeacherSearchVo searchVo, Model model) {

		String teacher_id = searchVo.getId();
		List<Map<String, Object>> tccList = service.selectTeacherTccListAll(teacher_id);
		List<Map<String, Object>> courseList = service.selectTeacherCourseListAll(teacher_id);
		Map<String, Object> teacher = service.selectTeacher(teacher_id);


		// 연수후기
		BoardSearchVo boardSearchVo = new BoardSearchVo();
		boardSearchVo.setTeacher_id(teacher_id);
		boardSearchVo.setBoard_type(GlobalConst.BBS_TYPE_REVIEW);
		boardSearchVo.setTop(4);
		List<Map<String, Object>> reviewList = bbsService.selectSimpleTopBoardList(boardSearchVo);

		// 질의응답
		boardSearchVo.setBoard_type(GlobalConst.BBS_TYPE_QNA);
		List<Map<String, Object>> qnaList = bbsService.selectSimpleTopBoardList(boardSearchVo);

		// 공지사항
		boardSearchVo.setBoard_type(GlobalConst.BBS_TYPE_NOTICE);
		List<Map<String, Object>> noticeList = bbsService.selectSimpleTopBoardList(boardSearchVo);

		model.addAttribute("searchVo", searchVo);
		model.addAttribute("teacher", teacher);
		model.addAttribute("tccList", tccList);
		model.addAttribute("courseList", courseList);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("courseCategoryList", courseService.selectCourseCategoryListForMenu());

		return "teacher/teacherdetail";
	}

	@RequestMapping(value = "/board/layerdetail")
	public String replyDetail(Model model, @RequestParam HashMap<String,String> param) {
		// 첨부파일 리스트
		List<String> file_ids = new ArrayList<String>();
        HashMap<String, String> detail = bbsService.selectBbsDetail(param);
        String fileId = detail.get("attach1_file");
        if (!StringUtils.isEmpty(fileId)) file_ids.add(fileId);
        fileId = detail.get("attach2_file");
        if (!StringUtils.isEmpty(fileId)) file_ids.add(fileId);
        List<FileVo> fileList = null;
        if (file_ids.size() > 0) {
        	fileList = commonService.selectAttachFileListByIds(file_ids.toArray(new String[0]));
        }

        // 조회수 증가
        bbsService.updateHits(param.get("id"));

		model.addAttribute("board_type", param.get("board_type"));
		model.addAttribute("detail", detail);
		model.addAttribute("fileList", fileList);

		return "common/board/layerdetail";
	}



}
