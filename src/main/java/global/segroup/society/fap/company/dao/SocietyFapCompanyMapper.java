/**
 * 
 */
package global.segroup.society.fap.company.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import global.segroup.domain.BoardContent;
import global.segroup.domain.User;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairSet;
import global.segroup.society.fap.admincommon.domain.SocietyFapJobRecruitPcsSch;
import global.segroup.society.fap.company.domain.SocietyFapCommonRequiredDoc;
import global.segroup.society.fap.company.domain.SocietyFapCompUserConnectRequest;
import global.segroup.society.fap.company.domain.SocietyFapCompanyUser;
import global.segroup.society.fap.company.domain.SocietyFapCompanyUserConnect;
import global.segroup.society.fap.company.domain.SocietyFapJobAd;
import global.segroup.society.fap.company.domain.SocietyFapJobApplyFinalResult;
import global.segroup.society.fap.company.domain.SocietyFapJobApplyResult;
import global.segroup.society.fap.company.domain.SocietyFapJobCategory;
import global.segroup.society.fap.company.domain.SocietyFapJobCategoryEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobComp;
import global.segroup.society.fap.company.domain.SocietyFapJobDorm;
import global.segroup.society.fap.company.domain.SocietyFapJobExam;
import global.segroup.society.fap.company.domain.SocietyFapJobExamFile;
import global.segroup.society.fap.company.domain.SocietyFapJobExamNeedEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobExamObjEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobExamSvEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobExamType;
import global.segroup.society.fap.company.domain.SocietyFapJobFile;
import global.segroup.society.fap.company.domain.SocietyFapJobIsr;
import global.segroup.society.fap.company.domain.SocietyFapJobItv;
import global.segroup.society.fap.company.domain.SocietyFapJobItvObjEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobItvTpEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobJaLevel;
import global.segroup.society.fap.company.domain.SocietyFapJobJitEmployee;
import global.segroup.society.fap.company.domain.SocietyFapJobJoinDt;
import global.segroup.society.fap.company.domain.SocietyFapJobPay;
import global.segroup.society.fap.company.domain.SocietyFapJobPayBase;
import global.segroup.society.fap.company.domain.SocietyFapJobPayEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobPayExtra;
import global.segroup.society.fap.company.domain.SocietyFapJobPref;
import global.segroup.society.fap.company.domain.SocietyFapJobRecruitPcs;
import global.segroup.society.fap.company.domain.SocietyFapJobServiceWork;
import global.segroup.society.fap.company.domain.SocietyFapJobTestEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobTestEtcObj;
import global.segroup.society.fap.company.domain.SocietyFapJobTrial;
import global.segroup.society.fap.company.domain.SocietyFapJobWork;
import global.segroup.society.fap.company.domain.SocietyFapJobWorkplace;
import global.segroup.society.fap.company.domain.SocietyFapJobWorkplaceDtl;
import global.segroup.society.fap.company.domain.SocietyFapJobWorkplaceEtc;
import global.segroup.society.fap.company.domain.SocietyFapLaJobPlan;
import global.segroup.society.fap.company.domain.SocietyFapLaJobSet;
import global.segroup.society.fap.company.domain.SocietyFapPersonalRequiredDoc;
import global.segroup.society.fap.company.domain.SocietyFapQnaAnswer;
import global.segroup.society.fap.company.domain.SocietyFapTokyofairDate;
import global.segroup.society.fap.company.domain.SocietyFapTokyofairScrUser;
import global.segroup.society.fap.company.domain.SocietyFapTokyofairScreening;
import global.segroup.society.fap.companyroadmap.domain.SocietyFapCompanyRoadmapJobfair;
import global.segroup.society.fap.user.domain.SocietyFapNominee;

/**
 * @Author : 신동철
 * @Date : 2018. 11. 29.
 * @Class 설명 : Soft Engineer Society 통합잡페어 채용기업 매퍼
 * 
 */
public interface SocietyFapCompanyMapper {
	
	/**
	 * @Method Name : user_id_check
	 * @Date : 2018. 12. 11.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 유저아이디 or null
	 * @Method 설명 : 유저 아이디 중복 검사 중복된 경우 아이디 값이 return되며 중복 되지 않은 경우 null이 return됨
	 */
	public String user_id_check(String user_id);
	
	/**
	 * @Method Name : insert_com_user
	 * @Date : 2018. 12. 11.
	 * @User : 김준영
	 * @Param : 유저 객체
	 * @Return : -
	 * @Method 설명 : 유저 등록을 하는 함수
	 */
	public void insert_com_user(User user);
	
	/**
	 * @Method Name : insert_company
	 * @Date : 2018. 12. 11.
	 * @User : 김준영
	 * @Param : 회사 정보 객체
	 * @Return : -
	 * @Method 설명 : 회사 정보를 등록 하는 함수
	 */
	public void insert_company(SocietyFapCompanyUser sfcUser);
	
	/**
	 * @Method Name : comp_user_connect
	 * @Date : 2018. 12. 12.
	 * @User : 김준영
	 * @Param : 회사-담당자 연결 객체
	 * @Return : -
	 * @Method 설명 : 회사와 담당자를 연결해주는 함수
	 */
	public int comp_user_connect(SocietyFapCompanyUserConnect sfCUConnect);
	
	/**
	 * @Method Name : select_company_log
	 * @Date : 2019. 03. 11.
	 * @User : 김준영
	 * @Param : 회사아이디
	 * @Return : 회사 로고 정보
	 * @Method 설명 : 특정 회사 로고 정보 획득 함수
	 */
	public SocietyFapCompanyUser select_company_log(String user_id);
	
	/**
	 * @Method Name : select_company
	 * @Date : 2018. 12. 13.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 회사 정보 객체
	 * @Method 설명 : 아이디가 가지고 있는 회사 정보를 가져오는 함수
	 */
	public SocietyFapCompanyUser select_company(String user_id);
	
	/**
	 * @Method Name : update_company
	 * @Date : 2018. 12. 13.
	 * @User : 김준영
	 * @Param : 회사 정보 객체
	 * @Return : -
	 * @Method 설명 : 회사 정보를 업데이트 하는 함수
	 */
	public void update_company(SocietyFapCompanyUser sfcUser);
	
	/**
	 * @Method Name : select_user
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 공통 유저 객체
	 * @Method 설명 : 공통 유저 객체를 불러오는 함수
	 */
	public User select_user(String user_id);
	
	/**
	 * @Method Name : update_user
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 공통 유저 객체
	 * @Return : -
	 * @Method 설명 : 회사 담당자 정보를 수정하는 함수
	 */
	public void update_user(User user);
	
	/**
	 * @Method Name : jobfair_search_list
	 * @Date : 2018. 12. 24.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 통합잡페어 정보
	 * @Method 설명 : 통합잡페어 정보 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> jobfair_search_list();	
	
	/**
	 * @Method Name : jobfair_divide_search_list
	 * @Date : 2018. 12. 24.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어 세부정보 리스트
	 * @Method 설명 : 선택한 잡페어 세부정보 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> jobfair_divide_search_list(int fap_jobfair_seq);
	
	/**
	 * @Method Name : company_jobfair_divide_participation
	 * @Date : 2018. 12. 24.
	 * @User : 신동철
	 * @Param : 회사잡페어등록정보(잡페어 시퀀스, 잡페어 세부 시퀀스, 회사 아이디, 에이전시 여부구분)
	 * @Return : -
	 * @Method 설명 : 회사잡페어등록정보 입력
	 */
	public void company_jobfair_divide_participation(HashMap<String, Object> hashmap);
	
	/**
	 * @Method Name : delete_company_user_info
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 탈퇴할 기업 담당자 객체
	 * @Return : -
	 * @Method 설명 : 기업 담당자 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(30글자) 변경후 참조 테이블에 적용
	 */
	public int delete_company_user_info(HashMap<String, String> updateMap);
	
	/**
	 * @Method Name : select_comp_user_connect
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 기업 - 유저 연결 객체
	 * @Method 설명 : 해당 하는 아이디에 기업 - 유저 연결 객체를 불러오는 함수
	 */
	public SocietyFapCompanyUserConnect select_comp_user_connect(String user_id);
	
