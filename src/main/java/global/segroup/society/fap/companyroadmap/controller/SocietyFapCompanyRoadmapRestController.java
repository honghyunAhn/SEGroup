/**
 * 
 */
package global.segroup.society.fap.companyroadmap.controller;


import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.segroup.service.SEGroupCommonService;
import global.segroup.society.fap.company.domain.SocietyFapJobAd;
import global.segroup.society.fap.company.domain.SocietyFapJobRecruitPcs;
import global.segroup.society.fap.company.service.SocietyFapCompanyService;
import global.segroup.society.fap.companyroadmap.domain.SocietyFapCompanyRoadmapJobfairDivide;
import global.segroup.society.fap.companyroadmap.service.SocietyFapCompanyRoadmapService;
import global.segroup.society.fap.user.service.SocietyFapUserService;
import global.segroup.util.PathConstants;

/**
 * 
 * @Author : 원병호
 * @Date : 2018. 12. 12.
 * @Class 설명 : Soft Engineer Society 통합잡페어 채용기업 로드맵 Rest 컨트롤러
 * 
 */

@Controller
public class SocietyFapCompanyRoadmapRestController implements PathConstants {

	private static final Logger logger = LoggerFactory.getLogger(SocietyFapCompanyRoadmapRestController.class);

	@Autowired
	private SocietyFapCompanyService sfcService;
		
	@Autowired
	private SocietyFapUserService sfuService;
	
	@Autowired
	private SEGroupCommonService sgcService;

	@Autowired
	private SocietyFapCompanyRoadmapService sfcrService;
	
	/**
	 * @Method Name : company_user_id_check
	 * @Date : 2018. 12. 11.
	 * @User : 김준영
	 * @Param : 유저가 입력한 아이디
	 * @Return : 중복 체크 후 boolean
	 * @Method 설명 : 유저가 입력한 아이디를 중복체크 해주는 함수
	 */
//	@ResponseBody
//	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_USER_ID_CHECK, method = RequestMethod.POST)
//	public boolean companyUserIdCheck(String user_id){
//		logger.info("아이디 중복 체크 컨트롤러 시작");
//		String user_id_check = sfcService.userIdCheck(user_id);
//		// 중복된 아이디가 없는 경우
//		if(user_id_check == null){
//			return true;
//		}
//		logger.info("아이디 중복 체크 컨트롤러 종료");
//		return false;
//	}
	
	
	/**
	 * 
	 * @Method Name : select_jobfair_divide
	 * @Date : 2018. 12. 20.
	 * @User : Administrator
	 * @Param : 잡페어 seq
	 * @Return : 세부잡페어 list
	 * @Method 설명 :잡페어seq로 세부 잡페어 목록 불러오기
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_ROADMAP_SELECT_JOBFAIR_DIVIDE, method = RequestMethod.POST)
	public ArrayList<SocietyFapCompanyRoadmapJobfairDivide> select_jobfair_divide(int fap_jobfair_seq, Authentication auth, HttpSession session){
		logger.info("FAP 기업로드맵 잡페어 세부 불러오기 컨트롤러 시작");
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		String user_id = "";
		if(auth!= null) user_id = (String)auth.getPrincipal();
		else  {
			SecurityContextImpl context = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
			Authentication authTemp = context.getAuthentication();
			user_id = (String) authTemp.getPrincipal();
		}
		String fap_comp_id = sfcService.select_fap_comp_id(user_id);
		params.put("fap_jobfair_seq", fap_jobfair_seq);
		params.put("fap_comp_id", fap_comp_id);
		
		ArrayList<SocietyFapCompanyRoadmapJobfairDivide> jobfair_divide_list = sfcrService.select_jobfair_divide(params);
		
		//에러 감지용 로그 시작
		logger.info("---------> 에러감지용 로그 시작(companyRoadmapRestController)");
		logger.info("회사아이디 : " + fap_comp_id);
		logger.info("잡페어 일련번호 : " + fap_jobfair_seq);
		for(SocietyFapCompanyRoadmapJobfairDivide jobfair_divide : jobfair_divide_list){
			logger.info("출력 시킬 잡페어 세부 일련번호 : " + jobfair_divide);
		}
		logger.info("---------> 에러감지용 로그 종료(companyRoadmapRestController)");
		//에러 감지용 로그 종료
		
		logger.info("FAP 기업로드맵 잡페어 세부 불러오기 컨트롤러 종료(companyRoadmapRestController)");
		return jobfair_divide_list;
	}
	
	/**
	 * @Method Name : select_job_ad_title_list
	 * @Date : 2019. 9. 23.
	 * @User : 이종호
	 * @Param : 세부잡페어 시퀀스
	 * @Return : 진행중,마감된 채용공고(제목) 리스트
	 * @Method 설명 : 세부 잡페어별 진행중,마감된 채용공고(제목) 리스트 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_ROADMAP_SELECT_JOB_AD_TITLE_LIST, method = RequestMethod.POST)
	public ArrayList<SocietyFapJobAd> select_job_ad_title_list(int fap_jobfair_divide_seq, Authentication auth){
		logger.info("FAP 세부 잡페어별 진행중,마감된 채용공고(제목) 리스트 조회 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		String fap_comp_id = sfcService.select_fap_comp_id(user_id);
		HashMap<String, Object> params = new HashMap<>();
		params.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		params.put("fap_comp_id", fap_comp_id);
		ArrayList<SocietyFapJobAd> jobAdTitleList = sfcrService.select_job_ad_title_list(params);
		logger.info("FAP 세부 잡페어별 진행중,마감된 채용공고(제목) 리스트 조회 컨트롤러 종료");
		return jobAdTitleList;
	}
	
	/**
	 * 
	 * @Method Name : select_job_recruit_pcs
	 * @Date : 2018. 12. 26.
	 * @User : 원병호
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 채용전형 리스트 가져오기
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_ROADMAP_SELECT_JOB_RECRUIT_PCS, method = RequestMethod.POST)
	public ArrayList<SocietyFapJobRecruitPcs> select_job_recruit_pcs(String fap_jobfair_divide_seq, Authentication auth){
		logger.info("FAP 기업로드맵 채용 전형 불러오기 컨트롤러 시작");
		
		String user_id = (String)auth.getPrincipal();
		
		logger.info("param : {}, {}", fap_jobfair_divide_seq, user_id);
		
		ArrayList<SocietyFapJobRecruitPcs> SocietyFapJobRecruitPcsList = 
				sfcrService.select_job_recruit_pcs(fap_jobfair_divide_seq, user_id);
		logger.info("FAP 기업로드맵 채용 전형 불러오기 컨트롤러 종료 {}", SocietyFapJobRecruitPcsList);
		return SocietyFapJobRecruitPcsList;
	}
	
	
	/**
	 * @Method Name : roadmap_process_map
	 * @Date : 2018. 12. 27.
	 * @User : Administrator
	 * @Param : 
	 * @Return : hashmap
	 * @Method 설명 : 로드맵 진행에 필요한 정보
	 */
	@ResponseBody
	@RequestMapping(value = SOCIETY_FAP_COMPANY_ROADMAP_ROADMAP_PROCESS_MAP, method = RequestMethod.POST)
	public HashMap<String, Object> roadmap_process_map (Authentication auth, String fap_jobfair_divide_seq){
		logger.info("FAP 기업로드맵 진행 정보 불러오기 컨트롤러 시작");
		
		String user_id = (String)auth.getPrincipal();
		
		HashMap<String, Object> result = sfcrService.roadmap_process_map(user_id, Integer.parseInt(fap_jobfair_divide_seq));
		
		return result;
	}
	
}
