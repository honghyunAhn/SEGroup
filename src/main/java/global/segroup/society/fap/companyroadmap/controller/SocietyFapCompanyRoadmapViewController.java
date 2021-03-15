/**
 * 
 */
package global.segroup.society.fap.companyroadmap.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.security.auth.login.AccountExpiredException;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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

import global.segroup.domain.User;
import global.segroup.service.SEGroupCommonService;
import global.segroup.society.fap.company.domain.SocietyFapCompanyUser;
import global.segroup.society.fap.company.service.SocietyFapCompanyService;
import global.segroup.society.fap.companyroadmap.domain.SocietyFapCompanyRoadmapJobfair;
import global.segroup.society.fap.companyroadmap.domain.SocietyFapCompanyRoadmapJobfairDivide;
import global.segroup.society.fap.companyroadmap.service.SocietyFapCompanyRoadmapService;
import global.segroup.society.fap.user.service.SocietyFapUserService;
import global.segroup.util.PathConstants;

/**
 * @Author : 원병호
 * @Date : 2018. 12. 12.
 * @Class 설명 : Soft Engineer Society 통합잡페어 채용기업 로드맵 View 컨트롤러
 * 
 */

@Controller
public class SocietyFapCompanyRoadmapViewController implements PathConstants {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyFapCompanyRoadmapViewController.class);
	
	@Autowired
	private SocietyFapCompanyService sfcService;
		
	@Autowired
	private SocietyFapUserService sfuService;
	
	@Autowired
	private SEGroupCommonService sgcService;
	
	@Autowired
	private SocietyFapCompanyRoadmapService sfcrService;
	
	/**
	 * @Method Name : company_insert_form
	 * @Date : 2018. 12. 11.
	 * @User : 김준영
	 * @Param : 공통 유저, 회사 유저
	 * @Return : 회원가입 후 기업 로그인 페이지로 이동 
	 * @Method 설명 : FAP 기업 회원가입 후 로그인 페이지로 이동하는 컨트롤러 함수
	 */
//	@Transactional
//	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_INSERT_FORM, method = RequestMethod.POST)
//	public String company_insert_form(Model model, String company_ck, User user, SocietyFapCompanyUser societyFapCompanyUser){
//		logger.info("FAP 기업 회원 등록 컨트롤러 시작");
//		// 존재하는 회사 정보가 없어 담당자가 회사 정보까지 입력; 회원 공통 테이블, 회사회원 둘다 insert
//		if(company_ck.equals("nonexistent")){
//			sfcService.insertComUser(user);
//			sfcService.insertCompany(societyFapCompanyUser);
//		// 존재하는 회사 정보가 있어서 담당자가 회사 정보를 입력하지 않음; 회원 공통 테이블
//		} else if(company_ck.equals("existent")){
//			sfcService.insertComUser(user);
//		}
//		logger.info("FAP 기업 회원 등록 컨트롤러 종료");
//		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_COMPANY_INSERT_FORM;
//	}
//	
	@RequestMapping(value=SOCIETY_FAP_COMPANY_ROADMAP_MAIN, method = RequestMethod.GET)
	public String company_roadmap_main(Model model){
		System.out.println("hello world!");
		
		//잡페어 리스트 담은 map (key : jobfair_list_now, jobfair_list_before,jobfair_list_after)
		HashMap<String, Object> jobfair_map = new HashMap<String, Object>();
		jobfair_map = sfcrService.select_jobfair();
		model.addAttribute("jobfair_map", jobfair_map);
		
		
		
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_COMPANY_ROADMAP_MAIN;
	}
}