/**
 * 
 */
package global.segroup.society.fap.agency.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import global.segroup.domain.User;
import global.segroup.society.fap.agency.domain.SocietyFapAgencyCompanyConnect;
import global.segroup.society.fap.company.domain.SocietyFapCompanyUser;
import global.segroup.society.fap.company.domain.SocietyFapCompanyUserConnect;
import global.segroup.society.fap.company.domain.SocietyFapJobAd;
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

/**
 * @Author : 김준영
 * @Date : 2018. 12. 11.
 * @Class 설명 : Soft Engineer Society 통합잡페어 에이전시 Mapper
 * 
 */
public interface SocietyFapAgencyMapper {

	/**
	 * @Method Name : userIdCheck
	 * @Date : 2018. 12. 11.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 유저아이디 or null
	 * @Method 설명 : 유저 아이디 중복 검사 중복된 경우 아이디 값이 return되며 중복 되지 않은 경우 null이 return됨
	 */
	public String user_id_check(String user_id);
	
	/**
	 * @Method Name : insert_com_user
	 * @Date : 2018. 12. 13.
	 * @User : 김준영
	 * @Param : 유저 객체
	 * @Return : -
	 * @Method 설명 : 유저 등록을 하는 함수
	 */
	public void insert_com_user(User user);
	
	/**
	 * @Method Name : insert_agency
	 * @Date : 2018. 12. 13.
	 * @User : 김준영
	 * @Param : 에이전시 정보 객체
	 * @Return : -
	 * @Method 설명 : 에이전시 정보를 등록 하는 함수
	 */
	public void insert_agency(SocietyFapCompanyUser sfcUser);
	
	/**
	 * @Method Name : comp_user_connect
	 * @Date : 2018. 12. 13.
	 * @User : 김준영
	 * @Param : 에이전시-담당자 연결 객체
	 * @Return : -
	 * @Method 설명 : 에이전시와 담당자를 연결해주는 함수
	 */
	public void comp_user_connect(SocietyFapCompanyUserConnect sfCUConnect);
	
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
	 * @Method 설명 : 에이전시 담당자 정보를 수정하는 함수
	 */
	public void update_user(User user);
	
	/**
	 * @Method Name : agency_company_connect
	 * @Date : 2018. 12. 18.
	 * @User : 김준영
	 * @Param : 에이전시 기업 연결 객체
	 * @Return : -
	 * @Method 설명 : 에이전시와 기업을 연결해주는 함수
	 */
	public void agency_company_connect(SocietyFapAgencyCompanyConnect societyFapAgencyCompanyConnect);
	
	/**
	 * @Method Name : select_comp_user_connect
	 * @Date : 2018. 12. 18.
	 * @User : 김준영
	 * @Param : 회원 아이디
	 * @Return : 기업 - 회사 연결 객체
	 * @Method 설명 : 회원 아이디가 가지고 있는 기업 - 회사 연결 객체를 가져오는 함수
	 */
	public SocietyFapCompanyUserConnect select_comp_user_connect(String user_id);
	
	/**
	 * @Method Name : select_agen_user_connect
	 * @Date : 2019. 02. 11.
	 * @User : 김홍일
	 * @Param : 회원 아이디
	 * @Return : 기업 - 회사 연결 객체
	 * @Method 설명 : 회원 아이디가 가지고 있는 기업 - 회사 연결 객체를 가져오는 함수
	 */
	public SocietyFapCompanyUserConnect select_agen_user_connect(String user_id);
	
	/**
	 * @Method Name : select_ag_comp
	 * @Date : 2018. 12. 18.
	 * @User : 김준영
	 * @Param : 회원 아이디
	 * @Return : 에이전시 - 기업 연결 객체
	 * @Method 설명 : 회원 아이디가 가지고 있는 기업객체(에이전시)와 연결 되어있는 일반 기업을 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_ag_comp(String user_id);
	
	/**
	 * @Method Name : select_comp_list
	 * @Date : 2018. 12. 19.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 기업 객체 리스트
	 * @Method 설명 : 기업 객체를 불러오는 함수
	 */
	public ArrayList<SocietyFapCompanyUser> select_comp_list(String user_id);
	
