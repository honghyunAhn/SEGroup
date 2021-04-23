/**
 * 
 */
package global.segroup.society.fap.user.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;

import org.apache.ibatis.session.RowBounds;

import global.segroup.domain.BoardContent;
import global.segroup.domain.User;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminFinalDecisionTime;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenPt;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenPtApply;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenPtResume;
import global.segroup.society.fap.admincommon.domain.SocietyFapPopup;
import global.segroup.society.fap.company.domain.SocietyFapPersonalRequiredDoc;
import global.segroup.society.fap.user.domain.SocietyFapPersonalGraduate;
import global.segroup.society.fap.user.domain.SocietyFapPersonalHighschool;
import global.segroup.society.fap.user.domain.SocietyFapPersonalUniversity;
import global.segroup.society.fap.user.domain.SocietyFapPersonalUser;
import global.segroup.society.fap.user.domain.SocietyFapQnaQuestion;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeAddr;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeCareer;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeEduhistory;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeFile;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeForm;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeLicense;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeName;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeProfile;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeProject;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeTalent;

/**
 * @Author : 신동철
 * @Date : 2018. 11. 29.
 * @Class 설명 : Soft Engineer Society 통합잡페어 지원자 매퍼
 * 
 */
public interface SocietyFapUserMapper {

	/**
	 * @Method Name : user_id_check
	 * @Date : 2018. 12. 12.
	 * @User : 김준영
	 * @Param : 유저가 입력한 아이디
	 * @Return : 일치하는 아이디 or null
	 * @Method 설명 : 유저가 입력한 아이디가 중복되는지 확인하는 함수
	 */
	public String user_id_check(String user_id);
	
	/**
	 * @Method Name : insert_com_user
	 * @Date : 2018. 12. 12.
	 * @User : 김준영
	 * @Param : 유저 객체
	 * @Return : -
	 * @Method 설명 : 유저 공통 정보를 등록을 하는 함수 
	 */
	public void insert_com_user(User user);
	
	/**
	 * @Method Name : select_com_user
	 * @Date : 2019. 2. 27.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 유저 객체
	 * @Method 설명 : 특정 유저의 정보를 가져오는 함수
	 */
	public User select_com_user(String user_id);
	
	/**
	 * @Method Name : insertResumeBasic
	 * @Date : 2018. 12. 12.
	 * @User : 남유송
	 * @Param : 이력서 전체 객체
	 * @Return : -
	 * @Method 설명 : FAP 이력서 기본정보 저장
	 */
	public void insert_resume_basic(SocietyFapUserResumeForm resumeForm);

	/**
	 * @Method Name : insertResumeEduHistory
	 * @Date : 2018. 12. 13.
	 * @User : 남유송
	 * @Param :  FAP 학력/관련 교육이수 정보 
	 * @Return : -
	 * @Method 설명 : FAP 학력/관련 교육이수 정보 저장
	 */
	public void insert_resume_eduHistory(SocietyFapUserResumeEduhistory resumeEduhistory);
	
	/**
	 * @Method Name : insert_personal_user
	 * @Date : 2018. 12. 14.
	 * @User : 김준영
	 * @Param : 개인 회원 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원을 등록을 하는 함수
	 */
	public void insert_personal_user(SocietyFapPersonalUser societyFapPersonalUser);
	
	/**
	 * @Method Name : insert_personal_hs
	 * @Date : 2018. 12. 14.
	 * @User : 김준영
	 * @Param : 개인 회원 고등학교 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원의 고등학교를 등록 하는 함수
	 */
	public void insert_personal_hs(SocietyFapPersonalHighschool societyFapPersonalHighschool);
	
	/**
	 * @Method Name : insert_personal_univ
	 * @Date : 2018. 12. 14.
	 * @User : 김준영
	 * @Param : 개인 회원 대학교 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원의 대학교을 등록 하는 함수 
	 */
	public void insert_personal_univ(SocietyFapPersonalUniversity societyFapPersonalUniversity);
	
	/**
	 * @Method Name : insert_personal_grad
	 * @Date : 2018. 12. 14.
	 * @User : 김준영
	 * @Param : 개인 회원 대학원 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원의 대학원을 등록 하는 함수
	 */
	public void insert_personal_grad(SocietyFapPersonalGraduate societyFapPersonalGraduate);
	
	/**
	 * @Method Name : select_personal_user
	 * @Date : 2018. 12. 14.
	 * @User : Administrator
	 * @Param : -
	 * @Return : 개인 유저 객체
	 * @Method 설명 : 개인 유저 객체를 불러오는 함수
	 */
	public SocietyFapPersonalUser select_personal_user(String user_id);
	
	/**
	 * @Method Name : select_personal_school
	 * @Date : 2018. 12. 14.
	 * @User : Administrator
	 * @Param : 개인 유저 객체
	 * @Return : 개인 유저의 학교 정보 hashMap
	 * @Method 설명 : 개인 유저가 가지고 있는 학교 정보를 불러오는 함수
	 */
	public HashMap<String, Object> select_personal_school(SocietyFapPersonalUser societyFapPersonalUser);
	
	/**
	 * @Method Name : insertResumeEduHistory
	 * @Date : 2018. 12. 14.
	 * @User : 남유송
	 * @Param : 이력서 자격증 객체
	 * @Return : -
	 * @Method 설명 : FAP 이력서 자격증  정보 저장
	 */
	public void insert_resume_license(SocietyFapUserResumeLicense resumeLicense);
	
	/**
	 * @Method Name : insertResumeCareer
	 * @Date : 2018. 12. 14.
	 * @User : 남유송
	 * @Param : 이력서 사회경력 객체
	 * @Return : -
	 * @Method 설명 : FAP 이력서 사회경력  정보 저장
	 */
	public void insert_resume_career(SocietyFapUserResumeCareer resumeCareer);
	