	/**
	 * @Method Name : select_all_company
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 모든 기업 리스트
	 * @Method 설명 : 모든 기업 리스트를 불러오는 함수 
	 */
	public ArrayList<SocietyFapCompanyUser> select_all_company();
	
	/**
	 * @Method Name : delete_comp_user_connect
	 * @Date : 2018. 12. 27.
	 * @User : 김준영
	 * @Param : 기업 - 유저 연결 시퀀스
	 * @Return : -
	 * @Method 설명 : 기업 - 유저 연결을 삭제하는 함수
	 */
	public int delete_comp_user_connect(int fap_comp_user_connect_seq);
	
	
	/**
	 * @Method Name : select_company_jobfair_participation
	 * @Date : 2018. 12. 26.
	 * @User : 신동철
	 * @Param : (잡페어 시퀀스, 회사 아이디)
	 * @Return : -
	 * @Method 설명 : 회사잡페어등록정보 검색
	 */
	public ArrayList<HashMap<String, Object>> select_company_jobfair_participation(HashMap<String, Object> hashmap);
	
	/**
	 * @Method Name : select_fap_comp_id
	 * @Date : 2018. 12. 27.
	 * @User : 신동철
	 * @Param : 회원 아이디
	 * @Return : 회사 아이디
	 * @Method 설명 : 회사 아이디 발급 여부 검색
	 */
	public String select_fap_comp_id(String user_id);

	/**
	 * @Method Name : select_connect_request
	 * @Date : 2018. 12. 31.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 에이전시 정보 리스트
	 * @Method 설명 : 기업에게 연결 요청을 한 에이전시의 정보를 가져오는 함수
	 */
	public ArrayList<SocietyFapCompanyUser> select_connect_request(String user_id);
	
	/**
	 * @Method Name : insert_common_required_doc
	 * @Date : 2019. 1. 1.
	 * @User : 신동철
	 * @Param : 공통 내정서류 정보
	 * @Return : -
	 * @Method 설명 : 공통 내정서류를 등록하는 함수
	 */
	public int insert_common_required_doc(SocietyFapCommonRequiredDoc common_required_doc);
	
	/**
	 * @Method Name : delete_common_required_doc
	 * @Date : 2019. 1. 1.
	 * @User : 신동철
	 * @Param : 공통 내정서류 정보
	 * @Return : -
	 * @Method 설명 : 공통 내정서류를 삭제하는 함수
	 */
	public void delete_common_required_doc(SocietyFapCommonRequiredDoc common_required_doc);
	
	/**
	 * @Method Name : search_common_required_doc_list
	 * @Date : 2019. 1. 1.
	 * @User : 신동철
	 * @Param : 채용공고 시퀀스, 회사아이디
	 * @Return : 공통 내정서류 리스트
	 * @Method 설명 : 공통 내정서류 리스트를 검색하는 함수
	 */
	public ArrayList<SocietyFapCommonRequiredDoc> search_common_required_doc_list(HashMap<String, Object> hashmap);
	
	/**
	 * @Method Name : request_handling
	 * @Date : 2019. 1. 2.
	 * @User : 김준영
	 * @Param : 요청 처리를 위한 유저 아이디, 기업 아이디, 처리 상태
	 * @Return : -
	 * @Method 설명 : 에이전시의 기업 연결 요청을 처리하는 함수
	 */
	public void request_handling(HashMap<String, Object> hashMap);
	
	/**
	 * @Method Name : select_common_required_doc
	 * @Date : 2019. 1. 1.
	 * @User : 신동철
	 * @Param : 공통 내정서류 시퀀스
	 * @Return : 특정 공통내정서류 정보
	 * @Method 설명 :  특정 공통내정서류를 검색하는 함수
	 */
	public SocietyFapCommonRequiredDoc select_common_required_doc(int fap_common_required_doc_seq);
	
	/**
	 * @Method Name : update_common_required_doc
	 * @Date : 2019. 1. 2.
	 * @User : 신동철
	 * @Param : 공통 내정서류 정보
	 * @Return : -
	 * @Method 설명 : 공통 내정서류를 수정하는 함수
	 */
	public void update_common_required_doc(SocietyFapCommonRequiredDoc common_required_doc);
	
	/**
	 * @Method Name : search_company_job_ad_list
	 * @Date : 2019. 1. 5.
	 * @User : 신동철
	 * @Param : 회사 아이디
	 * @Return : 회사가 참가한 채용공고 리스트 
	 * @Method 설명 : 회사가 참가한 채용공고 리스트 검색하는 함수
	 */
	public ArrayList<SocietyFapJobAd> search_company_job_ad_list(SocietyFapJobAd job_ad);
	
	/**
	 * @Method Name : select_common_company
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 에이전시를 제외한 기업 객체
	 * @Method 설명 : 모든 기업객체 중 에이전시를 제외한 일반 기업 객체를 가져오는 함수
	 */
	public ArrayList<SocietyFapCompanyUser> select_common_company();
	
	
	/**
	 * @Method Name : search_nominee_info_list
	 * @Date : 2019. 1. 5.
	 * @User : 신동철
	 * @Param : 채용공고 시퀀스, 회사 아이디
	 * @Return : 특정 회사의 내정자 정보 리스트 
	 * @Method 설명 : 특정 회사의 내정자 정보 리스트  검색하는 함수
	 */
	public ArrayList<HashMap<String, Object>> search_nominee_info_list(HashMap<String, Object> hashmap);
	
	/**
	 * @Method Name : insert_personal_required_doc
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 개인 내정서류 정보
	 * @Return : -
	 * @Method 설명 : 개인 내정서류를 등록하는 함수
	 */
	public int insert_personal_required_doc(SocietyFapPersonalRequiredDoc personal_required_doc);
	
	/**
	 * @Method Name : select_user_flag
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 회원 아이디
	 * @Return : -
	 * @Method 설명 : 회원 권한을 검색하는 함수
	 */
	public String select_user_flag(String user_id);
	
	/**
	 * @Method Name : select_nominee_info
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 특정 내정자 시퀀스
	 * @Return : 특정 내정자 정보
	 * @Method 설명 : 특정 내정자 정보 검색하는 함수
	 */
	public SocietyFapNominee select_nominee_info(long fap_nominee_seq);
	
	/**
	 * @Method Name : search_personal_required_doc_list
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 특정 내정자 시퀀스
	 * @Return : 개인 내정서류 리스트
	 * @Method 설명 : 개인 내정서류 리스트를 검색하는 함수
	 */
	public ArrayList<HashMap<String, Object>> search_personal_required_doc_list(int fap_nominee_seq);
	
	/**
	 * @Method Name : select_personal_required_doc
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 특정 내정자 시퀀스
	 * @Return : 특정 개인 내정서류 정보
	 * @Method 설명 : 특정 개인 내정서류 정보를 검색하는 함수
	 */
	public SocietyFapPersonalRequiredDoc select_personal_required_doc(int fap_nominee_seq);
	
	/**
	 * @Method Name : update_personal_required_doc
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 개인 내정서류
	 * @Return : -
	 * @Method 설명 : 개인 내정서류 수정하는 함수
	 */
	public void update_personal_required_doc(SocietyFapPersonalRequiredDoc personal_required_doc);
	
	/**
	 * @Method Name : delete_personal_required_doc
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 개인 내정서류
	 * @Return : -
	 * @Method 설명 : 개인 내정서류 삭제 하는 함수
	 */
	public void delete_personal_required_doc(SocietyFapPersonalRequiredDoc personal_required_doc);
	
	/**
	 * @Method Name : search_nominee_info
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 내정자 시퀀스
	 * @Return : 내정자 정보 
	 * @Method 설명 : 특정 회사의 내정자 정보 검색하는 함수
	 */
	public HashMap<String, Object> search_nominee_info(SocietyFapNominee nominee);
	
	/**
	 * @Method Name : algorithm_jobfair_setting_use_search
	 * @Date : 2019. 1. 8.
	 * @User : 이종호
	 * @Param : 현지잡페어 설정 사용중인 구분코드
	 * @Return : 현지잡페어 설정 정보 
	 * @Method 설명 : 사용중인 구분코드로 현지잡페어 설정정보를 취득
	 */
	public HashMap<String, Object> algorithm_jobfair_setting_use_search(HashMap<String, Object> params);

