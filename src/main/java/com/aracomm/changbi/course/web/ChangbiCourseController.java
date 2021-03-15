package com.aracomm.changbi.course.web;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.changbi.course.service.ChangbiCourseService;
import com.aracomm.changbi.learn.web.PayController;
import com.aracomm.changbi.mypage.service.PointService;
import com.aracomm.changbi.user.service.UserService;
import com.inicis.std.util.HttpUtil;
import com.inicis.std.util.ParseUtil;
import com.inicis.std.util.SignatureUtil;

import global.segroup.society.edu.user.service.SocietyEduUserService;


@Controller
public class ChangbiCourseController {

	@Value("#{config['boardPages']}")
	String boardPages;

	@Autowired
	ChangbiCourseService courseService;
	
	@Autowired
	private UserService userService;

	@Autowired
	private PointService pointService;
	
	@Autowired
	private SocietyEduUserService seuService;

	private static final Logger logger = LoggerFactory.getLogger(ChangbiCourseController.class);

	/* ----------------------------------IT 관련 컨트롤러 모음 ---------------------------------------------*/

	@RequestMapping(value = "lms/course/it/sub01-01", method = RequestMethod.GET)
	public String sub01_01(Model model, String parent_menu, String son_menu, HttpServletRequest request) {

		logger.info("과정 - IT 페이지 이동 컨트롤러 시작");

		// leftmenu에 띄울 애들을 정리하기.		
		List<HashMap<String, String>> courseList = courseService.selectCourseList();
		model.addAttribute("parent_menu", parent_menu);
		model.addAttribute("son_menu", son_menu);
		model.addAttribute("courseList", courseList);
		
//		PayController pc = new PayController();
//		try {
//			model.addAttribute("buyertel","01065328833");
//		    model.addAttribute("buyername","sangsu");
//		    model.addAttribute("buyeremail","sss@sss.com");
//			model = pc.payInfo(model, request, "12000", "c000000048", "c000000048", "20200101", "20200131");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		logger.info("과정 - IT 페이지 이동 컨트롤러 종료");

		return "lms/course/it/sub01-01";
	}
	
	@RequestMapping(value = "lms/course/it/sub01-01-01-01", method = RequestMethod.GET)
	public String sub01_01_01_01(String course_id, Model model,HttpServletRequest request) {
				
		logger.info("과정 - IT 과정상세 페이지 이동 컨트롤러 시작");

		model.addAttribute("courseInfo", courseService.selectCourseDetail(course_id));
		List<HashMap<String, String>> chapterInfo = courseService.selectCourseChapterListAll(course_id);
		model.addAttribute("chapterInfo", chapterInfo);		
		
//		PayController pc = new PayController();
//		try {
//			model.addAttribute("buyertel","01065328833");
//		    model.addAttribute("buyername","sangsu");
//		    model.addAttribute("buyeremail","sss@sss.com");
//			model = pc.payInfo(model, request, "12000", "c000000048", "c000000048", "20200101", "20200131");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		//화면 좌측메뉴처리를 위한 모델세팅
		List<HashMap<String, String>> courseList = courseService.selectCourseList();
		model.addAttribute("courseList", courseList);
		model.addAttribute("moveFlag", "1");

		//마일리지 퍼센트 처리
		Map<String, Object> pointPolicy = pointService.selectPolicyPoint();
		int pointPercentage = (int)pointPolicy.get("SAVE_LECTURE_POINT");
		
		model.addAttribute("point_percentage_policy", pointPercentage);
		
		logger.info("과정 - IT 과정상세 페이지 이동 컨트롤러 끝");
		
		return "lms/course/it/sub01-01-01-01";
	}
		
	/* ----------------------------------IT 관련 컨트롤러 모음 ---------------------------------------------*/
	
	
	
	
	/* ----------------------------------외국어 관련 컨트롤러 모음 ---------------------------------------------*/

	@RequestMapping(value = "lms/course/foreign/sub02-01", method = RequestMethod.GET)
	public String sub02_01(Model model, String parent_menu, String son_menu, HttpServletRequest request) {

		logger.info("과정 - 외국어 페이지 이동 컨트롤러 시작");

		// leftmenu에 띄울 애들을 정리하기.		
		List<HashMap<String, String>> courseList = courseService.selectCourseList();
		model.addAttribute("parent_menu", parent_menu);
		model.addAttribute("son_menu", son_menu);
		model.addAttribute("courseList", courseList);
		
//		PayController pc = new PayController();
//		try {
//			model.addAttribute("buyertel","01065328833");
//		    model.addAttribute("buyername","sangsu");
//		    model.addAttribute("buyeremail","sss@sss.com");
//			model = pc.payInfo(model, request, "12000", "c000000048", "c000000048", "20200101", "20200131");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		logger.info("과정 - 외국어 페이지 이동 컨트롤러 종료");

		return "lms/course/foreign/sub02-01";
	}
	
	@RequestMapping(value = "lms/course/foreign/sub02-01-01-01", method = RequestMethod.GET)
	public String sub02_01_01_01(String course_id, Model model,HttpServletRequest request) {
				
		logger.info("과정 - 외국어 과정상세 페이지 이동 컨트롤러 시작");

		model.addAttribute("courseInfo", courseService.selectCourseDetail(course_id));
		List<HashMap<String, String>> chapterInfo = courseService.selectCourseChapterListAll(course_id);
		model.addAttribute("chapterInfo", chapterInfo);		
		
//		PayController pc = new PayController();
//		try {
//			model.addAttribute("buyertel","01065328833");
//		    model.addAttribute("buyername","sangsu");
//		    model.addAttribute("buyeremail","sss@sss.com");
//			model = pc.payInfo(model, request, "12000", "c000000048", "c000000048", "20200101", "20200131");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		//화면 좌측메뉴처리를 위한 모델세팅
		List<HashMap<String, String>> courseList = courseService.selectCourseList();
		model.addAttribute("courseList", courseList);
		model.addAttribute("moveFlag", "1");

		//마일리지 퍼센트 처리
		Map<String, Object> pointPolicy = pointService.selectPolicyPoint();
		int pointPercentage = (int)pointPolicy.get("SAVE_LECTURE_POINT");
		
		model.addAttribute("point_percentage_policy", pointPercentage);
		
		logger.info("과정 - 외국어 과정상세 페이지 이동 컨트롤러 끝");
		
		return "lms/course/foreign/sub02-01-01-01";
	}

	
	/* ----------------------------------외국어 관련 컨트롤러 모음 ---------------------------------------------*/

	
	/* ----------------------------------직무역량 관련 컨트롤러 모음 ---------------------------------------------*/

	@RequestMapping(value = "lms/course/business/sub03-01", method = RequestMethod.GET)
	public String sub03_01(Model model, String parent_menu, String son_menu, HttpServletRequest request) {

		logger.info("과정 - 직무역량 페이지 이동 컨트롤러 시작");

		// leftmenu에 띄울 애들을 정리하기.		
		List<HashMap<String, String>> courseList = courseService.selectCourseList();
		model.addAttribute("parent_menu", parent_menu);
		model.addAttribute("son_menu", son_menu);
		model.addAttribute("courseList", courseList);
		
//		PayController pc = new PayController();
//		try {
//			model.addAttribute("buyertel","01065328833");
//		    model.addAttribute("buyername","sangsu");
//		    model.addAttribute("buyeremail","sss@sss.com");
//			model = pc.payInfo(model, request, "12000", "c000000048", "c000000048", "20200101", "20200131");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		logger.info("과정 - 직무역량 페이지 이동 컨트롤러 종료");

		return "lms/course/business/sub03-01";
	}

	@RequestMapping(value = "lms/course/business/sub03-01-01-01", method = RequestMethod.GET)
	public String sub03_01_01_01(String course_id, Model model,HttpServletRequest request) {
				
		logger.info("과정 - 직무역량 과정상세 페이지 이동 컨트롤러 시작");

		model.addAttribute("courseInfo", courseService.selectCourseDetail(course_id));
		List<HashMap<String, String>> chapterInfo = courseService.selectCourseChapterListAll(course_id);
		model.addAttribute("chapterInfo", chapterInfo);		
		
//		PayController pc = new PayController();
//		try {
//			model.addAttribute("buyertel","01065328833");
//		    model.addAttribute("buyername","sangsu");
//		    model.addAttribute("buyeremail","sss@sss.com");
//			model = pc.payInfo(model, request, "12000", "c000000048", "c000000048", "20200101", "20200131");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		//화면 좌측메뉴처리를 위한 모델세팅
		List<HashMap<String, String>> courseList = courseService.selectCourseList();
		model.addAttribute("courseList", courseList);
		model.addAttribute("moveFlag", "1");

		//마일리지 퍼센트 처리
		Map<String, Object> pointPolicy = pointService.selectPolicyPoint();
		int pointPercentage = (int)pointPolicy.get("SAVE_LECTURE_POINT");
		
		model.addAttribute("point_percentage_policy", pointPercentage);
		
		logger.info("과정 - 직무역량 과정상세 페이지 이동 컨트롤러 끝");
		
		return "lms/course/business/sub03-01-01-01";
	}
	