	/**
	 * @Method Name : insertResumeProject
	 * @Date : 2018. 12. 14.
	 * @User : 남유송
	 * @Param : 이력서 프로젝트 객체
	 * @Return : -
	 * @Method 설명 : FAP 이력서 프로젝트  정보 저장
	 */
	public void insert_resume_project(SocietyFapUserResumeProject resumeProject);
	
	/**
	 * @Method Name : insertResumeTalent
	 * @Date : 2018. 12. 14.
	 * @User : 남유송
	 * @Param : 이력서 역량/재능 객체
	 * @Return : -
	 * @Method 설명 : FAP 이력서 역량/재능  정보 저장
	 */
	public void insert_resume_talent(SocietyFapUserResumeTalent resumeTalent);
	
	/**
	 * @Method Name : select_fap_user_jobfair_info_list
	 * @Date : 2018. 12. 6.
	 * @User : 정대영
	 * @Param : -
	 * @Return : hashmapList
	 * @Method 설명 : 통합잡페어정보 리스트
	 */
	public ArrayList<HashMap<String, Object>> select_fap_user_jobfair_info_list();
	
	/**
	 * @Method Name : select_fap_user_jobfair_location_list
	 * @Date : 2018. 12. 6.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMapList
	 * @Method 설명 : 통합잡페어 개최지 리스트
	 */
	public ArrayList<HashMap<String, Object>> select_fap_user_jobfair_location_list(HashMap<String, Object> params);
	
	/**
	 * @Method Name : user_jobfair_entry_request
	 * @Date : 2018. 12. 10.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : -
	 * @Method 설명 : FAP 취업지원자 잡페어 신청
	 */
	public int user_jobfair_entry_request(HashMap<String, Object> map);
	
	/**
	 * @Method Name : select_jobfair_job_advertisement_list
	 * @Date : 2018. 12. 14.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 채용공고 리스트 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_jobfair_job_advertisement_list(HashMap<String, Object> params , RowBounds rw);
	
	/**
	 * @Method Name : select_category_and_workplace_list
	 * @Date : 2019. 2. 26.
	 * @User : 정대영
	 * @Param : Long
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 채용공고 시퀀스 별 모집직종, 근무지 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_category_and_workplace_list(ArrayList<Long> curJobAdSeqList);
	
	/**
	 * @Method Name : select_jobfair_job_advertisement_list_count
	 * @Date : 2019. 2. 25.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 채용공고 리스트 총 개수 셀렉트
	 */
	public int select_jobfair_job_advertisement_list_count(HashMap<String, Object> paramMap);
	
	/**
	 * @Method Name : select_company_group_code_list
	 * @Date : 2019. 1. 14.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMap
	 * @Method 설명 : FAP 취업지원자 잡페어별 그룹코드 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_company_group_code_list(HashMap<String, Object> fapJobAdvertisement);
	
	/**
	 * @Method Name : select_jobfair_job_advertisement
	 * @Date : 2018. 12. 13.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMap
	 * @Method 설명 : FAP 취업지원자 채용공고 셀렉트(채용공고 읽기)
	 */
	public HashMap<String, Object> select_jobfair_job_advertisement(HashMap<String, Object> fapJobAdvertisement);
	
	/**
	 * @Method Name : insert_my_favorite_company
	 * @Date : 2018. 12. 14.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 내가담은기업 인서트
	 */
	public int insert_my_favorite_company(HashMap<String, Object> fapMyFavoriteCompany);
	
	/**
	 * @Method Name : my_favorite_company_check
	 * @Date : 2018. 12. 14.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 취업지원자 내가담은기업 중복체크
	 */
	public String my_favorite_company_check(HashMap<String, Object> fapMyFavoriteCompany);
	
	/**
	 * @Method Name : select_my_favorite_company_list
	 * @Date : 2018. 12. 14.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 내가담은기업 리스트 출력
	 */
	public ArrayList<HashMap<String, Object>> select_my_favorite_company_list(HashMap<String, Object> params);

	/**
	 * @Method Name : insert_resume_profile
	 * @Date : 2018. 12. 16.
	 * @User : 남유송
	 * @Param : 이력서 PR 객체 
	 * @Return : -
	 * @Method 설명 : FAP 이력서 PR 정보 저장
	 */
	public void insert_resume_profile(SocietyFapUserResumeProfile resumeProfile);

	/**
	 * @Method Name : insert_resume_addr
	 * @Date : 2018. 12. 16.
	 * @User : 남유송
	 * @Param : 이력서 주소 객체
	 * @Return : -
	 * @Method 설명 : FAP 이력서 주소 정보 저장
	 */
	public void insert_resume_addr(SocietyFapUserResumeAddr resumeAddr);

	/**
	 * @Method Name : insert_resume_name
	 * @Date : 2018. 12. 16.
	 * @User : 남유송
	 * @Param : 이력서 이름 객체
	 * @Return : -
	 * @Method 설명 : FAP 이름 정보 저장 
	 */
	public void insert_resume_name(SocietyFapUserResumeName resumeName);

	/**
	 * @Method Name : insert_resume_file
	 * @Date : 2018. 12. 16.
	 * @User : 남유송
	 * @Param : 이력서 파일 객체 
	 * @Return : -
	 * @Method 설명 : FAP 파일 정보 저장
	 */
	public void insert_resume_file(SocietyFapUserResumeFile resumeFile);

	/**
	 * @Method Name : update_com_user
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 공통 회원 객체
	 * @Return : -
	 * @Method 설명 : 공통 회원 정보를 수정
	 */
	public void update_com_user(User user);
	
	/**
	 * @Method Name : update_personal_user
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 개인 회원 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원 정보를 수정
	 */
	public void update_personal_user(SocietyFapPersonalUser societyFapPersonalUser);
	