	/**
	 * @Method Name : user_connect_delete
	 * @Date : 2019. 1. 10.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : -
	 * @Method 설명 : 유저 아이디에 해당하는 기업 - 유저 연결 객체를 삭제하는 함수
	 */
	public void user_connect_delete(String user_id);

	/**
	 * @Method Name : algorithm_calendar_setting_insert
	 * @Date : 2019. 1. 10.
	 * @User : 이종호
	 * @Param : 현지잡페어 설정 정보
	 * @Return : -
	 * @Method 설명 : 현지잡페어 설정 정보 등록
	 */
	public void algorithm_calendar_setting_insert(SocietyFapLaJobSet jobSet);
	
	/**
	 * @Method Name : algorithm_calendar_setting_insert_plan
	 * @Date : 2019. 1. 10.
	 * @User : 이종호
	 * @Param : 현지잡페어 시간 설정 정보
	 * @Return : -
	 * @Method 설명 : 현지잡페어 시간 설정 정보 등록
	 */
	public void algorithm_calendar_setting_insert_plan(SocietyFapLaJobPlan jobPlan);
	
	/**
	 * @Method Name : algorithm_calendar_setting_update
	 * @Date : 2019. 1. 14.
	 * @User : 이종호
	 * @Param : 현지잡페어 설정 정보
	 * @Return : -
	 * @Method 설명 : 현지잡페어 설정 정보 수정
	 */
	public void algorithm_calendar_setting_update(SocietyFapLaJobSet jobSet);
	
	/**
	 * @Method Name : algorithm_calendar_setting_delete_plan
	 * @Date : 2019. 1. 14.
	 * @User : 이종호
	 * @Param : 현지잡페어 시간 설정 정보
	 * @Return : -
	 * @Method 설명 : 현지잡페어 시간 설정 정보 삭제
	 */
	public void algorithm_calendar_setting_delete_plan(long fap_job_ad_seq);
	
	//채용공고 이전 시작


	/**
	 * @Method Name : insert_job_ad
	 * @Date : 2018. 12. 24.
	 * @User : 이재준
	 * @Param : 채용공고 객체
	 * @Return : -
	 * @Method 설명 : FAP 채용공고 기본정보 저장
	 */
	public void insert_job_ad(SocietyFapJobAd JobAd);
	
	/**
	 * @Method Name : insert_job_dorm
	 * @Date : 2018. 12. 26.
	 * @User : 이재준
	 * @Param : 기숙사 정보 객체
	 * @Return : -
	 * @Method 설명 : FAP 채용공고 기숙사 정보 저장
	 */
	public void insert_job_dorm(SocietyFapJobDorm JobDorm);
	
	/**
	 * @Method Name : insert_job_jit_employee
	 * @Date : 2018. 12. 26.
	 * @User : 이재준
	 * @Param : 계약사원 정보 객체
	 * @Return : -
	 * @Method 설명 : FAP 채용공고 계약사원 정보 저장
	 */
	public void insert_job_jit_employee(SocietyFapJobJitEmployee JobJitEmployee);
	
	/**
	 * @Method Name : insert_job_ja_level
	 * @Date : 2018. 12. 26.
	 * @User : 이재준
	 * @Param : 업무에 필요한 일본어 정보 객체
	 * @Return : -
	 * @Method 설명 : FAP 채용공고 업무에 필요한 일본어 정보 저장
	 */
	public void insert_job_ja_level(SocietyFapJobJaLevel JobJaLevel);
	
	/**
	 * @Method Name : insert_job_trial
	 * @Date : 2018. 12. 26.
	 * @User : 이재준
	 * @Param : 시용기간 정보 객체
	 * @Return : -
	 * @Method 설명 : 시용기간 정보 저장
	 */
	public void insert_job_trial(SocietyFapJobTrial JobTrial);
	
	/**
	 * @Method Name : insert_job_comp
	 * @Date : 2018. 12. 27.
	 * @User : 이재준
	 * @Param : 회사명 정보 객체
	 * @Return : -
	 * @Method 설명 : 회사명 정보 저장
	 */
	public void insert_job_comp(SocietyFapJobComp JobComp);
	
	/**
	 * @Method Name : insert_job_file
	 * @Date : 2018. 12. 30.
	 * @User : 이재준
	 * @Param : 채용공고 파일 객체 
	 * @Return : -
	 * @Method 설명 : 파일 정보 저장
	 */
	public void insert_job_file(SocietyFapJobFile JobFile);
	
	/**
	 * @Method Name : insert_job_isr
	 * @Date : 2018. 12. 31.
	 * @User : 이재준
	 * @Param : 채용공고 보험 객체 
	 * @Return : -
	 * @Method 설명 : 보험 정보 저장
	 */
	public void insert_job_isr(SocietyFapJobIsr JobIsr);
	
	/**
	 * @Method Name : insert_job_join_dt
	 * @Date : 2018. 12. 31.
	 * @User : 이재준
	 * @Param : 채용공고 입사예정일 객체 
	 * @Return : -
	 * @Method 설명 : 입사예정일 정보 저장
	 */
	public void insert_job_join_dt(SocietyFapJobJoinDt JobJoinDt);
	
	/**
	 * @Method Name : insert_job_work
	 * @Date : 2018. 12. 31.
	 * @User : 이재준
	 * @Param : 채용공고 주요업무 객체 
	 * @Return : -
	 * @Method 설명 : 주요업무 정보 저장
	 */
	public void insert_job_work(SocietyFapJobWork JobWork);
	
	/**
	 * @Method Name : insert_job_category
	 * @Date : 2018. 12. 31.
	 * @User : 이재준
	 * @Param : 채용공고 모집직종 객체 
	 * @Return : -
	 * @Method 설명 : 모집직종 정보 저장
	 */
	public void insert_job_category(List<SocietyFapJobCategory> JobCategory);
	
	/**
	 * @Method Name : insert_job_category_etc
	 * @Date : 2019. 2. 8.
	 * @User : 이재준
	 * @Param : 채용공고 모집직종(기타) 객체 
	 * @Return : -
	 * @Method 설명 : 모집직종(기타) 정보 저장
	 */
	public void insert_job_category_etc(SocietyFapJobCategoryEtc JobCategoryEtc);
	
	/**
	 * @Method Name : insert_job_pref
	 * @Date : 2018. 12. 31.
	 * @User : 이재준
	 * @Param : 채용공고 우대사항 객체 
	 * @Return : -
	 * @Method 설명 : 우대사항 정보 저장
	 */
	public void insert_job_pref(SocietyFapJobPref JobPref);
	
	/**
	 * @Method Name : insert_job_workplace
	 * @Date : 2019. 1. 2.
	 * @User : 이재준
	 * @Param : 채용공고 근무예정지 객체 
	 * @Return : -
	 * @Method 설명 : 근무예정지 정보 저장
	 */
	public void insert_job_workplace(List<SocietyFapJobWorkplace> jobWorkplaceList);
	
	/**
	 * @Method Name : insert_job_workplace_dtl
	 * @Date : 2019. 1. 2.
	 * @User : 이재준
	 * @Param : 채용공고 상세근무예정지 객체 
	 * @Return : -
	 * @Method 설명 : 상세근무예정지 정보 저장
	 */
	public void insert_job_workplace_dtl(List<SocietyFapJobWorkplaceDtl> jobWorkplaceDtlList);
	
	/**
	 * @Method Name : insert_job_workplace_etc
	 * @Date : 2019. 2. 8.
	 * @User : 이재준
	 * @Param : 채용공고 근무예정지(기타) 객체 
	 * @Return : -
	 * @Method 설명 : 근무예정지(기타) 정보 저장
	 */
	public void insert_job_workplace_etc(SocietyFapJobWorkplaceEtc JobWorkplaceEtc);
	
	/**
	 * @Method Name : insert_job_recruitpcs
	 * @Date : 2019. 1. 7.
	 * @User : 이재준
	 * @Param : 채용공고 채용전형 객체 
	 * @Return : -
	 * @Method 설명 : 채용전형 정보 저장
	 */
	public void insert_job_recruitpcs(List<SocietyFapJobRecruitPcs> JobRecruitPcs);
	
