package global.segroup;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.segroup.society.edu.admin.domain.SocietyEduAdminBanner;
import global.segroup.society.edu.admin.domain.SocietyEduAdminSubBanner;
import global.segroup.society.edu.admin.service.SocietyEduAdminService;
import global.segroup.society.edu.apply.service.SocietyEduApplyService;
import global.segroup.util.LocaleUtil;
import global.segroup.util.PathConstants;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController implements PathConstants {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

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
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String newHome( HttpServletRequest request, HttpServletResponse response) {
		StringBuffer url = ((HttpServletRequest) request).getRequestURL();
		String urlLower = url.toString().toLowerCase();
		
		LocaleUtil.setLocale(request, response);
		
		if (urlLower.equals("http://ges.sesoc.global/")) {
			return "redirect:" + PathConstants.SOCIETY_EDU_APPLY_KMOVE;
		} else if(urlLower.equals("http://www.scitmaster.com/") || urlLower.equals("http://scitmaster.com/")) {
			return "redirect:" + PathConstants.SOCIETY_ICTCENTER;
		}else {
			return PathConstants.SES + PathConstants.SES_NEW_MAIN;
		}
	}
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/mainpage", method = RequestMethod.GET)
	public String home( HttpServletRequest request, HttpServletResponse response) {
		StringBuffer url = ((HttpServletRequest) request).getRequestURL();
		String urlLower = url.toString().toLowerCase();
		
		LocaleUtil.setLocale(request, response);
		
		if (urlLower.equals("http://ges.sesoc.global/")) {
			return "redirect:" + PathConstants.SOCIETY_EDU_APPLY_KMOVE;
		} else if(urlLower.equals("http://www.scitmaster.com/") || urlLower.equals("http://scitmaster.com/")) {
			return "redirect:" + PathConstants.SOCIETY_ICTCENTER;
		}else {
			return PathConstants.SES + PathConstants.SES_MAIN;
		}
	}
	
	@RequestMapping(value = PathConstants.SES_MAIN_LANGUAGE_CHANGE, method = RequestMethod.GET)
	public String company_language_change(String lo,HttpServletRequest request , HttpServletResponse response) {
		
		LocaleUtil.setLocale(request, response, lo);
		
		return "redirect:/mainpage";
	}
	
	/**
	 * FAP 관리자 main 페이지로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_MAIN, method = RequestMethod.GET)
	public String society_fap_admin_main(HttpServletRequest request, HttpServletResponse response) {
		
		LocaleUtil.setLocale(request, response);
		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_MAIN;
	}
	
	/**
	 * FAP 기업 main 페이지로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_MAIN, method = RequestMethod.GET)
	public String society_fap_company_main(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.info("FAP 기업 메인 페이지 컨트롤러 시작");
		
		LocaleUtil.setLocale(request, response);
		
		logger.info("FAP 기업 메인 페이지 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_MAIN;
	}
	
	/**
	 * FAP 에이전시 main 페이지로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_MAIN, method = RequestMethod.GET)
	public String society_fap_agency_main(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		LocaleUtil.setLocale(request, response);
		
		//클라이언트 session 정보 리셋
		session.removeAttribute("chosen_fap_comp_id");
		session.removeAttribute("chosen_fap_comp_ja_nm");
		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_MAIN;
	}

	@RequestMapping(value = PathConstants.SOCIETY_FS_MAIN, method = RequestMethod.GET)
	public String society_fs_main() {
		return "redirect:http://ict.sesoc.global" + PathConstants.SOCIETY_FS_MAIN;
	}
	
	@RequestMapping(value = PathConstants.SOCIETY_FS_ADMIN, method = RequestMethod.GET)
	public String society_fs_admin() {
		return "redirect:http://ict.sesoc.global" + PathConstants.SOCIETY_FS_ADMIN;
	}
	
	@RequestMapping(value = PathConstants.SOCIETY_TOEFL_MAIN, method = RequestMethod.GET)
	public String society_toefl_main() {
		return "redirect:http://ict.sesoc.global" + PathConstants.SOCIETY_TOEFL_MAIN;
	}

	@RequestMapping(value = PathConstants.SES_SOCIETY_VISION, method = RequestMethod.GET)
	public String society_vision() {
		
		return PathConstants.SES + PathConstants.SES_SOCIETY_VISION;
	}

	@RequestMapping(value = PathConstants.SES_SOCIETY_HISTORY, method = RequestMethod.GET)
	public String society_history() {

		return PathConstants.SES + PathConstants.SES_SOCIETY_HISTORY;
	}

//	@RequestMapping(value = PathConstants.SOCIETY_ICTCENTER, method = { RequestMethod.GET, RequestMethod.POST })
//	public String ictcenter(Model model, String sessionExpire, HttpServletRequest request, HttpServletResponse response) {
//		
//		LocaleUtil.setLocale(request, response);
//		if(sessionExpire != null) {
//			model.addAttribute("sessionExpire", sessionExpire);
//		}
//		// 메인에 보여줄 모집과정 DB 습득
//		ArrayList<HashMap<String, Object>> slideList = new ArrayList<HashMap<String, Object>>();
//		/*if (sw_devops_master.size() > 0) {
//			longTermList = sw_devops_master.get(0);
//			slideList.add(longTermList);
//		}*/
//		try{
//		slideList.addAll(seaService.selectShortTermList("", "SC IT MASTER CUP과정"));
//		slideList.addAll(seaService.selectShortTermInfo("IT 101"));
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//		model.addAttribute("slideList", slideList);
//
//		// 메인에 보여줄 게시판 DB 습득
//		model.addAttribute("mediainitList", (ArrayList<HashMap<String, Object>>) seaService.main_mediainit_list());
//		model.addAttribute("graduateList", (ArrayList<HashMap<String, Object>>) seaService.main_graduate_list());
//		model.addAttribute("noticeList", (ArrayList<HashMap<String, Object>>) seaService.main_notice_list());
//		model.addAttribute("faqList", (ArrayList<HashMap<String, Object>>) seaService.main_faq_list());
//
//		String path = eduApplyCurriculumGisuInsertImage;
//		model.addAttribute("path", path);
//		
//		// 메인에 보여줄 메인 배너 정보; 2018. 10. 1. 김준영
//		ArrayList<SocietyEduAdminBanner> banner_list = seadService.banner_shown_list();
//		
//		for(SocietyEduAdminBanner lists : banner_list){
//			lists.setImg_full_path(seadService.banner_img_loading(lists.getEdu_ban_saved()));
//		}
//		model.addAttribute("banner_list", banner_list);
//
//		// 메인에 보여줄 서브 배너 정보; 2018. 10. 1. 김준영
//		ArrayList<SocietyEduAdminSubBanner> subbanner_list = seadService.subbanner_shown_list();
//		for(SocietyEduAdminSubBanner lists : subbanner_list){
//			lists.setImg_full_path(seadService.subbanner_img_loading(lists.getEdu_sub_ban_saved()));
//		}
//		model.addAttribute("subbanner_list", subbanner_list);
//		
//		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_MAIN;
//	}
	@RequestMapping(value = PathConstants.SOCIETY_ICTCENTER, method = RequestMethod.GET)
	public String ictcenter() {
		return "redirect:/rainbow";
	}

	@RequestMapping(value = PathConstants.PRIVACY_POLICY, method = RequestMethod.GET)
	public String privacy_policy() {
		// 개인정보처리방침
		return PathConstants.SEGROUP_SOCIETY + PathConstants.PRIVACY_POLICY;
	}

	@RequestMapping(value = PathConstants.USAGE_POLICY, method = RequestMethod.GET)
	public String usage_policy() {
		// 이용정책
		return PathConstants.SEGROUP_SOCIETY + PathConstants.USAGE_POLICY;
	}
	
	@RequestMapping(value=PathConstants.SEGROUP_MAIN_COMPLIST, method = RequestMethod.GET)
	public String main_complist() {
		return PathConstants.SES + PathConstants.SEGROUP_MAIN_COMPLIST;
	}
	
}