	/**
	 * @Method Name : update_user_hs
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 개인 회원의 고등학교 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원의 고등학교 정보를 수정
	 */
	public void update_user_hs(SocietyFapPersonalHighschool societyFapPersonalHighschool);
	
	/**
	 * @Method Name : update_user_univ
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 개인 회원의 대학교 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원의 대학교 정보를 수정
	 */
	public void update_user_univ(SocietyFapPersonalUniversity societyFapPersonalUniversity);
	
	/**
	 * @Method Name : update_user_grad
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 개인 회원의 대학원 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원의 대학원 정보를 수정
	 */
	public void update_user_grad(SocietyFapPersonalGraduate societyFapPersonalGraduate);
	
	/**
	 * @Method Name : delete_user_hs
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 개인 회원 seq
	 * @Return : -
	 * @Method 설명 : 개인 회원의 고등학교 삭제
	 */
	public void delete_user_hs(int fap_personal_user_seq);
	
	/**
	 * @Method Name : delete_user_univ
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 개인 회원 seq
	 * @Return : -
	 * @Method 설명 : 개인 회원의 대학교 삭제
	 */
	public void delete_user_univ(int fap_personal_user_seq);
	
	/**
	 * @Method Name : delete_user_grad
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 대학원 seq
	 * @Return : -
	 * @Method 설명 : 개인 회원의 대학원 삭제
	 */
	public void delete_user_grad(int grad_seq);
	
	/**
	 * @Method Name : delete_my_favorite_company
	 * @Date : 2018. 12. 17.
	 * @User : 정대영
	 * @Param : SocietyFapUserMyFavoriteCompany
	 * @Return : Int
	 * @Method 설명 : FAP 내가담은목록에서 기업 삭제
	 */
	public int delete_my_favorite_company_list(HashMap<String, Object> deleteMyFavoriteCompany);

	/**
	 * @Method Name : select_my_resume_list
	 * @Date : 2018. 12. 18.
	 * @User : 남유송
	 * @Param : user_id
	 * @Return : 이력서 기본 정보 객체
	 * @Method 설명 : 이력서 관리에서 기본정보 출력
	 */
	public ArrayList<HashMap<String, Object>> select_my_resume_list(String user_id);
	
	/**
	 * @Method Name : select_my_resume_available_list
	 * @Date : 2019. 4. 4.
	 * @User : 이종호
	 * @Param : user_id,jobfair_seq
	 * @Return : 지원가능한 이력서 기본 정보 객체 리스트
	 * @Method 설명 : 지원페이지에서 이력서 리스트 출력
	 */
	public ArrayList<HashMap<String, Object>> select_my_resume_available_list(HashMap<String, Object> paramMap);

	/**
	 * @Method Name : search_job_advertisement_list
	 * @Date : 2018. 12. 20.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : SocietyFapUserJobAdvertisementList
	 * @Method 설명 : FAP 채용공고 상세검색
	 */
	public ArrayList<HashMap<String, Object>> search_job_advertisement_list(HashMap<String, Object> selectedCompanyInfoMap);

	/**
	 * @Method Name : selectResumeApplyBasic
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (기본정보)
	 */
	public HashMap<String, Object> selectResumeApplyBasic(HashMap<String, Object> param);
	
	/**
	 * @Method Name : selectResumeApplyEduhistory
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (학력정보)
	 */
	public ArrayList<HashMap<String, Object>> selectResumeApplyEduhistory(HashMap<String, Object> param);
	
	/**
	 * @Method Name : selectResumeApplyLicense
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (자격증정보)
	 */
	public ArrayList<HashMap<String, Object>> selectResumeApplyLicense(HashMap<String, Object> param);
	
	/**
	 * @Method Name : selectResumeApplyCareer
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (경력정보)
	 */
	public ArrayList<HashMap<String, Object>> selectResumeApplyCareer(HashMap<String, Object> param);
	
	/**
	 * @Method Name : selectResumeApplyProject
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (프로젝트정보)
	 */
	public ArrayList<HashMap<String, Object>> selectResumeApplyProject(HashMap<String, Object> param);

	/**
	 * @Method Name : selectResumeApplyTalent
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (역량재능정보)
	 */
	public ArrayList<HashMap<String, Object>> selectResumeApplyTalent(HashMap<String, Object> param);
	
	/**
	 * @Method Name : selectResumeApplyProfile
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (자기소개 정보)
	 */
	public ArrayList<HashMap<String, Object>> selectResumeApplyProfile(HashMap<String, Object> param);
	
	/**
	 * @Method Name : selectResumeApplyAddress
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (주소정보)
	 */
	public ArrayList<HashMap<String, Object>> selectResumeApplyAddress(HashMap<String, Object> param);
	
	/**
	 * @Method Name : selectResumeApplyName
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (이름정보)
	 */
	public ArrayList<HashMap<String, Object>> selectResumeApplyName(HashMap<String, Object> param);
	
	/**
	 * @Method Name : selectResumeApplyFile
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (파일정보)
	 */
	public ArrayList<HashMap<String, Object>> selectResumeApplyFile(HashMap<String, Object> param);
	
	/**
	 * @Method Name : selectFapOpened
	 * @Date : 2020. 10. 07.
	 * @User : 양승균
	 * @Param : HashMap
	 * @Return : ArrayList
	 * @Method 설명 : FAP 지원 과정/기수 조회
	 */
	
	public ArrayList<HashMap<String, Object>> selectFapOpened(HashMap<String, Object> param);
	
	/**
	 * @Method Name : selectScoreList
	 * @Date : 2020. 10. 05.
	 * @User : 김성미
	 * @Param : HashMap
	 * @Return : ArrayList
	 * @Method 설명 : FAP 지원자 성적 조회
	 */
	public ArrayList<HashMap<String, Object>> selectScoreList(HashMap<String, Object> param);
	
