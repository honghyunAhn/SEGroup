/**
 * 
 */
package global.segroup.society.fap.companyroadmap.service;


import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import global.segroup.society.fap.company.dao.SocietyFapCompanyDAO;
import global.segroup.society.fap.company.domain.SocietyFapJobAd;
import global.segroup.society.fap.company.domain.SocietyFapJobRecruitPcs;
import global.segroup.society.fap.companyroadmap.dao.SocietyFapCompanyRoadmapDAO;
import global.segroup.society.fap.companyroadmap.domain.SocietyFapCompanyRoadmapJobfair;
import global.segroup.society.fap.companyroadmap.domain.SocietyFapCompanyRoadmapJobfairDivide;
import global.segroup.society.fap.user.dao.SocietyFapUserDAO;

/**
 * @Author : 신동철
 * @Date : 2018. 11. 29.
 * @Class 설명 : Soft Engineer Society 통합잡페어 채용기업 서비스
 * 
 */
@Service
public class SocietyFapCompanyRoadmapService {

	private static final Logger logger = LoggerFactory.getLogger(SocietyFapCompanyRoadmapService.class);

	@Autowired
	private SocietyFapCompanyDAO sfcDAO;

	@Autowired
	private SocietyFapUserDAO sfuDAO;
	
	@Autowired
	private SocietyFapCompanyRoadmapDAO sfcrDAO;
	
	/**
	 * 
	 * @Method Name : select_jobfair
	 * @Date : 2018. 12. 14.
	 * @User : 원병호
	 * @Param : 
	 * @Return : 잡페어리스트를 담은 map 
	 * @Method 설명 :(key : 진행중 = jobfair_list_now, 시작전 = jobfair_list_before, 종료된 = jobfair_list_after)
	 */
	public HashMap<String, Object> select_jobfair(){
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		ArrayList<SocietyFapCompanyRoadmapJobfair> jobfair_list_now = sfcrDAO.select_jobfair_now();		//진행중인 잡페어 목록
		ArrayList<SocietyFapCompanyRoadmapJobfair> jobfair_list_before = sfcrDAO.select_jobfair_before();	//시작전 잡페어 목록
		ArrayList<SocietyFapCompanyRoadmapJobfair> jobfair_list_after = sfcrDAO.select_jobfair_after();	//끝난 잡페어 목록
		
		result.put("jobfair_list_now", jobfair_list_now);
		result.put("jobfair_list_before", jobfair_list_before);
		result.put("jobfair_list_after", jobfair_list_after);
		
		return result;
	}
	
	/**
	 * @Method Name : select_jobfair_divide
	 * @Date : 2018. 12. 20.
	 * @User : 원병호
	 * @Param : fap_jobfair_seq, fap_comp_id 담은 hashmap
	 * @Return : SocietyFapCompanyRoadmapJobfairDivide 객체
	 * @Method 설명 : fap_jobfair_seq로 잡페어 세부정보 가져오기
	 */
	public ArrayList<SocietyFapCompanyRoadmapJobfairDivide> select_jobfair_divide(HashMap<String, Object> params){
		
		return sfcrDAO.select_jobfair_divide(params);
	}
	
	/**
	 * @Method Name : select_job_ad_title_list
	 * @Date : 2019. 9. 23.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스, 기업 아이디
	 * @Return : 세부 잡페어별 진행중, 마감된 채용공고 (제목) 리스트
	 * @Method 설명 : 세부 잡페어별 진행중, 마감된 채용공고 (제목) 리스트 조회 
	 */
	public ArrayList<SocietyFapJobAd> select_job_ad_title_list(HashMap<String, Object> params){
		logger.info("FAP 기업로드맵 세부 잡페어별 진행중, 마감된 채용공고 (제목) 리스트 조회 DAO 시작");
		ArrayList<SocietyFapJobAd> result = sfcrDAO.select_job_ad_title_list(params);
		logger.info("FAP 기업로드맵 세부 잡페어별 진행중, 마감된 채용공고 (제목) 리스트 조회 DAO 종료");
		return result;
	}
	
	
	/**
	 * 
	 * @Method Name : select_job_recruit
	 * @Date : 2018. 12. 24.
	 * @User : Administrator
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 해당 세부 잡페어의 전형 리스트
	 */
	public ArrayList<SocietyFapJobRecruitPcs> select_job_recruit_pcs(String fap_jobfair_divide_seq, String user_id){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("fap_jobfair_divide_seq", Integer.parseInt(fap_jobfair_divide_seq));
		map.put("user_id", user_id);
		
		return sfcrDAO.select_job_recruit_pcs(map);
	}
	
	
	
	/**
	 * @Method Name : select_job_recruit
	 * @Date : 2018. 12. 24.
	 * @User : Administrator
	 * @Param : 
	 * @Return : hashmap
	 * @Method 설명 : 로드맵 진행에 필요한 정보
	 */
	public HashMap<String, Object> roadmap_process_map (String user_id, int fap_jobfair_divide_seq){
		
		String fap_comp_id = null;
		
		HashMap<String, Object> result = new HashMap<String, Object>();	//로드맵 진행에 필요한 모든 정보를 담는 map
		
		//fap_comp_user_connect
		HashMap<String, Object> map_fap_comp_user_connect = sfcrDAO.select_comp_user_connect(user_id);
		fap_comp_id = (String) map_fap_comp_user_connect.get("fap_comp_id");	//후속 쿼리에 필요한 param 세팅
		result.put("fap_comp_user_connect",  map_fap_comp_user_connect);
		
		//fap_jobfair_comp
		HashMap<String, Object> param_jobfair_comp = new HashMap<String, Object>();
		
		param_jobfair_comp.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		param_jobfair_comp.put("fap_comp_id", fap_comp_id);
		
		result.put("fap_jobfair_comp", sfcrDAO.select_jobfair_comp(param_jobfair_comp));
		
		//fap_jobfair_start
		HashMap<String, Object> fap_jobfair_start = sfcrDAO.select_jobfair_start(fap_jobfair_divide_seq);
		result.put("fap_jobfair_start", fap_jobfair_start);
		
		//fap_job_ad
		HashMap<String, Object> param_fap_job_ad = new HashMap<String, Object>();
		param_fap_job_ad.put("fap_comp_id", fap_comp_id);
		param_fap_job_ad.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		SocietyFapJobAd fap_job_ad = sfcrDAO.select_job_ad(param_fap_job_ad);
		result.put("fap_job_ad", fap_job_ad);
		
		//fap_job_recruit_pcs_sch
		ArrayList<HashMap<String, Object>> fap_job_recruit_pcs_sch = sfcrDAO.select_job_recruit_sch((int)fap_job_ad.getFap_job_ad_seq());
		result.put("fap_job_recruit_pcs_sch", fap_job_recruit_pcs_sch);
		
		return result;
	}
	
	
	
	
	
}
