/**
 * 
 */
package global.segroup.society.fap.adminuser.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import global.segroup.society.fap.adminuser.service.SocietyFapAdminUserService;
import global.segroup.util.PathConstants;

/**
 * @Author : 정대영
 * @Date : 2018. 12. 05.
 * @Class 설명 : Soft Engineer Society 통합잡페어 관리자(취업지원자 기능담당) View 컨트롤러
 * 
 */

@Controller
public class SocietyFapAdminUserViewController implements PathConstants {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyFapAdminUserViewController.class);
	
	@Autowired
	private SocietyFapAdminUserService sfauService;
	
	/**
	 * @Method Name : additional_apply_company_configured
	 * @Date : 2019. 1. 7.
	 * @User : 정대영
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 추가기업 지원설정 폼)
	 * @Method 설명 : 관리자 추가지원 기업설정 페이지 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_ADDITIONAL_APPLY_COMPANY_CONFIGURED, method = RequestMethod.GET)
	public String additional_apply_company_configured(Model model, int fap_jobfair_seq){
		logger.debug("FAP 관리자 추가지원 기업설정 컨트롤러 시작");
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		logger.debug("FAP 관리자 추가지원 기업설정 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_ADDITIONAL_APPLY_COMPANY_CONFIGURED;
	}
	
	/**
	 * @Method Name : apply_business_rule_application_form
	 * @Date : 2019. 1. 8.
	 * @User : 정대영
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 관리자 잡페어 세부 별 지원룰 적용 페이지)
	 * @Method 설명 : FAP 관리자 잡페어 세부 별 지원룰 적용 페이지로 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_APPLY_BUSINESS_RULE_APPLICATION_FORM, method = RequestMethod.GET)
	public String apply_business_rule_application_form(Model model, int fap_jobfair_seq){
		logger.debug("FAP 관리자 추가지원 기업설정 컨트롤러 시작");
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		logger.debug("FAP 관리자 추가지원 기업설정 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_APPLY_BUSINESS_RULE_APPLICATION_FORM;
	}
	
}