	/**
	 * @Method Name : company_scale_statistics
	 * @Date : 2018. 12. 24.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMap
	 * @Method 설명 : FAP 채용공고 기업규모별 상세통계
	 */
	public HashMap<String, Object> company_scale_statistics(HashMap<String, Object> jobAdvertisementInfoMap);

	/**
	 * @Method Name : select_files
	 * @Date : 2018. 12. 26.
	 * @User : 남유송
	 * @Param : 이력서 일련번호
	 * @Return : String(이력서 저장 파일 이름)
	 * @Method 설명 : FAP 이력서 저장 파일 이름 리스트
	 */
	public ArrayList<HashMap<String, Object>> select_files(HashMap<String, Object> param);
	
	/**
	 * @Method Name : select_company_name_and_apply_rank
	 * @Date : 2018. 12. 27.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMap
	 * @Method 설명 : FAP 취업지업자 회사명 및 지원가능 지망 셀렉트
	 */
	public HashMap<String, Object> select_company_name_and_apply_count(HashMap<String, Object> advertisementInfoMap);
	
	/**
	 * @Method Name : delete_user_info
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 탈퇴할 회원 객체
	 * @Return : -
	 * @Method 설명 : 회원 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(30글자) 변경후 참조 테이블에 적용
	 */
	public int delete_user_info(HashMap<String, String> updateMap);
	
	/**
	 * @Method Name : select_company_name_and_apply_rank
	 * @Date : 2018. 12. 27.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : IntegerList
	 * @Method 설명 : FAP 취업지업자 회사명 및 지원가능 지망 셀렉트
	 */
	public ArrayList<Integer> select_company_apply_info_rank(HashMap<String, Object> advertisementInfoMap);
	
	/**
	 * @Method Name : select_user_apply_count
	 * @Date : 2018. 12. 28.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지업자 채용공고지원정보 테이블에 해당 유저아이디가 있는지 여부 판별
	 */
	public int select_user_apply_count(HashMap<String, Object> advertisementInfoMap);
	
	/**
	 * @Method Name : select_current_jobfair_count
	 * @Date : 2018. 12. 28.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 잡페어 세부테이블에 설정된 디폴트 지망 개수 셀렉트
	 */
	public int select_current_jobfair_count(HashMap<String, Object> advertisementInfoMap);
	
	/**
	 * @Method Name : select_user_apply_fixed_count
	 * @Date : 2018. 12. 28.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 잡페어별 유저 지망개수 테이블에 지정된 지망 개수 셀렉트
	 */
	public int select_user_apply_fixed_count(HashMap<String, Object> advertisementInfoMap);
	
	/**
	 * @Method Name : apply_insert_this_job_advertisement
	 * @Date : 2018. 12. 31.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 해당 채용공고에 지원하기(최초지원 시)
	 */
	public int apply_insert_this_job_advertisement(HashMap<String, Object> applyJobAdvertisementInfo);
	
	/**
	 * @Method Name : apply_update_this_job_advertisement
	 * @Date : 2018. 12. 31.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 해당 채용공고에 지원하기(추가지원 시)
	 */
	public int apply_update_this_job_advertisement(HashMap<String, Object> applyJobAdvertisementInfo);
	
	/**
	 * @Method Name : apply_second_this_job_advertisement
	 * @Date : 2018. 12. 31.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : -
	 * @Method 설명 : FAP 취업지원자 해당 채용공고에 지원하기 두번째 스탭
	 */
	public void apply_second_this_job_advertisement(HashMap<String, Object> applyJobAdvertisementInfo);
	
	/**
	 * @Method Name : apply_job_advertisement_duplicate_check
	 * @Date : 2018. 12. 31.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 채용공고 중복지원 여부 체크
	 */
	public int apply_job_advertisement_duplicate_check(HashMap<String, Object> applyApplicableCheckInfo);
	
	/**
	 * @Method Name : select_fap_jobfair_applicable_time
	 * @Date : 2019. 1. 3.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 취업지원자 채용공고 지원가능한지 여부를 판단
	 */
	public String select_fap_jobfair_applicable_time(HashMap<String, Object> fapJobAdvertisement);
	
	/**
	 * @Method Name : select_jobfair_apply_rule_gb
	 * @Date : 2019. 8. 9.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 채용공고별 지원룰 적용여부(공통코드)
	 * @Method 설명 : 취업지원자 채용공고 지원 가능 여부 판단
	 */
	public String select_jobfair_apply_rule_gb(HashMap<String, Object> fapJobAdvertisement);
	
	/**
	 * @Method Name : select_fap_jobfair_applicable_is_first
	 * @Date : 2019. 1. 3.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Long
	 * @Method 설명 : FAP 취업지원자 채용공고 지원허가의 최초여부를 판단
	 */
	public long select_fap_jobfair_applicable_is_first(HashMap<String, Object> fapJobAdvertisement);
	
	/**
	 * @Method Name : apply_job_advertisement_quarter_check
	 * @Date : 2019. 1. 4.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 채용공고 지원할 지망개수 보유하고 있는지 여부 판단
	 */
	public int apply_job_advertisement_quarter_check(HashMap<String, Object> applyApplicableCheckInfo);
	
	/**
	 * @Method Name : apply_job_advertisement_time_check
	 * @Date : 2019. 1. 4.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 채용공고 지원할 지망개수 보유하고 있는지 여부 판단
	 */
	public int apply_job_advertisement_time_check(HashMap<String, Object> applyApplicableCheckInfo);

	/**
	 * @Method Name : delete_my_resume
	 * @Date : 2018. 12. 18.
	 * @User : 남유송
	 * @Param : 이력서 일련번호
	 * @Return : -
	 * @Method 설명 : 이력서 정보 삭제 
	 */
	public void delete_my_resume(HashMap<String, Object> param);
	
