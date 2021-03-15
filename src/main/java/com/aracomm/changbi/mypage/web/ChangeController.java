package com.aracomm.changbi.mypage.web;

import java.security.Principal;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aracomm.base.common.AraCommConst;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.common.service.CommonService;
import com.aracomm.changbi.mypage.service.ChangeService;
import com.aracomm.changbi.mypage.vo.LectureSearchVo;
import com.aracomm.changbi.user.vo.UserVo;

@Controller
@RequestMapping(value = "/mypage/change")
public class ChangeController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(ChangeController.class);

	@Autowired
	private ChangeService service;

	@Autowired
	private CommonService commonService;

	@Value("#{config['boardPages']}")
	int boardPages;

	@RequestMapping(value = "/change")
	public String change(Model model, LectureSearchVo searchVO, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		searchVO.setUser_id(user_id);
		searchVO.setVisiblePages(boardPages);

		model.addAttribute("searchVO", searchVO);
		model.addAttribute("list", service.selectChangeableLectureList(searchVO));
		model.addAttribute("emailList", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_EMAIL));
		model.addAttribute("phone1List", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_PHONE1));
		model.addAttribute("tel1List", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_TEL1));

		return "mypage/change/change";
	}

	@RequestMapping(value="/searchChangeableLectureAjax")
	public @ResponseBody Object searchChangeableLectureAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String, Object> lectureInfo = service.selectCurrentLecture(params);
		params.put("cardinal", (String) lectureInfo.get("CARDINAL_ID"));
		params.put("course", (String) lectureInfo.get("COURSE_ID"));
		params.put("credit", (int) lectureInfo.get("CREDIT"));

		HashMap<String, Object> result = new HashMap<>();
		result.put("lecture", lectureInfo);
		result.put("list", service.selectChangeableLecture(params));

		return result;
	}

	@RequestMapping(value="/saveChangeLectureAjax")
	public @ResponseBody Object saveChangeLectureAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String, Object> result = new HashMap<>();
		try {
			int id = service.saveChangeLecture(params);
			result.put("result", id>0?AraCommConst.TEXT_SUCCESS:AraCommConst.TEXT_FAIL);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", AraCommConst.TEXT_FAIL);
		}

		return result;
	}

	@RequestMapping(value="/searchDelayableLectureAjax")
	public @ResponseBody Object searchDelayableLectureAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String, Object> lectureInfo = service.selectCurrentLecture(params);
		UserVo vo = (UserVo) ((Authentication)SecurityContextHolder.getContext().getAuthentication()).getPrincipal();

		params.put("cardinal", (String) lectureInfo.get("CARDINAL_ID"));
		params.put("course", (String) lectureInfo.get("COURSE_ID"));
		params.put("credit", (int) lectureInfo.get("CREDIT"));

		HashMap<String, Object> result = new HashMap<>();
		result.put("lecture", lectureInfo);
		result.put("user", vo);
		result.put("list", service.selectDelayableLecture(params));

		return result;
	}

	@RequestMapping(value="/saveDelayLectureAjax")
	public @ResponseBody Object saveDelayLectureAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String, Object> result = new HashMap<>();
		try {
			int id = service.saveDelayLecture(params);
			result.put("result", id>0?AraCommConst.TEXT_SUCCESS:AraCommConst.TEXT_FAIL);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", AraCommConst.TEXT_FAIL);
		}

		return result;
	}

	@RequestMapping(value="/searchCancelableLectureAjax")
	public @ResponseBody Object searchCancelableLectureAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String, Object> lectureInfo = service.selectCurrentLecture(params);
		UserVo vo = (UserVo) ((Authentication)SecurityContextHolder.getContext().getAuthentication()).getPrincipal();

		HashMap<String, Object> result = new HashMap<>();
		result.put("lecture", lectureInfo);
		result.put("user", vo);

		return result;
	}

	@RequestMapping(value="/saveCancelLectureAjax")
	public @ResponseBody Object saveCancelLectureAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String, Object> result = new HashMap<>();
		try {
			int id = service.saveCancelLecture(params);
			result.put("result", id>0?AraCommConst.TEXT_SUCCESS:AraCommConst.TEXT_FAIL);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", AraCommConst.TEXT_FAIL);
		}

		return result;
	}

	@RequestMapping(value="/lectureCancelAjax")
	public @ResponseBody Object lectureCancelAjax(Model model, @RequestParam HashMap<String,String> params, Principal principal) {
		return null;
	}

	@RequestMapping(value = "/result")
	public String result(Model model, LectureSearchVo searchVO, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		searchVO.setUser_id(user_id);
		searchVO.setVisiblePages(boardPages);

		//TODO : 연수 연기/변경/취소 신청결과 조회


		model.addAttribute("searchVO", searchVO);
		model.addAttribute("list", service.selectChangedLectureList(searchVO));

		return "mypage/change/result";
	}
}
