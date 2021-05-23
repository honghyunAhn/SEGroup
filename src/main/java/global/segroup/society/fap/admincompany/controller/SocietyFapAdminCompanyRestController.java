/**
 * 
 */
package global.segroup.society.fap.admincompany.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairDivide;
import global.segroup.society.fap.admincommon.service.SocietyFapAdminCommonService;
import global.segroup.society.fap.admincompany.service.SocietyFapAdminCompanyService;
import global.segroup.society.fap.company.domain.SocietyFapJobAd;
import global.segroup.society.fap.companyroadmap.service.SocietyFapCompanyRoadmapService;
import global.segroup.util.PathConstants;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 20.
 * @Class 설명 : Soft Engineer Society 통합잡페어 관리자(기업기능담당) Rest 컨트롤러
 * 
 */
@Controller
public class SocietyFapAdminCompanyRestController {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyFapAdminCompanyRestController.class);
	
	@Autowired
	private SocietyFapCompanyRoadmapService sfcrService;
	
	@Autowired
	private SocietyFapAdminCompanyService sfacService;
	
	@Autowired
	private SocietyFapAdminCommonService sfaService;
	
	/**
	 * @Method Name : update_job_ad_state
	 * @Date : 2019. 2. 12.
	 * @User : 정대영
	 * @Param : SocietyFapJobAd(fap_job_ad_seq, fap_job_ad_state)
	 * @Return : -
	 * @Method 설명 : FAP 관리자 채용공고 상태 수정
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_UPDATE_JOB_AD_STATE, method = RequestMethod.POST)
	public boolean update_job_ad_state(@RequestBody SocietyFapJobAd jobAd, Authentication auth, HttpSession session){
		logger.debug("FAP 관리자 채용공고 상태 수정 시작");
		
		String admin_id = "";
		if(auth != null) admin_id = (String) auth.getPrincipal();
		else admin_id = (String) session.getAttribute("user_id");
		
		boolean result = sfacService.admin_approve_job_ad(jobAd, admin_id);
		logger.debug("FAP 관리자 채용공고 상태 수정 종료");
		return result;
	}
	
	/**
	 * 
	 * @Method Name : select_jobfair_divide
	 * @Date : 2019. 2. 12.
	 * @User : 정대영
	 * @Param : 잡페어 seq
	 * @Return : 세부잡페어 list
	 * @Method 설명 : FAP 관리자 잡페어seq로 세부 잡페어 목록 불러오기
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_SELECT_JOBFAIR_DIVIDE, method = RequestMethod.POST)
	public ArrayList<SocietyFapAdminJobfairDivide> select_jobfair_divide(int fap_jobfair_seq, Authentication auth){
		logger.info("FAP 관리자 잡페어 세부 불러오기 컨트롤러 시작");
		ArrayList<SocietyFapAdminJobfairDivide> jobfair_divide_list = sfaService.select_fap_jobfair_divide(fap_jobfair_seq);
		logger.info("FAP 관리자 잡페어 세부 불러오기 컨트롤러 종료");
		return jobfair_divide_list;
	}
	
	/**
	 * @Method Name : admin_select_per_state_job_ad_list
	 * @Date : 2019. 2. 12.
	 * @User : 정대영
	 * @Param : 잡페어 시퀀스, 잡페어세부 시퀀스
	 * @Return : HashMapList(회사별 진행중인 잡페어 리스트)
	 * @Method 설명 : FAP 관리자 채용공고 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_SELECT_PER_STATE_JOB_AD_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> admin_select_per_state_job_ad_list(@RequestBody HashMap<String, Object> params){
		logger.debug("FAP 관리자 채용공고 리스트 검색 컨트롤러 시작");
		ArrayList<HashMap<String, Object>> perStateJobAdList = sfacService.admin_select_per_state_job_ad_list(params);
		logger.debug("FAP 관리자 채용공고 리스트 검색 컨트롤러 종료");
		return perStateJobAdList;
	}
	/**
	 * @Method Name : admin_select_jobfair_list
	 * @Date : 2019. 2. 21.
	 * @User : 남유송
	 * @Param :-
	 * @Return : 잡페어 정보 리스트 
	 * @Method 설명 :  잡페어 정보 리스트 출력
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_SELECT_JOBFAIR_LIST, method = RequestMethod.POST)
	public HashMap<String, Object> admin_select_jobfiar_list(Model model){
		logger.debug("잡페어 정보 리스트 출력 시작");
		HashMap<String, Object> jobfair_map = new HashMap<String, Object>();
		jobfair_map = sfcrService.select_jobfair();
		Gson gson = new Gson();
		model.addAttribute("jobfair_map", gson.toJson(jobfair_map));
		logger.debug("잡페어 정보 리스트 출력 시작 종료");
		return jobfair_map;
	}
	/**
	 * @Method Name : select_all_job_fair_divide
	 * @Date : 2019.02.21
	 * @User : 남유송
	 * @Param : int
	 * @Return : HashMap
	 * @Method 설명 : 잡페어별 잡페어 상세 구분코드, 일련번호 출력
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_COMPANY_SELECT_JOBFAIR_LIST, method = RequestMethod.POST)
	public ArrayList<SocietyFapAdminJobfairDivide> select_all_job_fair_divide(int fap_jobfair_seq){
		logger.info("잡페어별 잡페어 세부정보 검색 컨트롤러 시작");
		ArrayList<SocietyFapAdminJobfairDivide> jobFairDividedMap = sfaService.select_fap_jobfair_divide(fap_jobfair_seq);
		for (int i = 0; i < jobFairDividedMap.size(); i++) {
			System.out.println(jobFairDividedMap.toString());
		}
		logger.info("잡페어별 잡페어 세부정보 검색컨트롤러 종료");
		return jobFairDividedMap;
	}
	
	/**
	 * @Method Name : change_groupcode
	 * @Date : 2019.02.26
	 * @User : 남유송
	 * @Param : Hashmap
	 * @Return : -
	 * @Method 설명 : 그룹코드 업데이트
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_COMPANY_CHANGE_GROUPCODE, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> change_groupcode(String fap_job_ad_groupcode, String fap_job_ad_seq, int fap_jobfair_divide_seq){
		logger.info("기업 그룹코드 업데이트 컨트롤러 시작");
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("fap_job_ad_groupcode", fap_job_ad_groupcode);
		params.put("fap_job_ad_seq", Long.parseLong(fap_job_ad_seq));
		sfacService.admin_update_groupcode(params);
		ArrayList<HashMap<String, Object>> count_per_group = sfacService.select_count_per_group(fap_jobfair_divide_seq);
		logger.info("기업 그룹코드 업데이트 컨트롤러 종료");
		return count_per_group;
		
	}
	
	/**
	 * @Method Name : update_rank
	 * @Date : 2021.03.09
	 * @User : 안홍현
	 * @Param : Hashmap
	 * @Return : -
	 * @Method 설명 : 순위 변경
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_COMPANY_ADMIN_UPDATE_RANK, method = RequestMethod.POST)
	public int admin_update_rank(String fap_job_ad_seq, int fap_job_ad_rank, String fap_jobfair_divide_seq,String fap_job_ad_groupcode){
		logger.info("기업 그룹 순위 업데이트 컨트롤러 시작");
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("fap_job_ad_seq", Long.parseLong(fap_job_ad_seq));
		params.put("fap_job_ad_rank", fap_job_ad_rank);
		params.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		params.put("fap_job_ad_groupcode", fap_job_ad_groupcode);
		int res = sfacService.admin_update_rank(params);
		logger.info("기업 그룹 순위 업데이트 컨트롤러 종료");
		return res;
	}
	/**
	 * @Method Name : allow_common_user
	 * @Date : 2021.05.18
	 * @User : 김나영
	 * @Param : Hashmap
	 * @Return : -
	 * @Method 설명 : 잡페어 관리자 그룹코드 일반회원 지원 허용
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_ALLOW_COMMON_USER_YN, method = RequestMethod.POST)
	public int allow_common_user_yn(String fap_job_ad_seq, String allow_common_user_yn){
		logger.info("잡페어 관리자 그룹코드 일반회원 지원 허용 컨트롤러 시작");
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("fap_job_ad_seq", fap_job_ad_seq);
		params.put("allow_common_user_yn", allow_common_user_yn);
		int res = sfacService.allow_common_user_yn(params);
		logger.info("잡페어 관리자 그룹코드 일반회원 지원 허용 컨트롤러 종료");
		return res;
	}
	/**
	 * @Method Name : admin_job_app_per_update
	 * @Date : 2019. 2. 27.
	 * @User : 이종호
	 * @Param : 지원가능인원 시퀀스 , 지원가능 인원 수
	 * @Return : -
	 * @Method 설명 : FAP 관리자 채용공고 지원가능인원 수정
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOB_APP_PER_UPDATE, method = RequestMethod.POST)
	public void admin_job_app_per_update(@RequestBody HashMap<String, Object> params){
		logger.info("FAP 관리자 채용공고 지원가능인원 수정 시작");
		sfacService.admin_job_app_per_update(params);
		logger.info("FAP 관리자 채용공고 지원가능인원 수정 종료");
	}
	
	/**
	 * @Method Name : admin_job_itv_per_update
	 * @Date : 2019. 7. 31.
	 * @User : 이종호
	 * @Param : 현지제한인원 시퀀스 , 인원수
	 * @Return :  -
	 * @Method 설명 : FAP 관리자 채용공고 현지제한인원 수정 
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOB_ITV_PER_UPDATE, method = RequestMethod.POST)
	public void admin_job_itv_per_update(@RequestBody HashMap<String, Object> params) {
		logger.info("FAP 관리자 채용공고 현지제한인원 수정 컨트롤러 시작");
		sfacService.admin_job_itv_per_update(params);
		logger.info("FAP 관리자 채용공고 현지제한인원 수정 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : admin_update_mismatching
	 * @Date : 2019. 2. 27.
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : FAP 관리자 미스매칭/일반지원 수정
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_UPDATE_MISMATCHING, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public void admin_update_mismatching(@RequestBody HashMap<String, Object> params){
		logger.info("FAP 관리자 미스매칭/일반지원 수정 시작");
		sfacService.admin_update_mismatching(params);
		logger.info("FAP 관리자 미스매칭/일반지원 수정 종료");
	}
}