	/**
	 * @return 
	 * @Method Name : update_resume_form
	 * @Date : 2019.01.07
	 * @User : 남유송
	 * @Param : long(이력서 일련번호)
	 * @Return : SocietyFapUserResumeForm
	 * @Method 설명 : 기본 이력서 정보만 업데이트
	 */
	public long resume_parent_update(SocietyFapUserResumeForm resumeForm);

	/**
	 * @Method Name : delete_resume_eduHistory
	 * @Date : 2019.01.07
	 * @User : 남유송
	 * @Param : 이력서 학력/관련 교육 이수 객체
	 * @Return : -
	 * @Method 설명 : 이력서 학력/관련 교육 이수 정보 삭제
	 */
	public void delete_resume_eduHistory(long fap_resume_seq);

	/**
	 * @Method Name : delete_resume_license
	 * @Date : 2019.01.07
	 * @User : 남유송
	 * @Param : 이력서 자격증 객체
	 * @Return : -
	 * @Method 설명 : 이력서 자격증 정보 삭제
	 */
	public void delete_resume_license(long fap_resume_seq);

	/**
	 * @Method Name : delete_resume_career
	  * @Date : 2019.01.07
	 * @User : 남유송
	 * @Param : 이력서 사회/경력 객체
	 * @Return : -
	 * @Method 설명 : 이력서 사회/경력 정보 삭제
	 */
	public void delete_resume_career(long fap_resume_seq);

	/**
	 * @Method Name : delete_resume_project
	  * @Date : 2019.01.07
	 * @User : 남유송
	 * @Param : 이력서 프로젝트 객체
	 * @Return : -
	 * @Method 설명 : 이력서 프로젝트 정보 삭제
	 */
	public void delete_resume_project(long fap_resume_seq);

	/**
	 * @Method Name : delete_resume_talent
	  * @Date : 2019.01.07
	 * @User : 남유송
	 * @Param : 이력서 재능 객체
	 * @Return : -
	 * @Method 설명 : 이력서 재능 정보 삭제
	 */
	public void delete_resume_talent(long fap_resume_seq);

	/**
	 * @Method Name : delete_resume_profile
	  * @Date : 2019.01.07
	 * @User : 남유송
	 * @Param : 이력서 PR 객체
	 * @Return : -
	 * @Method 설명 : 이력서 PR 정보 삭제
	 */
	public void delete_resume_profile(long fap_resume_seq);

	/**
	 * @Method Name : delete_resume_addr
	 * @Date : 2019.01.07
	 * @User : 남유송
	 * @Param : 이력서 주소 정보 객체
	 * @Return : -
	 * @Method 설명 : 이력서 주소 정보 삭제
	 */
	public void delete_resume_addr(long fap_resume_seq);

	/**
	 * @Method Name : delete_resume_name
	  * @Date : 2019.01.07
	 * @User : 남유송
	 * @Param : 이력서 이름 객체
	 * @Return : -
	 * @Method 설명 : 이력서 이름 정보 삭제
	 */
	public void delete_resume_name(long fap_resume_seq);

	/**
	 * @Method Name : delete_resume_file
	 * @Date : 2019.01.07
	 * @User : 남유송
	 * @Param : 이력서 파일 객체
	 * @Return : -
	 * @Method 설명 : 이력서 파일 정보 삭제
	 */
	public void delete_resume_file(long fap_resume_seq);
	
	/**
	 * @Method Name : search_nominated_company_list
	 * @Date : 2019. 1. 8.
	 * @User : 신동철
	 * @Param : 회원 아이디
	 * @Return : 내정받은 회사 리스트
	 * @Method 설명 : FAP 취업지원자 채용공고 지원할 지망개수 보유하고 있는지 여부 판단
	 */
	public ArrayList<HashMap<String, Object>> search_nominated_company_list(String user_id);
	
	/**
	 * @Method Name : insert_user_required_doc
	 * @Date : 2019. 1. 8.
	 * @User : 신동철
	 * @Param : 내정자 내정서류 정보
	 * @Return : -
	 * @Method 설명 : 내정자 내정서류를 등록하는 함수
	 */
	public int insert_user_required_doc(SocietyFapPersonalRequiredDoc user_required_doc);
	
	/**
	 * @Method Name : select_user_flag
	 * @Date : 2019. 1. 8.
	 * @User : 신동철
	 * @Param : 회원 아이디
	 * @Return : -
	 * @Method 설명 : 회원 권한을 검색하는 함수
	 */
	public String select_user_flag(String user_id);

	/**
	 * @Method Name : update_resume_form
	 * @Date : 2019.01.09
	 * @User : 남유송
	 * @Param : 이력서 기본정보
	 * @Return : -
	 * @Method 설명 : 이력서 기본정보 업데이트
	 */
	public void update_resume_form(SocietyFapUserResumeForm resumeForm);

	/**
	 * @Method Name : resume_deletable_check
	 * @Date : 2019. 1. 9.
	 * @User : 남유송
	 * @Param : int(이력서 일련번호)
	 * @Return : int
	 * @Method 설명 : 지원된 이력서를 삭제 못하도록 이력서가 이미 지원되어있는지 여부 검사
	 */
	public int select_undeletable_resume(int fap_resume_seq);
	
	/**
	 * @Method Name : select_approval_after_personal_apply_status_list
	 * @Date : 2019. 1. 15.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 승인된 개인지원현황 리스트 출력
	 */
	public ArrayList<HashMap<String, Object>> select_approval_after_personal_apply_status_list(HashMap<String, Object> userInfoMap);
	
	/**
	 * @Method Name : select_approval_before_personal_apply_status_list
	 * @Date : 2019. 1. 15.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 승인 전 개인지원현황 리스트 출력
	 */
	public ArrayList<HashMap<String, Object>> select_approval_before_personal_apply_status_list(HashMap<String, Object> userInfoMap);
	
