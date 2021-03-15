/**
 * 
 */
package global.segroup.society.fap.admincommon.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

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

/**
 * @Author : 신동철
 * @Date : 2018. 11. 29.
 * @Class 설명 : Soft Engineer Society 통합잡페어 관리자 매퍼
 * 
 */
public interface SocietyFapAdminCommonMapper {
		
	
	/**
	 * @Method Name : insert_jobfair
	 * @Date : 2018. 12. 11.
	 * @User : 신동철
	 * @Param : 잡페어 객체
	 * @Return : -
	 * @Method 설명 : 통합잡페어 등록
	 */
	public void insert_jobfair(SocietyFapAdminJobfair sfaJobfair);
	
	/**
	 * @Method Name : insert_jobfair_lo
	 * @Date : 2018. 12. 11.
	 * @User : 신동철
	 * @Param : 잡페어 개최지 리스트
	 * @Return : -
	 * @Method 설명 : 통합잡페어 개최지 등록
	 */
	public void insert_jobfair_lo(ArrayList<SocietyFapAdminJobfairLo> sfaJobfairLoList);
	/**
	 * @Method Name : insert_jobfair_divide
	 * @Date : 2018. 12. 11.
	 * @User : 신동철
	 * @Param : 잡페어 세부정보 리스트
	 * @Return : -
	 * @Method 설명 : 통합잡페어 세부정보 등록
	 */
	public void insert_jobfair_divide(SocietyFapAdminJobfairDivide sfaJobfairDivide);
		
	/**
	 * @Method Name : insert_jobfair_divide_rc
	 * @Date : 2018. 12. 11.
	 * @User : 신동철
	 * @Param : 잡페어 세부채용대상 리스트
	 * @Return : -
	 * @Method 설명 : 통합잡페어 세부채용대상 등록
	 */
	public void insert_jobfair_divide_rc(ArrayList<SocietyFapAdminJobfairDivideRc> sfaJobfairDivideRcList);
	
	/**
	 * @Method Name : select_fap_jobfair_info
	 * @Date : 2018. 12. 13.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 선택한 잡페어 전체 정보
	 * @Method 설명 : 선택한 잡페어 전체 정보 검색
	 */
	public HashMap<String, Object> select_fap_jobfair_info(int fap_jobfair_seq);
	
	/**
	 * @Method Name : jobfair_search_list
	 * @Date : 2018. 12. 14.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 통합잡페어 정보
	 * @Method 설명 : 통합잡페어 정보 리스트 검색
	 */
	public ArrayList<SocietyFapAdminJobfair> jobfair_search_list(HashMap<String, Object>hashmap);
	
	/**
	 * @Method Name : select_fap_jobfair
	 * @Date : 2018. 12. 14.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 특정의 잡페어 정보
	 * @Method 설명 : 특정의 잡페어 정보 검색
	 */
	public SocietyFapAdminJobfair select_fap_jobfair(int fap_jobfair_seq);
	
	/**
	 * @Method Name : select_fap_jobfair_divide
	 * @Date : 2018. 12. 14.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 통합잡페어 세부정보
	 * @Method 설명 : 통합잡페어 세부정보 검색
	 */
	public ArrayList<SocietyFapAdminJobfairDivide> select_fap_jobfair_divide(int fap_jobfair_seq);
	
	/**
	 * @Method Name : delete_fap_jobfair
	 * @Date : 2018. 12. 14.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스
	 * @Return : -
	 * @Method 설명 : 잡페어 삭제
	 */
	public void delete_fap_jobfair(int fap_jobfair_seq);
		
	/**
	 * @Method Name : update_jobfair
	 * @Date : 2018. 12. 18.
	 * @User : 신동철
	 * @Param : 잡페어정보
	 * @Return : -
	 * @Method 설명 : 잡페어정보 수정
	 */
	public void update_jobfair(SocietyFapAdminJobfair sfaJobfair);
	
	/**
	 * @Method Name : update_fap_jobfair_lo
	 * @Date : 2018. 12. 18.
	 * @User : 신동철
	 * @Param : 잡페어 개최지 정보
	 * @Return : -
	 * @Method 설명 : 잡페어 개최지 정보 수정
	 */
	public void update_jobfair_lo(ArrayList<SocietyFapAdminJobfairLo> sfaJobfairLo);
	
	/**
	 * @Method Name : update_fap_jobfair_divide
	 * @Date : 2018. 12. 18.
	 * @User : 신동철
	 * @Param : 잡페어 세부 정보
	 * @Return : -
	 * @Method 설명 : 잡페어 세부 정보 수정
	 */
	public void update_jobfair_divide(SocietyFapAdminJobfairDivide sfaJobfairDivide);
	
	/**
	 * @Method Name : update_fap_jobfair_divide_rc
	 * @Date : 2018. 12. 18.
	 * @User : 신동철
	 * @Param : 잡페어 세부 채용대상 정보
	 * @Return : -
	 * @Method 설명 : 잡페어 세부 채용대상 정보 수정
	 */
	public void update_jobfair_divide_rc(ArrayList<SocietyFapAdminJobfairDivideRc> sfaJobfairDivideRc);
	
	/**
	 * @Method Name : update_jobfair_unchecked_divide_rc
	 * @Date : 2018. 12. 19.
	 * @User : 신동철
	 * @Param : 잡페어 세부 미선택 채용대상 정보
	 * @Return : -
	 * @Method 설명 : 잡페어 세부 미선택 채용대상 정보 수정
	 */
	public void update_jobfair_unchecked_divide_rc(ArrayList<SocietyFapAdminJobfairDivideRc> sfaJobfairDivideRc);
	
	/**
	 * @Method Name : search_jobfair_user_apply_info
	 * @Date : 2018. 12. 20.
	 * @User : 신동철
	 * @Param : (잡페어 시퀀스, 회원타입, 승인여부, 이름)
	 * @Return : 잡페어 지원자 등록정보
	 * @Method 설명 : 잡페어 지원자 등록정보 검색
	 */
	public ArrayList<HashMap<String, Object>> search_jobfair_user_apply_info(HashMap<String, Object> hashmap);
	
	/**
	 * @Method Name : jobfair_user_apply_permission
	 * @Date : 2018. 12. 21.
	 * @User : 신동철
	 * @Param : 지원자 잡페어 신청 등록 시퀀스 리스트
	 * @Return : -
	 * @Method 설명 : 잡페어 지원자 신청 승인
	 */
	public void jobfair_user_apply_permission(ArrayList<SocietyFapAdminJobfairApply> sfaJobfairApplyList);
	
	/**
	 * @Method Name : insert_apply_max_num
	 * @Date : 2018. 12. 28.
	 * @User : 신동철
	 * @Param : 잡페어 객체
	 * @Return : -
	 * @Method 설명 : 잡페어 지원가능인원 등록
	 */
	public void insert_apply_max_num(SocietyFapAdminJobfair sfaJobfair);
	
	/**
	 * @Method Name : insert_limit_interview
	 * @Date : 2019. 7. 30.
	 * @User : 이종호
	 * @Param : 잡페어 현지면접 인원제한 정보
	 * @Return : -
	 * @Method 설명 : 잡페어 현지면접 인원제한 정보 등록
	 */
	public void insert_limit_interview(SocietyFapAdminLimitInterview limitInterview);
	
	/**
	 * @Method Name : update_limit_interview
	 * @Date : 2019. 7. 30.
	 * @User : 이종호
	 * @Param : 잡페어 현지면접 인원제한 정보
	 * @Return : -
	 * @Method 설명 : 잡페어 현지면접 인원제한 정보 수정
	 */
	public void update_limit_interview(SocietyFapAdminLimitInterview limitInterview);
	
	/**
	 * @Method Name : update_apply_max_num
	 * @Date : 2018. 12. 28.
	 * @User : 신동철
	 * @Param : 잡페어 객체
	 * @Return : -
	 * @Method 설명 : 잡페어 지원가능인원 수정
	 */
	public void update_apply_max_num(SocietyFapAdminJobfair sfaJobfair);
	
	/**
	 * @Method Name : insert_comp_group_set
	 * @Date : 2018. 12. 30.
	 * @User : 신동철
	 * @Param : 회사그룹 설정 객체
	 * @Return : -
	 * @Method 설명 : 회사그룹 설정 등록
	 */
	public void insert_comp_group_set(ArrayList<SocietyFapAdminJobfairCompGroup> sfaCompGroupList);
	
	/**
	 * @Method Name : update_comp_group_set
	 * @Date : 2018. 12. 30.
	 * @User : 신동철
	 * @Param : 회사그룹 설정 객체
	 * @Return : -
	 * @Method 설명 : 회사그룹 설정 수정
	 */
	public void update_comp_group_set(ArrayList<SocietyFapAdminJobfairCompGroup> sfaCompGroupList);
	
	/**
	 * @Method Name : delete_comp_group_set
	 * @Date : 2018. 12. 30.
	 * @User : 신동철
	 * @Param : 회사그룹 설정 객체
	 * @Return : -
	 * @Method 설명 : 회사그룹 설정 삭제
	 */
	public void delete_comp_group_set(int fap_jobfair_seq);
	
	/**
	 * @Method Name : delete_jobfair_lo
	 * @Date : 2018. 12. 30.
	 * @User : 신동철
	 * @Param : 잡페어 개최지 시퀀스
	 * @Return : -
	 * @Method 설명 : 잡페어 개최지 삭제
	 */
	public void delete_jobfair_lo(int fap_jobfair_lo_seq);
	
