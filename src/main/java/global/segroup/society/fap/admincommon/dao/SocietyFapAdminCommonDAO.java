/**
 * 
 */
package global.segroup.society.fap.admincommon.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import global.segroup.domain.BoardContent;
import global.segroup.domain.BoardFile;
import global.segroup.domain.BoardGroup;
import global.segroup.domain.FaqConsultingContents;
import global.segroup.domain.User;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminFaqGb;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminFinalDecisionTime;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfair;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairApply;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairCompGroup;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairDivide;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairDivideRc;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairLo;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairSet;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairSetDate;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairSetTime;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminLimitInterview;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminNoticeAlim;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminNoticeContent;
import global.segroup.society.fap.admincommon.domain.SocietyFapJobRecruitPcsSch;
import global.segroup.society.fap.admincommon.domain.SocietyFapJobfairApplicableTime;
import global.segroup.society.fap.admincommon.domain.SocietyFapMainpageContent;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenJobInfo;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenPt;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenPtResume;
import global.segroup.society.fap.admincommon.domain.SocietyFapPerJobfairDivideTemp;
import global.segroup.society.fap.admincommon.domain.SocietyFapPerJobfairTempGroup;
import global.segroup.society.fap.admincommon.domain.SocietyFapPopup;
import global.segroup.society.fap.company.dao.SocietyFapCompanyMapper;
import global.segroup.society.fap.company.domain.SocietyFapCompanyUser;
import global.segroup.society.fap.company.domain.SocietyFapJobAd;
import global.segroup.society.fap.company.domain.SocietyFapJobAdShow;
import global.segroup.society.fap.company.domain.SocietyFapJobExam;
import global.segroup.society.fap.company.domain.SocietyFapJobExamFile;
import global.segroup.society.fap.company.domain.SocietyFapJobExamNeedEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobExamObjEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobExamSvEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobExamType;
import global.segroup.society.fap.company.domain.SocietyFapJobItv;
import global.segroup.society.fap.company.domain.SocietyFapJobItvObjEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobItvTpEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobRecruitPcs;
import global.segroup.society.fap.company.domain.SocietyFapJobTestEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobTestEtcObj;
import global.segroup.society.fap.companyroadmap.domain.SocietyFapCompanyRoadmapJobfairDivide;
import global.segroup.society.fap.user.domain.SocietyFapPersonalGraduate;
import global.segroup.society.fap.user.domain.SocietyFapPersonalHighschool;
import global.segroup.society.fap.user.domain.SocietyFapPersonalUniversity;
import global.segroup.society.fap.user.domain.SocietyFapPersonalUser;
import global.segroup.society.fap.user.domain.SocietyFapUserApplyNumbers;
import global.segroup.util.PageNavigator;


/**
 * @Author : 신동철
 * @Date : 2018. 11. 29.
 * @Class 설명 : Soft Engineer Society 통합잡페어 관리자 DAO
 * 
 */