	/**
	 * @Method Name : select_user_recruit_pcs_sch
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 회원아이디
	 * @Return : 취업지원자 전형일정 스케줄
	 * @Method 설명 : 취업지원자 전형일정 스케줄 검색
	 */
	public ArrayList<HashMap<String, Object>> select_user_recruit_pcs_sch(String user_id);
	
	/**
	 * @Method Name : select_user_review_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 취업지원자 서류전형 시퀀스
	 * @Return : 취업지원자 서류전형 정보
	 * @Method 설명 : 취업지원자 서류전형 정보 검색
	 */
	public HashMap<String, Object> select_user_review_pcs(long fap_job_recruit_pcs_seq);
	
	/**
	 * @Method Name : select_user_exam_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 취업지원자 시험전형 시퀀스
	 * @Return : 취업지원자 시험전형 정보
	 * @Method 설명 : 취업지원자 시험전형 정보 검색
	 */
	public HashMap<String, Object> select_user_exam_pcs(long fap_job_recruit_pcs_seq);
	
	/**
	 * @Method Name : select_user_itv_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 취업지원자 면접전형 시퀀스
	 * @Return : 취업지원자 면접전형 정보
	 * @Method 설명 : 취업지원자 면접전형 정보 검색
	 */
	public HashMap<String, Object> select_user_itv_pcs(long fap_job_recruit_pcs_seq);
	
	/**
	 * @Method Name : select_user_test_etc_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 취업지원자 기타전형 시퀀스
	 * @Return : 취업지원자 기타전형 정보
	 * @Method 설명 : 취업지원자 기타전형 정보 검색
	 */
	public HashMap<String, Object> select_user_test_etc_pcs(long fap_job_recruit_pcs_seq);
	
	/**
	 * @Method Name : select_per_ad_apply_info
	 * @Date : 2019. 1. 17.
	 * @User : 정대영
	 * @Param : LinkedHashMap
	 * @Return : LinkedHashMap
	 * @Method 설명 : FAP 취업지원자 채용공고 별 지원인원 및 지원가능인원 정보 조회
	 */
	public ArrayList<LinkedHashMap<String, Object>> select_per_ad_apply_info(HashMap<String, Object> userPerApplyStatusInfoParamMap);
	
	/**
	 * @Method Name : delete_current_apply_info
	 * @Date : 2019. 1. 18.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 승인 전 지원정보 삭제
	 */
	public int delete_current_apply_info(HashMap<String, Object> userInfoMap);
	
	/**
	 * @Method Name : minus_quarter_after_apply_cancel
	 * @Date : 2019. 1. 21.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 승인 전 지원정보 삭제 후 쿼터 회복
	 */
	public int minus_quarter_after_apply_cancel(HashMap<String, Object> userInfoMap);
	
	/**
	 * @Method Name : select_fap_user_jobfair_per_user_info_list
	 * @Date : 2019. 2. 13.
	 * @User : 정대영
	 * @Param : String
	 * @Return : HashMapList
	 * @Method 설명 : 통합잡페어 리스트(현재 세션아이디 참가중인지 판단)
	 */
	public ArrayList<HashMap<String, Object>> select_fap_user_jobfair_per_user_info_list(String user_id);
	
	/**
	 * @Method Name : select_fap_user_jobfair_divide_info_list
	 * @Date : 2019. 2. 14.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 해당잡페어 승인된 취업지원자 잡페어 세부선택 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_fap_user_jobfair_divide_info_list(HashMap<String, Object> params);
	
	/**
	 * @Method Name : select_user_current_participation_jobfair_list
	 * @Date : 2019. 2. 15.
	 * @User : 정대영
	 * @Param : -
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 잡페어 선택 모달 눌렀을 때 해당아이디 잡페어 목록 요청
	 */
	public ArrayList<HashMap<String, Object>> select_user_current_participation_jobfair_list(String user_id);
	
	/**
	 * @Method Name : select_user_current_participation_jobfair_divide
	 * @Date : 2019. 2. 15.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 잡페어 선택 모달 눌렀을 때 해당아이디 잡페어 세부 목록 요청
	 */
	public ArrayList<HashMap<String, Object>> select_user_current_participation_jobfair_divide(HashMap<String, Object> params);
	
	/**
	 * @Method Name : request_apply_info_rank_change
	 * @Date : 2019. 2. 20.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 취업지원자 개인지원현황 지망순위 변경 요청
	 */
	public int request_apply_info_rank_change(ArrayList<HashMap<String, Object>> appInfoMapAry);
	
	/**
	 * @Method Name : select_per_user_before_apply_detail_info
	 * @Date : 2019. 2. 21.
	 * @User : 정대영
	 * @Param : Long
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 개인별 지원전 상세정보 요청
	 */
	public ArrayList<HashMap<String, Object>> select_per_user_before_apply_detail_info(long fap_job_app_info_seq);
	
	/**
	 * @Method Name : select_per_user_after_apply_detail_info
	 * @Date : 2019. 2. 21.
	 * @User : 정대영
	 * @Param : Long
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 개인별 지원후 상세정보 요청
	 */
	public ArrayList<HashMap<String, Object>> select_per_user_after_apply_detail_info(long fap_job_app_info_seq);
	
	/**
	 * @Method Name : select_current_company_rank_info
	 * @Date : 2019. 2. 26.
	 * @User : 정대영
	 * @Param : Long
	 * @Return : ArrayList
	 * @Method 설명 : FAP 취업지원자 기업별 지망순위 별 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_current_company_rank_info(long fap_job_ad_seq);
	
	/**
	 * @Method Name : select_total_apply_status_detail_info
	 * @Date : 2019. 2. 26.
	 * @User : 정대영
	 * @Param : Long
	 * @Return : HashMap
	 * @Method 설명 : FAP 취업지원자 기업별 상세정보 요청
	 */
	public HashMap<String, Object> select_total_apply_status_detail_info(long fap_job_ad_seq);
	
