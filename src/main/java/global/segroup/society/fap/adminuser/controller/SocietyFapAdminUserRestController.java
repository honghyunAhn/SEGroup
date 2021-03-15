/**
 * 
 */
package global.segroup.society.fap.adminuser.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairDivide;
import global.segroup.society.fap.admincommon.domain.SocietyFapJobfairApplicableTime;
import global.segroup.society.fap.admincommon.service.SocietyFapAdminCommonService;
import global.segroup.society.fap.adminuser.service.SocietyFapAdminUserService;
import global.segroup.util.PathConstants;

/**
 * 
 * @Author : 정대영
 * @Date : 2018. 12. 05.
 * @Class 설명 : Soft Engineer Society 통합잡페어 관리자(유저기능담당) Rest 컨트롤러
 * 
 */

@Controller
public class SocietyFapAdminUserRestController implements PathConstants {

	private static final Logger logger = LoggerFactory.getLogger(SocietyFapAdminUserRestController.class);

	@Autowired
	private SocietyFapAdminUserService sfauService;
	
	@Autowired
	private SocietyFapAdminCommonService sfaService;
	
	/**
	 * @Method Name : select_jobfair_divide_list_in_additional_apply
	 * @Date : 2019. 1. 7.
	 * @User : 정대영
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 추가기업 지원설정 폼)
	 * @Method 설명 : FAP 관리자 잡페어 세부 정보 비동기 셀렉트  컨트롤러
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_SELECT_JOBFAIR_DIVIDE_LIST_IN_ADDITIONAL_APPLY, method = RequestMethod.GET)
	public ArrayList<SocietyFapAdminJobfairDivide> select_jobfair_divide_list_in_additional_apply(int fap_jobfair_seq){
		logger.debug("FAP 관리자 잡페어 세부 정보 비동기 셀렉트  컨트롤러 시작");
		ArrayList<SocietyFapAdminJobfairDivide> jobfair_divide_search_list = sfaService.select_fap_jobfair_divide(fap_jobfair_seq);
	    logger.debug("FAP 관리자 잡페어 세부 정보 비동기 셀렉트  컨트롤러 종료");
		return jobfair_divide_search_list;
	}
	
	/**
	 * @Method Name : select_jobfair_divide_ad_apply_status_info
	 * @Date : 2019. 1. 8.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : HashMap
	 * @Method 설명 : FAP 관리자 잡페어 세부 별 채용공고 진행상황 리스트를 셀렉트하는 컨트롤러 
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_SELECT_JOBFAIR_DIVIDE_AD_APPLY_STATUS_INFO, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> select_jobfair_divide_ad_apply_status_info(int fap_jobfair_divide_seq){
		logger.debug("FAP 관리자 잡페어 세부 별 채용공고 진행상황 셀렉트  컨트롤러 시작");
		ArrayList<HashMap<String, Object>> adApplyStatusInfoList = sfauService.select_jobfair_divide_ad_apply_status_info(fap_jobfair_divide_seq);
	    logger.debug("FAP 관리자 잡페어 세부 별 채용공고 진행상황 셀렉트  컨트롤러 종료");
		return adApplyStatusInfoList;
	}
	
	/**
	 * @Method Name : select_jobfair_divide_addition_comp_list
	 * @Date : 2019. 1. 8.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : HashMap
	 * @Method 설명 : FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고 리스트 셀렉트 컨트롤러 
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_SELECT_JOBFAIR_DIVIDE_ADDITION_COMP_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> select_jobfair_divide_addition_comp_list(int fap_jobfair_divide_seq){
		logger.debug("FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고 리스트 셀렉트 컨트롤러  시작");
		ArrayList<HashMap<String, Object>> additionCompList = sfauService.select_jobfair_divide_addition_comp_list(fap_jobfair_divide_seq);
	    logger.debug("FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고 리스트 셀렉트 컨트롤러  종료");
		return additionCompList;
	}
	
	/**
	 * @Method Name : insert_jobfair_divide_addition_comp_list
	 * @Date : 2019. 1. 8.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고로 설정(insert)
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_INSERT_JOBFAIR_DIVIDE_ADDITION_COMP_LIST, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String insert_jobfair_divide_addition_comp_list(@RequestBody HashMap<String, Object> insertIntoAdditionalApplyInfoMap, Authentication auth){
		logger.debug("FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고로 설정(insert) 컨트롤러  시작");
		insertIntoAdditionalApplyInfoMap.put("admin_id", (String)auth.getPrincipal());
		//채용공고 관련 정보 추가  
		String message = sfauService.insert_jobfair_divide_addition_comp_list(insertIntoAdditionalApplyInfoMap);
		
		//채용공고 관련 정보 추가시 지원룰 테이블에 관련 정보 추가 
		String additionalMessage = sfauService.insert_jobfair_apply_rule_info(insertIntoAdditionalApplyInfoMap);
		  
	    logger.debug("FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고로 설정(insert) 컨트롤러  종료");
		return message;
	}
	
	/**
	 * @Method Name : delete_jobfair_divide_addition_comp_list
	 * @Date : 2019. 1. 8.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고에서 설정 삭제
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_DELETE_JOBFAIR_DIVIDE_ADDITION_COMP_LIST, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String delete_jobfair_divide_addition_comp_list(@RequestBody HashMap<String, Object> deleteFromAdditionalApplyInfoMap, Authentication auth){
		logger.debug("FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고에서 설정 삭제 컨트롤러  시작");
		deleteFromAdditionalApplyInfoMap.put("admin_id", (String)auth.getPrincipal());
		
		//채용공고 관련 정보 삭제  
		String message = sfauService.delete_jobfair_divide_addition_comp_list(deleteFromAdditionalApplyInfoMap);
		//채용공고 관련 정보 삭제시 지원룰 테이블에 관련 정보 삭제 
		String additionalMessage = sfauService.delete_jobfair_apply_rule_info(deleteFromAdditionalApplyInfoMap);
	    logger.debug("FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고에서 설정 삭제 컨트롤러  종료");
		return message;
	}
	
	/**
	 * @Method Name : select_jobfair_divide_applicable_time
	 * @Date : 2019. 1. 9.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : String
	 * @Method 설명 : FAP 관리자 잡페어 세부별 지원가능 시간 조회
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_SELECT_JOBFAIR_DIVIDE_APPLICABLE_TIME, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> select_jobfair_divide_applicable_time(int fap_jobfair_divide_seq){
		logger.debug("FAP 관리자 잡페어 세부별 지원가능 시간 조회 컨트롤러  시작");
		ArrayList<HashMap<String, Object>> applicableTimeList = sfauService.select_jobfair_divide_applicable_time(fap_jobfair_divide_seq);
	    logger.debug("FAP 관리자 잡페어 세부별 지원가능 시간 조회 컨트롤러  종료");
		return applicableTimeList;
	}
	
	/**
	 * @Method Name : resume_approval_after_rule_apply
	 * @Date : 2019. 1. 9. -> 2019. 8. 7
	 * @User : 정대영 -> 이종호
	 * @Param : HashMap -> ArrayList<Integer>
	 * @Return : String -> -
	 * @Method 설명 : FAP 관리자 채용공고별 룰 적용 후 취업지원자 이력서 승인
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_RESUME_APPROVAL_AFTER_RULE_APPLY, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public void resume_approval_after_rule_apply(long[] fap_job_ad_seq_list,long[] fap_jobfair_rule_seq_list, long fap_jobfair_divide_seq,String fap_jobfair_apply_rule_gb, Authentication auth,long fap_jobfair_applicable_time_seq){
		logger.debug("FAP 관리자 채용공고별 룰 적용 후 취업지원자 이력서 승인 컨트롤러  시작");
		
		List<Long> job_ad_list = Arrays.stream(fap_job_ad_seq_list).boxed().collect(Collectors.toList());
		List<Long> jobfair_rule_list = Arrays.stream(fap_jobfair_rule_seq_list).boxed().collect(Collectors.toList());
		
		HashMap<String, Object> approvalInsertInfoMap = new HashMap<>();
		approvalInsertInfoMap.put("admin_id", (String)auth.getPrincipal());
		approvalInsertInfoMap.put("job_ad_list", job_ad_list);
		approvalInsertInfoMap.put("jobfair_rule_list", jobfair_rule_list);
		approvalInsertInfoMap.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		approvalInsertInfoMap.put("fap_jobfair_apply_rule_gb", fap_jobfair_apply_rule_gb);
		approvalInsertInfoMap.put("fap_jobfair_applicable_time_seq", fap_jobfair_applicable_time_seq);
		
		sfauService.resume_approval_after_rule_apply(approvalInsertInfoMap);
		sfauService.update_applicable_time_deadline_gb(approvalInsertInfoMap);
	    logger.debug("FAP 관리자 채용공고별 룰 적용 후 취업지원자 이력서 승인 컨트롤러  종료");
	}
	
	/**
	 * @Method Name : resume_ignore_after_rule_apply
	 * @Date : 2019. 1. 9.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 관리자 잡페어 세부별 룰 무시하고 취업지원자 이력서 승인
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_RESUME_IGNORE_AFTER_RULE_APPLY, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public void resume_ignore_after_rule_apply(long[] fap_job_ad_seq_list,long[] fap_jobfair_rule_seq_list,long fap_jobfair_divide_seq,String fap_jobfair_apply_rule_gb, Authentication auth,long fap_jobfair_applicable_time_seq){
		logger.debug("FAP 관리자 잡페어 세부별 룰 무시하고 취업지원자 이력서 승인 컨트롤러  시작");
		
		List<Long> job_ad_list = Arrays.stream(fap_job_ad_seq_list).boxed().collect(Collectors.toList());
		List<Long> jobfair_rule_list = Arrays.stream(fap_jobfair_rule_seq_list).boxed().collect(Collectors.toList());
		
		HashMap<String, Object> ignoreInsertInfoMap = new HashMap<>();
		ignoreInsertInfoMap.put("admin_id", (String)auth.getPrincipal());
		ignoreInsertInfoMap.put("job_ad_list", job_ad_list);
		ignoreInsertInfoMap.put("jobfair_rule_list", jobfair_rule_list);
		ignoreInsertInfoMap.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		ignoreInsertInfoMap.put("fap_jobfair_apply_rule_gb", fap_jobfair_apply_rule_gb);
		ignoreInsertInfoMap.put("fap_jobfair_applicable_time_seq", fap_jobfair_applicable_time_seq);
		
		ignoreInsertInfoMap.put("admin_id", (String)auth.getPrincipal());
		sfauService.resume_ignore_after_rule_apply(ignoreInsertInfoMap);
		sfauService.update_applicable_time_deadline_gb(ignoreInsertInfoMap);
	    logger.debug("FAP 관리자 잡페어 세부별 룰 무시하고 취업지원자 이력서 승인 컨트롤러  종료");
	}
	
	/**
	 * @Method Name : select_jobfair_applicable_time_nm_list
	 * @Date : 2019. 8. 6.
	 * @User : 이종호
	 * @Param : 세부잡페어 시퀀스
	 * @Return : 지원가능 시간 명칭 리스트
	 * @Method 설명 : 세부잡페어별 지원가능 시간 명칭 리스트 조회
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_SELECT_JOBFAIR_APPLICABLE_TIME_NM_LIST, method = RequestMethod.POST)
	public ArrayList<SocietyFapJobfairApplicableTime> select_jobfair_applicable_time_nm_list(int fap_jobfair_divide_seq){
		logger.info("FAP 관리자 세부잡페어별 지원가능 시간 명칭 리스트 조회 컨트롤러 시작");
		ArrayList<SocietyFapJobfairApplicableTime> result = sfauService.select_jobfair_applicable_time_nm_list(fap_jobfair_divide_seq);
		logger.info("FAP 관리자 세부잡페어별 지원가능 시간 명칭 리스트 조회 컨트롤러 종료");
		
		return result;
	}
	
	/**
	 * @Method Name : select_jobfair_applicable_ad_list
	 * @Date : 2019. 8. 7.
	 * @User : 이종호
	 * @Param : 채용공고 지원가능시간 시퀀스
	 * @Return : 지원룰 대상 채용공고 리스트
	 * @Method 설명 : 세부 채용공고별 지원룰 대상 채용공고 리스트 조회
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_SELECT_JOBFAIR_APPLICABLE_AD_LIST, method = RequestMethod.POST)
	public HashMap<String, Object> select_jobfair_applicable_ad_list(long fap_jobfair_applicable_time_seq,
			int pageCount, int curPage, int orderNo){
		logger.info("FAP 관리자 세부 채용공고별 지원룰 대상 채용공고 리스트 조회 컨트롤러 시작");
		
		HashMap<String, Object> result = sfauService.select_jobfair_applicable_ad_list(fap_jobfair_applicable_time_seq,pageCount,curPage,orderNo);
		
		logger.info("FAP 관리자 세부 채용공고별 지원룰 대상 채용공고 리스트 조회 컨트롤러 종료");
		return result;
	}
}