	/* ----------------------------------직무역량 관련 컨트롤러 모음 ---------------------------------------------*/
	
	/* ----------------------------------자격증 관련 컨트롤러 모음 ---------------------------------------------*/

	@RequestMapping(value = "lms/course/license/sub05-01", method = RequestMethod.GET)
	public String sub05_01(Model model, String parent_menu, String son_menu, HttpServletRequest request) {

		logger.info("과정 - 자격정 페이지 이동 컨트롤러 시작");

		// leftmenu에 띄울 애들을 정리하기.		
		List<HashMap<String, String>> courseList = courseService.selectCourseList();
		model.addAttribute("parent_menu", parent_menu);
		model.addAttribute("son_menu", son_menu);
		model.addAttribute("courseList", courseList);
		
//		PayController pc = new PayController();
//		try {
//			model.addAttribute("buyertel","01065328833");
//		    model.addAttribute("buyername","sangsu");
//		    model.addAttribute("buyeremail","sss@sss.com");
//			model = pc.payInfo(model, request, "12000", "c000000048", "c000000048", "20200101", "20200131");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		logger.info("과정 - 자격증 페이지 이동 컨트롤러 종료");

		return "lms/course/license/sub05-01";
	}

	@RequestMapping(value = "lms/course/license/sub05-01-01-01", method = RequestMethod.GET)
	public String sub05_01_01_01(String course_id, Model model,HttpServletRequest request) {
				
		logger.info("과정 - 자격증 과정상세 페이지 이동 컨트롤러 시작");

		model.addAttribute("courseInfo", courseService.selectCourseDetail(course_id));
		List<HashMap<String, String>> chapterInfo = courseService.selectCourseChapterListAll(course_id);
		model.addAttribute("chapterInfo", chapterInfo);		
		
//		PayController pc = new PayController();
//		try {
//			model.addAttribute("buyertel","01065328833");
//		    model.addAttribute("buyername","sangsu");
//		    model.addAttribute("buyeremail","sss@sss.com");
//			model = pc.payInfo(model, request, "12000", "c000000048", "c000000048", "20200101", "20200131");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		//화면 좌측메뉴처리를 위한 모델세팅
		List<HashMap<String, String>> courseList = courseService.selectCourseList();
		model.addAttribute("courseList", courseList);
		model.addAttribute("moveFlag", "1");

		//마일리지 퍼센트 처리
		Map<String, Object> pointPolicy = pointService.selectPolicyPoint();
		int pointPercentage = (int)pointPolicy.get("SAVE_LECTURE_POINT");
		
		model.addAttribute("point_percentage_policy", pointPercentage);
		
		logger.info("과정 - 자격증 과정상세 페이지 이동 컨트롤러 끝");
		
		return "lms/course/license/sub05-01-01-01";
	}
	

	/* ----------------------------------자격증 관련 컨트롤러 모음 ---------------------------------------------*/

	/* ----------------------------------JOB-Market 관련 컨트롤러 모음 ---------------------------------------------*/

	@RequestMapping(value = "lms/course/jobmarket/sub06-01", method = RequestMethod.GET)
	public String sub06_01(Model model, String parent_menu, String son_menu, HttpServletRequest request) {

		logger.info("과정 - JOB-Market 페이지 이동 컨트롤러 시작");

		// leftmenu에 띄울 애들을 정리하기.		
		List<HashMap<String, String>> courseList = courseService.selectCourseList();
		model.addAttribute("parent_menu", parent_menu);
		model.addAttribute("son_menu", son_menu);
		model.addAttribute("courseList", courseList);
		
//		PayController pc = new PayController();
//		try {
//			model.addAttribute("buyertel","01065328833");
//		    model.addAttribute("buyername","sangsu");
//		    model.addAttribute("buyeremail","sss@sss.com");
//			model = pc.payInfo(model, request, "12000", "c000000048", "c000000048", "20200101", "20200131");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		logger.info("과정 - JOB-Market 페이지 이동 컨트롤러 종료");

		return "lms/course/jobmarket/sub06-01";
	}

	@RequestMapping(value = "lms/course/jobmatket/sub06-01-01-01", method = RequestMethod.GET)
	public String sub06_01_01_01(String course_id, Model model,HttpServletRequest request) {
				
		logger.info("과정 - JOB-Market 과정상세 페이지 이동 컨트롤러 시작");

		model.addAttribute("courseInfo", courseService.selectCourseDetail(course_id));
		List<HashMap<String, String>> chapterInfo = courseService.selectCourseChapterListAll(course_id);
		model.addAttribute("chapterInfo", chapterInfo);		
		
//		PayController pc = new PayController();
//		try {
//			model.addAttribute("buyertel","01065328833");
//		    model.addAttribute("buyername","sangsu");
//		    model.addAttribute("buyeremail","sss@sss.com");
//			model = pc.payInfo(model, request, "12000", "c000000048", "c000000048", "20200101", "20200131");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		//화면 좌측메뉴처리를 위한 모델세팅
		List<HashMap<String, String>> courseList = courseService.selectCourseList();
		model.addAttribute("courseList", courseList);
		model.addAttribute("moveFlag", "1");

		//마일리지 퍼센트 처리
		Map<String, Object> pointPolicy = pointService.selectPolicyPoint();
		int pointPercentage = (int)pointPolicy.get("SAVE_LECTURE_POINT");
		
		model.addAttribute("point_percentage_policy", pointPercentage);
		
		logger.info("과정 - JOB-Market 과정상세 페이지 이동 컨트롤러 끝");
		
		return "lms/course/jobmarket/sub06-01-01-01";
	}
	

	/* ----------------------------------JOB-Market 관련 컨트롤러 모음 ---------------------------------------------*/
	
	
	/* ----------------------------------취업연계 관련 컨트롤러 모음 ---------------------------------------------*/


	@RequestMapping(value = "lms/course/jobtraining/sub04-01", method = RequestMethod.GET)
	public String sub04_01(Model model, String parent_menu, String son_menu, HttpServletRequest request) {

		logger.info("과정 - 취업연계 페이지 이동 컨트롤러 시작");

		// leftmenu에 띄울 애들을 정리하기.		
		List<HashMap<String, String>> courseList = courseService.selectCourseList();
		model.addAttribute("parent_menu", parent_menu);
		model.addAttribute("son_menu", son_menu);
		model.addAttribute("courseList", courseList);
		
//		PayController pc = new PayController();
//		try {
//			model.addAttribute("buyertel","01065328833");
//		    model.addAttribute("buyername","sangsu");
//		    model.addAttribute("buyeremail","sss@sss.com");
//			model = pc.payInfo(model, request, "12000", "c000000048", "c000000048", "20200101", "20200131");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		logger.info("과정 - 취업연계 페이지 이동 컨트롤러 종료");
		
		return "lms/course/jobtraining/sub04-01";
	}	


	@RequestMapping(value = "lms/course/jobtraining/sub04-01-01-01", method = RequestMethod.GET)
	public String sub04_01_01_01(String course_id, Model model,HttpServletRequest request) {
				
		logger.info("과정 - 취업연계 과정상세 페이지 이동 컨트롤러 시작");

		model.addAttribute("courseInfo", courseService.selectCourseDetail(course_id));
		List<HashMap<String, String>> chapterInfo = courseService.selectCourseChapterListAll(course_id);
		model.addAttribute("chapterInfo", chapterInfo);		
		
//		PayController pc = new PayController();
//		try {
//			model.addAttribute("buyertel","01065328833");
//		    model.addAttribute("buyername","sangsu");
//		    model.addAttribute("buyeremail","sss@sss.com");
//			model = pc.payInfo(model, request, "12000", "c000000048", "c000000048", "20200101", "20200131");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		//화면 좌측메뉴처리를 위한 모델세팅
		List<HashMap<String, String>> courseList = courseService.selectCourseList();
		model.addAttribute("courseList", courseList);
		model.addAttribute("moveFlag", "1");

		//마일리지 퍼센트 처리
		Map<String, Object> pointPolicy = pointService.selectPolicyPoint();
		int pointPercentage = (int)pointPolicy.get("SAVE_LECTURE_POINT");
		
		model.addAttribute("point_percentage_policy", pointPercentage);
		
		logger.info("과정 - 취업연계 과정상세 페이지 이동 컨트롤러 끝");
		
		return "lms/course/jobtraining/sub04-01-01-01";
	}
	
	/* ----------------------------------취업연계 관련 컨트롤러 모음 ---------------------------------------------*/
	
	/* ----------------------------------모의토플 관련 컨트롤러 모음 ---------------------------------------------*/
	
