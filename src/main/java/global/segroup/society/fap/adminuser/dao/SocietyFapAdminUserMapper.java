/**
 * 
 */
package global.segroup.society.fap.adminuser.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;

import global.segroup.society.fap.admincommon.domain.SocietyFapJobfairApplicableTime;
import global.segroup.society.fap.adminuser.domain.SocietyFapAdminUserOfConflictedQuarter;

/**
 * @Author : 정대영
 * @Date : 2018. 12. 5.
 * @Class 설명 : Soft Engineer Society 통합잡페어 관리자(유저기능담당) mapper
 * 
 */
public interface SocietyFapAdminUserMapper {
	
	/**
	 * @Method Name : select_jobfair_divide_ad_apply_status_info
	 * @Date : 2019. 1. 8.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : HashMap
	 * @Method 설명 : FAP 관리자 잡페어 세부 별 채용공고 진행상황 리스트를 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_jobfair_divide_ad_apply_status_info(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : select_jobfair_divide_addition_comp_list
	 * @Date : 2019. 1. 8.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : HashMap
	 * @Method 설명 : FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고 리스트 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_jobfair_divide_addition_comp_list(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : insert_jobfair_divide_addition_comp_list
	 * @Date : 2019. 1. 8.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고로 설정(insert)
	 */
	public int insert_jobfair_divide_addition_comp_list(HashMap<String, Object> insertIntoAdditionalApplyInfoMap);
	
	/**
	 * @Method Name : delete_jobfair_divide_addition_comp_list
	 * @Date : 2019. 1. 8.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고에서 설정 삭제
	 */
	public int delete_jobfair_divide_addition_comp_list(HashMap<String, Object> deleteFromAdditionalApplyInfoMap);
	
	/**
	 * @Method Name : select_jobfair_divide_applicable_time
	 * @Date : 2019. 1. 9.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : HashMapList
	 * @Method 설명 : FAP 관리자 잡페어 세부별 지원가능 시간 조회
	 */
	public ArrayList<HashMap<String, Object>> select_jobfair_divide_applicable_time(int fap_jobfair_divide_seq);

	/**
	 * @Method Name : resume_rule_apply_after_insert
	 * @Date : 2019. 1. 9.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 관리자 잡페어 세부별 룰 적용 후 룰 위반하지 않은 취업지원자 이력서 승인
	 */
	public int resume_rule_apply_after_insert(HashMap<String, Object> insertInfoMap);
	
	/**
	 * @Method Name : apply_after_job_apply_info_update
	 * @Date : 2019. 1. 10.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 관리자 잡페어 세부별 취업지원자 이력서 승인후 채용정보지원 및 지원가능시간 승인으로 수정
	 */
	public int apply_after_job_apply_info_update(HashMap<String, Object> ignoreInsertInfoMap);
	
	/**
	 * @Method Name : not_applicant_apply_after_job_apply_info_update
	 * @Date : 2019. 1. 10.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 관리자 잡페어 세부별 취업지원자 이력서 승인후 채용정보지원 및 지원가능시간 승인으로 수정
	 */
	public int not_applicant_apply_after_job_apply_info_update(HashMap<String, Object> insertInfoMap);
	
	/**
	 * @Method Name : select_is_applicable_time
	 * @Date : 2019. 8. 9.
	 * @User : 이종호
	 * @Param : 지원룰 관련 정보
	 * @Return : 지원가능시간 관리 시퀀스
	 * @Method 설명 : 채용공고별 지원가능시간 마감 여부 확인
	 */
	public Long select_is_applicable_time(HashMap<String, Object> params);
	
	/**
	 * @Method Name : update_applicable_time_deadline_gb
	 * @Date : 2019. 8. 9.
	 * @User : 이종호
	 * @Param : 지원가능시간 관리 일련번호
	 * @Return : -
	 * @Method 설명 : 세부잡페어별 지원가능시간 최종적용여부 적용처리
	 */
	public void update_applicable_time_deadline_gb(long fap_jobfair_applicable_time_seq);
	
	/**
	 * @Method Name : delete_addition_apply_company
	 * @Date : 2019. 1. 10.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : -
	 * @Method 설명 : FAP 관리자 잡페어 세부별 취업지원자 승인 후 추가지원가능기업 리셋
	 */
	public void delete_addition_apply_company(HashMap<String, Object> insertInfoMap);
	