	/**
	 * @Method Name : insert_job_itv
	 * @Date : 2019. 1. 7.
	 * @User : 이재준
	 * @Param : 채용공고 면접전형 객체 
	 * @Return : -
	 * @Method 설명 : 면접전형 정보 저장
	 */
	public void insert_job_itv(SocietyFapJobItv JobItv);
	
	/**
	 * @Method Name : insert_job_test_etc
	 * @Date : 2019. 1. 8.
	 * @User : 이재준
	 * @Param : 채용공고 기타전형 객체 
	 * @Return : -
	 * @Method 설명 : 기타전형 정보 저장
	 */
	public void insert_job_test_etc(SocietyFapJobTestEtc JobTestEtc);
	
	/**
	 * @Method Name : insert_job_test_etc_obj
	 * @Date : 2019. 1. 8.
	 * @User : 이재준
	 * @Param : 기타전형대상자(기타) 객체 
	 * @Return : -
	 * @Method 설명 : 기타전형대상자(기타) 정보 저장
	 */
	public void insert_job_test_etc_obj(SocietyFapJobTestEtcObj JobTestEtcObj);
	
	/**
	 * @Method Name : insert_job_itv_tp_etc
	 * @Date : 2019. 1. 8.
	 * @User : 이재준
	 * @Param : 면접방식(기타) 객체 
	 * @Return : -
	 * @Method 설명 : 면접방식(기타) 정보 저장
	 */
	public void insert_job_itv_tp_etc(SocietyFapJobItvTpEtc JobItvTpEtc);
	
	/**
	 * @Method Name : insert_job_itv_obj_etc
	 * @Date : 2019. 1. 8.
	 * @User : 이재준
	 * @Param : 면접대상자(기타) 객체 
	 * @Return : -
	 * @Method 설명 : 면접대상자(기타) 정보 저장
	 */
	public void insert_job_itv_obj_etc(SocietyFapJobItvObjEtc JobItvObjEtc);
	
	/**
	 * 
	 * @Method Name : insert_job_pay
	 * @Date : 2019. 1. 8.
	 * @User : 원병호
	 * @Param : 급여 객체
	 * @Return : 
	 * @Method 설명 : 급여 정보 저장
	 */
	public void insert_job_pay(List<SocietyFapJobPay> JobPay);
	
	/**
	 * 
	 * @Method Name : insert_job_pay_base
	 * @Date : 2019. 1. 9.
	 * @User : 원병호
	 * @Param : 
	 * @Return : 
	 * @Method 설명 :기본급 객체 정보 등록
	 */
	public void insert_job_pay_base(List<SocietyFapJobPayBase> JobPayBase);
			
			
	/**
	 * 		
	 * @Method Name : insert_job_pay_extra
	 * @Date : 2019. 1. 9.
	 * @User : 원병호
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 잔업수당 객체 정보 등록
	 */
	public void insert_job_pay_extra(SocietyFapJobPayExtra JobPayExtra);
			
	/**
	 * 
	 * @Method Name : insert_job_service_work
	 * @Date : 2019. 1. 9.
	 * @User : 원병호
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 서비스잔업수당 객체 정보 등록
	 */
	public void insert_job_service_work(SocietyFapJobServiceWork JobServiceWork);
			
	/**
	 * 
	 * @Method Name : insert_job_service_work
	 * @Date : 2019. 1. 9.
	 * @User : 원병호
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 기타수당 객체 정보 등록
	 */
	public void insert_job_pay_etc(List<SocietyFapJobPayEtc> JobPayEtc);		
			
			
		
			
	
	/**
	 * @Method Name : insert_job_exam
	 * @Date : 2019. 1. 8.
	 * @User : 이재준
	 * @Param : 채용공고 시험전형 객체 
	 * @Return : -
	 * @Method 설명 : 시험전형 정보 저장
	 */
	public void insert_job_exam(SocietyFapJobExam JobExam);
	
	/**
	 * @Method Name : insert_job_exam_obj_etc
	 * @Date : 2019. 1. 9.
	 * @User : 이재준
	 * @Param : 시험대상자(기타) 객체 
	 * @Return : -
	 * @Method 설명 : 시험대상자(기타) 정보 저장
	 */
	public void insert_job_exam_obj_etc(SocietyFapJobExamObjEtc JobExamObjEtc);
	
	/**
	 * @Method Name : insert_job_exam_sv_etc
	 * @Date : 2019. 1. 9.
	 * @User : 이재준
	 * @Param : 시험감독관(기타) 객체 
	 * @Return : -
	 * @Method 설명 : 시험감독관(기타) 정보 저장
	 */
	public void insert_job_exam_sv_etc(SocietyFapJobExamSvEtc JobExamSvEtc);
	
	/**
	 * @Method Name : insert_job_exam_need_etc
	 * @Date : 2019. 1. 9.
	 * @User : 이재준
	 * @Param : 시험준비물(기타) 객체 
	 * @Return : -
	 * @Method 설명 : 시험준비물(기타) 정보 저장
	 */
	public void insert_job_exam_need_etc(SocietyFapJobExamNeedEtc JobExamNeedEtc);
	
	/**
	 * @Method Name : insert_job_exam_file
	 * @Date : 2019. 1. 9.
	 * @User : 김준영
	 * @Param : 시험 파일 객체
	 * @Return : -
	 * @Method 설명 : 시험 파일을 저장하는 함수
	 */
	public void insert_job_exam_file(SocietyFapJobExamFile JobExamFile);
	
	/**
	 * @Method Name : insert_job_exam_type
	 * @Date : 2019. 1. 9.
	 * @User : 이재준
	 * @Param : 시험종류 객체 
	 * @Return : -
	 * @Method 설명 : 시험종류 정보 저장
	 */
	public void insert_job_exam_type(List<SocietyFapJobExamType> jobExamTypeList);
	
	/**
	 * @Method Name : select_job_pay
	 * @Date : 2019. 1. 10.
	 * @User : 원병호
	 * @Param : fap_job_ad_seq
	 * @Return : 급여 관련 모든 정보를 담은 map
	 * @Method 설명 : 급여 관련 모든 정보를 가져옵니다.
	 */
	public HashMap<String, Object> select_job_pay(long fap_job_ad_seq);
	
	/**
	 * @Method Name : select_job_ad_list
	 * @Date : 2019. 1. 10.
	 * @User : 이재준
	 * @Param : fap_comp_id
	 * @Return : 채용공고 기본 정보 객체
	 * @Method 설명 : 채용공고 관리에서 채용공고 기본정보 출력
	 */
	public ArrayList<SocietyFapJobAd> select_job_ad_list(String fap_comp_id);
	
	/**
	 * @Method Name : selectJobAd
	 * @Date : 2019. 1. 10.
	 * @User : 이재준
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 채용공고 정보 수정
	 */
	public HashMap<String, Object> selectJobAd(HashMap<String, Object> param);
	
	//채용공고 이전 끝
	
	/**
	 * @Method Name : select_job_ideal_person
	 * @Date : 2019. 1. 11.
	 * @User : 김준영
	 * @Param : 채용공고 정보 seq
	 * @Return : 채용공고 정보, 주요 업무 정보, 업무에 필요한 능력, 우대사항 
	 * @Method 설명 : 채용공고 정보, 주요 업무, 인재상, 기술상세를 가져오는 함수
	 */
	public HashMap<String, Object> select_job_ideal_person(long fap_job_ad_seq);
	
	/**
	 * @Method Name : algorithm_company_setting_search
	 * @Date : 2019. 1. 11.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 
	 * @Method 설명 : 채용공고당 현지잡페어 시간 설정 조회
	 */
	public HashMap<String, Object> algorithm_company_setting_search(Long fap_job_ad_seq);
	
	/**
	 * @Method Name : select_job_ad
	 * @Date : 2019. 1. 14.
	 * @User : 김준영
	 * @Param : 채용공고 정보 seq
	 * @Return : 채용공고 정보
	 * @Method 설명 : 기본 채용공고 정보를 가져오는 함수
	 */
	public SocietyFapJobAd select_job_ad(Long fap_job_ad_seq);
	