	@RequestMapping(value = "lms/course/toefl/sub_toefl", method = RequestMethod.GET)
	public String sub07_01(Model model, String parent_menu, String son_menu, HttpServletRequest request) {

		logger.info("과정 - 모의토플 페이지 이동 컨트롤러 시작");

		// leftmenu에 띄울 애들을 정리하기.		
		List<HashMap<String, String>> courseList = courseService.selectCourseList();
		model.addAttribute("parent_menu", parent_menu);
		model.addAttribute("son_menu", son_menu);
		model.addAttribute("courseList", courseList);
		
//		PayController pc = new PayController();
//		try {
//			model.addAttribute("buyertel","01065328833");
//		    model.addAttribute("buyername","sangsu");
//		    model.addAttribute("buyeremail","sss@sss.com");
//			model = pc.payInfo(model, request, "12000", "c000000048", "c000000048", "20200101", "20200131");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		logger.info("과정 - 모의토플 페이지 이동 컨트롤러 종료");
		
		return "lms/course/toefl/sub_toefl";
	}	
	
	/* ---------------------------------전체검색 관련 컨트롤러 ---------------------------------------------*/

	@RequestMapping(value = "lms/course/search/sub05-01", method = RequestMethod.GET)
	public String search_sub05_01(@RequestParam HashMap<String, String> param, Model model) {

		logger.info("Main에서 검색창을 사용했을 때의 컨트롤러 시작");
		String startPage = StringUtils.isBlank((String) param.get("startPage")) ? "1" : (String) param.get("startPage");
		model.addAttribute("startPage",  CommonUtil.getStart(startPage, boardPages));
		model.addAttribute("keyWord", param.get("keyWord"));
		logger.info("Main에서 검색창을 사용했을 때의 컨트롤러 끝");

		return "lms/course/search/sub05-01";
	}
	
	@RequestMapping(value = "lms/course/search/selectSearchCourseList", method = RequestMethod.GET)
	public @ResponseBody Object searchCourse(@RequestParam HashMap<String, String> param, Model model) {
		
		if(param.get("display_list")!=null&&!param.get("display_list").equals("")) {
			String[] display_list_split = param.get("display_list").split(",");
			for(int i = 0; i < display_list_split.length; i++) {
				String key = "display_icons_" + display_list_split[i]; 
				System.out.println("key : " + key + ", value : " + display_list_split[i]);
				param.put(key, display_list_split[i]);
			}
		} else {
			System.out.println("과정리스트 조회시 아이콘관련 세팅 안함");
		}
		
		// 시작 페이지 객체
		String startPage = StringUtils.isBlank((String) param.get("startPage")) ? "1" : (String) param.get("startPage");
		// 시작 페이지 설정
		param.put("startPage", CommonUtil.getStart(startPage, boardPages));
		// 볼 수 있는 페이지 설정
		param.put("visiblePages", boardPages);
		return courseService.selectSearchCourseList(param);
	}

	@RequestMapping(value = "lms/course/search/movePage", method = RequestMethod.GET)
	public String searchMovePage(String course_id, String grand, Model model) {

		logger.info("검색창에서 상세보기 페이지 이동 컨트롤러 시작");
		
		model.addAttribute("courseInfo", courseService.selectCourseDetail(course_id));
		List<HashMap<String, String>> chapterInfo = courseService.selectCourseChapterListAll(course_id);
		model.addAttribute("chapterInfo", chapterInfo);

		//화면 좌측메뉴처리를 위한 모델세팅
		List<HashMap<String, String>> courseList = courseService.selectCourseList();
		model.addAttribute("courseList", courseList);
		model.addAttribute("moveFlag", "1");		

		logger.info("검색창에서 상세보기 페이지 이동 컨트롤러 끝");

		if(grand.equals("ICT")) {
			return "lms/course/it/sub01-01-01-01";
		} else if(grand.equals("외국어")) {
			return "lms/course/foreign/sub02-01-01-01";			
		} else if(grand.equals("직무역량")) {
			return "lms/course/business/sub03-01-01-01";			
		} else if(grand.equals("자격증")) {
			return "lms/course/license/sub05-01-01-01";			
		} else if(grand.equals("JOB-Market")) {
			return "lms/course/business/sub06-01-01-01";			
		} else {
			return "lms/course/jobtraining/sub04-01-01-01";			
		}

	}		
	
	
	/* ----------------------------------취업연계 관련 컨트롤러 모음 ---------------------------------------------*/

		
	
	
	
	
	
	/* ----------------------------------모든 페이지에서 사용 되는 메서드 정리---------------------------------------------*/
	
	@RequestMapping(value = "lms/course/makesignature", method = RequestMethod.GET)
	public @ResponseBody HashMap<String, String> makeSignature(@RequestParam HashMap<String, String> param) {


		/* 이니시스 정보 인코딩 시작*/
		PayController pc = new PayController();

		param=pc.makeSignature(param);
		
		return param;

	}
	
	@RequestMapping(value = "lms/course/selectBoard", method = RequestMethod.GET)
	public @ResponseBody Object selectCourseBoardList(@RequestParam HashMap<String, String> param) {

		logger.info("Ajax 과정목록 가져오기 시작");

		if(param.get("display_list")!=null&&!param.get("display_list").equals("")) {
			String[] display_list_split = param.get("display_list").split(",");
			for(int i = 0; i < display_list_split.length; i++) {
				String key = "display_icons_" + display_list_split[i]; 
				System.out.println("key : " + key + ", value : " + display_list_split[i]);
				param.put(key, display_list_split[i]);
			}
		} else {
			System.out.println("과정리스트 조회시 아이콘관련 세팅 안함");
		}
		
		// 시작 페이지 객체
		String startPage = StringUtils.isBlank((String) param.get("startPage")) ? "1" : (String) param.get("startPage");
		// 시작 페이지 설정
		param.put("startPage", CommonUtil.getStart(startPage, boardPages));
		// 볼 수 있는 페이지 설정?
		param.put("visiblePages", boardPages);


		logger.info("Ajax 과정목록 가져오기 종료");
		
		return courseService.selectCourseBoardList(param);

	}