	/**
	 * @Method Name : select_user_of_conflicted_quarter_info
	 * @Date : 2019. 1. 10.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : SocietyFapAdminUserOfConflictedQuarterList
	 * @Method 설명 : FAP 관리자 잡페어 세부 및 시간별, 채용공고별 지원자 정보 셀렉트
	 */
	public ArrayList<SocietyFapAdminUserOfConflictedQuarter> select_user_of_conflicted_quarter_info(HashMap<String, Object> approvalInsertInfoMap);
	
	/**
	 * @Method Name : quarter_count_return_because_apply_fail
	 * @Date : 2019. 1. 14.
	 * @User : 정대영
	 * @Param : HashMap(SocietyFapAdminUserOfConflictedQuarterList)
	 * @Return : -
	 * @Method 설명 : FAP 관리자 잡페어 세부 및 시간별, 채용공고별 쿼터 충돌된 지원자 지망개수 회복
	 */
	public void quarter_count_return_because_apply_fail(HashMap<String, Object> finallyMustDeleteUserApplyInfoListMap);
	
	/**
	 * @Method Name : delete_user_of_conflicted_quarter_info
	 * @Date : 2019. 1. 14.
	 * @User : 정대영
	 * @Param : HashMap(SocietyFapAdminUserOfConflictedQuarterList)
	 * @Return : -
	 * @Method 설명 : FAP 관리자 잡페어 세부 및 시간별, 채용공고별 쿼터 충돌된 지원자 정보 삭제
	 */
	public void delete_user_of_conflicted_quarter_info(HashMap<String, Object> finallyMustDeleteUserApplyInfoListMap);
	
	/**
	 * @Method Name : insert_apply_final_result_tb
	 * @Date : 2019. 2. 21.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : -
	 * @Method 설명 : FAP 관리자 전형별지원결과정보에 인서트 후 최종결과정보에 한번 더 인서트
	 */
	public void insert_apply_final_result_tb(HashMap<String, Object> insertInfoMap);

	/**
	 * @Method Name : insert_jobfair_apply_rule_info
	 * @Date : 2019. 8. 9.
	 * @User : 김경아
	 * @Param : 지원룰 테이블에 추가될 정보
	 * @Return : 지원룰 테이블 정보 추가여부 
	 * @Method 설명 : 채용공고 관련 정보 추가시 지원룰 테이블에 관련 정보 추가
	 */
	public int insert_jobfair_apply_rule_info(HashMap<String, Object> insertIntoAdditionalApplyInfoMap);

	/**
	 * @Method Name : delete_jobfair_apply_rule_info
	 * @Date : 2019. 8. 9.
	 * @User : 김경아
	 * @Param : 지원룰 테이블에 삭제될 정보
	 * @Return : 지원룰 테이블 정보 삭제여부 
	 * @Method 설명 : 채용공고 관련 정보 삭제시 지원룰 테이블에 관련 정보 삭제
	 */
	public int delete_jobfair_apply_rule_info(HashMap<String, Object> deleteFromAdditionalApplyInfoMap);

	/**
	 * @Method Name : select_jobfair_applicable_time_nm_list
	 * @Date : 2019. 8. 6.
	 * @User : 이종호
	 * @Param : 세부잡페어 시퀀스
	 * @Return : 지원가능 시간 명칭 리스트
	 * @Method 설명 : 세부잡페어별 지원가능 시간 명칭 리스트 조회
	 */
	public ArrayList<SocietyFapJobfairApplicableTime> select_jobfair_applicable_time_nm_list(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : select_jobfair_applicable_ad_list
	 * @Date : 2019. 8. 7.
	 * @User : 이종호
	 * @Param : 채용공고 지원가능시간 시퀀스
	 * @Return : 지원룰 대상 채용공고 리스트
	 * @Method 설명 : 세부 채용공고별 지원룰 대상 채용공고 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> select_jobfair_applicable_ad_list(HashMap<String, Object> params,RowBounds rb);
	
	/**
	 * @Method Name : select_jobfair_applicable_ad_list_count
	 * @Date : 2019. 8. 7.
	 * @User : 이종호
	 * @Param : 채용공고 지원가능시간 시퀀스
	 * @Return : 지원룰 대상 채용공고 리스트 갯수 
	 * @Method 설명 : 세부 채용공고별 지원룰 대상 채용공고 리스트 갯수 조회
	 */
	public int select_jobfair_applicable_ad_list_count(long fap_jobfair_applicable_time_seq);
}
