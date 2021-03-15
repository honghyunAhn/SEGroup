package com.aracomm.changbi.mypage.web;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aracomm.changbi.mypage.service.LectureService;
import com.aracomm.changbi.user.vo.UserVo;

@Controller
@RequestMapping(value = "/class/study")
public class PlayerController {
	private static final Logger logger = LoggerFactory.getLogger(PlayerController.class);

	@Autowired
	private LectureService service;

	@RequestMapping(value="/player")
	public String report(Model model, @RequestParam HashMap<String,Object> params ) {
		UserVo vo = (UserVo) ((Authentication)SecurityContextHolder.getContext().getAuthentication()).getPrincipal();
		params.put("user_id", vo.getUsername());

		model.addAttribute("classParam", params);
		model.addAttribute("classInfo", service.selectClassInfo(params));
		model.addAttribute("chapterInfo", service.selectChapterInfo(params));

		if (!params.get("op").equals("preview")) {
			service.insertStudyHistory(params);
		}

		return "class/study/player";
	}

	/*
	 * AjaxSessionTimeoutFilter 참고
	 * https://m.blog.naver.com/PostView.nhn?blogId=cutesboy3&logNo=220794371997
	 * */
//	@RequestMapping(value="/enrollHistory",produces="application/json; charset=utf-8")
//	public @ResponseBody HashMap<String, Object> enrollStudyHistory(Model model, @RequestParam HashMap<String,Object> params ) {
//		UserVo vo = (UserVo) ((Authentication)SecurityContextHolder.getContext().getAuthentication()).getPrincipal();
//		params.put("user_id", vo.getUsername());
//
//		service.updateStudyHistory(params);
//
//		HashMap<String, Object> result = new HashMap<>();
//		result.put("RESULT", "SUCCESS");
//		return result;
//	}
}
