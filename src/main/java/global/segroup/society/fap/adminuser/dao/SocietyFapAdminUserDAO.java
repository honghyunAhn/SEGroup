/**
 * 
 */
package global.segroup.society.fap.adminuser.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.segroup.society.fap.admincommon.domain.SocietyFapJobfairApplicableTime;
import global.segroup.society.fap.adminuser.domain.SocietyFapAdminUserOfConflictedQuarter;
import global.segroup.util.PageNavigator;


/**
 * @Author : 정대영
 * @Date : 2018. 12. 5.
 * @Class 설명 : Soft Engineer Society 통합잡페어 관리자(유저기능담당) DAO
 * 
 */

@Repository
public class SocietyFapAdminUserDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyFapAdminUserDAO.class);
	
	@Autowired
	private SqlSession sqlSession;

	/**
	 * @Method Name : select_jobfair_divide_ad_apply_status_info
	 * @Date : 2019. 1. 8.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : HashMap
	 * @Method 설명 : FAP 관리자 잡페어 세부 별 채용공고 진행상황 리스트를 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_jobfair_divide_ad_apply_status_info(int fap_jobfair_divide_seq){
		logger.debug("FAP 관리자 잡페어 세부 별 채용공고 진행상황 셀렉트  DAO 시작");
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		ArrayList<HashMap<String, Object>> adApplyStatusInfoList = sfauMapper.select_jobfair_divide_ad_apply_status_info(fap_jobfair_divide_seq);
		logger.debug("FAP 관리자 잡페어 세부 별 채용공고 진행상황 셀렉트  DAO 종료");
		return adApplyStatusInfoList;
	}
	
	/**
	 * @Method Name : select_jobfair_divide_addition_comp_list
	 * @Date : 2019. 1. 8.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : HashMap
	 * @Method 설명 : FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고 리스트 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_jobfair_divide_addition_comp_list(int fap_jobfair_divide_seq){
		logger.debug("FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고 리스트 셀렉트 DAO 시작");
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		ArrayList<HashMap<String, Object>> additionCompList = sfauMapper.select_jobfair_divide_addition_comp_list(fap_jobfair_divide_seq);
		logger.debug("FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고 리스트 셀렉트 DAO 종료");
		return additionCompList;
	}
	
	/**
	 * @Method Name : insert_jobfair_divide_addition_comp_list
	 * @Date : 2019. 1. 8.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고로 설정(insert)
	 */
	public int insert_jobfair_divide_addition_comp_list(HashMap<String, Object> insertIntoAdditionalApplyInfoMap){
		logger.debug("FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고로 설정(insert) DAO 시작");
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		int insertResult = sfauMapper.insert_jobfair_divide_addition_comp_list(insertIntoAdditionalApplyInfoMap);
		logger.debug("FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고로 설정(insert) DAO 종료");
		return insertResult;
	}
	
	/**
	 * @Method Name : delete_jobfair_divide_addition_comp_list
	 * @Date : 2019. 1. 8.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고에서 설정 삭제
	 */
	public int delete_jobfair_divide_addition_comp_list(HashMap<String, Object> deleteFromAdditionalApplyInfoMap){
		logger.debug("FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고에서 설정 삭제 DAO 시작");
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		int deleteResult = sfauMapper.delete_jobfair_divide_addition_comp_list(deleteFromAdditionalApplyInfoMap);
		logger.debug("FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고에서 설정 삭제 DAO 종료");
		return deleteResult;
	}
	
	/**
	 * @Method Name : select_jobfair_divide_applicable_time
	 * @Date : 2019. 1. 9.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : HashMapList
	 * @Method 설명 : FAP 관리자 잡페어 세부별 지원가능 시간 조회
	 */
	public ArrayList<HashMap<String, Object>> select_jobfair_divide_applicable_time(int fap_jobfair_divide_seq){
		logger.debug("FAP 관리자 잡페어 세부별 지원가능 시간 조회  DAO 시작");
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		ArrayList<HashMap<String, Object>> applicableTimeList = sfauMapper.select_jobfair_divide_applicable_time(fap_jobfair_divide_seq);
		logger.debug("FAP 관리자 잡페어 세부별 지원가능 시간 조회  DAO 종료");
		return applicableTimeList;
	}
	
	/**
	 * @Method Name : resume_rule_apply_after_insert
	 * @Date : 2019. 1. 9.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 관리자 잡페어 세부별 룰 적용 후 룰 위반하지 않은 취업지원자 이력서 승인
	 */
	public int resume_rule_apply_after_insert(HashMap<String, Object> insertInfoMap){
		logger.debug("FAP 관리자 잡페어 세부별 룰 적용 후 룰 위반하지 않은 취업지원자 이력서 승인 DAO 시작");
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		int insertResultCount = sfauMapper.resume_rule_apply_after_insert(insertInfoMap);
		logger.debug("FAP 관리자 잡페어 세부별 룰 적용 후 룰 위반하지 않은 취업지원자 이력서 승인 DAO 종료");
		return insertResultCount;
	}
	
	/**
	 * @Method Name : apply_after_job_apply_info_update
	 * @Date : 2019. 1. 10.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 관리자 잡페어 세부별 취업지원자 이력서 승인후 채용정보지원 및 지원가능시간 승인으로 수정
	 */
	public int apply_after_job_apply_info_update(HashMap<String, Object> insertInfoMap){
		logger.debug("FAP 관리자 잡페어 세부별 취업지원자 이력서 승인후 채용정보지원 및 지원가능시간 승인으로 수정 DAO 시작");
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		int updateResultCount = sfauMapper.apply_after_job_apply_info_update(insertInfoMap);
		logger.debug("FAP 관리자 잡페어 세부별 취업지원자 이력서 승인후 채용정보지원 및 지원가능시간 승인으로 수정 DAO 종료");
		return updateResultCount;
	}
	
	/**
	 * @Method Name : not_applicant_apply_after_job_apply_info_update
	 * @Date : 2019. 1. 10.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 관리자 잡페어 세부별 취업지원자 이력서 승인후 채용정보지원 및 지원가능시간 승인으로 수정
	 */
	public int not_applicant_apply_after_job_apply_info_update(HashMap<String, Object> insertInfoMap){
		logger.debug("FAP 관리자 잡페어 세부별 취업지원자 이력서 승인후 채용정보지원 및 지원가능시간 승인으로 수정 DAO 시작");
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		int updateResultCount = sfauMapper.not_applicant_apply_after_job_apply_info_update(insertInfoMap);
		logger.debug("FAP 관리자 잡페어 세부별 취업지원자 이력서 승인후 채용정보지원 및 지원가능시간 승인으로 수정 DAO 종료");
		return updateResultCount;
	}
	
	/**
	 * @Method Name : select_is_applicable_time
	 * @Date : 2019. 8. 9.
	 * @User : 이종호
	 * @Param : 지원룰 관련 정보
	 * @Return : 지원가능시간 관리 시퀀스
	 * @Method 설명 : 채용공고별 지원가능시간 마감 여부 확인
	 */
	public Long select_is_applicable_time(HashMap<String, Object> params) {
		logger.info("FAP 관리자 채용공고별 지원가능시간 마감 여부 확인 DAO 시작");
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		Long fap_jobfair_applicable_time_seq = sfauMapper.select_is_applicable_time(params);
		logger.info("FAP 관리자 채용공고별 지원가능시간 마감 여부 확인 DAO 종료");
		return fap_jobfair_applicable_time_seq;
	}
	
	/**
	 * @Method Name : update_applicable_time_deadline_gb
	 * @Date : 2019. 8. 9.
	 * @User : 이종호
	 * @Param : 지원가능시간 관리 일련번호
	 * @Return : -
	 * @Method 설명 : 세부잡페어별 지원가능시간 최종적용여부 적용처리
	 */
	public void update_applicable_time_deadline_gb(long fap_jobfair_applicable_time_seq) {
		logger.info("FAP 관리자 세부잡페어별 지원가능시간 최종적용여부 적용처리 DAO 시작");
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		sfauMapper.update_applicable_time_deadline_gb(fap_jobfair_applicable_time_seq);
		logger.info("FAP 관리자 세부잡페어별 지원가능시간 최종적용여부 적용처리 DAO 종료");
	}
	
	/**
	 * @Method Name : delete_addition_apply_company
	 * @Date : 2019. 1. 10.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 관리자 잡페어 세부별 취업지원자 승인 후 추가지원가능기업 리셋
	 */
	public void delete_addition_apply_company(HashMap<String, Object> insertInfoMap){
		logger.debug("FAP 관리자 잡페어 세부별 취업지원자 승인 후 추가지원가능기업 리셋 DAO 시작");
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		sfauMapper.delete_addition_apply_company(insertInfoMap);
		logger.debug("FAP 관리자 잡페어 세부별 취업지원자 승인 후 추가지원가능기업 리셋 DAO 종료");
	}
	
	/**
	 * @Method Name : select_user_of_conflicted_quarter_info
	 * @Date : 2019. 1. 10.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : SocietyFapAdminUserOfConflictedQuarterList
	 * @Method 설명 : FAP 관리자 잡페어 세부 및 시간별, 채용공고별 지원자 정보 셀렉트
	 */
	public ArrayList<SocietyFapAdminUserOfConflictedQuarter> select_user_of_conflicted_quarter_info(HashMap<String, Object> approvalInsertInfoMap){
		logger.debug("FAP 관리자 잡페어 세부 및 시간별 채용공고별 쿼터 충돌된 지원자 정보 셀렉트 DAO 시작");
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		ArrayList<SocietyFapAdminUserOfConflictedQuarter> conflictedUserApplyInfoList = sfauMapper.select_user_of_conflicted_quarter_info(approvalInsertInfoMap);
		logger.debug("FAP 관리자 잡페어 세부 및 시간별 채용공고별 쿼터 충돌된 지원자 정보 셀렉트 DAO 종료");
		return conflictedUserApplyInfoList;
	}
	
	/**
	 * @Method Name : quarter_count_return_because_apply_fail
	 * @Date : 2019. 1. 14.
	 * @User : 정대영
	 * @Param : HashMap(SocietyFapAdminUserOfConflictedQuarterList)
	 * @Return : -
	 * @Method 설명 : FAP 관리자 잡페어 세부 및 시간별, 채용공고별 쿼터 충돌된 지원자 지망개수 회복
	 */
	public void quarter_count_return_because_apply_fail(HashMap<String, Object> finallyMustDeleteUserApplyInfoListMap){
		logger.debug("FAP 관리자 잡페어 세부 및 시간별, 채용공고별 쿼터 충돌된 지원자 지망개수 회복 DAO 시작");
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		sfauMapper.quarter_count_return_because_apply_fail(finallyMustDeleteUserApplyInfoListMap);
		logger.debug("FAP 관리자 잡페어 세부 및 시간별, 채용공고별 쿼터 충돌된 지원자 지망개수 회복 DAO 끝");
	}
	
	/**
	 * @Method Name : delete_user_of_conflicted_quarter_info
	 * @Date : 2019. 1. 14.
	 * @User : 정대영
	 * @Param : HashMap(SocietyFapAdminUserOfConflictedQuarterList)
	 * @Return : -
	 * @Method 설명 : FAP 관리자 잡페어 세부 및 시간별, 채용공고별 쿼터 충돌된 지원자 정보 삭제
	 */
	public void delete_user_of_conflicted_quarter_info(HashMap<String, Object> finallyMustDeleteUserApplyInfoListMap){
		logger.debug("FAP 관리자 잡페어 세부 및 시간별 채용공고별 쿼터 충돌된 지원자 정보 삭제 DAO 시작");
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		sfauMapper.delete_user_of_conflicted_quarter_info(finallyMustDeleteUserApplyInfoListMap);
		logger.debug("FAP 관리자 잡페어 세부 및 시간별 채용공고별 쿼터 충돌된 지원자 정보 삭제 DAO 끝");
	}
	
	/**
	 * @Method Name : insert_apply_final_result_tb
	 * @Date : 2019. 2. 21.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : -
	 * @Method 설명 : FAP 관리자 전형별지원결과정보에 인서트 후 최종결과정보에 한번 더 인서트
	 */
	public void insert_apply_final_result_tb(HashMap<String, Object> insertInfoMap){
		logger.debug("FAP 관리자 전형별지원결과정보에 인서트 후 최종결과정보에 한번 더 인서트 DAO 시작");
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		sfauMapper.insert_apply_final_result_tb(insertInfoMap);
		logger.debug("FAP 관리자 전형별지원결과정보에 인서트 후 최종결과정보에 한번 더 인서트 DAO 끝");
	}

	/**
	 * @Method Name : insert_jobfair_apply_rule_info
	 * @Date : 2019. 8. 9.
	 * @User : 김경아
	 * @Param : 지원룰 테이블에 추가될 정보
	 * @Return : 지원룰 테이블 정보 추가여부 
	 * @Method 설명 : 채용공고 관련 정보 추가시 지원룰 테이블에 관련 정보 추가
	 */
	public int insert_jobfair_apply_rule_info(HashMap<String, Object> insertIntoAdditionalApplyInfoMap) {
		logger.debug("FAP 관리자 채용공고 관련 정보 추가시 지원룰 테이블에 관련 정보 추가 DAO 시작");
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		int result = sfauMapper.insert_jobfair_apply_rule_info(insertIntoAdditionalApplyInfoMap);
		logger.debug("FAP 관리자 채용공고 관련 정보 추가시 지원룰 테이블에 관련 정보 추가 DAO 종료");
		return result; 
	}

	/**
	 * @Method Name : delete_jobfair_apply_rule_info
	 * @Date : 2019. 8. 9.
	 * @User : 김경아
	 * @Param : 지원룰 테이블에 삭제될 정보
	 * @Return : 지원룰 테이블 정보 삭제여부 
	 * @Method 설명 : 채용공고 관련 정보 삭제시 지원룰 테이블에 관련 정보 삭제
	 */
	public int delete_jobfair_apply_rule_info(HashMap<String, Object> deleteFromAdditionalApplyInfoMap) {
		logger.debug("FAP 관리자 채용공고 관련 정보 추가시 지원룰 테이블에 관련 정보 삭제 DAO 시작");
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		int result = sfauMapper.delete_jobfair_apply_rule_info(deleteFromAdditionalApplyInfoMap);
		logger.debug("FAP 관리자 채용공고 관련 정보 추가시 지원룰 테이블에 관련 정보 삭제 DAO 종료");
		return result; 
	}
	
	/**
	 * @Method Name : select_jobfair_applicable_time_nm_list
	 * @Date : 2019. 8. 6.
	 * @User : 이종호
	 * @Param : 세부잡페어 시퀀스
	 * @Return : 지원가능 시간 명칭 리스트
	 * @Method 설명 : 세부잡페어별 지원가능 시간 명칭 리스트 조회
	 */
	public ArrayList<SocietyFapJobfairApplicableTime> select_jobfair_applicable_time_nm_list(int fap_jobfair_divide_seq){
		logger.info("FAP 관리자 세부잡페어별 지원가능 시간 명칭 리스트 조회 DAO 시작");
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		ArrayList<SocietyFapJobfairApplicableTime> result = sfauMapper.select_jobfair_applicable_time_nm_list(fap_jobfair_divide_seq);
		logger.info("FAP 관리자 세부잡페어별 지원가능 시간 명칭 리스트 조회 DAO 종료");
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
	public ArrayList<HashMap<String, Object>> select_jobfair_applicable_ad_list(HashMap<String, Object> params,PageNavigator navi){
		logger.info("FAP 관리자 세부 채용공고별 지원룰 대상 채용공고 리스트 조회 DAO 시작");
		RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());
		
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		ArrayList<HashMap<String, Object>> result = sfauMapper.select_jobfair_applicable_ad_list(params,rb);
		logger.info("FAP 관리자 세부 채용공고별 지원룰 대상 채용공고 리스트 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_jobfair_applicable_ad_list_count
	 * @Date : 2019. 8. 7.
	 * @User : 이종호
	 * @Param : 채용공고 지원가능시간 시퀀스
	 * @Return : 지원룰 대상 채용공고 리스트 갯수 
	 * @Method 설명 : 세부 채용공고별 지원룰 대상 채용공고 리스트 갯수 조회
	 */
	public int select_jobfair_applicable_ad_list_count(long fap_jobfair_applicable_time_seq) {
		logger.info("FAP 관리자 세부 채용공고별 지원룰 대상 채용공고 리스트 갯수 조회 DAO 시작");
		SocietyFapAdminUserMapper sfauMapper = sqlSession.getMapper(SocietyFapAdminUserMapper.class);
		int result = sfauMapper.select_jobfair_applicable_ad_list_count(fap_jobfair_applicable_time_seq);
		logger.info("FAP 관리자 세부 채용공고별 지원룰 대상 채용공고 리스트 갯수 조회 DAO 종료");
		return result;
	}
}