	/**
	 * @Method Name : delete_fap_jobfair_divide
	 * @Date : 2018. 12. 30.
	 * @User : 신동철
	 * @Param : 잡페어 세부정보 시퀀스
	 * @Return : -
	 * @Method 설명 : 잡페어 세부정보 삭제
	 */
	public void delete_fap_jobfair_divide(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : delete_fap_jobfair_divide_rc
	 * @Date : 2018. 12. 30.
	 * @User : 신동철
	 * @Param : 잡페어 세부채용대상 시퀀스
	 * @Return : -
	 * @Method 설명 : 잡페어 세부채용대상 삭제
	 */
	public void delete_fap_jobfair_divide_rc(int fap_jobfair_divide_rc_seq);

	/**
	 * @Method Name : select_all_fap_jobfair
	 * @Date : 2018. 12. 31.
	 * @User : 남유송
	 * @Param : -
	 * @Return : 잡페어 정보 객체
	 * @Method 설명 : 잡페어 정보 리스트 검색
	 */
	public ArrayList<SocietyFapAdminJobfair> select_all_fap_jobfair();
	
	/**
	 * @Method Name : select_user_list
	 * @Date : 2019. 3. 4.
	 * @User : 정병준
	 * @Param : -
	 * @Return : 회원 리스트를 가져오는 함수
	 * @Method 설명 : 회원 리스트를 가져오는 함수
	 */
	public ArrayList<User> select_user_list(HashMap<String, Object> map);
	
	/**
	 * @Method Name : select_user_list
	 * @Date : 2019. 3. 4.
	 * @User : 정병준
	 * @Param : -
	 * @Return : 회원 리스트 개수를 가져오는 함수
	 * @Method 설명 : 회원 리스트 개수를 가져오는 함수
	 */
	public int select_user_list_count(HashMap<String, Object> map);
	
	/**
	 * @Method Name : select_company_list
	 * @Date : 2019. 1. 2.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 기업 리스트를 가져오는 함수
	 * @Method 설명 : 기업 리스트를 가져오는 함수
	 */
	public ArrayList<SocietyFapCompanyUser> select_company_list(RowBounds rb, HashMap<String, Object> paramMap);
	
	/**
	 * @Method Name : select_all_job_fair_divide
	 * @Date : 2019. 1. 2.
	 * @User : 남유송
	 * @Param : Int
	 * @Return : ArrayList
	 * @Method 설명 : 잡페어별 잡페어 상세 구분코드, 일련번호 출력
	 */
	public ArrayList<HashMap<String, Object>> select_all_job_fair_divide(int fap_jobfair_seq);

	/**
	 * @Method Name : read_all_job_fair_ad_list
	 * @Date : 2018. 01. 02.
	 * @User : 남유송
	 * @Param : int
	 * @Return : HashMap
	 * @Method 설명 : 잡페어별 채용공고 리스트 출력
	 */
	public ArrayList<HashMap<String, Object>> select_jobfair_job_ad(HashMap<String, Object> params);

	/**
	 * @Method Name : applicant_list_per_job_ad
	 * @Date : 2018. 01. 03.
	 * @User : 남유송
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 지원자 리스트 출력 페이지 )
	 * @Method 설명 : 기업별 지원자 현황 페이지에서 채용공고별 지원자 리스트 출력 페이지
	 */
	public ArrayList<HashMap<String, Object>> select_applicant_list(int fap_job_ad_seq);

	/**
	 * @Method Name : select_personal_user
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 회원 아이디
	 * @Return : 공통 회원 객체, 개인 회원 객체
	 * @Method 설명 : 회원이 가지오 있는 개인 회원 정보를 가져오는 함수
	 */
	public HashMap<String, Object> select_personal_user(String user_id);
	
	/**
	 * @Method Name : select_personal_school
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 개인 회원 객체
	 * @Return : 회원 학교 정보 객체
	 * @Method 설명 : 개인 회원이 가지고 있는 학교 정보를 가져오는 함수
	 */
	public HashMap<String, Object> select_personal_school(HashMap<String, Object> hashMap);
	
	/**
	 * @Method Name : insert_personal_hs
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 개인 회원 고등학교 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원의 고등학교를 등록 하는 함수
	 */
	public void insert_personal_hs(SocietyFapPersonalHighschool societyFapPersonalHighschool);
	
	/**
	 * @Method Name : insert_personal_univ
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 개인 회원 대학교 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원의 대학교을 등록 하는 함수 
	 */
	public void insert_personal_univ(SocietyFapPersonalUniversity societyFapPersonalUniversity);
	
	/**
	 * @Method Name : insert_personal_grad
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 개인 회원 대학원 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원의 대학원을 등록 하는 함수
	 */
	public void insert_personal_grad(SocietyFapPersonalGraduate societyFapPersonalGraduate);
	
	/**
	 * @Method Name : update_com_user
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 공통 회원 객체
	 * @Return : -
	 * @Method 설명 : 공통 회원 정보를 수정
	 */
	public void update_com_user(User user);
	
	/**
	 * @Method Name : update_personal_user
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 개인 회원 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원 정보를 수정
	 */
	public void update_personal_user(SocietyFapPersonalUser societyFapPersonalUser);
	
	/**
	 * @Method Name : update_user_hs
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 개인 회원의 고등학교 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원의 고등학교 정보를 수정
	 */
	public void update_user_hs(SocietyFapPersonalHighschool societyFapPersonalHighschool);
	
	/**
	 * @Method Name : update_user_univ
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 개인 회원의 대학교 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원의 대학교 정보를 수정
	 */
	public void update_user_univ(SocietyFapPersonalUniversity societyFapPersonalUniversity);
	
	/**
	 * @Method Name : update_user_grad
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 개인 회원의 대학원 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원의 대학원 정보를 수정
	 */
	public void update_user_grad(SocietyFapPersonalGraduate societyFapPersonalGraduate);
	
	/**
	 * @Method Name : delete_user_hs
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 고등학교 seq
	 * @Return : -
	 * @Method 설명 : 개인 회원의 고등학교 삭제
	 */
	public void delete_user_hs(int fap_personal_user_seq);
	
	/**
	 * @Method Name : delete_user_univ
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 대학교 seq
	 * @Return : -
	 * @Method 설명 : 개인 회원의 대학교 삭제
	 */
	public void delete_user_univ(int fap_personal_user_seq);
	
	/**
	 * @Method Name : delete_user_grad
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 대학원 seq
	 * @Return : -
	 * @Method 설명 : 개인 회원의 대학원 삭제
	 */
	public void delete_user_grad(int grad_seq);
	
	/**
	 * @Method Name : delete_user_info
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 탈퇴할 회원 객체
	 * @Return : -
	 * @Method 설명 : 회원 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(30글자) 변경후 참조 테이블에 적용
	 */
	public void delete_user_info(HashMap<String, String> updateMap);
	
	/**
	 * @Method Name : select_user
	 * @Date : 2019. 1. 3. 김준영
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 공통 유저 객체
	 * @Method 설명 : 공통 유저 객체를 불러오는 함수
	 */
	public User select_user(String user_id);
	
	/**
	 * @Method Name : update_user
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 공통 회원 객체
	 * @Return : -
	 * @Method 설명 : 공통 회원 정보를 수정하는 함수
	 */
	public void update_user(User user);
	
	/**
	 * @Method Name : select_company
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 기업 아이디
	 * @Return : 기업 객체
	 * @Method 설명 : 해당하는 아이디의 기업 정보를 가져오는 함수
	 */
	public SocietyFapCompanyUser select_company(String fap_comp_id);
	
	/**
	 * @Method Name : update_company
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 기업 정보 객체
	 * @Return : -
	 * @Method 설명 : 기업 정보를 업데이트 하는 함수
	 */
	public void update_company(SocietyFapCompanyUser societyFapCompanyUser);
	
	/**
	 * @Method Name : insert_email
	 * @Date : 2019. 1. 15.
	 * @User : 전상수
	 * @Param : DB에 저장될 이메일 객체
	 * @Return : -
	 * @Method 설명 : 이메일을 DB에 등록하는 함수
	 */
	public void insert_email(HashMap<String, Object> allMailList);
	
	
	/**
	 * @Method Name : select_email
	 * @Date : 2019. 1. 15.
	 * @User : 전상수
	 * @Param : -
	 * @Return : DB에 저장되어있는 이메일 객체들
	 * @Method 설명 : 이메일 리스트를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_email(HashMap<String,String>data,RowBounds rb);
	

	/**
	 * @Method Name : select_email_content
	 * @Date : 2019. 1. 15.
	 * @User : 전상수
	 * @Param : -
	 * @Return : DB에 저장되어있는 이메일 객체들
	 * @Method 설명 : 이메일 리스트를 가져오는 함수
	 */
	public String select_email_content(String uid);
	
	
	/**
	 * @Method Name : select_email_max_uid
	 * @Date : 2019. 1. 15.
	 * @User : 전상수
	 * @Param : -
	 * @Return : DB에 저장되어있는 이메일중 가장 최근의 것의 UID
	 * @Method 설명 : 이메일들중 가장 UID가 최근의 것을 가져오는 함수
	 */
	public HashMap<String, Object> select_email_max_uid();

	/**
	 * @Method Name : select_email_max_uid
	 * @Date : 2019. 1. 15.
	 * @User : 전상수
	 * @Param : -
	 * @Return : DB에 저장되어있는 이메일중 가장 최근의 것의 UID
	 * @Method 설명 : 이메일들중 가장 UID가 최근의 것을 가져오는 함수
	 */
	public int select_count_email(HashMap<String,String>data);

	/**
	 * @Method Name : insert_jobfair_applicable_time
	 * @Date : 2019. 01. 03.
	 * @User : 신동철
	 * @Param : 채용공고 지원가능시간 정보
	 * @Return : -
	 * @Method 설명 : 취업지원자 채용공고 지원가능시간 등록
	 */
	public void insert_jobfair_applicable_time(List<SocietyFapJobfairApplicableTime> jobfair_applicable_time_list);

	/**
	 * @Method Name : comp_user_connect_tb
	 * @Date : 2019. 1. 4.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 담당자 - 기업 연결 객체
	 * @Method 설명 : 담당자 - 기업 연결 리스트를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_comp_user_connect();
	
	/**
	 * @Method Name : connect_update
	 * @Date : 2019. 1. 4.
	 * @User : 김준영
	 * @Param : 변경 리스트, 승인 상태
	 * @Return : -
	 * @Method 설명 : 선택한 리스트의 승인 상태를 바꿔주는 함수
	 */
	public void connect_update(HashMap<String, Object> hashMap);
	/**
	 * @Method Name : update_jobfair_applicable_time
	 * @Date : 2019. 1. 4.
	 * @User : 신동철
	 * @Param : 취업지원자 채용공고 지원가능시간 정보
	 * @Return : -
	 * @Method 설명 : 취업지원자 채용공고 지원가능시간 수정
	 */
	public void update_jobfair_applicable_time(List<SocietyFapJobfairApplicableTime> jobfairApplicableTimeList);
	
	/**
	 * @Method Name : connect_all_update
	 * @Date : 2019. 1. 4.
	 * @User : 김준영
	 * @Param : 변경 대상 승인 상태, 변경 할 승인 상태
	 * @Return : -
	 * @Method 설명 : 변경 대상을 변경 할 승인 상태로 바꿔주는 함수
	 */
	public void connect_all_update(HashMap<String, Object> hashMap);
	
	/**
	 * @Method Name : connect_delete
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : 삭제 할 담당자 - 기업 연결 객체 seq
	 * @Return : -
	 * @Method 설명 : 담당자 - 기업 연결을 끊는 함수
	 */
	public void connect_delete(List<Integer> seq_list);
	
	/**
	 * @Method Name : select_unconnect_user_list
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 유저 객체 리스트
	 * @Method 설명 : 기업과 연결 되지 않은 유저 객체 리스트를 가져오는 함수
	 * 				(연결 테이블에 값이 존재 하지 않는 기업만 가져옴; 대기, 거절 등의 기업은 관리에서 처리)
	 */
	public ArrayList<User> select_unconnect_user_list();
	
	/**
	 * @Method Name : select_connect_company
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 연결 할 기업 리스트
	 * @Method 설명 : 담당자와 연결할 기업 리스트를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_connect_company();
	
	/**
	 * @Method Name : insert_comp_user_connect
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : 연결 할 유저 아이디 리스트, 연결 할 기업 아이디
	 * @Return : - 
	 * @Method 설명 : 기업 - 담당자 연결하는 함수
	 */
	public void insert_comp_user_connect(HashMap<String, Object> hashMap);
	
	/**
	 * @Method Name : select_ag_comp_connect
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트
	 * @Method 설명 : 에이전시 - 기업이 연결 되어있는 에이전시와 기업의 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_ag_comp_connect();
	
	/**
	 * @Method Name : select_unconnect_comp_list
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 에이전시와 연결 되어 있지 않은 기업 리스트
	 * @Method 설명 : 에이전시와 연결 되어 있지 않은 기업 리스트를 가져오는 함수
	 * 				(연결 테이블에 값이 존재 하지 않는 기업만 가져옴; 대기, 거절 등의 기업은 관리에서 처리)
	 */
	public ArrayList<SocietyFapCompanyUser> select_unconnect_comp_list(RowBounds rb);
	
	/**
	 * @Method Name : select_agency_list
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 일반기업을 제외한 에이전시 객체
	 * @Method 설명 : 기업 객체 중 일반 기업을 제외한 에이전시 객체 리스트를 가져오는 함수
	 */
	public ArrayList<SocietyFapCompanyUser> select_agency_list(RowBounds rb);
	
	/**
	 * @Method Name : connect_ag_comp
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : 연결 객체
	 * @Return : -
	 * @Method 설명 : 에이전시 - 기업을 연결 하는 함수
	 */
	public void connect_ag_comp(HashMap<String, Object> hashMap);
	
	/**
	 * @Method Name : ag_comp_connect_delete
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : 에이전시 - 기업 연결 seq 리스트
	 * @Return : -
	 * @Method 설명 : 에이전시 - 기업 연결을 끊는 함수
	 */
	public void ag_comp_connect_delete(List<Integer> seq_list);
	
	/**
	 * @Method Name : ag_comp_connect_update
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : 에이전시 - 기업 연결 객체
	 * @Return : -
	 * @Method 설명 : 에이전시 - 기업 연결 객체의 승인 상태를 변경하는 함수
	 */
	public void ag_comp_connect_update(HashMap<String, Object> hashMap);
	
	/**
	 * @Method Name : select_uncertain_company
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 기업 객체
	 * @Method 설명 : 기업 - 유저 연결 객체가 없어 기업, 에이전시 구분이 모호한 기업 리스트를 가져오는 함수
	 */
	public ArrayList<SocietyFapCompanyUser> select_uncertain_company(RowBounds rb);
	
	/**
	 * @Method Name : search_job_ad_info
	 * @Date : 2019. 1. 10.
	 * @User : 신동철
	 * @Param : 잡페어시퀀스, 잡페어세부 시퀀스, 채용전형 설정여부, 회사명
	 * @Return : 채용공고 정보
	 * @Method 설명 : 채용공고 정보 검색
	 */
	public ArrayList<HashMap<String, Object>> search_job_ad_info(HashMap<String, Object> hashmap);
	
	/**
	 * @Method Name : search_recruit_process_info
	 * @Date : 2019. 1. 10.
	 * @User : 신동철
	 * @Param : 잡페어시퀀스, 잡페어세부 시퀀스, 채용전형 설정여부, 회사명
	 * @Return : 채용전형 정보
	 * @Method 설명 : 채용전형 정보 검색
	 */
	public ArrayList<HashMap<String, Object>> search_recruit_process_info(HashMap<String, Object> hashmap);
	
	/**
	 * @Method Name : select_review_pcs
	 * @Date : 2019. 1. 12.
	 * @User : 신동철
	 * @Param : 서류전형 스케줄 시퀀스
	 * @Return : 서류전형 정보
	 * @Method 설명 : 서류전형 정보 검색
	 */
	public HashMap<String, Object> select_review_pcs(long fap_job_recruit_pcs_seq);
	
	/**
	 * @Method Name : select_exam_pcs
	 * @Date : 2019. 1. 12.
	 * @User : 신동철
	 * @Param : 시험전형 스케줄 시퀀스
	 * @Return : 시험전형 정보
	 * @Method 설명 : 시험전형 정보 검색
	 */
	public HashMap<String, Object> select_exam_pcs(long fap_job_recruit_pcs_seq);
	
	/**
	 * @Method Name : select_itv_pcs
	 * @Date : 2019. 1. 12.
	 * @User : 신동철
	 * @Param : 면접전형 시퀀스
	 * @Return : 면접전형 정보
	 * @Method 설명 : 면접전형 정보 검색
	 */
	public HashMap<String, Object> select_itv_pcs(long fap_job_recruit_pcs_seq);
	
	/**
	 * @Method Name : select_test_etc_pcs
	 * @Date : 2019. 1. 12.
	 * @User : 신동철
	 * @Param : 기타전형 시퀀스
	 * @Return : 기타전형 정보
	 * @Method 설명 : 기타전형 정보 검색
	 */
	public HashMap<String, Object> select_test_etc_pcs(long fap_job_recruit_pcs_seq);	
	
	/**
	 * @Method Name : update_review_process_schedule
	 * @Date : 2019. 1. 13.
	 * @User : 신동철
	 * @Param : 서류전형 정보
	 * @Return : -
	 * @Method 설명 : 서류전형 스케줄 설정
	 */
	public void update_review_process_schedule(SocietyFapJobRecruitPcsSch review_process_schedule);
	
	/**
	 * @Method Name : update_exam_process_schedule
	 * @Date : 2019. 1. 13.
	 * @User : 신동철
	 * @Param : 시험전형 정보
	 * @Return : -
	 * @Method 설명 : 시험전형 스케줄 설정
	 */
	public void update_exam_process_schedule(SocietyFapJobRecruitPcsSch exam_process_schedule);
	
	/**
	 * @Method Name : update_itv_process_schedule
	 * @Date : 2019. 1. 13.
	 * @User : 신동철
	 * @Param : 면접전형 정보
	 * @Return : -
	 * @Method 설명 : 면접전형 스케줄 설정
	 */
	public void update_itv_process_schedule(SocietyFapJobRecruitPcsSch itv_process_schedule);
	
	/**
	 * @Method Name : update_test_etc_process_schedule
	 * @Date : 2019. 1. 13.
	 * @User : 신동철
	 * @Param : 기타전형 정보
	 * @Return : -
	 * @Method 설명 : 기타전형 스케줄 설정
	 */
	public void update_test_etc_process_schedule(SocietyFapJobRecruitPcsSch test_etc_process_schedule);
	
	/**
	 * @Method Name : update_review_process
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 서류전형 수정 정보
	 * @Return : -
	 * @Method 설명 : 서류전형 제출서류 목록 수정
	 */
	public void update_review_process(SocietyFapJobRecruitPcs review_process);
	
	/**
	 * @Method Name : update_exam_process
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 시험전형 수정 정보
	 * @Return : -
	 * @Method 설명 : 시험전형 정보 수정
	 */
	public void update_exam_process(SocietyFapJobExam exam_process);
	
	/**
	 * @Method Name : update_exam_file
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 시험전형 시험문제파일 수정 정보
	 * @Return : -
	 * @Method 설명 : 시험전형 시험문제파일 수정
	 */
	public void update_exam_file(SocietyFapJobExamFile exam_file);
	
	/**
	 * @Method Name : update_exam_obj_etc
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 시험전형 시험대상자 수정 정보
	 * @Return : -
	 * @Method 설명 : 시험전형 시험대상자 수정
	 */
	public void update_exam_obj_etc(SocietyFapJobExamObjEtc exam_obj_etc);
	
	/**
	 * @Method Name : update_exam_sv_etc
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 시험전형 시험감독관 수정 정보
	 * @Return : -
	 * @Method 설명 : 시험전형 시험감독관 수정
	 */
	public void update_exam_sv_etc(SocietyFapJobExamSvEtc exam_sv_etc);
	
	/**
	 * @Method Name : update_exam_need_etc
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 시험전형 시험준비물 수정 정보
	 * @Return : -
	 * @Method 설명 : 시험전형 시험준비물 수정
	 */
	public void update_exam_need_etc(SocietyFapJobExamNeedEtc exam_need_etc);
	
	/**
	 * @Method Name : update_exam_type
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 시험전형 시험종류 수정 정보
	 * @Return : -
	 * @Method 설명 : 시험전형 시험종류 수정
	 */
	public void update_exam_type(SocietyFapJobExamType exam_type);
	
	/**
	 * @Method Name : update_itv_process
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 면접 채용전형 정보
	 * @Return : -
	 * @Method 설명 : 면접 채용전형 정보 수정
	 */
	public void update_itv_process(SocietyFapJobRecruitPcs itv_process);
	
	/**
	 * @Method Name : update_itv_process_info
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 면접 전형정보
	 * @Return : -
	 * @Method 설명 : 면접 전형정보 수정
	 */
	public void update_itv_process_info(SocietyFapJobItv itv_process_info);
	
	/**
	 * @Method Name : update_itv_tp_etc
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 면접 방식 정보
	 * @Return : -
	 * @Method 설명 : 면접 방식 정보 수정
	 */
	public void update_itv_tp_etc(SocietyFapJobItvTpEtc itv_tp_etc);
	
	/**
	 * @Method Name : update_itv_obj_etc
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 면접 대상자 정보
	 * @Return : -
	 * @Method 설명 : 면접 대상자 정보 수정
	 */
	public void update_itv_obj_etc(SocietyFapJobItvObjEtc itv_obj_etc);
	
	/**
	 * @Method Name : update_test_etc_info
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 기타면접 전형정보
	 * @Return : -
	 * @Method 설명 : 기타면접 전형정보 수정
	 */
	public void update_test_etc_info(SocietyFapJobTestEtc test_etc_info);
	
	/**
	 * @Method Name : update_test_etc_obj
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 기타면접 전형대상자
	 * @Return : -
	 * @Method 설명 : 기타면접 전형대상자 수정
	 */
	public void update_test_etc_obj(SocietyFapJobTestEtcObj test_etc_obj);
	
	/**
	 * @Method Name : select_recruit_pcs_sch
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 전형일정 스케줄 검색 정보
	 * @Return : 전형일정 스케줄
	 * @Method 설명 : 전형일정 스케줄 검색
	 */
	public ArrayList<HashMap<String, Object>> select_recruit_pcs_sch(SocietyFapJobRecruitPcsSch recruit_pcs_sch);
	
	/**
	 * @Method Name : search_job_ad_jobfair_list
	 * @Date : 2019. 1. 18.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 승인된 채용공고의 모든 잡페어 리스트
	 * @Method 설명 : 승인된 채용공고의 모든 잡페어 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> search_job_ad_jobfair_list();
	
	/**
	 * @Method Name : search_job_ad_comp_list
	 * @Date : 2019. 1. 18.
	 * @User : 신동철
	 * @Param : 
	 * @Return : 승인된 채용공고의 모든 회사 리스트
	 * @Method 설명 : 승인된 채용공고의 모든 회사 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> search_job_ad_comp_list();
	
	/**
	 * @Method Name : search_job_ad_list
	 * @Date : 2019. 1. 18.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스, 잡페어세부 시퀀스, 회사 아이디
	 * @Return : 회사가 참가하여 승인받은 채용공고 리스트
	 * @Method 설명 : 회사가 참가하여 승인받은 채용공고 리스트 검색
	 */
	public ArrayList<SocietyFapJobAd> search_job_ad_list(SocietyFapJobAd jobAd);
	
	/**
	 * @Method Name : select_job_ad_comp_list
	 * @Date : 2019. 1. 18.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스
	 * @Return : 해당 잡페어의 채용공고에 승인받은 회사 목록
	 * @Method 설명 : 해당잡페어의 채용공고에 승인받은 회사 목록 검색
	 */
	public ArrayList<HashMap<String, Object>> select_job_ad_comp_list(int fap_jobfair_seq);

	/**
	 * @Method Name : applied_result_list
	 * @Date : 2018. 01. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : ArrayList
	 * @Method 설명 : 지원자별 전형 결과 가져오기
	 */
	public ArrayList<HashMap<String, Object>> select_applied_result(HashMap<String, Object> params);
	
	/**
	 * @Method Name : select_jobfair_apply_count
	 * @Date : 2019. 1. 21.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스, 회원타입, 승인여부, 지원자명
	 * @Return : 잡페어의 지원자 count
	 * @Method 설명 : 잡페어의 지원자 count 조회
	 */
	public int select_jobfair_apply_count(HashMap<String,Object> map);
	
	/**
	 * @Method Name : per_jobfair_temp_group_insert
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 잡페어별 임시 결제 그룹 정보
	 * @Return : 잡페어별 임시 결제 그룹 정보 시퀀스
	 * @Method 설명 : 잡페어별 임시 결제 그룹 정보 등록
	 */
	public void per_jobfair_temp_group_insert(SocietyFapPerJobfairTempGroup perGroup);
	
	/**
	 * @Method Name : per_jobfair_divide_temp_insert
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 세부잡페어별 임시 결제 정보
	 * @Return : -
	 * @Method 설명 : 세부잡페어별 임시 결제 정보 등록
	 */
	public void per_jobfair_divide_temp_insert(SocietyFapPerJobfairDivideTemp divideTemp);
	
	/**
	 * @Method Name : per_jobfair_temp_group_search
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 임시 결제 그룹 정보
	 * @Method 설명 : 잡페어별 임시 결제 그룹 정보 검색
	 */
	public ArrayList<HashMap<String, Object>> per_jobfair_temp_group_search(int fap_jobfair_seq);
	
	/**
	 * @Method Name : per_jobfair_temp_group_delete
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 잡페어별 임시 결제 그룹 정보 시퀀스
	 * @Return : -
	 * @Method 설명 : 잡페어별 임시 결제 그룹 정보 삭제
	 */
	public void per_jobfair_temp_group_delete(int fap_per_jobfair_temp_group_seq);
	
	/**
	 * @Method Name : per_jobfair_temp_group_search_detail
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 잡페어별 임시 결제 그룹 정보 시퀀스
	 * @Return : 잡페어별 임시 결제 그룹 정보
	 * @Method 설명 : 잡페어별 임시 결제 그룹 정보 상세 검색
	 */
	public HashMap<String, Object> per_jobfair_temp_group_search_detail(SocietyFapPerJobfairTempGroup perGroup);
	
	/**
	 * @Method Name : per_jobfair_temp_group_update
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 잡페어별 임시 결제 그룹 정보
	 * @Return : -
	 * @Method 설명 : 잡페어별 임시 결제 그룹 정보 수정
	 */
	public void per_jobfair_temp_group_update(SocietyFapPerJobfairTempGroup perGroup);
	
	/**
	 * @Method Name : per_jobfair_divide_temp_delete
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 잡페어별 임시 결제 그룹 정보 시퀀스
	 * @Return : -
	 * @Method 설명 : 상세잡페어별 임시 결제 정보 삭제
	 */
	public void per_jobfair_divide_temp_delete(int fap_per_jobfair_temp_group_seq);
	
	/**
	 * @Method Name : per_comp_temp_payment_update
	 * @Date : 2019. 2. 7.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 회사 결제정보 수정
	 * @Method 설명 : 잡페어별 회사 결제정보 수정
	 */
	public void per_comp_temp_payment_update(HashMap<String, Object> params);
	
	/**
	 * @Method Name : per_comp_temp_payment_insert
	 * @Date : 2019. 2. 7.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 회사 결제정보 등록
	 * @Method 설명 : 잡페어별 회사 결제정보 등록
	 */
	public void per_comp_temp_payment_insert(HashMap<String, Object> params);
	
	/**
	 * @Method Name : per_comp_temp_payment_delete
	 * @Date : 2019. 2. 7.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 회사 결제정보 삭제
	 * @Method 설명 : 잡페어별 회사 결제정보 삭제
	 */
	public void per_comp_temp_payment_delete(int fap_per_comp_temp_payment_seq);
	
	/**
	 * @Method Name : select_comp_list_include_agency
	 * @Date : 2019. 1. 28.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 기업(에이전시 포함) 리스트 맵
	 * @Method 설명 : 기업(에이전시 포함) 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> select_comp_list_include_agency(int fap_jobfair_seq);
	
	/**
	 * @Method Name : search_approved_job_recruit_pcs
	 * @Date : 2019. 1. 30.
	 * @User : 원병호
	 * @Param : fap_job_ad_seq
	 * @Return : ArrayList<SocietyFapJobRecruitPcs>
	 * @Method 설명 : 해당 채용공고의 채용전형을 가져오는 함수
	 */
	public ArrayList<SocietyFapJobRecruitPcs> search_approved_job_recruit_pcs(long fap_job_ad_seq);
	
	/**
	 * @Method Name : search_approved_review_pcs_date
	 * @Date : 2019. 1. 30.
	 * @User : 원병호
	 * @Param : fap_job_ad_seq
	 * @Return : SocietyFapJobfairApplicableTime 객체
	 * @Method 설명 : 해당 채용공고의 서류 마감일을 검색하는 함수
	 */
	public SocietyFapJobfairApplicableTime search_approved_review_pcs_date(long fap_job_ad_seq);
	
	/**
	 * @Method Name : insert_approved_review_pcs
	 * @Date : 2019. 1. 30.
	 * @User : 원병호
	 * @Param : SocietyFapJobRecruitPcsSch
	 * @Return : 
	 * @Method 설명 : 채용전형 스케줄(서류전형) 등록
	 */
	public void insert_approved_review_pcs(SocietyFapJobRecruitPcsSch jobRecruitPcsSch);
	
	/**
	 * @Method Name : insert_approved_recruit_pcs
	 * @Date : 2019. 1. 30.
	 * @User : 원병호
	 * @Param : SocietyFapJobRecruitPcsSch
	 * @Return : 
	 * @Method 설명 : 채용전형 스케줄(서류전형 제외) 등록
	 */
	public void insert_approved_recruit_pcs(SocietyFapJobRecruitPcsSch jobRecruitPcsSch);
	
	/**
	 * @Method Name : select_job_recruit_pcs_sch_by_seq
	 * @Date : 2019. 1. 30.
	 * @User : Administrator
	 * @Param : fap_job_recruit_pcs_seq
	 * @Return : SocietyFapJobRecruitPcsSch
	 * @Method 설명 : 해당 seq의 SocietyFapJobRecruitPcsSch 객체 검색
	 */
	public SocietyFapJobRecruitPcsSch select_job_recruit_pcs_sch_by_seq(long fap_job_recruit_pcs_seq);
	
	/**
	 * @Method Name : select_connect_request
	 * @Date : 2019. 2. 7.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 기업 - 담당자 연결 요청 객체
	 * @Method 설명 : 기업 - 담당자 연결 요청 객체를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_connect_request(RowBounds rb);
	
	/**
	 * @Method Name : delete_connect_request
	 * @Date : 2019. 2. 7.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : -
	 * @Method 설명 : 기업 - 담당자 연결 요청을 삭제하는 함수
	 */
	public void delete_connect_request(String user_id);
	
	/**
	 * @Method Name : delete_connect_request_seq
	 * @Date : 2019. 2. 8.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : -
	 * @Method 설명 : 기업 - 담당자 연결 요청을 삭제하는 함수
	 */
	public int delete_connect_request_seq(int fap_comp_user_request_seq);
	
	/**
	 * @Method Name : select_user_list_paging_count
	 * @Date : 2019. 2. 11.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 회원 리스트 총 개수를 불러오는 함수
	 * @Method 설명 : 회원 리스트 총 개수를 불러오는 함수 
	 */
	public int select_user_list_paging_count();
	
	/**
	 * @Method Name : select_company_list_paging_count
	 * @Date : 2019. 2. 13.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 기업 리스트 총 개수를 불러오는 함수
	 * @Method 설명 : 기업 리스트 총 개수를 불러오는 함수 
	 */
	public int select_company_list_paging_count(HashMap<String,Object> paramMap);
	
	/**
	 * @Method Name : select_fap_notice
	 * @Date : 2019. 2. 14.
	 * @User : 김준영
	 * @Param : -
	 * @Return : FAP 공지사항 hashmap 객체
	 * @Method 설명 : FAP 공지사항을 불러오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_fap_notice();
	
	/**
	 * @Method Name : select_standby_ag_comp_connect_list
	 * @Date : 2019. 2. 14.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 대기중인 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트
	 * @Method 설명 : 대기중인 에이전시 - 기업이 연결 되어있는 에이전시와 기업의 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_standby_ag_comp_connect_list(RowBounds rb);
	
	/**
	 * @Method Name : select_standby_ag_comp_connect_list_paging_count
	 * @Date : 2019. 2. 14.
	 * @User : 이재준
	 * @Param : -
	 * @Return :  대기중인 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수를 불러오는 함수
	 * @Method 설명 :  대기중인 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수를 불러오는 함수 
	 */
	public int select_standby_ag_comp_connect_list_paging_count();
	
	/**
	 * @Method Name : board_search_all_count
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 관리자 게시판의 모든 게시물 개수
	 * @Method 설명 : 관리자 게시판 진입 시 모든 게시물 개수 조회
	 */
	public int board_search_all_count(HashMap<String, Object> map);
	
	/**
	 * @Method Name : board_search_all
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 관리자 게시판의 모든 게시물
	 * @Method 설명 : 관리자 게시판 진입 시 모든 게시물 조회
	 */
	public ArrayList<BoardGroup> board_search_all(HashMap<String, Object> map);
	
	/**
	 * @Method Name : board_contents_search
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : 관리자 게시판 관리의 특정 게시판 정보 객체
	 * @Return : 관리자 게시판의 특정 게시판의 게시글 리스트
	 * @Method 설명 : 게시글 리스트를 가져오는 함수
	 */
	public ArrayList<HashMap<String,Object>> board_contents_search(HashMap<String, Object> map);
	
	/**
	 * @Method Name : board_contents_count
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : 관리자 게시판 관리의 특정 게시판 정보 객체
	 * @Return : 관리자 게시판의 특정 게시판의 게시글 갯수
	 * @Method 설명 : 페이징을 위한 전체글 갯수 조회하는 함수
	 */
	public int board_contents_count(HashMap<String, Object> map);
	
	
	/**
	 * @Method Name : select_approval_ag_comp_connect_list
	 * @Date : 2019. 2. 15.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 승인받은 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트
	 * @Method 설명 : 승인받은 에이전시 - 기업이 연결 되어있는 에이전시와 기업의 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_approval_ag_comp_connect_list(RowBounds rb);
	
	/**
	 * @Method Name : select_approval_ag_comp_connect_list_paging_count
	 * @Date : 2019. 2. 15.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 승인받은 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수를 불러오는 함수
	 * @Method 설명 : 승인받은 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수를 불러오는 함수 
	 */
	public int select_approval_ag_comp_connect_list_paging_count();
	
	/**
	 * @Method Name : select_unconnect_comp_list_paging_count
	 * @Date : 2019. 2. 15.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 에이전시에 연결 되어있지 않은 기업 리스트 총 개수를 불러오는 함수
	 * @Method 설명 : 에이전시에 연결 되어있지 않은 기업 리스트 총 개수를 불러오는 함수 
	 */
	public int select_unconnect_comp_list_paging_count();
	
	/**
	 * @Method Name : select_unconnect_comp_list_paging_count
	 * @Date : 2019. 2. 15.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 기업에 연결 될 에이전시 리스트 총 개수를 불러오는 함수
	 * @Method 설명 : 기업에 연결 될 에이전시 리스트 총 개수를 불러오는 함수 
	 */
	public int select_agency_list_paging_count();
	
	/**
	 * @Method Name : insert_board_content
	 * @Date : 2019. 2. 19.
	 * @User : 신동철
	 * @Param : 공지사항 내용
	 * @Return : -
	 * @Method 설명 : FAP 공지사항 등록 함수
	 */
	public int insert_board_content(BoardContent boardContent);
	
	/**
	 * @Method Name : insert_notice_content
	 * @Date : 2019. 2. 19.
	 * @User : 신동철
	 * @Param : 공지사항 부가내용
	 * @Return : -
	 * @Method 설명 : FAP 공지사항 부가내용 등록 함수
	 */
	public void insert_notice_content(SocietyFapAdminNoticeContent noticeContent);
	
	/**
	 * @Method Name : insert_board_file
	 * @Date : 2019. 2. 19.
	 * @User : 김준영
	 * @Param : 공통 게시물 파일 정보
	 * @Return : -
	 * @Method 설명 : 파일을 저장하는 함수
	 */
	public void insert_board_file(BoardFile boardFile);
	
	/**
	 * @Method Name : delete_notice
	 * @Date : 2019. 2. 20.
	 * @User : 김준영
	 * @Param : 게시판 seq
	 * @Return : 삭제 여부
	 * @Method 설명 : 공지사항을 삭제하는 함수
	 */
	public int delete_notice(int board_content_seq);
	
	
	
	/**
	 * @Method Name : search_jobfair_attended_comp_list
	 * @Date : 2019. 2. 21.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 잡페어 참가 기업 리스트
	 * @Method 설명 : 잡페어 참가 기업 리스트를 검색하는 함수
	 */
	public ArrayList<HashMap<String, Object>> search_jobfair_attended_comp_list();
	
	/**
	 * @Method Name : searched_jobfair_attended_comp_list
	 * @Date : 2019. 2. 21.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 잡페어별 참가 기업 리스트
	 * @Method 설명 : 잡페어별 참가 기업 리스트를 검색하는 함수
	 */
	public ArrayList<HashMap<String, Object>> searched_jobfair_attended_comp_list(HashMap<String, Object> hashmap);
	
	
	/**
	 * @Method Name : select_refusal_ag_comp_connect_list
	 * @Date : 2019. 2. 20.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 거절한 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트
	 * @Method 설명 : 거절한 에이전시 - 기업이 연결 되어있는 에이전시와 기업의 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_refusal_ag_comp_connect_list(RowBounds rb);
	
	/**
	 * @Method Name : select_refusal_ag_comp_connect_list_paging_count
	 * @Date : 2019. 2. 15.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 거절한 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수를 불러오는 함수
	 * @Method 설명 : 거절한 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수를 불러오는 함수 
	 */
	public int select_refusal_ag_comp_connect_list_paging_count();
	
	/**
	 * @Method Name : select_standby_comp_user_connect
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 대기중인 담당자 - 기업 연결 리스트
	 * @Method 설명 : 대기중인 담당자 - 기업 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_standby_comp_user_connect(RowBounds rb);
	
	/**
	 * @Method Name : select_standby_comp_user_connect_list_paging_count
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 대기중인 담당자 - 기업 연결 리스트 총 개수를 불러오는 함수
	 * @Method 설명 : 대기중인 담당자 - 기업 연결 리스트 총 개수를 불러오는 함수 
	 */
	public int select_standby_comp_user_connect_list_paging_count();
	
	/**
	 * @Method Name : select_approval_comp_user_connect
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 승인한 담당자 - 기업 연결 리스트
	 * @Method 설명 : 승인한 담당자 - 기업 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_approval_comp_user_connect(RowBounds rb);
	
	/**
	 * @Method Name : select_approval_comp_user_connect_list_paging_count
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 승인한 담당자 - 기업 연결 리스트 총 개수를 불러오는 함수
	 * @Method 설명 : 승인한 담당자 - 기업 연결 리스트 총 개수를 불러오는 함수 
	 */
	public int select_approval_comp_user_connect_list_paging_count();
	
	/**
	 * @Method Name : select_refusal_comp_user_connect
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 거절한 담당자 - 기업 연결 리스트
	 * @Method 설명 : 거절한 담당자 - 기업 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_refusal_comp_user_connect(RowBounds rb);
	
	/**
	 * @Method Name : select_refusal_comp_user_connect_list_paging_count
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 거절한 담당자 - 기업 연결 리스트 총 개수를 불러오는 함수
	 * @Method 설명 : 거절한 담당자 - 기업 연결 리스트 총 개수를 불러오는 함수 
	 */
	public int select_refusal_comp_user_connect_list_paging_count();

	/**
	 * @Method Name : select_uncertain_company_paging_count	
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 연결 객체가 없어 불명확한 기업 리스트 개수를 불러오는 함수
	 * @Method 설명 : 연결 객체가 없어 불명확한 기업 리스트 개수를 불러오는 함수 
	 */
	public int select_uncertain_company_paging_count();
	
	/**
	 * @Method Name : select_connect_request_paging_count
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 담당자 연결 요청 개수를 불러오는 함수
	 * @Method 설명 : 담당자 연결 요청 개수를 불러오는 함수 
	 */
	public int select_connect_request_paging_count();

	/**
	 * @Method Name : select_unconnect_company_list
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 유저(기업) 객체 리스트
	 * @Method 설명 : 기업과 연결 되지 않은 유저(기업) 객체 리스트를 가져오는 함수
	 * 				(연결 테이블에 값이 존재 하지 않는 기업만 가져옴; 대기, 거절 등의 기업은 관리에서 처리)
	 */
	public ArrayList<User> select_unconnect_company_list(RowBounds rb);
	
	/**
	 * @Method Name : select_unconnect_company_list_paging_count
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 유저(기업)수
	 * @Method 설명 : 기업과 연결 되지 않은 유저(기업)수를 가져오는 함수 
	 */
	public int select_unconnect_company_list_paging_count();
	
	/**
	 * @Method Name : select_unconnect_agency_list
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 유저(에이전시) 객체 리스트
	 * @Method 설명 : 기업과 연결 되지 않은 유저(에이전시) 객체 리스트를 가져오는 함수
	 * 				
	 */
	public ArrayList<User> select_unconnect_agency_list(RowBounds rb);
	
	/**
	 * @Method Name : select_unconnect_company_list_paging_count
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 유저(에이전시)수
	 * @Method 설명 : 기업과 연결 되지 않은 유저(에이전시)수를 가져오는 함수 
	 */
	public int select_unconnect_agency_list_paging_count();
	
	/**
	 * @Method Name : select_connect_company_list
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 연결 할 기업 리스트
	 * @Method 설명 : 담당자와 연결할 기업 리스트를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_connect_company_list(RowBounds rb);
	
	/**
	 * @Method Name : select_connect_company_list_paging_count
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 연결 할 기업 리스트 개수
	 * @Method 설명 :  담당자와 연결할 기업 리스트 개수를 가져오는 함수 
	 */
	public int select_connect_company_list_paging_count();
	
	/**
	 * @Method Name : select_connect_agency_list
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 연결 할 에이전시 리스트
	 * @Method 설명 : 담당자와 연결할 에이전시 리스트를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_connect_agency_list(RowBounds rb);
	
	/**
	 * @Method Name : select_connect_agency_list_paging_count
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 연결 할 에이전시 리스트 개수
	 * @Method 설명 :  담당자와 연결할 에이전시 리스트 개수를 가져오는 함수 
	 */
	public int select_connect_agency_list_paging_count();
	
	/**
	 * @Method Name : select_jobfair_applicable_time
	 * @Date : 2019. 2. 21.
	 * @User : 원병호
	 * @Param : 잡페어 세부
	 * @Return : 
	 * @Method 설명 : 잡페어 지원가능 시간 정보 검색
	 */
	public ArrayList<HashMap<String,Object>> select_jobfair_applicable_time(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : select_jobfair_applicable_time
	 * @Date : 2019. 2. 21.
	 * @User : 원병호
	 * @Param : 잡페어 세부
	 * @Return : 
	 * @Method 설명 : 잡페어 지원가능 시간 정보 검색
	 */
	public ArrayList<SocietyFapJobfairApplicableTime> select_jobfair_applicable_time_first(int fap_jobfair_divide_seq);
	
	
	
	
	/**
	 * @Method Name : search_user_apply_numbers
	 * @Date : 2019. 2. 25.
	 * @User : 신동철
	 * @Param : 잡페어 세부 시퀀스
	 * @Return : 잡페어별 취업지원자 지망개수
	 * @Method 설명 : 잡페어별 취업지원자 지망개수 검색
	 */
	public ArrayList<HashMap<String, Object>> search_user_apply_numbers(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : update_user_apply_numbers
	 * @Date : 2019. 2. 25.
	 * @User : 신동철
	 * @Param : 지원자 지망개수
	 * @Return : 잡페어별 취업지원자 지망개수 수정
	 * @Method 설명 : 잡페어별 취업지원자 지망개수 수정
	 */
	public void update_user_apply_numbers(ArrayList<SocietyFapUserApplyNumbers> newUserApplyNumbersList);
	
	/**
	 * @Method Name : insert_jobfair_applicable_time_one
	 * @Date : 2019. 2. 27.
	 * @User : 원병호
	 * @Param : 잡페어 추가지원 객체
	 * @Return : 
	 * @Method 설명 : 잡페어 추가지원/미스매칭 등록
	 */
	public void insert_jobfair_applicable_time_one(SocietyFapJobfairApplicableTime jobfairApplicableTime);
	
	/**
	 * @Method Name : update_jobfair_applicable_time_one
	 * @Date : 2019. 3. 4.
	 * @User : 원병호
	 * @Param : 잡페어 추가지원 객체
	 * @Return : 
	 * @Method 설명 : 잡페어 추가지원/미스매칭 수정
	 */
	public void update_jobfair_applicable_time_one(SocietyFapJobfairApplicableTime jobfairApplicableTime);
	
	/**
	 * @Method Name : delete_jobfair_applicable_time
	 * @Date : 2019. 3. 4.
	 * @User : Administrator
	 * @Param : 
	 * @Return : 
	 * @Method 설명 :
	 */
	public void delete_jobfair_applicable_time(int fap_jobfair_applicable_time_seq);
	
	/**
	 * @Method Name : update_board_content
	 * @Date : 2019. 3. 5.
	 * @User : 신동철
	 * @Param : 공통게시판 게시물
	 * @Return : -
	 * @Method 설명 : 관리자 공통게시판 게시물 수정
	 */
	public int update_board_content(BoardContent boardContent);
	
	/**
	 * @Method Name : update_notice_content
	 * @Date : 2019. 3. 5.
	 * @User : 신동철
	 * @Param : 잡페어 공지사항
	 * @Return : -
	 * @Method 설명 : 잡페어 공지사항 수정
	 */
	public void update_notice_content(SocietyFapAdminNoticeContent noticeContent);
	
	/**
	 * @Method Name : delete_board_file
	 * @Date : 2019. 3. 5.
	 * @User : 신동철
	 * @Param : 잡페어 공지사항 파일 시퀀스
	 * @Return : -
	 * @Method 설명 : 잡페어 공지사항 파일 삭제
	 */
	public void delete_board_file(int board_file_seq);
	
	/**
	 * @Method Name : search_qna_comp
	 * @Date : 2019. 3. 6.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 채용공고 Q&A 기업명
	 * @Method 설명 : 채용공고 Q&A 기업명 검색
	 */
	public ArrayList<HashMap<String, Object>> search_qna_comp();
	
	/**
	 * @Method Name : search_qna_job_ad
	 * @Date : 2019. 3. 6.
	 * @User : 신동철
	 * @Param : 채용기업 아이디
	 * @Return : 채용공고 Q&A 채용공고
	 * @Method 설명 : 채용공고 Q&A 채용공고 검색
	 */
	public ArrayList<HashMap<String, Object>> search_qna_job_ad(String fap_comp_id);
	
	/**
	 * @Method Name : search_job_qna_question_info
	 * @Date : 2019. 3. 6.
	 * @User : 신동철
	 * @Param : 채용기업 아이디, 채용공고 시퀀스, 질문승인여부, 작성자 이름
	 * @Return : 채용공고 Q&A 질문 정보
	 * @Method 설명 : 채용공고 Q&A 질문 정보 검색 
	 */
	public ArrayList<HashMap<String, Object>> search_job_qna_question_info(HashMap<String, Object> hashmap);

	/**
	 * @Method Name : jobfair_user_qna_permission
	 * @Date : 2019. 3. 7.
	 * @User : 신동철
	 * @Param : 질문 승인할 채용공고 Q&A질문일련번호
	 * @Return : -
	 * @Method 설명 : 채용공고 Q&A 질문 승인
	 */
	public void jobfair_user_qna_permission(List<Integer>fap_jobfair_user_qna_seq_list);
	
	/**
	 * @Method Name : jobfair_user_qna_nonpermission
	 * @Date : 2019. 3. 7.
	 * @User : 신동철
	 * @Param : 질문 미승인할 채용공고 Q&A질문일련번호
	 * @Return : -
	 * @Method 설명 : 채용공고 Q&A 질문 미승인
	 */
	public void jobfair_user_qna_nonpermission(List<Integer>fap_jobfair_user_qna_seq_list);
	
	/**
	 * @Method Name : insert_qna_question_refuse_reason
	 * @Date : 2019. 3. 7.
	 * @User : 신동철
	 * @Param : Q&A질문일련번호, 미승인사유
	 * @Return : -
	 * @Method 설명 : 채용공고 Q&A 질문 미승인사유 등록
	 */
	public void insert_qna_question_refuse_reason(HashMap<String, Object> hashmap); 
	
	/**
	 * @Method Name : select_jobfair_divide_info
	 * @Date : 2019. 3. 12.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어 세부
	 * @Method 설명 : 잡페어 세부 검색
	 */
	public ArrayList<SocietyFapCompanyRoadmapJobfairDivide> select_jobfair_divide_info(HashMap<String, Object> params);
		
	/**
	 * @Method Name : search_jobfair_divide_final_select_info
	 * @Date : 2019. 3. 14.
	 * @User : 신동철
	 * @Param : 잡페어 세부시퀀스
	 * @Return : 잡페어 세부별 최종합격자 결정 시한
	 * @Method 설명 : 잡페어 세부별 최종합격자 결정 시한 설정 정보 검색
	 */
	public HashMap<String, Object> search_jobfair_divide_final_select_info(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : insert_fap_jobfair_divide_final_select
	 * @Date : 2019. 3. 14.
	 * @User : 신동철 
	 * @Param : 잡페어 세부 시퀀스, 최종합격 결정 시작일, 최종합격 결정 마감일
	 * @Return : -
	 * @Method 설명 : 잡페어 세부별 최종합격자 결정 시한 설정 등록
	 */
	public void insert_fap_jobfair_divide_final_select(HashMap<String, Object> hashmap);
	
	/**
	 * @Method Name : final_decision_time_duplicate_check
	 * @Date : 2019. 3. 25.
	 * @User : 이종호
	 * @Param : 최종확정 기간정보
	 * @Return : -
	 * @Method 설명 : 최종확정 기간 중복 조회
	 */
	public int final_decision_time_duplicate_check(SocietyFapAdminFinalDecisionTime finalDecision);
	
	/**
	 * @Method Name : final_decision_time_insert
	 * @Date : 2019. 3. 21.
	 * @User : 이종호
	 * @Param : 최종확정 기간정보
	 * @Return : -
	 * @Method 설명 : 최종확정 기간 등록
	 */
	public void final_decision_time_insert(SocietyFapAdminFinalDecisionTime finalDecision);
	
	/**
	 * @Method Name : final_decision_algorithm_step_one
	 * @Date : 2019. 5. 10.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 내정자중 미 선택자 포기처리
	 */
	public void final_decision_algorithm_step_one(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : final_decision_algorithm_step_one_ns
	 * @Date : 2019. 5. 15.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 내정자중 미 선택자 포기처리 (확정필수-유예없음)
	 */
	public void final_decision_algorithm_step_one_ns(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : final_decision_algorithm_step_two
	 * @Date : 2019. 5. 10.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 내정+예비중 확정된 기업을 제외하고 포기처리
	 */
	public void final_decision_algorithm_step_two(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : final_decision_algorithm_step_three
	 * @Date : 2019. 5. 10.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : 잡페어 최종확정 알고리즘 내정포기로 인한 예비합격자 정보
	 * @Method 설명 : 잡페어 최종확정 알고리즘 내정포기로 인한 예비합격자 정보 조회
	 */
	public ArrayList<HashMap<String, Object>> final_decision_algorithm_step_three(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : final_decision_algorithm_step_four
	 * @Date : 2019. 5. 10.
	 * @User : 이종호
	 * @Param : 잡페어 최종확정 알고리즘 예비합격자 정보
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 예비합격자 정보 적용
	 */
	public void final_decision_algorithm_step_four(ArrayList<HashMap<String, Object>> list);
	
	/**
	 * @Method Name : final_decision_algorithm_step_five
	 * @Date : 2019. 5. 10.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 확정된 지원자 확정 버튼 노출여부 변경
	 */
	public void final_decision_algorithm_step_five(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : final_decision_algorithm_step_final
	 * @Date : 2019. 5. 15.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 모든 지원자 확정 버튼 노출여부 변경
	 */
	public void final_decision_algorithm_step_final(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : final_decision_algorithm_gb_update
	 * @Date : 2019. 5. 15.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 최종적용 이후 예비합격자 종료 처리
	 */
	public void final_decision_algorithm_gb_update(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : final_decision_algorithm_nominee_update
	 * @Date : 2019. 12. 9.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 적용 이후 예비->합격 대상자 내정자 등록 
	 */
	public void final_decision_algorithm_nominee_update(int fap_jobfair_divide_seq);

	/**
	 * @Method Name : final_decision_algorithm_pass_to_comp
	 * @Date : 2019. 5. 15.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 최종적용 이후 기업에 전달
	 */
	public void final_decision_algorithm_pass_to_comp(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : final_decision_time_select
	 * @Date : 2019. 3. 21.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : -
	 * @Method 설명 : 세부 잡페어 별 최종확정 기간 조회
	 */
	public ArrayList<SocietyFapAdminFinalDecisionTime> final_decision_time_select(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : final_decision_time_delete
	 * @Date : 2019. 3. 25.
	 * @User : 이종호
	 * @Param : 최종확정 기간 시퀀스들
	 * @Return : -
	 * @Method 설명 : 세부 잡페어 별 최종확정 기간 삭제
	 */
	public void final_decision_time_delete(HashMap<String, Object> fap_jobfair_set_seq_map);
	
	/**
	 * @Method Name : fap_ad_show_code_select
	 * @Date : 2019. 3. 22.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 채용공고 대상자 공통코드 맵
	 * @Method 설명 : 채용공고 대상자 설정을 위한 조회
	 */
	public ArrayList<HashMap<String, Object>> fap_ad_show_code_select();
	
	/**
	 * @Method Name : fap_ad_show_link_code_select
	 * @Date : 2019. 3. 22.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 채용공고 시퀀스
	 * @Method 설명 : 채용공고 연결된 대상자 설정을 위한 조회
	 */
	public ArrayList<SocietyFapJobAdShow> fap_ad_show_link_code_select(long fap_job_ad_seq);
	
	/**
	 * @Method Name : fap_ad_show_link_code_delete
	 * @Date : 2019. 3. 22.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 채용공고 시퀀스
	 * @Method 설명 : 채용공고 연결된 대상자 설정을 위한 삭제
	 */
	public void fap_ad_show_link_code_delete(long fap_job_ad_seq);
	
	/**
	 * @Method Name : fap_ad_show_link_code_insert
	 * @Date : 2019. 3. 22.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 채용공고 연결된 대상자 정보 리스트
	 * @Method 설명 : 채용공고 연결된 대상자 설정을 위한 등록
	 */
	public void fap_ad_show_link_code_insert(ArrayList<SocietyFapJobAdShow> show_list);
	
	/**
	 * @Method Name : fap_faq_select_list
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 파인애플 FAQ 리스트
	 * @Method 설명 : 파인애플 FAQ 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> fap_faq_select_list();
	
	/**
	 * @Method Name : fap_faq_select_list_gb
	 * @Date : 2019. 4. 10.
	 * @User : 이종호
	 * @Param : FAQ 구분값
	 * @Return : 파인애플 FAQ 리스트(구분된)
	 * @Method 설명 : 파인애플 FAQ 리스트(구분된) 조회
	 */
	public ArrayList<HashMap<String, Object>> fap_faq_select_list_gb(HashMap<String, Object> paramMap,RowBounds rb);
	
	/**
	 * @Method Name : fap_faq_select_list_gb_count
	 * @Date : 2019. 4. 10.
	 * @User : 이종호
	 * @Param : FAQ 구분값
	 * @Return : 파인애플 FAQ 리스트(구분된) 갯수
	 * @Method 설명 : 파인애플 FAQ 리스트(구분된) 갯수 조회
	 */
	public int fap_faq_select_list_gb_count(HashMap<String, Object> paramMap);
	
	/**
	 * @Method Name : fap_faq_insert_content
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : 파인애플 FAQ 내용 정보
	 * @Return : -
	 * @Method 설명 : 파인애플 FAQ 내용 등록
	 */
	public void fap_faq_insert_content(FaqConsultingContents content);
	
	/**
	 * @Method Name : fap_faq_insert_gb
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : 파인애플 FAQ 구분 정보
	 * @Return : -
	 * @Method 설명 : 파인애플 FAQ 구분 등록
	 */
	public void fap_faq_insert_gb(SocietyFapAdminFaqGb faqGb);
	
	/**
	 * @Method Name : fap_faq_select_list
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 파인애플 FAQ 단일정보
	 * @Method 설명 : 파인애플 FAQ 단일 조회
	 */
	public HashMap<String, Object> fap_faq_select_one(int consulting_seq);
	
	/**
	 * @Method Name : fap_faq_update_content
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : 파인애플 FAQ 내용 정보
	 * @Return : -
	 * @Method 설명 : 파인애플 FAQ 내용 수정
	 */
	public void fap_faq_update_content(FaqConsultingContents content);
	
	/**
	 * @Method Name : fap_faq_update_gb
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : 파인애플 FAQ 구분 정보
	 * @Return : -
	 * @Method 설명 : 파인애플 FAQ 구분 수정
	 */
	public void fap_faq_update_gb(SocietyFapAdminFaqGb faqGb);
	
	/**
	 * @Method Name : fap_faq_delete
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : 파인애플 FAQ 시퀀스
	 * @Return : -
	 * @Method 설명 : 파인애플 FAQ 삭제
	 */
	public void fap_faq_delete(int consulting_seq);
	
	/**
	 * @Method Name : fap_open_pt_insert
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 정보 등록
	 */
	public void fap_open_pt_insert(SocietyFapOpenPt openPt);
	
	/**
	 * @Method Name : fap_open_pt_select_list
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 오픈잡페어 설명회 정보 리스트
	 * @Method 설명 : 오픈잡페어 설명회 정보 리스트 조회
	 */
	public ArrayList<SocietyFapOpenPt> fap_open_pt_select_list();
	
	/**
	 * @Method Name : fap_open_pt_select_one
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 시퀀스
	 * @Return : 오픈잡페어 설명회 정보
	 * @Method 설명 : 오픈잡페어 설명회 정보 조회
	 */
	public SocietyFapOpenPt fap_open_pt_select_one(int fap_open_pt_seq);

	/**
	 * @Method Name : fap_open_pt_update_show_gb
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 수정정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 같은종류 모두 비노출 처리
	 */
	public void fap_open_pt_update_show_gb(SocietyFapOpenPt openPt);
	
	/**
	 * @Method Name : fap_open_pt_update_gb
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 수정정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 구분 정보 수정
	 */
	public void fap_open_pt_update_gb(SocietyFapOpenPt openPt);
	
	/**
	 * @Method Name : fap_open_pt_update
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 수정정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 정보 수정
	 */
	public void fap_open_pt_update(SocietyFapOpenPt openPt);
	
	/**
	 * @Method Name : fap_open_pt_delete
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 시퀀스
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 정보 삭제
	 */
	public void fap_open_pt_delete(int fap_open_pt_seq);
	
	/**
	 * @Method Name : fap_open_pt_applier_list_count
	 * @Date : 2019. 4. 17.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 정보
	 * @Return : 오픈잡페어 설명회 총 지원자 수(검색 포함)
	 * @Method 설명 : 해당 설명회 총 지원자 수(검색 포함) 조회
	 */
	public int fap_open_pt_applier_list_count(HashMap<String, Object> paramMap);
	
	/**
	 * @Method Name : fap_open_edu_applier_list_count
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 정보
	 * @Return : 오픈잡페어 구직자 교육 총 지원자 수(검색 포함)
	 * @Method 설명 : 해당 구직자 교육 총 지원자 수(검색 포함) 조회
	 */
	public int fap_open_edu_applier_list_count(HashMap<String, Object> paramMap);
	
	/**
	 * @Method Name : fap_open_pt_applier_list
	 * @Date : 2019. 4. 16.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 정보
	 * @Return : 해당 설명회 지원자 정보 리스트
	 * @Method 설명 : 해당 설명회 지원자 정보 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> fap_open_pt_applier_list(HashMap<String, Object> paramMap,RowBounds rb);
	
	/**
	 * @Method Name : fap_open_edu_applier_list
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 정보
	 * @Return : 해당 구직자 교육 지원자 정보 리스트
	 * @Method 설명 : 해당 구직자 교육 지원자 정보 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> fap_open_edu_applier_list(HashMap<String, Object> paramMap,RowBounds rb);

	/**
	 * @Method Name : fap_open_pt_applier_list_excel
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 지원자 시퀀스 정보
	 * @Return : 해당 설명회 지원자 정보 리스트
	 * @Method 설명 : 해당 설명회 지원자 정보 리스트 엑셀출력용 조회
	 */
	public ArrayList<LinkedHashMap<String, Object>> fap_open_pt_applier_list_excel(HashMap<String, Object> paramMap);
	
	/**
	 * @Method Name : fap_open_edu_applier_list_excel
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 지원자 시퀀스 정보
	 * @Return : 해당 구직자 교육 지원자 정보 리스트
	 * @Method 설명 : 해당 구직자 교육 지원자 정보 리스트 엑셀출력용 조회
	 */
	public ArrayList<LinkedHashMap<String, Object>> fap_open_edu_applier_list_excel(HashMap<String, Object> paramMap);
	
	/**
	 * @Method Name : fap_open_pt_only_list
	 * @Date : 2019. 4. 16.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 구분
	 * @Return : 해당 구분 설명회 정보 리스트
	 * @Method 설명 : 해당 구분 설명회 정보 리스트 조회
	 */
	public ArrayList<SocietyFapOpenPt> fap_open_pt_only_list(String fap_open_pt_gb);
	
	/**
	 * @Method Name : fap_open_edu_applier_resume_update
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 지원자 이력서 정보
	 * @Return : -
	 * @Method 설명 : 해당 구분 구직자 교육 지원자 합/불 처리
	 */
	public void fap_open_edu_applier_resume_update(SocietyFapOpenPtResume openResume);
	
	/**
	 * @Method Name : fap_open_edu_close_fail_update
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 정보
	 * @Return : -
	 * @Method 설명 : 해당 오픈잡페어 구직자 교육 마감처리 시 대기 지원자 불합격 처리
	 */
	public void fap_open_edu_close_fail_update(SocietyFapOpenPt openPt);
	
	/**
	 * @Method Name : fap_popup_insert
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : FAP 팝업 정보
	 * @Return : -
	 * @Method 설명 : FAP 팝업 정보 등록
	 */
	public void fap_popup_insert(SocietyFapPopup popup);
	
	/**
	 * @Method Name : fap_popup_select_list
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : -
	 * @Return : FAP 팝업 정보 리스트
	 * @Method 설명 : FAP 팝업 정보 리스트 조회
	 */
	public ArrayList<SocietyFapPopup> fap_popup_select_list();
	
	/**
	 * @Method Name : fap_popup_select_one
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : -
	 * @Return : FAP 팝업 정보 단일
	 * @Method 설명 : FAP 팝업 정보 단일 조회
	 */
	public SocietyFapPopup fap_popup_select_one(int fap_popup_seq);
	
	/**
	 * @Method Name : fap_popup_delete
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : -
	 * @Return : FAP 팝업 시퀀스
	 * @Method 설명 : FAP 팝업 정보 삭제
	 */
	public void fap_popup_delete(int fap_popup_seq);
	
	/**
	 * @Method Name : fap_job_resume_update_gb
	 * @Date : 2019. 4. 30.
	 * @User : 이종호
	 * @Param : FAP 이력서 수정여부 구분
	 * @Return : -
	 * @Method 설명 : FAP 이력서 수정여부 구분 변경
	 */
	public void fap_job_resume_update_gb(String fap_job_resume_update_gb);
	
	/**
	 * @Method Name : applicant_status_per_applier_search
	 * @Date : 2019. 5. 17.
	 * @User : 이종호
	 * @Param : 지원자별 지원현황 검색 조건
	 * @Return : 지원자별 지원 현황 리스트
	 * @Method 설명 : 지원자별 지원 현황 리스트 검색
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_applier_search(HashMap<String, Object> search_map);
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_one
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보1
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드1
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_one(int jobfair_seq);
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_two
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보2
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드2
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_two(int jobfair_seq);
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_three
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보3
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드3
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_three(int jobfair_seq);
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_four
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보4
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드4
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_four(int jobfair_seq);
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_five
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보5
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드5
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_five(int jobfair_seq);
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_six
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보6
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드6
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_six(int jobfair_seq);
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_seven
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보7
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드7
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_seven(int jobfair_seq);
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_eight
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보8
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드8
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_eight(int jobfair_seq);
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_nine
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보9
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드9
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_nine(int jobfair_seq);
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_ten
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보10
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드10
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_ten(int jobfair_seq);
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_eleven
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보11
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드11
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_eleven(int jobfair_seq);

	/**
	 * @Method Name : applicant_status_per_comp_excel_twelve
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보12
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드12
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_twelve(int jobfair_seq);
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_thirteen
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보13
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드13
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_thirteen(int jobfair_seq);
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_fourteen
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보14
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드14
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_fourteen(int jobfair_seq);
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_fifteen
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보15
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드15
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_fifteen(int jobfair_seq);
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_sixteen
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보16
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드16
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_comp_excel_sixteen(int jobfair_seq);
	
	/**
	 * @Method Name : jobfair_apply_max_count
	 * @Date : 2019. 5. 20.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 지원자가 최대 지원한 갯수
	 * @Method 설명 : 잡페어별 지원자가 최대 지원한 갯수 검색
	 */
	public int jobfair_apply_max_count(HashMap<String, Object> params);

	/**
	 * @Method Name : fap_open_insert_job_info_content
	 * @Date : 2019. 6. 26.
	 * @User : 김경아
	 * @Param : 오픈잡페어 취업정보 & 전략 게시판 내용 정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 취업정보 & 전략 게시판 내용 등록
	 */
	public void fap_open_insert_job_info_content(SocietyFapOpenJobInfo openJobInfo);

	/**
	 * @Method Name : fap_open_update_job_info_content
	 * @Date : 2019. 6. 27.
	 * @User : 김경아
	 * @Param : 오픈잡페어 취업정보 & 전략 게시판 내용 정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 취업정보 & 전략 게시판 내용 수정
	 */
	public int fap_open_update_job_info_content(SocietyFapOpenJobInfo openJobInfo);

	/**
	 * @return 
	 * @Method Name : fap_open_delete_job_info_content
	 * @Date : 2019. 6. 27.
	 * @User : 김경아
	 * @Param : 게시판 일련번호
	 * @Return : -
	 * @Method 설명 : 오픈잡페어  취업정보 & 전략 게시판 정보 삭제
	 */
	public int fap_open_delete_job_info_content(int board_content_seq);

	/**
	 * @return 
	 * @Method Name : fap_open_job_info_content_additional_detail
	 * @Date : 2019. 6. 27.
	 * @User : 김경아
	 * @Param : 게시판 글 일련번호
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 취업정보 & 전략 게시판 추가항목 조회
	 */
	public HashMap<String, Object> fap_open_job_info_content_additional_detail(HashMap<String,Object> paramMap);

	 
	/**
	 * @return 
	 * @Method Name : fap_open_job_info_content_list
	 * @Date : 2019. 6. 27.
	 * @User : 김경아
	 * @Param : 게시판 일련번호
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 취업정보 & 전략 게시판 리스트 조회 
	 */
	public ArrayList<HashMap<String, Object>> fap_open_job_info_content_list(HashMap<String, Object> map, RowBounds rb);

	/**
	 * @Method Name : select_company_group_code_list
	 * @Date : 2019. 7. 25. 
	 * @User : 김경아
	 * @Param : HashMap
	 * @Return : HashMap
	 * @Method 설명 : FAP 관리자 잡페어별 그룹코드 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> admin_select_company_group_code_list(HashMap<String, Object> fapJobAdvertisement);

	
	/**
	 * @Method Name : search_job_advertisement_list
	 * @Date : 2019. 07. 25.
	 * @User : 김경아
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 채용공고 상세검색
	 */
	public ArrayList<HashMap<String, Object>> admin_search_job_advertisement_list(
			HashMap<String, Object> selectedCompanyInfoMap);

	/**
	 * @Method Name : board_contents_detail
	 * @Date : 2019. 7. 31.
	 * @User : 김경아
	 * @Param : 게시판 글 seq
	 * @Return : 게시판 세부 내용
	 * @Method 설명 : 게시판 세부 내용을 가져오는 함수
	 */
	public HashMap<String, Object> board_contents_detail(int board_content_seq);

	/**
	 * @Method Name : board_contents_hit_update
	 * @Date : 2019. 7. 31.
	 * @User : 김경아	
	 * @Param : 게시판 상세구분
	 * @Return : 
	 * @Method 설명 : 게시판 조회수를 추가하는 함수 
	 */
	public void board_contents_hit_update(int board_content_seq);


	/**
	 * @Method Name : fap_open_insert_notice_content
	 * @Date : 2019. 7. 31.
	 * @User : 김경아 
	 * @Param : 공지사항 게시판 정보 
	 * @Return : 
	 * @Method 설명 : 공지사항 게시판 정보 추가 
	 */
	public void fap_open_insert_notice_content(SocietyFapAdminNoticeContent noticeContent);

	/**
	 * @Method Name : fap_open_update_notice_content
	 * @Date : 2019. 8. 1.
	 * @User : 김경아
	 * @Param : 공지사항 게시판 정보
	 * @Return : 
	 * @Method 설명 : 공지사항 게시판 정보 수정
	 */
	public void fap_open_update_notice_content(SocietyFapAdminNoticeContent noticeContent);

	/**
	 * @Method Name : delete_jobfair_divide_seq_from_apply_info
	 * @Date : 2019. 8. 16.
	 * @User : 김경아
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 잡페어 추가지원/미스매칭 지원정보 삭제
	 */
	public void delete_jobfair_divide_seq_from_apply_info(int fap_jobfair_divide_seq);

	/**
	 * @Method Name : insert_admin_notice_info
	 * @Date : 2019. 8. 29.
	 * @User : 김경아
	 * @Param : 등록자 id, 잡페어 시퀀스 
	 * @Return : 
	 * @Method 설명 : FAP 잡페어 참가신청시 관리자 알림테이블에 해당 정보 추가 
	 */
	public int insert_admin_notice_info(HashMap<String, Object> map);

	/**
	 * @Method Name : select_admin_notice_alim_list
	 * @Date : 2019. 8. 30.
	 * @User : 김경아
	 * @Param :  
	 * @Return :   관리자 알림 list   
	 * @Method 설명 :   관리자 알림 list 출력 
	 */
	public ArrayList<HashMap<String,Object>> select_admin_notice_alim_list(HashMap<String, Object> paramMap, RowBounds rb);

	/**
	 * @Method Name : select_comp_nm
	 * @Date : 2019. 9. 3.
	 * @User : 김경아	
	 * @Param : 기업id
	 * @Return : 
	 * @Method 설명 : 기업이름출력
	 */
	public ArrayList<String> select_comp_nm(String fap_comp_id);

	/**
	 * @Method Name : select_job_ad_title
	 * @Date : 2019. 9. 3.
	 * @User : 김경아	
	 * @Param : FAP 채용공고명 조회
	 * @Return : 
	 * @Method 설명 : 
	 */
	public String select_job_ad_title(long fap_job_ad_seq);

	/**
	 * @Method Name : select_job_qna_question_title
	 * @Date : 2019. 9. 3.
	 * @User : 김경아	
	 * @Param : 질문글 시퀀스 
	 * @Return : 질문글 제목 
	 * @Method 설명 : FAP 질문글 조회 
	 */
	public String select_job_qna_question_title(long fap_job_qna_question_seq);

	
	/**
	 * @Method Name : mainpage_cct_select
	 * @Date : 2019. 9. 3.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 지원자 메인페이지 기업컨텐츠 관리 정보
	 * @Method 설명 : 설정된 지원자 메인페이지 기업컨텐츠 관리 정보를 조회
	 */
	public SocietyFapMainpageContent mainpage_ct_select();
	
	/**
	 * @Method Name : mainpage_ct_insert
	 * @Date : 2019. 9. 3.
	 * @User : 이종호
	 * @Param : 지원자 메인페이지 기업컨텐츠 관리 정보
	 * @Return : -
	 * @Method 설명 : 지원자 메인페이지 기업컨텐츠 관리 정보 등록
	 */
	public void mainpage_ct_insert(SocietyFapMainpageContent mainCt);
	
	/**
	 * @Method Name : mainpage_ct_update
	 * @Date : 2019. 9. 3.
	 * @User : 이종호
	 * @Param : 지원자 메인페이지 기업컨텐츠 관리 정보
	 * @Return : -
	 * @Method 설명 : 지원자 메인페이지 기업컨텐츠 관리 정보 수정
	 */
	public void mainpage_ct_update(SocietyFapMainpageContent mainCt);
	
	/**
	 * @Method Name : mainpage_ct_delete
	 * @Date : 2019. 9. 3.
	 * @User : 이종호
	 * @Param : 지원자 메인페이지 기업컨텐츠 관리 정보
	 * @Return : -
	 * @Method 설명 : 지원자 메인페이지 기업컨텐츠 관리 정보 삭제
	 */
	public void mainpage_ct_delete(int fap_mainpage_ct_seq);

	/**
	 * @Method Name : admin_notice_update_handle_fin_gb
	 * @Date : 2019. 9. 6.
	 * @User : 김경아
	 * @Param :  알림 seq, 알림처리여부 
	 * @Return :     
	 * @Method 설명 :   알림내용 처리상태 변경 
	 */
	public int admin_notice_update_handle_fin_gb(HashMap<String,Object> paramMap);

	/**
	 * @Method Name : admin_notice_update_handle_fin_gb_all_selected
	 * @Date : 2019. 9. 6.
	 * @User : 김경아
	 * @Param :  알림 seq, 알림처리여부 
	 * @Return :     
	 * @Method 설명 :   알림내용 처리상태 단체변경 
	 */
	public int admin_notice_update_handle_fin_gb_all_selected(List<SocietyFapAdminNoticeAlim> adminNoticeAlimList);

	/**
	 * @Method Name : select_admin_notice_alim_list_count
	 * @Date : 2019. 9. 9.
	 * @User : 김경아
	 * @Param : 
	 * @Return : 알림 구분 
	 * @Method 설명 : FAP 관리자 알림 list 출력 리스트 갯수 조회
	 */
	public int select_admin_notice_alim_list_count(String selected_handle_gb);

	/**
	 * @Method Name : select_admin_notice_list_not_handled
	 * @Date : 2019. 9. 9.
	 * @User : 김경아
	 * @Param :   처리여부 
	 * @Return :     
	 * @Method 설명 :  처리되지 않은 항목 갯수 조회 
	 */
	public int select_admin_notice_list_not_handled();

	/**
	 * @Method Name : delete_exam_file
	 * @Date : 2019. 9. 26.
	 * @User : 김경아	
	 * @Param : 파일명 
	 * @Return : 
	 * @Method 설명 : 파일삭제시 파일테이블에서 해당 파일정보 삭제 
	 */
	public int delete_exam_file(String fap_job_exam_file_saved);

	/**
	 * @Method Name : insert_exam_file
	 * @Date : 2019. 9. 26.
	 * @User : 김경아
	 * @Param : 시험전형 시험문제파일정보
	 * @Return : 
	 * @Method 설명 : 시험전형 시험문제파일 등록 
	 */
	public void insert_exam_file(SocietyFapJobExamFile exam_file);
	
	/**
	 * @Method Name : tokyofair_schedule_set_insert
	 * @Date : 2019. 9. 18.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 설정 등록
	 */
	public int tokyofair_schedule_set_insert(SocietyFapAdminJobfairSet fap_jobfair_set);
	
	/**
	 * @Method Name : tokyofair_schedule_set_date_insert
	 * @Date : 2019. 9. 18.
	 * @User : 이종호
	 * @Param : 도쿄페어 날짜 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 날짜 정보 등록
	 */
	public void tokyofair_schedule_set_date_insert(List<SocietyFapAdminJobfairSetDate> fap_jobfair_set_date);
	
	/**
	 * @Method Name : tokyofair_schedule_set_time_insert
	 * @Date : 2019. 9. 18.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 일정 정보 등록 
	 */
	public void tokyofair_schedule_set_time_insert(List<SocietyFapAdminJobfairSetTime> fap_jobfair_set_time);
	
	/**
	 * @Method Name : tokyofair_schedule_set_search_list
	 * @Date : 2019. 9. 19.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : 도쿄페어 설정 정보 리스트 
	 * @Method 설명 : 도쿄페어 설정 정보 리스트 조회
	 */
	public ArrayList<SocietyFapAdminJobfairSet> tokyofair_schedule_set_search_list(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : tokyofair_schedule_set_gb_init
	 * @Date : 2019. 9. 19.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스 , 도쿄페어 설정 사용여부 초기화 구분
	 * @Return : -
	 * @Method 설명 : 도쿄페어 설정 사용여부 초기화
	 */
	public void tokyofair_schedule_set_gb_init(HashMap<String, Object> params);
	
	/**
	 * @Method Name : tokyofair_schedule_set_gb_update
	 * @Date : 2019. 9. 19.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 시퀀스, 도쿄페어 설정 사용여부 구분
	 * @Return : -
	 * @Method 설명 : 도쿄페어 설정 사용여부 구분 변경 
	 */
	public void tokyofair_schedule_set_gb_update(HashMap<String, Object> params);
	
	/**
	 * @Method Name : tokyofair_schedule_set_delete
	 * @Date : 2019. 9. 19.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 설정 삭제 
	 */
	public void tokyofair_schedule_set_delete(int fap_jobfair_set_seq);
	
	/**
	 * @Method Name : tokyofair_schedule_set_search
	 * @Date : 2019. 9. 19.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 시퀀스
	 * @Return : 도쿄페어 설정 정보
	 * @Method 설명 : 도쿄페어 설정 정보 조회
	 */
	public SocietyFapAdminJobfairSet tokyofair_schedule_set_search(int fap_jobfair_set_seq);
	
	/**
	 * @Method Name : tokyofair_schedule_set_date_search
	 * @Date : 2019. 9. 19.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 시퀀스
	 * @Return : 도쿄페어 일정 정보
	 * @Method 설명 : 도쿄페어 일정 정보 조회
	 */
	public HashMap<String, Object> tokyofair_schedule_set_date_search(int fap_jobfair_set_seq);
	
	/**
	 * @Method Name : tokyofair_schedule_set_update
	 * @Date : 2019. 9. 20.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 설정 정보 수정 
	 */
	public int tokyofair_schedule_set_update(SocietyFapAdminJobfairSet fap_jobfair_set);
	
	/**
	 * @Method Name : tokyofair_schedule_set_date_delete
	 * @Date : 2019. 9. 20.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 날짜 정보 삭제
	 */
	public void tokyofair_schedule_set_date_delete(int fap_jobfair_seq);

	/**
	 * @Method Name : tokyofair_screening_search_bookable
	 * @Date : 2019. 10. 13.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : 채용공고 리스트
	 * @Method 설명 : 관리자 도쿄페어 설명회,시험 등록가능 조회
	 */
	public ArrayList<HashMap<String, Object>> tokyofair_screening_search_bookable(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : tokyfair_schedule_booked_search
	 * @Date : 2019. 10. 13.
	 * @User : 이종호
	 * @Param : 현지 잡페어 설정 시퀀스 , 등록된 일정 날짜
	 * @Return : 등록된 일정 정보 리스트
	 * @Method 설명 : 도쿄페어 등록된 일정 정보 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> tokyfair_schedule_booked_search(HashMap<String, Object> params);
	
	/**
	 * @Method Name : tokyofair_screening_insert_admin
	 * @Date : 2019. 10. 14.
	 * @User : 이종호
	 * @Param : 도쿄페어 설명회,시험 전형 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 설명회,시험 전형 등록 
	 */
	public void tokyofair_screening_insert_admin(HashMap<String, Object> params);
	
	/**
	 * @Method Name : tokyofair_scr_user_insert_admin
	 * @Date : 2019. 10. 14.
	 * @User : 이종호
	 * @Param : 도쿄페어 설명회,시험 전형 인원 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 설명회,시험 전형 인원 등록 
	 */
	public void tokyofair_scr_user_insert_admin(ArrayList<HashMap<String, Object>> list);
	
	/**
	 * @Method Name : tokyofair_schedule_date_check_admin
	 * @Date : 2019. 10. 14.
	 * @User : 이종호
	 * @Param : 도쿄페어 날짜정보
	 * @Return : 도쿄페어 날짜 시퀀스
	 * @Method 설명 : 이미 등록된 도쿄페어 날짜 시퀀스 조회
	 */
	public Integer tokyofair_schedule_date_check_admin(HashMap<String, Object> params);
	
	/**
	 * @Method Name : tokyofair_schedule_date_insert_admin
	 * @Date : 2019. 10. 14.
	 * @User : 이종호
	 * @Param : 도쿄페어 날짜정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 날짜 등록 
	 */
	public void tokyofair_schedule_date_insert_admin(HashMap<String, Object> params);
	
	/**
	 * @Method Name : tokyofair_schedule_info_insert_admin
	 * @Date : 2019. 10. 14.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 일정 정보 등록 
	 */
	public void tokyofair_schedule_info_insert_admin(HashMap<String, Object> params);
	
	/**
	 * @Method Name : tokyofair_member_insert_admin
	 * @Date : 2019. 10. 14.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 인원 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 일정 인원 정보 등록 
	 */
	public void tokyofair_member_insert_admin(ArrayList<HashMap<String, Object>> list);
}