	/**
	 * @Method Name : select_company
	 * @Date : 2018. 12. 19.
	 * @User : 김준영
	 * @Param : 에이전시 유저 아이디
	 * @Return : 기업 객체
	 * @Method 설명 : 에이전시 담당자 가지고 있는 기업 객체를 가져오는 함수
	 */
	public SocietyFapCompanyUser select_company(String fap_comp_id);
	
	/**
	 * @Method Name : update_company
	 * @Date : 2018. 12. 19.
	 * @User : 김준영
	 * @Param : 기업 정보 객체
	 * @Return : -
	 * @Method 설명 : 기업 정보를 업데이트 해주는 함수 
	 */
	public void update_company(SocietyFapCompanyUser sfcUser);
	
	/**
	 * @Method Name : insert_ag_comp_connect
	 * @Date : 2018. 12. 19.
	 * @User : 김준영
	 * @Param : 에이전시 아이디, 기업아이디
	 * @Return : -
	 * @Method 설명 : 에이전시가 관리하는 기업을 추가하는 함수
	 */
	public void insert_ag_comp_connect(HashMap<String, Object> hashMap);
	
	/**
	 * @Method Name : direct_request_connect
	 * @Date : 2018. 12. 21.
	 * @User : 김준영
	 * @Param : 에이전시 기업 연결 객체(회사 아이디는 배열)
	 * @Return : -
	 * @Method 설명 : 에이전시와 기업을 연결 요청을 보내는 함수
	 */
	public void connect_request(HashMap<String, Object> hashMap);
	
	/**
	 * @Method Name : agency_company_disconnect
	 * @Date : 2018. 12. 21.
	 * @User : 김준영
	 * @Param : 에이전시 기업 연결 SEQ
	 * @Return : -
	 * @Method 설명 : 에이전시 기업 연결을 끊은 후 기업 관리 페이지로 이동 
	 */
	public void ag_comp_disconnect(int fap_ag_comp_connect_seq);
	
	/**
	 * @Method Name : ck_ag_comp_connect
	 * @Date : 2018. 12. 21.
	 * @User : 김준영
	 * @Param : 기업 아이디
	 * @Return : 에이전시 - 기업 연결 객체
	 * @Method 설명 : 기업에 연결된 에이전시가 있는지 확인함
	 */
	public ArrayList<SocietyFapAgencyCompanyConnect> ck_ag_comp_connect(String user_id);
	
	/**
	 * @Method Name : update_ag_comp_connect
	 * @Date : 2018. 12. 21.
	 * @User : 김준영
	 * @Param : 에이전시 - 기업 연결 객체
	 * @Return : -
	 * @Method 설명 : 에이전시 - 기업 연결 객체의 승인 여부를 수정하는 함수
	 */
	public void update_ag_comp_connect(SocietyFapAgencyCompanyConnect societyFapAgencyCompanyConnect);
	
	/**
	 * @Method Name : delete_agency_user_info
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 탈퇴할 에이전시 담당자 정보 객체
	 * @Return : -
	 * @Method 설명 : 에이전시 담당자 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(30글자) 변경후 참조 테이블에 적용
	 */
	public void delete_agency_user_info(HashMap<String, String> updateMap);
	
	/**
	 * @Method Name : select_exclude_comp_list
	 * @Date : 2018. 12. 27.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 에이전시 - 기업 객체
	 * @Method 설명 : 이미 다른 에이전시와 연결되어 있는 에이전시 - 기업 객체를 가져오는 함수
	 */
	public ArrayList<SocietyFapAgencyCompanyConnect> select_exclude_comp_list(String user_id);
	
	/**
	 * @Method Name : select_company_compare_id
	 * @Date : 2018. 12. 31.
	 * @User : 김준영
	 * @Param : 기업 아이디
	 * @Return : 기업 객체
	 * @Method 설명 : 기업 아이디와 일치하는 정보를 가져오는 함수
	 */
	public SocietyFapCompanyUser select_company_compare_id(String fap_comp_id);
	
	/**
	 * @Method Name : delete_connect_request
	 * @Date : 2018. 12. 31.
	 * @User : 김준영
	 * @Param : 에이전시 - 기업 연결 객체
	 * @Return : -
	 * @Method 설명 : 에이전시가 기업 연결을 위해 보낸 요청을 삭제하는 함수
	 */
	public void delete_connect_request(SocietyFapAgencyCompanyConnect agencyCompanyConnect);
	
