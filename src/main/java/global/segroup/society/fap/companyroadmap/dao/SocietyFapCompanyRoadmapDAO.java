/**
 * 
 */
package global.segroup.society.fap.companyroadmap.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.segroup.society.fap.company.domain.SocietyFapJobAd;
import global.segroup.society.fap.company.domain.SocietyFapJobRecruitPcs;
import global.segroup.society.fap.companyroadmap.domain.SocietyFapCompanyRoadmapJobfair;
import global.segroup.society.fap.companyroadmap.domain.SocietyFapCompanyRoadmapJobfairDivide;


/**
 * @Author : 신동철
 * @Date : 2018. 11. 29.
 * @Class 설명 : Soft Engineer Society 통합잡페어 채용기업 DAO
 * 
 */

@Repository
public class SocietyFapCompanyRoadmapDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyFapCompanyRoadmapDAO.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	/**
	 * 
	 * @Method Name : select_jobfair_now
	 * @Date : 2018. 12. 14.
	 * @User : 원병호
	 * @Param : 
	 * @Return : 현재 진행중인 잡페어 목록
	 * @Method 설명 :
	 */
	public ArrayList<SocietyFapCompanyRoadmapJobfair> select_jobfair_now(){
		logger.info("FAP 기업로드맵 현재진행중인 잡페어 불러오기 DAO 시작");
		SocietyFapCompanyRoadmapMapper sfcrMapper = sqlSession.getMapper(SocietyFapCompanyRoadmapMapper.class);
		ArrayList<SocietyFapCompanyRoadmapJobfair> result = null;
		result = sfcrMapper.select_jobfair_now();		
		logger.info("FAP 기업로드맵 현재진행중인 잡페어 불러오기 DAO 종료");
		return result;
	}
	
	/**
	 * 
	 * @Method Name : select_jobfair_before
	 * @Date : 2018. 12. 14.
	 * @User : 원병호
	 * @Param : 
	 * @Return : 시작전 잡페어 목록
	 * @Method 설명 :
	 */
	public ArrayList<SocietyFapCompanyRoadmapJobfair> select_jobfair_before(){
		logger.info("FAP 기업로드맵 시작전 잡페어 불러오기 DAO 시작");
		SocietyFapCompanyRoadmapMapper sfcrMapper = sqlSession.getMapper(SocietyFapCompanyRoadmapMapper.class);
		ArrayList<SocietyFapCompanyRoadmapJobfair> result = null;
		result = sfcrMapper.select_jobfair_before();			
		logger.info("FAP 기업로드맵 시작전 잡페어 불러오기 DAO 종료");
		return result;
	}
	
	/**
	 * 
	 * @Method Name : select_jobfair_after
	 * @Date : 2018. 12. 14.
	 * @User : 원병호
	 * @Param : 
	 * @Return : 끝난 잡페어 목록
	 * @Method 설명 :
	 */
	public ArrayList<SocietyFapCompanyRoadmapJobfair> select_jobfair_after(){
		logger.info("FAP 기업로드맵 끝난 잡페어 불러오기 DAO 시작");
		SocietyFapCompanyRoadmapMapper sfcrMapper = sqlSession.getMapper(SocietyFapCompanyRoadmapMapper.class);
		ArrayList<SocietyFapCompanyRoadmapJobfair> result = null;
		result = sfcrMapper.select_jobfair_after();
		logger.info("FAP 기업로드맵 끝난 잡페어 불러오기 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_jobfair_divide
	 * @Date : 2018. 12. 20.
	 * @User : 원병호
	 * @Param : fap_jobfair_seq
	 * @Return : SocietyFapCompanyRoadmapJobfairDivide 객체
	 * @Method 설명 : fap_jobfair_seq로 잡페어 세부정보 가져오기
	 */
	public ArrayList<SocietyFapCompanyRoadmapJobfairDivide> select_jobfair_divide(HashMap<String, Object> params){
		logger.info("FAP 기업로드맵 잡페어 세부 불러오기 DAO 시작");
		SocietyFapCompanyRoadmapMapper sfcrMapper = sqlSession.getMapper(SocietyFapCompanyRoadmapMapper.class);
		
		ArrayList<SocietyFapCompanyRoadmapJobfairDivide> result = sfcrMapper.select_jobfair_divide(params);
		
		return result;
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
		SocietyFapCompanyRoadmapMapper sfcrMapper = sqlSession.getMapper(SocietyFapCompanyRoadmapMapper.class);
		ArrayList<SocietyFapJobAd> result = sfcrMapper.select_job_ad_title_list(params);
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
	public ArrayList<SocietyFapJobRecruitPcs> select_job_recruit_pcs(HashMap<String, Object> map){
		SocietyFapCompanyRoadmapMapper sfcrMapper = sqlSession.getMapper(SocietyFapCompanyRoadmapMapper.class);
		
		logger.info("dao, param : {}", map);
		ArrayList<SocietyFapJobRecruitPcs> result = sfcrMapper.select_job_recruit_pcs(map);
		return result;
	}
	
	/**
	 * @Method Name : select_comp_user_connect
	 * @Date : 2018. 12. 27.
	 * @User : 원병호
	 * @Param : user_id
	 * @Return : hashmap (user_id, fap_comp_user_connect_ck, fap_comp_id)
	 * @Method 설명 : 아이디로 회사아이디와 승인상태를 가져오는 DAO 함수
	 */
	public HashMap<String, Object> select_comp_user_connect (String user_id){
		SocietyFapCompanyRoadmapMapper sfcrMapper = sqlSession.getMapper(SocietyFapCompanyRoadmapMapper.class);
		HashMap<String, Object> result = sfcrMapper.select_comp_user_connect(user_id);
		return result;
	}
	
	/**
	 * @Method Name : select_jobfair_comp
	 * @Date : 2018. 12. 28.
	 * @User : 원병호
	 * @Param : hashmap(fap_jobfair_divide_seq, fap_comp_id)
	 * @Return : hashmap (fap_jobfair_comp_seq, fap_jobfair_divide_seq, fap_jobfair_seq
    						, fap_comp_id, fap_jobfair_comp_gu)
	 * @Method 설명 : 회사 잡페어 등록정보
	 */
	public HashMap<String, Object> select_jobfair_comp (HashMap<String, Object> map){
		SocietyFapCompanyRoadmapMapper sfcrMapper = sqlSession.getMapper(SocietyFapCompanyRoadmapMapper.class);
			HashMap<String, Object> result = sfcrMapper.select_jobfair_comp(map);
		return result;
	}
	
	
	/**
	 * @Method Name : select_jobfair_start
	 * @Date : 2018. 12. 31.
	 * @User : 원병호
	 * @Param : fap_jobfair_divide_seq
	 * @Return : hashmap (is_start, is_end ; 0:true, 1:false)
	 * @Method 설명 : 해당 세부 잡페어의 신청 가능 여부
	 */
	public HashMap<String, Object> select_jobfair_start (int fap_jobfair_divide_seq){
		SocietyFapCompanyRoadmapMapper sfcrMapper = sqlSession.getMapper(SocietyFapCompanyRoadmapMapper.class);
		HashMap<String, Object> result = sfcrMapper.select_jobfair_start(fap_jobfair_divide_seq);
	return result;
	}
	
	/*
	 * @Method Name : select_job_ad
	 * @Date : 2018. 12. 31.
	 * @User : 원병호
	 * @Param : HashMap (fap_comp_id, fap_jobfair_divide_seq)
	 * @Return : SocietyFapJobAd
	 * @Method 설명 : 채용공고 정보
	 */
	public SocietyFapJobAd  select_job_ad (HashMap<String, Object> map){
		SocietyFapCompanyRoadmapMapper sfcrMapper = sqlSession.getMapper(SocietyFapCompanyRoadmapMapper.class);
		SocietyFapJobAd result = sfcrMapper.select_job_ad(map);
	return result;
	}
	
	/*
	 * @Method Name : select_job_recruit_sch
	 * @Date : 2019. 1. 2.
	 * @User : 원병호
	 * @Param : fap_job_ad_seq
	 * @Return : HashMap (fap_job_recruit_pcs_sch 객체 + is_start, is_end:전형이 시작됐는지 판단하는 값)
	 * @Method 설명 :
	 */
	public ArrayList<HashMap<String, Object>> select_job_recruit_sch(int fap_job_ad_seq){
		SocietyFapCompanyRoadmapMapper sfcrMapper = sqlSession.getMapper(SocietyFapCompanyRoadmapMapper.class);
		ArrayList<HashMap<String, Object>> result = sfcrMapper.select_job_recruit_pcs_sch(fap_job_ad_seq);
		return result;
	}
	
}
