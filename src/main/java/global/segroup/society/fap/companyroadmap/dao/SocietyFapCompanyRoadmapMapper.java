/**
 * 
 */
package global.segroup.society.fap.companyroadmap.dao;

import java.util.ArrayList;
import java.util.HashMap;

import global.segroup.society.fap.company.domain.SocietyFapJobAd;
import global.segroup.society.fap.company.domain.SocietyFapJobRecruitPcs;
import global.segroup.society.fap.companyroadmap.domain.SocietyFapCompanyRoadmapJobfair;
import global.segroup.society.fap.companyroadmap.domain.SocietyFapCompanyRoadmapJobfairDivide;

/**
 * @Author : 원병호
 * @Date : 2018. 12. 12.
 * @Class 설명 : Soft Engineer Society 통합잡페어 채용기업 로드맵 매퍼
 * 
 */
public interface SocietyFapCompanyRoadmapMapper {
	
	public ArrayList<SocietyFapCompanyRoadmapJobfair> select_jobfair_now();			//잡페어 목록(진행중)
	public ArrayList<SocietyFapCompanyRoadmapJobfair> select_jobfair_before();		//잡페어 목록(시작전)
	public ArrayList<SocietyFapCompanyRoadmapJobfair> select_jobfair_after();		//잡페어 목록(종료된)
	public ArrayList<SocietyFapCompanyRoadmapJobfairDivide> select_jobfair_divide(HashMap<String, Object> params);	//잡페어 세부
	
	/**
	 * @Method Name : select_job_ad_title_list
	 * @Date : 2019. 9. 23.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스, 기업 아이디
	 * @Return : 세부 잡페어별 진행중, 마감된 채용공고 (제목) 리스트
	 * @Method 설명 : 세부 잡페어별 진행중, 마감된 채용공고 (제목) 리스트 조회 
	 */
	public ArrayList<SocietyFapJobAd> select_job_ad_title_list(HashMap<String, Object> params);
	
	/**
	 * @Method Name : select_job_recruit_pcs
	 * @Date : 2018. 12. 26.
	 * @User : Administrator
	 * @Param : HashMap : fap_jobfair_divide_seq, user_id
	 * @Return : ArrayList
	 * @Method 설명 : 해당 세부 잡페어의 채용전형을 불러오는 메소드
	 */
	public ArrayList<SocietyFapJobRecruitPcs> select_job_recruit_pcs(HashMap<String, Object> map);
	
	/**
	 * @Method Name : select_comp_user_connect
	 * @Date : 2018. 12. 27.
	 * @User : 원병호
	 * @Param : user_id
	 * @Return : hashmap (user_id, fap_comp_user_connect_ck, fap_comp_id)
	 * @Method 설명 : 아이디로 회사아이디와 승인상태를 가져오는 매퍼 함수
	 */
	public HashMap<String, Object> select_comp_user_connect (String user_id);
	
	/**
	 * @Method Name : select_jobfair_comp
	 * @Date : 2018. 12. 28.
	 * @User : 원병호
	 * @Param : hashmap(fap_jobfair_divide_seq, fap_comp_id)
	 * @Return : hashmap (fap_jobfair_comp_seq, fap_jobfair_divide_seq, fap_jobfair_seq
    						, fap_comp_id, fap_jobfair_comp_gu)
	 * @Method 설명 : 회사 잡페어 등록정보
	 */
	public HashMap<String, Object> select_jobfair_comp (HashMap<String, Object> map);
	
	
	/**
	 * @Method Name : select_jobfair_start
	 * @Date : 2018. 12. 31.
	 * @User : 원병호
	 * @Param : fap_jobfair_divide_seq
	 * @Return : hashmap (is_start, is_end ; 0:true, 1:false)
	 * @Method 설명 : 해당 세부 잡페어의 신청 가능 여부
	 */
	public HashMap<String, Object> select_jobfair_start (int fap_jobfair_divide_seq);
	
	/*
	 * @Method Name : select_job_ad
	 * @Date : 2018. 12. 31.
	 * @User : 원병호
	 * @Param : HashMap (fap_comp_id, fap_jobfair_divide_seq)
	 * @Return : SocietyFapJobAd
	 * @Method 설명 : 채용공고 정보
	 */
	public SocietyFapJobAd  select_job_ad (HashMap<String, Object> map);
	
	/*
	 * @Method Name : select_job_recruit_sch
	 * @Date : 2019. 1. 2.
	 * @User : 원병호
	 * @Param : fap_job_ad_seq
	 * @Return : HashMap (fap_job_recruit_pcs_sch 객체 + is_start, is_end:전형이 시작됐는지 판단하는 값)
	 * @Method 설명 :
	 */
	public ArrayList<HashMap<String, Object>> select_job_recruit_pcs_sch(int fap_job_ad_seq);
	
}
