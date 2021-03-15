/**
 * 
 */
package global.segroup.society.edu.admin.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.security.auth.login.AccountExpiredException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import global.segroup.domain.Admin;
import global.segroup.domain.AdminPager;
import global.segroup.domain.AdminSecurity;
import global.segroup.domain.BoardContent;
import global.segroup.domain.BoardFile;
import global.segroup.domain.BoardGroup;
import global.segroup.domain.FaqConsultingContents;
import global.segroup.domain.OfflineConsultingContents;
import global.segroup.domain.OnlineConsultingContents;
import global.segroup.domain.User;
import global.segroup.domain.UserSecurity;
import global.segroup.exception.ExpiredDateException;
import global.segroup.society.edu.admin.domain.SocietyEduAdminBanner;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculum;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculumGisu;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculumGisuImg;
import global.segroup.society.edu.admin.domain.SocietyEduAdminPayment;
import global.segroup.society.edu.admin.domain.SocietyEduAdminSubBanner;
import global.segroup.society.edu.admin.service.SocietyEduAdminService;
import global.segroup.society.edu.user.service.SocietyEduUserService;
import global.segroup.util.LocaleUtil;
import global.segroup.util.PathConstants;

/**
 * @Author : 이종호
 * @Date : 2017. 8. 4.
 * @Class 설명 : Soft Engineer Society 모집홍보 관리자 View 컨트롤러
 * 
 */

