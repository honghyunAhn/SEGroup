package com.aracomm.changbi.main.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.changbi.board.vo.BoardSearchVo;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.common.service.BannerService;
import com.aracomm.changbi.common.service.CommonService;
import com.aracomm.changbi.course.service.ChangbiCourseService;
import com.aracomm.changbi.guide.service.CardinalService;
import com.aracomm.changbi.learn.service.CourseService;
import com.aracomm.changbi.learn.vo.CourseSearchVo;
import com.aracomm.changbi.serviceCenter.service.BbsService;
import com.aracomm.changbi.teacher.service.TeacherService;
import com.google.gson.Gson;

import global.segroup.society.edu.admin.domain.SocietyEduAdminBanner;
import global.segroup.society.edu.admin.domain.SocietyEduAdminSubBanner;
import global.segroup.society.edu.admin.service.SocietyEduAdminService;
import global.segroup.society.edu.apply.service.SocietyEduApplyService;
import global.segroup.society.smtp.community.service.SmtpCommunityService;
import global.segroup.society.smtp.course.service.SmtpCourseService;
import global.segroup.util.LocaleUtil;
import global.segroup.util.PathConstants;

//import com.aracomm.changbi.main.service.MainService;

@Controller
public class MainController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	private static final String MAIN_DISPLAY_COMP = "1";		// 업체추천
	private static final String MAIN_DISPLAY_ELEMENTARY = "2";	// 초등추천
	private static final String MAIN_DISPLAY_MIDDEL = "3";		// 중등추천
	private static final int VISIBLE_PAGES_COURSELIST = 8;		// 페이지당 보여줄 과정수

	@Autowired
	private CourseService courseService;
	
	@Autowired
	private ChangbiCourseService lmsCourseService;

	@Autowired
	private TeacherService teacherService;

	@Autowired
	private BbsService bbsService;

	@Autowired
	private CardinalService cardinalService;

	@Autowired
	private BannerService bannerService;

	@Autowired
	private CommonService commonService;

	@Autowired
	private SmtpCourseService smtpCourseService;
	
	@Autowired
	private SmtpCommunityService smtpCommunityService;
	
	@Autowired
	private SocietyEduApplyService seaService;
	
	@Autowired
	private SocietyEduAdminService seadService;

	/**
	 * file.propertices 의 등록된 과정 기수 등록 이미지 파일 경로
	 */
	@Value("#{props['edu.apply.curriculum_gisu_insert_image']}")
	private String eduApplyCurriculumGisuInsertImage;
	/**
	 * 메인화면
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/")
	public String main(HttpServletRequest request, Model model){
		
		logger.info("logger 테스트");

		
		// 상단 배너 리스트
		List<Map<String, Object>> topBannerList = bannerService.selectBannerList(GlobalConst.BANNER_POSTION_TOP);

		// 창비추천 과정 리스트
		CourseSearchVo courseSearchVo1 = new CourseSearchVo();
		courseSearchVo1.setMain_display(MAIN_DISPLAY_COMP);
		courseSearchVo1.setVisiblePages(VISIBLE_PAGES_COURSELIST);	// page당 8개씩 display
		List<Map<String, Object>> recommCourseList = courseService.selectMainRecommCourseList(courseSearchVo1);

		// 강사리스트
		List<Map<String, Object>> teacherList = teacherService.selectMainTeacherList(4);

		// 분야별 연수 과정
		List<Map<String, String>> courseCodeList = commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_COURSE);
		CourseSearchVo courseSearchVo2 = new CourseSearchVo();
		courseSearchVo2.setCredit(String.valueOf(1));	// 1학점
		List<Map<String, Object>> courseList = courseService.selectMainCourseListAllByCourse(courseSearchVo2);


		// 공지사항 리스트
		BoardSearchVo searchVo = new BoardSearchVo();
		searchVo.setTop(4);
		searchVo.setBoard_type(GlobalConst.BBS_TYPE_NOTICE);
		List<Map<String, Object>> noticeList = bbsService.selectSimpleTopBoardList(searchVo);

		// 자주 묻는 질문 리스트
		searchVo.setBoard_type(GlobalConst.BBS_TYPE_FAQ);
		List<Map<String, Object>> faqList = bbsService.selectSimpleTopBoardList(searchVo);


		// 교육청/기관 단체 연수 배너 리스트
		List<Map<String, Object>> groupLearnBannerList = courseService.selectMainGroupLearnBannerList();

		// 다음연수일정 배녀영역 리스트
		List<Map<String, Object>> cardinalBannerList = cardinalService.selectMainCardinalList();

		model.addAttribute("today", CommonUtil.getFormatDate("yyyy-MM-dd(EEE)"));
		model.addAttribute("topBannerList", topBannerList);
		model.addAttribute("recommSearchVo", courseSearchVo1);
		model.addAttribute("recommCourseList", recommCourseList);
		model.addAttribute("teacherList", teacherList);
		model.addAttribute("courseCodeList", courseCodeList);
		model.addAttribute("courseList", courseList);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("faqList", faqList);
		model.addAttribute("groupLearnBannerList", groupLearnBannerList);
		model.addAttribute("cardinalBannerList", cardinalBannerList);

		return "main/main";
	}
	@RequestMapping(value ="/popup/hub")
	public String mainPopup() {
		return "/popup/mainPopup1";
	}
	/**
	 * 창비 메인 페이지 이동
	 * @param
	 * @return
	 */
	@RequestMapping(value ="lms/main")
	public String lms_main(Model model,String urlParam) {
		
		/*
		 * if(urlParam!=null) if(urlParam.equals("payComplete")){
		 * model.addAttribute("message","payComplete"); }else
		 * if(urlParam.equals("payError")){ model.addAttribute("message","payError"); }
		 */
		
		// 메인 배너 리스트
		List<Map<String, Object>> mainBannerList = bannerService.selectBannerList("2");
		// 띠 배너 리스트
		List<Map<String, Object>> midBannerList = bannerService.selectBannerList("3");
		// Hot&New 배너 리스트
		List<Map<String, Object>> hotAndNewBannerList = bannerService.selectBannerList("4");
		
		// 공지사항/이벤트 리스트
		BoardSearchVo searchVo = new BoardSearchVo();
		searchVo.setTop(5);
		searchVo.setBoard_type(GlobalConst.BBS_TYPE_NOTICE); //1
		List<Map<String, Object>> noticeList = bbsService.selectSimpleTopBoardList(searchVo);
		
		// 자주 묻는 질문 리스트
		searchVo.setBoard_type(GlobalConst.BBS_TYPE_FAQ); //3
		List<Map<String, Object>> faqList = bbsService.selectSimpleTopBoardList(searchVo);

		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("grand", "외국어");
		param.put("startPage", "0");
		param.put("visiblePages", "10");
		param.put("main_recommend_chk", "Y");
		param.put("main_recommend1", "1");
		param.put("main_recommend2", "2");
		param.put("main_recommend3", "3");
		param.put("main_recommend4", "4");
		param.put("main_recommend5", "5");
		//select문에서 main 추천 강좌를 표시하는 order를 지정하기 위한 flag값(null이나 빈칸만 아니면 된다.)
		param.put("main_recommend_order", "1");
		List<HashMap<String, String>> recommend_foreign_list = lmsCourseService.selectCourseBoardList(param);
		
		// 신규, 추천, 인기, 교재, 할인 아이콘 표시
		for (int i = 0; i < recommend_foreign_list.size(); i++) {
			if (recommend_foreign_list.get(i).get("icon_displays").contains("1")) {
				recommend_foreign_list.get(i).put("icon_1", "Y");
			}
			if (recommend_foreign_list.get(i).get("icon_displays").contains("2")) {
				recommend_foreign_list.get(i).put("icon_2", "Y");
			}
			if (recommend_foreign_list.get(i).get("icon_displays").contains("3")) {
				recommend_foreign_list.get(i).put("icon_3", "Y");
			}
			if (recommend_foreign_list.get(i).get("icon_displays").contains("4")) {
				recommend_foreign_list.get(i).put("icon_4", "Y");
			}
			if (recommend_foreign_list.get(i).get("icon_displays").contains("5")) {
				recommend_foreign_list.get(i).put("icon_5", "Y");
			}
		}
		model.addAttribute("foreign_recommends", recommend_foreign_list);
		param.put("grand", "ICT");
		List<HashMap<String, String>> recommend_it_list = lmsCourseService.selectCourseBoardList(param);
		// 신규, 추천, 인기, 교재, 할인 아이콘 표시
		for (int i = 0; i < recommend_it_list.size(); i++) {
			if (recommend_it_list.get(i).get("icon_displays").contains("1")) {
				recommend_it_list.get(i).put("icon_1", "Y");
			}
			if (recommend_it_list.get(i).get("icon_displays").contains("2")) {
				recommend_it_list.get(i).put("icon_2", "Y");
			}
			if (recommend_it_list.get(i).get("icon_displays").contains("3")) {
				recommend_it_list.get(i).put("icon_3", "Y");
			}
			if (recommend_it_list.get(i).get("icon_displays").contains("4")) {
				recommend_it_list.get(i).put("icon_4", "Y");
			}
			if (recommend_it_list.get(i).get("icon_displays").contains("5")) {
				recommend_it_list.get(i).put("icon_5", "Y");
			}
		}
		model.addAttribute("it_recommends", recommend_it_list);
		
		param.put("grand", "직무역량");
		List<HashMap<String, String>> recommend_business_list = lmsCourseService.selectCourseBoardList(param);
		// 신규, 추천, 인기, 교재, 할인 아이콘 표시
		for (int i = 0; i < recommend_business_list.size(); i++) {
			if (recommend_business_list.get(i).get("icon_displays").contains("1")) {
				recommend_business_list.get(i).put("icon_1", "Y");
			}
			if (recommend_business_list.get(i).get("icon_displays").contains("2")) {
				recommend_business_list.get(i).put("icon_2", "Y");
			}
			if (recommend_business_list.get(i).get("icon_displays").contains("3")) {
				recommend_business_list.get(i).put("icon_3", "Y");
			}
			if (recommend_business_list.get(i).get("icon_displays").contains("4")) {
				recommend_business_list.get(i).put("icon_4", "Y");
			}
			if (recommend_business_list.get(i).get("icon_displays").contains("5")) {
				recommend_business_list.get(i).put("icon_5", "Y");
			}
		}
		model.addAttribute("business_recommends", recommend_business_list);
		
		param.put("grand", "자격증");
		List<HashMap<String, String>> recommend_license_list = lmsCourseService.selectCourseBoardList(param);
		// 신규, 추천, 인기, 교재, 할인 아이콘 표시
		for (int i = 0; i < recommend_license_list.size(); i++) {
			if (recommend_license_list.get(i).get("icon_displays").contains("1")) {
				recommend_license_list.get(i).put("icon_1", "Y");
			}
			if (recommend_license_list.get(i).get("icon_displays").contains("2")) {
				recommend_license_list.get(i).put("icon_2", "Y");
			}
			if (recommend_license_list.get(i).get("icon_displays").contains("3")) {
				recommend_license_list.get(i).put("icon_3", "Y");
			}
			if (recommend_license_list.get(i).get("icon_displays").contains("4")) {
				recommend_license_list.get(i).put("icon_4", "Y");
			}
			if (recommend_license_list.get(i).get("icon_displays").contains("5")) {
				recommend_license_list.get(i).put("icon_5", "Y");
			}
		}
		model.addAttribute("license_recommends", recommend_license_list);
		
		param.put("grand", "취업연계");
		List<HashMap<String, String>> recommend_jobtraining_list = lmsCourseService.selectCourseBoardList(param);
		model.addAttribute("jobtraining_recommends", recommend_jobtraining_list);
		
		
		model.addAttribute("mainBannerList", mainBannerList);
		model.addAttribute("midBannerList", midBannerList);
		model.addAttribute("hotAndNewBannerList", hotAndNewBannerList);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("faqList", faqList);
		
		return "lms/main";
	}
	
	@RequestMapping(value ="/rainbow")
	public String ictcenter(Model model, String sessionExpire, HttpServletRequest request, HttpServletResponse response, String urlParam) {
		
		if(urlParam!=null) {
			switch(urlParam.split("-")[0]) {
			case "payComplete":
				model.addAttribute("message","payComplete");
				break;
			case "payError":
				model.addAttribute("message","payError");
				break;
			}
			
			if(urlParam.split("-")[1].equalsIgnoreCase("sessionExpire")) {
				model.addAttribute("session","sessionExpire");
			}
		 }
		
		LocaleUtil.setLocale(request, response);
		if(sessionExpire != null) {
			model.addAttribute("sessionExpire", sessionExpire);
		}
		// 메인에 보여줄 모집과정 DB 습득
		ArrayList<HashMap<String, Object>> slideList = new ArrayList<HashMap<String, Object>>();
		/*if (sw_devops_master.size() > 0) {
			longTermList = sw_devops_master.get(0);
			slideList.add(longTermList);
		}*/
		try{
		slideList.addAll(seaService.selectShortTermList("", "SC IT MASTER CUP과정"));
		slideList.addAll(seaService.selectShortTermInfo("IT 101"));
		}catch(Exception e){
			e.printStackTrace();
		}
		model.addAttribute("slideList", slideList);

		// 메인에 보여줄 게시판 DB 습득
		model.addAttribute("mediainitList", (ArrayList<HashMap<String, Object>>) seaService.main_mediainit_list());
		model.addAttribute("graduateList", (ArrayList<HashMap<String, Object>>) seaService.main_graduate_list());
		model.addAttribute("noticeList", (ArrayList<HashMap<String, Object>>) seaService.main_notice_list());
		model.addAttribute("faqList", (ArrayList<HashMap<String, Object>>) seaService.main_faq_list());

		String path = eduApplyCurriculumGisuInsertImage;
		model.addAttribute("path", path);
		
		// 메인에 보여줄 메인 배너 정보; 2018. 10. 1. 김준영
		ArrayList<SocietyEduAdminBanner> banner_list = seadService.banner_shown_list();
		
		for(SocietyEduAdminBanner lists : banner_list){
			lists.setImg_full_path(seadService.banner_img_loading(lists.getEdu_ban_saved()));
		}
		model.addAttribute("banner_list", banner_list);

		// 메인에 보여줄 서브 배너 정보; 2018. 10. 1. 김준영
		ArrayList<SocietyEduAdminSubBanner> subbanner_list = seadService.subbanner_shown_list();
		for(SocietyEduAdminSubBanner lists : subbanner_list){
			lists.setImg_full_path(seadService.subbanner_img_loading(lists.getEdu_sub_ban_saved()));
		}
		model.addAttribute("subbanner_list", subbanner_list);
		
		return "/segroup/society/smtp/index";
	}
	
	/**
	 * 일본취업과정 소개글 페이지 이동
	 * @param
	 * @return
	 */
	@RequestMapping(value ="lms/class-intro")
	public String class_intro() {
		return "lms/class-intro";
	}
	
	@RequestMapping(value ="smpt/class-intro")
	public String smtp_intro() {
		return "smpt/class-intro";
	}
	
	@RequestMapping(value ="/cancelPage1")
	public String cancelPage1() {
		return "main/cancel";
	}
	
	
	@RequestMapping(value = "/loginPage")
	public String login() {
		
		return "main/login";
	}

	/**
	 * 추천과정 리스트 조회
	 * @param searchVo
	 * @return
	 */
	@RequestMapping(value = "/ajaxMainRecommendCourseList")
	public @ResponseBody HashMap<String, Object> ajaxMainRecommendCourseList(CourseSearchVo searchVo) {
		HashMap<String, Object> result = getSimpleAjaxResult();

		if("N".equals(searchVo.getGubun())) {	// 추천구분 : 신규과정 [1:창비추천, 2:초등추천, 3:중등추천, N:신규과정]
			searchVo.setNewYn("Y");
		} else {
			searchVo.setMain_display(searchVo.getGubun());
		}
		searchVo.setVisiblePages(VISIBLE_PAGES_COURSELIST);	// page당 8개씩 display

		result.put("recommSearchVo", searchVo);
		result.put("recommCourseList", courseService.selectMainRecommCourseList(searchVo));

		return result;
	}

	/**
	 * 과정구분별 과정 리스트 조회
	 * @param searchVo
	 * @return
	 */
	@RequestMapping(value = "/ajaxMainCourseListByCourse")
	public @ResponseBody HashMap<String, Object> ajaxMainCourseListByCourse(CourseSearchVo searchVo) {
		HashMap<String, Object> result = getSimpleAjaxResult();

		List<Map<String, Object>> courseList = courseService.selectMainCourseListAllByCourse(searchVo);

		result.put("courseList", courseList);

		return result;
	}



}