	/**
	 * @Method Name : select_komve
	 * @Date : 2019. 2. 22.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 교육기관명
	 * @Method 설명 : 등록된 교육기관을 불러오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_komve();
	
	/**
	 * @Method Name : check_user_personal
	 * @Date : 2019. 2. 22.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 유저 - 개인회원 연결 갯수(0 또는 1)
	 * @Method 설명 : 개인 회원 테이블이 연결되어있는지 확인하는 함수
	 */
	public int check_user_personal(String user_id);
	
	/**
	 * @Method Name : select_job_ad_total_application_status
	 * @Date : 2019. 2. 22.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 잡페어별 전체지원현황 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_job_ad_total_application_status(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : user_board_contents_search
	 * @Date : 2019. 3. 6.
	 * @User : 신동철
	 * @Param : 게시판 관리의 특정 게시판 정보 객체
	 * @Return : fap 공지사항 게시글 리스트
	 * @Method 설명 : 게시글 리스트를 가져오는 함수
	 */
	public ArrayList<BoardContent> user_board_contents_search(HashMap<String, Object> map);
	
	/**
	 * @Method Name : board_contents_count
	 * @Date : 2019. 3. 6.
	 * @User : 신동철
	 * @Param : 게시판 관리의 특정 게시판 정보 객체
	 * @Return : fap 공지사항 게시판의 게시글 갯수
	 * @Method 설명 : 페이징을 위한 전체글 갯수 조회하는 함수
	 */
	public int board_contents_count(HashMap<String, Object> map);
	
	/**
	 * @Method Name : user_board_contents_list_search
	 * @Date : 2019. 3. 6.
	 * @User : 신동철
	 * @Param : 게시판 시퀀스
	 * @Return : 기업 잡페어 공지사항 게시판 리스트
	 * @Method 설명 : 기업 잡페어 공지사항 게시판 리스트 검색 함수
	 */
	public ArrayList<BoardContent> user_board_contents_list_search(HashMap<String, Object> map);
	
	/**
	 * @Method Name : insert_job_qna_question
	 * @Date : 2019. 3. 8.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 질문 객체
	 * @Return : 
	 * @Method 설명 : 채용공고 Q&A 질문 등록
	 */
	public int insert_job_qna_question(SocietyFapQnaQuestion qna_q);
	
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
	 * @Method Name : update_job_qna_question
	 * @Date : 2019. 3. 11.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 질문 객체
	 * @Return : 
	 * @Method 설명 : 사용자 채용공고 Q&A 질문 수정
	 */
	public void update_job_qna_question(SocietyFapQnaQuestion qna_q);
	
	/**
	 * @Method Name : delete_job_qna_question
	 * @Date : 2019. 3. 11.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 질문 일련번호
	 * @Return : 
	 * @Method 설명 : 사용자 채용공고 Q&A 질문 삭제
	 */
	public void delete_job_qna_question(long fap_job_qna_question_seq);
	