	/**
	 * @Method Name : select_agency
	 * @Date : 2019. 1. 2.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 에이전시 기업 객체
	 * @Method 설명 : 기업 중 에이전시 기업을 가져온다.
	 */
	public ArrayList<SocietyFapCompanyUser> select_agency();
	
	/**
	 * @Method Name : connect_refusal
	 * @Date : 2019. 1. 2.
	 * @User : 김준영
	 * @Param : 에이전시 담당자, 기업 담당자 아이디
	 * @Return : -
	 * @Method 설명 : 현재 로그인 한 에이전시 담당자가 가지고 있는 에이전시 기업과 일치 하지 않고, 
	 * 				 입력한 기업 담당자와 연결되어 있는 기업이 일치하는 에이전시 - 기업 담당자 객체의 승인 상태를 거절로 바꿈 
	 */
	public void connect_refusal(HashMap<String, Object> hashMap);
	
	/**
	 * @Method Name : select_agency_company
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 일반 기업을 제외한 에이전시 객체
	 * @Method 설명 : 기업 리스트중 일반 기업을 제외한 에이전시 객체 리스트를 가져오는 함수
	 */
	public ArrayList<SocietyFapCompanyUser> select_agency_company();
	
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
	 * @Method Name : jobfair_search_list
	 * @Date : 2019. 1. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 통합잡페어 정보
	 * @Method 설명 : 통합잡페어 정보 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> jobfair_search_list();	

	/**
	 * @Method Name : jobfair_divide_search_list
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어 세부정보 리스트
	 * @Method 설명 : 선택한 잡페어 세부정보 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> jobfair_divide_search_list(int fap_jobfair_seq);
	
	/**
	 * @Method Name : select_job_ad_list
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : fap_comp_id
	 * @Return : 채용공고 기본 정보 객체
	 * @Method 설명 : 채용공고 관리에서 채용공고 기본정보 출력
	 */
	public ArrayList<SocietyFapJobAd> select_job_ad_list(String fap_comp_id);
	
	/**
	 * @Method Name : insert_job_ad
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 채용공고 객체
	 * @Return : -
	 * @Method 설명 : FAP 채용공고 기본정보 저장
	 */
	public void insert_job_ad(SocietyFapJobAd JobAd);
	
	/**
	 * @Method Name : insert_job_dorm
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 기숙사 정보 객체
	 * @Return : -
	 * @Method 설명 : FAP 채용공고 기숙사 정보 저장
	 */
	public void insert_job_dorm(SocietyFapJobDorm JobDorm);
	
	/**
	 * @Method Name : insert_job_jit_employee
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 계약사원 정보 객체
	 * @Return : -
	 * @Method 설명 : FAP 채용공고 계약사원 정보 저장
	 */
	public void insert_job_jit_employee(SocietyFapJobJitEmployee JobJitEmployee);
	
	/**
	 * @Method Name : insert_job_ja_level
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 업무에 필요한 일본어 정보 객체
	 * @Return : -
	 * @Method 설명 : FAP 채용공고 업무에 필요한 일본어 정보 저장
	 */
	public void insert_job_ja_level(SocietyFapJobJaLevel JobJaLevel);
	
	/**
	 * @Method Name : insert_job_trial
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 시용기간 정보 객체
	 * @Return : -
	 * @Method 설명 : 시용기간 정보 저장
	 */
	public void insert_job_trial(SocietyFapJobTrial JobTrial);
	
	/**
	 * @Method Name : insert_job_comp
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 회사명 정보 객체
	 * @Return : -
	 * @Method 설명 : 회사명 정보 저장
	 */
	public void insert_job_comp(SocietyFapJobComp JobComp);
	
	/**
	 * @Method Name : insert_job_file
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 채용공고 파일 객체 
	 * @Return : -
	 * @Method 설명 : 파일 정보 저장
	 */
	public void insert_job_file(SocietyFapJobFile JobFile);
	
	/**
	 * @Method Name : insert_job_isr
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 채용공고 보험 객체 
	 * @Return : -
	 * @Method 설명 : 보험 정보 저장
	 */
	public void insert_job_isr(SocietyFapJobIsr JobIsr);
	