@Controller
public class SocietyEduAdminViewController implements PathConstants {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyEduAdminViewController.class);
	
	@Autowired
	private SocietyEduAdminService seaService;
	
	@Autowired
	private SocietyEduUserService seuService;
	
	/**
	 * file.propertices 의 등록된 과정 기수 등록 이미지 파일 경로
	 */
	@Value("#{props['edu.apply.curriculum_gisu_insert_image']}")
	private String eduApplyCurriculumGisuInsertImage;
	
	/**
	 * file.propertices 의 등록된 과정 기수 홍보 이미지 파일 경로
	 */
	@Value("#{props['edu.admin.curriculum_gisu_insert_image']}")
	private String eduAdminCurriculumGisuInsertImage;
	
	/**
	 * @Method Name : curriculum_form
	 * @Date : 2017. 8. 4.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 과정개설 페이지)
	 * @Method 설명 : 관리자 페이지에서 과정개설 페이지 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_INSERT_FORM, method = RequestMethod.GET)
	public String curriculum_insert_form(Model model){
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_INSERT_FORM;
	}
	
	/**
	 * @Method Name : curriculum_insert
	 * @Date : 2017. 8. 4.
	 * @User : 이종호
	 * @Param : 과정개설 정보
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 과정 관리 페이지)
	 * @Method 설명 : 관리자 페이지에서 과정 개설 등록 후 페이지 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_INSERT, method = RequestMethod.POST)
	public String curriculum_insert(Authentication auth, SocietyEduAdminCurriculum seaCur){
		logger.debug("과정 개설 등록 컨트롤러 시작");
		
		// 로그인한 관리자 아이디 설정
		seaCur.setCrc_ins_id((String)auth.getPrincipal());
		seaCur.setCrc_udt_id((String)auth.getPrincipal());
		
		seaService.curriculum_insert(seaCur);
		
		logger.debug("과정 개설 등록 컨트롤러 종료");
		
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_MANAGER_FORM;
	}
	
	/**
	 * @Method Name : curriculum_manager_form
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 과정 관리 페이지)
	 * @Method 설명 : 관리자 페이지에서 과정 관리 폼 이동, 모든 과정 정보를 조회 후 Model에 담아서 리턴
	 */
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_MANAGER_FORM, method = RequestMethod.GET)
	public String curriculum_manager_form(Model model,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int pageCount,
			@RequestParam(defaultValue="") String orderType,
			@RequestParam(defaultValue="") String orderValue,
			@RequestParam(defaultValue="") String searchName){
		logger.debug("전체 과정 검색 컨트롤러 시작");
		
		int count = seaService.searchCurriculumAllCount();
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
	    map.put("count", count); // 레코드의 갯수
	    map.put("orderType", orderType); // 정렬 컬럼
	    map.put("orderValue", orderValue); // 정렬 기준(desc,asc)
	    map.put("pageCount", pageCount);
	    map.put("adminPager", adminPager);
	    map.put("searchName", searchName);
	    
	    ArrayList<SocietyEduAdminCurriculum> seaCurList = seaService.searchCurriculumAll(map);
	    model.addAttribute("map",map);
		model.addAttribute("seaCurList", seaCurList);
		
		logger.debug("전체 과정 검색 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_MANAGER_FORM;
	}
	
	/**
	 * @Method Name : currculum_update_form
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 과정 시퀀스 정보
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 과정 수정 폼)
	 * @Method 설명 : 과정 시퀀스로 과정 정보 조회 후 Model에 담아서 리턴
	 */
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_UPDATE_FORM, method = RequestMethod.GET)
	public String curriculum_update_form(int crc_seq, Model model){
		logger.debug("특정 과정 검색 후 수정 폼 이동 컨트롤러 시작");
		
		Gson gson = new Gson();
		
		SocietyEduAdminCurriculum seaCurriculum = seaService.searchCurriculum(crc_seq);
		
		model.addAttribute("seaCurriculumJson", gson.toJson(seaCurriculum));
		
		model.addAttribute("seaCurriculum", seaCurriculum);
		
		String path = eduApplyCurriculumGisuInsertImage;
		model.addAttribute("path", path);
		
		logger.debug("특정 과정 검색 후 수정 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : curriculum_update
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 과정 정보 객체 
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 과정 관리 페이지)
	 * @Method 설명 : 관리자 페이지에서 과정 정보를 수정하는 컨트롤러 함수 
	 */
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_UPDATE, method = RequestMethod.POST)
	public String curriculum_update(Authentication auth, SocietyEduAdminCurriculum seaCur){
		logger.debug("과정 정보 수정 컨트롤러 시작");
		
		System.out.println("seaCur : " + seaCur.toString());
		
		// 업데이트를 진행한 로그인한 관리자 아이디 설정
		seaCur.setCrc_udt_id((String)auth.getPrincipal());
		
		seaService.curriculum_update(seaCur);
		
		logger.debug("과정 정보 수정 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_MANAGER_FORM;
	}
	
	/**
	 * @Method Name : curriculum_gisu_manager_form
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 기수 관리 페이지)
	 * @Method 설명 : 관리자 페이지에서 기수 관리 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_GISU_MANAGER_FORM, method = RequestMethod.GET)
	public String curriculum_gisu_manager_form(Model model,
				@RequestParam(defaultValue="1") int curPage,
				@RequestParam(defaultValue="10") int pageCount,
				@RequestParam(defaultValue="gisu") String orderType,
				@RequestParam(defaultValue="") String searchName,
				@RequestParam(defaultValue="desc") String orderValue){
		logger.debug("전체 과정 검색 컨트롤러 시작");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("searchName", searchName);
		int count = seaService.searchCurriculumGisuAllCount(map);
		//AdminPager.setBLOCK_SCALE(10);
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
		
	    map.put("count", count); // 레코드의 갯수
	    map.put("adminPager", adminPager);
	    map.put("orderType", orderType);
	    map.put("orderValue", orderValue);
	    map.put("pageCount", pageCount);
	    ArrayList<SocietyEduAdminCurriculumGisu> curGisuList = seaService.searchCurriculumGisuAll(map);
	   
	    System.out.println(map);
	    model.addAttribute("map",map);
		model.addAttribute("seaCurGisu", curGisuList);
		
		logger.debug("전체 과정 검색 컨트롤러 종료");
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_GISU_MANAGER_FORM;
	}
	
	/**
	 * @Method Name : payment_manager_form
	 * @Date : 2017. 12. 4.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 결제 관리 페이지)
	 * @Method 설명 : 관리자 페이지에서 기수 관리 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_PAYMENT_MANAGER_FORM, method = RequestMethod.GET)
	public String payment_manager_form(Model model,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int pageCount,
			/*@RequestParam(defaultValue="contents") String searchOption,
			@RequestParam(defaultValue="") String keyword,*/
			@RequestParam(defaultValue="") String searchName,
			@RequestParam(defaultValue="gisu") String orderType,
			@RequestParam(defaultValue="desc") String orderValue){
		
		logger.debug("전체 과정 검색 컨트롤러 시작");
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("searchName", searchName); // 검색옵션
		int count = seaService.searchCurriculumGisuAllCount(map);
		//AdminPager.setBLOCK_SCALE(5);
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
		
	    map.put("count", count); // 레코드의 갯수
	    map.put("adminPager", adminPager);
	    map.put("orderType", orderType);
	    map.put("orderValue", orderValue);
	    map.put("pageCount", pageCount);
		
	    model.addAttribute("map",map);
		model.addAttribute("seaCurGisu", seaService.searchCurriculumGisuAll(map));
		
		logger.debug("전체 과정 검색 컨트롤러 종료");
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_PAYMENT_MANAGER_FORM;
	}
	
	
	
	/**
	 * @Method Name : payment_form
	 * @Date : 2017. 12. 4.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 결제 페이지)
	 * @Method 설명 : 관리자 페이지에서 기수 관리 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_PAYMENT_FORM, method = RequestMethod.POST)
	public String payment_form(Model model,String gisu_seq,String gisu_name){
		
		logger.debug("전체 과정 검색 컨트롤러 시작");
		
		
        List<HashMap<String, Object>> resultMap = seaService.selectPayInfo(gisu_seq);
	
		
		model.addAttribute("pay_info", resultMap);	
		model.addAttribute("gisu_seq", gisu_seq);
		model.addAttribute("gisu_name", gisu_name);
		
		logger.debug("전체 과정 검색 컨트롤러 종료");
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_PAYMENT_FORM;
	}
	
	/**
	 * @Method Name : payment_update_validity
	 * @Date : 2018. 2. 10.
	 * @User : 윤상혁
	 * @Param : 기수 시퀀스
	 * @Return : 기수 결제정보 수정/삭제 가능여부
	 * @Method 설명 : 기수 결제정보 수정/삭제 가능여부를 리턴하는 컨트롤러 함수
	 */
	@RequestMapping(value="edu/admin/payment_update_validity", method = RequestMethod.POST)
	public @ResponseBody String payment_update_validity(int gisu_seq){
		logger.debug("기수 결제정보 수정/삭제 가능여부 확인 컨트롤러 시작");
		int payCount = 0;
		List<HashMap<String, Object>> payList = seaService.selectPayByGisu(gisu_seq);
		payCount = payList.size();
		System.out.println(payList);
		logger.debug("기수 결제정보 수정/삭제 가능여부 확인 컨트롤러 종료");
		return ""+payCount;
	}
	
	/**
	 * @Method Name : payment_form
	 * @Date : 2017. 12. 4.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 결제 페이지)
	 * @Method 설명 : 관리자 페이지에서 기수결제정보등록하는 컨트롤러 함수
	 */
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_PAYMENT_INSERT_FORM, method = RequestMethod.POST)
	public @ResponseBody
	List<HashMap<String, Object>> payment_insert_form(Model model,SocietyEduAdminPayment seap, String gisu_seq,Authentication auth){
		
		logger.debug("전체 과정 검색 컨트롤러 시작");
		
		for(int i=0;i<seap.getPaymentList().size();i++){
			seap.getPaymentList().get(i).setAdminId(auth.getName());
			seap.getPaymentList().get(i).setSeq(gisu_seq);
		}
		seaService.payInfoInsert(seap);
		
		logger.debug("전체 과정 검색 컨트롤러 종료");
		 List<HashMap<String, Object>> resultMap = seaService.selectPayInfo(gisu_seq);
		return resultMap;
	}
	
	/**
	 * @Method Name : payment_delete_form
	 * @Date : 2017. 12. 4.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 결제 페이지)
	 * @Method 설명 : 관리자 페이지에서 결제삭제하는 컨트롤러 함수
	 */
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_PAYMENT_DELETE_FORM, method = RequestMethod.POST)
	public @ResponseBody
	List<HashMap<String, Object>> payment_delete_form(Model model,SocietyEduAdminPayment seap, String gisu_seq,Authentication auth){
		
		logger.debug("전체 과정 검색 컨트롤러 시작");
		
		for(int i=0;i<seap.getPaymentList().size();i++){
			seap.getPaymentList().get(i).setAdminId(auth.getName());
			seap.getPaymentList().get(i).setSeq(gisu_seq);
		}
		seaService.payInfoDelete(seap);
		
		
		logger.debug("전체 과정 검색 컨트롤러 종료");
		 List<HashMap<String, Object>> resultMap = seaService.selectPayInfo(gisu_seq);
		return resultMap;
	}
	
	/**
	 * @Method Name : curriculum_gisu_insert_form
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 기수 개설 폼 페이지)
	 * @Method 설명 : 관리자 페이지에서 기수 정보를 개설하는 폼으로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_GISU_INSERT_FORM, method = RequestMethod.GET)
	public String curriculum_gisu_insert_form(Model model){
		logger.debug("기수 개설 폼 컨트롤러 시작");
		
		model.addAttribute("seaCurList", seaService.searchCurriculumPermission());
		
		logger.debug("기수 개설 폼 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_GISU_INSERT_FORM;
	}
			
	/**
	 * @Method Name : curriculum_gisu_update_form
	 * @Date : 2017. 8. 7. -> 2018. 9. 28
	 * @User : 이종호, 신동철
	 * @Param : 기수 시퀀스 정보 
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 기수 수정 폼 페이지)
	 * @Method 설명 : 기수 시퀀스 정보에 해당하는 기수 정보를 조회하여 Model에 담아서 리턴
	 */
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_GISU_UPDATE_FORM, method = RequestMethod.GET)
	public String curriculum_gisu_update_form(int gisu_seq, Model model){
		logger.debug("기수 정보 수정 폼 이동 컨트롤러 시작");
		
		Gson gson = new Gson();
		
		SocietyEduAdminCurriculumGisu seaCurGisu = seaService.searchCurGisu(gisu_seq);
		
		model.addAttribute("seaCurGisuJson", gson.toJson(seaCurGisu));
		
		model.addAttribute("seaCurList", seaService.searchCurriculumPermission());
		model.addAttribute("seaCurGisu",seaCurGisu);
		model.addAttribute("seaCurGisuImgList", seaService.searchCurGisuImgList(gisu_seq));
		
		String path = eduAdminCurriculumGisuInsertImage+"/";
		model.addAttribute("path", path);
		logger.debug("기수 정보 수정 폼 이동 컨트롤러 종료");
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_GISU_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : curriculum_gisu_update
	 * @Date : 2017. 8. 7. -> 2018. 10. 1
	 * @User : 이종호, 신동철
	 * @Param : 기수 정보 객체
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 기수 관리 폼 페이지)
	 * @Method 설명 : 관리자 페이지에서 기수 정보를 수정하는 컨트롤러 함수
	 */
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_GISU_UPDATE, method = RequestMethod.POST)
	public String curriculum_gisu_update(SocietyEduAdminCurriculumGisuImg seaCurGisuImg, Authentication auth, SocietyEduAdminCurriculumGisu seaCurGisu){
		logger.debug("기수 정보 수정 컨트롤러 시작");
		
		// 업데이트를 진행한 로그인한 관리자 아이디 설정
		seaCurGisu.setGisu_udt_id((String)auth.getPrincipal());		
		seaService.curriculum_gisu_update(seaCurGisu);
						
		//기수 이미지 수정
		if(seaCurGisuImg.getGisu_crc_img_list() != null){
			seaCurGisuImg.setGisu_crc_img_udt_id((String)auth.getPrincipal());
			//기수 업데이트 폼에서 이미지를 insert하기 위한 정보 입력
			seaCurGisuImg.setGisu_crc_img_saved_file_ins_id((String)auth.getPrincipal());		
			seaService.curriculum_gisu_img_update(seaCurGisuImg);		
		}
		logger.debug("기수 정보 수정 컨트롤러 종료");
		
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_GISU_MANAGER_FORM;
	}
	
	/**
	 * @Method Name : apply_info_update_form
	 * @Date : 2018. 02. 13.
	 * @User : 박기호
	 * @Param : 
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 지원신청서 페이지)
	 * @Method 설명 : 해당하는 학생의 지원신청서 자료보기.
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_APPLY_INFO_UPDATE_FORM , method = RequestMethod.GET
			, produces ="text/json;charset=UTF-8")
	public String apply_form(Model model,
			@RequestParam(defaultValue="") int gisu_seq,
			@RequestParam(defaultValue="") String app_id,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int pageCount,
			@RequestParam(defaultValue="") String search_name,
			@RequestParam(defaultValue="apply_date") String orderType,
			@RequestParam(defaultValue="desc") String orderValue
			){
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("gisu_seq", gisu_seq);
		map.put("app_id", app_id);
		
		map.put("curPage", curPage);
		map.put("pageCount", pageCount);
		map.put("search_name", search_name);
		map.put("orderType", orderType);
		map.put("orderValue", orderValue);
		model.addAttribute("map", map);
		
		HashMap<String,Object> resultMap = seaService.selectEduApplyForm(map);
		Gson gson = new Gson();
		model.addAttribute("eduApply", resultMap);
		model.addAttribute("app_self_intro", resultMap.get("app_self_intro"));
		resultMap.remove("app_self_intro");
		
		/*유저정보 검색*/
		User user = new User();
		user.setUser_id(app_id);
		User userInfo = seaService.user_info_select(user);
		model.addAttribute("detail",userInfo);
		model.addAttribute("eduApplyJson",gson.toJson(resultMap));
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_APPLY_INFO_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : apply_info_print_form
	 * @Date : 2018. 08. 24.
	 * @User : 김지훈
	 * @Param : 
	 * @Return : JSP 리턴페이지(지원신청서 인쇄용 페이지)
	 * @Method 설명 : 해당하는 학생의 인쇄화면 보기.
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_APPLY_INFO_PRINT_FORM , method = RequestMethod.GET)
	public String apply_info_print_form(Model model, String app_info){
		HashMap<String, Object> map = new HashMap<>();
		
		List<HashMap<String,Object>> resultList = new ArrayList<HashMap<String,Object>>();
		HashMap<String,Object> resultMap = new HashMap<String,Object>();

		// 인쇄할 지원자의 기수와 아이디 정보를 가공
		List<String> infoList = new ArrayList<String>(Arrays.asList(app_info.split(";")));
		
		for (String str : infoList) {
			String[] result = str.split(",");
			
			map.put("gisu_seq", result[0]);
			map.put("app_id", result[1]);
			
			resultMap = seaService.selectEduApplyForm(map);
			resultList.add(resultMap);
		}
		model.addAttribute("eduApplyList", resultList);

		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_APPLY_INFO_PRINT_FORM;
	}
	
	
	/**
	 * @Method Name : apply_manager_form
	 * @Date : 2017. 8. 18.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 관리자 지원자 관리 폼 페이지)
	 * @Method 설명 : 관리자 페이지에서 지원자 관리 폼으로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_APPLY_MANAGER_FORM, method = RequestMethod.GET)
	public String apply_manager_form(Model model){
		logger.debug("모집홍보 관리자 지원자 관리 폼 이동 컨트롤러 시작");
		
		model.addAttribute("seaCurList", seaService.searchCurriculumPermission());
		
		// 모든 지원자들 정보 조회
		HashMap<String, Object> map = new HashMap<String, Object>();
		int count = seaService.apply_manager_select_count(new HashMap<String, Object>());
		map.put("count", count); // 레코드의 갯수
		AdminPager.setPAGE_SCALE(10);
		AdminPager adminPager = new AdminPager(count, 1);
		map.put("adminPager", adminPager); // 페이징 객체
		ArrayList<HashMap<String, Object>> resultList = seaService.apply_manager_select(map);
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("pageCount", 10);
		resultMap.put("resultList", resultList);
		resultMap.put("adminPager", adminPager);
		model.addAttribute("resultMap", resultMap);
		
		logger.debug("모집홍보 관리자 지원자 관리 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_APPLY_MANAGER_FORM;
	}
	
	/**
	 * @Method Name : payment_manager_user
	 * @Date : 2017. 12. 4.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 결제 관리 페이지)
	 * @Method 설명 : 관리자 페이지에서 결제 관리 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_PAYMENT_USER_FORM, method = RequestMethod.GET)
	public String payment_manager_user(Model model){
		
		logger.debug("전체 과정 검색 컨트롤러 시작");
		
		model.addAttribute("seaCurList", seaService.searchCurriculumPermission());
		
		logger.debug("전체 과정 검색 컨트롤러 종료");
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_PAYMENT_USER_FORM;
	}
	
	/**
	 * @Method Name : payment_manager_refund
	 * @Date : 2017. 12. 21.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 환불 관리 페이지)
	 * @Method 설명 : 관리자 페이지에서 환불 관리 페이지로 이동하는 컨트롤러 함수
	 */