	/**
	 * @Method Name : final_decision_time_select_today
	 * @Date : 2019. 3. 25.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : 오늘날짜를 포함한 최종확정 기간 정보
	 * @Method 설명 : 오늘날짜를 포함한 최종확정 기간 정보 조회
	 */
	public SocietyFapAdminFinalDecisionTime final_decision_time_select_today(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : personal_apply_final_decision_no_one
	 * @Date : 2019. 3. 25.
	 * @User : 이종호
	 * @Param : 최종확정정보
	 * @Return : -
	 * @Method 설명 : 지원자 최종확정 결정 등록
	 */
	public void personal_apply_final_decision_update(HashMap<String, Object> paramMap);
	
	/**
	 * @Method Name : personal_apply_final_decision_select_count
	 * @Date : 2019. 3. 25.
	 * @User : 이종호
	 * @Param : 최종확정 정보
	 * @Return : 최종확정 개수
	 * @Method 설명 : 지원자 최종확정 개수 검색
	 */
	public int personal_apply_final_decision_select_count(HashMap<String, Object> paramMap);
	
	/**
	 * @Method Name : final_decision_time_count_select
	 * @Date : 2019. 3. 27.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : -
	 * @Method 설명 : 지원자가 최종확정을 내린 기업이 있는지 조회
	 */
	public int final_decision_time_count_select(String user_id);
	
	/**
	 * @Method Name : open_pt_info_select
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 오픈잡페어 설명회 정보
	 * @Method 설명 : 노출된 오픈잡페어 설명회 정보 조회
	 */
	public SocietyFapOpenPt open_pt_info_select();
	
	/**
	 * @Method Name : open_pt_edu_info_select
	 * @Date : 2019. 4. 15.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 오픈잡페어 구직자 교육 정보
	 * @Method 설명 : 노출된 오픈잡페어 구직자 교육 정보 조회
	 */
	public SocietyFapOpenPt open_pt_edu_info_select();
	
	/**
	 * @Method Name : open_pt_apply
	 * @Date : 2019. 4. 12.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 지원자 정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 지원자 신청
	 */
	public void open_pt_apply(SocietyFapOpenPtApply apply);
	
	/**
	 * @Method Name : open_pt_apply_check
	 * @Date : 2019. 4. 12.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 정보
	 * @Return : 오픈잡페어 설명회 지원자 참가 횟수
	 * @Method 설명 : 오픈잡페어 설명회 지원자 신청 확인
	 */
	public int open_pt_apply_check(SocietyFapOpenPtApply apply);
	
	/**
	 * @Method Name : open_pt_apply_cancel
	 * @Date : 2019. 4. 15.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 지원자 시퀀스
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 지원자 신청 취소
	 */
	public void open_pt_apply_cancel(int fap_open_pt_apply_seq);
	
	/**
	 * @Method Name : open_pt_apply_mypage_list
	 * @Date : 2019. 4. 12.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : 오픈잡페어 설명회 지원자 참가 내역
	 * @Method 설명 : 오픈잡페어 설명회 지원자 신청 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> user_open_pt_applied_list(String user_id);
	
	/**
	 * @Method Name : user_open_edu_applied_list
	 * @Date : 2019. 4. 12.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : 오픈잡페어 구직자교육 지원자 참가 내역
	 * @Method 설명 : 오픈잡페어 구직자교육 지원자 신청 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> user_open_edu_applied_list(String user_id);
	
	/**
	 * @Method Name : open_pt_edu_resume_apply
	 * @Date : 2019. 4. 15.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 지원자 이력서 정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 구직자 교육 지원자 이력서 신청
	 */
	public void open_pt_edu_resume_apply(SocietyFapOpenPtResume resume);
	
	/**
	 * @Method Name : user_open_edu_resume_list_select
	 * @Date : 2019. 4. 15.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 지원자 아이디
	 * @Return : 오픈잡페어 구직자 교육 지원자 이력서 리스트
	 * @Method 설명 : 오픈잡페어 구직자 교육 지원자 이력서 리스트 조회
	 */
	public ArrayList<SocietyFapUserResumeForm> user_open_edu_resume_list_select(String user_id);
	
	/**
	 * @Method Name : user_popup_check
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : -
	 * @Return : FAP 노출 팝업 리스트
	 * @Method 설명 : FAP 노출 팝업 리스트 조회
	 */
	public ArrayList<SocietyFapPopup> user_popup_check();

	/**
	 * @Method Name : user_open_comp_banner_list
	 * @Date : 2019. 7. 17.
	 * @User : 김경아
	 * @Param :  회사아이디, 채용공고 시퀀스 
	 * @Return : 기업배너정보
	 * @Method 설명 : FAP 오픈잡페어 지원자 메인페이지 기업배너 리스트 조회 
	 */
	public HashMap<String, Object> user_open_comp_banner_list(HashMap<String, Object> paramMap);

	
	/**
	 * @Method Name : select_user_board_nm
	 * @Date : 2019. 7. 21.
	 * @User : 김경아		
	 * @Param : 게시판 세부구분
	 * @Return : 게시판 이름 
	 * @Method 설명 : 게시판 이름 조회 
	 */
	public String select_user_board_nm(String board_detail_gb);
	
	/**
	 * @Method Name : select_jobfair_divide_gb
	 * @Date : 2019. 8. 26.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : 세부 잡페어 구분
	 * @Method 설명 : 세부 잡페어 구분 조회
	 */
	public String select_jobfair_divide_gb(int fap_jobfair_divide_seq);
	
	/**
	 * @Method Name : select_mainpage_context
	 * @Date : 2019. 9. 3.
	 * @User : 이종호
	 * @Param : 지역정보
	 * @Return : 메인페이지 기업컨텐츠 정보
	 * @Method 설명 : 설정된 메인페이지 기업컨텐츠 조회
	 */
	public ArrayList<HashMap<String, Object>> select_mainpage_context(HashMap<String,Object> paramMap);
	
	/**
	 * @Method Name : check_jobfair_join
	 * @Date : 2019. 9. 4.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : 잡페어 참가 승인 완료시 1 아니면 0
	 * @Method 설명 : 해당 잡페어 참가 승인까지 완료했는 조회
	 */
	public int check_jobfair_join(HashMap<String, Object> params);
	
	/**
	 * @Method Name : check_user_apply_confirm
	 * @Date : 2019. 9. 6.
	 * @User : 이종호
	 * @Param : 회원 아이디, 잡페어 시퀀스
	 * @Return : 회원 지원하기(보증보험) 동의 완료시 1 미동의시 0
	 * @Method 설명 : 해당 잡페어의 채용공고에 지원시 보증보험 관련 동의를 했는지 조회
	 */
	public int check_user_apply_confirm(HashMap<String, Object> params);
	
	/**
	 * @Method Name : insert_user_apply_confirm
	 * @Date : 2019. 9. 6.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스, 회원 아이디
	 * @Return : -
	 * @Method 설명 : 잡페어별 회원 지원동의(보증보험) 동의 등록 
	 */
	public int insert_user_apply_confirm(HashMap<String, Object> params);
	
	/**
	 * @Method Name : tokyofair_schedule_user_list
	 * @Date : 2019. 10. 15.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스 , 회원 아이디
	 * @Return : 도쿄페어 본인 일정 리스트
	 * @Method 설명 : 도쿄페어 본인 일정 리스트 조회
	 */
	public HashMap<String, Object> tokyofair_schedule_user_list(HashMap<String, Object> params);
	
	/**
	 * @return 
	 * @Method Name : internship_apply
	 * @Date : 2021. 4. 16.
	 * @User : 김나영
	 * @Param : 회원 ID, 이름, 연락처, 이메일
	 * @Return : -
	 * @Method 설명 : 미국인턴십 지원
	 */
	public int internship_apply(HashMap<String, Object> params);
	
	/**
	 * @return 
	 * @Method Name : select_internship
	 * @Date : 2021. 4. 16.
	 * @User : 김나영
	 * @Param : 게시글 시퀀스
	 * @Return : 미국인턴십 지원자 정보
	 * @Method 설명 : 미국인턴십 지원여부 조회
	 */
	public HashMap<String, Object> select_internship(HashMap<String, Object> params);
	
	/**
	 * @return 
	 * @Method Name : internship_cancel
	 * @Date : 2021. 4. 16.
	 * @User : 김나영
	 * @Param : 인턴십 시퀀스
	 * @Return : -
	 * @Method 설명 : 미국인턴십 지원취소
	 */
	public int internship_cancel(HashMap<String, Object> params);
}