	/**
	 * @Method Name : insert_job_join_dt
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 채용공고 입사예정일 객체 
	 * @Return : -
	 * @Method 설명 : 입사예정일 정보 저장
	 */
	public void insert_job_join_dt(SocietyFapJobJoinDt JobJoinDt);
	
	/**
	 * @Method Name : insert_job_work
	 * @Date : 2019. 1. 22.
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
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 채용공고 우대사항 객체 
	 * @Return : -
	 * @Method 설명 : 우대사항 정보 저장
	 */
	public void insert_job_pref(SocietyFapJobPref JobPref);
	
	/**
	 * @Method Name : insert_job_workplace
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 채용공고 근무예정지 객체 
	 * @Return : -
	 * @Method 설명 : 근무예정지 정보 저장
	 */
	public void insert_job_workplace(List<SocietyFapJobWorkplace> jobWorkplaceList);
	
	/**
	 * @Method Name : insert_job_workplace_dtl
	 * @Date : 2019. 1. 22.
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
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 채용공고 채용전형 객체 
	 * @Return : -
	 * @Method 설명 : 채용전형 정보 저장
	 */
	public void insert_job_recruitpcs(List<SocietyFapJobRecruitPcs> JobRecruitPcs);
	
	/**
	 * @Method Name : insert_job_itv
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 채용공고 면접전형 객체 
	 * @Return : -
	 * @Method 설명 : 면접전형 정보 저장
	 */
	public void insert_job_itv(SocietyFapJobItv JobItv);
	
	/**
	 * @Method Name : insert_job_test_etc
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 채용공고 기타전형 객체 
	 * @Return : -
	 * @Method 설명 : 기타전형 정보 저장
	 */
	public void insert_job_test_etc(SocietyFapJobTestEtc JobTestEtc);
	
	/**
	 * @Method Name : insert_job_test_etc_obj
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 기타전형대상자(기타) 객체 
	 * @Return : -
	 * @Method 설명 : 기타전형대상자(기타) 정보 저장
	 */
	public void insert_job_test_etc_obj(SocietyFapJobTestEtcObj JobTestEtcObj);
	
	/**
	 * @Method Name : insert_job_itv_tp_etc
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 면접방식(기타) 객체 
	 * @Return : -
	 * @Method 설명 : 면접방식(기타) 정보 저장
	 */
	public void insert_job_itv_tp_etc(SocietyFapJobItvTpEtc JobItvTpEtc);
	
	/**
	 * @Method Name : insert_job_itv_obj_etc
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 면접대상자(기타) 객체 
	 * @Return : -
	 * @Method 설명 : 면접대상자(기타) 정보 저장
	 */
	public void insert_job_itv_obj_etc(SocietyFapJobItvObjEtc JobItvObjEtc);
	
	/**
	 * 
	 * @Method Name : insert_job_pay
	 * @Date : 2019. 1. 22.
	 * @User : 원병호
	 * @Param : 급여 객체
	 * @Return : 
	 * @Method 설명 : 급여 정보 저장
	 */
	public void insert_job_pay(List<SocietyFapJobPay> JobPay);
	
	/**
	 * 
	 * @Method Name : insert_job_pay_base
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 
	 * @Return : 
	 * @Method 설명 :기본급 객체 정보 등록
	 */
	public void insert_job_pay_base(List<SocietyFapJobPayBase> JobPayBase);
			
	/**
	 * 		
	 * @Method Name : insert_job_pay_extra
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 잔업수당 객체 정보 등록
	 */
	public void insert_job_pay_extra(SocietyFapJobPayExtra JobPayExtra);
			
	/**
	 * 
	 * @Method Name : insert_job_service_work
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 서비스잔업수당 객체 정보 등록
	 */
	public void insert_job_service_work(SocietyFapJobServiceWork JobServiceWork);
			
	/**
	 * 
	 * @Method Name : insert_job_service_work
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 기타수당 객체 정보 등록
	 */
	public void insert_job_pay_etc(List<SocietyFapJobPayEtc> JobPayEtc);		
			
	/**
	 * @Method Name : insert_job_exam
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 채용공고 시험전형 객체 
	 * @Return : -
	 * @Method 설명 : 시험전형 정보 저장
	 */
	public void insert_job_exam(SocietyFapJobExam JobExam);
	