@Repository
public class SocietyFapAdminCommonDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyFapAdminCommonDAO.class);
	
	@Autowired
	private SqlSession sqlSession;
		
	
	/**
	 * @Method Name : insert_fap_jobfair
	 * @Date : 2018. 12. 11.
	 * @User : 신동철
	 * @Param : 잡페어 객체
	 * @Return : -
	 * @Method 설명 : 통합잡페어 정보 등록
	 */
	public void insert_jobfair (SocietyFapAdminJobfair sfaJobfair){
		logger.info("FAP 잡페어 등록 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.insert_jobfair(sfaJobfair);
		
		logger.info("FAP 잡페어 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : insert_fap_jobfair_lo
	 * @Date : 2018. 12. 11.
	 * @User : 신동철
	 * @Param : 잡페어 개최지 리스트
	 * @Return : -
	 * @Method 설명 : 통합잡페어 개최지 등록
	 */
	public void insert_jobfair_lo (ArrayList<SocietyFapAdminJobfairLo> sfaJobfairLoList){
		logger.info("FAP 잡페어 개최지 등록 DAO 시작");
			
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.insert_jobfair_lo(sfaJobfairLoList);
		
		logger.info("FAP 잡페어 개최지 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : insert_fap_jobfair_divide
	 * @Date : 2018. 12. 11.
	 * @User : 신동철
	 * @Param : 잡페어 세부정보 리스트
	 * @Return : -
	 * @Method 설명 : 통합잡페어 세부정보 등록
	 */
	public void insert_jobfair_divide (SocietyFapAdminJobfairDivide sfaJobfairDivide){
		logger.info("FAP 잡페어 세부정보 등록 DAO 시작");
			
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.insert_jobfair_divide(sfaJobfairDivide);
		
		logger.info("FAP 잡페어 세부정보 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : insert_fap_jobfair_divide_rc
	 * @Date : 2018. 12. 11.
	 * @User : 신동철
	 * @Param : 잡페어 세부채용대상 리스트
	 * @Return : -
	 * @Method 설명 : 통합잡페어 세부채용대상 등록
	 */
	public void insert_jobfair_divide_rc (ArrayList<SocietyFapAdminJobfairDivideRc> sfaJobfairDivideRcList){
		logger.info("FAP 잡페어 세부채용대상 등록 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.insert_jobfair_divide_rc(sfaJobfairDivideRcList);
		
		logger.info("FAP 잡페어 세부채용대상 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : select_fap_jobfair_info
	 * @Date : 2018. 12. 13.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 선택한 잡페어 전체 리스트
	 * @Method 설명 : 선택한 잡페어 전체 리스트 검색
	 */
	public HashMap<String, Object> select_fap_jobfair_info(int fap_jobfair_seq){
		logger.debug("통합잡페어 정보 검색 DAO 시작");
		HashMap<String, Object> resultMap = null;
		try{
			SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
			resultMap = sfaMapper.select_fap_jobfair_info(fap_jobfair_seq);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		logger.debug("통합잡페어 정보 검색 DAO 종료");
		return resultMap;
	}
	
	/**
	 * @Method Name : jobfair_search_list
	 * @Date : 2018. 12. 14.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 통합잡페어 정보 리스트
	 * @Method 설명 : 통합잡페어 정보 리스트 검색
	 */
	public ArrayList<SocietyFapAdminJobfair> jobfair_search_list(HashMap<String, Object>hashmap){
		logger.debug("통합잡페어 정보 리스트 검색 DAO 시작");
		ArrayList<SocietyFapAdminJobfair> jobfair_search_list = null;		
		try{
			SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
			jobfair_search_list = sfaMapper.jobfair_search_list(hashmap);
		}catch(Exception e){
			e.printStackTrace();
		}		
		logger.debug("통합잡페어 정보 리스트 검색 DAO 종료");
		return jobfair_search_list;
	}
	
	/**
	 * @Method Name : select_fap_jobfair
	 * @Date : 2018. 12. 14.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 특정의 잡페어 정보
	 * @Method 설명 : 특정의 잡페어 정보 검색
	 */
	public SocietyFapAdminJobfair select_fap_jobfair(int fap_jobfair_seq){
		logger.debug("통합잡페어 정보 리스트 검색 DAO 시작");
		SocietyFapAdminJobfair select_fap_jobfair = null;
		try{
			SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
			select_fap_jobfair = sfaMapper.select_fap_jobfair(fap_jobfair_seq);
		}catch(Exception e){
			e.printStackTrace();
		}		
		logger.debug("통합잡페어 정보 리스트 검색 DAO 종료");
		return select_fap_jobfair;
	}
	
	/**
	 * @Method Name : select_fap_jobfair_divide
	 * @Date : 2018. 12. 14.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 통합잡페어 세부정보 
	 * @Method 설명 : 통합잡페어 정보 검색
	 */
	public ArrayList<SocietyFapAdminJobfairDivide> select_fap_jobfair_divide(int fap_jobfair_seq){
		logger.debug("통합잡페어 세부정보 검색 DAO 시작");
		ArrayList<SocietyFapAdminJobfairDivide> select_fap_jobfair_divide = null;
		try{
			SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
			select_fap_jobfair_divide = sfaMapper.select_fap_jobfair_divide(fap_jobfair_seq);
		}catch(Exception e){
			e.printStackTrace();
		}		
		logger.debug("통합잡페어 세부정보 검색 DAO 종료");
		return select_fap_jobfair_divide;
	}
	
	/**
	 * @Method Name : delete_fap_jobfair
	 * @Date : 2018. 12. 14.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 통합잡페어 세부정보 
	 * @Method 설명 : 통합잡페어 정보 검색
	 */
	public void delete_fap_jobfair(int fap_jobfair_seq){
		logger.debug("잡페어 삭제 DAO 시작");
		try{
			SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
			sfaMapper.delete_fap_jobfair(fap_jobfair_seq);
		}catch(Exception e){
			e.printStackTrace();
		}		
		logger.debug("잡페어 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : update_jobfair
	 * @Date : 2018. 12. 18.
	 * @User : 신동철
	 * @Param : 잡페어 객체
	 * @Return : -
	 * @Method 설명 : 통합잡페어 정보 수정
	 */
	public void update_jobfair (SocietyFapAdminJobfair sfaJobfair){
		logger.info("FAP 잡페어 수정 DAO 시작");
		
			SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
			sfaMapper.update_jobfair(sfaJobfair);
		
		logger.info("FAP 잡페어 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : update_jobfair_lo
	 * @Date : 2018. 12. 11.
	 * @User : 신동철
	 * @Param : 잡페어 개최지 리스트
	 * @Return : -
	 * @Method 설명 : 통합잡페어 개최지 수정
	 */
	public void update_jobfair_lo (ArrayList<SocietyFapAdminJobfairLo> sfaJobfairLoList){
		logger.info("FAP 잡페어 개최지 수정 DAO 시작");
			
			SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
			sfaMapper.update_jobfair_lo(sfaJobfairLoList);
		
		logger.info("FAP 잡페어 개최지 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : update_jobfair_divide
	 * @Date : 2018. 12. 11.
	 * @User : 신동철
	 * @Param : 잡페어 세부정보 리스트
	 * @Return : -
	 * @Method 설명 : 통합잡페어 세부정보 수정
	 */
	public void update_jobfair_divide (SocietyFapAdminJobfairDivide sfaJobfairDivide){
		logger.info("FAP 잡페어 세부정보 수정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_jobfair_divide(sfaJobfairDivide);
		
		logger.info("FAP 잡페어 세부정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : update_jobfair_divide_rc
	 * @Date : 2018. 12. 11.
	 * @User : 신동철
	 * @Param : 잡페어 세부채용대상 리스트
	 * @Return : -
	 * @Method 설명 : 통합잡페어 세부채용대상 수정
	 */
	public void update_jobfair_divide_rc (ArrayList<SocietyFapAdminJobfairDivideRc> sfaJobfairDivideRcList){
		logger.info("FAP 잡페어 세부채용대상 수정 DAO 시작");
			
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_jobfair_divide_rc(sfaJobfairDivideRcList);
		
		logger.info("FAP 잡페어 세부채용대상 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : update_jobfair_unchecked_divide_rc
	 * @Date : 2018. 12. 11.
	 * @User : 신동철
	 * @Param : 잡페어 미선택 세부채용대상
	 * @Return : -
	 * @Method 설명 : 통합잡페어 미선택 세부채용대상 수정
	 */
	public void update_jobfair_unchecked_divide_rc(ArrayList<SocietyFapAdminJobfairDivideRc> sfaJobfairDivideRc){
		logger.info("FAP 잡페어 미선택 세부채용대상 수정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_jobfair_unchecked_divide_rc(sfaJobfairDivideRc);
		
		logger.info("FAP 잡페어 미선택 세부채용대상 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : search_jobfair_user_apply_info
	 * @Date : 2018. 12. 20.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 잡페어 지원자 등록정보
	 * @Method 설명 : 잡페어 지원자 등록정보 검색
	 */
	public ArrayList<HashMap<String, Object>> search_jobfair_user_apply_info(HashMap<String, Object> hashmap){
		logger.debug("잡페어 지원자 등록정보 검색 DAO 시작");
		ArrayList<HashMap<String, Object>> resultList = null;
		try{
			SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
			resultList = sfaMapper.search_jobfair_user_apply_info(hashmap);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		logger.debug("잡페어 지원자 등록정보 검색 DAO 종료");
		return resultList;
	}

	/**
	 * @Method Name : jobfair_user_apply_permission
	 * @Date : 2018. 12. 21.
	 * @User : 신동철
	 * @Param : 지원자 잡페어 신청 등록 시퀀스
	 * @Return : -
	 * @Method 설명 : 잡페어 지원자 신청 승인
	 */
	public void jobfair_user_apply_permission(ArrayList<SocietyFapAdminJobfairApply> sfaJobfairApplyList){
		logger.debug("잡페어 지원자 신청 승인 DAO 시작");
		try{
			SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
			sfaMapper.jobfair_user_apply_permission(sfaJobfairApplyList);
		}catch(Exception e){
			e.printStackTrace();
		}		
		logger.debug("잡페어 지원자 신청 승인 DAO 종료");
	}	
	
	/**
	 * @Method Name : insert_apply_max_num
	 * @Date : 2018. 12. 28.
	 * @User : 신동철
	 * @Param : 잡페어 객체
	 * @Return : -
	 * @Method 설명 : 잡페어 지원가능인원 등록
	 */
	public void insert_apply_max_num(SocietyFapAdminJobfair sfaJobfair){
		logger.debug("잡페어 지원가능인원 등록 DAO 시작");

		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.insert_apply_max_num(sfaJobfair);
	
		logger.debug("잡페어 지원가능인원 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : insert_limit_interview
	 * @Date : 2019. 7. 30.
	 * @User : 이종호
	 * @Param : 잡페어 현지면접 인원제한 정보
	 * @Return : -
	 * @Method 설명 : 잡페어 현지면접 인원제한 정보 등록
	 */
	public void insert_limit_interview(SocietyFapAdminLimitInterview limitInterview) {
		logger.info("잡페어 현지면접 인원제한 정보 등록 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.insert_limit_interview(limitInterview);
		
		logger.info("잡페어 현지면접 인원제한 정보 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : update_limit_interview
	 * @Date : 2019. 7. 30.
	 * @User : 이종호
	 * @Param : 잡페어 현지면접 인원제한 정보
	 * @Return : -
	 * @Method 설명 : 잡페어 현지면접 인원제한 정보 수정
	 */
	public void update_limit_interview(SocietyFapAdminLimitInterview limitInterview) {
		logger.info("잡페어 현지면접 인원제한 정보 수정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_limit_interview(limitInterview);
		
		logger.info("잡페어 현지면접 인원제한 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : update_apply_max_num
	 * @Date : 2018. 12. 28.
	 * @User : 신동철
	 * @Param : 잡페어 객체
	 * @Return : -
	 * @Method 설명 : 잡페어 지원가능인원 수정
	 */
	public void update_apply_max_num(SocietyFapAdminJobfair sfaJobfair){
		logger.debug("잡페어 지원가능인원 수정 DAO 시작");

		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_apply_max_num(sfaJobfair);

		logger.debug("잡페어 지원가능인원 수정 DAO 종료");
	}

	/**
	 * @Method Name : insert_comp_group_set
	 * @Date : 2018. 12. 30.
	 * @User : 신동철
	 * @Param : 회사그룹 설정 객체
	 * @Return : -
	 * @Method 설명 : 회사그룹 설정 등록
	 */
	public void insert_comp_group_set(ArrayList<SocietyFapAdminJobfairCompGroup> sfaCompGroupList){
		logger.info("FAP 회사그룹 설정 등록 DAO 시작");

		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.insert_comp_group_set(sfaCompGroupList);
	
		logger.info("FAP 회사그룹 설정 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : update_comp_group_set
	 * @Date : 2018. 12. 30.
	 * @User : 신동철
	 * @Param : 회사그룹 설정 객체
	 * @Return : -
	 * @Method 설명 : 회사그룹 설정 수정
	 */
	public void update_comp_group_set(ArrayList<SocietyFapAdminJobfairCompGroup> sfaJobfairCompGroupList){
		logger.info("FAP 회사그룹 설정 수정 DAO 시작");

		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_comp_group_set(sfaJobfairCompGroupList);
	
		logger.info("FAP 회사그룹 설정 수정 DAO 종료");	
	}
	
	/**
	 * @Method Name : delete_comp_group_set
	 * @Date : 2018. 12. 30.
	 * @User : 신동철
	 * @Param : 회사그룹 설정 객체
	 * @Return : -
	 * @Method 설명 : 회사그룹 설정 삭제
	 */
	public void delete_comp_group_set(int fap_jobfair_seq){
		logger.info("FAP 회사그룹 설정 삭제 DAO 시작");

		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.delete_comp_group_set(fap_jobfair_seq);
		
		logger.info("FAP 회사그룹 설정 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : delete_jobfair_lo
	 * @Date : 2018. 12. 30.
	 * @User : 신동철
	 * @Param : 잡페어 개최지 시퀀스
	 * @Return : -
	 * @Method 설명 : 잡페어 개최지 삭제
	 */
	public void delete_jobfair_lo(int fap_jobfair_lo_seq){
		logger.info("FAP 잡페어 개최지 삭제 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.delete_jobfair_lo(fap_jobfair_lo_seq);	
			
		logger.info("FAP 잡페어 개최지 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : delete_fap_jobfair_divide
	 * @Date : 2018. 12. 30.
	 * @User : 신동철
	 * @Param : 잡페어 세부정보 시퀀스
	 * @Return : -
	 * @Method 설명 : 잡페어 세부정보 삭제
	 */
	public void delete_fap_jobfair_divide(int fap_jobfair_divide_seq){
		logger.info("FAP 잡페어 채용대상 삭제 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.delete_fap_jobfair_divide(fap_jobfair_divide_seq);	
		
		logger.info("FAP 잡페어 채용대상 삭제 DAO 종료");
		
	}
	
	/**
	 * @Method Name : delete_fap_jobfair_divide_rc
	 * @Date : 2018. 12. 30.
	 * @User : 신동철
	 * @Param : 잡페어 세부채용대상 시퀀스
	 * @Return : -
	 * @Method 설명 : 잡페어 세부채용대상 삭제
	 */
	public void delete_fap_jobfair_divide_rc(int fap_jobfair_divide_rc_seq){
		logger.info("FAP 잡페어 채용대상 삭제 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.delete_fap_jobfair_divide_rc(fap_jobfair_divide_rc_seq);	
			
		logger.info("FAP 잡페어 채용대상 삭제 DAO 종료");
	}

	/**
	 * @Method Name : read_all_job_fair_ad_list
	 * @Date : 2018. 01. 02.
	 * @User : 남유송
	 * @Param : int
	 * @Return : HashMap
	 * @Method 설명 : 잡페어별 채용공고 리스트 출력
	 */
	public ArrayList<HashMap<String, Object>> select_jobfair_job_ad(HashMap<String, Object> params) {
		logger.info("잡페어별 채용공고 리스트 출력 컨트롤러 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> jobFairAdList = sfaMapper.select_jobfair_job_ad(params);
		logger.info("잡페어별 채용공고 리스트 출력 컨트롤러 종료");
		return jobFairAdList;
	}
	
	/**
	 * @Method Name : select_user_list
	 * @Date : 2019. 3. 4.
	 * @User : 정병준
	 * @Param : -
	 * @Return : 회원 리스트를 가져오는 함수
	 * @Method 설명 : 유저 리스트를 가져오는 함수
	 */
	public ArrayList<User> select_user_list(HashMap<String, Object> map){
		logger.info("FAP 회원 리스트 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<User> user_list = sfaMapper.select_user_list(map);
		logger.info("FAP 회원 리스트 가져오기 DAO 종료");
		return user_list;
	}
	
	/**
	 * @Method Name : select_user_list_count
	 * @Date : 2019. 3. 4.
	 * @User : 정병준
	 * @Param : -
	 * @Return : 회원 리스트의 개수를 가져오는 함수
	 * @Method 설명 : 유저 리스트의 개수를 가져오는 함수
	 */
	public int select_user_list_count(HashMap<String, Object> map){
		logger.info("FAP 회원 리스트 개수 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int result = sfaMapper.select_user_list_count(map);
		logger.info("FAP 회원 리스트 개수 가져오기 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_company_list
	 * @Date : 2019. 1. 2.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 기업 리스트를 가져오는 함수
	 * @Method 설명 : 기업 리스트를 가져오는 함수
	 */
	public ArrayList<SocietyFapCompanyUser> select_company_list(int start, int countPerPage, HashMap<String, Object> paramMap){
		logger.info("FAP 기업 리스트 가져오기 DAO 시작");
		RowBounds rb = new RowBounds(start, countPerPage);
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<SocietyFapCompanyUser> company_list = sfaMapper.select_company_list(rb, paramMap);
		logger.info("FAP 기업 리스트 가져오기 DAO 종료");
		return company_list;
	}

	/**
	 * @Method Name : applicant_list_per_job_ad
	 * @Date : 2018. 01. 03.
	 * @User : 남유송
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 지원자 리스트 출력 페이지 )
	 * @Method 설명 : 기업별 지원자 현황 페이지에서 채용공고별 지원자 리스트 출력 페이지
	 */
	public ArrayList<HashMap<String, Object>> select_applicant_list(int fap_job_ad_seq) {
		logger.info("채용공고별 지원자 리스트 출력 페이지 이동 컨트롤러 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> allApplicantList = sfaMapper.select_applicant_list(fap_job_ad_seq);
		logger.info("채용공고별 지원자 리스트 출력 페이지 이동 컨트롤러 종료");
		return allApplicantList;
	}

	/**
	 * @Method Name : select_personal_user
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 회원 아이디
	 * @Return : 공통 회원 객체, 개인 회원 객체
	 * @Method 설명 : 회원이 가지오 있는 개인 회원 정보를 가져오는 함수
	 */
	public HashMap<String, Object> select_personal_user(String user_id){
		logger.info("FAP 개인 유저 객체 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		HashMap<String, Object> user_info = sfaMapper.select_personal_user(user_id);
		logger.info("FAP 개인 유저 객체 가져오기 DAO 종료");
		return user_info;
	}
	
	/**
	 * @Method Name : select_personal_school
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 개인 회원 객체
	 * @Return : 회원 학교 정보 객체
	 * @Method 설명 : 개인 회원이 가지고 있는 학교 정보를 가져오는 함수
	 */
	public HashMap<String, Object> select_personal_school(HashMap<String, Object> hashMap){
		logger.info("FAP 개인 유저 학교 객체 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		HashMap<String, Object> user_school = sfaMapper.select_personal_school(hashMap);
		logger.info("FAP 개인 유저 학교 객체 가져오기 DAO 종료");
		return user_school;
	}
	
	/**
	 * @Method Name : personal_user_update
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 공통, 개인 회원 객체, 학교 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원 정보를 수정 하는 함수
	 */
	@Transactional
	public void porsonal_user_update(User user, SocietyFapPersonalUser sfpUser, 
			SocietyFapPersonalHighschool sfpHighschool, 
			SocietyFapPersonalUniversity sfpUniversity,
			SocietyFapPersonalGraduate sfpGraduate, String origin_level){
		logger.info("FAP 관리자 개인 회원 정보 수정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		// 회원 공통 테이블 수정
		sfaMapper.update_com_user(user);
		// 개인 회원 테이블 수정
		sfpUser.setFap_personal_user_udt_id(user.getUser_id());
		sfaMapper.update_personal_user(sfpUser);
		
		sfaMapper.delete_user_hs(sfpUser.getFap_personal_user_seq());
		sfaMapper.delete_user_univ(sfpUser.getFap_personal_user_seq());
		
		// 고등학교 정보 입력
		if(sfpUser.getFap_personal_user_edu_level().equals("B3300")){
			sfpHighschool.setFap_personal_user_seq(sfpUser.getFap_personal_user_seq());
			sfpHighschool.setFap_personal_hs_ins_id(user.getUser_id());
			sfpHighschool.setFap_personal_hs_udt_id(user.getUser_id());
			sfaMapper.insert_personal_hs(sfpHighschool);
		// 대학교 정보 입력
		} else if(sfpUser.getFap_personal_user_edu_level().equals("B3301") 
					|| sfpUser.getFap_personal_user_edu_level().equals("B3302")
					|| sfpUser.getFap_personal_user_edu_level().equals("B3304")
					|| sfpUser.getFap_personal_user_edu_level().equals("B3305")){
			sfpUniversity.setFap_personal_user_seq(sfpUser.getFap_personal_user_seq());
			sfpUniversity.setFap_personal_univ_ins_id(user.getUser_id());
			sfpUniversity.setFap_personal_univ_udt_id(user.getUser_id());
			sfaMapper.insert_personal_univ(sfpUniversity);
		// 대학교, 대학원 정보 입력
		} else if(sfpUser.getFap_personal_user_edu_level().equals("B3303")
					|| sfpUser.getFap_personal_user_edu_level().equals("B3306")){
			sfpUniversity.setFap_personal_user_seq(sfpUser.getFap_personal_user_seq());
			sfpUniversity.setFap_personal_univ_ins_id(user.getUser_id());
			sfpUniversity.setFap_personal_univ_udt_id(user.getUser_id());
			sfaMapper.insert_personal_univ(sfpUniversity);
			sfpGraduate.setFap_personal_univ_seq(sfpUniversity.getFap_personal_univ_seq());
			sfpGraduate.setFap_personal_grad_ins_id(user.getUser_id());
			sfpGraduate.setFap_personal_grad_udt_id(user.getUser_id());
			sfaMapper.insert_personal_grad(sfpGraduate);
		}
		
		logger.info("FAP 관리자 개인 회원 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : delete_user_info
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 탈퇴할 회원 객체
	 * @Return : -
	 * @Method 설명 : 회원 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(30글자) 변경후 참조 테이블에 적용
	 */
	public void delete_user_info(User user){
		logger.info("FAP 관리자 회원 탈퇴 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		// 중복되기 어려운 임의의값 생성
		long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmssSSS"); 
		String deleteUserId = user.getUser_id() + dayTime.format(new Date(time));
		
		// DB에 ID길이가 30이므로 넘을 시 잘라줌
		if(deleteUserId.length() >= 30) {
			deleteUserId = deleteUserId.substring(0, 30);
		}
		
		//변경할 데이터 맵
		HashMap<String, String> updateMap = new HashMap<>();
		
		updateMap.put("user_id", user.getUser_id());
		updateMap.put("user_state", "A0202");
		updateMap.put("user_delete_id", deleteUserId);
			
		// 회원 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(30글자) 변경
		sfaMapper.delete_user_info(updateMap);
		logger.info("FAP 관리자 회원 탈퇴 DAO 종료");
	}
	
	/**
	 * @Method Name : select_user
	 * @Date : 2019. 1. 3. 김준영
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 공통 유저 객체
	 * @Method 설명 : 공통 유저 객체를 불러오는 함수
	 */
	public User select_user(String user_id){
		logger.info("FAP 기업 담당자 정보 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		User user = sfaMapper.select_user(user_id);
		logger.info("FAP 기업 담당자 정보 가져오기 DAO 종료");
		return user;
	}
	
	/**
	 * @Method Name : update_user
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 공통 회원 객체
	 * @Return : -
	 * @Method 설명 : 공통 회원 정보를 수정하는 함수
	 */
	public void update_user(User user){
		logger.info("FAP 관리자 기업, 에이전시 관리자 정보 수정 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_user(user);
		logger.info("FAP 관리자 기업, 에이전시 관리자 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : select_company
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 기업 아이디
	 * @Return : 기업 객체
	 * @Method 설명 : 해당하는 아이디의 기업 정보를 가져오는 함수
	 */
	public SocietyFapCompanyUser select_company(String fap_comp_id){
		logger.info("FAP 관리자 기업 정보 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		SocietyFapCompanyUser company_info = sfaMapper.select_company(fap_comp_id);
		logger.info("FAP 관리자 기업 정보 가져오기 DAO 종료");
		return company_info;
	}
	
	/**
	 * @Method Name : update_company
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 기업 정보 객체
	 * @Return : -
	 * @Method 설명 : 기업 정보를 업데이트 하는 함수
	 */
	public void update_company(SocietyFapCompanyUser societyFapCompanyUser){
		logger.info("FAP 관리자 기업 정보 수정 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_company(societyFapCompanyUser);
		logger.info("FAP 관리자 기업 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : select_email
	 * @Date : 2019. 1. 15.
	 * @User : 전상수
	 * @Param : -
	 * @Return : DB에 저장되어있는 이메일 객체들
	 * @Method 설명 : 이메일 리스트를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_email(HashMap<String,String>data,PageNavigator pn){
		logger.info("FAP 관리자 메일정보 호출 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		RowBounds rb=new RowBounds(pn.getStartRecord(),pn.getCountPerPage());
		ArrayList<HashMap<String, Object>> mail_list=null;
		try{
		mail_list = sfaMapper.select_email(data,rb);
		}catch(Exception e){
			e.printStackTrace();
		}
		logger.info("FAP 관리자 메일정보 호출 DAO 종료");
		return mail_list;
	}
	/**
	 * @Method Name : select_email
	 * @Date : 2019. 1. 15.
	 * @User : 전상수
	 * @Param : -
	 * @Return : DB에 저장되어있는 이메일 객체들
	 * @Method 설명 : 이메일 리스트를 가져오는 함수
	 */
	public String select_email_content(String uid){
		logger.info("FAP 관리자 메일정보 호출 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		String result="";
		try{
			result = sfaMapper.select_email_content(uid);
		}catch(Exception e){
			e.printStackTrace();
		}
		logger.info("FAP 관리자 메일정보 호출 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_email_max_uid
	 * @Date : 2019. 1. 15.
	 * @User : 전상수
	 * @Param : -
	 * @Return : DB에 저장되어있는 이메일중 가장 최근의 것의 UID
	 * @Method 설명 : 이메일들중 가장 UID가 최근의 것을 가져오는 함수
	 */
	public HashMap<String, Object> select_email_max_uid(){
		HashMap<String, Object> max_mail;
		logger.info("FAP 관리자 max uid메일정보 호출 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		max_mail = sfaMapper.select_email_max_uid();
		logger.info("FAP 관리자 max uid메일정보 호출 DAO 종료");
		
		return max_mail;
	}
	
	/**
	 * @Method Name : select_email_max_uid
	 * @Date : 2019. 1. 15.
	 * @User : 전상수
	 * @Param : -
	 * @Return : DB에 저장되어있는 이메일중 가장 최근의 것의 UID
	 * @Method 설명 : 이메일들중 가장 UID가 최근의 것을 가져오는 함수
	 */
	public int select_count_email(HashMap<String,String>data){
		int result=0;
		logger.info("FAP 관리자 max uid메일정보 호출 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		result = sfaMapper.select_count_email(data);
		logger.info("FAP 관리자 max uid메일정보 호출 DAO 종료");
		
		return result;
	}
	
	/**
	 * @Method Name : insert_email
	 * @Date : 2019. 1. 15.
	 * @User : 전상수
	 * @Param : DB에 저장될 이메일 객체
	 * @Return : -
	 * @Method 설명 : 이메일을 DB에 등록하는 함수
	 */
	public void insert_email(ArrayList<HashMap<String, Object>> allMailList){
		logger.info("FAP 관리자 메일정보 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		
		try{
			for(HashMap<String, Object> mail:allMailList){
				sfaMapper.insert_email(mail);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		logger.info("FAP 관리자 메일정보 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : insert_jobfair_applicable_time
	 * @Date : 2019. 01. 03.
	 * @User : 신동철
	 * @Param : 채용공고 지원가능시간 정보
	 * @Return : -
	 * @Method 설명 : 취업지원자 채용공고 지원가능시간 등록
	 */
	public void insert_jobfair_applicable_time(List<SocietyFapJobfairApplicableTime> jobfair_applicable_time_list){
		logger.info("취업지원자 채용공고 지원가능시간 등록 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.insert_jobfair_applicable_time(jobfair_applicable_time_list);
		
		logger.info("취업지원자 채용공고 지원가능시간 등록 DAO 종료");		
	}
	
	/**
	 * @Method Name : comp_user_connect_tb
	 * @Date : 2019. 1. 4.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 담당자 - 기업 연결 객체
	 * @Method 설명 : 담당자 - 기업 연결 리스트를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_comp_user_connect(){
		logger.info("FAP 담당자 - 기업 연결 리스트 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> connect_list = sfaMapper.select_comp_user_connect();
		logger.info("FAP 담당자 - 기업 연결 리스트 가져오기 DAO 종료");
		return connect_list;
	}
	
	/**
	 * @Method Name : connect_update
	 * @Date : 2019. 1. 4.
	 * @User : 김준영
	 * @Param : 변경 리스트, 승인 상태
	 * @Return : -
	 * @Method 설명 : 선택한 리스트의 승인 상태를 바꿔주는 함수
	 */
	public void connect_update(HashMap<String, Object> hashMap){
		logger.info("FAP 관리자 담당자 - 기업 연결 승인 상태 변경 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.connect_update(hashMap);
		logger.info("FAP 관리자 담당자 - 기업 연결 승인 상태 변경 DAO 종료");
	}
	
	/**
	 * @Method Name : connect_all_update
	 * @Date : 2019. 1. 4.
	 * @User : 김준영
	 * @Param : 변경 대상 승인 상태, 변경 할 승인 상태
	 * @Return : -
	 * @Method 설명 : 변경 대상을 변경 할 승인 상태로 바꿔주는 함수
	 */
	public void connect_all_update(HashMap<String, Object> hashMap){
		logger.info("FAP 관리자 담당자 - 기업 연결 승인 상태 전부 변경 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.connect_all_update(hashMap);
		logger.info("FAP 관리자 담당자 - 기업 연결 승인 상태 전부 변경 DAO 종료");
	}
	
	/**
	 * @Method Name : connect_delete
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : 삭제 할 기업 - 담당자 연결 객체 seq
	 * @Return : -
	 * @Method 설명 : 기업 - 담당자 연결을 끊는 함수
	 */
	public void connect_delete(ArrayList<Integer> seq_list){
		logger.info("FAP 관리자 담당자 - 기업 연결 끊기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.connect_delete(seq_list);
		logger.info("FAP 관리자 담당자 - 기업 연결 끊기 DAO 종료");
	}
	
	/**
	 * @Method Name : update_jobfair_applicable_time
	 * @Date : 2019. 1. 4.
	 * @User : 신동철
	 * @Param : 취업지원자 채용공고 지원가능시간 정보
	 * @Return : -
	 * @Method 설명 : 취업지원자 채용공고 지원가능시간 수정
	 */
	public void update_jobfair_applicable_time(List<SocietyFapJobfairApplicableTime> jobfairApplicableTimeList){
		logger.info("FAP 취업지원자 채용공고 지원가능시간 수정 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_jobfair_applicable_time(jobfairApplicableTimeList);
		
		logger.info("FAP 취업지원자 채용공고 지원가능시간 수정 종료");
	}
	
	/**
	 * @Method Name : select_unconnect_user_list
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 유저 객체 리스트
	 * @Method 설명 : 기업과 연결 되지 않은 유저 객체 리스트를 가져오는 함수
	 */
	public ArrayList<User> select_unconnect_user_list(){
		logger.info("FAP 기업과 연결 되지 않은 유저 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<User> user = sfaMapper.select_unconnect_user_list();
		logger.info("FAP 기업과 연결 되지 않은 유저 가져오기 DAO 종료");
		return user;
	}
	
	/**
	 * @Method Name : select_connect_company
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 연결 할 기업 리스트
	 * @Method 설명 : 담당자와 연결할 기업 리스트를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_connect_company(){
		logger.info("FAP 담당자와 연결 할 기업 리스트 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> hashMap = sfaMapper.select_connect_company();
		logger.info("FAP 담당자와 연결 할 기업 리스트 가져오기 DAO 종료");
		return hashMap;
	}
	
	/**
	 * @Method Name : insert_comp_user_connect
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : 연결 할 유저 아이디 리스트, 연결 할 기업 아이디
	 * @Return : - 
	 * @Method 설명 : 기업 - 담당자 연결하는 함수
	 */
	public void insert_comp_user_connect(HashMap<String, Object> hashMap){
		logger.info("FAP 기업 - 담당자 연결 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.insert_comp_user_connect(hashMap);
		logger.info("FAP 기업 - 담당자 연결 DAO 종료");
	}
	
	/**
	 * @Method Name : select_ag_comp_connect
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트
	 * @Method 설명 : 에이전시 - 기업이 연결 되어있는 에이전시와 기업의 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_ag_comp_connect(){
		logger.info("FAP 에이전시 - 기업 연결 리스트 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> connect_list = sfaMapper.select_ag_comp_connect();
		logger.info("FAP 에이전시 - 기업 연결 리스트 가져오기 DAO 종료");
		return connect_list;
	}
	
	/**
	 * @Method Name : select_unconnect_comp_list
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 에이전시와 연결 되어 있지 않은 기업 리스트
	 * @Method 설명 : 에이전시와 연결 되어 있지 않은 기업 리스트를 가져오는 함수
	 * 				(연결 테이블에 값이 존재 하지 않는 기업만 가져옴; 대기, 거절 등의 기업은 관리에서 처리)
	 */
	public ArrayList<SocietyFapCompanyUser> select_unconnect_comp_list(int start, int countPerPage){
		logger.info("FAP 에이전시와 연결 되어 있지 않은 기업 리스트 가져오기 DAO 시작");
		RowBounds rb = new RowBounds(start, countPerPage);
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<SocietyFapCompanyUser> unconnect_comp_list = sfaMapper.select_unconnect_comp_list(rb);
		logger.info("FAP 에이전시와 연결 되어 있지 않은 기업 리스트 가져오기 DAO 종료");
		return unconnect_comp_list;
	}
	
	/**
	 * @Method Name : select_agency_list
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 일반기업을 제외한 에이전시 객체
	 * @Method 설명 : 기업 객체 중 일반 기업을 제외한 에이전시 객체 리스트를 가져오는 함수
	 */
	public ArrayList<SocietyFapCompanyUser> select_agency_list(int start, int countPerPage){
		logger.info("FAP 에이전시 리스트 가져오기 DAO 시작");
		RowBounds rb = new RowBounds(start, countPerPage);
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<SocietyFapCompanyUser> select_agency_list = sfaMapper.select_agency_list(rb);
		logger.info("FAP 에이전시 리스트 가져오기 DAO 종료");
		return select_agency_list;
	}
	
	/**
	 * @Method Name : connect_ag_comp
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : 연결 객체
	 * @Return : -
	 * @Method 설명 : 에이전시 - 기업을 연결 하는 함수
	 */
	public void connect_ag_comp(HashMap<String, Object> hashMap){
		logger.info("FAP 에이전시 - 기업 연결 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.connect_ag_comp(hashMap);
		logger.info("FAP 에이전시 - 기업 연결 DAO 종료");
	}
	
	/**
	 * @Method Name : ag_comp_connect_delete
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : 에이전시 - 기업 연결 seq 리스트
	 * @Return : -
	 * @Method 설명 : 에이전시 - 기업 연결을 끊는 함수
	 */
	public void ag_comp_connect_delete(ArrayList<Integer> seq_list){
		logger.info("FAP 에이전시 - 기업 연결 끊기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.ag_comp_connect_delete(seq_list);
		logger.info("FAP 에이전시 - 기업 연결 끊기 DAO 종료");
	}

	/**
	 * @Method Name : ag_comp_connect_update
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : 에이전시 - 기업 연결 객체
	 * @Return : -
	 * @Method 설명 : 에이전시 - 기업 연결 객체의 승인 상태를 변경하는 함수
	 */
	public void ag_comp_connect_update(HashMap<String, Object> hashMap){
		logger.info("FAP 에이전시 - 기업 연결 승인 상태 변경 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.ag_comp_connect_update(hashMap);
		logger.info("FAP 에이전시 - 기업 연결 승인 상태 변경 DAO 종료");
	}
	
	/**
	 * @Method Name : select_uncertain_company
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 기업 객체
	 * @Method 설명 : 기업 - 유저 연결 객체가 없어 기업, 에이전시 구분이 모호한 기업 리스트를 가져오는 함수
	 */
	public ArrayList<SocietyFapCompanyUser> select_uncertain_company(int start, int countPerPage){
		logger.info("FAP 불분명한 기업 리스트 가져오기 DAO 시작");
		RowBounds rb = new RowBounds(start, countPerPage);
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<SocietyFapCompanyUser> uncertain_company_list = sfaMapper.select_uncertain_company(rb);
		logger.info("FAP 불분명한 기업 리스트 가져오기 DAO 종료");
		return uncertain_company_list;
	}
	
	/**
	 * @Method Name : search_job_ad_info
	 * @Date : 2019. 1. 10.
	 * @User : 신동철
	 * @Param : 잡페어시퀀스, 잡페어세부 시퀀스, 채용전형 설정여부, 회사명
	 * @Return : 채용공고 정보
	 * @Method 설명 : 채용공고 정보 검색
	 */
	public ArrayList<HashMap<String, Object>> search_job_ad_info(HashMap<String, Object> hashmap){
		logger.info("채용공고 정보 검색 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> job_ad_info_list = sfaMapper.search_job_ad_info(hashmap);
		
		logger.info("채용공고 정보 검색 DAO 종료");
		return job_ad_info_list;
	}
	
	/**
	 * @Method Name : search_recruit_process_info
	 * @Date : 2019. 1. 10.
	 * @User : 신동철
	 * @Param : 잡페어시퀀스, 잡페어세부 시퀀스, 채용전형 설정여부, 회사명
	 * @Return : 채용전형 정보
	 * @Method 설명 : 채용전형 정보 검색
	 */
	public ArrayList<HashMap<String, Object>> search_recruit_process_info(HashMap<String, Object> hashmap){
		logger.info("채용전형 정보 검색 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> recruit_process_info_list = sfaMapper.search_recruit_process_info(hashmap);
		
		logger.info("채용전형 정보 검색 DAO 종료");
		return recruit_process_info_list;
	}
	
	/**
	 * @Method Name : select_review_pcs
	 * @Date : 2019. 1. 12.
	 * @User : 신동철
	 * @Param : 서류전형 스케줄 시퀀스
	 * @Return : 서류전형 정보
	 * @Method 설명 : 서류전형 정보 검색
	 */
	public HashMap<String, Object> select_review_pcs(long fap_job_recruit_pcs_seq){
		logger.info("서류전형 정보 검색 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		HashMap<String, Object> review_pcs_info = sfaMapper.select_review_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("서류전형 정보 검색 DAO 종료");
		return review_pcs_info;
	}
	
	/**
	 * @Method Name : select_exam_pcs
	 * @Date : 2019. 1. 12.
	 * @User : 신동철
	 * @Param : 시험전형 스케줄 시퀀스
	 * @Return : 시험전형 정보
	 * @Method 설명 : 시험전형 정보 검색
	 */
	public HashMap<String, Object> select_exam_pcs(long fap_job_recruit_pcs_seq){
		logger.info("시험전형 정보 검색 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		HashMap<String, Object> exam_pcs_info = sfaMapper.select_exam_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("시험전형 정보 검색 DAO 종료");
		return exam_pcs_info;
	}
	
	/**
	 * @Method Name : select_itv_pcs
	 * @Date : 2019. 1. 12.
	 * @User : 신동철
	 * @Param : 면접전형 시퀀스
	 * @Return : 면접전형 정보
	 * @Method 설명 : 면접전형 정보 검색
	 */
	public HashMap<String, Object> select_itv_pcs(long fap_job_recruit_pcs_seq){
		logger.info("면접전형 정보 검색 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		HashMap<String, Object> itv_pcs_info = sfaMapper.select_itv_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("면접전형 정보 검색 DAO 종료");
		return itv_pcs_info;
	}
	
	/**
	 * @Method Name : select_test_etc_pcs
	 * @Date : 2019. 1. 12.
	 * @User : 신동철
	 * @Param : 기타전형 시퀀스
	 * @Return : 기타전형 정보
	 * @Method 설명 : 기타전형 정보 검색
	 */
	public HashMap<String, Object> select_test_etc_pcs(long fap_job_recruit_pcs_seq){
		logger.info("기타전형 정보 검색 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		HashMap<String, Object> test_etc_pcs_info = sfaMapper.select_test_etc_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("기타전형 정보 검색 DAO 종료");
		return test_etc_pcs_info;
	}
		
	/**
	 * @Method Name : update_review_process_schedule
	 * @Date : 2019. 1. 13.
	 * @User : 신동철
	 * @Param : 서류전형 정보
	 * @Return : -
	 * @Method 설명 : 서류전형 스케줄 설정
	 */
	public void update_review_process_schedule(SocietyFapJobRecruitPcsSch review_process_schedule){
		logger.info("서류전형 스케줄 설정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_review_process_schedule(review_process_schedule);
		
		logger.info("서류전형 스케줄 설정 DAO 종료");
	}
	
	/**
	 * @Method Name : update_exam_process_schedule
	 * @Date : 2019. 1. 13.
	 * @User : 신동철
	 * @Param : 시험전형 정보
	 * @Return : -
	 * @Method 설명 : 시험전형 스케줄 설정
	 */
	public void update_exam_process_schedule(SocietyFapJobRecruitPcsSch exam_process_schedule){
		logger.info("시험전형 스케줄 설정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_exam_process_schedule(exam_process_schedule);
		
		logger.info("시험전형 스케줄 설정 DAO 종료");
	}
	
	/**
	 * @Method Name : update_itv_process_schedule
	 * @Date : 2019. 1. 13.
	 * @User : 신동철
	 * @Param : 면접전형 정보
	 * @Return : -
	 * @Method 설명 : 면접전형 스케줄 설정
	 */
	public void update_itv_process_schedule(SocietyFapJobRecruitPcsSch itv_process_schedule){
		logger.info("면접전형 스케줄 설정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_itv_process_schedule(itv_process_schedule);
		
		logger.info("면접전형 스케줄 설정 DAO 종료");		
	}
	
	/**
	 * @Method Name : update_test_etc_process_schedule
	 * @Date : 2019. 1. 13.
	 * @User : 신동철
	 * @Param : 기타전형 정보
	 * @Return : -
	 * @Method 설명 : 기타전형 스케줄 설정
	 */
	public void update_test_etc_process_schedule(SocietyFapJobRecruitPcsSch test_etc_process_schedule){
		logger.info("기타전형 스케줄 설정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_test_etc_process_schedule(test_etc_process_schedule);
		
		logger.info("기타전형 스케줄 설정 DAO 종료");		
	}
	
	/**
	 * @Method Name : update_review_process
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 서류전형 수정 정보
	 * @Return : -
	 * @Method 설명 : 서류전형 제출서류 목록 수정
	 */
	public void update_review_process(SocietyFapJobRecruitPcs review_process){
		logger.info("서류전형 수정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_review_process(review_process);
		
		logger.info("서류전형 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : update_exam_process
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 시험전형 수정 정보
	 * @Return : -
	 * @Method 설명 : 시험전형 목록 수정
	 */
	public void update_exam_process(SocietyFapJobExam exam_process){
		logger.info("시험전형 수정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_exam_process(exam_process);
		
		logger.info("시험전형 수정 DAO 종료");
	}
	
	
	/**
	 * @Method Name : update_exam_file
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 시험전형 시험문제파일 수정 정보
	 * @Return : -
	 * @Method 설명 : 시험전형 시험문제파일 수정
	 */
	public void update_exam_file(SocietyFapJobExamFile exam_file){
		logger.info("시험전형 시험문제파일 수정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_exam_file(exam_file);
		
		logger.info("시험전형 시험문제파일 수정 DAO 종료");		
	}
	
	/**
	 * @Method Name : update_exam_obj_etc
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 시험전형 시험대상자 수정 정보
	 * @Return : -
	 * @Method 설명 : 시험전형 시험대상자 수정
	 */
	public void update_exam_obj_etc(SocietyFapJobExamObjEtc exam_obj_etc){
		logger.info("시험전형 시험대상자 수정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_exam_obj_etc(exam_obj_etc);
		
		logger.info("시험전형 시험대상자 수정 DAO 종료");		
	}
	
	/**
	 * @Method Name : update_exam_sv_etc
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 시험전형 시험감독관 수정 정보
	 * @Return : -
	 * @Method 설명 : 시험전형 시험감독관 수정
	 */
	public void update_exam_sv_etc(SocietyFapJobExamSvEtc exam_sv_etc){
		logger.info("시험전형 시험감독관 수정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_exam_sv_etc(exam_sv_etc);
		
		logger.info("시험전형 시험감독관 수정 DAO 종료");	
	}
	
	/**
	 * @Method Name : update_exam_need_etc
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 시험전형 시험준비물 수정 정보
	 * @Return : -
	 * @Method 설명 : 시험전형 시험준비물 수정
	 */
	public void update_exam_need_etc(SocietyFapJobExamNeedEtc exam_need_etc){
		logger.info("시험전형 시험준비물 수정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_exam_need_etc(exam_need_etc);
		
		logger.info("시험전형 시험준비물 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : update_exam_type
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 시험전형 시험종류 수정 정보
	 * @Return : -
	 * @Method 설명 : 시험전형 시험종류 수정
	 */
	public void update_exam_type(SocietyFapJobExamType exam_type){
		logger.info("시험전형 시험종류 수정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_exam_type(exam_type);
		
		logger.info("시험전형 시험종류 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : update_itv_process
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 면접 채용전형 정보
	 * @Return : -
	 * @Method 설명 : 면접 채용전형 정보 수정
	 */
	public void update_itv_process(SocietyFapJobRecruitPcs itv_process){
		logger.info("면접 채용전형 정보수정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_itv_process(itv_process);
		
		logger.info("면접 채용전형 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : update_itv_process_info
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 면접 전형정보
	 * @Return : -
	 * @Method 설명 : 면접 전형정보 수정
	 */
	public void update_itv_process_info(SocietyFapJobItv itv_process_info){
		logger.info("면접 전형정보 수정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_itv_process_info(itv_process_info);
		
		logger.info("면접 전형정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : update_itv_tp_etc
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 면접 방식 정보
	 * @Return : -
	 * @Method 설명 : 면접 방식 정보 수정
	 */
	public void update_itv_tp_etc(SocietyFapJobItvTpEtc itv_tp_etc){
		logger.info("면접 방식 정보 수정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_itv_tp_etc(itv_tp_etc);
		
		logger.info("면접 방식 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : update_itv_obj_etc
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 면접 대상자 정보
	 * @Return : -
	 * @Method 설명 : 면접 대상자 정보 수정
	 */
	public void update_itv_obj_etc(SocietyFapJobItvObjEtc itv_obj_etc){
		logger.info("면접 대상자 정보 수정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_itv_obj_etc(itv_obj_etc);
		
		logger.info("면접 대상자 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : update_test_etc_info
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 기타면접 전형정보
	 * @Return : -
	 * @Method 설명 : 기타면접 전형정보 수정
	 */
	public void update_test_etc_info(SocietyFapJobTestEtc test_etc_info){
		logger.info("기타면접 전형정보 수정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_test_etc_info(test_etc_info);
		
		logger.info("기타면접 전형정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : update_test_etc_obj
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 기타면접 전형대상자
	 * @Return : -
	 * @Method 설명 : 기타면접 전형대상자 수정
	 */
	public void update_test_etc_obj(SocietyFapJobTestEtcObj test_etc_obj){
		logger.info("기타면접 전형대상자 수정 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_test_etc_obj(test_etc_obj);
		
		logger.info("기타면접 전형대상자 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : select_recruit_pcs_sch
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 전형일정 스케줄 검색 정보
	 * @Return : 전형일정 스케줄
	 * @Method 설명 : 전형일정 스케줄 검색
	 */
	public ArrayList<HashMap<String, Object>> select_recruit_pcs_sch(SocietyFapJobRecruitPcsSch recruit_pcs_sch){
		logger.info("전형일정 스케줄 검색 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> recruit_pcs_sch_list = sfaMapper.select_recruit_pcs_sch(recruit_pcs_sch);
		
		logger.info("전형일정 스케줄 검색 DAO 종료");
		return recruit_pcs_sch_list;
	}
	
	/**
	 * @Method Name : search_job_ad_jobfair_list
	 * @Date : 2019. 1. 18.
	 * @User : 신동철
	 * @Param : -
	 * @Method 설명 : 승인된 채용공고의 모든 잡페어 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> search_job_ad_jobfair_list(){
		logger.info("승인된 채용공고의 모든 잡페어 리스트 검색 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> job_ad_jobfair_list = sfaMapper.search_job_ad_jobfair_list();
		
		logger.info("승인된 채용공고의 모든 잡페어 리스트 검색 DAO 종료");
		return job_ad_jobfair_list;
	}
	
	/**
	 * @Method Name : search_job_ad_comp_list
	 * @Date : 2019. 1. 18.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 승인된 채용공고의 모든 회사 리스트
	 * @Method 설명 : 승인된 채용공고의 모든 회사 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> search_job_ad_comp_list(){
		logger.info("승인된 채용공고의 모든 회사 리스트 검색 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> job_ad_comp_list = sfaMapper.search_job_ad_comp_list();
		
		logger.info("승인된 채용공고의 모든 회사 리스트 검색 DAO 종료");
		return job_ad_comp_list;
	}
	
	/**
	 * @Method Name : search_job_ad_list
	 * @Date : 2019. 1. 18.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스, 잡페어세부 시퀀스, 회사 아이디
	 * @Return : 회사가 참가하여 승인받은 채용공고 리스트
	 * @Method 설명 : 회사가 참가하여 승인받은 채용공고 리스트 검색
	 */
	public ArrayList<SocietyFapJobAd> search_job_ad_list(SocietyFapJobAd jobAd){
		logger.info("회사가 참가하여 승인받은 채용공고 리스트 검색 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<SocietyFapJobAd> job_ad_list = sfaMapper.search_job_ad_list(jobAd);
		
		logger.info("회사가 참가하여 승인받은 채용공고 리스트 검색 DAO 종료");
		return job_ad_list;
	}
	
	/**
	 * @Method Name : select_job_ad_comp_list
	 * @Date : 2019. 1. 18.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스
	 * @Return : 해당 잡페어의 채용공고에 승인받은 회사 목록
	 * @Method 설명 : 해당잡페어의 채용공고에 승인받은 회사 목록 검색
	 */
	public ArrayList<HashMap<String, Object>> select_job_ad_comp_list(int fap_jobfair_seq){
		logger.info("해당 잡페어의 채용공고에 승인받은 회사 목록 검색 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> job_ad_comp_list = sfaMapper.select_job_ad_comp_list(fap_jobfair_seq);
		
		logger.info("해당 잡페어의 채용공고에 승인받은 회사 목록 검색 DAO 종료");
		return job_ad_comp_list;
	}
	
	/**
	 * @Method Name : applied_result_list
	 * @Date : 2018. 01. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : ArrayList
	 * @Method 설명 : 지원자별 전형 결과 가져오기
	 */
	public ArrayList<HashMap<String, Object>> select_applied_result(HashMap<String, Object> params) {
		logger.info("지원자별 전형 결과 출력 컨트롤러 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> applied_result_list=sfaMapper.select_applied_result(params);
		logger.info("지원자별 전형 결과 출력 컨트롤러 종료");
		return applied_result_list;
	}
	
	/**
	 * @Method Name : select_jobfair_apply_count
	 * @Date : 2019. 1. 21.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스, 회원타입, 승인여부, 지원자명
	 * @Return : 잡페어의 지원자 count
	 * @Method 설명 : 잡페어의 지원자 count 조회
	 */
	public int select_jobfair_apply_count(HashMap<String,Object> map){
		logger.info("잡페어의 지원자 count 조회 DAO 시작");
		
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int apply_count = sfaMapper.select_jobfair_apply_count(map);
		
		logger.info("잡페어의 지원자 count 조회 DAO 종료");
		return apply_count;
	}
	
	/**
	 * @Method Name : per_jobfair_temp_group_insert
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 잡페어별 임시 결제 그룹 정보, 세부잡페어별 임시 결제 정보
	 * @Return : -
	 * @Method 설명 : 잡페어별 임시 결제 그룹 정보 등록
	 */
	public void per_jobfair_temp_group_insert(SocietyFapPerJobfairTempGroup perGroup, SocietyFapPerJobfairDivideTemp divideTemp) {
		logger.debug("잡페어별 임시 결제 그룹 정보 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.per_jobfair_temp_group_insert(perGroup);
		
		for(SocietyFapPerJobfairDivideTemp divideList : divideTemp.getPerJobfairDivideList()) {
			divideList.setFap_per_jobfair_temp_group_seq(perGroup.getFap_per_jobfair_temp_group_seq());
		}
		
		sfaMapper.per_jobfair_divide_temp_insert(divideTemp);
		
		logger.debug("잡페어별 임시 결제 그룹 정보 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : per_jobfair_temp_group_search
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 임시 결제 그룹 정보
	 * @Method 설명 : 잡페어별 임시 결제 그룹 정보 검색
	 */
	public ArrayList<HashMap<String, Object>> per_jobfair_temp_group_search(int fap_jobfair_seq){
		logger.debug("잡페어별 임시 결제 그룹 정보 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		
		ArrayList<HashMap<String, Object>> result = sfaMapper.per_jobfair_temp_group_search(fap_jobfair_seq);
		
		logger.debug("잡페어별 임시 결제 그룹 정보 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : per_jobfair_temp_group_delete
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 잡페어별 임시 결제 그룹 정보 시퀀스
	 * @Return : -
	 * @Method 설명 : 잡페어별 임시 결제 그룹 정보 삭제
	 */
	public void per_jobfair_temp_group_delete(int fap_per_jobfair_temp_group_seq) {
		logger.debug("잡페어별 임시 결제 그룹 정보 삭제 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		
		sfaMapper.per_jobfair_temp_group_delete(fap_per_jobfair_temp_group_seq);
		
		logger.debug("잡페어별 임시 결제 그룹 정보 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : per_jobfair_temp_group_search_detail
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 잡페어별 임시 결제 그룹 정보 시퀀스
	 * @Return : 잡페어별 임시 결제 그룹 정보
	 * @Method 설명 : 잡페어별 임시 결제 그룹 정보 상세 검색
	 */
	public HashMap<String, Object> per_jobfair_temp_group_search_detail(SocietyFapPerJobfairTempGroup perGroup){
		logger.debug("잡페어별 임시 결제 그룹 정보 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		
		HashMap<String, Object> result = sfaMapper.per_jobfair_temp_group_search_detail(perGroup);
		
		logger.debug("잡페어별 임시 결제 그룹 정보 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : per_jobfair_temp_group_update
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 잡페어별 임시 결제 그룹 정보
	 * @Return : -
	 * @Method 설명 : 잡페어별 임시 결제 그룹 정보 수정
	 */
	public void per_jobfair_temp_group_update(SocietyFapPerJobfairTempGroup perGroup,SocietyFapPerJobfairDivideTemp divideTemp) {
		logger.debug("잡페어별 임시 결제 그룹 정보 수정 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.per_jobfair_temp_group_update(perGroup);
		
		sfaMapper.per_jobfair_divide_temp_delete(perGroup.getFap_per_jobfair_temp_group_seq());
		
		sfaMapper.per_jobfair_divide_temp_insert(divideTemp);
		
		logger.debug("잡페어별 임시 결제 그룹 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : select_comp_list_include_agency
	 * @Date : 2019. 1. 28.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 기업(에이전시 포함) 리스트 맵
	 * @Method 설명 : 기업(에이전시 포함) 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> select_comp_list_include_agency(int fap_jobfair_seq){
		logger.debug("기업(에이전시 포함) 리스트 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		
		ArrayList<HashMap<String, Object>> result = sfaMapper.select_comp_list_include_agency(fap_jobfair_seq);
		
		logger.debug("기업(에이전시 포함) 리스트 검색 DAO 종료");
		
		return result;
	}
	
	/**
	 * @Method Name : per_comp_temp_payment_update
	 * @Date : 2019. 2. 7.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 회사 결제정보 수정
	 * @Method 설명 : 잡페어별 회사 결제정보 수정
	 */
	public void per_comp_temp_payment_update(HashMap<String, Object> params) {
		logger.debug("잡페어별 회사 결제정보 수정 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		
		sfaMapper.per_comp_temp_payment_update(params);
		
		logger.debug("잡페어별 회사 결제정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : per_comp_temp_payment_insert
	 * @Date : 2019. 2. 7.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 회사 결제정보 등록
	 * @Method 설명 : 잡페어별 회사 결제정보 등록
	 */
	public void per_comp_temp_payment_insert(HashMap<String, Object> params) {
		logger.debug("잡페어별 회사 결제정보 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		
		sfaMapper.per_comp_temp_payment_insert(params);
		
		logger.debug("잡페어별 회사 결제정보 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : per_comp_temp_payment_delete
	 * @Date : 2019. 2. 7.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 회사 결제정보 삭제
	 * @Method 설명 : 잡페어별 회사 결제정보 삭제
	 */
	public void per_comp_temp_payment_delete(int fap_per_comp_temp_payment_seq) {
		logger.debug("잡페어별 회사 결제정보 삭제 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		
		sfaMapper.per_comp_temp_payment_delete(fap_per_comp_temp_payment_seq);
		
		logger.debug("잡페어별 회사 결제정보 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : search_approved_job_recruit_pcs
	 * @Date : 2019. 1. 30.
	 * @User : 원병호
	 * @Param : fap_job_ad_seq
	 * @Return : ArrayList<SocietyFapJobRecruitPcs>
	 * @Method 설명 : 해당 채용공고의 채용전형을 가져오는 함수
	 */
	public ArrayList<SocietyFapJobRecruitPcs> search_approved_job_recruit_pcs(long fap_job_ad_seq){
		logger.debug("관리자 승인된 채용전형 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		
		ArrayList<SocietyFapJobRecruitPcs> result = sfaMapper.search_approved_job_recruit_pcs(fap_job_ad_seq);
		
		logger.debug("관리자 승인된 채용전형 리스트 검색 DAO 종료");
		
		return result;
	}
	
	/**
	 * @Method Name : search_approved_review_pcs_date
	 * @Date : 2019. 1. 30.
	 * @User : 원병호
	 * @Param : fap_job_ad_seq
	 * @Return : SocietyFapJobfairApplicableTime 객체
	 * @Method 설명 : 해당 채용공고의 서류 마감일을 검색하는 함수
	 */
	public SocietyFapJobfairApplicableTime search_approved_review_pcs_date(long fap_job_ad_seq){
		logger.debug("관리자 해당 채용공고의 서류 마감일 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		
		SocietyFapJobfairApplicableTime result = sfaMapper.search_approved_review_pcs_date(fap_job_ad_seq);
		
		logger.debug("관리자 해당 채용공고의 서류 마감일 검색 종료");
		return result;
	}
	
	/**
	 * @Method Name : insert_approved_review_pcs
	 * @Date : 2019. 1. 30.
	 * @User : 원병호
	 * @Param : SocietyFapJobRecruitPcsSch
	 * @Return : 
	 * @Method 설명 : 채용전형 스케줄(서류전형) 등록
	 */
	public void insert_approved_review_pcs(SocietyFapJobRecruitPcsSch jobRecruitPcsSch){
		logger.debug("관리자 서류전형 스케줄 입력 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		
		sfaMapper.insert_approved_review_pcs(jobRecruitPcsSch);
		
		logger.debug("관리자 서류전형 스케줄 입력 DAO 종료");
	}
	
	/**
	 * @Method Name : insert_approved_recruit_pcs
	 * @Date : 2019. 1. 30.
	 * @User : 원병호
	 * @Param : SocietyFapJobRecruitPcsSch
	 * @Return : 
	 * @Method 설명 : 채용전형 스케줄(서류전형 제외) 등록
	 */
	public void insert_approved_recruit_pcs(SocietyFapJobRecruitPcsSch jobRecruitPcsSch){
		logger.debug("관리자 전형 스케줄 입력 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		
		sfaMapper.insert_approved_recruit_pcs(jobRecruitPcsSch);
		
		logger.debug("관리자 전형 스케줄 입력 DAO 종료");
	}
	
	
	/**
	 * @Method Name : select_job_recruit_pcs_sch_by_seq
	 * @Date : 2019. 1. 30.
	 * @User : Administrator
	 * @Param : fap_job_recruit_pcs_seq
	 * @Return : SocietyFapJobRecruitPcsSch
	 * @Method 설명 : 해당 seq의 SocietyFapJobRecruitPcsSch 객체 검색
	 */
	public SocietyFapJobRecruitPcsSch select_job_recruit_pcs_sch_by_seq(long fap_job_recruit_pcs_seq){
		logger.debug("관리자 특정 전형 스케줄 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		
		SocietyFapJobRecruitPcsSch result = sfaMapper.select_job_recruit_pcs_sch_by_seq(fap_job_recruit_pcs_seq);
		
		logger.debug("관리자 특정 전형 스케줄 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_connect_request
	 * @Date : 2019. 2. 7.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 기업 - 담당자 연결 요청 객체
	 * @Method 설명 : 기업 - 담당자 연결 요청 객체를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_connect_request(int start, int countPerPage){
		logger.info("FAP 기업 - 담당자 연결 요청 가져오기 DAO 시작");
		RowBounds rb = new RowBounds(start, countPerPage);
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> CompUserConnectRequest = sfaMapper.select_connect_request(rb);
		logger.info("FAP 기업 - 담당자 연결 요청 가져오기 DAO 종료");
		return CompUserConnectRequest;
	}
	
	/**
	 * @Method Name : delete_connect_request
	 * @Date : 2019. 2. 7.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : -
	 * @Method 설명 : 기업 - 담당자 연결 요청을 삭제하는 함수
	 */
	public void delete_connect_request(String user_id){
		logger.info("FAP 기업 - 담당자 연결 요청 삭제 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.delete_connect_request(user_id);
		logger.info("FAP 기업 - 담당자 연결 요청 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : delete_connect_request_seq
	 * @Date : 2019. 2. 8.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : -
	 * @Method 설명 : 기업 - 담당자 연결 요청을 삭제하는 함수
	 */
	public int delete_connect_request_seq(int fap_comp_user_request_seq){
		logger.info("FAP 기업 - 담당자 연결 요청 삭제 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int result = sfaMapper.delete_connect_request_seq(fap_comp_user_request_seq);
		logger.info("FAP 기업 - 담당자 연결 요청 삭제 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_user_list_paging_count
	 * @Date : 2019. 2. 11.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 회원 수
	 * @Method 설명 : 회원 리스트 총 개수를 불러오는 함수 
	 */
	public int select_user_list_paging_count(){
		logger.info("회원 리스트 총 개수 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int userTotalCount = sfaMapper.select_user_list_paging_count();
		logger.info("회원 리스트 총 개수 가져오기 DAO 종료");
		return userTotalCount;
	}
	
	/**
	 * @Method Name : select_company_list_paging_count
	 * @Date : 2019. 8. 2.
	 * @User : 김경아
	 * @Param : 검색 관련 정보
	 * @Return : 기업 수
	 * @Method 설명 : 기업 리스트 총 개수를 불러오는 함수 
	 */
	public int select_company_list_paging_count(HashMap<String, Object> paramMap){
		logger.info("기업 리스트 총 개수 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int companyTotalCount = sfaMapper.select_company_list_paging_count(paramMap);
		logger.info("기업 리스트 총 개수 가져오기 DAO 종료");
		return companyTotalCount;
	}
	
	/**
	 * @Method Name : select_fap_notice
	 * @Date : 2019. 2. 14.
	 * @User : 김준영
	 * @Param : -
	 * @Return : FAP 공지사항 hashmap 객체
	 * @Method 설명 : FAP 공지사항을 불러오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_fap_notice(){
		logger.info("FAP 공지사항 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> notice_list = sfaMapper.select_fap_notice();
		logger.info("FAP 공지사항 가져오기 DAO 종료");
		return notice_list;
	}
	
	/**
	 * @Method Name : select_standby_ag_comp_connect
	 * @Date : 2019. 2. 14.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 대기중인 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트
	 * @Method 설명 : 대기중인 에이전시 - 기업이 연결 되어있는 에이전시와 기업의 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_standby_ag_comp_connect_list(int start, int countPerPage){
		logger.info("FAP 대기중인 에이전시 - 기업 연결 리스트 가져오기 DAO 시작");
		RowBounds rb = new RowBounds(start, countPerPage);
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> select_standby_ag_comp_connect_list = sfaMapper.select_standby_ag_comp_connect_list(rb);
		logger.info("FAP 대기중인 에이전시 - 기업 연결 리스트 가져오기 DAO 종료");
		return select_standby_ag_comp_connect_list;
	}
	
	/**
	 * @Method Name : select_standby_ag_comp_connect_list_paging_count
	 * @Date : 2019. 2. 14.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 대기중인 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수를 불러오는 함수
	 * @Method 설명 : 대기중인 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수를 불러오는 함수
	 */
	public int select_standby_ag_comp_connect_list_paging_count(){
		logger.info("대기중인 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int standbyTotalCount = sfaMapper.select_standby_ag_comp_connect_list_paging_count();
		logger.info("대기중인 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수 가져오기 DAO 종료");
		return standbyTotalCount;
	}
	
	/**
	 * @Method Name : board_search_all_count
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 관리자 게시판의 모든 게시물 개수
	 * @Method 설명 : 관리자 게시판 진입 시 모든 게시물 개수 조회
	 */
	public int board_search_all_count(HashMap<String, Object> map){
		logger.debug("FAP 관리자 게시판 모든 게시물 개수 조회 DAO 함수 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int board_all_count = sfaMapper.board_search_all_count(map);
		logger.debug("FAP 관리자 게시판 모든 게시물 개수 조회 DAO 함수 종료");
		return board_all_count;
	}
	
	/**
	 * @Method Name : board_search_all
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 관리자 게시판의 모든 게시물
	 * @Method 설명 : 관리자 게시판 진입 시 모든 게시물 조회
	 */
	public ArrayList<BoardGroup> board_search_all(HashMap<String, Object> map){
		logger.debug("FAP 관리자 게시판 모든 게시물 조회 DAO 함수 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<BoardGroup> resultList = sfaMapper.board_search_all(map);
		logger.debug("FAP 관리자 게시판 모든 게시물 조회 DAO 함수 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : board_contents_search
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : 관리자 게시판 관리의 특정 게시판 정보 객체
	 * @Return : 관리자 게시판의 특정 게시판의 게시글 리스트
	 * @Method 설명 : 게시글 리스트를 가져오는 함수
	 */
	public ArrayList<HashMap<String,Object>> board_contents_search(HashMap<String, Object> map){
		logger.info("FAP 관리자 게시글 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String,Object>> board_list = sfaMapper.board_contents_search(map);
		logger.info("FAP 관리자 게시글 가져오기 DAO 종료");
		return board_list;
	}
	
	/**
	 * @Method Name : board_contents_count
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : 관리자 게시판 관리의 특정 게시판 정보 객체
	 * @Return : 관리자 게시판의 특정 게시판의 게시글 갯수
	 * @Method 설명 : 페이징을 위한 전체글 갯수 조회하는 함수
	 */
	public int board_contents_count(HashMap<String, Object> map){
		logger.info("FAP 관리자 게시글 갯수 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int count = sfaMapper.board_contents_count(map);
		logger.info("FAP 관리자 게시글 갯수 가져오기 DAO 종료");
		return count;
	}
	
	
	/**
	 * @Method Name : select_approval_ag_comp_connect
	 * @Date : 2019. 2. 15.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 승인받은 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트
	 * @Method 설명 : 승인받은 에이전시 - 기업이 연결 되어있는 에이전시와 기업의 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_approval_ag_comp_connect_list(int start, int countPerPage){
		logger.info("FAP 승인받은 에이전시 - 기업 연결 리스트 가져오기 DAO 시작");
		RowBounds rb = new RowBounds(start, countPerPage);
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> select_approval_ag_comp_connect_list = sfaMapper.select_approval_ag_comp_connect_list(rb);
		logger.info("FAP 승인받은 에이전시 - 기업 연결 리스트 가져오기 DAO 종료");
		return select_approval_ag_comp_connect_list;
	}
	
	/**
	 * @Method Name : select_approval_ag_comp_connect_list_paging_count
	 * @Date : 2019. 2. 15.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 승인받은 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수를 불러오는 함수
	 * @Method 설명 : 승인받은 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수를 불러오는 함수
	 */
	public int select_approval_ag_comp_connect_list_paging_count(){
		logger.info("승인받은 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int approvalTotalCount = sfaMapper.select_approval_ag_comp_connect_list_paging_count();
		logger.info("승인받은 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수 가져오기 DAO 종료");
		return approvalTotalCount;
	}
	
	/**
	 * @Method Name : select_unconnect_comp_list_paging_count
	 * @Date : 2019. 2. 15.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 에이전시에 연결 되어있지 않은 기업 리스트 총 개수를 불러오는 함수
	 * @Method 설명 : 에이전시에 연결 되어있지 않은 기업 리스트 총 개수를 불러오는 함수
	 */
	public int select_unconnect_comp_list_paging_count(){
		logger.info("에이전시에 연결 되어있지 않은 기업 리스트 총 개수 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int unconnectTotalCount = sfaMapper.select_unconnect_comp_list_paging_count();
		logger.info("에이전시에 연결 되어있지 않은 기업 리스트 총 개수 가져오기 DAO 종료");
		return unconnectTotalCount;
	}
	
	/**
	 * @Method Name : select_agency_list_paging_count
	 * @Date : 2019. 2. 15.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 기업에 연결 될 에이전시 리스트 총 개수를 불러오는 함수
	 * @Method 설명 : 기업에 연결 될 에이전시 리스트 총 개수를 불러오는 함수
	 */
	public int select_agency_list_paging_count(){
		logger.info("기업에 연결 될 에이전시 리스트 총 개수 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int agencyTotalCount = sfaMapper.select_agency_list_paging_count();
		logger.info("기업에 연결 될 에이전시 리스트 총 개수 가져오기 DAO 종료");
		return agencyTotalCount;
	}
	
	/**
	 * @Method Name : insert_board_content
	 * @Date : 2019. 2. 19.
	 * @User : 신동철
	 * @Param : 공지사항 내용
	 * @Return : -
	 * @Method 설명 : FAP 공지사항 등록 함수
	 */
	public int insert_board_content(BoardContent boardContent){
		logger.info("FAP 관리자 공지사항 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int result = sfaMapper.insert_board_content(boardContent);
		logger.info("FAP 관리자 공지사항 등록 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : insert_notice_content
	 * @Date : 2019. 2. 19.
	 * @User : 신동철
	 * @Param : 공지사항 부가내용
	 * @Return : -
	 * @Method 설명 : FAP 공지사항 부가내용 등록 함수
	 */
	public void insert_notice_content(SocietyFapAdminNoticeContent noticeContent){
		logger.info("FAP 관리자 공지사항 부가내용 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.insert_notice_content(noticeContent);
		logger.info("FAP 관리자 공지사항 부가내용 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : insert_board_file
	 * @Date : 2019. 2. 19.
	 * @User : 김준영
	 * @Param : 공통 게시물 파일 정보
	 * @Return : -
	 * @Method 설명 : 파일을 저장하는 함수
	 */
	public void insert_board_file(BoardFile boardFile){
		logger.info("FAP 관리자 공지사항 파일 저장 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.insert_board_file(boardFile);
		System.out.println(boardFile);
		logger.info("FAP 관리자 공지사항 파일 저장 DAO 시작");
	}
	
	/**
	 * @Method Name : delete_notice
	 * @Date : 2019. 2. 20.
	 * @User : 김준영
	 * @Param : 게시판 seq
	 * @Return : 삭제 여부
	 * @Method 설명 : 공지사항을 삭제하는 함수
	 */
	public int delete_notice(int board_content_seq){
		logger.info("FAP 공지사항 삭제 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int result = sfaMapper.delete_notice(board_content_seq);
		logger.info("FAP 공지사항 삭제 DAO 종료");
		return result;
	}
	
	
	/**
	 * @Method Name : search_jobfair_attended_comp_list
	 * @Date : 2019. 2. 21.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 잡페어 참가 기업 리스트
	 * @Method 설명 : 잡페어 참가 기업 리스트를 검색하는 함수
	 */
	public ArrayList<HashMap<String, Object>> search_jobfair_attended_comp_list(){
		logger.info("FAP 잡페어 참가 기업 리스트를 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> resultList = sfaMapper.search_jobfair_attended_comp_list();
		logger.info("FAP 잡페어 참가 기업 리스트를 검색 DAO 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : searched_jobfair_attended_comp_list
	 * @Date : 2019. 2. 21.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 잡페어별 참가 기업 리스트
	 * @Method 설명 : 잡페어별 참가 기업 리스트를 검색하는 함수
	 */
	public ArrayList<HashMap<String, Object>> searched_jobfair_attended_comp_list(HashMap<String, Object> hashmap){
		logger.info("FAP 잡페어별 참가 기업 리스트를 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> resultList = sfaMapper.searched_jobfair_attended_comp_list(hashmap);
		logger.info("FAP 잡페어별 참가 기업 리스트를 검색 DAO 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : select_refusal_ag_comp_connect
	 * @Date : 2019. 2. 20.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 거절한 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트
	 * @Method 설명 : 거절한 에이전시 - 기업이 연결 되어있는 에이전시와 기업의 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_refusal_ag_comp_connect_list(int start, int countPerPage){
		logger.info("FAP 거절한 에이전시 - 기업 연결 리스트 가져오기 DAO 시작");
		RowBounds rb = new RowBounds(start, countPerPage);
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> select_refusal_ag_comp_connect_list = sfaMapper.select_refusal_ag_comp_connect_list(rb);
		logger.info("FAP 거절한 에이전시 - 기업 연결 리스트 가져오기 DAO 종료");
		return select_refusal_ag_comp_connect_list;
	}
	
	/**
	 * @Method Name : select_refusal_ag_comp_connect_list_paging_count
	 * @Date : 2019. 2. 20.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 거절한 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수를 불러오는 함수
	 * @Method 설명 : 거절한 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수를 불러오는 함수
	 */
	public int select_refusal_ag_comp_connect_list_paging_count(){
		logger.info("거절한 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int refusalTotalCount = sfaMapper.select_refusal_ag_comp_connect_list_paging_count();
		logger.info("거절한 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수 가져오기 DAO 종료");
		return refusalTotalCount;
	}
	
	/**
	 * @Method Name : select_standby_comp_user_connect
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 대기중인 담당자 - 기업 연결 리스트
	 * @Method 설명 : 대기중인 담당자 - 기업 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_standby_comp_user_connect(int start, int countPerPage){
		logger.info("FAP 대기중인 담당자 - 기업 연결 리스트 가져오기 DAO 시작");
		RowBounds rb = new RowBounds(start, countPerPage);
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> select_standby_comp_user_connect = sfaMapper.select_standby_comp_user_connect(rb);
		logger.info("FAP 대기중인 담당자 - 기업 연결 리스트 가져오기 DAO 종료");
		return select_standby_comp_user_connect;
	}
	
	/**
	 * @Method Name : select_standby_comp_user_connect_list_paging_count
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 대기중인 담당자 - 기업 연결 리스트 총 개수를 불러오는 함수
	 * @Method 설명 : 대기중인 담당자 - 기업 연결 리스트 총 개수를 불러오는 함수
	 */
	public int select_standby_comp_user_connect_list_paging_count(){
		logger.info("대기중인 담당자 - 기업 연결 리스트 총 개수 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int userStandbyTotalCount = sfaMapper.select_standby_comp_user_connect_list_paging_count();
		logger.info("대기중인 담당자 - 기업 연결 리스트 총 개수 가져오기 DAO 종료");
		return userStandbyTotalCount;
	}
	
	/**
	 * @Method Name : select_approval_comp_user_connect
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 승인한 담당자 - 기업 연결 리스트
	 * @Method 설명 : 승인한 담당자 - 기업 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_approval_comp_user_connect(int start, int countPerPage){
		logger.info("FAP 승인한 담당자 - 기업 연결 리스트 가져오기 DAO 시작");
		RowBounds rb = new RowBounds(start, countPerPage);
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> select_approval_comp_user_connect = sfaMapper.select_approval_comp_user_connect(rb);
		logger.info("FAP 승인한 담당자 - 기업 연결 리스트 가져오기 DAO 종료");
		return select_approval_comp_user_connect;
	}
	
	/**
	 * @Method Name : select_approval_comp_user_connect_list_paging_count
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 승인한 담당자 - 기업 연결 리스트 총 개수를 불러오는 함수
	 * @Method 설명 : 승인한 담당자 - 기업 연결 리스트 총 개수를 불러오는 함수
	 */
	public int select_approval_comp_user_connect_list_paging_count(){
		logger.info("승인한 담당자 - 기업 연결 리스트 총 개수 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int userApprovalTotalCount = sfaMapper.select_approval_comp_user_connect_list_paging_count();
		logger.info("승인한 담당자 - 기업 연결 리스트 총 개수 가져오기 DAO 종료");
		return userApprovalTotalCount;
	}
	
	/**
	 * @Method Name : select_refusal_comp_user_connect
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 거절한 담당자 - 기업 연결 리스트
	 * @Method 설명 : 거절한 담당자 - 기업 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_refusal_comp_user_connect(int start, int countPerPage){
		logger.info("FAP 거절한 담당자 - 기업 연결 리스트 가져오기 DAO 시작");
		RowBounds rb = new RowBounds(start, countPerPage);
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> select_refusal_comp_user_connect = sfaMapper.select_refusal_comp_user_connect(rb);
		logger.info("FAP 거절한 담당자 - 기업 연결 리스트 가져오기 DAO 종료");
		return select_refusal_comp_user_connect;
	}
	
	/**
	 * @Method Name : select_refusal_comp_user_connect_list_paging_count
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 거절한 담당자 - 기업 연결 리스트 총 개수를 불러오는 함수
	 * @Method 설명 : 거절한 담당자 - 기업 연결 리스트 총 개수를 불러오는 함수
	 */
	public int select_refusal_comp_user_connect_list_paging_count(){
		logger.info("거절한 담당자 - 기업 연결 리스트 총 개수 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int userRefusalTotalCount = sfaMapper.select_refusal_comp_user_connect_list_paging_count();
		logger.info("거절한 담당자 - 기업 연결 리스트 총 개수 가져오기 DAO 종료");
		return userRefusalTotalCount;
	}
	
	/**
	 * @Method Name : select_uncertain_company_paging_count
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 연결 객체가 없어 불명확한 기업 리스트 개수를 불러오는 함수
	 * @Method 설명 : 연결 객체가 없어 불명확한 기업 리스트 개수를 불러오는 함수
	 */
	public int select_uncertain_company_paging_count(){
		logger.info("연결 객체가 없어 불명확한 기업 리스트 개수 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int uncertainTotalCount = sfaMapper.select_uncertain_company_paging_count();
		logger.info("연결 객체가 없어 불명확한 기업 리스트 개수 가져오기 DAO 종료");
		return uncertainTotalCount;
	}
	
	/**
	 * @Method Name : select_connect_request_paging_count
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 담당자 연결 요청 개수를 불러오는 함수
	 * @Method 설명 : 담당자 연결 요청 개수를 불러오는 함수
	 */
	public int select_connect_request_paging_count(){
		logger.info("담당자 연결 요청 개수 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int requestTotalCount = sfaMapper.select_connect_request_paging_count();
		logger.info("담당자 연결 요청 개수 가져오기 DAO 종료");
		return requestTotalCount;
	}
	
	/**
	 * @Method Name : select_unconnect_company_list
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 유저(기업) 객체 리스트
	 * @Method 설명 : 기업과 연결 되지 않은 유저(기업) 객체 리스트를 가져오는 함수
	 */
	public ArrayList<User> select_unconnect_company_list(int start, int countPerPage){
		logger.info("FAP 기업과 연결 되지 않은 유저(기업) 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		RowBounds rb = new RowBounds(start, countPerPage);
		ArrayList<User> company_user = sfaMapper.select_unconnect_company_list(rb);
		logger.info("FAP 기업과 연결 되지 않은 유저(기업) 가져오기 DAO 종료");
		return company_user;
	}
	
	/**
	 * @Method Name : select_unconnect_company_list_paging_count
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 유저(기업) 수
	 * @Method 설명 : 유저(기업) 수를 불러오는 함수
	 */
	public int select_unconnect_company_list_paging_count(){
		logger.info("유저(기업) 수 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int companyUserTotalCount = sfaMapper.select_unconnect_company_list_paging_count();
		logger.info("유저(기업) 수 가져오기 DAO 종료");
		return companyUserTotalCount;
	}
	
	/**
	 * @Method Name : select_unconnect_agency_list
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 유저(에이전시) 객체 리스트
	 * @Method 설명 : 기업과 연결 되지 않은 유저(에이전시) 객체 리스트를 가져오는 함수
	 */
	public ArrayList<User> select_unconnect_agency_list(int start, int countPerPage){
		logger.info("FAP 기업과 연결 되지 않은 유저(에이전시) 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		RowBounds rb = new RowBounds(start, countPerPage);
		ArrayList<User> agency_user = sfaMapper.select_unconnect_agency_list(rb);
		logger.info("FAP 기업과 연결 되지 않은 유저(에이전시) 가져오기 DAO 종료");
		return agency_user;
	}
	
	/**
	 * @Method Name : select_unconnect_agency_list_paging_count
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 유저(에이전시) 수
	 * @Method 설명 : 유저(에이전시) 수를 불러오는 함수
	 */
	public int select_unconnect_agency_list_paging_count(){
		logger.info("유저(에이전시) 수 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int agencyUserTotalCount = sfaMapper.select_unconnect_agency_list_paging_count();
		logger.info("유저(에이전시) 수 가져오기 DAO 종료");
		return agencyUserTotalCount;
	}
	
	/**
	 * @Method Name : select_connect_company_list
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 연결 할 기업 리스트
	 * @Method 설명 : 담당자와 연결할 기업 리스트를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_connect_company_list(int start, int countPerPage){
		logger.info("FAP 담당자와 연결 할 기업 리스트 가져오기 DAO 시작");
		RowBounds rb = new RowBounds(start, countPerPage);
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> select_connect_company_list = sfaMapper.select_connect_company_list(rb);
		logger.info("FAP 담당자와 연결 할 기업 리스트 가져오기 DAO 종료");
		return select_connect_company_list;
	}
	
	/**
	 * @Method Name : select_connect_company_list_paging_count
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 연결 할 기업 리스트 개수
	 * @Method 설명 : 담당자와 연결할 기업 리스트 개수를 가져오는 함수
	 */
	public int select_connect_company_list_paging_count(){
		logger.info("연결 할 기업 리스트 개수 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int companyListTotalCount = sfaMapper.select_connect_company_list_paging_count();
		logger.info("연결 할 기업 리스트 개수 가져오기 DAO 종료");
		return companyListTotalCount;
	}
	
	/**
	 * @Method Name : select_connect_agency_list
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 연결 할 기업 리스트
	 * @Method 설명 : 담당자와 연결할 기업 리스트를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_connect_agency_list(int start, int countPerPage){
		logger.info("FAP 담당자와 연결 할 에이전시 리스트 가져오기 DAO 시작");
		RowBounds rb = new RowBounds(start, countPerPage);
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> select_connect_agency_list = sfaMapper.select_connect_agency_list(rb);
		logger.info("FAP 담당자와 연결 할 에이전시 리스트 가져오기 DAO 종료");
		return select_connect_agency_list;
	}
	
	/**
	 * @Method Name : select_connect_agency_list_paging_count
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 연결 할 에이전시 리스트 개수
	 * @Method 설명 : 담당자와 연결할 에이전시 리스트 개수를 가져오는 함수
	 */
	public int select_connect_agency_list_paging_count(){
		logger.info("연결 할 에이전시 리스트 개수 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int agencyListTotalCount = sfaMapper.select_connect_agency_list_paging_count();
		logger.info("연결 할 에이전시 리스트 개수 가져오기 DAO 종료");
		return agencyListTotalCount;
	}
	
	/**
	 * @Method Name : select_jobfair_applicable_time
	 * @Date : 2019. 2. 21.
	 * @User : 원병호
	 * @Param : 잡페어 세부
	 * @Return : 
	 * @Method 설명 : 잡페어 지원가능 시간 정보 검색
	 */
	public ArrayList<HashMap<String, Object>> select_jobfair_applicable_time(int fap_jobfair_divide_seq){
		logger.info("FAP 잡페어 지원가능 시간 정보 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> result = sfaMapper.select_jobfair_applicable_time(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 지원가능 시간 정보 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_jobfair_applicable_time
	 * @Date : 2019. 2. 21.
	 * @User : 원병호
	 * @Param : 잡페어 세부
	 * @Return : 
	 * @Method 설명 : 잡페어 지원가능 시간 정보 검색
	 */
	public ArrayList<SocietyFapJobfairApplicableTime> select_jobfair_applicable_time_first(int fap_jobfair_divide_seq){
		logger.info("FAP 잡페어 지원가능 시간 정보 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<SocietyFapJobfairApplicableTime> result = sfaMapper.select_jobfair_applicable_time_first(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 지원가능 시간 정보 검색 종료");
		return result;
	}
	
	
	/**
	 * @Method Name : search_user_apply_numbers
	 * @Date : 2019. 2. 25.
	 * @User : 신동철
	 * @Param : 잡페어 세부 시퀀스
	 * @Return : 잡페어별 취업지원자 지망개수
	 * @Method 설명 : 잡페어별 취업지원자 지망개수 검색
	 */
	public ArrayList<HashMap<String, Object>> search_user_apply_numbers(int fap_jobfair_divide_seq){
		logger.info("FAP 잡페어별 취업지원자 지망개수 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> resultList = sfaMapper.search_user_apply_numbers(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어별 취업지원자 지망개수 검색 DAO 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : update_user_apply_numbers
	 * @Date : 2019. 2. 25.
	 * @User : 신동철
	 * @Param : 지원자 지망개수
	 * @Return : 잡페어별 취업지원자 지망개수 수정
	 * @Method 설명 : 잡페어별 취업지원자 지망개수 수정
	 */
	public void update_user_apply_numbers(ArrayList<SocietyFapUserApplyNumbers> newUserApplyNumbersList){
		logger.info("FAP 잡페어별 취업지원자 지망개수 수정 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_user_apply_numbers(newUserApplyNumbersList);
		logger.info("FAP 잡페어별 취업지원자 지망개수 수정 DAO 종료");
	}

	/**
	 * @Method Name : insert_jobfair_applicable_time_one
	 * @Date : 2019. 2. 27.
	 * @User : 원병호
	 * @Param : 잡페어 추가지원 객체
	 * @Return : 
	 * @Method 설명 : 잡페어 추가지원/미스매칭 등록
	 */
	public void insert_jobfair_applicable_time_one(SocietyFapJobfairApplicableTime jobfairApplicableTime){
		logger.info("FAP 관리자 잡페어 추가지원/미스매칭 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.insert_jobfair_applicable_time_one(jobfairApplicableTime);
		logger.info("FAP 관리자 잡페어 추가지원/미스매칭 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : update_jobfair_applicable_time_one
	 * @Date : 2019. 3. 4.
	 * @User : 원병호
	 * @Param : 잡페어 추가지원 객체
	 * @Return : 
	 * @Method 설명 : 잡페어 추가지원/미스매칭 수정
	 */
	public void update_jobfair_applicable_time_one(SocietyFapJobfairApplicableTime jobfairApplicableTime){
		logger.info("FAP 관리자 잡페어 추가지원/미스매칭 수정 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_jobfair_applicable_time_one(jobfairApplicableTime);
		logger.info("FAP 관리자 잡페어 추가지원/미스매칭 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : delete_jobfair_applicable_time
	 * @Date : 2019. 3. 4.
	 * @User : Administrator
	 * @Param : 잡페어 추가지원 일련번호
	 * @Return : 
	 * @Method 설명 : 잡페어 추가지원/미스매칭 수정 삭제
	 */
	public void delete_jobfair_applicable_time(int fap_jobfair_applicable_time_seq){
		logger.info("FAP 관리자 잡페어 추가지원/미스매칭 삭제 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.delete_jobfair_applicable_time(fap_jobfair_applicable_time_seq);
		logger.info("FAP 관리자 잡페어 추가지원/미스매칭 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : update_board_content
	 * @Date : 2019. 3. 5.
	 * @User : 신동철
	 * @Param : 공통게시판 게시물
	 * @Return : -
	 * @Method 설명 : 관리자 공통게시판 게시물 수정
	 */
	public int update_board_content(BoardContent boardContent){
		logger.info("FAP 관리자 공통게시판 게시물 수정 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int result = sfaMapper.update_board_content(boardContent);
		logger.info("FAP 관리자 공통게시판 게시물 수정 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : update_notice_content
	 * @Date : 2019. 3. 5.
	 * @User : 신동철
	 * @Param : 잡페어 공지사항
	 * @Return : -
	 * @Method 설명 : 잡페어 공지사항 수정
	 */
	public void update_notice_content(SocietyFapAdminNoticeContent noticeContent){
		logger.info("FAP 관리자 공지사항 수정 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.update_notice_content(noticeContent);
		logger.info("FAP 관리자 공지사항 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : delete_board_file
	 * @Date : 2019. 3. 5.
	 * @User : 신동철
	 * @Param : 잡페어 공지사항 파일 시퀀스
	 * @Return : -
	 * @Method 설명 : 잡페어 공지사항 파일 삭제
	 */
	public void delete_board_file(int board_file_seq){
		logger.info("FAP 잡페어 공지사항 파일 삭제 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.delete_board_file(board_file_seq);
		logger.info("FAP 잡페어 공지사항 파일 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : search_qna_comp
	 * @Date : 2019. 3. 6.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 채용공고 Q&A 기업명
	 * @Method 설명 : 채용공고 Q&A 기업명 검색
	 */
	public ArrayList<HashMap<String, Object>> search_qna_comp(){
		logger.info("FAP 잡페어 채용공고 Q&A 기업명 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> resultList = sfaMapper.search_qna_comp();
		logger.info("FAP 잡페어 채용공고 Q&A 기업명 검색 DAO 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : search_qna_job_ad
	 * @Date : 2019. 3. 6.
	 * @User : 신동철
	 * @Param : 채용기업 아이디
	 * @Return : 채용공고 Q&A 채용공고
	 * @Method 설명 : 채용공고 Q&A 채용공고 검색
	 */
	public ArrayList<HashMap<String, Object>> search_qna_job_ad(String fap_comp_id){
		logger.info("FAP 잡페어 채용공고 Q&A 채용공고 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> resultList = sfaMapper.search_qna_job_ad(fap_comp_id);		
		logger.info("FAP 잡페어 채용공고 Q&A 채용공고 검색 DAO 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : search_job_qna_question_info
	 * @Date : 2019. 3. 6.
	 * @User : 신동철
	 * @Param : 채용기업 아이디, 채용공고 시퀀스, 질문승인여부, 작성자 이름
	 * @Return : 채용공고 Q&A 질문 정보
	 * @Method 설명 : 채용공고 Q&A 질문 정보 검색 
	 */
	public ArrayList<HashMap<String, Object>> search_job_qna_question_info(HashMap<String, Object> hashmap){
		logger.info("FAP 잡페어 채용공고 Q&A 질문 정보 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> resultList = sfaMapper.search_job_qna_question_info(hashmap);		
		logger.info("FAP 잡페어 채용공고 Q&A 질문 정보 검색 DAO 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : jobfair_user_qna_permission
	 * @Date : 2019. 3. 7.
	 * @User : 신동철
	 * @Param : 질문 승인할 채용공고 Q&A질문일련번호
	 * @Return : -
	 * @Method 설명 : 채용공고 Q&A 질문 승인
	 */
	public void jobfair_user_qna_permission(List<Integer>fap_jobfair_user_qna_seq_list){
		logger.info("FAP 잡페어 채용공고 Q&A 질문 승인 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.jobfair_user_qna_permission(fap_jobfair_user_qna_seq_list);		
		logger.info("FAP 잡페어 채용공고 Q&A 질문 승인 DAO 종료");
	}
	
	/**
	 * @Method Name : jobfair_user_qna_nonpermission
	 * @Date : 2019. 3. 7.
	 * @User : 신동철
	 * @Param : 질문 미승인할 채용공고 Q&A질문일련번호
	 * @Return : -
	 * @Method 설명 : 채용공고 Q&A 질문 미승인
	 */
	public void jobfair_user_qna_nonpermission(List<Integer>fap_jobfair_user_qna_seq_list){
		logger.info("FAP 잡페어 채용공고 Q&A 질문 미승인 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.jobfair_user_qna_nonpermission(fap_jobfair_user_qna_seq_list);		
		logger.info("FAP 잡페어 채용공고 Q&A 질문 미승인 DAO 종료");
	}
	
	/**
	 * @Method Name : insert_qna_question_refuse_reason
	 * @Date : 2019. 3. 7.
	 * @User : 신동철
	 * @Param : Q&A질문일련번호, 미승인사유
	 * @Return : -
	 * @Method 설명 : 채용공고 Q&A 질문 미승인사유 등록
	 */
	public void insert_qna_question_refuse_reason(HashMap<String, Object> hashmap){
		logger.info("FAP 잡페어 채용공고 Q&A 질문 미승인사유 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.insert_qna_question_refuse_reason(hashmap);		
		logger.info("FAP 잡페어 채용공고 Q&A 질문 미승인사유 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : select_jobfair_divide_info
	 * @Date : 2019. 3. 12.
	 * @User : 신동철
	 * @Param : fap_jobfair_seq
	 * @Return : SocietyFapCompanyRoadmapJobfairDivide 객체
	 * @Method 설명 : fap_jobfair_seq로 잡페어 세부정보 가져오기
	 */
	public ArrayList<SocietyFapCompanyRoadmapJobfairDivide> select_jobfair_divide_info(HashMap<String, Object> params){
		logger.info("FAP 잡페어 세부 불러오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);		
		ArrayList<SocietyFapCompanyRoadmapJobfairDivide> result = sfaMapper.select_jobfair_divide_info(params);
		logger.info("FAP 잡페어 세부 불러오기 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : search_jobfair_divide_final_select_info
	 * @Date : 2019. 3. 14.
	 * @User : 신동철
	 * @Param : 잡페어 세부시퀀스
	 * @Return : 잡페어 세부별 최종합격자 결정 시한
	 * @Method 설명 : 잡페어 세부별 최종합격자 결정 시한 설정 정보 검색
	 */
	public HashMap<String, Object> search_jobfair_divide_final_select_info(int fap_jobfair_divide_seq){
		logger.info("FAP 잡페어 세부별 최종합격자 결정 시한 설정 정보 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);		
		HashMap<String, Object> hashmap = sfaMapper.search_jobfair_divide_final_select_info(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 세부별 최종합격자 결정 시한 설정 정보 검색 DAO 종료");
		return hashmap;
	}
	
	/**
	 * @Method Name : insert_fap_jobfair_divide_final_select
	 * @Date : 2019. 3. 14.
	 * @User : 신동철 
	 * @Param : 잡페어 세부 시퀀스, 최종합격 결정 시작일, 최종합격 결정 마감일
	 * @Return : -
	 * @Method 설명 : 잡페어 세부별 최종합격자 결정 시한 설정 등록
	 */
	public void insert_fap_jobfair_divide_final_select(HashMap<String, Object> hashmap){
		logger.info("FAP 잡페어 세부별 최종합격자 결정 시한 설정 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);		
		sfaMapper.insert_fap_jobfair_divide_final_select(hashmap);
		logger.info("FAP 잡페어 세부별 최종합격자 결정 시한 설정 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : final_decision_time_duplicate_check
	 * @Date : 2019. 3. 25.
	 * @User : 이종호
	 * @Param : 최종확정 기간정보
	 * @Return : -
	 * @Method 설명 : 최종확정 기간 중복 조회
	 */
	public int final_decision_time_duplicate_check(SocietyFapAdminFinalDecisionTime finalDecision) {
		logger.info("FAP 잡페어 최종확정 기간 중복 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int result = sfaMapper.final_decision_time_duplicate_check(finalDecision);
		logger.info("FAP 잡페어 최종확정 기간 중복 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : final_decision_time_insert
	 * @Date : 2019. 3. 21.
	 * @User : 이종호
	 * @Param : 최종확정 기간정보
	 * @Return : -
	 * @Method 설명 : 최종확정 기간 등록
	 */
	public void final_decision_time_insert(SocietyFapAdminFinalDecisionTime finalDecision) {
		logger.info("FAP 잡페어 최종확정 기간 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.final_decision_time_insert(finalDecision);
		logger.info("FAP 잡페어 최종확정 기간 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : final_decision_time_select
	 * @Date : 2019. 3. 21.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : -
	 * @Method 설명 : 세부 잡페어 별 최종확정 기간 조회
	 */
	public ArrayList<SocietyFapAdminFinalDecisionTime> final_decision_time_select(int fap_jobfair_divide_seq){
		logger.info("FAP 잡페어 최종확정 기간 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<SocietyFapAdminFinalDecisionTime> result = sfaMapper.final_decision_time_select(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 최종확정 기간 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : final_decision_time_delete
	 * @Date : 2019. 3. 25.
	 * @User : 이종호
	 * @Param : 최종확정 기간 시퀀스들
	 * @Return : -
	 * @Method 설명 : 세부 잡페어 별 최종확정 기간 삭제
	 */
	public void final_decision_time_delete(HashMap<String, Object> fap_jobfair_set_seq_map) {
		logger.info("FAP 잡페어 최종확정 기간 삭제 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.final_decision_time_delete(fap_jobfair_set_seq_map);
		logger.info("FAP 잡페어 최종확정 기간 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : final_decision_algorithm_step_one
	 * @Date : 2019. 5. 10.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 내정자중 미 선택자 포기처리
	 */
	public void final_decision_algorithm_step_one(int fap_jobfair_divide_seq) {
		logger.info("FAP 잡페어 최종확정 알고리즘 내정자중 미 선택자 포기처리 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.final_decision_algorithm_step_one(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 최종확정 알고리즘 내정자중 미 선택자 포기처리 DAO 종료");
	}
	
	/**
	 * @Method Name : final_decision_algorithm_step_one_ns
	 * @Date : 2019. 5. 15.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 내정자중 미 선택자 포기처리 (확정필수-유예없음)
	 */
	public void final_decision_algorithm_step_one_ns(int fap_jobfair_divide_seq) {
		logger.info("FAP 잡페어 최종확정 알고리즘 내정자중 미 선택자 포기처리 (확정필수-유예없음) DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.final_decision_algorithm_step_one_ns(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 최종확정 알고리즘 내정자중 미 선택자 포기처리 (확정필수-유예없음) DAO 종료");
	}
	
	/**
	 * @Method Name : final_decision_algorithm_step_two
	 * @Date : 2019. 5. 10.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 내정자중 미 선택자 포기처리
	 */
	public void final_decision_algorithm_step_two(int fap_jobfair_divide_seq) {
		logger.info("FAP 잡페어 최종확정 알고리즘 내정+예비중 확정된 기업을 제외하고 포기처리 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.final_decision_algorithm_step_two(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 최종확정 알고리즘 내정+예비중 확정된 기업을 제외하고 포기처리 DAO 종료");
	}
	
	/**
	 * @Method Name : final_decision_algorithm_step_three
	 * @Date : 2019. 5. 10.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : 잡페어 최종확정 알고리즘 내정포기로 인한 예비합격자 정보
	 * @Method 설명 : 잡페어 최종확정 알고리즘 내정포기로 인한 예비합격자 정보 조회
	 */
	public ArrayList<HashMap<String, Object>> final_decision_algorithm_step_three(int fap_jobfair_divide_seq){
		logger.info("FAP 잡페어 최종확정 알고리즘 내정포기로 인한 예비합격자 정보 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> result = sfaMapper.final_decision_algorithm_step_three(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 최종확정 알고리즘 내정포기로 인한 예비합격자 정보 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : final_decision_algorithm_step_four
	 * @Date : 2019. 5. 10.
	 * @User : 이종호
	 * @Param : 잡페어 최종확정 알고리즘 예비합격자 정보
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 예비합격자 정보 적용
	 */
	public void final_decision_algorithm_step_four(ArrayList<HashMap<String, Object>> list) {
		logger.info("FAP 잡페어 최종확정 알고리즘 예비합격자 정보 적용 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.final_decision_algorithm_step_four(list);
		logger.info("FAP 잡페어 최종확정 알고리즘 예비합격자 정보 적용 DAO 종료");
	}
	
	/**
	 * @Method Name : final_decision_algorithm_step_five
	 * @Date : 2019. 5. 10.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 확정된 지원자 확정 버튼 노출여부 변경
	 */
	public void final_decision_algorithm_step_five(int fap_jobfair_divide_seq) {
		logger.info("FAP 잡페어 최종확정 알고리즘 확정된 지원자 확정 버튼 노출여부 변경 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.final_decision_algorithm_step_five(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 최종확정 알고리즘 확정된 지원자 확정 버튼 노출여부 변경 DAO 종료");
	}
	
	/**
	 * @Method Name : final_decision_algorithm_step_final
	 * @Date : 2019. 5. 15.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 모든 지원자 확정 버튼 노출여부 변경
	 */
	public void final_decision_algorithm_step_final(int fap_jobfair_divide_seq) {
		logger.info("FAP 잡페어 최종확정 알고리즘 모든 지원자 확정 버튼 노출여부 변경 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.final_decision_algorithm_step_final(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 최종확정 알고리즘 모든 지원자 확정 버튼 노출여부 변경 DAO 종료");
	}
	
	/**
	 * @Method Name : final_decision_algorithm_gb_update
	 * @Date : 2019. 5. 15.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 최종적용 이후 예비합격자 종료 처리
	 */
	public void final_decision_algorithm_gb_update(int fap_jobfair_divide_seq) {
		logger.info("FAP 잡페어 최종확정 알고리즘 최종적용 이후 예비합격자 종료 처리 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.final_decision_algorithm_gb_update(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 최종확정 알고리즘 최종적용 이후 예비합격자 종료 처리 DAO 종료");
	}
	
	/**
	 * @Method Name : final_decision_algorithm_nominee_update
	 * @Date : 2019. 12. 9.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 적용 이후 예비->합격 대상자 내정자 등록 
	 */
	public void final_decision_algorithm_nominee_update(int fap_jobfair_divide_seq) {
		logger.info("FAP 잡페어 최종확정 알고리즘 적용 이후 예비->합격 대상자 내정자 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.final_decision_algorithm_nominee_update(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 최종확정 알고리즘 적용 이후 예비->합격 대상자 내정자 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : final_decision_algorithm_pass_to_comp
	 * @Date : 2019. 5. 15.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 최종적용 이후 기업에 전달
	 */
	public void final_decision_algorithm_pass_to_comp(int fap_jobfair_divide_seq) {
		logger.info("FAP 잡페어 최종확정 알고리즘 최종적용 이후 기업에 전달 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.final_decision_algorithm_pass_to_comp(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 최종확정 알고리즘 최종적용 이후 기업에 전달 DAO 종료");
	}
	
	/**
	 * @Method Name : fap_ad_show_code_select
	 * @Date : 2019. 3. 22.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 채용공고 대상자 공통코드 맵
	 * @Method 설명 : 채용공고 대상자 설정을 위한 조회
	 */
	public ArrayList<HashMap<String, Object>> fap_ad_show_code_select(){
		logger.info("FAP 채용공고 대상자 공통코드 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> result = sfaMapper.fap_ad_show_code_select();
		logger.info("FAP 채용공고 대상자 공통코드 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_ad_show_link_code_select
	 * @Date : 2019. 3. 22.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 채용공고 시퀀스
	 * @Method 설명 : 채용공고 연결된 대상자 설정을 위한 조회
	 */
	public ArrayList<SocietyFapJobAdShow> fap_ad_show_link_code_select(long fap_job_ad_seq){
		logger.info("FAP 채용공고 연결된 대상자 설정을 위한 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<SocietyFapJobAdShow> result = sfaMapper.fap_ad_show_link_code_select(fap_job_ad_seq);
		logger.info("FAP 채용공고 연결된 대상자 설정을 위한 조회 DAO 시작");
		
		return result;
	}
	
	/**
	 * @Method Name : fap_ad_show_link_code_delete
	 * @Date : 2019. 3. 22.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 채용공고 시퀀스
	 * @Method 설명 : 채용공고 연결된 대상자 설정을 위한 삭제
	 */
	public void fap_ad_show_link_code_delete(long fap_job_ad_seq) {
		logger.info("FAP 채용공고 연결된 대상자 설정을 위한 삭제 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.fap_ad_show_link_code_delete(fap_job_ad_seq);
		logger.info("FAP 채용공고 연결된 대상자 설정을 위한 삭제 DAO 시작");
	}
	
	/**
	 * @Method Name : fap_ad_show_link_code_insert
	 * @Date : 2019. 3. 22.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 채용공고 연결된 대상자 정보 리스트
	 * @Method 설명 : 채용공고 연결된 대상자 설정을 위한 등록
	 */
	public void fap_ad_show_link_code_insert(ArrayList<SocietyFapJobAdShow> show_list) {
		logger.info("FAP 채용공고 연결된 대상자 설정을 위한 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.fap_ad_show_link_code_insert(show_list);
		logger.info("FAP 채용공고 연결된 대상자 설정을 위한 등록 DAO 시작");
	}
	
	/**
	 * @Method Name : fap_faq_select_list
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 파인애플 FAQ 리스트
	 * @Method 설명 : 파인애플 FAQ 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> fap_faq_select_list(){
		logger.info("FAP FAQ 리스트 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> result = sfaMapper.fap_faq_select_list();
		logger.info("FAP FAQ 리스트 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_faq_select_list_gb
	 * @Date : 2019. 4. 10.
	 * @User : 이종호
	 * @Param : FAQ 구분값
	 * @Return : 파인애플 FAQ 리스트(구분된)
	 * @Method 설명 : 파인애플 FAQ 리스트(구분된) 조회
	 */
	public ArrayList<HashMap<String, Object>> fap_faq_select_list_gb(HashMap<String, Object> paramMap,RowBounds rb){
		logger.info("FAP FAQ 리스트(구분된) 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> result = sfaMapper.fap_faq_select_list_gb(paramMap,rb);
		logger.info("FAP FAQ 리스트(구분된) 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_faq_select_list_gb_count
	 * @Date : 2019. 4. 10.
	 * @User : 이종호
	 * @Param : FAQ 구분값
	 * @Return : 파인애플 FAQ 리스트(구분된) 갯수
	 * @Method 설명 : 파인애플 FAQ 리스트(구분된) 갯수 조회
	 */
	public int fap_faq_select_list_gb_count(HashMap<String, Object> paramMap) {
		logger.info("FAP FAQ 리스트(구분된) 갯수 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int result = sfaMapper.fap_faq_select_list_gb_count(paramMap);
		logger.info("FAP FAQ 리스트(구분된) 갯수 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_faq_insert_content
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : 파인애플 FAQ 내용 정보
	 * @Return : -
	 * @Method 설명 : 파인애플 FAQ 내용 등록
	 */
	public void fap_faq_insert_content(FaqConsultingContents content) {
		logger.info("FAP FAQ 내용 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.fap_faq_insert_content(content);
		logger.info("FAP FAQ 내용 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : fap_faq_insert_gb
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : 파인애플 FAQ 구분 정보
	 * @Return : -
	 * @Method 설명 : 파인애플 FAQ 구분 등록
	 */
	public void fap_faq_insert_gb(SocietyFapAdminFaqGb faqGb) {
		logger.info("FAP FAQ 구분 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.fap_faq_insert_gb(faqGb);
		logger.info("FAP FAQ 구분 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : fap_faq_select_list
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 파인애플 FAQ 단일정보
	 * @Method 설명 : 파인애플 FAQ 단일 조회
	 */
	public HashMap<String, Object> fap_faq_select_one(int consulting_seq){
		logger.info("FAP FAQ 단일 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		HashMap<String, Object> result = sfaMapper.fap_faq_select_one(consulting_seq);
		logger.info("FAP FAQ 단일 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_faq_update_content
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : 파인애플 FAQ 내용 정보
	 * @Return : -
	 * @Method 설명 : 파인애플 FAQ 내용 수정
	 */
	public void fap_faq_update_content(FaqConsultingContents content) {
		logger.info("FAP FAQ 내용 수정 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.fap_faq_update_content(content);
		logger.info("FAP FAQ 내용 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : fap_faq_update_gb
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : 파인애플 FAQ 구분 정보
	 * @Return : -
	 * @Method 설명 : 파인애플 FAQ 구분 수정
	 */
	public void fap_faq_update_gb(SocietyFapAdminFaqGb faqGb) {
		logger.info("FAP FAQ 구분 수정 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.fap_faq_update_gb(faqGb);
		logger.info("FAP FAQ 구분 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : fap_faq_delete
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : 파인애플 FAQ 시퀀스
	 * @Return : -
	 * @Method 설명 : 파인애플 FAQ 삭제
	 */
	public void fap_faq_delete(int consulting_seq) {
		logger.info("FAP FAQ 삭제 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.fap_faq_delete(consulting_seq);
		logger.info("FAP FAQ 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : fap_open_pt_insert
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 정보 등록
	 */
	public void fap_open_pt_insert(SocietyFapOpenPt openPt) {
		logger.info("FAP 오픈잡페어 설명회 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.fap_open_pt_insert(openPt);
		logger.info("FAP 오픈잡페어 설명회 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : fap_open_pt_select_list
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 오픈잡페어 설명회 정보 리스트
	 * @Method 설명 : 오픈잡페어 설명회 정보 리스트 조회
	 */
	public ArrayList<SocietyFapOpenPt> fap_open_pt_select_list(){
		logger.info("FAP 오픈잡페어 설명회 정보 리스트 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<SocietyFapOpenPt> result = sfaMapper.fap_open_pt_select_list();
		logger.info("FAP 오픈잡페어 설명회 정보 리스트 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_pt_select_one
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 시퀀스
	 * @Return : 오픈잡페어 설명회 정보
	 * @Method 설명 : 오픈잡페어 설명회 정보 조회
	 */
	public SocietyFapOpenPt fap_open_pt_select_one(int fap_open_pt_seq) {
		logger.info("FAP 오픈잡페어 설명회 정보 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		SocietyFapOpenPt result = sfaMapper.fap_open_pt_select_one(fap_open_pt_seq);
		logger.info("FAP 오픈잡페어 설명회 정보 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_pt_update_show_gb
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 수정정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 같은종류 모두 비노출 처리
	 */
	public void fap_open_pt_update_show_gb(SocietyFapOpenPt openPt) {
		logger.info("FAP 오픈잡페어 설명회 같은종류 모두 비노출 처리 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.fap_open_pt_update_show_gb(openPt);
		logger.info("FAP 오픈잡페어 설명회 같은종류 모두 비노출 처리 DAO 종료");
	}
	
	/**
	 * @Method Name : fap_open_pt_update_gb
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 수정정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 구분 정보 수정
	 */
	public void fap_open_pt_update_gb(SocietyFapOpenPt openPt) {
		logger.info("FAP 오픈잡페어 설명회 구분 정보 수정 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.fap_open_pt_update_gb(openPt);
		logger.info("FAP 오픈잡페어 설명회 구분 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : fap_open_pt_update
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 수정정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 정보 수정
	 */
	public void fap_open_pt_update(SocietyFapOpenPt openPt) {
		logger.info("FAP 오픈잡페어 설명회 정보 수정 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.fap_open_pt_update(openPt);
		logger.info("FAP 오픈잡페어 설명회 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : fap_open_pt_delete
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 시퀀스
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 정보 삭제
	 */
	public void fap_open_pt_delete(int fap_open_pt_seq) {
		logger.info("FAP 오픈잡페어 설명회 정보 삭제 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.fap_open_pt_delete(fap_open_pt_seq);
		logger.info("FAP 오픈잡페어 설명회 정보 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : fap_open_pt_applier_list_count
	 * @Date : 2019. 4. 17.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 정보
	 * @Return : 오픈잡페어 설명회 총 지원자 수(검색 포함)
	 * @Method 설명 : 해당 설명회 총 지원자 수(검색 포함) 조회
	 */
	public int fap_open_pt_applier_list_count(HashMap<String, Object> paramMap) {
		logger.info("FAP 해당 설명회 총 지원자 수(검색 포함) 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int result =  sfaMapper.fap_open_pt_applier_list_count(paramMap);
		logger.info("FAP 해당 설명회 총 지원자 수(검색 포함) 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_edu_applier_list_count
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 정보
	 * @Return : 오픈잡페어 구직자 교육 총 지원자 수(검색 포함)
	 * @Method 설명 : 해당 구직자 교육 총 지원자 수(검색 포함) 조회
	 */
	public int fap_open_edu_applier_list_count(HashMap<String, Object> paramMap) {
		logger.info("FAP 해당 구직자 교육 총 지원자 수(검색 포함) 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int result =  sfaMapper.fap_open_edu_applier_list_count(paramMap);
		logger.info("FAP 해당 구직자 교육 총 지원자 수(검색 포함) 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_pt_applier_list
	 * @Date : 2019. 4. 16.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 정보
	 * @Return : 해당 설명회 지원자 정보 리스트
	 * @Method 설명 : 해당 설명회 지원자 정보 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> fap_open_pt_applier_list(HashMap<String, Object> paramMap,RowBounds rb){
		logger.info("FAP 해당 설명회 지원자 정보 리스트 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		 ArrayList<HashMap<String, Object>> result =  sfaMapper.fap_open_pt_applier_list(paramMap,rb);
		logger.info("FAP 해당 설명회 지원자 정보 리스트 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_edu_applier_list
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 정보
	 * @Return : 해당 구직자 교육 지원자 정보 리스트
	 * @Method 설명 : 해당 구직자 교육 지원자 정보 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> fap_open_edu_applier_list(HashMap<String, Object> paramMap,RowBounds rb){
		logger.info("FAP 해당 구직자 교육 지원자 정보 리스트 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		 ArrayList<HashMap<String, Object>> result =  sfaMapper.fap_open_edu_applier_list(paramMap,rb);
		logger.info("FAP 해당 구직자 교육 지원자 정보 리스트 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_pt_applier_list_excel
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 지원자 시퀀스 정보
	 * @Return : 해당 설명회 지원자 정보 리스트
	 * @Method 설명 : 해당 설명회 지원자 정보 리스트 엑셀출력용 조회
	 */
	public ArrayList<LinkedHashMap<String, Object>> fap_open_pt_applier_list_excel(HashMap<String, Object> paramMap){
		logger.info("FAP 해당 설명회 지원자 정보 리스트 엑셀출력용 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		 ArrayList<LinkedHashMap<String, Object>> result =  sfaMapper.fap_open_pt_applier_list_excel(paramMap);
		logger.info("FAP 해당 설명회 지원자 정보 리스트 엑셀출력용 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_edu_applier_list_excel
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 지원자 시퀀스 정보
	 * @Return : 해당 구직자 교육 지원자 정보 리스트
	 * @Method 설명 : 해당 구직자 교육 지원자 정보 리스트 엑셀출력용 조회
	 */
	public ArrayList<LinkedHashMap<String, Object>> fap_open_edu_applier_list_excel(HashMap<String, Object> paramMap){
		logger.info("FAP 해당 구직자 교육 지원자 정보 리스트 엑셀출력용 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		 ArrayList<LinkedHashMap<String, Object>> result =  sfaMapper.fap_open_edu_applier_list_excel(paramMap);
		logger.info("FAP 해당 구직자 교육 지원자 정보 리스트 엑셀출력용 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_pt_only_list
	 * @Date : 2019. 4. 16.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 구분
	 * @Return : 해당 구분 설명회 정보 리스트
	 * @Method 설명 : 해당 구분 설명회 정보 리스트 조회
	 */
	public ArrayList<SocietyFapOpenPt> fap_open_pt_only_list(String fap_open_pt_gb){
		logger.info("FAP 해당 구분 설명회 정보 리스트 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		 ArrayList<SocietyFapOpenPt> result =  sfaMapper.fap_open_pt_only_list(fap_open_pt_gb);
		logger.info("FAP 해당 구분 설명회 정보 리스트 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_edu_applier_resume_update
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 지원자 이력서 정보
	 * @Return : -
	 * @Method 설명 : 해당 구분 구직자 교육 지원자 합/불 처리
	 */
	public void fap_open_edu_applier_resume_update(SocietyFapOpenPtResume openResume) {
		logger.info("FAP  해당 구분 구직자 교육 지원자 합/불 처리 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		 sfaMapper.fap_open_edu_applier_resume_update(openResume);
		logger.info("FAP  해당 구분 구직자 교육 지원자 합/불 처리 DAO 종료");
	}
	
	/**
	 * @Method Name : fap_open_edu_close_fail_update
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 정보
	 * @Return : -
	 * @Method 설명 : 해당 오픈잡페어 구직자 교육 마감처리 시 대기 지원자 불합격 처리
	 */
	public void fap_open_edu_close_fail_update(SocietyFapOpenPt openPt) {
		logger.info("FAP  해당 오픈잡페어 구직자 교육 마감처리 시 대기 지원자 불합격 처리 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		 sfaMapper.fap_open_edu_close_fail_update(openPt);
		logger.info("FAP  해당 오픈잡페어 구직자 교육 마감처리 시 대기 지원자 불합격 처리 DAO 종료");
	}
	
	/**
	 * @Method Name : fap_open_job_info_content_list
	 * @Date : 2019. 6. 27.
	 * @User : 김경아
	 * @Param : 게시판 일련번호
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 취업정보 & 전략 게시판 리스트 조회 
	 */
	public ArrayList<HashMap<String,Object>> fap_open_job_info_content_list(HashMap<String, Object> map, RowBounds  rb){
		logger.info("FAP  해당 오픈잡페어 취업정보 & 전략 게시판 추가항목 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String,Object>> result = sfaMapper.fap_open_job_info_content_list(map, rb);
		logger.info("FAP  해당 오픈잡페어 취업정보 & 전략 게시판 추가항목 조회 DAO 종료");
		return result;
	}
	
	 
	
	/**
	 * @Method Name : fap_open_job_info_content_additional_detail
	 * @Date : 2019. 6. 27.
	 * @User : 김경아
	 * @Param : 게시판 글 일련번호
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 취업정보 & 전략 게시판 상세조회 추가항목  
	 */
	public HashMap<String, Object> fap_open_job_info_content_additional_detail(HashMap<String,Object> paramMap){
		logger.info("FAP  해당 오픈잡페어 취업정보 & 전략 게시판 상세조회 추가항목 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		HashMap<String, Object> result = new HashMap<String, Object>();
		result = sfaMapper.fap_open_job_info_content_additional_detail(paramMap);
		logger.info("FAP  해당 오픈잡페어 취업정보 & 전략 게시판 상세조회 추가항목 DAO 종료");
		return result;
	}
	
	
	/**
	 * @Method Name : fap_open_insert_job_info_content
	 * @Date : 2019. 6. 26.
	 * @User : 김경아
	 * @Param : 오픈잡페어 취업정보 & 전략 정보 
	 * @Return : -
	 * @Method 설명 : 오픈잡페어  취업정보 & 전략 게시판 정보 등록
	 */
	public void fap_open_insert_job_info_content(SocietyFapOpenJobInfo openJobInfo){
		logger.info("FAP  해당 오픈잡페어 취업정보 & 전략 게시판 정보 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.fap_open_insert_job_info_content(openJobInfo);
		logger.info("FAP  해당 오픈잡페어 취업정보 & 전략 게시판 정보 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : fap_open_update_job_info_content
	 * @Date : 2019. 6. 27.
	 * @User : 김경아
	 * @Param : 오픈잡페어 취업정보 & 전략 정보 
	 * @Return : -
	 * @Method 설명 : 오픈잡페어  취업정보 & 전략 게시판 정보 수정
	 */
	public int fap_open_update_job_info_content(SocietyFapOpenJobInfo openJobInfo){
		logger.info("FAP  해당 오픈잡페어 취업정보 & 전략 게시판 정보 수정 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		 
		int result = sfaMapper.fap_open_update_job_info_content(openJobInfo);
		 
		logger.info("FAP  해당 오픈잡페어 취업정보 & 전략 게시판 정보 수정 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_delete_job_info_content
	 * @Date : 2019. 6. 27.
	 * @User : 김경아
	 * @Param : 취업정보 & 전략 게시판 일련번호
	 * @Return : -
	 * @Method 설명 : 오픈잡페어  취업정보 & 전략 게시판 정보 삭제
	 */
	public int fap_open_delete_job_info_content(int board_content_seq){
		logger.info("FAP  해당 오픈잡페어 취업정보 & 전략 게시판 정보 수정 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int result = sfaMapper.fap_open_delete_job_info_content(board_content_seq);
		logger.info("FAP  해당 오픈잡페어 취업정보 & 전략 게시판 정보 수정 DAO 종료");
		return result;
	} 
 
	/**
	 * @Method Name : fap_popup_insert
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : FAP 팝업 정보
	 * @Return : -
	 * @Method 설명 : FAP 팝업 정보 등록
	 */
	public void fap_popup_insert(SocietyFapPopup popup) {
		logger.info("FAP 팝업 정보 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		 sfaMapper.fap_popup_insert(popup);
		logger.info("FAP 팝업 정보 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : fap_popup_select_list
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : -
	 * @Return : FAP 팝업 정보 리스트
	 * @Method 설명 : FAP 팝업 정보 리스트 조회
	 */
	public ArrayList<SocietyFapPopup> fap_popup_select_list(){
		logger.info("FAP 팝업 정보 리스트 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<SocietyFapPopup> result = sfaMapper.fap_popup_select_list();
		logger.info("FAP 팝업 정보 리스트 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_popup_select_one
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : -
	 * @Return : FAP 팝업 정보 단일
	 * @Method 설명 : FAP 팝업 정보 단일 조회
	 */
	public SocietyFapPopup fap_popup_select_one(int fap_popup_seq) {
		logger.info("FAP 팝업 정보 단일 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		SocietyFapPopup result = sfaMapper.fap_popup_select_one(fap_popup_seq);
		logger.info("FAP 팝업 정보 단일 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_popup_delete
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : -
	 * @Return : FAP 팝업 시퀀스
	 * @Method 설명 : FAP 팝업 정보 삭제
	 */
	public void fap_popup_delete(int fap_popup_seq) {
		logger.info("FAP 팝업 정보 삭제 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.fap_popup_delete(fap_popup_seq);
		logger.info("FAP 팝업 정보 삭제 DAO 시작");
	}
	
	/**
	 * @Method Name : fap_job_resume_update_gb
	 * @Date : 2019. 4. 30.
	 * @User : 이종호
	 * @Param : FAP 이력서 수정여부 구분
	 * @Return : -
	 * @Method 설명 : FAP 이력서 수정여부 구분 변경
	 */
	public void fap_job_resume_update_gb(String fap_job_resume_update_gb) {
		logger.info("FAP 이력서 수정여부 구분 변경 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.fap_job_resume_update_gb(fap_job_resume_update_gb);
		logger.info("FAP 이력서 수정여부 구분 변경 DAO 종료");
	}
	
	/**
	 * @Method Name : applicant_status_per_applier_search
	 * @Date : 2019. 5. 17.
	 * @User : 이종호
	 * @Param : 지원자별 지원현황 검색 조건
	 * @Return : 지원자별 지원 현황 리스트
	 * @Method 설명 : 지원자별 지원 현황 리스트 검색
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_applier_search(HashMap<String, Object> search_map){
		logger.info("FAP 관리자 지원자별 지원 현황 리스트 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<LinkedHashMap<String, Object>> result = sfaMapper.applicant_status_per_applier_search(search_map);
		logger.info("FAP 관리자 지원자별 지원 현황 리스트 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_one
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보1
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드1
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_one(int jobfair_seq){
		logger.info("FAP 관리자 기업별 지원 현황 정보1 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<LinkedHashMap<String, Object>> result = sfaMapper.applicant_status_per_comp_excel_one(jobfair_seq);
		logger.info("FAP 관리자 기업별 지원 현황 정보1 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_two
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보2
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드2
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_two(int jobfair_seq){
		logger.info("FAP 관리자 기업별 지원 현황 정보2 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<LinkedHashMap<String, Object>> result = sfaMapper.applicant_status_per_comp_excel_two(jobfair_seq);
		logger.info("FAP 관리자 기업별 지원 현황 정보2 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_three
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보3
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드3
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_three(int jobfair_seq){
		logger.info("FAP 관리자 기업별 지원 현황 정보3 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<LinkedHashMap<String, Object>> result = sfaMapper.applicant_status_per_comp_excel_three(jobfair_seq);
		logger.info("FAP 관리자 기업별 지원 현황 정보3 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_four
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보4
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드4
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_four(int jobfair_seq){
		logger.info("FAP 관리자 기업별 지원 현황 정보4 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<LinkedHashMap<String, Object>> result = sfaMapper.applicant_status_per_comp_excel_four(jobfair_seq);
		logger.info("FAP 관리자 기업별 지원 현황 정보4 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_five
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보5
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드5
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_five(int jobfair_seq){
		logger.info("FAP 관리자 기업별 지원 현황 정보5 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<LinkedHashMap<String, Object>> result = sfaMapper.applicant_status_per_comp_excel_five(jobfair_seq);
		logger.info("FAP 관리자 기업별 지원 현황 정보5 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_six
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보6
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드6
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_six(int jobfair_seq){
		logger.info("FAP 관리자 기업별 지원 현황 정보6 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<LinkedHashMap<String, Object>> result = sfaMapper.applicant_status_per_comp_excel_six(jobfair_seq);
		logger.info("FAP 관리자 기업별 지원 현황 정보6 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_seven
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보7
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드7
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_seven(int jobfair_seq){
		logger.info("FAP 관리자 기업별 지원 현황 정보7 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<LinkedHashMap<String, Object>> result = sfaMapper.applicant_status_per_comp_excel_seven(jobfair_seq);
		logger.info("FAP 관리자 기업별 지원 현황 정보7 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_eight
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보8
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드8
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_eight(int jobfair_seq){
		logger.info("FAP 관리자 기업별 지원 현황 정보8 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<LinkedHashMap<String, Object>> result = sfaMapper.applicant_status_per_comp_excel_eight(jobfair_seq);
		logger.info("FAP 관리자 기업별 지원 현황 정보8 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_nine
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보9
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드9
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_nine(int jobfair_seq){
		logger.info("FAP 관리자 기업별 지원 현황 정보9 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<LinkedHashMap<String, Object>> result = sfaMapper.applicant_status_per_comp_excel_nine(jobfair_seq);
		logger.info("FAP 관리자 기업별 지원 현황 정보9 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_ten
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보10
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드10
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_ten(int jobfair_seq){
		logger.info("FAP 관리자 기업별 지원 현황 정보10 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<LinkedHashMap<String, Object>> result = sfaMapper.applicant_status_per_comp_excel_ten(jobfair_seq);
		logger.info("FAP 관리자 기업별 지원 현황 정보10 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_eleven
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보11
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드11
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_eleven(int jobfair_seq){
		logger.info("FAP 관리자 기업별 지원 현황 정보11 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<LinkedHashMap<String, Object>> result = sfaMapper.applicant_status_per_comp_excel_eleven(jobfair_seq);
		logger.info("FAP 관리자 기업별 지원 현황 정보11 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_twelve
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보12
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드12
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_twelve(int jobfair_seq){
		logger.info("FAP 관리자 기업별 지원 현황 정보12 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<LinkedHashMap<String, Object>> result = sfaMapper.applicant_status_per_comp_excel_twelve(jobfair_seq);
		logger.info("FAP 관리자 기업별 지원 현황 정보12 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_thirteen
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보13
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드13
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_thirteen(int jobfair_seq){
		logger.info("FAP 관리자 기업별 지원 현황 정보13 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<LinkedHashMap<String, Object>> result = sfaMapper.applicant_status_per_comp_excel_thirteen(jobfair_seq);
		logger.info("FAP 관리자 기업별 지원 현황 정보13 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_fourteen
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보14
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드14
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_fourteen(int jobfair_seq){
		logger.info("FAP 관리자 기업별 지원 현황 정보14 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<LinkedHashMap<String, Object>> result = sfaMapper.applicant_status_per_comp_excel_fourteen(jobfair_seq);
		logger.info("FAP 관리자 기업별 지원 현황 정보14 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_fifteen
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보15
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드15
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_fifteen(int jobfair_seq){
		logger.info("FAP 관리자 기업별 지원 현황 정보15 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<LinkedHashMap<String, Object>> result = sfaMapper.applicant_status_per_comp_excel_fifteen(jobfair_seq);
		logger.info("FAP 관리자 기업별 지원 현황 정보15 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_sixteen
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보16
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드16
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_sixteen(int jobfair_seq){
		logger.info("FAP 관리자 기업별 지원 현황 정보16 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<LinkedHashMap<String, Object>> result = sfaMapper.applicant_status_per_comp_excel_sixteen(jobfair_seq);
		logger.info("FAP 관리자 기업별 지원 현황 정보16 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : jobfair_apply_max_count
	 * @Date : 2019. 5. 20.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 지원자가 최대 지원한 갯수
	 * @Method 설명 : 잡페어별 지원자가 최대 지원한 갯수 검색
	 */
	public int jobfair_apply_max_count(HashMap<String, Object> params) {
		logger.info("FAP 관리자 잡페어별 지원자가 최대 지원한 갯수 검색 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int result = sfaMapper.jobfair_apply_max_count(params);
		logger.info("FAP 관리자 잡페어별 지원자가 최대 지원한 갯수 검색 DAO 종료");
		return result;
	}

	/**
	 * @Method Name : select_company_group_code_list
	 * @Date : 2019. 7. 25. 
	 * @User : 김경아
	 * @Param : HashMap
	 * @Return : HashMap
	 * @Method 설명 : FAP 관리자 잡페어별 그룹코드 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> admin_select_company_group_code_list(
			HashMap<String, Object> fapJobAdvertisement) {
		logger.info(" FAP 관리자 잡페어별 그룹코드 셀렉트 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> result = sfaMapper.admin_select_company_group_code_list(fapJobAdvertisement);
		logger.info(" FAP 관리자 잡페어별 그룹코드 셀렉트 DAO 시작");
		return result;
	}

	/**
	 * @Method Name : search_job_advertisement_list
	 * @Date : 2019. 07. 25.
	 * @User : 김경아
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 채용공고 상세검색
	 */
	public ArrayList<HashMap<String, Object>> admin_search_job_advertisement_list(
			HashMap<String, Object> selectedCompanyInfoMap) {
		logger.info(" FAP 관리자 잡페어별 그룹코드 셀렉트 DAO 시작");
		 SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);		
		 ArrayList<HashMap<String, Object>> result = sfaMapper.admin_search_job_advertisement_list(selectedCompanyInfoMap);
		logger.info(" FAP 관리자 잡페어별 그룹코드 셀렉트 DAO 종료");
		return result;
	}

	/**
	 * @Method Name : board_contents_detail
	 * @Date : 2019. 7. 31.
	 * @User : 김경아
	 * @Param : 게시판 세부구분  공통코드 
	 * @Return : 게시판 세부 내용
	 * @Method 설명 : 게시판 세부 내용을 가져오는 함수
	 */
	public HashMap<String, Object> board_contents_detail(int board_content_seq){
		logger.info("FAP 게시판 세부내용 가져오기 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		HashMap<String, Object> board_content = sfaMapper.board_contents_detail(board_content_seq);
		logger.info("FAP 게시판 세부내용 가져오기 DAO 시작");
		return board_content;
	}

	/**
	 * @Method Name : board_contents_hit_update
	 * @Date : 2019. 7. 31.
	 * @User : 김경아	
	 * @Param : 게시판 글 seq
	 * @Return : 
	 * @Method 설명 : 게시판 조회수를 추가하는 함수 
	 */
	public void board_contents_hit_update(int board_content_seq) {
		logger.info("FAP 게시글 세부 내용 중 조회수 증가 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.board_contents_hit_update(board_content_seq);
		logger.info("FAP 게시글 세부 내용 중 조회수 증가 DAO 종료");
	}

	/**
	 * @Method Name : fap_open_insert_notice_content
	 * @Date : 2019. 7. 31.
	 * @User : 김경아 
	 * @Param : 공지사항 게시판 정보 
	 * @Return : 
	 * @Method 설명 : 공지사항 게시판 정보 추가 
	 */
	public void fap_open_insert_notice_content(SocietyFapAdminNoticeContent noticeContent) {
		logger.info("FAP 오픈잡페어 공지사항 게시판 내용 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.fap_open_insert_notice_content(noticeContent);
		logger.info("FAP 오픈잡페어 공지사항 게시판 내용 등록 DAO 종료");
	}
	/**
	 * @Method Name : fap_open_update_notice_content
	 * @Date : 2019. 8. 1.
	 * @User : 김경아
	 * @Param : 공지사항 게시판 정보
	 * @Return : 
	 * @Method 설명 : 공지사항 게시판 정보 수정
	 */
	public void fap_open_update_notice_content(SocietyFapAdminNoticeContent noticeContent) {
		logger.info("FAP 오픈잡페어 공지사항 게시판 내용 수정 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.fap_open_update_notice_content(noticeContent);
		logger.info("FAP 오픈잡페어 공지사항 게시판 내용 수정 DAO 종료");
		
	}
	
	/**
	 * @Method Name : fap_insert_internship_content
	 * @Date : 2021. 04. 22
	 * @User : 김나영
	 * @Param : 미국인턴십 게시판 정보 
	 * @Return : 
	 * @Method 설명 : 미국인턴십 게시판 정보 추가 
	 */
	public void fap_insert_internship_content(SocietyFapAdminNoticeContent noticeContent) {
		logger.info("FAP 미국인턴십 게시판 정보 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.fap_insert_internship_content(noticeContent);
		logger.info("FAP 미국인턴십 게시판 정보 등록 DAO 종료");
	}
	/**
	 * @Method Name : fap_update_internship_content
	 * @Date : 2021. 4. 22.
	 * @User : 김나영
	 * @Param : 미국인턴십 게시판 정보 
	 * @Return : 
	 * @Method 설명 : 미국인턴십 게시판 정보 수정
	 */
	public void fap_update_internship_content(SocietyFapAdminNoticeContent noticeContent) {
		logger.info("FAP 미국인턴십 게시판 정보 수정 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.fap_update_internship_content(noticeContent);
		logger.info("FAP 미국인턴십 게시판 정보 수정 DAO 종료");
		
	}
	/**
	 * @Method Name : delete_jobfair_divide_seq_from_apply_info
	 * @Date : 2019. 8. 16.
	 * @User : 김경아
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 잡페어 추가지원/미스매칭 지원정보 삭제
	 */
	public void delete_jobfair_divide_seq_from_apply_info(int fap_jobfair_divide_seq) {
		logger.info("FAP잡페어 추가지원/미스매칭 정보 삭제 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.delete_jobfair_divide_seq_from_apply_info(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 추가지원/미스매칭 정보 삭제 DAO 종료");
		
	}

	/**
	 * @Method Name : insert_admin_notice_info
	 * @Date : 2019. 8. 29.
	 * @User : 김경아
	 * @Param : 등록자 id, 잡페어 시퀀스 
	 * @Return : 
	 * @Method 설명 : FAP 잡페어 참가신청시 관리자 알림테이블에 해당 정보 추가 
	 */
	public int insert_admin_notice_info(HashMap<String, Object> map) {
		logger.info("FAP 잡페어 참가신청시 관리자 알림테이블에 정보 추가 서비스 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int result = sfaMapper.insert_admin_notice_info(map);
		logger.info("FAP 잡페어 참가신청시 관리자 알림테이블에 정보 추가 서비스 종료");
		return result;
	}

	/**
	 * @Method Name : select_admin_notice_alim_list
	 * @Date : 2019. 8. 30.
	 * @User : 김경아
	 * @Param :  
	 * @Return :   관리자 알림 list   
	 * @Method 설명 :   관리자 알림 list 출력 
	 */
	public ArrayList<HashMap<String, Object>> select_admin_notice_alim_list(HashMap<String, Object> paramMap, PageNavigator navi) {
		logger.info("FAP 관리자 알림 list 출력 서비스 시작");
		RowBounds rb = new RowBounds(navi.getStartRecord(),navi.getCountPerPage());
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> result =  sfaMapper.select_admin_notice_alim_list(paramMap, rb);		 
		logger.info("FAP 관리자 알림 list 출력 서비스 종료");
		return result;
	}

	/**
	 * @Method Name : select_job_ad_title
	 * @Date : 2019. 9. 3.
	 * @User : 김경아	
	 * @Param : FAP 채용공고명 조회
	 * @Return : 
	 * @Method 설명 : 
	 */
	public String select_job_ad_title(long fap_job_ad_seq) {
		logger.info("FAP 채용공고명 조회 서비스 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		String result = sfaMapper.select_job_ad_title(fap_job_ad_seq);
		logger.info("FAP 채용공고명 조회 서비스 종료");
		return result;
	}
	/**
	 * @Method Name : mainpage_cct_select
	 * @Date : 2019. 9. 3.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 지원자 메인페이지 기업컨텐츠 관리 정보
	 * @Method 설명 : 설정된 지원자 메인페이지 기업컨텐츠 관리 정보를 조회
	 */
	public SocietyFapMainpageContent mainpage_ct_select() {
		logger.info("설정된 지원자 메인페이지 기업컨텐츠 관리 정보를 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		SocietyFapMainpageContent result = sfaMapper.mainpage_ct_select();
		logger.info("설정된 지원자 메인페이지 기업컨텐츠 관리 정보를 조회 DAO 종료");
		return result;
	}
	/**
	 * @Method Name : select_job_qna_question_title
	 * @Date : 2019. 9. 3.
	 * @User : 김경아	
	 * @Param : 질문글 시퀀스 
	 * @Return : 질문글 제목 
	 * @Method 설명 : FAP 질문글 조회 
	 */
	public String select_job_qna_question_title(long fap_job_qna_question_seq) {
		logger.info("FAP 질문글 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		String result =  sfaMapper.select_job_qna_question_title(fap_job_qna_question_seq);		 
		logger.info("FAP 질문글 조회 DAO 종료");
		return result;
	}


	 
	 
	/**
	 * @Method Name : mainpage_ct_insert
	 * @Date : 2019. 9. 3.
	 * @User : 이종호
	 * @Param : 지원자 메인페이지 기업컨텐츠 관리 정보
	 * @Return : -
	 * @Method 설명 : 지원자 메인페이지 기업컨텐츠 관리 정보 등록
	 */
	public void mainpage_ct_insert(SocietyFapMainpageContent mainCt) {
		logger.info("지원자 메인페이지 기업컨텐츠 관리 정보 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.mainpage_ct_insert(mainCt);
		logger.info("지원자 메인페이지 기업컨텐츠 관리 정보 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : mainpage_ct_update
	 * @Date : 2019. 9. 3.
	 * @User : 이종호
	 * @Param : 지원자 메인페이지 기업컨텐츠 관리 정보
	 * @Return : -
	 * @Method 설명 : 지원자 메인페이지 기업컨텐츠 관리 정보 수정
	 */
	public void mainpage_ct_update(SocietyFapMainpageContent mainCt) {
		logger.info("지원자 메인페이지 기업컨텐츠 관리 정보 수정 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.mainpage_ct_update(mainCt);
		logger.info("지원자 메인페이지 기업컨텐츠 관리 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : mainpage_ct_delete
	 * @Date : 2019. 9. 3.
	 * @User : 이종호
	 * @Param : 지원자 메인페이지 기업컨텐츠 관리 정보
	 * @Return : -
	 * @Method 설명 : 지원자 메인페이지 기업컨텐츠 관리 정보 삭제
	 */
	public void mainpage_ct_delete(int fap_mainpage_ct_seq) {
		logger.info("지원자 메인페이지 기업컨텐츠 관리 정보 삭제 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.mainpage_ct_delete(fap_mainpage_ct_seq);
		logger.info("지원자 메인페이지 기업컨텐츠 관리 정보 삭제 DAO 종료");
	}

	/**
	 * @Method Name : admin_notice_update_handle_fin_gb
	 * @Date : 2019. 9. 06.
	 * @User : 김경아
	 * @Param :  알림 seq, 알림처리여부 
	 * @Return :     
	 * @Method 설명 :   알림내용 처리상태 변경 
	 */
	public int admin_notice_update_handle_fin_gb(HashMap<String, Object> paramMap) {
		logger.info("FAP 관리자 알림내용 처리상태 변경 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int result = sfaMapper.admin_notice_update_handle_fin_gb(paramMap);
		logger.info("FAP 관리자 알림내용 처리상태 변경 DAO 종료");
		return result;
	}

	/**
	 * @Method Name : admin_notice_update_handle_fin_gb_all_selected
	 * @Date : 2019. 9. 06.
	 * @User : 김경아
	 * @Param :  알림 seq, 알림처리여부 
	 * @Return :     
	 * @Method 설명 :   알림내용 처리상태 단체변경 
	 */
	public int admin_notice_update_handle_fin_gb_all_selected(List<SocietyFapAdminNoticeAlim> adminNoticeAlimList) {
		logger.info("FAP 관리자 알림내용 처리상태 단체변경 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int result = sfaMapper.admin_notice_update_handle_fin_gb_all_selected(adminNoticeAlimList);
		logger.info("FAP 관리자 알림내용 처리상태 단체변경 DAO 종료");
		return result;
	}

	/**
	 * @Method Name : select_admin_notice_alim_list_count
	 * @Date : 2019. 9. 9.
	 * @User : 김경아
	 * @Param : 
	 * @Return : 알림 구분 
	 * @Method 설명 : FAP 관리자 알림 list 출력 리스트 갯수 조회
	 */
	public int select_admin_notice_alim_list_count(String selected_handle_gb) {
		logger.info("FAP 관리자 알림 list 출력 리스트 갯수 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int result= sfaMapper.select_admin_notice_alim_list_count(selected_handle_gb);
		logger.info("FAP 관리자 알림 list 출력 리스트 갯수 조회 DAO 종료");
		return result;
	}

	/**
	 * @Method Name : select_admin_notice_list_not_handled
	 * @Date : 2019. 9. 9.
	 * @User : 김경아
	 * @Param :   처리여부 
	 * @Return :     
	 * @Method 설명 :  처리되지 않은 항목 갯수 조회 
	 */
	public int select_admin_notice_list_not_handled() {
		 logger.debug("FAP 관리자 처리되지 않은 항목 갯수 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int result= sfaMapper.select_admin_notice_list_not_handled();
		 logger.info("FAP 관리자 처리되지 않은 항목 갯수 조회 DAO 시작");
		return result;
	}

	/**
	 * @Method Name : delete_exam_file
	 * @Date : 2019. 9. 26.
	 * @User : 김경아	
	 * @Param : 파일명 
	 * @Return : 
	 * @Method 설명 : 파일삭제시 파일테이블에서 해당 파일정보 삭제 
	 */
	public int delete_exam_file(String fap_job_exam_file_saved) {
	  logger.info("FAP 관리자 파일테이블에서 파일정보 삭제 DAO 시작");
	  
	  SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
	  int result = sfaMapper.delete_exam_file(fap_job_exam_file_saved);
	  logger.info("FAP 관리자 파일테이블에서 파일정보 삭제 DAO 종료");
	  return result;
	}

	/**
	 * @Method Name : insert_exam_file
	 * @Date : 2019. 9. 26.
	 * @User : 김경아
	 * @Param : 시험전형 시험문제파일정보
	 * @Return : 
	 * @Method 설명 : 시험전형 시험문제파일 등록 
	 */
	public void insert_exam_file(SocietyFapJobExamFile exam_file) {
		  logger.info("FAP 관리자 시험전형 시험문제파일 등록  DAO 시작");
		  SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		  sfaMapper.insert_exam_file(exam_file);
		  logger.info("FAP 관리자 시험전형 시험문제파일 등록  DAO 시작");
		
	}
	
	/**
	 * @Method Name : tokyofair_schedule_set_insert
	 * @Date : 2019. 9. 18.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 설정 등록
	 */
	public int tokyofair_schedule_set_insert(SocietyFapAdminJobfairSet fap_jobfair_set) {
		logger.info("FAP 관리자 도쿄페어 설정 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int result = sfaMapper.tokyofair_schedule_set_insert(fap_jobfair_set);
		logger.info("FAP 관리자 도쿄페어 설정 등록 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_set_date_insert
	 * @Date : 2019. 9. 18.
	 * @User : 이종호
	 * @Param : 도쿄페어 날짜 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 날짜 정보 등록
	 */
	public void tokyofair_schedule_set_date_insert(List<SocietyFapAdminJobfairSetDate> fap_jobfair_set_date) {
		logger.info("FAP 관리자 도쿄페어 날짜 정보 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.tokyofair_schedule_set_date_insert(fap_jobfair_set_date);
		logger.info("FAP 관리자 도쿄페어 날짜 정보 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : tokyofair_schedule_set_time_insert
	 * @Date : 2019. 9. 18.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 일정 정보 등록 
	 */
	public void tokyofair_schedule_set_time_insert(List<SocietyFapAdminJobfairSetTime> fap_jobfair_set_time) {
		logger.info("FAP 관리자 도쿄페어 일정 정보 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.tokyofair_schedule_set_time_insert(fap_jobfair_set_time);
		logger.info("FAP 관리자 도쿄페어 일정 정보 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : tokyofair_schedule_set_search_list
	 * @Date : 2019. 9. 19.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : 도쿄페어 설정 정보 리스트 
	 * @Method 설명 : 도쿄페어 설정 정보 리스트 조회
	 */
	public ArrayList<SocietyFapAdminJobfairSet> tokyofair_schedule_set_search_list(int fap_jobfair_divide_seq){
		logger.info("FAP 관리자 도쿄페어 설정 정보 리스트 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<SocietyFapAdminJobfairSet> result = sfaMapper.tokyofair_schedule_set_search_list(fap_jobfair_divide_seq);
		logger.info("FAP 관리자 도쿄페어 설정 정보 리스트 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_set_gb_init
	 * @Date : 2019. 9. 19.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스 , 도쿄페어 설정 사용여부 초기화 구분
	 * @Return : -
	 * @Method 설명 : 도쿄페어 설정 사용여부 초기화
	 */
	public void tokyofair_schedule_set_gb_init(HashMap<String, Object> params) {
		logger.info("FAP 관리자 도쿄페어 설정 사용여부 초기화 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.tokyofair_schedule_set_gb_init(params);
		logger.info("FAP 관리자 도쿄페어 설정 사용여부 초기화 DAO 종료");
	}
	
	/**
	 * @Method Name : tokyofair_schedule_set_gb_update
	 * @Date : 2019. 9. 19.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 시퀀스, 도쿄페어 설정 사용여부 구분
	 * @Return : -
	 * @Method 설명 : 도쿄페어 설정 사용여부 구분 변경 
	 */
	public void tokyofair_schedule_set_gb_update(HashMap<String, Object> params) {
		logger.info("FAP 관리자 도쿄페어 설정 사용여부 구분 변경 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.tokyofair_schedule_set_gb_update(params);
		logger.info("FAP 관리자 도쿄페어 설정 사용여부 구분 변경 DAO 종료");
	}
	
	/**
	 * @Method Name : tokyofair_schedule_set_delete
	 * @Date : 2019. 9. 19.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 설정 삭제 
	 */
	public void tokyofair_schedule_set_delete(int fap_jobfair_set_seq) {
		logger.info("FAP 관리자 도쿄페어 설정 삭제 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.tokyofair_schedule_set_delete(fap_jobfair_set_seq);
		logger.info("FAP 관리자 도쿄페어 설정 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : tokyofair_schedule_set_search
	 * @Date : 2019. 9. 19.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 시퀀스
	 * @Return : 도쿄페어 설정 정보
	 * @Method 설명 : 도쿄페어 설정 정보 조회
	 */
	public SocietyFapAdminJobfairSet tokyofair_schedule_set_search(int fap_jobfair_set_seq) {
		logger.info("FAP 관리자 도쿄페어 설정 정보 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		SocietyFapAdminJobfairSet result = sfaMapper.tokyofair_schedule_set_search(fap_jobfair_set_seq);
		logger.info("FAP 관리자 도쿄페어 설정 정보 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_set_date_search
	 * @Date : 2019. 9. 19.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 시퀀스
	 * @Return : 도쿄페어 일정 정보
	 * @Method 설명 : 도쿄페어 일정 정보 조회
	 */
	public HashMap<String, Object> tokyofair_schedule_set_date_search(int fap_jobfair_set_seq){
		logger.info("FAP 관리자 도쿄페어 일정 정보 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		HashMap<String, Object> result = sfaMapper.tokyofair_schedule_set_date_search(fap_jobfair_set_seq);
		logger.info("FAP 관리자 도쿄페어 일정 정보 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_set_update
	 * @Date : 2019. 9. 20.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 설정 정보 수정 
	 */
	public int tokyofair_schedule_set_update(SocietyFapAdminJobfairSet fap_jobfair_set) {
		logger.info("FAP 관리자 도쿄페어 설정 정보 수정 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		int result = sfaMapper.tokyofair_schedule_set_update(fap_jobfair_set);
		logger.info("FAP 관리자 도쿄페어 설정 정보 수정 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_set_date_delete
	 * @Date : 2019. 9. 20.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 날짜 정보 삭제
	 */
	public void tokyofair_schedule_set_date_delete(int fap_jobfair_seq) {
		logger.info("FAP 관리자 도쿄페어 일정 정보 삭제 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.tokyofair_schedule_set_date_delete(fap_jobfair_seq);
		logger.info("FAP 관리자 도쿄페어 일정 정보 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : tokyofair_screening_search_bookable
	 * @Date : 2019. 10. 13.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : 채용공고 리스트
	 * @Method 설명 : 관리자 도쿄페어 설명회,시험 등록가능 조회
	 */
	public ArrayList<HashMap<String, Object>> tokyofair_screening_search_bookable(int fap_jobfair_divide_seq){
		logger.info("FAP 관리자 도쿄페어 설명회,시험 등록가능 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> result = sfaMapper.tokyofair_screening_search_bookable(fap_jobfair_divide_seq);
		logger.info("FAP 관리자 도쿄페어 설명회,시험 등록가능 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyfair_schedule_booked_search
	 * @Date : 2019. 10. 13.
	 * @User : user
	 * @Param : 현지 잡페어 설정 시퀀스 , 등록된 일정 날짜
	 * @Return : 등록된 일정 정보 리스트
	 * @Method 설명 : 도쿄페어 등록된 일정 정보 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> tokyfair_schedule_booked_search(HashMap<String, Object> params){
		logger.info("FAP 관리자 도쿄페어 등록된 일정 정보 리스트 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		ArrayList<HashMap<String, Object>> result = sfaMapper.tokyfair_schedule_booked_search(params);
		logger.info("FAP 관리자 도쿄페어 등록된 일정 정보 리스트 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_member_duplicate_check
	 * @Date : 2019. 10. 10.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 인원 정보
	 * @Return : 중복된 인원 정보
	 * @Method 설명 : 도쿄페어 일정 인원 중복 체크
	 */
	public ArrayList<HashMap<String, Object>> tokyofair_schedule_member_duplicate_check(HashMap<String, Object> scheduleMap, ArrayList<HashMap<String, Object>> resumeList){
		logger.info("FAP 관리자 도쿄페어 일정 인원 중복 체크 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<HashMap<String, Object>> result = new ArrayList<>();
		for(HashMap<String, Object> member : resumeList) {
			HashMap<String, Object> params = new HashMap<>();
			params.put("fap_jobfair_set_seq", scheduleMap.get("fap_jobfair_set_seq"));
			params.put("fap_tokyofair_date_dt", scheduleMap.get("fap_tokyofair_date_dt"));
			params.put("fap_tokyofair_date_room_num", scheduleMap.get("fap_tokyofair_date_room_num"));
			params.put("fap_jobfair_itv_stu_dt", scheduleMap.get("fap_jobfair_itv_stu_dt"));
			params.put("fap_tokyofair_member_id", member.get("user_id"));
			params.put("fap_tokyofair_member_st", scheduleMap.get("fap_tokyofair_schedule_st"));
			params.put("fap_tokyofair_member_et", scheduleMap.get("fap_tokyofair_schedule_et"));
			
			HashMap<String, Object> checkMap = sfcMapper.tokyofair_schedule_member_duplicate_check(params); 
			if(checkMap != null) {
				result.add(checkMap);
			}
		}
		
		logger.info("FAP 관리자 도쿄페어 일정 인원 중복 체크 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_screening_insert_admin
	 * @Date : 2019. 10. 14.
	 * @User : 이종호
	 * @Param : 도쿄페어 설명회,시험 전형 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 설명회,시험 전형 등록 
	 */
	public void tokyofair_screening_insert_admin(HashMap<String, Object> params) {
		logger.info("FAP 관리자 도쿄페어 설명회,시험 전형 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.tokyofair_screening_insert_admin(params);
		logger.info("FAP 관리자 도쿄페어 설명회,시험 전형 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : tokyofair_scr_user_insert_admin
	 * @Date : 2019. 10. 14.
	 * @User : 이종호
	 * @Param : 도쿄페어 설명회,시험 전형 인원 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 설명회,시험 전형 인원 등록 
	 */
	public void tokyofair_scr_user_insert_admin(ArrayList<HashMap<String, Object>> list) {
		logger.info("FAP 관리자 도쿄페어 설명회,시험 전형 인원 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.tokyofair_scr_user_insert_admin(list);
		logger.info("FAP 관리자 도쿄페어 설명회,시험 전형 인원 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : tokyofair_schedule_date_check_admin
	 * @Date : 2019. 10. 14.
	 * @User : 이종호
	 * @Param : 도쿄페어 날짜정보
	 * @Return : 도쿄페어 날짜 시퀀스
	 * @Method 설명 : 이미 등록된 도쿄페어 날짜 시퀀스 조회
	 */
	public int tokyofair_schedule_date_check_admin(HashMap<String, Object> params) {
		logger.info("FAP 관리자 이미 등록된 도쿄페어 날짜 시퀀스 조회 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		Integer result = sfaMapper.tokyofair_schedule_date_check_admin(params);
		int fap_tokyofair_date_seq = result == null ? 0 : result;
		logger.info("FAP 관리자 이미 등록된 도쿄페어 날짜 시퀀스 조회 DAO 종료");
		return fap_tokyofair_date_seq;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_date_insert_admin
	 * @Date : 2019. 10. 14.
	 * @User : 이종호
	 * @Param : 도쿄페어 날짜정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 날짜 등록 
	 */
	public void tokyofair_schedule_date_insert_admin(HashMap<String, Object> params) {
		logger.info("FAP 관리자 도쿄페어 날짜 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.tokyofair_schedule_date_insert_admin(params);
		logger.info("FAP 관리자 도쿄페어 날짜 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : tokyofair_schedule_info_insert_admin
	 * @Date : 2019. 10. 14.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 일정 정보 등록 
	 */
	public void tokyofair_schedule_info_insert_admin(HashMap<String, Object> params) {
		logger.info("FAP 관리자 도쿄페어 일정 정보 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.tokyofair_schedule_info_insert_admin(params);
		logger.info("FAP 관리자 도쿄페어 일정 정보 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : tokyofair_member_insert_admin
	 * @Date : 2019. 10. 14.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 인원 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 일정 인원 정보 등록 
	 */
	public void tokyofair_member_insert_admin(ArrayList<HashMap<String, Object>> list) {
		logger.info("FAP 관리자 도쿄페어 일정 인원 정보 등록 DAO 시작");
		SocietyFapAdminCommonMapper sfaMapper = sqlSession.getMapper(SocietyFapAdminCommonMapper.class);
		sfaMapper.tokyofair_member_insert_admin(list);
		logger.info("FAP 관리자 도쿄페어 일정 인원 정보 등록 DAO 종료");
	}
}