//	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_PAYMENT_USER_REFUND, method = RequestMethod.GET)
//	public String payment_manager_refund(Model model){
//		
//		logger.debug("전체 과정 검색 컨트롤러 시작");
//		model.addAttribute("seaCurList", seaService.searchCurriculumPermission());
//		model.addAttribute("seaRefundList", seaService.searchCurriculumRefund());
//		
//		logger.debug("전체 과정 검색 컨트롤러 종료");
//		
//		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_PAYMENT_USER_REFUND;
//	}
	
	
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_FORM, method = RequestMethod.GET)
	public String admin_form(){
		logger.debug("모집홍보 관리자 메인 폼 이동 컨트롤러 시작");
		logger.debug("모집홍보 관리자 메인 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_FORM;
	}
	
	/**
	 * @Method Name : admin_login_form
	 * @Date : 2017. 8. 9.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 모집홍보 관리자 로그인 폼 페이지)
	 * @Method 설명 : 모집홍보 관리자 로그인 폼 페이지 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_LOGIN_FORM , method = RequestMethod.GET)
	public String admin_login_form(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		logger.debug("모집홍보 관리자 로그인 폼 이동 컨트롤러 시작");
		
		LocaleUtil.setLocale(request, response);
		
		Exception exception = (Exception)session.getAttribute("SPRING_SECURITY_LAST_EXCEPTION");
		
		
		if((exception != null) && !(exception.getCause() instanceof UsernameNotFoundException || exception.getCause() instanceof BadCredentialsException) ){
			//세션 초기화
			SecurityContextHolder.clearContext();
			session.invalidate();
			//휴면 계정 처리
			if(exception.getCause() instanceof DisabledException){
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_DORMANCY_FORM;
			}
			//탈퇴 계정 처리
			else if(exception.getCause() instanceof AccountExpiredException){
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_EXPIRED_FORM;
			}
			//정지 계정 처리
			else if(exception.getCause() instanceof LockedException){
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_LOCKED_FORM;
			}
			//관리자 권한 기간 만료
			else if(exception.getCause() instanceof ExpiredDateException){
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_TERMINATION_FORM;
			}
			// 승인 대기 계정 처리
			else {
				return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_ADMIN_PENDING_APPROVAL_FORM;
			}
		}
		
		logger.debug("모집홍보 관리자 로그인 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_LOGIN_FORM;
	}
	
	/**
	 * @Method Name : admin_login_form
	 * @Date : 2017. 8. 9.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 모집홍보 관리자 로그인 폼 페이지)
	 * @Method 설명 : 모집홍보 관리자 로그인 폼 페이지 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SES_SOCIETY_ADMIN , method = RequestMethod.GET)
	public String ses_society_admin(){
		
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_LOGIN_FORM;
	}
	
	/**
	 * @Method Name : admin_login_success
	 * @Date : 2017. 8. 9.
	 * @User : 이종호
	 * @Param : 인증 정보 객체
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 모집홍보 관리자 로그인 성공)
	 * @Method 설명 : 모집홍보 관리자 로그인 성공시 권한별 페이지 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_LOGIN_SUCCESS, method = RequestMethod.GET)
	public String admin_login_success(Authentication auth){
		logger.debug("모집홍보 관리자 로그인 성공 컨트롤러 시작");
		Object authObj = auth.getDetails();
		
		if(authObj instanceof UserSecurity){
			logger.debug("모집홍보 관리자 로그인 성공 컨트롤러 종료");
			return "redirect:"+PathConstants.SOCIETY_EDU_USER_ACCESS_DENIED;
		}else if(authObj instanceof AdminSecurity){
			logger.debug("모집홍보 관리자 로그인 성공 컨트롤러 종료");
			return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_FORM;
		}else{
			logger.debug("모집홍보 관리자 로그인 성공 컨트롤러 종료");
			return "home";
		}
	}
	
	/**
	 * @Method Name : admin_access_denied
	 * @Date : 2017. 8. 9.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 모집홍보 관리자 접근 권한 없음 페이지)
	 * @Method 설명 : 권한이 없는 사용자가 관리자 페이지 접근시 호출되는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_ACCESS_DENIED, method = RequestMethod.GET)
	public String admin_access_denied(){
		logger.debug("모집홍보 관리자 접근 권한 없음 컨트롤러 시작");
		logger.debug("모집홍보 관리자 접근 권한 없음 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_ACCESS_DENIED;
	}
	
	/**
	 * @Method Name : board_manager_form
	 * @Date : 2018. 9. 13.
	 * @User : 이종호 , 정대영
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 모집홍보 관리자 게시판 관리 폼 페이지)
	 * @Method 설명 : 관리자 게시판 관리 폼 페이지 이동 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_BOARD_MANAGER_FORM, method = RequestMethod.GET)
	public String board_manager_form(Model model,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int pageCount,
			@RequestParam(defaultValue="") String search_division,
			@RequestParam(defaultValue="") String search_type
			){
		logger.debug("모집홍보 관리자 게시판 관리 폼 이동 컨트롤러 시작");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("pageCount", pageCount);
		map.put("search_division", search_division);
		map.put("search_type", search_type);
		
		int count = seaService.board_search_all_count(map);
		
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count, curPage);
		map.put("count", count); // 레코드의 갯수
		map.put("adminPager", adminPager);
		
		ArrayList<BoardGroup> resultList = seaService.board_search_all(map);	
		model.addAttribute("map", map);
		model.addAttribute("resultList", resultList);
		model.addAttribute("curPage", curPage);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("search_division", search_division);
		model.addAttribute("search_type", search_type);
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_BOARD_MANAGER_FORM;
	}
	
	/**
	 * @Method Name : board_contents_search
	 * @Date : 2018. 9. 13
	 * @User : 이종호, 원병호
	 * @Param : 게시판 시퀀스
	 * @Return : JSP 리턴 페이지(SMART Cloud IT마스터 모집홍보 관리자 게시글 리스트 페이지)
	 * @Method 설명 : 특정 게시판 시퀀스에 해당하는 게시글 리스트 를 조회하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_BOARD_CONTENTS_SEARCH, method = RequestMethod.POST)
	public String board_contents_search(Model model, BoardGroup boardGroup,
			@RequestParam(defaultValue="") String search_division,
			@RequestParam(defaultValue="") String search_type,
			@RequestParam(defaultValue="0") int board_seq,
			@RequestParam(defaultValue="") String borad_nm,
			@RequestParam(defaultValue="1") int page,
			@RequestParam(defaultValue="10") int pageCount
			){
		logger.debug("모집홍보 관리자 게시글 리스트 조회 컨트롤러 시작");
		
		int curPage = page;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("pageCount", pageCount);
		map.put("board_seq", board_seq);

		int count = seaService.board_contents_count(map);
		
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
		logger.debug("adminPager {}", adminPager);
		
		map.put("count", count); // 레코드의 갯수
		map.put("adminPager", adminPager);
		
		ArrayList<BoardContent> resultList = seaService.board_contents_search(map);
		
		model.addAttribute("contentList", resultList);
		model.addAttribute("boardGroup", boardGroup);
		model.addAttribute("search_division",search_division);
		model.addAttribute("search_type",search_type);
		model.addAttribute("board_seq",board_seq);
		model.addAttribute("borad_nm",borad_nm);
		model.addAttribute("map", map);
		logger.debug("모집홍보 관리자 게시글 리스트 조회 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_ADMIN_BOARD_CONTENTS_SEARCH;
	}
	
	/**
	 * @Method Name : board_contents_detail
	 * @Date : 2017. 9. 13.
	 * @User : 이종호
	 * @Param : 게시판 세부내용 시퀀스, 게시판 구분, 게시판 타입
	 * @Return : JSP 리턴페이지(게시판 세부내용)
	 * @Method 설명 : 
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_BOARD_CONTENTS_DETAIL, method = RequestMethod.POST)
	public String board_contents_detail(int board_content_seq, Model model, BoardGroup boardGroup,
			@RequestParam(defaultValue="0") int board_seq,
			@RequestParam(defaultValue="") String search_division,
			@RequestParam(defaultValue="") String search_type
			){
		logger.debug("모집홍보 관리자 게시글 세부 내용 조회 컨트롤러 시작");
	
		//조회수 증가
		seaService.board_contents_hit_update(board_content_seq);
		//조회
		HashMap<String, Object> resultMap = seaService.board_contents_detail(board_content_seq);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("board_seq", board_seq);
		ArrayList<BoardContent> resultList = seaService.board_contents_search(map);

		String path = seaService.findPath(boardGroup.getBoard_gb(), boardGroup.getBoard_tp());
		model.addAttribute("contentDetail", resultMap);
		model.addAttribute("contentList", resultList);
		model.addAttribute("boardGroup", boardGroup);
		model.addAttribute("path", path);
		model.addAttribute("board_seq",board_seq);
		model.addAttribute("search_division",search_division);
		model.addAttribute("search_type",search_type);
		
		logger.debug("모집홍보 관리자 게시글 세부 내용 조회 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_BOARD_CONTENTS_DETAIL;
	}
	
	/**
	 * @Method Name : board_contents_insert_form
	 * @Date : 2017. 9. 28.
	 * @User : 이종호
	 * @Param : 게시판 시퀀스
	 * @Return : JSP 리턴 페이지(게시판 세부내용 등록 페이지)
	 * @Method 설명 : 게시판 세부 내용 등록 페이지로 폼 이동 하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_BOARD_CONTENTS_INSERT_FORM, method = RequestMethod.POST)
	public String board_contents_insert_form(BoardGroup boardGroup, Model model , Authentication auth,
			@RequestParam(defaultValue="") String search_division,
			@RequestParam(defaultValue="") String search_type
			){
		logger.debug("모집홍보 관리자 게시글 세부 내용 등록 폼 이동 컨트롤러 시작");
		BoardGroup boardGb = seaService.board_gb_search(boardGroup);
		String path = seaService.findPath(boardGb.getBoard_gb(), boardGb.getBoard_tp());
		String admin = "admin";
		model.addAttribute("path", path);
		model.addAttribute("boardGb", boardGb);
		model.addAttribute("board_content_nm", admin);
		model.addAttribute("search_division",search_division);
		model.addAttribute("search_type",search_type);
		logger.debug("모집홍보 관리자 게시글 세부 내용 등록 폼 이동 컨트롤러 종료");
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_BOARD_CONTENTS_INSERT_FORM;
	}
	
	/**
	 * @Method Name : board_contents_insert
	 * @Date : 2017. 9. 28.
	 * @User : 이종호
	 * @Param : 게시글 세부내용, 게시판 첨부파일 저장 경로
	 * @Return : JSP 리턴페이지(게시판 메니저 폼)
	 * @Method 설명 : 게시글 등록하고 메니저 폼으로 이동하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value= PathConstants.SOCIETY_EDU_ADMIN_BOARD_CONTENTS_INSERT, method = RequestMethod.POST)
	public String board_contents_insert(Model model, BoardGroup boardGroup, String boardFilePath, 
			BoardContent boardContent, BoardFile boardFile, Authentication auth,
			@RequestParam(defaultValue="0") int board_seq,
			@RequestParam(defaultValue="") String borad_nm,
			@RequestParam(defaultValue="") String search_division,
			@RequestParam(defaultValue="") String search_type){

		System.out.println("2 : " + boardGroup);
		String path = seaService.findPath(boardGroup.getBoard_gb(), boardGroup.getBoard_tp());
		seaService.board_contents_insert(boardContent);
		seaService.board_contents_file_insert(path, boardFile, boardContent.getBoard_content_seq(), auth.getName());
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("board_seq", board_seq);
		ArrayList<BoardContent> resultList = seaService.board_contents_search(map);
		
		model.addAttribute("contentList", resultList);
		model.addAttribute("boardGroup", boardGroup);
		model.addAttribute("board_seq",board_seq);
		model.addAttribute("borad_nm",borad_nm);
		model.addAttribute("search_division",search_division);
		model.addAttribute("search_type",search_type);
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_BOARD_CONTENTS_SEARCH;
	}
	
	/**
	 * @Method Name : board_contents_update_form
	 * @Date : 2017. 9. 22.
	 * @User : 이종호
	 * @Param : 게시판 세부내용 시퀀스, 게시판 구분, 게시판 타입
	 * @Return : JSP 리턴페이지(게시판 세부내용 수정 페이지)
	 * @Method 설명 : 게시판 세부 내용 수정 페이지로 폼 이동 하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_BOARD_CONTENTS_UPDATE_FORM, method = RequestMethod.POST
			, produces ="text/json;charset=UTF-8")
	public String board_contents_update_form(int board_content_seq, Model model, BoardGroup boardGroup,
			@RequestParam(defaultValue="") String search_division,
			@RequestParam(defaultValue="") String search_type
			){
		logger.debug("모집홍보 관리자 게시글 세부 내용 수정 폼 이동 컨트롤러 시작");
		
		HashMap<String, Object> resultMap = seaService.board_contents_detail(board_content_seq);

		String path = seaService.findPath(boardGroup.getBoard_gb(), boardGroup.getBoard_tp());
		
		model.addAttribute("contentDetail", resultMap);
		model.addAttribute("boardGroup", boardGroup);
		model.addAttribute("path", path);
		
		Gson gson = new Gson();
		model.addAttribute("fileList", gson.toJson(resultMap.get("fileList")));
		model.addAttribute("search_division",search_division);
		model.addAttribute("search_type",search_type);
		logger.debug("모집홍보 관리자 게시글 세부 내용 수정 폼 이동 컨트롤러 종료");
		System.out.println("resultMap.toString() : " + resultMap.toString());
		System.out.println("resultMap.get(\"fileList\").toString() : " + resultMap.get("fileList").toString());
		System.out.println("gson.toString() : " + gson.toString());
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_BOARD_CONTENTS_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : board_contents_update
	 * @Date : 2017. 9. 25.
	 * @User : 이종호
	 * @Param : 게시글 세부내용, 게시판 첨부파일 저장 경로
	 * @Return : JSP 리턴페이지(게시판 메니저 폼)
	 * @Method 설명 : 게시글 수정하고 메니저 폼으로 이동하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value= PathConstants.SOCIETY_EDU_ADMIN_BOARD_CONTENTS_UPDATE, method = RequestMethod.POST)
	public String board_contents_update(String boardFilePath, BoardContent boardContent, BoardFile boardFile
			,int board_content_seq, Model model, BoardGroup boardGroup, Authentication auth,
			@RequestParam(defaultValue="") String search_division,
			@RequestParam(defaultValue="") String search_type){
		logger.debug("모집홍보 관리자 게시글 세부 내용 수정 컨트롤러 시작");
		
		seaService.board_contents_update(boardContent);
		seaService.board_contents_file_delete(boardContent);
		seaService.board_contents_file_insert(boardFilePath, boardFile, boardContent.getBoard_content_seq(), auth.getName());
		
		//수정된 글 조회
		HashMap<String, Object> resultMap = seaService.board_contents_detail(board_content_seq);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("board_seq", boardGroup.getBoard_seq());
		ArrayList<BoardContent> resultList = seaService.board_contents_search(map);
		
		String path = seaService.findPath(boardGroup.getBoard_gb(), boardGroup.getBoard_tp());
		model.addAttribute("contentDetail", resultMap);
		model.addAttribute("contentList", resultList);
		model.addAttribute("boardGroup", boardGroup);
		model.addAttribute("path", path);
		model.addAttribute("search_division",search_division);
		model.addAttribute("search_type",search_type);
		
		logger.debug("모집홍보 관리자 게시글 세부 내용 수정 컨트롤러 종료");

		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_BOARD_CONTENTS_DETAIL;
	}
	
	/**
	 * @Method Name : board_contents_delete
	 * @Date : 2018. 8. 23.
	 * @User : 김지훈
	 * @Param : 게시판 시퀀스
	 * @Return : JSP 리턴 페이지(모집홍보 관리자 게시글 리스트 페이지)
	 * @Method 설명 : 게시글 삭제하고 메니저 폼으로 이동하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_BOARD_CONTENTS_DELETE, method = RequestMethod.POST)
	public String board_contents_delete(int board_content_seq, Model model, BoardGroup boardGroup, 
			String search_division, String search_type, Authentication auth) {
		logger.debug("모집홍보 관리자 게시글 삭제 컨트롤러 시작");

		seaService.board_contents_delete(board_content_seq);

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("board_seq", boardGroup.getBoard_seq());
		ArrayList<BoardContent> resultList = seaService.board_contents_search(map);
		
		model.addAttribute("contentList", resultList);
		model.addAttribute("boardGroup", boardGroup);
		model.addAttribute("search_division",search_division);
		model.addAttribute("search_type",search_type);
		logger.debug("모집홍보 관리자 게시글 삭제 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_BOARD_CONTENTS_SEARCH;
	}
	
	/**
	 * @Method Name : basic_user_select_all
	 * @Date : 2017. 9. 29.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(모집홍보 관리자 회원 정보 폼)
	 * @Method 설명 : 일반 회원(등급)의 모든 회원 정보를 조회하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_USER_MANAGER_FORM, method=RequestMethod.GET)
	public String basic_user_select_all(Model model,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int pageCount,
			@RequestParam(defaultValue="") String orderType,
			@RequestParam(defaultValue="") String orderValue,
			@RequestParam(defaultValue="") String searchName,
			@RequestParam(defaultValue="") String searchId){
		logger.debug("모집홍보 관리자 회원 정보 조회 컨트롤러 시작");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("orderType", orderType);
		map.put("orderValue", orderValue);
		map.put("pageCount", pageCount);
		map.put("searchName", searchName);
		map.put("searchId", searchId);
		
		int count = seaService.basic_user_select_all_count(map);

		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
		map.put("count", count); // 레코드의 갯수
		map.put("adminPager", adminPager);

	    ArrayList<User> resultList = seaService.basic_user_select_all(map);

	    model.addAttribute("map", map);
	    model.addAttribute("userList", resultList);
		model.addAttribute("curPage", curPage);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("orderType", orderType);
		model.addAttribute("orderValue", orderValue);
		model.addAttribute("searchName", searchName);
		model.addAttribute("searchId", searchId);
		logger.debug("모집홍보 관리자 회원 정보 조회 컨트롤러 종료");
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_USER_MANAGER_FORM;
	}
	
	/**
	 * @Method Name : user_info_update_form
	 * @Date : 2017. 10. 2.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : JSP 리턴 페이지(모집홍보 관리자 회원 수정 폼)
	 * @Method 설명 : 일반 회원(등급)의 회원 정보 수정 폼으로 이동하는 컨트롤러 함수 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_USER_INFO_UPDATE_FORM, method=RequestMethod.POST)
	public String user_info_update_form(User user, Model model,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int pageCount,
			@RequestParam(defaultValue="") String orderType,
			@RequestParam(defaultValue="") String orderValue,
			@RequestParam(defaultValue="") String searchName,
			@RequestParam(defaultValue="") String searchId){
		logger.debug("모집홍보 관리자 회원 정보 수정 폼 이동 컨트롤러 시작");
		System.out.println(user);
		User userinfo = seaService.user_info_select(user);
		System.out.println(userinfo);
		model.addAttribute("user", userinfo);
		model.addAttribute("curPage", curPage);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("orderType", orderType);
		model.addAttribute("orderValue", orderValue);
		model.addAttribute("searchName", searchName);
		model.addAttribute("searchId", searchId);
		logger.debug("모집홍보 관리자 회원 정보 수정 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_USER_INFO_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : user_info_update
	 * @Date : 2018. 2. 14
	 * @User : 윤상혁
	 * @Param : 회원 업데이트 파라미터
	 * @Return : JSP 리턴 페이지(모집홍보 관리자 회원 수정 폼)
	 * @Method 설명 : 일반 회원(등급)의 회원 정보 수정을 실행하는 컨트롤러 함수 
	 */
	@RequestMapping(value = "/edu/admin/user_info_update", method=RequestMethod.POST)
	public String user_info_update(Model model, User user,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int pageCount,
			@RequestParam(defaultValue="") String orderType,
			@RequestParam(defaultValue="") String orderValue,
			@RequestParam(defaultValue="") String searchName,
			@RequestParam(defaultValue="") String searchId){
		logger.debug("모집홍보 관리자 회원 정보 수정 폼 이동 컨트롤러 시작");
		
		System.out.println(user);
		System.out.println(user.getUser_sex());
		seaService.user_info_update(user);
		
		User userInfo = seaService.user_info_select(user);
		model.addAttribute("user", userInfo);
		model.addAttribute("curPage", curPage);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("orderType", orderType);
		model.addAttribute("orderValue", orderValue);
		model.addAttribute("searchName", searchName);
		model.addAttribute("searchId", searchId);
		logger.debug("모집홍보 관리자 회원 정보 수정 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_USER_INFO_UPDATE_FORM;
	}

	/**
	 * @Method Name : payment_manager_refund
	 * @Date : 2018. 2. 8.
	 * @User : 전상수
	 * @Param : 
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 환불 관리 페이지)
	 * @Method 설명 : 관리자 페이지에서 환불 관리 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_PAYMENT_USER_REFUND, method = RequestMethod.GET)
	public String payment_manager_refund(
			String gisu_seq, String gisu_order, String search_name, 
			@RequestParam(defaultValue="1")int pageIndex, 
			Model model){
		logger.debug("환불 요청자 정보 조회 컨트롤러 시작");
		
		/*HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("gisu_seq", gisu_seq);
		map.put("gisu_order", gisu_order);
		map.put("search_name", search_name);
		map.put("pageIndex", pageIndex);
		System.out.println(map);
		List<HashMap<String, Object>> seaRefundList = seaService.refund_manager_list(map);
		System.out.println(seaRefundList);
		model.addAttribute("seaRefundList", seaRefundList);*/
		model.addAttribute("seaCurList", seaService.searchCurriculumPermission());
		
		logger.debug("환불 요청자 정보 조회 컨트롤러 종료");
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_PAYMENT_USER_REFUND;
	}
	
	/**
	 * @Method Name : faq_manager_form
	 * @Date : 2018. 07. 20.
	 * @User : 김도훈
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 온라인 상담 관리 페이지)
	 * @Method 설명 : 관리자 페이지에서 FAQ 관리 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_FAQ_CONSULTING_MANAGER_FORM, method = RequestMethod.GET)
	public String faq_manager_form(Model model,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int pageCount,
			@RequestParam(defaultValue="") String orderType,
			@RequestParam(defaultValue="") String orderValue,
			@RequestParam(defaultValue="") String searchId,
			@RequestParam(defaultValue="") String searchTitle,
			@RequestParam(defaultValue="") String consultingTp
			){
		
		logger.debug("FAQ 처음화면 컨트롤러 시작");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("orderType", orderType);
		map.put("orderValue", orderValue);
		map.put("pageCount", pageCount);
		map.put("searchId", searchId);
		map.put("searchTitle", searchTitle);
		map.put("consulting_tp", consultingTp);
		
		int count = seaService.faq_manager_select_count(map);
		System.out.println(map);
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
		map.put("count", count); // 레코드의 갯수
		map.put("adminPager", adminPager);
		System.out.println(count);
	    System.out.println(pageCount);
	    ArrayList<FaqConsultingContents> resultList = seaService.faq_manager_select_all(map);
		System.out.println(resultList);
	    model.addAttribute("map",map);
	    model.addAttribute("resultList", resultList);
		model.addAttribute("curPage", curPage);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("orderType", orderType);
		model.addAttribute("orderValue", orderValue);
		model.addAttribute("searchId", searchId);
		model.addAttribute("searchTitle", searchTitle);
		model.addAttribute("consultingTp", consultingTp);
		
		logger.debug("FAQ 처음화면 컨트롤러 종료");
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_FAQ_CONSULTING_MANAGER_FORM;
	}
	
	/**
	 * @Method Name : faq_manager_detail_form
	 * @Date : 2018. 7. 25.
	 * @User : 김도훈
	 * @Param : 회원 아이디
	 * @Return : JSP 리턴 페이지(모집홍보 관리자 오프라인 상담 상세내용 폼)
	 * @Method 설명 : FAQ 리스트 페이지 컨트롤러 함수 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_FAQ_CONSULTING_DETAIL_FORM, method=RequestMethod.POST)
	public String faq_manager_detail_form(Model model,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int pageCount,
			@RequestParam(defaultValue="") String orderType,
			@RequestParam(defaultValue="") String orderValue,
			@RequestParam(defaultValue="") String searchId,
			@RequestParam(defaultValue="") String searchTitle,
			@RequestParam(defaultValue="") int consulting_seq){
		logger.debug("FAQ 상담 처음화면 컨트롤러 시작");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("orderType", orderType);
		map.put("orderValue", orderValue);
		map.put("pageCount", pageCount);
		map.put("searchId", searchId);
		map.put("searchTitle", searchTitle);
		
		int count = seaService.faq_manager_select_count(map);
		System.out.println(map);
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
		map.put("count", count); // 레코드의 갯수
		map.put("adminPager", adminPager);
		System.out.println(count);
	    System.out.println(pageCount);
	    ArrayList<OnlineConsultingContents> resultList = seaService.online_manager_select_all(map);
		System.out.println(resultList);
	    model.addAttribute("map",map);
	    model.addAttribute("resultList", resultList);
		model.addAttribute("curPage", curPage);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("orderType", orderType);
		model.addAttribute("orderValue", orderValue);
		model.addAttribute("searchId", searchId);
		model.addAttribute("searchTitle", searchTitle);
		
		logger.debug("FAQ 상담 처음화면 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_FAQ_CONSULTING_DETAIL_FORM;
	}
	
	/**
	 * @Method Name : faq_manager_detail
	 * @Date : 2017. 7. 25.
	 * @User : 김도훈
	 * @Param : FAQ 상담 게시판 세부내용 시퀀스, FAQ 타입
	 * @Return : JSP 리턴페이지(게시판 세부내용)
	 * @Method 설명 : 
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_FAQ_CONSULTING_CONTENTS_DETAIL, method = RequestMethod.POST)
	public String faq_manager_detail(int consulting_seq, Model model, FaqConsultingContents faqconsultingcontents,
			@RequestParam(defaultValue="") String search_type
			){
		logger.debug("FAQ 상담 관리자 게시글 세부 내용 조회 컨트롤러 시작");
	
		//조회
		HashMap<String, Object> resultMap = seaService.faq_manager_detail(consulting_seq);
		
		model.addAttribute("contentDetail", resultMap);
		model.addAttribute("FaqConsultingContents", faqconsultingcontents);
		model.addAttribute("search_type",search_type);
		
		logger.debug("FAQ 상담 관리자 게시글 세부 내용 조회 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_FAQ_CONSULTING_CONTENTS_DETAIL;
	}	
	
	/**
	 * @Method Name : faq_manager_insert_form
	 * @Date : 2018. 7. 25.
	 * @User : 김도훈
	 * @Param : 게시판 시퀀스
	 * @Return : JSP 리턴 페이지(게시판 세부내용 등록 페이지)
	 * @Method 설명 : FAQ 상담 게시판 세부 내용 등록 페이지로 폼 이동 하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_FAQ_CONSULTING_CONTENTS_INSERT_FORM, method = RequestMethod.POST)
	public String faq_manager_insert_form(Model model, Authentication auth,
			@RequestParam(defaultValue="") String search_type
			){
		logger.debug("FAQ 상담 관리자 게시글 세부 내용 등록 폼 이동 컨트롤러 시작");
		
		model.addAttribute("consulting_ins_id", auth.getName());
		model.addAttribute("search_type",search_type);
		logger.debug("FAQ 상담 관리자 게시글 세부 내용 등록 폼 이동 컨트롤러 종료");
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_FAQ_CONSULTING_CONTENTS_INSERT_FORM;
	}
	
	/**
	 * @Method Name : faq_manager_contents_insert
	 * @Date : 2018. 7. 25.
	 * @User : 김도훈
	 * @Param : FAQ 상담 게시글 세부내용 저장
	 * @Return : JSP 리턴페이지(게시판 메니저 폼)
	 * @Method 설명 : FAQ 상담 게시글 등록하고 메니저 폼으로 이동하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value= PathConstants.SOCIETY_EDU_ADMIN_FAQ_CONSULTING_CONTENTS_INSERT, method = RequestMethod.POST)
	public String faq_manager_contents_insert(FaqConsultingContents consultingContent){
		seaService.faq_manager_contents_insert(consultingContent);
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_FAQ_CONSULTING_MANAGER_FORM;
	}

	/**
	 * @throws Exception 
	 * @Method Name : faq_manager_update_form
	 * @Date : 2018. 7. 19.
	 * @User : 김도훈
	 * @Param : 회원 아이디
	 * @Return : JSP 리턴 페이지(FAQ 관리자용 상세내용 폼)
	 * @Method 설명 : FAQ 상담 게시판 수정내용을 DB에 저장하는 컨트롤러 함수 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_FAQ_CONSULTING_CONTENTS_UPDATE_FORM, method = RequestMethod.POST)
	public String faq_manager_update_form(int consulting_seq, Model model, Authentication auth,
			@RequestParam(defaultValue="") String search_type
			){
		logger.debug("FAQ 상담  관리자 게시글 세부 내용 수정 폼 이동 컨트롤러 시작");
		
		HashMap<String, Object> resultMap = seaService.faq_manager_detail(consulting_seq);
		
		model.addAttribute("consulting_ins_id", auth.getName());
		model.addAttribute("contentDetail", resultMap);
		model.addAttribute("search_type", search_type);
		logger.debug("FAQ 상담  관리자 게시글 세부 내용 수정 폼 이동 컨트롤러 종료");
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_FAQ_CONSULTING_CONTENTS_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : faq_manager_contents_update
	 * @Date : 2018. 7. 25.
	 * @User : 김도훈
	 * @Param : FAQ 상담 게시판 세부내용 시퀀스, FAQ 카테고리
	 * @Return : JSP 리턴페이지(게시판 세부내용 수정 페이지)
	 * @Method 설명 : FAQ 상담 게시판 세부 내용 수정 페이지로 폼 이동 하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value= PathConstants.SOCIETY_EDU_ADMIN_FAQ_CONSULTING_CONTENTS_UPDATE, method = RequestMethod.POST)
	public String faq_manager_contents_update(FaqConsultingContents consultingContent){
		logger.debug("모집홍보 관리자 게시글 세부 내용 수정 컨트롤러 시작");
		seaService.faq_manager_contents_update(consultingContent);
		logger.debug("모집홍보 관리자 게시글 세부 내용 수정 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_FAQ_CONSULTING_MANAGER_FORM;
	}

	/**
	 * @Method Name : online_manager_form
	 * @Date : 2018. 07. 27.
	 * @User : 김도훈
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 온라인 상담 관리 페이지)
	 * @Method 설명 : 관리자 페이지에서 온라인 상담 관리 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_MANAGER_FORM, method = RequestMethod.GET)
	public String online_manager_form(Model model,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int pageCount,
			@RequestParam(defaultValue="") String orderType,
			@RequestParam(defaultValue="") String orderValue,
			@RequestParam(defaultValue="") String searchId,
			@RequestParam(defaultValue="") String searchTitle){
		
		logger.debug("온라인 상담 처음화면 컨트롤러 시작");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("orderType", orderType);
		map.put("orderValue", orderValue);
		map.put("pageCount", pageCount);
		map.put("searchId", searchId);
		map.put("searchTitle", searchTitle);
		
		int count = seaService.online_manager_select_count(map);
		System.out.println(map);
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
		map.put("count", count); // 레코드의 갯수
		map.put("adminPager", adminPager);
		System.out.println(count);
	    System.out.println(pageCount);
	    ArrayList<OnlineConsultingContents> resultList = seaService.online_manager_select_all(map);
		System.out.println(resultList);
	    model.addAttribute("map",map);
	    model.addAttribute("resultList", resultList);
		model.addAttribute("curPage", curPage);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("orderType", orderType);
		model.addAttribute("orderValue", orderValue);
		model.addAttribute("searchId", searchId);
		model.addAttribute("searchTitle", searchTitle);
		
		logger.debug("온라인 상담 처음화면 컨트롤러 종료");
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_MANAGER_FORM;
	}

	/**
	 * @Method Name : online_manager_detail_form
	 * @Date : 2018. 7. 27.
	 * @User : 김도훈
	 * @Param : 회원 아이디
	 * @Return : JSP 리턴 페이지(모집홍보 관리자 오프라인 상담 상세내용 폼)
	 * @Method 설명 : 온라인상담 및 FAQ 상세내용 폼으로 이동하는 컨트롤러 함수 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_CONTENTS_DETAIL_FORM, method=RequestMethod.POST)
	public String online_manager_detail_form(Model model,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int pageCount,
			@RequestParam(defaultValue="") String orderType,
			@RequestParam(defaultValue="") String orderValue,
			@RequestParam(defaultValue="") String searchId,
			@RequestParam(defaultValue="") String searchTitle,
			@RequestParam(defaultValue="0") int consulting_seq,
			Authentication auth){
		logger.debug("모집홍보 관리자 온라인 상담 상세내용 폼 이동 컨트롤러 시작");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("orderType", orderType);
		map.put("orderValue", orderValue);
		map.put("pageCount", pageCount);
		map.put("searchId", searchId);
		map.put("searchTitle", searchTitle);
		map.put("consulting_seq", consulting_seq);
				
		System.out.println(map);
	    OnlineConsultingContents result = seaService.online_manager_select(consulting_seq);

	    System.out.println(result);
		model.addAttribute("result", result);
		model.addAttribute("curPage", curPage);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("orderType", orderType);
		model.addAttribute("orderValue", orderValue);
		model.addAttribute("searchId", searchId);
		model.addAttribute("searchId", searchTitle);
		model.addAttribute("loginedId",auth.getName());
		logger.debug("모집홍보 관리자 온라인 상담 상세내용 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_CONTENTS_DETAIL_FORM;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : online_manager_contents_update
	 * @Date : 2018. 8. 2.
	 * @User : 김도훈
	 * @Param : 회원 아이디
	 * @Return : JSP 리턴 페이지(FAQ 관리자용 상세내용 폼)
	 * @Method 설명 : 온라인 상담 게시판 내용을 수정하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value= PathConstants.SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_CONTENTS_UPDATE, method = RequestMethod.POST)
	public String online_manager_contents_update(OnlineConsultingContents consultingContent){
		seaService.online_manager_contents_update(consultingContent);
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_MANAGER_FORM;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : online_manager_reply_insert
	 * @Date : 2018. 7. 27.
	 * @User : 김도훈
	 * @Param : 회원 아이디
	 * @Return : JSP 리턴 페이지(FAQ 관리자용 상세내용 폼)
	 * @Method 설명 : 온라인 상담 게시판 답변 내용을 DB에 저장하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value= PathConstants.SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_REPLY_INSERT, method = RequestMethod.POST)
	public String online_manager_reply_insert(OnlineConsultingContents consultingContent){
		seaService.online_manager_reply_insert(consultingContent);
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_MANAGER_FORM;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : online_manager_reply_update
	 * @Date : 2018. 7. 27.
	 * @User : 김도훈
	 * @Param : 회원 아이디
	 * @Return : JSP 리턴 페이지(FAQ 관리자용 상세내용 폼)
	 * @Method 설명 : 온라인 상담 게시판 답변 내용을 DB에 저장하는 컨트롤러 함수 
	 */
	@Transactional
	@RequestMapping(value= PathConstants.SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_REPLY_UPDATE, method = RequestMethod.POST)
	public String online_manager_reply_update(OnlineConsultingContents consultingContent){
		seaService.online_manager_reply_update(consultingContent);
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_ONLINE_CONSULTING_MANAGER_FORM;
	}
	
	/**
	 * @Method Name : offline_manager_form
	 * @Date : 2018. 07. 13.
	 * @User : 김지훈
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 오프라인 상담 관리 페이지)
	 * @Method 설명 : 관리자 페이지에서 오프라인 상담 관리 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_OFFLINE_CONSULTING_MANAGER_FORM, method = RequestMethod.GET)
	public String offline_manager_form(Model model,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int pageCount,
			@RequestParam(defaultValue="") String orderType,
			@RequestParam(defaultValue="") String orderValue,
			@RequestParam(defaultValue="") String searchName,
			@RequestParam(defaultValue="") String searchTitle){
		
		logger.debug("오프라인 상담 처음화면 컨트롤러 시작");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("orderType", orderType);
		map.put("orderValue", orderValue);
		map.put("pageCount", pageCount);
		map.put("searchName", searchName);
		map.put("searchTitle", searchTitle);
		
		int count = seaService.offline_manager_select_count(map);
		System.out.println(map);
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
		map.put("count", count); // 레코드의 갯수
		map.put("adminPager", adminPager);
		System.out.println(count);
	    System.out.println(pageCount);
	    ArrayList<OfflineConsultingContents> resultList = seaService.offline_manager_select_all(map);
		System.out.println(resultList);
	    model.addAttribute("map",map);
	    model.addAttribute("resultList", resultList);
		model.addAttribute("curPage", curPage);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("orderType", orderType);
		model.addAttribute("orderValue", orderValue);
		model.addAttribute("searchName", searchName);
		model.addAttribute("searchTitle", searchTitle);
		
		logger.debug("오프라인 상담 처음화면 컨트롤러 종료");
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_OFFLINE_CONSULTING_MANAGER_FORM;
	}
	
	/**
	 * @Method Name : offline_manager_detail_form
	 * @Date : 2018. 7. 17.
	 * @User : 김지훈
	 * @Param : 회원 아이디
	 * @Return : JSP 리턴 페이지(모집홍보 관리자 오프라인 상담 상세내용 폼)
	 * @Method 설명 : 오프라인 상담 상세내용 폼으로 이동하는 컨트롤러 함수 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_OFFLINE_CONSULTING_DETAIL_FORM, method=RequestMethod.POST)
	public String offline_manager_detail_form(Model model,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int pageCount,
			@RequestParam(defaultValue="") String orderType,
			@RequestParam(defaultValue="") String orderValue,
			@RequestParam(defaultValue="") String searchName,
			@RequestParam(defaultValue="") String searchTitle,
			@RequestParam(defaultValue="") String seq){
		logger.debug("모집홍보 관리자 오프라인 상담 상세내용 폼 이동 컨트롤러 시작");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("orderType", orderType);
		map.put("orderValue", orderValue);
		map.put("pageCount", pageCount);
		map.put("searchName", searchName);
		map.put("searchTitle", searchTitle);
		map.put("searchTitle", seq);
		
		System.out.println(map);
	    OfflineConsultingContents result = seaService.offline_manager_select(seq);

	    System.out.println(result);
		model.addAttribute("result", result);
		model.addAttribute("curPage", curPage);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("orderType", orderType);
		model.addAttribute("orderValue", orderValue);
		model.addAttribute("searchName", searchName);
		model.addAttribute("searchId", searchTitle);
		logger.debug("모집홍보 관리자 오프라인 상담 상세내용 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_OFFLINE_CONSULTING_DETAIL_FORM;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : offline_manager_mail_send
	 * @Date : 2018. 7. 17.
	 * @User : 김지훈
	 * @Param : 회원 아이디
	 * @Return : JSP 리턴 페이지(모집홍보 관리자 오프라인 상담 상세내용 폼)
	 * @Method 설명 : 오프라인 상담 상세내용에 대한 메일답신 및 DB에 저장하는 컨트롤러 함수 
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_OFFLINE_CONSULTING_MAIL_SEND, method=RequestMethod.POST)
	public boolean offline_manager_mail_send(Model model,
			OfflineConsultingContents occ, Authentication auth,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int pageCount,
			@RequestParam(defaultValue="") String orderType,
			@RequestParam(defaultValue="") String orderValue,
			@RequestParam(defaultValue="") String searchName,
			@RequestParam(defaultValue="") String searchTitle,
			@RequestParam(defaultValue="") String send_mail_address) throws Exception{
		logger.debug("오프라인 상담 상세내용에 대한 메일답신 및 DB에 저장 컨트롤러 시작");
		boolean isRequested = false;
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("orderType", orderType);
		map.put("orderValue", orderValue);
		map.put("pageCount", pageCount);
		map.put("searchName", searchName);
		map.put("searchTitle", searchTitle);
		map.put("send_mail_address", send_mail_address);

//		System.out.println("auth : "+auth);
//		System.out.println("auth getDetails : "+auth.getDetails());
//		System.out.println("auth getPrincipal : "+auth.getPrincipal());
		occ.setUser_udt_id((String)auth.getPrincipal());
		System.out.println("occ : "+occ);
		System.out.println(map);
		System.out.println((String)map.get("send_mail_address"));
		
		if (seaService.offline_manager_mail_send(occ, (String)map.get("send_mail_address"))) {
			model.addAttribute("curPage", curPage);
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("orderType", orderType);
			model.addAttribute("orderValue", orderValue);
			model.addAttribute("searchName", searchName);
			model.addAttribute("searchId", searchTitle);
			
			isRequested = true;
		}
		logger.debug("오프라인 상담 상세내용에 대한 메일답신 및 DB에 저장 컨트롤러 종료");
		return isRequested;
	}
	
	/**
	 * @Method Name : admin_security_invalidate
	 * @Date : 2018. 9. 12
	 * @User : 이종호
	 * @Param : 세션정보
	 * @Return : 관리자 로그인 페이지
	 * @Method 설명 : 현재 세션정보를 초기화 하고 관리자 로그인 페이지로 이동 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SECURITY_INVALIDATE , method = RequestMethod.GET)
	public String admin_security_invalidate(HttpSession session) {
		logger.debug("관리자 시큐리티 초기화 컨트롤러 시작");
		
		// 세션 초기화
		SecurityContextHolder.clearContext();
		session.invalidate();
		
		logger.debug("관리자 시큐리티 초기화 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_LOGIN_FORM;
	}
	
	/**
	 * @Method Name : admin_join_form
	 * @Date : 2018. 9. 14
	 * @User : 이종호
	 * @Param : -
	 * @Return : 관리자 회원가입 페이지
	 * @Method 설명 : 관리자 회원 가입 페이지로 이동 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_JOIN_FORM , method = RequestMethod.GET)
	public String admin_join_form() {
		logger.debug("관리자 회원가입 페이지 이동 컨트롤러 시작");
		logger.debug("관리자 회원가입 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_ADMIN_JOIN_FORM;
	}
	
	/**
	 * @Method Name : admin_join
	 * @Date : 2018. 9. 14
	 * @User : 이종호
	 * @Param : -
	 * @Return : 관리자 회원가입 페이지
	 * @Method 설명 : 관리자 회원 가입 페이지로 이동 
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_JOIN , method = RequestMethod.POST)
	public String admin_join(User user, Admin admin) {
		logger.debug("관리자 회원가입 페이지 이동 컨트롤러 시작");
		
		//회원 테이블에 관리자 회원 등록
		//USER_FLAG(회원 종류)를 A0105(관리자)로 등록
		user.setUser_flag("A0105");
		//USER_STATe(회원 상태)를 A0204(승인 대기)로 등록
		user.setUser_state("A0204");
		//약관동의를 동의로 등록
		user.setUser_terms_ck("A1301");
		//회원 테이블 등록
		seuService.user_insert(user);
		
		//관리자 테이블에 관리자 등록
		//유저 객체에서 아이디, 비밀번호, 이름을 꺼내서 관리자 객체에 셋팅
		admin.setAdmin_id(user.getUser_id());
		admin.setAdmin_pw(user.getUser_pw());
		admin.setAdmin_nm(user.getUser_nm());
		//관리자 테이블 등록
		seaService.admin_insert(admin);
		
		logger.debug("관리자 회원가입 페이지 이동 컨트롤러 종료");
		return  "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_LOGIN_FORM;
	}

	/**
	 * @Method Name : admin_info_setting_form
	 * @Date : 2018. 9. 17
	 * @User : 이종호
	 * @Param : -
	 * @Return : 관리자 회원 정보 셋팅 폼 주소
	 * @Method 설명 : 관리자 회원 정보 셋팅 폼 이동 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_INFO_SETTING_FORM, method = RequestMethod.GET)
	public String admin_info_setting_form(Model model,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int pageCount,
			@RequestParam(defaultValue="") String searchName) {
		logger.debug("관리자 회원 정보 셋팅 폼 이동 컨트롤러 시작");
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("searchName", searchName);
		
		int count = seaService.admin_info_list_select_count(map);
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
		
		map.put("count", count); // 레코드의 갯수
	    map.put("adminPager", adminPager);
	    map.put("pageCount", pageCount);
		
	    model.addAttribute("map", map);

	    ArrayList<Admin> result = seaService.admin_info_list_select(map);
	    Gson gson = new Gson();
		model.addAttribute("admin_info_list_json", gson.toJson(result));
		
		logger.debug("관리자 회원 정보 셋팅 폼 이동 컨트롤러 종료");
		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_ADMIN_INFO_SETTING_FORM;
	}
	
	/**
	 * @Method Name : user_info_delete
	 * @Date : 2018. 9. 20
	 * @User : 이종호
	 * @Param : -
	 * @Return : 회원 관리 페이지
	 * @Method 설명 : 회원관리 페이지에서 회원탈퇴 기능 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_USER_INFO_DELETE , method = RequestMethod.POST)
	public String user_info_delete(User user,HttpSession session) {
		logger.debug("회원 탈퇴 컨트롤러 시작");

		// 회원탈퇴조치 서비스
		seuService.user_delete(user);

		logger.debug("회원 탈퇴 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_USER_MANAGER_FORM;
	}
	
	
	/**
	 * @Method Name : subbanner_manager_form
	 * @Date : 2018. 9. 20
	 * @User : 정대영
	 * @Param : -
	 * @Return : 서브 배너 관리 폼 
	 * @Method 설명 : 서브 배너 목록 확인
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SUBBANNER_MANAGER_FORM , method = RequestMethod.GET)
	public String SUBBANNER_MANAGER_FORM(Model model) {
		logger.debug("서브 배너 관리 페이지 이동 컨트롤러 시작");
		
		ArrayList<SocietyEduAdminSubBanner> subbanner_shown_list = seaService.subbanner_shown_list();
		for(SocietyEduAdminSubBanner lists : subbanner_shown_list){
			lists.setImg_full_path(seaService.subbanner_img_loading(lists.getEdu_sub_ban_saved()));
		}
		model.addAttribute("subbanner_shown_list", subbanner_shown_list);
		
		ArrayList<SocietyEduAdminSubBanner> subbanner_unshown_list = seaService.subbanner_unshown_list();
		for(SocietyEduAdminSubBanner lists : subbanner_unshown_list){
			lists.setImg_full_path(seaService.subbanner_img_loading(lists.getEdu_sub_ban_saved()));
		}
		model.addAttribute("subbanner_unshown_list", subbanner_unshown_list);
		
		logger.debug("서브 배너 관리 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_SUBBANNER_MANAGER_FORM;
	}
	
	/**
	 * @Method Name : subbanner_insert_form
	 * @Date : 2018. 9. 21
	 * @User : 정대영
	 * @Param : -
	 * @Return : 서브 배너 등록 폼 
	 * @Method 설명 : 서브 배너 등록 폼으로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SUBBANNER_INSERT_FORM , method = RequestMethod.GET)
	public String SUBBANNER_INSERT_FORM(Model model) {
		logger.debug("서브 배너 등록 페이지 이동 컨트롤러 시작");
		
		//링크 검색
		ArrayList<String> resultList = seaService.subbanner_select_gisu_crc_nm();
		model.addAttribute("gisu_crc_nm_list", resultList);
		
		logger.debug("서브 배너 등록 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_SUBBANNER_INSERT_FORM;
	}
	
	/**
	 * @Method Name : subbanner_delete
	 * @Date : 2018. 10. 1
	 * @User : 정대영
	 * @Param : 서브배너 시퀀스, 저장된 파일명
	 * @Return : -
	 * @Method 설명 : 서브 배너 삭제
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SUBBANNER_DELETE , method = RequestMethod.GET)
	public String subbanner_delete(int edu_sub_ban_seq, String edu_sub_ban_saved) {
		logger.debug("서브 배너 삭제 컨트롤러 시작");

		seaService.subbanner_delete(edu_sub_ban_seq, edu_sub_ban_saved);
		
		logger.debug("서브 배너 삭제 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_SUBBANNER_MANAGER_FORM;
	}

	
	/**
	 * @Method Name : subbanner_insert
	 * @Date : 2018. 9. 20
	 * @User : 정대영
	 * @Param : -
	 * @Return : 서브 배너 관리폼
	 * @Method 설명 : 서브 배너 저장
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SUBBANNER_INSERT , method = RequestMethod.POST)
	public String SUBBANNER_INSERT(SocietyEduAdminSubBanner seaSb, Authentication auth) {
		logger.debug("서브 배너 저장 컨트롤러 시작");
		
		seaSb.setEdu_sub_ban_ins_id((String)auth.getPrincipal());
		seaSb.setEdu_sub_ban_udt_id((String)auth.getPrincipal());
		
		seaService.subbanner_insert(seaSb);
		
		logger.debug("서브 배너 저장 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_SUBBANNER_MANAGER_FORM;
	}
	
	/**
	 * @Method Name : subbanner_update_form
	 * @Date : 2018. 9. 27
	 * @User : 정대영
	 * @Param : -
	 * @Return : 서브 배너 수정폼
	 * @Method 설명 : 서브 배너 수정폼으로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SUBBANNER_UPDATE_FORM , method = RequestMethod.GET)
	public String SUBBANNER_UPDATE_FORM(SocietyEduAdminSubBanner seaSb, Authentication auth, Model model) {
		logger.debug("서브 배너 수정 폼 컨트롤러 시작");
		
		SocietyEduAdminSubBanner result = seaService.subbanner_update_select(seaSb);
		result.setImg_full_path(seaService.subbanner_img_loading(result.getEdu_sub_ban_saved()));
		model.addAttribute("result", result);
		
		ArrayList<String> resultList = seaService.subbanner_select_gisu_crc_nm();
		model.addAttribute("gisu_crc_nm_list", resultList);
		
		logger.debug("서브 배너 수정 폼 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_SUBBANNER_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : subbanner_update
	 * @Date : 2018. 9. 28
	 * @User : 정대영
	 * @Param : -
	 * @Return : 서브 배너 수정
	 * @Method 설명 : 서브 배너 수정
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SUBBANNER_UPDATE , method = RequestMethod.POST)
	public String SUBBANNER_UPDATE(SocietyEduAdminSubBanner seaSb, Authentication auth) {
		logger.debug("서브 배너 수정 컨트롤러 시작");
		
		seaSb.setEdu_sub_ban_udt_id((String)auth.getPrincipal());
		seaService.subbanner_update(seaSb);
			
		logger.debug("서브 배너 수정 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_SUBBANNER_MANAGER_FORM;
	}
	
	
	/**
	 * @Method Name : curriculum_gisu_insert
	 * @Date : 2018. 9. 20.
	 * @User : 신동철
	 * @Param : 기수 정보 객체
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 관리자 기수 관리 폼 페이지)
	 * @Method 설명 : 관리자 페이지에서 기수 정보를 등록하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_GISU_INSERT, method = RequestMethod.POST)
	public String curriculum_gisu_insert(SocietyEduAdminCurriculumGisuImg seaCurGisuImg, Authentication auth, SocietyEduAdminCurriculumGisu seaCurGisu
			){
		logger.debug("기수 정보 등록 컨트롤러 시작");
		// 로그인한 관리자 아이디 설정
		seaCurGisu.setGisu_ins_id((String)auth.getPrincipal());
		seaCurGisu.setGisu_udt_id((String)auth.getPrincipal());
		
		//기수 정보 등록
		seaService.curriculum_gisu_insert(seaCurGisu);
		
		//기수 이미지 등록
		if(seaCurGisuImg.getGisu_crc_img_list() != null){
			seaCurGisuImg.setGisu_seq(seaCurGisu.getGisu_seq());
			seaCurGisuImg.setGisu_crc_img_saved_file_ins_id((String)auth.getPrincipal());
			seaCurGisuImg.setGisu_crc_img_udt_id((String)auth.getPrincipal());		
			seaService.curriculum_gisu_img_insert(seaCurGisuImg);
		}
		
		logger.debug("기수 정보 등록 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_GISU_MANAGER_FORM;
	}
	
	/**
	 * @Method Name : banner_manager_form
	 * @Date : 2018. 9. 27.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 메인 배너 관리 폼 
	 * @Method 설명 : 메인 배너 목록 확인
	 */
	@RequestMapping(value = SOCIETY_EDU_ADMIN_BANNER_MANAGER_FORM, method = RequestMethod.GET)
	public String BANNER_MANAGER_FORM(Model model) {
		logger.debug("메인 배너 관리 페이지 이동 컨트롤러 시작");
		ArrayList<SocietyEduAdminBanner> banner_shown_list = seaService.banner_shown_list();
		
		for(SocietyEduAdminBanner lists : banner_shown_list){
			lists.setImg_full_path(seaService.banner_img_loading(lists.getEdu_ban_saved()));
		}
		model.addAttribute("banner_shown_list", banner_shown_list);
		
		ArrayList<SocietyEduAdminBanner> banner_unshown_list = seaService.banner_unshown_list();
		for(SocietyEduAdminBanner lists : banner_unshown_list){
			lists.setImg_full_path(seaService.banner_img_loading(lists.getEdu_ban_saved()));
		}
		model.addAttribute("banner_unshown_list", banner_unshown_list);
		
		ArrayList<SocietyEduAdminCurriculumGisu> select_gisu_crc_nm = seaService.select_gisu_crc_nm();
		
		
		model.addAttribute("select_gisu_crc_nm", select_gisu_crc_nm);
		
		logger.debug("메인 배너 관리 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_BANNER_MANAGER_FORM;
	}
	
	/**
	 * @Method Name : banner_insert_form
	 * @Date : 2018. 9. 27.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 메인 배너 등록 폼 
	 * @Method 설명 : 메인 배너 등록 폼으로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_BANNER_INSERT_FORM , method = RequestMethod.GET)
	public String BANNER_INSERT_FORM(Model model) {
		logger.debug("메인 배너 등록 페이지 이동 컨트롤러 시작");
		
		ArrayList<String> curriculum_nm_list = seaService.curriculum_nm_list();
		model.addAttribute("curriculum_nm_list", curriculum_nm_list);
		
		logger.debug("메인 배너 등록 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_BANNER_INSERT_FORM;
	}
	
	/**
	 * @Method Name : banner_insert
	 * @Date : 2018. 9. 27.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 메인 배너 관리폼
	 * @Method 설명 : 메인 배너 저장
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_BANNER_INSERT , method = RequestMethod.POST)
	public String SUBBANNER_INSERT(SocietyEduAdminBanner seaB, Authentication auth) {
		logger.debug("메인 배너 저장 컨트롤러 시작");
		
		seaB.setEdu_ban_ins_id((String)auth.getPrincipal());
		seaB.setEdu_ban_udt_id((String)auth.getPrincipal());
		
		seaService.banner_insert(seaB);
		
		logger.debug("메인 배너 저장 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_BANNER_MANAGER_FORM;
	}
	
	/**
	 * @Method Name : banner_update_form
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 배너 수정폼
	 * @Method 설명 : 배너 수정폼으로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_BANNER_UPDATE_FORM , method = RequestMethod.GET)
	public String BANNER_UPDATE_FORM(SocietyEduAdminBanner seaB, Authentication auth, Model model) {
		logger.debug("배너 수정 폼 컨트롤러 시작");
		
		SocietyEduAdminBanner result = seaService.banner_update_select(seaB);
		result.setImg_full_path(seaService.banner_img_loading(result.getEdu_ban_saved()));
		model.addAttribute("result", result);
		
		ArrayList<String> resultList = seaService.curriculum_nm_list();
		model.addAttribute("curriculum_nm_list", resultList);
		
		logger.debug("배너 수정 폼 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_ADMIN_BANNER_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : banner_update
	 * @Date : 2018. 10. 1
	 * @User : 이재준
	 * @Param : -
	 * @Return : 배너 수정
	 * @Method 설명 : 배너 수정
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_BANNER_UPDATE , method = RequestMethod.POST)
	public String BANNER_UPDATE(SocietyEduAdminBanner seaB, Authentication auth, Model model) {
		logger.debug("배너 수정 컨트롤러 시작");
		
		seaB.setEdu_ban_udt_id((String)auth.getPrincipal());
		seaService.banner_update(seaB);

		logger.debug("배너 수정 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_BANNER_MANAGER_FORM;
	}
	
	/**
	 * @Method Name : banner_delete
	 * @Date : 2018. 10. 2
	 * @User : 정대영
	 * @Param : 메인 배너 시퀀스, 저장된 파일명
	 * @Return : -
	 * @Method 설명 : 배너 삭제
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_BANNER_DELETE , method = RequestMethod.GET)
	public String banner_delete(int edu_ban_seq, String edu_ban_saved) {
		logger.debug("메인 서브 배너 삭제 컨트롤러 시작");

		seaService.banner_delete(edu_ban_seq, edu_ban_saved);
		
		logger.debug("메인 서브 배너 삭제 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_BANNER_MANAGER_FORM;
	}
	
	/**
	 * @Method Name : curriculum_gisu_img_delete
	 * @Date : 2018. 10. 2
	 * @User : 신동철
	 * @Param : 기수이미지 객체
	 * @Return : -
	 * @Method 설명 : 기수과정 설명 이미지 삭제
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_GISU_IMG_DELETE , method = RequestMethod.GET)
	public String curriculum_gisu_img_delete(SocietyEduAdminCurriculumGisuImg seaCurGisuImg, Model model) {
		logger.debug("기수 과정 이미지 삭제 컨트롤러 시작");
		
		seaService.curriculum_gisu_img_delete(seaCurGisuImg);
				
		model.addAttribute("gisu_seq", seaCurGisuImg.getGisu_seq());
		
		logger.debug("기수 과정 이미지 삭제 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_GISU_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : curriculum_gisu_delete
	 * @Date : 2018. 10. 3
	 * @User : 신동철
	 * @Param : 기수 시퀀스
	 * @Return : -
	 * @Method 설명 : 관리자 페이지에서 기수 정보를 삭제하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_GISU_DELETE, method = RequestMethod.GET)
	public String curriculum_gisu_delete(int gisu_seq){
		logger.debug("기수 정보 삭제 컨트롤러 시작");
		logger.info("{}",gisu_seq);
		//기수 정보 삭제
		seaService.curriculum_gisu_delete(gisu_seq);
		
		logger.debug("기수 정보 삭제 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_GISU_MANAGER_FORM;
	}
	
}