	/**
	 * @Method Name : insert_job_exam_obj_etc
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 시험대상자(기타) 객체 
	 * @Return : -
	 * @Method 설명 : 시험대상자(기타) 정보 저장
	 */
	public void insert_job_exam_obj_etc(SocietyFapJobExamObjEtc JobExamObjEtc);
	
	/**
	 * @Method Name : insert_job_exam_sv_etc
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 시험감독관(기타) 객체 
	 * @Return : -
	 * @Method 설명 : 시험감독관(기타) 정보 저장
	 */
	public void insert_job_exam_sv_etc(SocietyFapJobExamSvEtc JobExamSvEtc);
	
	/**
	 * @Method Name : insert_job_exam_need_etc
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 시험준비물(기타) 객체 
	 * @Return : -
	 * @Method 설명 : 시험준비물(기타) 정보 저장
	 */
	public void insert_job_exam_need_etc(SocietyFapJobExamNeedEtc JobExamNeedEtc);
	
	/**
	 * @Method Name : insert_job_exam_file
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 시험 파일 객체
	 * @Return : -
	 * @Method 설명 : 시험 파일을 저장하는 함수
	 */
	public void insert_job_exam_file(SocietyFapJobExamFile JobExamFile);
	
	/**
	 * @Method Name : insert_job_exam_type
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 시험종류 객체 
	 * @Return : -
	 * @Method 설명 : 시험종류 정보 저장
	 */
	public void insert_job_exam_type(List<SocietyFapJobExamType> jobExamTypeList);
	
	/**
	 * @Method Name : select_job_pay
	 * @Date : 2019. 1. 22.
	 * @User : 원병호
	 * @Param : fap_job_ad_seq
	 * @Return : 급여 관련 모든 정보를 담은 map
	 * @Method 설명 : 급여 관련 모든 정보를 가져옵니다.
	 */
	public HashMap<String, Object> select_job_pay(long fap_job_ad_seq);
	
	/**
	 * @Method Name : select_job_ideal_person
	 * @Date : 2019. 1. 22.
	 * @User : 김준영
	 * @Param : 채용공고 정보 seq
	 * @Return : 채용공고 정보, 주요 업무 정보, 업무에 필요한 능력, 우대사항 
	 * @Method 설명 : 채용공고 정보, 주요 업무, 인재상, 기술상세를 가져오는 함수
	 */
	public HashMap<String, Object> select_job_ideal_person(long fap_job_ad_seq);
	
	/**
	 * @Method Name : select_job_ad
	 * @Date : 2019. 1. 22.
	 * @User : 김준영
	 * @Param : 채용공고 정보 seq
	 * @Return : 채용공고 정보
	 * @Method 설명 : 기본 채용공고 정보를 가져오는 함수
	 */
	public SocietyFapJobAd select_job_ad(Long fap_job_ad_seq);
	
	/**
	 * @Method Name : select_job_recruit_pcs
	 * @Date : 2019. 1. 22.
	 * @User : 김준영
	 * @Param : 채용공고 정보 seq
	 * @Return : 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일
	 * @Method 설명 : 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_job_recruit_pcs(Long fap_job_ad_seq);
	
	/**
	 * @Method Name : select_job_category
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : fap_job_ad_seq
	 * @Return : 모집직종 관련 모든 정보를 담은 map
	 * @Method 설명 : 모집직종 관련 모든 정보를 가져옵니다.
	 */
	public HashMap<String, Object> select_job_category(long fap_job_ad_seq);
	
	/**
	 * @Method Name : select_fap_comp_id
	 * @Date : 2019. 1. 23.
	 * @User : 이재준
	 * @Param : 회원 아이디
	 * @Return : 회사 아이디
	 * @Method 설명 : 회사 아이디 발급 여부 검색
	 */
	public String select_fap_comp_id(String user_id);
	
	/**
	 * @Method Name : update_job_ad
	 * @Date : 2019. 1. 23.
	 * @User : 이재준
	 * @Param : 채용공고정보 객체
	 * @Return : 
	 * @Method 설명 : 채용공고정보 수정
	 */
	public void update_job_ad(SocietyFapJobAd jobAd);
	