	/**
	 * @Method Name : select_job_recruit_pcs
	 * @Date : 2019. 1. 14.
	 * @User : 김준영
	 * @Param : 채용공고 정보 seq
	 * @Return : 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일
	 * @Method 설명 : 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_job_recruit_pcs(Long fap_job_ad_seq);
	
	/**
	 * @Method Name : select_job_category
	 * @Date : 2019. 1. 14.
	 * @User : 이재준
	 * @Param : fap_job_ad_seq
	 * @Return : 모집직종 관련 모든 정보를 담은 map
	 * @Method 설명 : 모집직종 관련 모든 정보를 가져옵니다.
	 */
	public HashMap<String, Object> select_job_category(long fap_job_ad_seq);

	/**
	 * @Method Name : update_job_ad
	 * @Date : 2019. 1. 15.
	 * @User : 원병호
	 * @Param : 채용공고정보 객체
	 * @Return : 
	 * @Method 설명 : 채용공고정보 수정
	 */
	public void update_job_ad(SocietyFapJobAd jobAd);
	
	/**
	 * @Method Name : update_job_recruit_pcs
	 * @Date : 2019. 1. 15.
	 * @User : 김준영
	 * @Param : 채용전형 객체
	 * @Return : -
	 * @Method 설명 : 채용전형 수정
	 */
	public void update_job_recruit_pcs(SocietyFapJobRecruitPcs jobRecruitPcs);
	
	/**
	 * @Method Name : search_company_jobfair_list
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 회사 아이디
	 * @Return : 회사 잡페어 정보 리스트
	 * @Method 설명 : 회사 잡페어 정보 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>>search_company_jobfair_list(String fap_comp_id);
	
	/**
	 * @Method Name : search_company_jobfair_divide_list
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스, 회사 아이디
	 * @Return : 회사 잡페어세부 정보 리스트
	 * @Method 설명 : 회사 잡페어세부 정보 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>>search_company_jobfair_divide_list(SocietyFapJobRecruitPcsSch recruit_pcs_sch);
	
	/**
	 * @Method Name : select_company_recruit_pcs_sch
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 채용기업 전형일정 스케줄 검색 정보
	 * @Return : 채용기업 전형일정 스케줄
	 * @Method 설명 : 채용기업 전형일정 스케줄 검색
	 */
	public ArrayList<HashMap<String, Object>> select_company_recruit_pcs_sch(SocietyFapJobRecruitPcsSch recruit_pcs_sch);
	
	
	
	
	/**
	 * @Method Name : delete_job_recruit_pcs_selective
	 * @Date : 2019. 1. 16.
	 * @User : 김준영
	 * @Param : 채용공고 seq, 채용전형 seq
	 * @Return : -
	 * @Method 설명 : 수정에서 지운 채용전형을 지워주는 함수
	 */
	public void delete_job_recruit_pcs_selective(HashMap<String, Object> hashMap);
	
