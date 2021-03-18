/**
 * 
 */
package global.segroup.society.fap.admincompany.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairApplyRule;
import global.segroup.society.fap.company.domain.SocietyFapJobAd;
import global.segroup.society.fap.company.domain.SocietyFapJobCategory;
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

/**
 * @Author : 이재준
 * @Date : 2018. 12. 20.
 * @Class 설명 : Soft Engineer Society 통합잡페어 관리자(기업기능담당) Mapper
 * 
 */
public interface SocietyFapAdminCompanyMapper {
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
	public void insert_job_category(SocietyFapJobCategory JobCategory);

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
	 * @Method Name : insert_job_recruitpcs
	 * @Date : 2019. 1. 7.
	 * @User : 이재준
	 * @Param : 채용공고 채용전형 객체
	 * @Return : -
	 * @Method 설명 : 채용전형 정보 저장
	 */
	public void insert_job_recruitpcs(SocietyFapJobRecruitPcs JobRecruitPcs);

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
	public ArrayList<HashMap<String, Object>> select_job_pay(int fap_job_ad_seq);

	/**
	 * @Method Name : select_job_ad_list
	 * @Date : 2019. 1. 10.
	 * @User : 이재준
	 * @Param : fap_job_id
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

	/**
	 * @Method Name : admin_select_per_state_job_ad_list
	 * @Date : 2019. 2. 12.
	 * @User : 정대영
	 * @Param : 잡페어 시퀀스, 잡페어세부 시퀀스
	 * @Return : HashMapList(회사별 진행중인 잡페어 리스트)
	 * @Method 설명 : FAP 관리자 채용공고 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> admin_select_per_state_job_ad_list(HashMap<String, Object> parmas);

	/**
	 * @Method Name : admin_update_job_ad_state
	 * @Date : 2019. 2. 12.
	 * @User : 정대영
	 * @Param : SocietyFapJobAd
	 * @Return : -
	 * @Method 설명 : FAP 관리자 채용공고 상태를 수정하는 함수
	 */
	public void admin_update_job_ad_state(SocietyFapJobAd jobAd);

	/**
	 * @Method Name : select_current_jobfair_group_code
	 * @Date : 2019. 2. 12.
	 * @User : 정대영
	 * @Param : Int(잡페어 시퀀스)
	 * @Return : HashMap
	 * @Method 설명 : FAP 관리자 해당 잡페어 그룹코드 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_current_jobfair_group_code(int fap_jobfair_seq);

	/**
	 * @Method Name : select_current_job_ad_info_for_group_code
	 * @Date : 2019. 2. 12.
	 * @User : 정대영
	 * @Param : Int(잡페어 시퀀스)
	 * @Return : HashMap
	 * @Method 설명 : FAP 관리자 해당 채용공고 그룹코드에 필요한 정보 셀렉트
	 */
	public HashMap<String, Object> select_current_job_ad_info_for_group_code(long fap_job_ad_seq);

	/**
	 * @Method Name : admin_insert_apply_nums_per_ad
	 * @Date : 2019. 2. 12.
	 * @User : 정대영
	 * @Param : SocietyFapJobAd
	 * @Return : -
	 * @Method 설명 : FAP 관리자 채용공고 채용예정인원으로 채용가능인원 인서트
	 */
	public void admin_insert_apply_nums_per_ad(SocietyFapJobAd jobAd);

	/**
	 * @Method Name : admin_insert_itv_nums_per_ad
	 * @Date : 2019. 7. 31.
	 * @User : 이종호
	 * @Param : 채용공고 정보
	 * @Return : -
	 * @Method 설명 : FAP 관리자 채용공고 채용예정인원으로 현지면접인원 등록
	 */
	public void admin_insert_itv_nums_per_ad(SocietyFapJobAd jobAd);

	/**
	 * @Method Name : admin_select_flag_apply_nums_per_ad
	 * @Date : 2019. 2. 12.
	 * @User : 정대영
	 * @Param : long
	 * @Return : Int
	 * @Method 설명 : FAP 관리자 지원가능인원이 설정되어있는지 여부 확인
	 */
	public int admin_select_flag_apply_nums_per_ad(long fap_job_ad_seq);

	/**
	 * @Method Name : admin_select_flag_itv_nums_per_ad
	 * @Date : 2019. 7. 31.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 검색 갯수
	 * @Method 설명 : FAP 관리자 현지면접인원이 설정되어 있는지 여부 확인
	 */
	public int admin_select_flag_itv_nums_per_ad(long fap_job_ad_seq);

	/**
	 * @Method Name : change_groupcode
	 * @Date : 2019.02.26
	 * @User : 남유송
	 * @Param : Hashmap
	 * @Return : -
	 * @Method 설명 : 그룹코드 업데이트
	 */
	public void admin_update_groupcode(HashMap<String, Object> params);