	@RequestMapping(value = "lms/course/pageInfo", method = RequestMethod.GET)
	public @ResponseBody Object getPagingInfo(@RequestParam HashMap<String, String> param) {

		logger.info("Ajax 페이징 정보처리 시작");

		HashMap<String, String> returnParam = new HashMap<String, String>() {};

		
		if(param.get("display_list")!=null&&!param.get("display_list").equals("")) {
			String[] display_list_split = param.get("display_list").split(",");
			for(int i = 0; i < display_list_split.length; i++) {
				String key = "display_icons_" + display_list_split[i]; 
				param.put(key, display_list_split[i]);
			}
		} else {
			System.out.println("과정리스트 페이징 세팅시 아이콘관련 세팅 안함");

		}
		
		// 시작 페이지 객체
		String startPage = StringUtils.isBlank((String) param.get("startPage")) ? "1" : (String) param.get("startPage");
		// 시작 페이지 설정
		System.out.println("startpage 받은 값 : " + param.get("startPage"));
		System.out.println("startpage 세팅 값 : " + CommonUtil.getStart(startPage, boardPages));

		param.put("startPage", CommonUtil.getStart(startPage, boardPages));
		// 볼 수 있는 페이지 설정?
		param.put("visiblePages", boardPages);

		try {
			// 전체 게시물 갯수
			int totalCnt = courseService.selectCourseListTotCnt(param);
			returnParam.put("totalCnt", String.valueOf(totalCnt));
			returnParam.put("totalPages",
					String.valueOf(CommonUtil.getTotalPage(totalCnt, Integer.parseInt(boardPages))));
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 전체 게시물 갯수 설정
		returnParam.put("startPage", CommonUtil.getStart(startPage, boardPages));
		returnParam.put("visiblePages", String.valueOf(boardPages));

		logger.info("Ajax 페이징 정보처리 종료");

		return returnParam;
	}

	@RequestMapping(value = "lms/course/getUserInfo", method = RequestMethod.GET)
	public @ResponseBody Object getUserInfo(@RequestParam HashMap<String, String> param) {

		logger.info("Ajax - 수강신청 Modal에 회원정보 표시 시작");
		HashMap<String, String> user = courseService.getUserInfo(param.get("user_id"));
		logger.info("Ajax - 수강신청 Modal에 회원정보 표시 종료");
		return user;
	}
	
	
	@RequestMapping(value = "lms/course/getPointInfo", method = RequestMethod.GET)
	public @ResponseBody Object getPointInfo(@RequestParam HashMap<String, String> param) {

		logger.info("Ajax - 수강신청 Modal에 마일리지 표시 시작");
		HashMap<String, Object> userPoint = pointService.selectPointSummary(param.get("user_id"));
		logger.info("Ajax - 수강신청 Modal에 마일리지 표시 종료");
		return userPoint;
	}
	
	

	@RequestMapping(value = "lms/course/getCardinalInfo", method = RequestMethod.GET)
	public @ResponseBody Object getCardinalInfo(@RequestParam HashMap<String, String> param) {

		logger.info("Ajax - 수강신청Modal에 기수정보 표시 시작");

		List<HashMap<String, String>> matchedCardinals = courseService.checkCardinalMatched(param.get("course_id"));

		// 오늘 날짜 기준 주의 월요일 세팅
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		cal.add(cal.DATE, 7);
		String learn_start_date = dateFormat.format(cal.getTime());

		Calendar calToday = Calendar.getInstance();
		String today = dateFormat.format(calToday.getTime());
		
		
		ArrayList<HashMap<String,String>> validCardinals = new ArrayList<HashMap<String,String>>();
		
		for (HashMap<String, String> matchedOne : matchedCardinals) {
			HashMap<String, String> tempCardinal = new HashMap<String, String>();
//			tempCardinal.put("learnStartDate", learn_start_date);
			tempCardinal.put("today", today);
			tempCardinal.put("cardinal_id", matchedOne.get("cardinal_id"));
			
			List<HashMap<String, String>>tempList = courseService.selectCardinalList(tempCardinal);
			if(tempList.size()!=0) {
				validCardinals.add(tempList.get(0));
			};
			
		}

		logger.info("Ajax - 수강신청 Modal에 기수정보 표시 종료");
		return validCardinals;
	}
	
	// 수료조건 셋팅을 위해 기수정보 조회
	@RequestMapping(value = "lms/course/getCompleteCondition", method = RequestMethod.GET)
	public @ResponseBody Object getCompleteCondition(@RequestParam HashMap<String, String> param) {
		
		logger.info("수료조건 세팅을 위한 기수정보 조회 시작");
		
		HashMap<String, String> tempCardinal = new HashMap<String, String>();

		tempCardinal.put("cardinal_id", param.get("cardinal_id"));
		
		List<HashMap<String, String>>cardinalInfo = courseService.selectCardinalList(param);
		
		logger.info("수료조건 세팅을 위한 기수정보 조회 종료");

		return cardinalInfo;
	}
	
	
	// 메서드의 결과, cardinal_id를 화면에 보내주어 수강신청을 진행한다.
	@RequestMapping(value = "lms/course/checkCardinalExist", method = RequestMethod.GET)
	public @ResponseBody Object checkCardinalExist(@RequestParam HashMap<String, String> param) {

		logger.info("Ajax - 과정에 해당하는 기수 확인 컨트롤러 시작");

		HashMap<String, String> returnParam = new HashMap<String, String>();

		try {
			String new_cardinal_id = insertNewCardinal(param);
			
			returnParam.put("cardinal_id", new_cardinal_id);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		logger.info("Ajax - 과정에 해당하는 기수 확인 컨트롤러 종료");

		return returnParam;

	}
	
	
	
	/*
	 * // 메서드의 결과, cardinal_id를 화면에 보내주어 수강신청을 진행한다.
	 * 
	 * @RequestMapping(value = "lms/course/checkCardinalExist", method =
	 * RequestMethod.GET) public @ResponseBody Object
	 * checkCardinalExist(@RequestParam HashMap<String, String> param) {
	 * 
	 * logger.info("Ajax - 과정에 해당하는 기수 확인 컨트롤러 시작");
	 * 
	 * HashMap<String, String> returnParam = new HashMap<String, String>();
	 * 
	 * System.out.println("과정, 기수 브릿지 조회 시작"); List<HashMap<String, String>>
	 * cardinal_course_id_info =
	 * courseService.checkCardinalMatched(param.get("id"));
	 * 
	 * if (cardinal_course_id_info.size() != 0) {
	 * System.out.println("과정에 매칭된 기수가 있음. 접수시작일 확인해서 기간에 맞는 기수가 있는지 확인");
	 * 
	 * // 오늘 날짜 기준 주의 월요일 세팅 SimpleDateFormat dateFormat = new
	 * SimpleDateFormat("yyyy-MM-dd"); Calendar cal = Calendar.getInstance();
	 * cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY); cal.add(cal.DATE, 7); String
	 * learn_start_date = dateFormat.format(cal.getTime());
	 * 
	 * 
	 * boolean checkCardinalAlreadyExist = false;
	 * 
	 * List<HashMap<String, String>> existingAllCardinal = new
	 * ArrayList<HashMap<String, String>>();
	 * 
	 * //두개 이상일 경우, 처리가 필요하다. for (HashMap<String, String> car_cour_id_info :
	 * cardinal_course_id_info) { car_cour_id_info.put("learnStartDate",
	 * learn_start_date); int result =
	 * courseService.checkValidCardinalExist(car_cour_id_info); if (result != 0) {
	 * System.out.println("현재 날짜를 기준으로 기수가 이미 존재합니다"); checkCardinalAlreadyExist =
	 * true; HashMap<String, String> oneCardinal = new HashMap<String, String>();
	 * oneCardinal.put("cardinal_id",
	 * courseService.selectCardinalId(car_cour_id_info));
	 * existingAllCardinal.add(oneCardinal); } }
	 * 
	 * if (!checkCardinalAlreadyExist) {
	 * System.out.println("과정에 매핑된 기수는 있으나, 현재 날짜를 기준으로 개설된 기수가 없습니다. 기수 생성을 시작합니다."
	 * ); returnParam.put("cardinal_id", insertNewCardinal(param)); } else { return
	 * existingAllCardinal; }
	 * 
	 * } else { System.out.println("과정에 매핑된 기수가 없으므로, 현재 날짜를 기준으로 기수 생성을 시작합니다.");
	 * returnParam.put("cardinal_id", insertNewCardinal(param)); }
	 * 
	 * logger.info("Ajax - 과정에 해당하는 기수 확인 컨트롤러 종료");
	 * 
	 * return returnParam;
	 * 
	 * }
	 */
	
	@RequestMapping(value = "lms/course/signUpClass", method = RequestMethod.GET)
	public @ResponseBody Object signUpClass(HttpSession session, @RequestParam HashMap<String, String> param) {

		logger.info("Ajax - 수강신청 등록 시작");

//		param.put("user_id", (String)session.getAttribute("user_id"));

		//참고
		//결제정보를 우선 2로 설정하고 넣어서 나의 강의실에서 확인할 수 있다.
		param.put("payment_state", "2");

		try {
			//수강신청정보입력 
			int result = courseService.insertApply(param);
			
			//입과처리
			List<HashMap<String, String>> chapList = courseService.getChapPage(param);
			if(chapList == null || chapList.size() == 0) {
				chapList = courseService.getChapPage2(param);
			}
			//수강정보 이력 생성
			courseService.insertAttLec(param, chapList);
			//1) 회원정보(기본)수정시 회원정보 테이블 수정
			int updateUserInfo = courseService.updateUserInfo(param);
			
			//2) 회원정보(선택) 테이블에 사용자 정보가 있는지 확인 
			int ifAddtionalInfoExist = userService.selectIfAdditionalInfoExist(param.get("user_id"));
			
			//3) 2의 유무여부에 따라 해당 테이블 추가/수정
			if( ifAddtionalInfoExist > 0 ){
				courseService.updateAdditionalUserInfo(param);
			}else{
				courseService.insertAdditionalUserInfo(param);
			}
			
			
			if(result!=0) {
				System.out.println("수강신청 성공");

				//수강신청 성공시, 마일리지 차감작업을 해야 한다.			
				HashMap<String, String> getLearnAppParam = new HashMap<String, String>();
				getLearnAppParam.put("user_id", (String)session.getAttribute("user_id"));
				getLearnAppParam.put("course_id", param.get("course_id"));
				getLearnAppParam.put("cardinal_id", param.get("cardinal_id"));
				int learnAppId = courseService.selectLearnAppId(getLearnAppParam);				
								
				String pointUse = (String)param.get("pointUse");
				if(!pointUse.equals("0")) {
					Map<String, Object> pointWithdraw = new HashMap<String, Object>();
					pointWithdraw.put("user_id", (String)session.getAttribute("user_id"));
					pointWithdraw.put("learn_app_id", learnAppId);
					pointWithdraw.put("give", 0);
					pointWithdraw.put("withdraw", pointUse);
					pointWithdraw.put("note", "수강신청 마일리지 사용");

					pointService.insertPoint(pointWithdraw);				
				}
			
			} else {
				System.out.println("수강신청 실패");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		logger.info("Ajax - 수강신청 등록 끝");
		return false;
	}	
	
	public Boolean signUp(HttpSession session,HashMap<String, String> param) {
		
		logger.info("수강신청 등록 시작");

//		param.put("user_id", (String)session.getAttribute("user_id"));
		
		if(param.get("payment_type").equals("B")) {
			param.put("payment_state", "1"); //가상계좌
			
		}else if(param.get("payment_type").equals("C")) {
			param.put("payment_state", "2"); //신용카드
		}
		try {
			int result = courseService.insertApply(param);
			
			//입과처리
			List<HashMap<String, String>> chapList = courseService.getChapPage(param);
			if(chapList == null || chapList.size() == 0) {
				chapList = courseService.getChapPage2(param);
			}
			//수강정보 이력 생성
			courseService.insertAttLec(param, chapList);
			if(result!=0) {
				System.out.println("수강신청 성공");
			} else {
				System.out.println("수강신청 실패");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		logger.info("Ajax - 수강신청 등록 끝");
		return false;
	}	
	
	
	
	/* cardinal_id 정보를 리턴 */
	public String insertNewCardinal(HashMap<String, String> param) {
		System.out.println("새로운 기수를 생성하는 매서드");

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		String app_start_date = dateFormat.format(cal.getTime());

		cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		cal.add(cal.DATE, 7);
		String app_end_date = dateFormat.format(cal.getTime());

		Calendar cal2 = Calendar.getInstance();
		cal2.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		cal2.add(cal2.DATE, 7);
		String learn_start_date = dateFormat.format(cal2.getTime());

		// 시작하는 날짜를 포함한 연수기간이기 때문에, 연수종료일 - 1 처리를 해준다.
		cal2.add(cal2.DATE, Integer.parseInt(param.get("selp_period")) - 1);
		String learn_end_date = dateFormat.format(cal2.getTime());

		// 참고
		// 기수를 개설할 때 기수명도 필수로 기입되어야 한다.
		// 기수명은 과정명으로 처리한다.
		// String cardinal_name = param.get("course_name") + " " + learn_start_date;

		
		//자동기수명은, 과정에 등록된 기수들의 개수 + 1로 설정한다.
		int cardinalCount = courseService.selectCbCnCardinalCnt(param);
		
		String cardinal_name = (String)param.get("course_name") + " " + String.valueOf(cardinalCount + 1) + "기";
		
		//String cardinal_name = param.get("course_name");

		// 가장 큰 시퀀스 값을 먼저 가져온다.
		// 해당 시퀀스 + 1한 값에 0을 붙여준다 9자리까지
		// 맨 앞에 n을 붙인다.

		Integer max_cardinal_seq = courseService.selectMaxCardinalSeq();
			
		if (max_cardinal_seq == null) {
			max_cardinal_seq = 0;
		}
		max_cardinal_seq += 1;

		String new_cardinal_id = "n" + setLPad(String.valueOf(max_cardinal_seq), 9, "0");
		System.out.println("새로운 cardinal id : " + new_cardinal_id);

		HashMap<String, Object> cardinalInfo = new HashMap<String, Object>();
		cardinalInfo.put("name", cardinal_name);
		cardinalInfo.put("appStartDate", app_start_date);
		cardinalInfo.put("appEndDate", app_end_date);
		cardinalInfo.put("learnStartDate", learn_start_date);
		cardinalInfo.put("learnEndDate", learn_end_date);
		cardinalInfo.put("id", new_cardinal_id);

		// 관리자에서 기수 출력을 위해, 의미는 없지만 같은 데이터를 세팅한다.
		cardinalInfo.put("learn_type", "J");
		cardinalInfo.put("credits", "1,2");
		cardinalInfo.put("course_type", "S");
		cardinalInfo.put("att_exam_type", "A");
		cardinalInfo.put("cancel", "0");
		cardinalInfo.put("dup_limit", "0");
		cardinalInfo.put("add_exam_period", "0");
		cardinalInfo.put("app_possibles", "1,2");
		cardinalInfo.put("preview", "2");
		cardinalInfo.put("complate_yn", "Y");
		cardinalInfo.put("issue_date", "2019-12-24");
		cardinalInfo.put("att_eval_date", "2019-12-24");
		cardinalInfo.put("order_num", "1");
		cardinalInfo.put("use_yn", "Y");
		
		// 과정의 수료기준을 넣어준다.
		HashMap<String, Object> courseDetail = courseService.selectCourseDetail(param.get("id"));
		
		cardinalInfo.put("compPercentQuiz", courseDetail.get("comp_percent_quiz"));
		cardinalInfo.put("compPercentExam", courseDetail.get("comp_percent_exam"));
		cardinalInfo.put("compPercentProg", courseDetail.get("comp_percent_prog"));
		cardinalInfo.put("compScoreQuiz", courseDetail.get("comp_score_quiz"));
		cardinalInfo.put("compScoreExam", courseDetail.get("comp_score_exam"));
		cardinalInfo.put("compScoreProg", courseDetail.get("comp_score_prog"));
		cardinalInfo.put("completeTotal", courseDetail.get("complete_total"));
		cardinalInfo.put("price", courseDetail.get("price"));
		// 기수를 개설하면서, 동시에 브릿지 테이블에도 넣어주어야 한다.
		System.out.println("기수 정보 등록 시작");
		courseService.insertCardinal(cardinalInfo);
		System.out.println("기수 정보 등록 끝");
		// 카디널 id는 db에서 자동생성되기 때문에 이를 불러와야 한다.
		HashMap<String, String> cardinalCourseInfo = new HashMap<String, String>();
		cardinalCourseInfo.put("course_id", param.get("id"));
		cardinalCourseInfo.put("cardinal_id", new_cardinal_id);
		System.out.println("기수 과정 정보 등록 시작");
		courseService.insertCardinalCourseInfo(cardinalCourseInfo);
		System.out.println("기수 과정 정보 등록 끝");
		
		return new_cardinal_id;
	}

	public String setLPad(String str, int len, String strChar) {

		String strResult = "";
		StringBuilder sbAddChar = new StringBuilder();
		for (int i = str.length(); i < len; i++) { // iLen길이 만큼 strChar문자로 채운다.
			sbAddChar.append(strChar);
		}
		strResult = sbAddChar + str; // LPAD이므로, 채울문자열 + 원래문자열로 Concate한다.
		return strResult;

	}
	
	@RequestMapping(value = "lms/course/payInfo", method = RequestMethod.POST)
	public View user_pay_info(Model model, HttpServletRequest request, HttpServletResponse response,
			Authentication auth, HttpSession session,@RequestParam HashMap<String,String> param) {
		String retUrl = "lms/course/foreign/sub02-01";
		 
		String cardinalId = param.get("merchantData").split(",")[0];
		String courseId = param.get("merchantData").split(",")[1];
		String pointUse = param.get("merchantData").split(",")[2];
		String merPhone = param.get("merchantData").split(",")[3];
		String merEmail = param.get("merchantData").split(",")[4];
		String merId = param.get("merchantData").split(",")[5];
		param.put("user_id", merId);
		param.put("cardinal_id", cardinalId);
		param.put("course_id", courseId);
		param.put("dis_point", pointUse);
		param.put("phone", merPhone);
		param.put("email", merEmail);
		
		System.out.println(cardinalId+"!!!"+courseId);	
		
		/**********************************************************************************************
		 * INIpay 모듈 세팅 시작
		 **********************************************************************************************/

		// #############################
		// 인증결과 파라미터 일괄 수신
		// #############################
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Map<String, String> paramMap = new Hashtable<String, String>();

		Enumeration<String> elems = request.getParameterNames();

		String temp = "";

		while (elems.hasMoreElements()) {
			temp = (String) elems.nextElement();
			paramMap.put(temp, request.getParameter(temp));

		}

		// #####################
		// 인증이 성공일 경우만
		// #####################
		if ("0000".equals(paramMap.get("resultCode"))) {

			// ############################################
			// 1.전문 필드 값 설정(***가맹점 개발수정***)
			// ############################################

			String mid = paramMap.get("mid"); // 가맹점 ID 수신 받은 데이터로 설정

			//String signKey = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS"; // 가맹점에 제공된
			// 키(이니라이트키)
			// (가맹점
			// 수정후
			// 고정)
			// !!!절대!!
			// 전문
			// 데이터로
			// 설정금지

			String timestamp = SignatureUtil.getTimestamp(); // util에 의해서
			// 자동생성

			String charset = "UTF-8"; // 리턴형식[UTF-8,EUC-KR](가맹점 수정후 고정)
			String format = "NVP"; // 리턴형식[XML,JSON,NVP](가맹점 수정후 고정)

			// 추가적 noti가 필요한 경우(필수아님, 공백일 경우 미발송, 승인은 성공시, 실패시 모두 Noti발송됨)
			// 미사용
			// String notiUrl = "";

			String authToken = paramMap.get("authToken"); // 취소 요청 tid에 따라서
															// 유동적(가맹점 수정후 고정)

			String authUrl = paramMap.get("authUrl"); // 승인요청 API url(수신 받은값으로
														// 설정, 임의 세팅 금지)

			//String netCancel = paramMap.get("netCancelUrl"); // 망취소 API url (수신
																// 받은값으로 설정, 임의
																// 세팅 금지)

			// #####################
			// 2.signature 생성
			// #####################
			Map<String, String> signParam = new HashMap<String, String>();

			signParam.put("authToken", authToken); // 필수
			signParam.put("timestamp", timestamp); // 필수

			// signature 데이터 생성 (모듈에서 자동으로 signParam을 알파벳 순으로 정렬후 NVP 방식으로
			// 나열해 hash)
			String signature = null;
			try {
				signature = SignatureUtil.makeSignature(signParam);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			String price = ""; // 가맹점에서 최종 결제 가격 표기 (필수입력)

			// 1. 가맹점에서 승인시 주문번호가 변경될 경우 (선택입력) 하위 연결.
			// String oid = "";

			// #####################
			// 3.API 요청 전문 생성
			// #####################
			Map<String, String> authMap = new Hashtable<String, String>();

			authMap.put("mid", mid); // 필수
			authMap.put("authToken", authToken); // 필수
			authMap.put("signature", signature); // 필수
			authMap.put("timestamp", timestamp); // 필수
			authMap.put("charset", charset); // default=UTF-8
			authMap.put("format", format); // default=XML
			authMap.put("price", price); // 필수 (가격위변조체크기능)
			// 이니시스 창에서 X(닫기)를 눌러 cancel(결제진행취소)를 했을 때 이전창으로 돌아가기위한 정보담기.
			model.addAttribute("authMap", authMap);
			
			// 2. 가맹점에서 승인시 주문번호가 변경될 경우 (선택입력) 하위 연결.
			// authMap.put("oid", oid);

			// if(null != notiUrl && notiUrl.length() > 0){
			// authMap.put("notiUrl" ,notiUrl);
			// }

			HttpUtil httpUtil = new HttpUtil();

			// #####################
			// 4.API 통신 시작
			// #####################

			String authResultString = "";

			try {
				authResultString = httpUtil.processHTTP(authMap, authUrl);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// ############################################################
			// 5.API 통신결과 처리(***가맹점 개발수정***)
			// ############################################################

			String test = authResultString.replace(",", "&").replace(":", "=").replace("\"", "").replace(" ", "")
					.replace("\n", "").replace("}", "").replace("{", "");

			Map<String, String> resultMap = new HashMap<String, String>();

			try {
				resultMap = ParseUtil.parseStringToMap(test);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} // 문자열을 MAP형식으로 파싱

			if ("0000".equals(resultMap.get("resultCode"))) {
				/*****************************************************************************
				 * 여기에 가맹점 내부 DB에 결제 결과를 반영하는 관련 프로그램 코드를 구현한다.
				 * 
				 * [중요!] 승인내용에 이상이 없음을 확인한 뒤 가맹점 DB에 해당건이 정상처리 되었음을 반영함 처리중 에러 발생시 망취소를 한다.
				 ******************************************************************************/
				model.addAttribute("tid", resultMap.get("tid"));
				model.addAttribute("payMethod", resultMap.get("payMethod"));
				model.addAttribute("TotPrice", resultMap.get("TotPrice"));
				model.addAttribute("MOID", resultMap.get("MOID"));
				model.addAttribute("applDate", resultMap.get("applDate"));
				model.addAttribute("applTime", resultMap.get("applTime"));
				model.addAttribute("VACT_Num", resultMap.get("VACT_Num"));
				model.addAttribute("resultCode", resultMap.get("resultCode"));
				model.addAttribute("VACT_Num", resultMap.get("VACT_Num"));

				System.out.println(test);

				//resultMap.put("seq", paramMap.get("merchantData"));
				resultMap.put("cardinal_id", cardinalId);
				resultMap.put("course_id", courseId);
				resultMap.put("seq", String.valueOf(seuService.select_pay_crc_seq(courseId, cardinalId)));
				resultMap.put("pay_rtn_data", test);
				resultMap.put("id", merId);
				resultMap.put("point", pointUse);
// 				resultMap.put("pay_gb", "F0101"); LMS결제인 경우 				 
				
				HashMap<String, String> copy = new HashMap<String, String>(resultMap);
				if (resultMap.get("payMethod").equals("VBank")) {

					copy.put("status", "F0000");
					param.put("real_payment", resultMap.get("TotPrice"));//실결제금액
					param.put("payment_type", "B");//가상계좌
					seuService.user_pay_info(copy);
					signUp(session,param);
					
					//입금 전이므로 마일리지 적립 처리 X
					//결제 성공과 함께 사용한 포인트는 차감하기
					//필요 칼럼 - user_id, learn_app_id, give, withdraw, note
					
					HashMap<String, String> getLearnAppParam = new HashMap<String, String>();
					getLearnAppParam.put("user_id", merId);
					getLearnAppParam.put("course_id", courseId);
					getLearnAppParam.put("cardinal_id", cardinalId);
					
					int learnAppId = courseService.selectLearnAppId(getLearnAppParam);
					
					//사용한 포인트가 0이 아닐 때에만 마일리지 차감 내역을 기록한다.
					if(!pointUse.equals("0")) {
						Map<String, Object> pointWithdraw = new HashMap<String, Object>();
						pointWithdraw.put("user_id", merId);
						pointWithdraw.put("learn_app_id", learnAppId);
						pointWithdraw.put("give", 0);
						pointWithdraw.put("withdraw", pointUse);
						pointWithdraw.put("note", "수강신청 마일리지 사용");
						pointService.insertPoint(pointWithdraw);				
					}
				} else {

					copy.put("status", "F0001");
					seuService.user_pay_info(copy);
					
					//일반 회원을 K-Move(광주) 학생으로 변경
					//HashMap<String, String> params = new HashMap<String, String>();
					//params.put("user_id", auth.getName());
					//params.put("user_flag", "A0106");
					//sgcService.updateUserFlag(params);
					param.put("real_payment", resultMap.get("TotPrice"));//실결제금액
					param.put("payment_type", "C");//신용카드
					signUp(session, param);
					
					//결제 성공과 함께 사용한 포인트는 차감하기
					//필요 칼럼 - user_id, learn_app_id, give, withdraw, note
					
					HashMap<String, String> getLearnAppParam = new HashMap<String, String>();
					getLearnAppParam.put("user_id", (String)session.getAttribute("user_id"));
					getLearnAppParam.put("course_id", courseId);
					getLearnAppParam.put("cardinal_id", cardinalId);
					
					int learnAppId = courseService.selectLearnAppId(getLearnAppParam);
					
					//사용한 포인트가 0이 아닐 때에만 마일리지 차감 내역을 기록한다.
					if(!pointUse.equals("0")) {
						Map<String, Object> pointWithdraw = new HashMap<String, Object>();
						pointWithdraw.put("user_id", (String)session.getAttribute("user_id"));
						pointWithdraw.put("learn_app_id", learnAppId);
						pointWithdraw.put("give", 0);
						pointWithdraw.put("withdraw", pointUse);
						pointWithdraw.put("note", "수강신청 마일리지 사용");
						pointService.insertPoint(pointWithdraw);				
					}
					
					Map<String, Object> pointPolicy = pointService.selectPolicyPoint();
					int pointPercentage = (int)pointPolicy.get("SAVE_LECTURE_POINT");
					String pointLectureType = (String)pointPolicy.get("SAVE_LECTURE_TYPE");
					
					//마일리지 차감 후, 결제 금액에서의 마일리지 추가
					//마일리지에 관리자에서 설정한 
					if((Integer.parseInt(resultMap.get("TotPrice"))/100)!=0) {
					Map<String, Object> pointGive = new HashMap<String, Object>();
					pointGive.put("user_id", (String)session.getAttribute("user_id"));
					pointGive.put("learn_app_id", learnAppId);
					
					if(pointLectureType.equals("1")){
						pointGive.put("give", pointPercentage);
					}else{
						pointGive.put("give", (Integer.parseInt(resultMap.get("TotPrice"))/100) * pointPercentage);
					}
					
					pointGive.put("withdraw", 0);
					pointGive.put("note", "수강신청 결제 마일리지 적립");
					pointService.insertPoint(pointGive);
					}
				}

//				//결제 성공과 함께 사용한 포인트는 차감하기
//				//필요 칼럼 - user_id, learn_app_id, give, withdraw, note
//
//				HashMap<String, String> getLearnAppParam = new HashMap<String, String>();
//				getLearnAppParam.put("user_id", (String)session.getAttribute("user_id"));
//				getLearnAppParam.put("course_id", courseId);
//				getLearnAppParam.put("cardinal_id", cardinalId);
//				
//				int learnAppId = courseService.selectLearnAppId(getLearnAppParam);				
//
//				
//				//사용한 포인트가 0이 아닐 때에만 마일리지 차감 내역을 기록한다.
//				if(!pointUse.equals("0")) {
//					Map<String, Object> pointWithdraw = new HashMap<String, Object>();
//					pointWithdraw.put("user_id", (String)session.getAttribute("user_id"));
//					pointWithdraw.put("learn_app_id", learnAppId);
//					pointWithdraw.put("give", 0);
//					pointWithdraw.put("withdraw", pointUse);
//					pointWithdraw.put("note", "수강신청 마일리지 사용");
//					pointService.insertPoint(pointWithdraw);				
//				}
//				Map<String, Object> pointPolicy = pointService.selectPolicyPoint();
//				int pointPercentage = (int)pointPolicy.get("SAVE_LECTURE_POINT");
//				
//				//마일리지 차감 후, 결제 금액에서의 마일리지 추가
//				//마일리지에 관리자에서 설정한 
//				Map<String, Object> pointGive = new HashMap<String, Object>();
//				pointGive.put("user_id", (String)session.getAttribute("user_id"));
//				pointGive.put("learn_app_id", learnAppId);
//				pointGive.put("give", (Integer.parseInt(resultMap.get("TotPrice"))/100) * pointPercentage);
//				pointGive.put("withdraw", 0);
//				pointGive.put("note", "수강신청 결제 마일리지 적립");
//				pointService.insertPoint(pointGive);
				
				RedirectView redirect = new RedirectView("/lms/user/sub07-02?urlParam=payComplete");
			    redirect.setExposeModelAttributes(false);
			    return redirect;
			    

			} else {

				// 결제오류
				model.addAttribute("errorMsg", resultMap.get("resultMsg"));
				System.out.println("*********************************"+resultMap.get("resultMsg"));
				RedirectView redirect = new RedirectView("/lms/user/sub07-02?urlParam=payError");
			    redirect.setExposeModelAttributes(false);
			    return redirect;

			}
		}

		RedirectView redirect = new RedirectView("/lms/user/sub07-02?urlParam=payError");
	    redirect.setExposeModelAttributes(false);
	    return redirect;


	}
	
	@RequestMapping(value = "lms/course/checkAlreadyEnrolled", method = RequestMethod.GET)
	public @ResponseBody boolean checkAlreadyEnrolled(HttpSession session, @RequestParam HashMap<String, String> param) {
		
		boolean existOrNot = false;
		
		param.put("user_id", (String)session.getAttribute("user_id"));
		
		int result = courseService.selectEnrolledListCnt(param);

		if(result!=0) {
			existOrNot = true;
		}
		
		return existOrNot;
	}
	
	@RequestMapping(value = "lms/course/checkPayExist", method = RequestMethod.GET)
	public @ResponseBody void checkPayExist(HttpSession session, @RequestParam HashMap<String, Object> param) {
		
		logger.info("Ajax - 과정에 해당하는 납입 정보 등록 컨트롤러 시작");
		
		param.put("user_id", (String)session.getAttribute("user_id"));
		
		int count = courseService.selectCurriculumPayInfo(param);
		
		if(count == 0) {
			int result = courseService.insertCurriculumPayInfo(param);
		} 
		
		logger.info("Ajax - 과정에 해당하는 납입 정보 등록 컨트롤러 종료");
	}
	
	@RequestMapping(value = "lms/course/insertEduUserPay", method = RequestMethod.GET)
	public @ResponseBody void insertEduUserPay(Authentication auth, HttpSession session, @RequestParam HashMap<String, String> param) {
		
		logger.info("Ajax - 마일리지 결제 등록 컨트롤러 시작");
		param.put("status", "F0001");
		param.put("id", auth.getName());
		String courseId = param.get("course_id");
		String cardinalId = param.get("cardinal_id");
		
		param.put("seq", String.valueOf(seuService.select_pay_crc_seq(courseId, cardinalId)));
		
		seuService.user_pay_info(param);
		
		logger.info("Ajax - 마일리지 결제 등록 컨트롤러 종료");
	}
	
	@RequestMapping(value = "lms/course/toeflList", method=RequestMethod.GET)
	public @ResponseBody Object selectToefl(@RequestParam HashMap<String, String> param) {
		logger.info("Ajax 토플목록 가져오기 시작");
		
		if(param.get("display_list")!=null&&!param.get("display_list").equals("")) {
			String[] display_list_split = param.get("display_list").split(",");
			for(int i = 0; i < display_list_split.length; i++) {
				String key = "display_icons_" + display_list_split[i]; 
				System.out.println("key : " + key + ", value : " + display_list_split[i]);
				param.put(key, display_list_split[i]);
			}
		} else {
			System.out.println("과정리스트 조회시 아이콘관련 세팅 안함");
		}
		
		// 시작 페이지 객체
		String startPage = StringUtils.isBlank((String) param.get("startPage")) ? "1" : (String) param.get("startPage");
		// 시작 페이지 설정
		param.put("startPage", CommonUtil.getStart(startPage, boardPages));
		// 볼 수 있는 페이지 설정?
		param.put("visiblePages", boardPages);

		logger.info("Ajax 토플목록 가져오기 종료");
		
		return courseService.selectToefl(param);
	}
	
	@RequestMapping(value = "lms/course/toeflpageInfo", method = RequestMethod.GET)
	public @ResponseBody Object getPagingToeflInfo(@RequestParam HashMap<String, String> param) {

		logger.info("Ajax 토플 페이징 정보처리 시작");

		HashMap<String, String> returnParam = new HashMap<String, String>();
		
		if(param.get("display_list")!=null&&!param.get("display_list").equals("")) {
			String[] display_list_split = param.get("display_list").split(",");
			for(int i = 0; i < display_list_split.length; i++) {
				String key = "display_icons_" + display_list_split[i]; 
				System.out.println("key : " + key + ", value : " + display_list_split[i]);
				param.put(key, display_list_split[i]);
			}
		} else {
			System.out.println("과정리스트 조회시 아이콘관련 세팅 안함");
		}
		
		// 시작 페이지 객체
		String startPage = StringUtils.isBlank((String) param.get("startPage")) ? "1" : (String) param.get("startPage");
		// 시작 페이지 설정
		System.out.println("startpage 받은 값 : " + param.get("startPage"));
		System.out.println("startpage 세팅 값 : " + CommonUtil.getStart(startPage, boardPages));

		param.put("startPage", CommonUtil.getStart(startPage, boardPages));
		// 볼 수 있는 페이지 설정?
		param.put("visiblePages", boardPages);

		try {
			// 전체 게시물 갯수
			int totalCnt = courseService.selectToeflCnt(param);
			returnParam.put("totalCnt", String.valueOf(totalCnt));
			returnParam.put("totalPages",
					String.valueOf(CommonUtil.getTotalPage(totalCnt, Integer.parseInt(boardPages))));
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 전체 게시물 갯수 설정
		returnParam.put("startPage", CommonUtil.getStart(startPage, boardPages));
		returnParam.put("visiblePages", String.valueOf(boardPages));

		logger.info("Ajax 페이징 정보처리 종료");

		return returnParam;
	}
	
	@RequestMapping(value = "lms/course/payToeflInfo", method = RequestMethod.POST)
	public View user_toefl_info(Model model, HttpServletRequest request, HttpServletResponse response,
			Authentication auth, HttpSession session,@RequestParam HashMap<String,String> param) {
		String retUrl = "lms/course/foreign/sub02-01";
		
		String pointUse = param.get("merchantData").split(",")[0];
		String merPhone = param.get("merchantData").split(",")[1];
		String merEmail = param.get("merchantData").split(",")[2];
		String merId = param.get("merchantData").split(",")[3];
		String merToefl = param.get("merchantData").split(",")[4];
		param.put("user_id", merId);
		param.put("dis_point", pointUse);
		param.put("phone", merPhone);
		param.put("email", merEmail);
		param.put("email", merToefl);
		
		/**********************************************************************************************
		 * INIpay 모듈 세팅 시작
		 **********************************************************************************************/

		// #############################
		// 인증결과 파라미터 일괄 수신
		// #############################
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Map<String, String> paramMap = new Hashtable<String, String>();

		Enumeration<String> elems = request.getParameterNames();

		String temp = "";

		while (elems.hasMoreElements()) {
			temp = (String) elems.nextElement();
			paramMap.put(temp, request.getParameter(temp));

		}

		// #####################
		// 인증이 성공일 경우만
		// #####################
		if ("0000".equals(paramMap.get("resultCode"))) {

			// ############################################
			// 1.전문 필드 값 설정(***가맹점 개발수정***)
			// ############################################

			String mid = paramMap.get("mid"); // 가맹점 ID 수신 받은 데이터로 설정

			//String signKey = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS"; // 가맹점에 제공된
			// 키(이니라이트키)
			// (가맹점
			// 수정후
			// 고정)
			// !!!절대!!
			// 전문
			// 데이터로
			// 설정금지

			String timestamp = SignatureUtil.getTimestamp(); // util에 의해서
			// 자동생성

			String charset = "UTF-8"; // 리턴형식[UTF-8,EUC-KR](가맹점 수정후 고정)
			String format = "NVP"; // 리턴형식[XML,JSON,NVP](가맹점 수정후 고정)

			// 추가적 noti가 필요한 경우(필수아님, 공백일 경우 미발송, 승인은 성공시, 실패시 모두 Noti발송됨)
			// 미사용
			// String notiUrl = "";

			String authToken = paramMap.get("authToken"); // 취소 요청 tid에 따라서
															// 유동적(가맹점 수정후 고정)

			String authUrl = paramMap.get("authUrl"); // 승인요청 API url(수신 받은값으로
														// 설정, 임의 세팅 금지)

			//String netCancel = paramMap.get("netCancelUrl"); // 망취소 API url (수신
																// 받은값으로 설정, 임의
																// 세팅 금지)

			// #####################
			// 2.signature 생성
			// #####################
			Map<String, String> signParam = new HashMap<String, String>();

			signParam.put("authToken", authToken); // 필수
			signParam.put("timestamp", timestamp); // 필수

			// signature 데이터 생성 (모듈에서 자동으로 signParam을 알파벳 순으로 정렬후 NVP 방식으로
			// 나열해 hash)
			String signature = null;
			try {
				signature = SignatureUtil.makeSignature(signParam);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			String price = ""; // 가맹점에서 최종 결제 가격 표기 (필수입력)

			// 1. 가맹점에서 승인시 주문번호가 변경될 경우 (선택입력) 하위 연결.
			// String oid = "";

			// #####################
			// 3.API 요청 전문 생성
			// #####################
			Map<String, String> authMap = new Hashtable<String, String>();

			authMap.put("mid", mid); // 필수
			authMap.put("authToken", authToken); // 필수
			authMap.put("signature", signature); // 필수
			authMap.put("timestamp", timestamp); // 필수
			authMap.put("charset", charset); // default=UTF-8
			authMap.put("format", format); // default=XML
			authMap.put("price", price); // 필수 (가격위변조체크기능)
			// 이니시스 창에서 X(닫기)를 눌러 cancel(결제진행취소)를 했을 때 이전창으로 돌아가기위한 정보담기.
			model.addAttribute("authMap", authMap);
			
			// 2. 가맹점에서 승인시 주문번호가 변경될 경우 (선택입력) 하위 연결.
			// authMap.put("oid", oid);

			// if(null != notiUrl && notiUrl.length() > 0){
			// authMap.put("notiUrl" ,notiUrl);
			// }

			HttpUtil httpUtil = new HttpUtil();

			// #####################
			// 4.API 통신 시작
			// #####################

			String authResultString = "";

			try {
				authResultString = httpUtil.processHTTP(authMap, authUrl);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// ############################################################
			// 5.API 통신결과 처리(***가맹점 개발수정***)
			// ############################################################

			String test = authResultString.replace(",", "&").replace(":", "=").replace("\"", "").replace(" ", "")
					.replace("\n", "").replace("}", "").replace("{", "");

			Map<String, String> resultMap = new HashMap<String, String>();

			try {
				resultMap = ParseUtil.parseStringToMap(test);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} // 문자열을 MAP형식으로 파싱

			if ("0000".equals(resultMap.get("resultCode"))) {
				/*****************************************************************************
				 * 여기에 가맹점 내부 DB에 결제 결과를 반영하는 관련 프로그램 코드를 구현한다.
				 * 
				 * [중요!] 승인내용에 이상이 없음을 확인한 뒤 가맹점 DB에 해당건이 정상처리 되었음을 반영함 처리중 에러 발생시 망취소를 한다.
				 ******************************************************************************/
				model.addAttribute("tid", resultMap.get("tid"));
				model.addAttribute("payMethod", resultMap.get("payMethod"));
				model.addAttribute("TotPrice", resultMap.get("TotPrice"));
				model.addAttribute("MOID", resultMap.get("MOID"));
				model.addAttribute("applDate", resultMap.get("applDate"));
				model.addAttribute("applTime", resultMap.get("applTime"));
				model.addAttribute("VACT_Num", resultMap.get("VACT_Num"));
				model.addAttribute("resultCode", resultMap.get("resultCode"));
				model.addAttribute("VACT_Num", resultMap.get("VACT_Num"));

				System.out.println(test);

				//resultMap.put("seq", paramMap.get("merchantData"));
				resultMap.put("pay_rtn_data", test);
				resultMap.put("id", merId);
				resultMap.put("point", pointUse);
				resultMap.put("toeflId", merToefl);
				
// 				resultMap.put("pay_gb", "F0101"); LMS결제인 경우 				 
				
				HashMap<String, String> copy = new HashMap<String, String>(resultMap);
				if (resultMap.get("payMethod").equals("VBank")) {

					copy.put("status", "F0000");
					param.put("real_payment", resultMap.get("TotPrice"));//실결제금액
					param.put("payment_type", "B");//가상계좌
					courseService.user_pay_toefl(copy);
					
					//입금 전이므로 마일리지 적립 처리 X
					//결제 성공과 함께 사용한 포인트는 차감하기
					//필요 칼럼 - user_id, learn_app_id, give, withdraw, note
					
					HashMap<String, String> getLearnAppParam = new HashMap<String, String>();
					getLearnAppParam.put("user_id", merId);
					
					//사용한 포인트가 0이 아닐 때에만 마일리지 차감 내역을 기록한다.
					if(!pointUse.equals("0")) {
						Map<String, Object> pointWithdraw = new HashMap<String, Object>();
						pointWithdraw.put("user_id", merId);
						pointWithdraw.put("learn_app_id", 0);
						pointWithdraw.put("give", 0);
						pointWithdraw.put("withdraw", pointUse);
						pointWithdraw.put("note", "모의토플 마일리지 사용");
						pointService.insertPoint(pointWithdraw);				
					}
				} else {

					copy.put("status", "F0001");
					courseService.user_pay_toefl(copy);
					
					param.put("real_payment", resultMap.get("TotPrice"));//실결제금액
					param.put("payment_type", "C");//신용카드
					
					//결제 성공과 함께 사용한 포인트는 차감하기
					//필요 칼럼 - user_id, learn_app_id, give, withdraw, note
					
					HashMap<String, String> getLearnAppParam = new HashMap<String, String>();
					getLearnAppParam.put("user_id", merId);
					
					//사용한 포인트가 0이 아닐 때에만 마일리지 차감 내역을 기록한다.
					if(!pointUse.equals("0")) {
						Map<String, Object> pointWithdraw = new HashMap<String, Object>();
						pointWithdraw.put("user_id", merId);
						pointWithdraw.put("learn_app_id", 0);
						pointWithdraw.put("give", 0);
						pointWithdraw.put("withdraw", pointUse);
						pointWithdraw.put("note", "모의토플 마일리지 사용");
						pointService.insertPoint(pointWithdraw);
					}
					
					Map<String, Object> pointPolicy = pointService.selectPolicyPoint();
					int pointPercentage = (int)pointPolicy.get("SAVE_LECTURE_POINT");
					String pointLectureType = (String)pointPolicy.get("SAVE_LECTURE_TYPE");
					
					//마일리지 차감 후, 결제 금액에서의 마일리지 추가
					//마일리지에 관리자에서 설정한 
					if((Integer.parseInt(resultMap.get("TotPrice"))/100)!=0) {
					Map<String, Object> pointGive = new HashMap<String, Object>();
					pointGive.put("user_id", (String)session.getAttribute("user_id"));
					pointGive.put("learn_app_id", 0);
					
					if(pointLectureType.equals("1")){
						pointGive.put("give", pointPercentage);
					}else{
						pointGive.put("give", (Integer.parseInt(resultMap.get("TotPrice"))/100) * pointPercentage);
					}
					
					pointGive.put("withdraw", 0);
					pointGive.put("note", "모의토플 결제 마일리지 적립");
					pointService.insertPoint(pointGive);
					}
				}
				
				RedirectView redirect = new RedirectView("/lms/user/sub07-02?urlParam=payComplete");
			    redirect.setExposeModelAttributes(false);
			    return redirect;
			} else {
				// 결제오류
				model.addAttribute("errorMsg", resultMap.get("resultMsg"));
				System.out.println("*********************************"+resultMap.get("resultMsg"));
				RedirectView redirect = new RedirectView("/lms/user/sub07-02?urlParam=payError");
			    redirect.setExposeModelAttributes(false);
			    return redirect;
			}
		}

		RedirectView redirect = new RedirectView("/lms/user/sub07-02?urlParam=payError");
	    redirect.setExposeModelAttributes(false);
	    return redirect;
	}
	
	@RequestMapping(value = "/lms/course/insertToeflPay", method = RequestMethod.POST)
	public @ResponseBody Object insertToeflPay(HttpSession session, @RequestParam HashMap<String, String> param) {

		logger.info("Ajax - 토플 결제 등록 시작");

		//참고
		//결제정보를 우선 2로 설정하고 넣어서 나의 강의실에서 확인할 수 있다.
		param.put("status", "F0001");

		try {
			//수강신청정보입력 
			int result = courseService.user_pay_toefl(param);
			
			if(result!=0) {
				System.out.println("토플 결제 성공");

				//수강신청 성공시, 마일리지 차감작업을 해야 한다.			
								
				String pointUse = (String)param.get("point");
				if(!pointUse.equals("0")) {
					Map<String, Object> pointWithdraw = new HashMap<String, Object>();
					pointWithdraw.put("user_id", (String)param.get("id"));
					pointWithdraw.put("give", 0);
					pointWithdraw.put("withdraw", pointUse);
					pointWithdraw.put("note", "수강신청 마일리지 사용");

					pointService.insertPoint(pointWithdraw);	
				}
			
			} else {
				System.out.println("토플 결제 실패");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		logger.info("Ajax - 토플 결제 등록 끝");
		return false;
	}
}