	/**
	 * @Method Name : select_pcs_seq_list
	 * @Date : 2019. 1. 16.
	 * @User : 김준영
	 * @Param : 채용공고 seq
	 * @Return : 채용전형 seq list
	 * @Method 설명 : 채용공고에 해당하는 채용전형 seq list를 가져오는 함수
	 */
	public ArrayList<Long> select_pcs_seq_list(Long fap_job_ad_seq);
	/**
	 * @Method Name : delete_job_dorm
	 * @Date : 2019.01.16
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 기숙사 정보 삭제
	 */
	public void delete_job_dorm(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_jit_employee
	 * @Date : 2019.01.16
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 계약사원 정보 삭제
	 */
	public void delete_job_jit_employee(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_ja_level
	 * @Date : 2019.01.16
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 업무에 필요한 일본어 정보 삭제
	 */
	public void delete_job_ja_level(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_pref
	 * @Date : 2019.01.16
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 우대사항 정보 삭제
	 */
	public void delete_job_pref(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_join_dt
	 * @Date : 2019.01.16
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 입사예정일 정보 삭제
	 */
	public void delete_job_join_dt(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_trial
	 * @Date : 2019.01.16
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 시용기간 정보 삭제
	 */
	public void delete_job_trial(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_isr
	 * @Date : 2019.01.16
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 보험정보 삭제
	 */
	public void delete_job_isr(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_pay
	 * @Date : 2019.01.16
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 급여정보 삭제
	 */
	public void delete_job_pay(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_work
	 * @Date : 2019.01.16
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 주요업무 정보 삭제
	 */
	public void delete_job_work(long fap_job_ad_seq);
	
	/**
	 * @Method Name : select_company_review_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 채용기업 서류전형 시퀀스
	 * @Return : 채용기업 서류전형 정보
	 * @Method 설명 : 채용기업 서류전형 정보 검색
	 */
	public HashMap<String, Object> select_company_review_pcs(long fap_job_recruit_pcs_seq);
	
	/**
	 * @Method Name : delete_job_file
	 * @Date : 2019.01.16
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 파일 정보 삭제
	 */
	public void delete_job_file(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_category
	 * @Date : 2019.01.16
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 모집직종 정보 삭제
	 */
	public void delete_job_category(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_workplace
	 * @Date : 2019.01.16
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 근무예정지 정보 삭제
	 */
	public void delete_job_workplace(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_comp
	 * @Date : 2019.01.16
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 회사명 정보 삭제
	 */
	public void delete_job_comp(long fap_job_ad_seq);
	
	/**
	 * @Method Name : select_company_exam_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 채용기업 시험전형 시퀀스
	 * @Return : 채용기업 시험전형 정보
	 * @Method 설명 : 채용기업 시험전형 정보 검색
	 */
	public HashMap<String, Object> select_company_exam_pcs(long fap_job_recruit_pcs_seq);
	
	/**
	 * @Method Name : select_company_itv_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 채용기업 면접전형 시퀀스
	 * @Return : 채용기업 면접전형 정보
	 * @Method 설명 : 채용기업 면접전형 정보 검색
	 */
	public HashMap<String, Object> select_company_itv_pcs(long fap_job_recruit_pcs_seq);
	
	/**
	 * @Method Name : select_company_test_etc_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 채용기업 기타전형 시퀀스
	 * @Return : 채용기업 기타전형 정보
	 * @Method 설명 : 채용기업 기타전형 정보 검색
	 */
	public HashMap<String, Object> select_company_test_etc_pcs(long fap_job_recruit_pcs_seq);
	
	/**
	 * @Method Name : editable_check
	 * @Date : 2019. 1. 17.
	 * @User : 김준영
	 * @Param : 채용전형 seq
	 * @Return : 전형별지원결과정보 seq list
	 * @Method 설명 : 채용전형의 수정 가능 여부를 확인 하는 함수
	 */
	public int editable_check(long fap_job_recruit_pcs_seq);
	
	/**
	 * @Method Name : delete_job_exam
	 * @Date : 2019. 1. 18.
	 * @User : 김준영
	 * @Param : 채용전형 seq
	 * @Return : -
	 * @Method 설명 : 시험전형 정보를 삭제하는 함수
	 */
	public void delete_job_exam(long fap_job_recruit_pcs_seq);
	
	/**
	 * @Method Name : delete_job_exam
	 * @Date : 2019. 1. 18.
	 * @User : 김준영
	 * @Param : 채용전형 seq
	 * @Return : -
	 * @Method 설명 : 면접전형 정보를 삭제하는 함수
	 */
	public void delete_job_itv(long fap_job_recruit_pcs_seq);
	
	/**
	 * @Method Name : delete_job_exam
	 * @Date : 2019. 1. 18.
	 * @User : 김준영
	 * @Param : 채용전형 seq
	 * @Return : -
	 * @Method 설명 : 시험전형 정보를 삭제하는 함수
	 */
	public void delete_job_test_etc(long fap_job_recruit_pcs_seq);
	



	public ArrayList<SocietyFapCompanyRoadmapJobfair> select_jobfair_now();			//잡페어 목록(진행중)
	public ArrayList<SocietyFapCompanyRoadmapJobfair> select_jobfair_before();		//잡페어 목록(시작전)
	public ArrayList<SocietyFapCompanyRoadmapJobfair> select_jobfair_after();		//잡페어 목록(종료된)

	/**
	 * @Method Name : terms_update
	 * @Date : 2019. 1. 23.
	 * @User : 김준영
	 * @Param : 회원 객체
	 * @Return : 함수 작동 여부
	 * @Method 설명 : 회원의 약관 동의를 업데이트 하는 함수
	 */
	public int terms_update(User user);
	
	/**
	 * @Method Name : select_job_ad_by_state
	 * @Date : 2019. 1. 24.
	 * @User : 원병호
	 * @Param : hashmap (fap_comp_id, jobfair_seq, jobfair_divide_seq)
	 * @Return : 
	 * @Method 설명 : 대기중인 채용공고 정보 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_job_ad_by_state(HashMap<String, Object> parmas);
	
	/**
	 * @Method Name : update_job_ad_state
	 * @Date : 2019. 1. 26.
	 * @User : Administrator
	 * @Param : SocietyFapJobAd
	 * @Return : 
	 * @Method 설명 : 채용공고 상태를 수정하는 함수
	 */
	public int update_job_ad_state(SocietyFapJobAd jobAd);

	/**
	 * @Method Name : insert_connect_request
	 * @Date : 2019. 2. 7.
	 * @User : 김준영
	 * @Param : 기업 - 담당자 연결 요청 객체
	 * @Return : 요청 등록 성공 여부
	 * @Method 설명 : 기업 - 담당자 연결을 요청하는 함수
	 */
	public int insert_connect_request(SocietyFapCompUserConnectRequest CompUserConnectRequest);
	
	/**
	 * @Method Name : select_connect_request
	 * @Date : 2019. 2. 7.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 기업 - 담당자 연결 요청 객체
	 * @Method 설명 : 기업 - 담당자 연결 요청 객체를 가져오는 함수
	 */
	public ArrayList<SocietyFapCompUserConnectRequest> select_comp_user_connect_request(String user_id);
	
	/**
	 * @Method Name : delete_connect_request
	 * @Date : 2019. 2. 7.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : -
	 * @Method 설명 : 기업 - 담당자 연결 요청을 삭제하는 함수
	 */
	public int delete_connect_request(int fap_comp_user_request_seq);
	
	/**
	 * @Method Name : company_pay_for_cost
	 * @Date : 2019. 2. 8.
	 * @User : 이종호
	 * @Param : 유저 아이디
	 * @Return : -
	 * @Method 설명 : FAP 기업 - 비용결제 검색
	 */
	public ArrayList<HashMap<String, Object>> company_pay_for_cost(HashMap<String, Object> params);

	/**
	 * @Method Name : select_job_ad_load_list_paging
	 * @Date : 2019. 2. 9.
	 * @User : 정대영
	 * @Param : 기업 아이디
	 * @Return : 채용공고
	 * @Method 설명 : 기업이 작성한 모든 채용공고를 불러오는 함수(페이징 처리 후) 
	 */
	public ArrayList<HashMap<String, Object>> select_job_ad_load_list_paging(HashMap<String, Object> paramMap, RowBounds rb);
	
	/**
	 * @Method Name : select_job_ad_load_list_count
	 * @Date : 2019. 2. 9.
	 * @User : 정대영
	 * @Param : 기업 아이디
	 * @Return : 채용공고 개수
	 * @Method 설명 : 기업이 작성한 모든 채용공고 총 개수를 불러오는 함수 
	 */
	public int select_job_ad_load_list_count(HashMap<String, Object> paramMap);
	
	/**
	 * @Method Name : delete_job_ad_box
	 * @Date : 2019. 2. 11.
	 * @User : 김준영
	 * @Param : 채용공고 seq
	 * @Return : 삭제 여부
	 * @Method 설명 : 채용공고를 삭제하는 함수
	 */
	public int delete_job_ad_box(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_ag_comp_connect
	 * @Date : 2019. 2. 12.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : -
	 * @Method 설명 : 에이전시 - 기업 연결을 삭제하는 함수
	 */
	public void delete_ag_comp_connect(String user_id);
		
	/**
	 * @Method Name : select_job_file
	 * @Date : 2019. 2. 11.
	 * @User : 원병호
	 * @Param : 채용공고 seq
	 * @Return : 채용공고 파일 리스트
	 * @Method 설명 : 해당 채용공고의 첨부파일을 불러오는 함수
	 */
	public ArrayList<SocietyFapJobFile> select_job_file(long fap_job_ad_seq);
		
	/**
	 * @Method Name : board_contents_search
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : 게시판 관리의 특정 게시판 정보 객체
	 * @Return : fap 공지사항 게시글 리스트
	 * @Method 설명 : 게시글 리스트를 가져오는 함수
	 */
	public ArrayList<BoardContent> company_board_contents_search(HashMap<String, Object> map);
	
	/**
	 * @Method Name : board_contents_count
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : 게시판 관리의 특정 게시판 정보 객체
	 * @Return : fap 공지사항 게시판의 게시글 갯수
	 * @Method 설명 : 페이징을 위한 전체글 갯수 조회하는 함수
	 */
	public int board_contents_count(HashMap<String, Object> map);
	
	/**
	 * @Method Name : company_board_contents_list_search
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : 게시판 시퀀스
	 * @Return : 기업 잡페어 공지사항 게시판 리스트
	 * @Method 설명 : 기업 잡페어 공지사항 게시판 리스트 검색 함수
	 */
	public ArrayList<BoardContent> company_board_contents_list_search(HashMap<String, Object> map);
	
	/**
	 * @Method Name : search_applicant_info
	 * @Date : 2019. 2. 15.
	 * @User : 신동철
	 * @Param : 채용공고 seq, 회사 아이디
	 * @Return : 채용전형 진행중, 합격, 추가합격 정규지원자 정보
	 * @Method 설명 : 채용전형 진행중, 합격, 추가합격 정규지원자 정보 불러오는 함수
	 */
	public ArrayList<HashMap<String, Object>> search_applicant_info(HashMap<String, Object> hashmap);
	
	/**
	 * @Method Name : select_job_ad_recruit_pcs
	 * @Date : 2019. 2. 15.
	 * @User : 신동철
	 * @Param : 채용공고 시퀀스
	 * @Return : 채용공고 채용전형 정보
	 * @Method 설명 : 채용공고 지원자관리 채용전형 정보 검색 함수
	 */
	public ArrayList<SocietyFapJobRecruitPcs> select_job_ad_recruit_pcs(long fap_job_ad_seq);

	/**
	 * @Method Name : select_my_applied_resume
	 * @Date : 2019. 02. 19.
	 * @User : 남유송
	 * @Param : int
	 * @Return : HashMap
	 * @Method 설명 : 채용공고별 지원자 이력서 가져오기
	 */
	public HashMap<String, Object> selectResumeApply(int fap_resume_seq);
	
	/**
	 * @Method Name : search_unaccepted_applicant_info
	 * @Date : 2019. 2. 19.
	 * @User : 신동철
	 * @Param : 채용공고 seq, 회사 아이디
	 * @Return : 채용전형 지원자 정보
	 * @Method 설명 : 채용전형 불합격 지원자 정보 불러오는 함수
	 */
	public ArrayList<HashMap<String, Object>> search_unaccepted_applicant_info(HashMap<String, Object> hashmap);
	
	/**
	 * @Method Name : board_contents_detail
	 * @Date : 2019. 2. 19.
	 * @User : 김준영
	 * @Param : 게시판 내용 seq
	 * @Return : 게시판 세부 내용
	 * @Method 설명 : 게시판 세부 내용을 가져오는 함수
	 */
	public HashMap<String, Object> board_contents_detail(int board_content_seq);
	
	/**
	 * @Method Name : select_job_exam_file
	 * @Date : 2019. 2. 19.
	 * @User : 원병호
	 * @Param : 채용공고 시퀀스
	 * @Return : 시험전형 파일 리스트
	 * @Method 설명 : 해당 채용공고의 시험전형 파일 리스트 검색
	 */
	public ArrayList<SocietyFapJobExamFile> select_job_exam_file(long fap_job_ad_seq);
	
	/**
	 * @Method Name : search_missmatching_applicant_info
	 * @Date : 2019. 2. 21.
	 * @User : 신동철
	 * @Param : 채용공고 seq, 회사 아이디
	 * @Return : 채용전형 진행중, 합격, 추가합격 미스매칭 지원자 정보
	 * @Method 설명 : 채용전형 진행중, 합격, 추가합격 미스매칭 지원자 정보 불러오는 함수
	 */
	public ArrayList<HashMap<String, Object>> search_missmatching_applicant_info(HashMap<String, Object> hashmap);
	
	/**
	 * @Method Name : update_fap_job_apply_result
	 * @Date : 2019. 2. 19.
	 * @User : 신동철
	 * @Param : 전형별 결과
	 * @Return : -
	 * @Method 설명 : 지원자 전형별 지원결과 수정하는 함수
	 */
	public int update_fap_job_apply_result(ArrayList<SocietyFapJobApplyResult> applyResultList);
	
	/**
	 * @Method Name : update_fap_job_final_result
	 * @Date : 2019. 2. 19.
	 * @User : 신동철
	 * @Param : 최종결과
	 * @Return : -
	 * @Method 설명 : 채용전형 지원자 최종결과 수정하는 함수
	 */
	public void update_fap_job_final_result(ArrayList<SocietyFapJobApplyFinalResult> finalResultList);
	
	/**
	 * @Method Name : insert_pass_comment
	 * @Date : 2019. 2. 24.
	 * @User : 신동철
	 * @Param : 최종결과 합격사유
	 * @Return : -
	 * @Method 설명 : 지원자 최종결과 합격사유 등록하는 함수
	 */
	public void insert_pass_comment(SocietyFapJobApplyFinalResult passComment);
	
	/**
	 * @Method Name : insert_nominee
	 * @Date : 2019. 2. 24.
	 * @User : 신동철
	 * @Param : 내정자 리스트
	 * @Return : -
	 * @Method 설명 : 최종결과 합격한 내정자를 등록하는 함수
	 */
	public void insert_nominee(ArrayList<SocietyFapNominee> nomineeList);
	
	/**
	 * @Method Name : select_nominee
	 * @Date : 2019. 2. 26.
	 * @User : 신동철
	 * @Param : 채용공고시퀀스, 지원자 아이디
	 * @Return : 내정자 정보
	 * @Method 설명 : 최종결과 합격한 내정자 정보를 검색하는 함수
	 */
	public SocietyFapNominee select_nominee(HashMap<String, Object> hashmap);
	
	/**
	 * @Method Name : delete_nominee
	 * @Date : 2019. 2. 26.
	 * @User : 신동철
	 * @Param : 내정자 시퀀스
	 * @Return : -
	 * @Method 설명 : 최종결과가 불합격으로 바뀐 내정자 삭제하는 함수
	 */
	public void delete_nominee(long fap_nominee_seq);
	
	/**
	 * @Method Name : select_job_qna
	 * @Date : 2019. 3. 5.
	 * @User : 원병호
	 * @Param : 채용공고 일련번호
	 * @Return : 채용공고 Q&A 리스트
	 * @Method 설명 : 해당 채용공고의 Q&A리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> select_job_qna(long fap_job_ad_seq);
	
	/**
	 * @Method Name : select_job_qna_one
	 * @Date : 2019. 3. 6.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 질문 일련번호
	 * @Return : 해당 Q&A의 질문, 답변 정보
	 * @Method 설명 : 해당 Q&A의 질문, 답변 정보 
	 */
	public HashMap<String, Object> select_job_qna_one(long fap_job_qna_question_seq);
	
	/**
	 * @Method Name : insert_job_qna_question
	 * @Date : 2019. 3. 6.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 답변 객체
	 * @Return : 
	 * @Method 설명 : 채용공고 Q&A 답변 등록
	 */
	public int insert_job_qna_question(SocietyFapQnaAnswer qnaAnswer);
	
	/**
	 * @Method Name : update_job_qna_question_approve
	 * @Date : 2019. 3. 6.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 질문 일련번호
	 * @Return : 
	 * @Method 설명 : 답변완료로 상태 변경
	 */
	public void update_job_qna_question_approve(long fap_job_qna_question_seq);
	
	/**
	 * @Method Name : update_job_qna_question
	 * @Date : 2019. 3. 6.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 답변 객체
	 * @Return : 
	 * @Method 설명 : 채용공고 Q&A 답변 수정
	 */
	public void update_job_qna_question(SocietyFapQnaAnswer qnaAnswer);
	
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
	 * @Method Name : board_contents_hit_update
	 * @Date : 2019. 7. 16.
	 * @User : 김경아
	 * @Param : 게시글 시퀀스
	 * @Return : 
	 * @Method 설명 :  해당 게시글의 세부 내용 중 조회수를 증가 시키는 함수
	 */
	public void board_contents_hit_update(int board_content_seq);

	/**
	 * @Method Name : select_comp_name
	 * @Date : 2019. 7. 21.
	 * @User : 김경아		
	 * @Param : 게시판 세부구분
	 * @Return : 게시판 이름 
	 * @Method 설명 : 게시판 이름 조회 
	 */
	public String select_comp_name(String board_detail_gb);

	/**
	 * @Method Name : select_interview_limit_check
	 * @Date : 2019. 8. 1.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 채용공고별 현지면접인원 제한 정보
	 * @Method 설명 : 채용공고별 현지면접 대상자 인원제한 체크용 검색
	 */
	public HashMap<String, Object> select_interview_limit_check(long fap_job_ad_seq);
 
	/**
	 * @Method Name : select_interview_limit_type
	 * @Date : 2019. 8. 1.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 현지면접인원 제한 계열
	 * @Method 설명 : 잡페어별 현지면접인원 제한 계열 검색
	 */
	public String select_interview_limit_type(int fap_jobfair_seq);
	
	/**
	 * @Method Name : tokyofair_screening_date_check
	 * @Date : 2019. 9. 24.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : 도쿄페어 기업 전형 등록 가능 여부 ( 1: 가능 , 0: 불가능 )
	 * @Method 설명 : 도쿄페어 기업 전형 등록 가능 여부 ( 1: 가능 , 0: 불가능 ) 조회
	 */
	public int tokyofair_screening_date_check(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : tokyofair_screening_subject_search
	 * @Date : 2019. 9. 26.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 도쿄페어 전형 대상자
	 * @Method 설명 : 도쿄페어 전형 대상자 조회
	 */
	public ArrayList<HashMap<String, Object>> tokyofair_screening_subject_search(long fap_job_ad_seq);
	
	/**
	 * @Method Name : tokyofair_screening_subject_search_some
	 * @Date : 2019. 9. 26.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 도쿄페어 전형 확정대상자 제외 대상자
	 * @Method 설명 : 도쿄페어 전형 확정대상자 제외 대상자 조회 시작
	 */
	public ArrayList<HashMap<String, Object>> tokyofair_screening_subject_search_some(long fap_job_ad_seq);
	
	/**
	 * @Method Name : tokyofair_scr_user_select_group
	 * @Date : 2019. 9. 30.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 시퀀스
	 * @Return : 도쿄페어 전형별 등록인원
	 * @Method 설명 : 도쿄페어 전형별 등록인원 조회
	 */
	public ArrayList<HashMap<String, Object>> tokyofair_scr_user_select_group(int fap_tokyofair_screening_seq);
	
	/**
	 * @Method Name : tokyofair_screening_insert
	 * @Date : 2019. 9. 26.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 전형 정보 등록  
	 */
	public void tokyofair_screening_insert(SocietyFapTokyofairScreening tokyofairScr);
	
	/**
	 * @Method Name : tokyofair_scr_user_insert
	 * @Date : 2019. 9. 26.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 인원 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 전형 인원 정보 등록 
	 */
	public void tokyofair_scr_user_insert(List<SocietyFapTokyofairScrUser> scrUserList);
	
	/**
	 * @Method Name : tokyofair_screening_update
	 * @Date : 2019. 9. 30.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 전형 정보 수정 
	 */
	public void tokyofair_screening_update(SocietyFapTokyofairScreening tokyofairScr);
	
	/**
	 * @Method Name : tokyofair_scr_user_delete
	 * @Date : 2019. 9. 30.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 인원 정보 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 전형 인원 정보 삭제 
	 */
	public void tokyofair_scr_user_delete(int fap_tokyofair_screening_seq);
	
	/**
	 * @Method Name : tokyofair_scr_user_select
	 * @Date : 2019. 9. 26.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 도쿄페어 전형 등록 인원
	 * @Method 설명 : 도쿄페어 전형 등록 인원 조회
	 */
	public ArrayList<SocietyFapTokyofairScrUser> tokyofair_scr_user_select(long fap_job_ad_seq);
	
	/**
	 * @Method Name : tokyofair_screening_search_count
	 * @Date : 2019. 9. 26.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 도쿄페어 전형 등록 개수
	 * @Method 설명 : 도쿄페어 전형 등록 개수 조회 
	 */
	public int tokyofair_screening_search_count(long fap_job_ad_seq);
	
	/**
	 * @Method Name : tokyofair_screening_search
	 * @Date : 2019. 9. 27.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 도쿄페어 전형 리스트
	 * @Method 설명 : 도쿄페어 전형 리스트 조회
	 */
	public ArrayList<SocietyFapTokyofairScreening> tokyofair_screening_search(long fap_job_ad_seq);
	
	/**
	 * @Method Name : tokyofair_screening_search_bookable
	 * @Date : 2019. 10. 4.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 도쿄페어 전형 중 예약 가능한 리스트
	 * @Method 설명 : 도쿄페어 전형 중 예약 가능한 리스트 조회 
	 */
	public ArrayList<SocietyFapTokyofairScreening> tokyofair_screening_search_bookable(long fap_job_ad_seq);
 	
	/**
	 * @Method Name : tokyofair_screening_search_one
	 * @Date : 2019. 9. 27.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 시퀀스
	 * @Return : 도쿄페어 전형 정보
	 * @Method 설명 : 도쿄페어 전형 정보 조회
	 */
	public HashMap<String, Object> tokyofair_screening_search_one(int fap_tokyofair_screening_seq);
	
	/**
	 * @Method Name : tokyofair_screening_delete
	 * @Date : 2019. 9. 30.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 전형 삭제 
	 */
	public int tokyofair_screening_delete(int fap_tokyofair_screening_seq);
	
	/**
	 * @Method Name : tokyofair_schedule_set_search
	 * @Date : 2019. 10. 1.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : 설정된 도쿄페어 설정 정보
	 * @Method 설명 : 설정된 도쿄페어 설정 정보 조회
	 */
	public SocietyFapAdminJobfairSet tokyofair_schedule_set_search(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : tokyofair_schedule_date_check
	 * @Date : 2019. 10. 4.
	 * @User : 이종호
	 * @Param : 도쿄페어 날짜 정보
	 * @Return : 도쿄페어 날짜 시퀀스
	 * @Method 설명 : 도쿄페어 날짜 등록여부 확인
	 */
	public Integer tokyofair_schedule_date_check(HashMap<String, Object> params);
	
	/**
	 * @Method Name : tokyofair_schedule_date_insert
	 * @Date : 2019. 10. 4.
	 * @User : 이종호
	 * @Param : 도쿄페어 날짜 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 날짜 정보 등록 
	 */
	public int tokyofair_schedule_date_insert(HashMap<String, Object> params);
	
	/**
	 * @Method Name : tokyofair_schedule_info_insert
	 * @Date : 2019. 10. 4.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 일정 정보 등록 
	 */
	public int tokyofair_schedule_info_insert(HashMap<String, Object> params);
	
	/**
	 * @Method Name : tokyofair_schedule_info_check
	 * @Date : 2019. 10. 4.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 정보
	 * @Return : 0 가능, 1 불가능
	 * @Method 설명 : 도쿄페어 일정 가능여부 확인
	 */
	public int tokyofair_schedule_info_check(HashMap<String, Object> params);
	
	/**
	 * @Method Name : tokyofair_schedule_delete
	 * @Date : 2019. 10. 7.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 일정 삭제 
	 */
	public int tokyofair_schedule_delete(long fap_tokyofair_schedule_seq);
	
	/**
	 * @Method Name : tokyofair_schedule_member_delete
	 * @Date : 2019. 10. 11.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 인원 삭제 
	 */
	public void tokyofair_schedule_member_delete(long fap_tokyofair_schedule_seq);
	
	/**
	 * @Method Name : tokyofair_schedule_first_check
	 * @Date : 2019. 10. 7.
	 * @User : 이종호
	 * @Param : 도쿄페어 날짜 정보
	 * @Return : 최초일정 여부
	 * @Method 설명 : 도쿄페어 최초등록 일정 여부 판단
	 */
	public int tokyofair_schedule_first_check(SocietyFapTokyofairDate tokyofairDate);
	
	/**
	 * @Method Name : tokyofair_schedule_itv_comp_check
	 * @Date : 2019. 10. 7.
	 * @User : 이종호
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 도쿄페어 앞면접 과의 면접준비시간 체크 
	 */
	public int tokyofair_schedule_itv_comp_before_check(HashMap<String, Object> params);
	
	/**
	 * @Method Name : tokyofair_schedule_term_check
	 * @Date : 2019. 10. 8.
	 * @User : 이종호
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 도쿄페어 앞면접 과의 여유도 체크
	 */
	public int tokyofair_schedule_term_check(HashMap<String, Object> params);
	
	/**
	 * @Method Name : tokyofair_schedule_member_duplicate_check
	 * @Date : 2019. 10. 10.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 인원 정보
	 * @Return : 중복된 인원 정보
	 * @Method 설명 : 도쿄페어 일정 인원 중복 체크
	 */
	public HashMap<String, Object> tokyofair_schedule_member_duplicate_check(HashMap<String, Object> params);
	
	/**
	 * @Method Name : tokyofair_schedule_member_insert
	 * @Date : 2019. 10. 8.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 인원 정보
	 * @Return : 
	 * @Method 설명 : 도쿄페어 일정 인원 등록
	 */
	public void tokyofair_schedule_member_insert(HashMap<String, Object> scheduleMemberMap);
	
	/**
	 * @Method Name : tokyfair_schedule_booked_search
	 * @Date : 2019. 10. 10.
	 * @User : 이종호
	 * @Param : 현지 잡페어 설정 시퀀스 , 등록된 일정 날짜
	 * @Return : 등록된 일정 정보 리스트
	 * @Method 설명 : 도쿄페어 등록된 일정 정보 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> tokyfair_schedule_booked_search(HashMap<String, Object> params);
	
	/**
	 * @Method Name : job_ad_comp_id_search
	 * @Date : 2019. 10. 10.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 회사 아이디
	 * @Method 설명 : 채용공고 회사 아이디 조회
	 */
	public String job_ad_comp_id_search(long fap_job_ad_seq);
	
	/**
	 * @Method Name : tokyofair_screening_sch_gb_update
	 * @Date : 2019. 10. 11.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 일정등록 구분
	 * @Return : -
	 * @Method 설명 : 도쿄페어 전형 일정등록 구분 변경
	 */
	public void tokyofair_screening_sch_gb_update(HashMap<String, Object> params);
	
	/**
	 * @Method Name : tokyofair_schedule_search_detail
	 * @Date : 2019. 10. 11.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 시퀀스
	 * @Return : 도쿄페어 일정 및 인원 정보
	 * @Method 설명 : 도쿄페어 일정 정보 및 인원 정보 검색
	 */
	public HashMap<String, Object> tokyofair_schedule_search_detail(long fap_tokyofair_schedule_seq);
	
	/**
	 * @Method Name : tokyofair_screening_search_total
	 * @Date : 2019. 10. 11.
	 * @User : 이종호
	 * @Param : 회사 아이디, 세부 잡페어 시퀀스
	 * @Return : 도쿄페어 전체 전형 일정 정보
	 * @Method 설명 : 도쿄페어 전체 전형 일정 정보 조회 
	 */
	public HashMap<String, Object> tokyofair_screening_search_total(HashMap<String, Object> params);
	
}