	/**
	 * @Method Name : select_count_per_group
	 * @Date : 2019.02.26
	 * @User : 남유송
	 * @Param : int
	 * @Return : ArrayList
	 * @Method 설명 : 각 기업그룹코드 별 갯수
	 */
	public ArrayList<HashMap<String, Object>> select_count_per_group(int fap_jobfair_divide_seq);

	/**
	 * @Method Name : update_rank
	 * @Date : 2021.03.09
	 * @User : 안홍현
	 * @Param : Hashmap
	 * @Return : -
	 * @Method 설명 : 순위 변경
	 */
	public int admin_update_rank(HashMap<String, Object> params);
	
	/**
	 * @Method Name : admin_select_rank
	 * @Date : 2021.03.10
	 * @User : 안홍현
	 * @Param : Hashmap
	 * @Return : fap_job_ad_seq
	 * @Method 설명 : fap_job_ad_rank와 fap_jobfair_divide_seq로 일치하는 fap_job_ad_seq를 검색
	 */
	public ArrayList<String> admin_select_rank(HashMap<String, Object> param);
	
	/**
	 * @Method Name : admin_delete_rank
	 * @Date : 2021.03.10
	 * @User : 안홍현
	 * @Param : Hashmap
	 * @Return : -
	 * @Method 설명 : fap_job_ad_rank와 fap_jobfair_divide_seq로 해당하는 데이터의 fap_job_ad_rank를 null로 변환
	 */
	public int admin_delete_rank(HashMap<String, Object> params);

	/**
	 * @Method Name : admin_job_app_per_update
	 * @Date : 2019. 2. 27.
	 * @User : 이종호
	 * @Param : 지원가능인원 시퀀스 , 지원가능 인원 수
	 * @Return : -
	 * @Method 설명 : FAP 관리자 채용공고 지원가능인원 수정
	 */
	public void admin_job_app_per_update(HashMap<String, Object> parmas);

	/**
	 * @Method Name : admin_job_itv_per_update
	 * @Date : 2019. 7. 31.
	 * @User : 이종호
	 * @Param : 현지제한인원 시퀀스 , 인원수
	 * @Return : -
	 * @Method 설명 : FAP 관리자 채용공고 현지제한인원 수정
	 */
	public void admin_job_itv_per_update(HashMap<String, Object> params);

	/**
	 * @Method Name : admin_update_mismatching
	 * @Date : 2019. 2. 27.
	 * @User : 이재준
	 * @Param :
	 * @Return : -
	 * @Method 설명 : FAP 관리자 미스매칭/일반지원 수정
	 */
	public void admin_update_mismatching(HashMap<String, Object> params);

	/**
	 * @Method Name : admin_job_apply_approval_yet
	 * @Date : 2019. 4. 26.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스, 회사 아이디
	 * @Return : FAP 관리자 기업별 지원자 리스트 승인전 지원자 리스트
	 * @Method 설명 : FAP 관리자 기업별 지원자 리스트 승인전 지원자 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> admin_job_apply_approval_yet(HashMap<String, Object> params);

	/**
	 * @Method Name : select_jobfair_apply_rule_count
	 * @Date : 2019. 8. 7.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 지원룰 시퀀스 갯수
	 * @Method 설명 : 채용공고 승인 시 지원룰 대상 등록여부 확인
	 */
	public int select_jobfair_apply_rule_count(long fap_job_ad_seq);

	/**
	 * @Method Name : delete_jobfair_apply_rule
	 * @Date : 2019. 8. 20.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : -
	 * @Method 설명 : 채용공고 승인 취소시 지원룰 대상 삭제
	 */
	public void delete_jobfair_apply_rule(long fap_job_ad_seq);

	/**
	 * @Method Name : select_jobfair_applicable_time
	 * @Date : 2019. 8. 7.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 지원가능시간 시퀀스
	 * @Method 설명 : 세부잡페어별 진행중인 지원가능시간 시퀀스 조회
	 */
	public Long select_jobfair_applicable_time(long fap_job_ad_seq);

	/**
	 * @Method Name : insert_jobfair_apply_rule
	 * @Date : 2019. 8. 7.
	 * @User : 이종호
	 * @Param : 지원룰 정보
	 * @Return : -
	 * @Method 설명 : 지원룰 정보 등록
	 */
	public void insert_jobfair_apply_rule(SocietyFapAdminJobfairApplyRule rule);

	/**
	 * @Method Name : select_user_nm
	 * @Date : 2019. 9. 3.
	 * @User : 김경아
	 * @Param :
	 * @Return :
	 * @Method 설명 : id에 따른 이름 출력
	 */
	public HashMap<String, Object> select_comp_nm(String fap_comp_id);
}