	/**
	 * @Method Name : select_pcs_seq_list
	 * @Date : 2019. 1. 23.
	 * @User : 김준영
	 * @Param : 채용공고 seq
	 * @Return : 채용전형 seq list
	 * @Method 설명 : 채용공고에 해당하는 채용전형 seq list를 가져오는 함수
	 */
	public ArrayList<Long> select_pcs_seq_list(Long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_recruit_pcs_selective
	 * @Date : 2019. 1. 23.
	 * @User : 김준영
	 * @Param : 채용공고 seq, 채용전형 seq
	 * @Return : -
	 * @Method 설명 : 수정에서 지운 채용전형을 지워주는 함수
	 */
	public void delete_job_recruit_pcs_selective(HashMap<String, Object> hashMap);
	
	/**
	 * @Method Name : delete_job_exam
	 * @Date : 2019. 1. 23.
	 * @User : 김준영
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 수정에서 지운 채용전형을 지워주는 함수
	 */
	public void delete_job_exam(long fap_job_recruit_pcs_seq);
	
	/**
	 * @Method Name : delete_job_itv
	 * @Date : 2019. 1. 23.
	 * @User : 김준영
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 
	 */
	public void delete_job_itv(long fap_job_recruit_pcs_seq);
	
	/**
	 * @Method Name : delete_job_test_etc
	 * @Date : 2019. 1. 23.
	 * @User : 김준영
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 
	 */
	public void delete_job_test_etc(long fap_job_recruit_pcs_seq);
	
	/**
	 * @Method Name : update_job_recruit_pcs
	 * @Date : 2019. 1. 23.
	 * @User : 김준영
	 * @Param : 채용전형 객체
	 * @Return : -
	 * @Method 설명 : 채용전형 수정
	 */
	public void update_job_recruit_pcs(SocietyFapJobRecruitPcs jobRecruitPcs);
	
	/**
	 * @Method Name : delete_job_dorm
	 * @Date : 2019.01.23.
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 기숙사 정보 삭제
	 */
	public void delete_job_dorm(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_jit_employee
	 * @Date : 2019.01.23.
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 계약사원 정보 삭제
	 */
	public void delete_job_jit_employee(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_ja_level
	 * @Date : 2019.01.23.
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 업무에 필요한 일본어 정보 삭제
	 */
	public void delete_job_ja_level(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_pref
	 * @Date : 2019.01.23.
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 우대사항 정보 삭제
	 */
	public void delete_job_pref(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_join_dt
	 * @Date : 2019.01.23.
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 입사예정일 정보 삭제
	 */
	public void delete_job_join_dt(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_trial
	 * @Date : 2019.01.23.
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 시용기간 정보 삭제
	 */
	public void delete_job_trial(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_isr
	 * @Date : 2019.01.23.
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 보험정보 삭제
	 */
	public void delete_job_isr(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_pay
	 * @Date : 2019.01.23.
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 급여정보 삭제
	 */
	public void delete_job_pay(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_work
	 * @Date : 2019.01.23.
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 주요업무 정보 삭제
	 */
	public void delete_job_work(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_file
	 * @Date : 2019.01.23.
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 파일 정보 삭제
	 */
	public void delete_job_file(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_category
	 * @Date : 2019.01.23.
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 모집직종 정보 삭제
	 */
	public void delete_job_category(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_workplace
	 * @Date : 2019.01.23.
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 근무예정지 정보 삭제
	 */
	public void delete_job_workplace(long fap_job_ad_seq);
	
	/**
	 * @Method Name : delete_job_comp
	 * @Date : 2019.01.23.
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 회사명 정보 삭제
	 */
	public void delete_job_comp(long fap_job_ad_seq);
	
	/**
	 * @Method Name : editable_check
	 * @Date : 2019. 1. 24.
	 * @User : 김준영
	 * @Param : 채용전형 seq
	 * @Return : 전형별지원결과정보 seq list
	 * @Method 설명 : 채용전형의 수정 가능 여부를 확인 하는 함수
	 */
	public int editable_check(long fap_job_recruit_pcs_seq);
	
	
	public ArrayList<HashMap<String, Object>> select_agency_management_company_list();
	
	/**
	 * @Method Name : select_agency_comp
	 * @Date : 2019. 1. 25.
	 * @User : 이재준
	 * @Param : 에이전시 소속기업 아이디
	 * @Return : 기업 객체
	 * @Method 설명 : 에이전시 소속기업 객체를 가져오는 함수
	 */
	public SocietyFapCompanyUser select_agency_comp(String fap_comp_id);
	
	/**
	 * @Method Name : select_job_ad_by_state
	 * @Date : 2019. 2. 7.
	 * @User : 정대영
	 * @Param : hashmap (fap_comp_id, jobfair_seq, jobfair_divide_seq)
	 * @Return : 
	 * @Method 설명 : 분류된 채용공고 정보 가져오는 함수
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
	 * @Method Name : select_participate_possible_company_list
	 * @Date : 2019. 2. 7.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMapList
	 * @Method 설명 : FAP 에이전시 에이전시 관리 회사들 목록 요청
	 */
	public ArrayList<HashMap<String, Object>> select_participate_possible_company_list(HashMap<String, Object> parma);
	
	/**
	 * @Method Name : insert_company_jobfair_join_table
	 * @Date : 2019. 2. 8.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : int
	 * @Method 설명 : FAP 에이전시 에이전시 관리 회사 잡페어 참가 요청
	 */
	public int insert_company_jobfair_join_table(HashMap<String, Object> insertCompanyInfo);
	
	/**
	 * @Method Name : select_jobfair_attended_company_list
	 * @Date : 2019. 2. 8.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMapList
	 * @Method 설명 : FAP 에이전시 해당 잡페어에 참가할 회사목록 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_jobfair_attended_company_list(HashMap<String, Object> param);
	
	/**
	 * @Method Name : select_company_of_parameter_comp_id
	 * @Date : 2019. 2. 8.
	 * @User : 정대영
	 * @Param : 선택된 회사 아이디
	 * @Return : 기업 객체
	 * @Method 설명 : 에이전시 담당자 가지고 있는 기업 객체를 가져오는 함수(파라미터 선택된 회사 아이디로)
	 */
	public SocietyFapCompanyUser select_company_of_parameter_comp_id(String chosen_fap_comp_id);
	
	/**
	 * @Method Name : select_company_name
	 * @Date : 2019. 2. 11.
	 * @User : 정대영
	 * @Param : String
	 * @Return : String
	 * @Method 설명 : FAP 에이전시 회사아이디로 회사명 요청
	 */
	public String select_company_name(String chosen_fap_comp_id);
	
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
	 * @Method Name : select_job_ad_load_list_paging
	 * @Date : 2019. 2. 12.
	 * @User : 김준영
	 * @Param : 기업 아이디
	 * @Return : 채용공고
	 * @Method 설명 : 기업이 작성한 모든 채용공고를 불러오는 함수(페이징 처리 후) 
	 */
	public ArrayList<HashMap<String, Object>> select_job_ad_load_list_paging(HashMap<String, Object> paramMap, RowBounds rb);
	
	/**
	 * @Method Name : select_job_ad_load_list_count
	 * @Date : 2019. 2. 12.
	 * @User : 김준영
	 * @Param : 기업 아이디
	 * @Return : 채용공고 개수
	 * @Method 설명 : 기업이 작성한 모든 채용공고 총 개수를 불러오는 함수 
	 */
	public int select_job_ad_load_list_count(HashMap<String, Object> paramMap);
	
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
	 * @Method Name : select_job_exam_file
	 * @Date : 2019. 2. 19.
	 * @User : 원병호
	 * @Param : 채용공고 시퀀스
	 * @Return : 시험전형 파일 리스트
	 * @Method 설명 : 해당 채용공고의 시험전형 파일 리스트 검색
	 */
	public ArrayList<SocietyFapJobExamFile> select_job_exam_file(long fap_job_ad_seq);
	
	/**
	 * @Method Name : select_agency_jobfair_list
	 * @Date : 2019. 3. 12
	 * @User : 원병호
	 * @Param : 회사 아이디
	 * @Return : 
	 * @Method 설명 : 해당 회사가 참가한 잡페어 리스트
	 */
	public ArrayList<HashMap<String, Object>> select_agency_jobfair_list(String fap_comp_id);
	
	/**
	 * @Method Name : search_company_jobfair_divide_list
	 * @Date : 2019. 3. 12
	 * @User : 원병호
	 * @Param : map(회사 아이디, 잡페어 일련번호)
	 * @Return : 
	 * @Method 설명 : 해당 회사가 참가한 잡페어 세부 리스트
	 */
	public ArrayList<HashMap<String, Object>> select_company_jobfair_divide_list(HashMap<String, Object> params);
	
}
