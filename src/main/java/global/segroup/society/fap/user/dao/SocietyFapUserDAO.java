/**
 * 
 */
package global.segroup.society.fap.user.dao;

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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import global.segroup.domain.BoardContent;
import global.segroup.domain.User;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminFinalDecisionTime;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenPt;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenPtApply;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenPtResume;
import global.segroup.society.fap.admincommon.domain.SocietyFapPopup;
import global.segroup.society.fap.company.dao.SocietyFapCompanyMapper;
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
 * @Class 설명 : Soft Engineer Society 통합잡페어 지원자 DAO
 * 
 */

@Repository
public class SocietyFapUserDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyFapUserDAO.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	/**
	 * @Method Name : user_id_check
	 * @Date : 2018. 12. 12.
	 * @User : 김준영
	 * @Param : 유저가 입력한 아이디
	 * @Return : 일치하는 아이디 or null
	 * @Method 설명 : 유저가 입력한 아이디가 중복되는지 확인하는 함수
	 */
	public String user_id_check(String user_id){
		logger.debug("유저 아이디 중복 체크 DAO 시작");
		String user_id_check = null;
		try {
			SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
			user_id_check = sfuMapper.user_id_check(user_id);
		} catch (Exception e) {
			System.out.println(e);
		}
		logger.debug("유저 아이디 중복 체크 DAO 종료");
		return user_id_check;
	}
	
	/**
	 * @Method Name : select_com_user
	 * @Date : 2019. 2. 27.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 유저 객체
	 * @Method 설명 : 특정 유저의 정보를 가져오는 함수
	 */
	public User select_com_user(String user_id){
		logger.debug("유저 정보 가져오기 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		User user = sfuMapper.select_com_user(user_id);
		logger.debug("유저 정보 가져오기 DAO 종료");
		return user;
	}
	
	/**
	 * @Method Name : insert_com_user
	 * @Date : 2018. 12. 12.
	 * @User : 김준영
	 * @Param : 유저 객체
	 * @Return : -
	 * @Method 설명 : 유저 공통 정보를 등록을 하는 함수 
	 *//*
	public void insert_com_user(User user){
		logger.info("유저 공통 정보 등록 DAO 시작");
		try{
			SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
			sfuMapper.insert_com_user(user);
		} catch (Exception e) {
			System.out.println(e);
		}
		logger.info("유저 공통 정보 등록 DAO 종료");
	}
	
	*//**
	 * @Method Name : insert_personal_user
	 * @Date : 2018. 12. 14.
	 * @User : 김준영
	 * @Param : 개인 회원 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원을 등록을 하는 함수
	 *//*
	public void insert_personal_user(SocietyFapPersonalUser societyFapPersonalUser){
		logger.info("개인 회원 등록 DAO 시작");
		try {
			SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
			sfuMapper.insert_personal_user(societyFapPersonalUser);
		} catch (Exception e) {
			System.out.println(e);
		}
		logger.info("개인 회원 등록 DAO 종료");
	}
	
	*//**
	 * @Method Name : insert_personal_hs
	 * @Date : 2018. 12. 14.
	 * @User : 김준영
	 * @Param : 개인 회원 고등학교 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원의 고등학교를 등록 하는 함수
	 *//*
	public void insert_personal_hs(SocietyFapPersonalHighschool societyFapPersonalHighschool){
		logger.info("개인 회원 고등학교 등록 DAO 시작");
		try {
			SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
			sfuMapper.insert_personal_hs(societyFapPersonalHighschool);
		} catch (Exception e) {
			System.out.println(e);
		}
		logger.info("개인 회원 고등학교 등록 DAO 종료");
	}
	
	*//**
	 * @Method Name : insert_personal_univ
	 * @Date : 2018. 12. 14.
	 * @User : 김준영
	 * @Param : 개인 회원 대학교 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원의 대학교 등록 하는 함수 
	 *//*
	public void insert_personal_univ(SocietyFapPersonalUniversity societyFapPersonalUniversity){
		logger.info("개인 회원 대학교 등록 DAO 시작");
		try {
			SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
			sfuMapper.insert_personal_univ(societyFapPersonalUniversity);
		} catch (Exception e) {
			System.out.println(e);
		}
		logger.info("개인 회원 대학교 등록 DAO 종료");
	}
	
	*//**
	 * @Method Name : insert_personal_grad
	 * @Date : 2018. 12. 14.
	 * @User : 김준영
	 * @Param : 개인 회원 대학원 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원의 대학원을 등록 하는 함수
	 *//*
	public void insert_personal_grad(SocietyFapPersonalGraduate societyFapPersonalGraduate){
		logger.info("개인 회원 대학원 등록 DAO 시작");
		try {
			SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
			sfuMapper.insert_personal_grad(societyFapPersonalGraduate);
		} catch (Exception e) {
			System.out.println(e);
		}
		logger.info("개인 회원 대학원 등록 DAO 종료");
	}*/
	
	/**
	 * @Method Name : select_personal_user
	 * @Date : 2018. 12. 14.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 개인 유저 객체
	 * @Method 설명 : 개인 유저 객체를 불러오는 함수
	 */
	public SocietyFapPersonalUser select_personal_user(String user_id){
		logger.info("FAP 개인 유저 객체 가져오기 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		SocietyFapPersonalUser societyFapPersonalUser = sfuMapper.select_personal_user(user_id);			
		logger.info("FAP 개인 유저 객체 가져오기 DAO 종료");
		return societyFapPersonalUser;
	}
	
	/**
	 * @Method Name : select_personal_school
	 * @Date : 2018. 12. 14.
	 * @User : 김준영
	 * @Param : 개인 유저 객체
	 * @Return : 개인 유저의 학교 정보 hashMap
	 * @Method 설명 : 개인 유저가 가지고 있는 학교 정보를 불러오는 함수
	 */
	public HashMap<String, Object> select_personal_school(SocietyFapPersonalUser societyFapPersonalUser){
		logger.info("FAP 개인 유저 학교 객체 가져오기 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		HashMap<String, Object> hashmap = sfuMapper.select_personal_school(societyFapPersonalUser);			
		logger.info("FAP 개인 유저 학교 객체 가져오기 DAO 종료");
		return hashmap;
	}
	
	/**
	 * @Method Name : select_fap_user_jobfair_info_list
	 * @Date : 2018. 12. 6.
	 * @User : 정대영
	 * @Param : -
	 * @Return : HashMapList
	 * @Method 설명 : 통합잡페어 리스트
	 */
	public ArrayList<HashMap<String, Object>> select_fap_user_jobfair_info_list(){
		logger.debug("FAP 취업지원자 통합잡페어 정보 리스트 출력 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> jobfairInfoList = sfuMapper.select_fap_user_jobfair_info_list();
		logger.debug("FAP 취업지원자 통합잡페어 정보 리스트 출력 DAO 종료");
		return jobfairInfoList;
	}
	
	/**
	 * @Method Name : select_fap_user_jobfair_location_list
	 * @Date : 2018. 12. 6.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMapList
	 * @Method 설명 : 통합잡페어 개최지 리스트
	 */
	public ArrayList<HashMap<String, Object>> select_fap_user_jobfair_location_list(HashMap<String, Object> params){
		logger.debug("FAP 취업지원자 통합잡페어 개최지 리스트 출력 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> tempJobfairLocationList = sfuMapper.select_fap_user_jobfair_location_list(params);
		logger.debug("FAP 취업지원자 통합잡페어 개최지 리스트 출력 DAO 종료");
		return tempJobfairLocationList;
	}
	
	/**
	 * @Method Name : user_jobfair_entry_request
	 * @Date : 2018. 12. 10.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : -
	 * @Method 설명 : FAP 취업지원자 잡페어 신청 메소드
	 */
	public int user_jobfair_entry_request(HashMap<String, Object> map){
		logger.debug("FAP 취업지원자 잡페어 신청 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int result = sfuMapper.user_jobfair_entry_request(map);
		logger.debug("FAP 취업지원자 잡페어 신청 DAO 종료");
		return result; 
	}
	
	/**
	 * @Method Name : select_jobfair_job_advertisement_list
	 * @Date : 2018. 12. 14.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 채용공고 리스트 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_jobfair_job_advertisement_list(HashMap<String, Object> params, RowBounds rw){
		logger.debug("FAP 취업지원자 통합잡페어 정보 리스트 출력 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> jobAdvertisementList = sfuMapper.select_jobfair_job_advertisement_list(params, rw);
		logger.debug("FAP 취업지원자 통합잡페어 정보 리스트 출력 DAO 종료");
		return jobAdvertisementList;
	}
	
	/**
	 * @Method Name : select_category_and_workplace_list
	 * @Date : 2019. 2. 26.
	 * @User : 정대영
	 * @Param : Long
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 채용공고 시퀀스 별 모집직종, 근무지 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_category_and_workplace_list(ArrayList<Long> curJobAdSeqList){
		logger.debug("FAP 취업지원자 채용공고 시퀀스 별 모집직종, 근무지 셀렉트 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> categoryAndWorkplaceList = sfuMapper.select_category_and_workplace_list(curJobAdSeqList);
		logger.debug("FAP 취업지원자 채용공고 시퀀스 별 모집직종, 근무지 셀렉트 DAO 종료");
		return categoryAndWorkplaceList;
	}
	
	/**
	 * @Method Name : select_jobfair_job_advertisement_list_count
	 * @Date : 2019. 2. 25.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 채용공고 리스트 총 개수 셀렉트
	 */
	public int select_jobfair_job_advertisement_list_count(HashMap<String, Object> paramMap){
		logger.debug("FAP 취업지원자 채용공고 리스트 총 개수 셀렉트 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int adTotalCount = sfuMapper.select_jobfair_job_advertisement_list_count(paramMap);
		logger.debug("FAP 취업지원자 채용공고 리스트 총 개수 셀렉트 DAO 종료");
		return adTotalCount;
	}
	
	/**
	 * @Method Name : select_company_group_code_list
	 * @Date : 2019. 1. 14.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMap
	 * @Method 설명 : FAP 취업지원자 잡페어별 그룹코드 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_company_group_code_list(HashMap<String, Object> fapJobAdvertisement){
		logger.debug("FAP 취업지원자 잡페어별 그룹코드 셀렉트 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> companyGroupCodeList = sfuMapper.select_company_group_code_list(fapJobAdvertisement);
		logger.debug("FAP 취업지원자 잡페어별 그룹코드 셀렉트 DAO 종료");
		return companyGroupCodeList;
	}
	
	/**
	 * @Method Name : insert_my_favorite_company
	 * @Date : 2018. 12. 14.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 내가담은기업 목록 인서트
	 */
	public int insert_my_favorite_company(HashMap<String, Object> fapMyFavoriteCompany){
		logger.debug("FAP 취업지원자 내가담은기업 인서트 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int result = sfuMapper.insert_my_favorite_company(fapMyFavoriteCompany);
		logger.debug("FAP 취업지원자 내가담은기업 인서트 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : my_favorite_company_check
	 * @Date : 2018. 12. 14.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 취업지원자 내가담은기업 중복체크
	 */
	public String my_favorite_company_check(HashMap<String, Object> fapMyFavoriteCompany){
		logger.debug("FAP 취업지원자 내가담은기업 중복체크 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		String result = sfuMapper.my_favorite_company_check(fapMyFavoriteCompany);
		logger.debug("FAP 취업지원자 내가담은기업 중복체크 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_my_favorite_company_list
	 * @Date : 2018. 12. 14.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 내가담은기업 리스트 출력
	 */
	public ArrayList<HashMap<String, Object>> select_my_favorite_company_list(HashMap<String, Object> params){
		logger.debug("FAP 취업지원자 내가담은기업 리스트 출력 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> favoriteCompanyList = sfuMapper.select_my_favorite_company_list(params);
		logger.debug("FAP 취업지원자 내가담은기업 리스트 출력 DAO 종료");
		return favoriteCompanyList;
	}
	
	/**
	 * @Method Name : update_com_user
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 공통 회원 객체
	 * @Return : -
	 * @Method 설명 : 공통 회원 정보를 수정
	 */
	public void update_com_user(User user){
		logger.info("FAP 공통 회원 수정 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		sfuMapper.update_com_user(user);
		logger.info("FAP 공통 회원 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : update_personal_user
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 개인 회원 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원 정보를 수정
	 *//*
	public void update_personal_user(SocietyFapPersonalUser societyFapPersonalUser){
		logger.info("개인 회원 수정 DAO 시작");
		try {
			SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
			sfuMapper.update_personal_user(societyFapPersonalUser);
		} catch (Exception e) {
			System.out.println(e);
		}
		logger.info("개인 회원 수정 DAO 종료");
	}
	
	*//**
	 * @Method Name : update_user_hs
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 개인 회원의 고등학교 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원의 고등학교 정보를 수정
	 *//*
	public void update_user_hs(SocietyFapPersonalHighschool societyFapPersonalHighschool){
		logger.info("개인 회원 고등학교 수정 DAO 시작");
		try {
			SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
			sfuMapper.update_user_hs(societyFapPersonalHighschool);
		} catch (Exception e) {
			System.out.println(e);
		}
		logger.info("개인 회원 고등학교 수정 DAO 종료");
	}
	
	*//**
	 * @Method Name : update_user_univ
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 개인 회원의 대학교 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원의 대학교 정보를 수정
	 *//*
	public void update_user_univ(SocietyFapPersonalUniversity societyFapPersonalUniversity){
		logger.info("개인 회원 대학교 수정 DAO 시작");
		try {
			SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
			sfuMapper.update_user_univ(societyFapPersonalUniversity);
		} catch (Exception e) {
			System.out.println(e);
		}
		logger.info("개인 회원 대학교 수정 DAO 종료");
	}
	
	*//**
	 * @Method Name : update_user_grad
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 개인 회원의 대학원 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원의 대학원 정보를 수정
	 *//*
	public void update_user_grad(SocietyFapPersonalGraduate societyFapPersonalGraduate){
		logger.info("개인 회원 대학원 수정 DAO 시작");
		try {
			SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
			sfuMapper.update_user_grad(societyFapPersonalGraduate);
		} catch (Exception e) {
			System.out.println(e);
		}
		logger.info("개인 회원 대학원 수정 DAO 종료");
	}
	
	*//**
	 * @Method Name : delete_user_hs
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 고등학교 seq
	 * @Return : -
	 * @Method 설명 : 개인 회원의 고등학교 삭제
	 *//*
	public void delete_user_hs(int hs_seq){
		
		try {
			SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
			sfuMapper.delete_user_hs(hs_seq);
		} catch (Exception e) {
			System.out.println(e);
		}
		
	}
	
	*//**
	 * @Method Name : delete_user_univ
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 대학교 seq
	 * @Return : -
	 * @Method 설명 : 개인 회원의 대학교 삭제
	 *//*
	public void delete_user_univ(int univ_seq){
			
		try {
			SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
			sfuMapper.delete_user_univ(univ_seq);
		} catch (Exception e) {
			System.out.println(e);
		}
			
	}
	
	*//**
	 * @Method Name : delete_user_grad
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 대학원 seq
	 * @Return : -
	 * @Method 설명 : 개인 회원의 대학원 삭제
	 *//*
	public void delete_user_grad(int grad_seq){
		
		try {
			SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
			sfuMapper.delete_user_grad(grad_seq);
		} catch (Exception e) {
			System.out.println(e);
		}
		
	}*/
	
	/**
	 * @Method Name : insert_user
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 공통 유저 객체, 유저 학교 정보 객체
	 * @Return : -
	 * @Method 설명 : 유저 회원 가입
	 */
	@Transactional
	public void insert_user(User user, SocietyFapPersonalUser sfpUser, 
			SocietyFapPersonalHighschool sfpHighschool, 
			SocietyFapPersonalUniversity sfpUniversity, 
			SocietyFapPersonalGraduate sfpGraduate){
		logger.info("일반 회원 가입 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		// 회원 공통 정보
		sfuMapper.insert_com_user(user);
		// 개인 회원 정보
		sfuMapper.insert_personal_user(sfpUser);
		
		// 고등학교 정보 입력
		if(sfpUser.getFap_personal_user_edu_level().equals("B3300")){
			sfpHighschool.setFap_personal_user_seq(sfpUser.getFap_personal_user_seq());
			sfpHighschool.setFap_personal_hs_ins_id(user.getUser_id());
			sfpHighschool.setFap_personal_hs_udt_id(user.getUser_id());
			sfuMapper.insert_personal_hs(sfpHighschool);
		// 대학교 정보 입력
		} else if(sfpUser.getFap_personal_user_edu_level().equals("B3301") 
					|| sfpUser.getFap_personal_user_edu_level().equals("B3302")
					|| sfpUser.getFap_personal_user_edu_level().equals("B3304")
					|| sfpUser.getFap_personal_user_edu_level().equals("B3305")){
			sfpUniversity.setFap_personal_user_seq(sfpUser.getFap_personal_user_seq());
			sfpUniversity.setFap_personal_univ_ins_id(user.getUser_id());
			sfpUniversity.setFap_personal_univ_udt_id(user.getUser_id());
			sfuMapper.insert_personal_univ(sfpUniversity);
		// 대학교, 대학원 정보 입력
		} else if(sfpUser.getFap_personal_user_edu_level().equals("B3303")
					|| sfpUser.getFap_personal_user_edu_level().equals("B3306")){
			sfpUniversity.setFap_personal_user_seq(sfpUser.getFap_personal_user_seq());
			sfpUniversity.setFap_personal_univ_ins_id(user.getUser_id());
			sfpUniversity.setFap_personal_univ_udt_id(user.getUser_id());
			sfuMapper.insert_personal_univ(sfpUniversity);
			sfpGraduate.setFap_personal_univ_seq(sfpUniversity.getFap_personal_univ_seq());
			sfpGraduate.setFap_personal_grad_ins_id(user.getUser_id());
			sfpGraduate.setFap_personal_grad_udt_id(user.getUser_id());
			sfuMapper.insert_personal_grad(sfpGraduate);
		}
		logger.info("일반 회원 가입 DAO 종료");
	}
	
	/**
	 * @Method Name : user_school_insert
	 * @Date : 2019. 2. 25.
	 * @User : 김준영
	 * @Param : 개인 유저 정보, 학교 정보
	 * @Return : -
	 * @Method 설명 : 회원의 학교 정보를 입력하는 함수
	 */
	@Transactional
	public void user_school_insert(SocietyFapPersonalUser sfpUser, 
			SocietyFapPersonalHighschool sfpHighschool, 
			SocietyFapPersonalUniversity sfpUniversity, 
			SocietyFapPersonalGraduate sfpGraduate){
		logger.info("FAP 회원 학교 정보 입력 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		// 개인 회원 정보
		sfuMapper.insert_personal_user(sfpUser);
		
		// 고등학교 정보 입력
		if(sfpUser.getFap_personal_user_edu_level().equals("B3300")){
			sfpHighschool.setFap_personal_user_seq(sfpUser.getFap_personal_user_seq());
			sfpHighschool.setFap_personal_hs_ins_id(sfpUser.getUser_id());
			sfpHighschool.setFap_personal_hs_udt_id(sfpUser.getUser_id());
			sfuMapper.insert_personal_hs(sfpHighschool);
		// 대학교 정보 입력
		} else if(sfpUser.getFap_personal_user_edu_level().equals("B3301") 
					|| sfpUser.getFap_personal_user_edu_level().equals("B3302")
					|| sfpUser.getFap_personal_user_edu_level().equals("B3304")
					|| sfpUser.getFap_personal_user_edu_level().equals("B3305")){
			sfpUniversity.setFap_personal_user_seq(sfpUser.getFap_personal_user_seq());
			sfpUniversity.setFap_personal_univ_ins_id(sfpUser.getUser_id());
			sfpUniversity.setFap_personal_univ_udt_id(sfpUser.getUser_id());
			sfuMapper.insert_personal_univ(sfpUniversity);
		// 대학교, 대학원 정보 입력
		} else if(sfpUser.getFap_personal_user_edu_level().equals("B3303")
					|| sfpUser.getFap_personal_user_edu_level().equals("B3306")){
			sfpUniversity.setFap_personal_user_seq(sfpUser.getFap_personal_user_seq());
			sfpUniversity.setFap_personal_univ_ins_id(sfpUser.getUser_id());
			sfpUniversity.setFap_personal_univ_udt_id(sfpUser.getUser_id());
			sfuMapper.insert_personal_univ(sfpUniversity);
			sfpGraduate.setFap_personal_univ_seq(sfpUniversity.getFap_personal_univ_seq());
			sfpGraduate.setFap_personal_grad_ins_id(sfpUser.getUser_id());
			sfpGraduate.setFap_personal_grad_udt_id(sfpUser.getUser_id());
			sfuMapper.insert_personal_grad(sfpGraduate);
		}
		logger.info("FAP 회원 학교 정보 입력 DAO 종료");
	}
	
	/**
	 * @Method Name : update_user
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 회원 공통, 개인, 고등학교, 대학교, 대학원 객체
	 * @Return : -
	 * @Method 설명 : 회원 정보를 수정하는 함수
	 */
	@Transactional
	public void update_user(User user, SocietyFapPersonalUser sfpUser, 
			SocietyFapPersonalHighschool sfpHighschool, 
			SocietyFapPersonalUniversity sfpUniversity,
			SocietyFapPersonalGraduate sfpGraduate){
		logger.info("회원 정보 수정 DAO 시작");
		
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		// 회원 공통 테이블 수정
		sfuMapper.update_com_user(user);
		
		// 개인 회원 테이블 수정
		sfpUser.setFap_personal_user_udt_id(user.getUser_id());
		sfuMapper.update_personal_user(sfpUser);
		
		/*
		// 기존 선택했던 최종 학력과 수정 후 최종 학력이 같을 경우는 단순 update 실행
		if(origin_level.equals(sfpUser.getFap_personal_user_edu_level())){
			// 고등학교 정보 수정
			if(sfpUser.getFap_personal_user_edu_level().equals("B3300")){
				sfuMapper.update_user_hs(sfpHighschool);
			// 대학교 정보 수정
			} else if(sfpUser.getFap_personal_user_edu_level().equals("B3301") 
					|| sfpUser.getFap_personal_user_edu_level().equals("B3302")
					|| sfpUser.getFap_personal_user_edu_level().equals("B3304")
					|| sfpUser.getFap_personal_user_edu_level().equals("B3305")
					|| sfpUser.getFap_personal_user_edu_level().equals("B3306")){
				sfuMapper.update_user_univ(sfpUniversity);
			// 대학원 정보 수정
			} else if(sfpUser.getFap_personal_user_edu_level().equals("B3303")){
				sfuMapper.update_user_grad(sfpGraduate);
				sfuMapper.update_user_univ(sfpUniversity);
			}
		// 기존 선택했던 최종 학력과 수정 후 최종 학력이 다를 경우는 delete 후 insert실행
		} else {
			sfpHighschool.setFap_personal_hs_ins_id(user.getUser_id());
			sfpUniversity.setFap_personal_univ_ins_id(user.getUser_id());
			sfpGraduate.setFap_personal_grad_ins_id(user.getUser_id());
			// 기존 : 고등학교
			if(origin_level.equals("B3300")){
				// 고등학교 삭제
				sfuMapper.delete_user_hs(sfpHighschool.getFap_personal_hs_seq());
				// 전문 대학교 or 대학교 등록
				if(sfpUser.getFap_personal_user_edu_level().equals("B3301") 
						|| sfpUser.getFap_personal_user_edu_level().equals("B3302")
						|| sfpUser.getFap_personal_user_edu_level().equals("B3304")
						|| sfpUser.getFap_personal_user_edu_level().equals("B3305")
						|| sfpUser.getFap_personal_user_edu_level().equals("B3306")){
					sfpUniversity.setFap_personal_user_seq(sfpUser.getFap_personal_user_seq());
					sfuMapper.insert_personal_univ(sfpUniversity);
				// 대학원 등록
				} else if(sfpUser.getFap_personal_user_edu_level().equals("B3303")){
					sfpUniversity.setFap_personal_user_seq(sfpUser.getFap_personal_user_seq());
					sfuMapper.insert_personal_univ(sfpUniversity);
					sfpGraduate.setFap_personal_univ_seq(sfpUniversity.getFap_personal_univ_seq());
					sfuMapper.insert_personal_grad(sfpGraduate);
				}
			
			// 기존 : 전문 대학교 or 대학교
			} else if(origin_level.equals("B3301") 
					|| origin_level.equals("B3302")
					|| origin_level.equals("B3304")
					|| origin_level.equals("B3305")
					|| origin_level.equals("B3306")){
				// 대학교 삭제
				sfuMapper.delete_user_univ(sfpUniversity.getFap_personal_univ_seq());
				// 고등학교 등록
				if(sfpUser.getFap_personal_user_edu_level().equals("B3300")){
					sfpHighschool.setFap_personal_user_seq(sfpUser.getFap_personal_user_seq());
					sfuMapper.insert_personal_hs(sfpHighschool);
				// 대학원 등록
				} else if(sfpUser.getFap_personal_user_edu_level().equals("B3303")){
					sfpUniversity.setFap_personal_user_seq(sfpUser.getFap_personal_user_seq());
					sfuMapper.insert_personal_univ(sfpUniversity);
					sfpGraduate.setFap_personal_univ_seq(sfpUniversity.getFap_personal_univ_seq());
					sfuMapper.insert_personal_grad(sfpGraduate);
				}
				
			// 기존 : 대학원
			} else if(origin_level.equals("B3303")){
				// 대학교, 대학원 삭제
				sfuMapper.delete_user_grad(sfpGraduate.getFap_personal_grad_seq());
				sfuMapper.delete_user_univ(sfpUniversity.getFap_personal_univ_seq());
				// 고등학교 등록
				if(sfpUser.getFap_personal_user_edu_level().equals("B3300")){
					sfpHighschool.setFap_personal_user_seq(sfpUser.getFap_personal_user_seq());
					sfuMapper.insert_personal_hs(sfpHighschool);
				// 전문대학교 or 대학교 등록
				} else if(sfpUser.getFap_personal_user_edu_level().equals("B3301") 
							|| sfpUser.getFap_personal_user_edu_level().equals("B3302")
							|| sfpUser.getFap_personal_user_edu_level().equals("B3304")
							|| sfpUser.getFap_personal_user_edu_level().equals("B3305")
							|| sfpUser.getFap_personal_user_edu_level().equals("B3306")){
					sfpUniversity.setFap_personal_user_seq(sfpUser.getFap_personal_user_seq());
					sfuMapper.insert_personal_univ(sfpUniversity);
				}
			}
			
		}
		*/
		
		sfuMapper.delete_user_hs(sfpUser.getFap_personal_user_seq());
		sfuMapper.delete_user_univ(sfpUser.getFap_personal_user_seq());
		
		// 고등학교 정보 입력
		if(sfpUser.getFap_personal_user_edu_level().equals("B3300")){
			sfpHighschool.setFap_personal_user_seq(sfpUser.getFap_personal_user_seq());
			sfpHighschool.setFap_personal_hs_ins_id(user.getUser_id());
			sfpHighschool.setFap_personal_hs_udt_id(user.getUser_id());
			sfuMapper.insert_personal_hs(sfpHighschool);
		// 대학교 정보 입력
		} else if(sfpUser.getFap_personal_user_edu_level().equals("B3301") 
					|| sfpUser.getFap_personal_user_edu_level().equals("B3302")
					|| sfpUser.getFap_personal_user_edu_level().equals("B3304")
					|| sfpUser.getFap_personal_user_edu_level().equals("B3305")){
			sfpUniversity.setFap_personal_user_seq(sfpUser.getFap_personal_user_seq());
			sfpUniversity.setFap_personal_univ_ins_id(user.getUser_id());
			sfpUniversity.setFap_personal_univ_udt_id(user.getUser_id());
			sfuMapper.insert_personal_univ(sfpUniversity);
		// 대학교, 대학원 정보 입력
		} else if(sfpUser.getFap_personal_user_edu_level().equals("B3303")
					|| sfpUser.getFap_personal_user_edu_level().equals("B3306")){
			
			sfpUniversity.setFap_personal_user_seq(sfpUser.getFap_personal_user_seq());
			sfpUniversity.setFap_personal_univ_ins_id(user.getUser_id());
			sfpUniversity.setFap_personal_univ_udt_id(user.getUser_id());
			sfuMapper.insert_personal_univ(sfpUniversity);
			
			sfpGraduate.setFap_personal_univ_seq(sfpUniversity.getFap_personal_univ_seq());
			sfpGraduate.setFap_personal_grad_ins_id(user.getUser_id());
			sfpGraduate.setFap_personal_grad_udt_id(user.getUser_id());
			sfuMapper.insert_personal_grad(sfpGraduate);
		}
		
		logger.info("회원 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : delete_my_favorite_company_list
	 * @Date : 2018. 12. 17.
	 * @User : 정대영
	 * @Param : SocietyFapUserMyFavoriteCompany
	 * @Return : Int
	 * @Method 설명 : FAP 내가담은목록에서 기업 삭제
	 */
	public int delete_my_favorite_company_list(HashMap<String, Object> deleteMyFavoriteCompany){
		logger.debug("FAP 내가담은목록에서 기업 삭제 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int result = sfuMapper.delete_my_favorite_company_list(deleteMyFavoriteCompany);
		logger.debug("FAP 내가담은목록에서 기업 삭제 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : resume_parent_insert
	 * @Date : 2018. 01. 09.
	 * @User : 남유송
	 * @Param : 이력서 정보(기본정보)
	 * @Return : JSP 리턴페이지
	 * @Method 설명 : 사용자로부터 입력받은 정보로 이력서를 생성하고 이력서 관리 페이지로 이동하는 method
	 */
	public long resume_parent_insert(SocietyFapUserResumeForm resumeForm){
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		sfuMapper.insert_resume_basic(resumeForm);
		long resume_parent_insert_seq = resumeForm.getFap_resume_seq();
		return resume_parent_insert_seq;
	}
	

	/**
	 * @return 
	 * @Method Name : update_resume_form
	 * @Date : 2019.01.07
	 * @User : 남유송
	 * @Param : long(이력서 일련번호)
	 * @Return : SocietyFapUserResumeForm
	 * @Method 설명 : 기본 이력서 정보만 업데이트
	 */
	public long resume_parent_update(SocietyFapUserResumeForm resumeForm) {
		logger.debug("FAP 기본 이력서 정보 업데이트 Service 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		sfuMapper.update_resume_form(resumeForm);
		long resume_parent_insert_seq = resumeForm.getFap_resume_seq();
		logger.debug("FAP 기본 이력서 정보 업데이트 Service 시작");
		return resume_parent_insert_seq;
	}
	
	/**
	 * @Method Name : insert_resume
	 * @Date : 2018. 12. 17.
	 * @User :남유송
	 * @Param : 이력서 모든 정보 객체
	 * @Return : -
	 * @Method 설명 : 이력서 모든 정보 객체 입력 
	 */
	public void insert_resume(SocietyFapUserResumeForm resumeForm, SocietyFapUserResumeEduhistory resumeEduHistory, SocietyFapUserResumeLicense resumeLicense,
			SocietyFapUserResumeCareer resumeCareer, SocietyFapUserResumeProject resumeProject, SocietyFapUserResumeTalent resumeTalent,
			SocietyFapUserResumeProfile resumeProfile, SocietyFapUserResumeAddr resumeAddr, SocietyFapUserResumeName resumeName, SocietyFapUserResumeFile resumeFile
		) {
		logger.debug("이력서 전체 정보 등록 DAO 시작");
			String user_id = resumeForm.getUser_id();
			SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
			if(resumeEduHistory.getResumeEduList() != null){
				for(int i = 0; i < resumeEduHistory.getResumeEduList().size(); i++){
					resumeEduHistory.getResumeEduList().get(i).setFap_resume_seq(resumeForm.getFap_resume_seq());
					resumeEduHistory.getResumeEduList().get(i).setFap_resume_edu_ins_id(user_id);
					resumeEduHistory.getResumeEduList().get(i).setFap_resume_edu_udt_id(user_id);
				}
				sfuMapper.insert_resume_eduHistory(resumeEduHistory);
			}
			if(resumeLicense.getResumeLicenseList() != null){
				for(int i= 0; i < resumeLicense.getResumeLicenseList().size(); i++){
					resumeLicense.getResumeLicenseList().get(i).setFap_resume_seq(resumeForm.getFap_resume_seq());
					resumeLicense.getResumeLicenseList().get(i).setFap_resume_license_ins_id(user_id);
					resumeLicense.getResumeLicenseList().get(i).setFap_resume_license_udt_id(user_id);;
				}
				sfuMapper.insert_resume_license(resumeLicense);		
			}
			if(resumeCareer.getResumeCareerList() != null){
				for(int i = 0; i < resumeCareer.getResumeCareerList().size(); i++){
					resumeCareer.getResumeCareerList().get(i).setFap_resume_seq(resumeForm.getFap_resume_seq());
					resumeCareer.getResumeCareerList().get(i).setFap_resume_crr_ins_id(user_id);
					resumeCareer.getResumeCareerList().get(i).setFap_resume_crr_udt_id(user_id);
				}
				sfuMapper.insert_resume_career(resumeCareer);
			}
			if(resumeProject.getResumeProjectList() != null){
				for (int i = 0; i < resumeProject.getResumeProjectList().size(); i++) {
					resumeProject.getResumeProjectList().get(i).setFap_resume_seq(resumeForm.getFap_resume_seq());
					resumeProject.getResumeProjectList().get(i).setFap_resume_project_ins_id(user_id);
					resumeProject.getResumeProjectList().get(i).setFap_resume_project_udt_id(user_id);
				}
				sfuMapper.insert_resume_project(resumeProject);
			}
			if (resumeTalent.getResumeTalentList() != null) {
				for (int i = 0; i < resumeTalent.getResumeTalentList().size(); i++) {
					resumeTalent.getResumeTalentList().get(i).setFap_resume_seq(resumeForm.getFap_resume_seq());
					resumeTalent.getResumeTalentList().get(i).setFap_resume_talent_ins_id(user_id);
					resumeTalent.getResumeTalentList().get(i).setFap_resume_talent_udt_id(user_id);
				}
				sfuMapper.insert_resume_talent(resumeTalent);
			}
			if(resumeProfile.getResumeProfileList() != null) {
				for (int i = 0; i < resumeProfile.getResumeProfileList().size(); i++) {
					resumeProfile.getResumeProfileList().get(i).setFap_resume_seq(resumeForm.getFap_resume_seq());
					resumeProfile.getResumeProfileList().get(i).setFap_resume_pr_ins_id(user_id);
					resumeProfile.getResumeProfileList().get(i).setFap_resume_pr_udt_id(user_id);
				}
				sfuMapper.insert_resume_profile(resumeProfile);
			}
			if(resumeAddr.getResumeAddrList() != null){
				for (int i = 0; i < resumeAddr.getResumeAddrList().size(); i++) {
					resumeAddr.getResumeAddrList().get(i).setFap_resume_seq(resumeForm.getFap_resume_seq());
					resumeAddr.getResumeAddrList().get(i).setFap_resume_address_ins_id(user_id);
					resumeAddr.getResumeAddrList().get(i).setFap_resume_address_udt_id(user_id);
				}
				sfuMapper.insert_resume_addr(resumeAddr);
			}
			if(resumeName.getResumeNameList() != null){
				for (int i = 0; i < resumeName.getResumeNameList().size(); i++) {
					resumeName.getResumeNameList().get(i).setFap_resume_seq(resumeForm.getFap_resume_seq());
					resumeName.getResumeNameList().get(i).setFap_resume_nm_ins_id(user_id);
					resumeName.getResumeNameList().get(i).setFap_resume_nm_udt_id(user_id);
				}
				sfuMapper.insert_resume_name(resumeName);
			}
			if (resumeFile.getResumeFileList() != null) {
				for (int i = 0; i < resumeFile.getResumeFileList().size(); i++) {
					resumeFile.getResumeFileList().get(i).setFap_resume_seq(resumeForm.getFap_resume_seq());
					resumeFile.getResumeFileList().get(i).setFap_resume_file_ins_id(user_id);
					resumeFile.getResumeFileList().get(i).setFap_resume_file_udt_id(user_id);
				}
				sfuMapper.insert_resume_file(resumeFile);
			}
		logger.debug("이력서 전체 정보 등록 DAO 완료");
	}

	/**
	 * @Method Name : select_my_resume_list
	 * @Date : 2018. 12. 18.
	 * @User : 남유송
	 * @Param : user_id
	 * @Return : 이력서 기본정보
	 * @Method 설명 : 이력서 기본 정보 리스트 출력
	 */
	public ArrayList<HashMap<String, Object>> select_my_resume_list(String user_id) {
		logger.debug("이력서 기본 정보 리스트 출력 시작");
		ArrayList<HashMap<String, Object>> resumeFormList = null;
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		resumeFormList= sfuMapper.select_my_resume_list(user_id);		
		logger.debug("이력서 기본 정보 리스트 출력 완료");
		return resumeFormList;
	}
	
	/**
	 * @Method Name : select_my_resume_available_list
	 * @Date : 2019. 4. 4.
	 * @User : 이종호
	 * @Param : user_id,jobfair_seq
	 * @Return : 지원가능한 이력서 기본 정보 객체 리스트
	 * @Method 설명 : 지원페이지에서 이력서 리스트 출력
	 */
	public ArrayList<HashMap<String, Object>> select_my_resume_available_list(HashMap<String, Object> paramMap){
		logger.debug("지원페이지에서 이력서 리스트 출력 DAO 시작");
		ArrayList<HashMap<String, Object>> resumeFormList = null;
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		resumeFormList= sfuMapper.select_my_resume_available_list(paramMap);		
		logger.debug("지원페이지에서 이력서 리스트 출력 DAO 완료");
		return resumeFormList;
	}

	/**
	 * @Method Name : search_job_advertisement_list
	 * @Date : 2018. 12. 20.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : SocietyFapUserJobAdvertisementList
	 * @Method 설명 : FAP 채용공고 상세검색
	 */
	public ArrayList<HashMap<String, Object>> search_job_advertisement_list(HashMap<String, Object> selectedCompanyInfoMap){
		logger.debug("FAP 채용공고 상세검색 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> jobAdvertisementList = sfuMapper.search_job_advertisement_list(selectedCompanyInfoMap);
		logger.debug("FAP 채용공고 상세검색 DAO 종료");
		return jobAdvertisementList;
	}
	
	/**
	 * @Method Name : selectResumeApply
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (기본정보)
	 */
	public HashMap<String, Object> selectResumeApplyBasic(HashMap<String, Object> param) {
		logger.debug("FAP 이력서 정보 조회 (기본정보)  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		logger.debug("FAP 이력서 정보 조회 (기본정보) DAO 종료");
		return sfuMapper.selectResumeApplyBasic(param);
	}
	
	/**
	 * @Method Name : selectResumeApplyEduhistory
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (학력정보)
	 */
	public ArrayList<HashMap<String, Object>> selectResumeApplyEduhistory(HashMap<String, Object> param){
		logger.debug("FAP 이력서 정보 조회 (학력정보)  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		logger.debug("FAP 이력서 정보 조회 (학력정보) DAO 종료");
		return sfuMapper.selectResumeApplyEduhistory(param);
	}
	
	/**
	 * @Method Name : selectResumeApplyLicense
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (자격증정보)
	 */
	public ArrayList<HashMap<String, Object>> selectResumeApplyLicense(HashMap<String, Object> param){
		logger.debug("FAP 이력서 정보 조회 (자격증정보)  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		logger.debug("FAP 이력서 정보 조회 (자격증정보) DAO 종료");
		return sfuMapper.selectResumeApplyLicense(param);
	}
	
	/**
	 * @Method Name : selectResumeApplyCareer
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (경력정보)
	 */
	public ArrayList<HashMap<String, Object>> selectResumeApplyCareer(HashMap<String, Object> param){
		logger.debug("FAP 이력서 정보 조회 (경력정보)  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		logger.debug("FAP 이력서 정보 조회 (경력정보) DAO 종료");
		return sfuMapper.selectResumeApplyCareer(param);
	}
	
	/**
	 * @Method Name : selectResumeApplyProject
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (프로젝트정보)
	 */
	public ArrayList<HashMap<String, Object>> selectResumeApplyProject(HashMap<String, Object> param){
		logger.debug("FAP 이력서 정보 조회 (프로젝트정보)  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		logger.debug("FAP 이력서 정보 조회 (프로젝트정보) DAO 종료");
		return sfuMapper.selectResumeApplyProject(param);
	}
	
	/**
	 * @Method Name : selectResumeApplyTalent
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (역량재능정보)
	 */
	public ArrayList<HashMap<String, Object>> selectResumeApplyTalent(HashMap<String, Object> param){
		logger.debug("FAP 이력서 정보 조회 (역량재능정보)  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		logger.debug("FAP 이력서 정보 조회 (역량재능정보) DAO 종료");
		return sfuMapper.selectResumeApplyTalent(param);
	}
	
	/**
	 * @Method Name : selectResumeApplyProfile
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (자기소개정보)
	 */
	public ArrayList<HashMap<String, Object>> selectResumeApplyProfile(HashMap<String, Object> param){
		logger.debug("FAP 이력서 정보 조회 (자기소개정보)  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		logger.debug("FAP 이력서 정보 조회 (자기소개정보) DAO 종료");
		return sfuMapper.selectResumeApplyProfile(param);
	}
	
	/**
	 * @Method Name : selectResumeApplyAddress
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (주소정보)
	 */
	public ArrayList<HashMap<String, Object>> selectResumeApplyAddress(HashMap<String, Object> param){
		logger.debug("FAP 이력서 정보 조회 (주소정보)  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		logger.debug("FAP 이력서 정보 조회 (주소정보) DAO 종료");
		return sfuMapper.selectResumeApplyAddress(param);
	}
	
	/**
	 * @Method Name : selectResumeApplyName
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (이름정보)
	 */
	public ArrayList<HashMap<String, Object>> selectResumeApplyName(HashMap<String, Object> param){
		logger.debug("FAP 이력서 정보 조회 (이름정보)  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		logger.debug("FAP 이력서 정보 조회 (이름정보) DAO 종료");
		return sfuMapper.selectResumeApplyName(param);
	}
	
	/**
	 * @Method Name : selectResumeApplyFile
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 이력서 정보 조회 (파일정보)
	 */
	public ArrayList<HashMap<String, Object>> selectResumeApplyFile(HashMap<String, Object> param){
		logger.debug("FAP 이력서 정보 조회 (파일정보)  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		logger.debug("FAP 이력서 정보 조회 (파일정보) DAO 종료");
		return sfuMapper.selectResumeApplyFile(param);
	}
	
	/**
	 * @Method Name : selectFapOpened
	 * @Date : 2020. 10. 07.
	 * @User : 양승균
	 * @Param : HashMap
	 * @Return : ArrayList
	 * @Method 설명 : FAP 지원 과정/기수 조회
	 */
	public ArrayList<HashMap<String, Object>> selectFapOpened(HashMap<String, Object> param) {
		logger.debug("FAP 지원 과정/기수 조회  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		logger.debug("FAP 지원 과정/기수 조회  DAO 종료");
		return sfuMapper.selectFapOpened(param);
	}
	
	/**
	 * @Method Name : selectScoreList
	 * @Date : 2020. 10. 05.
	 * @User : 김성미
	 * @Param : HashMap
	 * @Return : ArrayList
	 * @Method 설명 : FAP 지원자 성적표 조회
	 */
	public ArrayList<HashMap<String, Object>> selectScoreList(HashMap<String, Object> param) {
		logger.debug("FAP 지원자 성적표 조회  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		logger.debug("FAP 지원자 성적표 조회  DAO 종료");
		return sfuMapper.selectScoreList(param);
	}
	
	/**
	 * @Method Name : company_scale_statistics
	 * @Date : 2018. 12. 24.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMap
	 * @Method 설명 : FAP 채용공고 기업규모별 상세통계
	 */
	public HashMap<String, Object> company_scale_statistics(HashMap<String, Object> jobAdvertisementInfoMap){
		logger.debug("FAP 채용공고 기업 규모별 상세통계 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		HashMap<String, Object> companyScaleStatistics = sfuMapper.company_scale_statistics(jobAdvertisementInfoMap);
		logger.debug("FAP 채용공고 기업 규모별 상세통계 DAO 종료");
		return companyScaleStatistics;
	}
	
	/**
	 * @Method Name : delete_user_info
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 탈퇴할 회원 객체
	 * @Return : -
	 * @Method 설명 : 회원 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(30글자) 변경후 참조 테이블에 적용
	 */
	public int delete_user_info(User user){
		logger.info("FAP 회원 탈퇴 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		// 중복되기 어려운 임의의값 생성
		
		//비밀번호 체크
		User select_user = sfuMapper.select_com_user(user.getUser_id());	
			try {
					// 비밀번호가 일치하지 않을 경우				입력	 	불러온거
				if(!passwordEncoder.matches(user.getUser_pw(), select_user.getUser_pw())){
						return 0;
				}
			}catch (NullPointerException e){
					//일치하는 아이디가 없어서 예외 발생할 때 처리부분
					return 0;
			}
				
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
		int result=sfuMapper.delete_user_info(updateMap);
		logger.info("FAP 회원 탈퇴 DAO 종료");
		
		return result;
	}

	/**
	 * @Method Name : select_files
	 * @Date : 2018. 12. 26.
	 * @User : 남유송
	 * @Param : 이력서 일련번호
	 * @Return : String(이력서 저장 파일 이름)
	 * @Method 설명 : FAP 이력서 파일 저장 이름 리스트 출력
	 */
	public ArrayList<HashMap<String, Object>> select_files(HashMap<String, Object> param) {
		logger.debug("FAP 이력서 파일 리스트 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> deletedFiles = sfuMapper.select_files(param);
		logger.debug("FAP 이력서 파일 리스트 DAO 종료");
		return deletedFiles;
	}
	
	/**
	 * @Method Name : select_company_name_and_apply_rank
	 * @Date : 2018. 12. 27.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMap
	 * @Method 설명 : FAP 취업지업자 회사명 및 지원가능 지망 수 셀렉트
	 */
	public HashMap<String, Object> select_company_name_and_apply_count(HashMap<String, Object> advertisementInfoMap){
		logger.debug("FAP 취업지업자 회사명 및 지원가능 지망 셀렉트 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		HashMap<String, Object> applyInfo = sfuMapper.select_company_name_and_apply_count(advertisementInfoMap);
		logger.debug("FAP 취업지업자 회사명 및 지원가능 지망 셀렉트 DAO 종료");
		return applyInfo;
	}
	
	/**
	 * @Method Name : select_company_apply_info_rank
	 * @Date : 2018. 12. 27.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Integer
	 * @Method 설명 : FAP 취업지업자 지망순위 셀렉트
	 */
	public ArrayList<Integer> select_company_apply_info_rank(HashMap<String, Object> advertisementInfoMap){
		logger.debug("FAP 취업지업자 지망순위 셀렉트 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<Integer> appInfoRankList = sfuMapper.select_company_apply_info_rank(advertisementInfoMap);
		logger.debug("FAP 취업지업자 지망순위 셀렉트 DAO 종료");
		return appInfoRankList;
	}
	
	/**
	 * @Method Name : select_user_apply_count
	 * @Date : 2018. 12. 28.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지업자 채용공고지원정보 테이블에 해당 유저아이디가 있는지 여부 판별
	 */
	public int select_user_apply_count(HashMap<String, Object> advertisementInfoMap){
		logger.debug("FAP 취업지업자 채용공고지원정보 테이블에 해당 유저아이디가 있는지 여부 판별 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int userApplyCount = sfuMapper.select_user_apply_count(advertisementInfoMap);
		logger.debug("FAP 취업지업자 채용공고지원정보 테이블에 해당 유저아이디가 있는지 여부 판별 DAO 종료");
		return userApplyCount;
	}
	 
	
	/**
	 * @Method Name : select_current_jobfair_count
	 * @Date : 2018. 12. 28.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 잡페어 세부테이블에 설정된 디폴트 지망 개수 셀렉트
	 */
	public int select_current_jobfair_count(HashMap<String, Object> advertisementInfoMap){
		logger.debug("FAP 취업지원자 잡페어 세부테이블에 설정된 디폴트 지망 개수 셀렉트 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int currentJobFairCount = sfuMapper.select_current_jobfair_count(advertisementInfoMap);
		logger.debug("FAP 취업지원자 잡페어 세부테이블에 설정된 디폴트 지망 개수 셀렉트 DAO 종료");
		return currentJobFairCount;
	}
	
	/**
	 * @Method Name : select_user_apply_fixed_count
	 * @Date : 2018. 12. 28.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 잡페어별 유저 지망개수 테이블에 지정된 지망 개수 셀렉트
	 */
	public int select_user_apply_fixed_count(HashMap<String, Object> advertisementInfoMap){
		logger.debug("FAP 취업지원자 잡페어별 유저 지망개수 테이블에 지정된 지망개수 셀렉트 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int currentJobFairCount = sfuMapper.select_user_apply_fixed_count(advertisementInfoMap);
		logger.debug("FAP 취업지원자 잡페어별 유저 지망개수 테이블에 지정된 지망개수 셀렉트 DAO 종료");
		return currentJobFairCount;
	}
	
	/**
	 * @Method Name : apply_insert_this_job_advertisement
	 * @Date : 2018. 12. 31.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 해당 채용공고에 지원하기(최초지원 시)
	 */
	public int apply_insert_this_job_advertisement(HashMap<String, Object> applyJobAdvertisementInfo) {
		logger.debug("FAP 채용지원자 해당 채용공고에 지원하기(최초지원 시) DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int insertResultCount = sfuMapper.apply_insert_this_job_advertisement(applyJobAdvertisementInfo);
		logger.debug("FAP 채용지원자 해당 채용공고에 지원하기(최초지원 시) DAO 종료");
		return insertResultCount;
	}
	
	/**
	 * @Method Name : apply_update_this_job_advertisement
	 * @Date : 2018. 12. 31.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 해당 채용공고에 지원하기(추가지원 시)
	 */
	public int apply_update_this_job_advertisement(HashMap<String, Object> applyJobAdvertisementInfo) {
		logger.debug("FAP 채용지원자 해당 채용공고에 지원하기(추가지원 시) DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int updateResultCount = sfuMapper.apply_update_this_job_advertisement(applyJobAdvertisementInfo);
		logger.debug("FAP 채용지원자 해당 채용공고에 지원하기(추가지원 시) DAO 종료");
		return updateResultCount;
	}
	
	/**
	 * @Method Name : apply_second_this_job_advertisement
	 * @Date : 2018. 12. 31.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : -
	 * @Method 설명 : FAP 취업지원자 해당 채용공고에 지원하기 두번째 스탭
	 */
	public void apply_second_this_job_advertisement(HashMap<String, Object> applyJobAdvertisementInfo) {
		logger.debug("FAP 채용지원자 해당 채용공고에 지원하기 Second DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		sfuMapper.apply_second_this_job_advertisement(applyJobAdvertisementInfo);
		logger.debug("FAP 채용지원자 해당 채용공고에 지원하기 Second DAO 끝");
	}
	
	/**
	 * @Method Name : apply_job_advertisement_duplicate_check
	 * @Date : 2018. 12. 31.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 채용공고 중복지원 여부 체크
	 */
	public int apply_job_advertisement_duplicate_check(HashMap<String, Object> applyDuplicateCheckInfo){
		logger.debug("FAP 채용공고 중복지원 여부 체크 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int duplicateCount = sfuMapper.apply_job_advertisement_duplicate_check(applyDuplicateCheckInfo);
		logger.debug("FAP 채용공고 중복지원 여부 체크 DAO 끝");
		return duplicateCount;
	}
	
	/**
	 * @Method Name : select_jobfair_job_advertisement
	 * @Date : 2018. 12. 14.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMap
	 * @Method 설명 : FAP 취업지원자 채용공고 셀렉트(채용공고 읽기)
	 */
	public HashMap<String, Object> select_jobfair_job_advertisement(HashMap<String, Object> fapJobAdvertisement){
		logger.debug("FAP 취업지원자 채용공고 정보 리스트 출력 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		HashMap<String, Object> jobAdvertisement = sfuMapper.select_jobfair_job_advertisement(fapJobAdvertisement);
		logger.debug("FAP 취업지원자 채용공고 정보 리스트 출력 DAO 종료");
		return jobAdvertisement;
	}
	
	/**
	 * @Method Name : select_fap_jobfair_applicable_time
	 * @Date : 2019. 1. 3.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 취업지원자 채용공고 지원가능한지 여부를 판단
	 */
	public String select_fap_jobfair_applicable_time(HashMap<String, Object> fapJobAdvertisement){
		logger.debug("FAP 취업지원자 채용공고 지원가능한지 여부를 판단 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		String applicableTimeFirst = sfuMapper.select_fap_jobfair_applicable_time(fapJobAdvertisement);
		logger.debug("FAP 취업지원자 채용공고 지원가능한지 여부를 판단 DAO 종료");
		return applicableTimeFirst;
	}
	
	/**
	 * @Method Name : select_jobfair_apply_rule_gb
	 * @Date : 2019. 8. 9.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 채용공고별 지원룰 적용여부(공통코드)
	 * @Method 설명 : 취업지원자 채용공고 지원 가능 여부 판단
	 */
	public String select_jobfair_apply_rule_gb(HashMap<String, Object> fapJobAdvertisement) {
		logger.info("FAP 취업지원자 채용공고 지원 가능 여부 판단 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		String fap_jobfair_apply_rule_gb = sfuMapper.select_jobfair_apply_rule_gb(fapJobAdvertisement);
		logger.info("FAP 취업지원자 채용공고 지원 가능 여부 판단 DAO 종료");
		return fap_jobfair_apply_rule_gb;
	}
	
	/**
	 * @Method Name : select_fap_jobfair_applicable_is_first
	 * @Date : 2019. 1. 3.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Long
	 * @Method 설명 : FAP 취업지원자 채용공고 지원허가의 최초여부를 판단
	 */
	public long select_fap_jobfair_applicable_is_first(HashMap<String, Object> fapJobAdvertisement){
		logger.debug("FAP 취업지원자 채용공고 지원허가의 최초여부를 판단 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		long applicableJobAdSeq = sfuMapper.select_fap_jobfair_applicable_is_first(fapJobAdvertisement);
		logger.debug("FAP 취업지원자 채용공고 지원허가의 최초여부를 판단 DAO 종료");
		return applicableJobAdSeq;
	}
	
	/**
	 * @Method Name : apply_job_advertisement_quarter_check
	 * @Date : 2019. 1. 4.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 채용공고 지원할 지망개수 보유하고 있는지 여부 판단
	 */
	public int apply_job_advertisement_quarter_check(HashMap<String, Object> applyApplicableCheckInfo){
		logger.debug("FAP 취업지원자 채용공고 지원할 지망개수 보유하고 있는지 여부 판단 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int quarterCount = sfuMapper.apply_job_advertisement_quarter_check(applyApplicableCheckInfo);
		logger.debug("FAP 취업지원자 채용공고 지원할 지망개수 보유하고 있는지 여부 판단 DAO 종료");
		return quarterCount;
	}
	
	/**
	 * @Method Name : apply_job_advertisement_time_check
	 * @Date : 2019. 1. 4.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 채용공고 지원할 지망개수 보유하고 있는지 여부 판단
	 */
	public int apply_job_advertisement_time_check(HashMap<String, Object> applyApplicableCheckInfo){
		logger.debug("FAP 취업지원자 채용공고 지원가능한 시간여부 판단 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int applicableTimeCount = sfuMapper.apply_job_advertisement_time_check(applyApplicableCheckInfo);
		logger.debug("FAP 취업지원자 채용공고 지원가능한 시간여부 판단 DAO 종료");
		return applicableTimeCount;
	}

	/**
	 * @Method Name : resume_delete
	 * @Date : 2019.01.07
	 * @User : 남유송
	 * @Param : 이력서 정보(학력/관련 교육이수, 사회 경력, 프로젝트 개발 경력, 자격, 역량/재능, PR, 포트폴리오 파일)
	 * @Return : -
	 * @Method 설명 : 이력서 전체 정보 삭제
	 */
	
	public void delete_resume(long fap_resume_seq) {
		logger.debug("FAP 이력서 전체 삭제 Service 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		sfuMapper.delete_resume_eduHistory(fap_resume_seq);
		sfuMapper.delete_resume_license(fap_resume_seq);
		sfuMapper.delete_resume_career(fap_resume_seq);
		sfuMapper.delete_resume_project(fap_resume_seq);
		sfuMapper.delete_resume_talent(fap_resume_seq);
		sfuMapper.delete_resume_profile(fap_resume_seq);
		sfuMapper.delete_resume_addr(fap_resume_seq);
		sfuMapper.delete_resume_name(fap_resume_seq);
		sfuMapper.delete_resume_file(fap_resume_seq);
		logger.debug("FAP 이력서 전체 삭제 Service 종료");
	}

	/**
	 * @Method Name : delete_my_resume
	 * @Date : 2018. 12. 18.
	 * @User : 남유송
	 * @Param : fap_resume_seq
	 * @Return : 
	 * @Method 설명 : 이력서 정보 삭제
	 */
	public void delete_my_resume(HashMap<String, Object> param) {
		logger.debug("이력서 정보 삭제 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		sfuMapper.delete_my_resume(param);		
		logger.debug("이력서 정보 삭제 완료");	
	}

	/**
	 * @Method Name : search_nominated_company_list
	 * @Date : 2019. 1. 8.
	 * @User : 신동철
	 * @Param : 회원 아이디
	 * @Return : 내정받은 회사 리스트
	 * @Method 설명 : FAP 취업지원자 채용공고 지원할 지망개수 보유하고 있는지 여부 판단
	 */
	public ArrayList<HashMap<String, Object>> search_nominated_company_list(String user_id){
		logger.debug("FAP 취업지원자 내정기업 리스트 검색 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> nominated_company_list = sfuMapper.search_nominated_company_list(user_id);
		logger.debug("FAP 취업지원자 내정기업 리스트 검색 DAO 종료");
		return nominated_company_list;
	}
	
	/**
	 * @Method Name : insert_user_required_doc
	 * @Date : 2019. 1. 8.
	 * @User : 신동철
	 * @Param : 내정자 내정서류 정보
	 * @Return : -
	 * @Method 설명 : 내정자 내정서류를 등록하는 함수
	 */
	public int insert_user_required_doc(SocietyFapPersonalRequiredDoc user_required_doc){
		logger.info("FAP 내정자 내정서류 등록 DAO 시작");
		
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int result = sfuMapper.insert_user_required_doc(user_required_doc);
		
		logger.info("FAP 내정자 내정서류 등록 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_user_flag
	 * @Date : 2019. 1. 8.
	 * @User : 신동철
	 * @Param : 회원 아이디
	 * @Return : -
	 * @Method 설명 : 회원 권한을 검색하는 함수
	 */
	public String select_user_flag(String user_id){
		logger.info("FAP 회원 권한 검색 DAO 시작");
		
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		String user_flag = sfuMapper.select_user_flag(user_id);
		
		logger.info("FAP 회원 권한 검색 DAO 종료");
		return user_flag;
	}

	/**
	 * @Method Name : resume_deletable_check
	 * @Date : 2019. 1. 9.
	 * @User : 남유송
	 * @Param : int(이력서 일련번호)
	 * @Return : int
	 * @Method 설명 : 지원된 이력서를 삭제 못하도록 이력서가 이미 지원되어있는지 여부 검사
	 */
	public int select_undeletable_resume(int fap_resume_seq) {
		logger.info("지원된 이력서 검색 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int resume_deletable_check = sfuMapper.select_undeletable_resume(fap_resume_seq);
		logger.info("지원된 이력서 검색 DAO 종료");
		return resume_deletable_check;
	}
	
	/**
	 * @Method Name : select_approval_after_personal_apply_status_list
	 * @Date : 2019. 1. 15.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 승인된 개인지원현황 리스트 출력
	 */
	public ArrayList<HashMap<String, Object>> select_approval_after_personal_apply_status_list(HashMap<String, Object> userInfoMap){
		logger.debug("FAP 취업지원자 승인된 개인지원현황 리스트 출력 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> approvalAfterpersonalApplyStatusList = sfuMapper.select_approval_after_personal_apply_status_list(userInfoMap);
		logger.debug("FAP 취업지원자 승인된 개인지원현황 리스트 출력 DAO 종료");
		return approvalAfterpersonalApplyStatusList;
	}
	
	/**
	 * @Method Name : select_approval_before_personal_apply_status_list
	 * @Date : 2019. 1. 15.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 승인 전 개인지원현황 리스트 출력
	 */
	public ArrayList<HashMap<String, Object>> select_approval_before_personal_apply_status_list(HashMap<String, Object> userInfoMap){
		logger.debug("FAP 취업지원자 승인 전 개인지원현황 리스트 출력 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> approvalBeforePersonalApplyStatusList = sfuMapper.select_approval_before_personal_apply_status_list(userInfoMap);
		logger.debug("FAP 취업지원자 승인 전 개인지원현황 리스트 출력 DAO 종료");
		return approvalBeforePersonalApplyStatusList;
	}
	
	/**
	 * @Method Name : select_user_recruit_pcs_sch
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 회원아이디
	 * @Return : 취업지원자 전형일정 스케줄
	 * @Method 설명 : 취업지원자 전형일정 스케줄 검색
	 */
	public ArrayList<HashMap<String, Object>> select_user_recruit_pcs_sch(String user_id){
		logger.info("취업지원자 전형일정 스케줄 검색 DAO 시작");
		
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> user_recruit_pcs_sch = sfuMapper.select_user_recruit_pcs_sch(user_id);
		
		logger.info("취업지원자 전형일정 스케줄 검색 DAO 종료");
		return user_recruit_pcs_sch;
	}
	
	/**
	 * @Method Name : select_user_review_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 취업지원자 서류전형 시퀀스
	 * @Return : 취업지원자 서류전형 정보
	 * @Method 설명 : 취업지원자 서류전형 정보 검색
	 */
	public HashMap<String, Object> select_user_review_pcs(long fap_job_recruit_pcs_seq){
		logger.info("취업지원자 서류전형 정보 DAO 시작");
		
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		HashMap<String, Object> user_review_pcs_info = sfuMapper.select_user_review_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("취업지원자 서류전형 정보 DAO 종료");
		return user_review_pcs_info;
	}
	
	/**
	 * @Method Name : select_user_exam_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 취업지원자 시험전형 시퀀스
	 * @Return : 취업지원자 시험전형 정보
	 * @Method 설명 : 취업지원자 시험전형 정보 검색
	 */
	public HashMap<String, Object> select_user_exam_pcs(long fap_job_recruit_pcs_seq){
		logger.info("취업지원자 시험전형 정보 DAO 시작");
		
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		HashMap<String, Object> user_exam_pcs_info = sfuMapper.select_user_exam_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("취업지원자 시험전형 정보 DAO 종료");
		return user_exam_pcs_info;
	}
	
	/**
	 * @Method Name : select_user_itv_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 취업지원자 면접전형 시퀀스
	 * @Return : 취업지원자 면접전형 정보
	 * @Method 설명 : 취업지원자 면접전형 정보 검색
	 */
	public HashMap<String, Object> select_user_itv_pcs(long fap_job_recruit_pcs_seq){
		logger.info("취업지원자 면접전형 정보 DAO 시작");
		
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		HashMap<String, Object> user_itv_pcs_info = sfuMapper.select_user_itv_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("취업지원자 면접전형 정보 DAO 종료");
		return user_itv_pcs_info;
	}
	
	/**
	 * @Method Name : select_user_test_etc_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 취업지원자 기타전형 시퀀스
	 * @Return : 취업지원자 기타전형 정보
	 * @Method 설명 : 취업지원자 기타전형 정보 검색
	 */
	public HashMap<String, Object> select_user_test_etc_pcs(long fap_job_recruit_pcs_seq){
		logger.info("취업지원자 기타전형 정보 DAO 시작");
		
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		HashMap<String, Object> user_test_etc_pcs_info = sfuMapper.select_user_test_etc_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("취업지원자 기타전형 정보 DAO 종료");
		return user_test_etc_pcs_info;
	}
	
	/**
	 * @Method Name : select_per_ad_apply_info
	 * @Date : 2019. 1. 17.
	 * @User : 정대영
	 * @Param : LinkedHashMap
	 * @Return : LinkedHashMap
	 * @Method 설명 : FAP 취업지원자 채용공고 별 지원인원 및 지원가능인원 정보 조회
	 */
	public ArrayList<LinkedHashMap<String, Object>> select_per_ad_apply_info(HashMap<String, Object> userPerApplyStatusInfoParamMap){
		logger.debug("FAP 취업지원자 채용공고 별 지원인원 및 지원가능인원 정보 조회 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<LinkedHashMap<String, Object>> adPerQuarterMapList = sfuMapper.select_per_ad_apply_info(userPerApplyStatusInfoParamMap);
		logger.debug("FAP 취업지원자 채용공고 별 지원인원 및 지원가능인원 정보 조회 DAO 종료");
		return adPerQuarterMapList;
	}
	
	/**
	 * @Method Name : delete_current_apply_info
	 * @Date : 2019. 1. 18.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 승인 전 지원정보 삭제
	 */
	public int delete_current_apply_info(HashMap<String, Object> userInfoMap){
		logger.debug("FAP 취업지원자 승인 전 지원정보 삭제 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int deleteResult = sfuMapper.delete_current_apply_info(userInfoMap);
		logger.debug("FAP 취업지원자 승인 전 지원정보 삭제 DAO 종료");
		return deleteResult;
	}
	
	/**
	 * @Method Name : minus_quarter_after_apply_cancel
	 * @Date : 2019. 1. 21.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 승인 전 지원정보 삭제 후 쿼터 회복
	 */
	public int minus_quarter_after_apply_cancel(HashMap<String, Object> userInfoMap){
		logger.debug("FAP 취업지원자 승인 전 지원정보 삭제 후 쿼터 회복 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int resultCount = sfuMapper.minus_quarter_after_apply_cancel(userInfoMap);
		logger.debug("FAP 취업지원자 승인 전 지원정보 삭제 후 쿼터 회복 DAO 종료");
		return resultCount;
	}
	
	/**
	 * @Method Name : select_fap_user_jobfair_per_user_info_list
	 * @Date : 2019. 2. 13.
	 * @User : 정대영
	 * @Param : String
	 * @Return : HashMapList
	 * @Method 설명 : 통합잡페어 리스트(현재 세션아이디 참가중인지 판단)
	 */
	public ArrayList<HashMap<String, Object>> select_fap_user_jobfair_per_user_info_list(String user_id){
		logger.debug("FAP 취업지원자 통합잡페어 정보(현재 세션아이디 참가중인지 판단) 리스트 출력 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> jobfairInfoList = sfuMapper.select_fap_user_jobfair_per_user_info_list(user_id);
		logger.debug("FAP 취업지원자 통합잡페어 정보(현재 세션아이디 참가중인지 판단) 리스트 출력 DAO 종료");
		return jobfairInfoList;
	}
	
	/**
	 * @Method Name : select_fap_user_jobfair_divide_info_list
	 * @Date : 2019. 2. 14.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 해당잡페어 승인된 취업지원자 잡페어 세부선택 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_fap_user_jobfair_divide_info_list(HashMap<String, Object> params){
		logger.debug("FAP 취업지원자 해당잡페어 승인된 취업지원자 잡페어 세부선택 셀렉트 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> jobfairDivideInfoList = sfuMapper.select_fap_user_jobfair_divide_info_list(params);
		logger.debug("FAP 취업지원자 해당잡페어 승인된 취업지원자 잡페어 세부선택 셀렉트 DAO 종료");
		return jobfairDivideInfoList;
	}
	
	/**
	 * @Method Name : select_user_current_participation_jobfair_list
	 * @Date : 2019. 2. 15.
	 * @User : 정대영
	 * @Param : -
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 잡페어 선택 모달 눌렀을 때 해당아이디 잡페어 목록 요청
	 */
	public ArrayList<HashMap<String, Object>> select_user_current_participation_jobfair_list(String user_id){
		logger.debug("FAP 취업지원자 잡페어 선택 모달 눌렀을 때 해당아이디 잡페어 목록 요청  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> jobfairInfoList = sfuMapper.select_user_current_participation_jobfair_list(user_id);
		logger.debug("FAP 취업지원자 잡페어 선택 모달 눌렀을 때 해당아이디 잡페어 목록 요청  DAO 종료");
		return jobfairInfoList;
	}
	
	/**
	 * @Method Name : select_user_current_participation_jobfair_divide
	 * @Date : 2019. 2. 15.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 잡페어 선택 모달 눌렀을 때 해당아이디 잡페어 세부 목록 요청
	 */
	public ArrayList<HashMap<String, Object>> select_user_current_participation_jobfair_divide(HashMap<String, Object> params){
		logger.debug("FAP 취업지원자 잡페어 선택 모달 눌렀을 때 해당아이디 잡페어 세부 목록 요청 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> jobfairDivideInfoList = sfuMapper.select_user_current_participation_jobfair_divide(params);
		logger.debug("FAP 취업지원자 잡페어 선택 모달 눌렀을 때 해당아이디 잡페어 세부 목록 요청 DAO 종료");
		return jobfairDivideInfoList;
	}
	
	/**
	 * @Method Name : request_apply_info_rank_change
	 * @Date : 2019. 2. 20.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 취업지원자 개인지원현황 지망순위 변경 요청
	 */
	public int request_apply_info_rank_change(ArrayList<HashMap<String, Object>> appInfoMapAry){
		logger.debug("FAP 취업지원자 개인지원현황 지망순위 변경 요청 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int changeResult = sfuMapper.request_apply_info_rank_change(appInfoMapAry);
		logger.debug("FAP 취업지원자 개인지원현황 지망순위 변경 요청 DAO 종료");
		return changeResult;
	}
	
	/**
	 * @Method Name : select_per_user_before_apply_detail_info
	 * @Date : 2019. 2. 21.
	 * @User : 정대영
	 * @Param : Long
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 개인별 지원전 상세정보 요청
	 */
	public ArrayList<HashMap<String, Object>> select_per_user_before_apply_detail_info(long fap_job_app_info_seq){
		logger.debug("FAP 취업지원자 개인별 지원전 상세정보 요청 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> applyBeforeInfoMapList = sfuMapper.select_per_user_before_apply_detail_info(fap_job_app_info_seq);
		logger.debug("FAP 취업지원자 개인별 지원전 상세정보 요청 DAO 종료");
		return applyBeforeInfoMapList;
	}
	
	/**
	 * @Method Name : select_per_user_after_apply_detail_info
	 * @Date : 2019. 2. 21.
	 * @User : 정대영
	 * @Param : Long
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 개인별 지원후 상세정보 요청
	 */
	public ArrayList<HashMap<String, Object>> select_per_user_after_apply_detail_info(long fap_job_app_info_seq){
		logger.debug("FAP 취업지원자 개인별 지원후 상세정보 요청 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> applyAfterInfoMapList = sfuMapper.select_per_user_after_apply_detail_info(fap_job_app_info_seq);
		logger.debug("FAP 취업지원자 개인별 지원후 상세정보 요청 DAO 종료");
		return applyAfterInfoMapList;
	}
	
	/**
	 * @Method Name : select_current_company_rank_info
	 * @Date : 2019. 2. 26.
	 * @User : 정대영
	 * @Param : Long
	 * @Return : ArrayList
	 * @Method 설명 : FAP 취업지원자 기업별 지망순위 별 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_current_company_rank_info(long fap_job_ad_seq){
		logger.debug("FAP 취업지원자 기업별 지망순위 별 셀렉트 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> companyPerApplyRankInfoList = sfuMapper.select_current_company_rank_info(fap_job_ad_seq);
		logger.debug("FAP 취업지원자 기업별 지망순위 별 셀렉트 DAO 종료");
		return companyPerApplyRankInfoList;
	}
	
	/**
	 * @Method Name : select_total_apply_status_detail_info
	 * @Date : 2019. 2. 26.
	 * @User : 정대영
	 * @Param : Long
	 * @Return : HashMap
	 * @Method 설명 : FAP 취업지원자 기업별 상세정보 요청
	 */
	public HashMap<String, Object> select_total_apply_status_detail_info(long fap_job_ad_seq){
		logger.debug("FAP 취업지원자 기업별 상세정보 요청 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		HashMap<String, Object> companyApplyInfo = sfuMapper.select_total_apply_status_detail_info(fap_job_ad_seq);
		logger.debug("FAP 취업지원자 기업별 상세정보 요청 DAO 종료");
		return companyApplyInfo;
	}
	
	/**
	 * @Method Name : select_komve
	 * @Date : 2019. 2. 22.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 교육기관명
	 * @Method 설명 : 등록된 교육기관을 불러오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_komve(){
		logger.info("FAP 교육기관 불러오기 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> kmove_list = sfuMapper.select_komve();
		logger.info("FAP 교육기관 불러오기 DAO 시작");
		return kmove_list;
	}
	
	/**
	 * @Method Name : check_user_personal
	 * @Date : 2019. 2. 22.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 유저 - 개인회원 연결 갯수(0 또는 1)
	 * @Method 설명 : 개인 회원 테이블이 연결되어있는지 확인하는 함수
	 */
	public int check_user_personal(String user_id){
		logger.info("FAP 회원 연결 확인 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int result = sfuMapper.check_user_personal(user_id);
		logger.info("FAP 회원 연결 확인 DAO 종료");
		return result;
	}
	
	
	/**
	 * @Method Name : select_job_ad_total_application_status
	 * @Date : 2019. 2. 22.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 잡페어별 전체지원현황 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_job_ad_total_application_status(int fap_jobfair_divide_seq){
		logger.debug("FAP 취업지원자 잡페어별 전체지원현황 셀렉트 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> perJobfairTotalApplyList = sfuMapper.select_job_ad_total_application_status(fap_jobfair_divide_seq);
		logger.debug("FAP 취업지원자 잡페어별 전체지원현황 셀렉트 DAO 종료");
		return perJobfairTotalApplyList;
	}
	
	/**
	 * @Method Name : user_board_contents_search
	 * @Date : 2019. 3. 6.
	 * @User : 신동철
	 * @Param : 게시판 관리의 특정 게시판 정보 객체
	 * @Return : fap 공지사항 게시글 리스트
	 * @Method 설명 : 게시글 리스트를 가져오는 함수
	 */
	public ArrayList<BoardContent> user_board_contents_search(HashMap<String, Object> map){
		logger.info("FAP 공지사항 가져오기 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<BoardContent> notice_list = sfuMapper.user_board_contents_search(map);
		logger.info("FAP 공지사항 가져오기 DAO 종료");
		return notice_list;
	}
	
	/**
	 * @Method Name : board_contents_count
	 * @Date : 2019. 3. 6.
	 * @User : 신동철
	 * @Param : 게시판 관리의 특정 게시판 정보 객체
	 * @Return : fap 공지사항 게시판의 게시글 갯수
	 * @Method 설명 : 페이징을 위한 전체글 갯수 조회하는 함수
	 */
	public int board_contents_count(HashMap<String, Object> map){
		logger.info("FAP 공지사항 게시글 갯수 가져오기 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int count = sfuMapper.board_contents_count(map);
		logger.info("FAP 공지사항 게시글 갯수 가져오기 DAO 시작");
		return count;
	}
	
	/**
	 * @Method Name : user_board_contents_list_search
	 * @Date : 2019. 3. 6.
	 * @User : 신동철
	 * @Param : 게시판 시퀀스
	 * @Return : 잡페어 지원자 공지사항 게시판 리스트
	 * @Method 설명 : 잡페어 지원자 공지사항 게시판 리스트 검색 함수
	 */
	public ArrayList<BoardContent> user_board_contents_list_search(HashMap<String, Object> map){
		logger.info("FAP 잡페어 지원자 공지사항 게시판 리스트 검색 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<BoardContent> notice_list = sfuMapper.user_board_contents_list_search(map);
		logger.info("FAP 잡페어 지원자 공지사항 게시판 리스트 검색 DAO 종료");
		return notice_list;
	}
	
	/**
	 * @Method Name : insert_job_qna_question
	 * @Date : 2019. 3. 8.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 질문 객체
	 * @Return : 
	 * @Method 설명 : 채용공고 Q&A 질문 등록
	 */
	public int insert_job_qna_question(SocietyFapQnaQuestion qna_q){
		logger.info("FAP 지원자 채용공고 Q&A 질문 등록 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int result = sfuMapper.insert_job_qna_question(qna_q);
		logger.info("FAP 지원자 채용공고 Q&A 질문 등록 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_job_qna
	 * @Date : 2019. 3. 5.
	 * @User : 원병호
	 * @Param : 채용공고 일련번호
	 * @Return : 채용공고 Q&A 리스트
	 * @Method 설명 : 해당 채용공고의 Q&A리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> select_job_qna(long fap_job_ad_seq){
		logger.info("FAP 채용전형 Q&A리스트 검색 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> result = sfuMapper.select_job_qna(fap_job_ad_seq);
		logger.info("FAP 채용전형  Q&A리스트 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_job_qna_one
	 * @Date : 2019. 3. 6.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 질문 일련번호
	 * @Return : 해당 Q&A의 질문, 답변 정보
	 * @Method 설명 : 해당 Q&A의 질문, 답변 정보 
	 */
	public HashMap<String, Object> select_job_qna_one(long fap_job_qna_question_seq){
		logger.info("FAP 채용전형 Q&A 상세  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		HashMap<String, Object> result = sfuMapper.select_job_qna_one(fap_job_qna_question_seq);
		logger.info("FAP 채용전형  Q&A 상세  DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : update_job_qna_question
	 * @Date : 2019. 3. 11.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 질문 객체
	 * @Return : 
	 * @Method 설명 : 사용자 채용공고 Q&A 질문 수정
	 */
	public void update_job_qna_question(SocietyFapQnaQuestion qna_q){
		logger.info("FAP 사용자 채용전형 Q&A 질문 수정  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		sfuMapper.update_job_qna_question(qna_q);
		logger.info("FAP 사용자 채용전형 Q&A 질문 수정  DAO 끝");
	}
	
	/**
	 * @Method Name : delete_job_qna_question
	 * @Date : 2019. 3. 11.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 질문 일련번호
	 * @Return : 
	 * @Method 설명 : 사용자 채용공고 Q&A 질문 삭제
	 */
	public void delete_job_qna_question(long fap_job_qna_question_seq){
		logger.info("FAP 사용자 채용전형 Q&A 질문 삭제  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		sfuMapper.delete_job_qna_question(fap_job_qna_question_seq);
		logger.info("FAP 사용자 채용전형 Q&A 질문 삭제  DAO 끝");
	}
	
	/**
	 * @Method Name : final_decision_time_select_today
	 * @Date : 2019. 3. 25.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : 오늘날짜를 포함한 최종확정 기간 정보
	 * @Method 설명 : 오늘날짜를 포함한 최종확정 기간 정보 조회
	 */
	public SocietyFapAdminFinalDecisionTime final_decision_time_select_today(int fap_jobfair_divide_seq) {
		logger.info("FAP 오늘날짜를 포함한 최종확정 기간 정보 조회  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		SocietyFapAdminFinalDecisionTime result = sfuMapper.final_decision_time_select_today(fap_jobfair_divide_seq);
		logger.info("FAP 오늘날짜를 포함한 최종확정 기간 정보 조회  DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : personal_apply_final_decision_no_one
	 * @Date : 2019. 3. 25.
	 * @User : 이종호
	 * @Param : 최종확정정보
	 * @Return : -
	 * @Method 설명 : 지원자 최종확정 결정 등록
	 */
	public void personal_apply_final_decision_update(HashMap<String, Object> paramMap) {
		logger.info("FAP 지원자 최종확정 결정 등록  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		sfuMapper.personal_apply_final_decision_update(paramMap);
		logger.info("FAP 지원자 최종확정 결정 등록  DAO 종료");
	}
	
	/**
	 * @Method Name : personal_apply_final_decision_select_count
	 * @Date : 2019. 3. 25.
	 * @User : 이종호
	 * @Param : 최종확정 정보
	 * @Return : 최종확정 개수
	 * @Method 설명 : 지원자 최종확정 개수 검색
	 */
	public int personal_apply_final_decision_select_count(HashMap<String, Object> paramMap) {
		logger.info("FAP 지원자 최종확정 일괄 포기 등록  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int result = sfuMapper.personal_apply_final_decision_select_count(paramMap);
		logger.info("FAP 지원자 최종확정 일괄 포기 등록  DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : final_decision_time_count_select
	 * @Date : 2019. 3. 27.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : -
	 * @Method 설명 : 지원자가 최종확정을 내린 기업이 있는지 조회
	 */
	public int final_decision_time_count_select(String user_id) {
		logger.info("FAP 지원자가 최종확정을 내린 기업이 있는지 조회  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int result = sfuMapper.final_decision_time_count_select(user_id);
		logger.info("FAP 지원자가 최종확정을 내린 기업이 있는지 조회  DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : open_pt_info_select
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 오픈잡페어 설명회 정보
	 * @Method 설명 : 노출된 오픈잡페어 설명회 정보 조회
	 */
	public SocietyFapOpenPt open_pt_info_select() {
		logger.info("FAP 노출된 오픈잡페어 설명회 정보 조회 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		SocietyFapOpenPt result = sfuMapper.open_pt_info_select();
		logger.info("FAP 노출된 오픈잡페어 설명회 정보 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : open_pt_edu_info_select
	 * @Date : 2019. 4. 15.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 오픈잡페어 구직자 교육 정보
	 * @Method 설명 : 노출된 오픈잡페어 구직자 교육 정보 조회
	 */
	public SocietyFapOpenPt open_pt_edu_info_select() {
		logger.info("FAP 노출된 오픈잡페어 구직자 교육 정보 조회 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		SocietyFapOpenPt result = sfuMapper.open_pt_edu_info_select();
		logger.info("FAP 노출된 오픈잡페어 구직자 교육 정보 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : open_pt_apply
	 * @Date : 2019. 4. 12.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 오픈잡페어 설명회 지원자 정보
	 * @Method 설명 : 오픈잡페어 설명회 지원자 신청
	 */
	public void open_pt_apply(SocietyFapOpenPtApply apply) {
		logger.info("FAP 오픈잡페어 설명회 지원자 신청 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		sfuMapper.open_pt_apply(apply);
		logger.info("FAP 오픈잡페어 설명회 지원자 신청 DAO 종료");
	}
	
	/**
	 * @Method Name : open_pt_edu_resume_apply
	 * @Date : 2019. 4. 15.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 지원자 이력서 정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 구직자 교육 지원자 이력서 신청
	 */
	public void open_pt_edu_resume_apply(SocietyFapOpenPtResume resume) {
		logger.info("FAP 오픈잡페어 구직자 교육 지원자 이력서 신청 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		sfuMapper.open_pt_edu_resume_apply(resume);
		logger.info("FAP 오픈잡페어 구직자 교육 지원자 이력서 신청 DAO 종료");
	}
	
	/**
	 * @Method Name : open_pt_apply_check
	 * @Date : 2019. 4. 12.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 정보
	 * @Return : 오픈잡페어 설명회 지원자 참가 횟수
	 * @Method 설명 : 오픈잡페어 설명회 지원자 신청 확인
	 */
	public int open_pt_apply_check(SocietyFapOpenPtApply apply) {
		logger.info("FAP 오픈잡페어 설명회 지원자 신청 확인 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int result = sfuMapper.open_pt_apply_check(apply);
		logger.info("FAP 오픈잡페어 설명회 지원자 신청 확인 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : open_pt_apply_cancel
	 * @Date : 2019. 4. 15.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 지원자 시퀀스
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 지원자 신청 취소
	 */
	public void open_pt_apply_cancel(int fap_open_pt_apply_seq) {
		logger.info("FAP 오픈잡페어 설명회 지원자 신청 취소 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		sfuMapper.open_pt_apply_cancel(fap_open_pt_apply_seq);
		logger.info("FAP 오픈잡페어 설명회 지원자 신청 취소 DAO 종료");
	}
	
	/**
	 * @Method Name : open_pt_apply_mypage_list
	 * @Date : 2019. 4. 12.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : 오픈잡페어 설명회 지원자 참가 내역
	 * @Method 설명 : 오픈잡페어 설명회 지원자 신청 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> user_open_pt_applied_list(String user_id){
		logger.info("FAP 오픈잡페어 설명회 지원자 신청 리스트 조회 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> result = sfuMapper.user_open_pt_applied_list(user_id);
		logger.info("FAP 오픈잡페어 설명회 지원자 신청 리스트 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : user_open_edu_applied_list
	 * @Date : 2019. 4. 12.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : 오픈잡페어 구직자교육 지원자 참가 내역
	 * @Method 설명 : 오픈잡페어 구직자교육 지원자 신청 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> user_open_edu_applied_list(String user_id){
		logger.info("FAP 오픈잡페어 구직자교육 지원자 신청 리스트 조회 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> result = sfuMapper.user_open_edu_applied_list(user_id);
		logger.info("FAP 오픈잡페어 구직자교육 지원자 신청 리스트 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : user_open_edu_resume_list_select
	 * @Date : 2019. 4. 15.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 지원자 아이디
	 * @Return : 오픈잡페어 구직자 교육 지원자 이력서 리스트
	 * @Method 설명 : 오픈잡페어 구직자 교육 지원자 이력서 리스트 조회
	 */
	public ArrayList<SocietyFapUserResumeForm> user_open_edu_resume_list_select(String user_id){
		logger.info("FAP 오픈잡페어 구직자 교육 지원자 이력서 리스트 조회 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<SocietyFapUserResumeForm> result = sfuMapper.user_open_edu_resume_list_select(user_id);
		logger.info("FAP 오픈잡페어 구직자 교육 지원자 이력서 리스트 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : user_popup_check
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : -
	 * @Return : FAP 노출 팝업 리스트
	 * @Method 설명 : FAP 노출 팝업 리스트 조회
	 */
	public ArrayList<SocietyFapPopup> user_popup_check(){
		logger.info("FAP 노출 팝업 리스트 조회 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<SocietyFapPopup> result = sfuMapper.user_popup_check();
		logger.info("FAP 노출 팝업 리스트 조회 DAO 종료");
		return result;
	}

	/**
	 * @Method Name : user_open_comp_banner_list
	 * @Date : 2019. 7. 17.
	 * @User : 김경아
	 * @Param :  회사아이디, 채용공고 시퀀스 
	 * @Return : 기업배너정보
	 * @Method 설명 : FAP 오픈잡페어 지원자 메인페이지 기업배너 리스트 조회 
	 */
	public List<HashMap<String, Object>> user_open_comp_banner_list(HashMap<String,Object> paramMap) {
		logger.info("FAP 오픈잡페어 지원자 메인페이지 기업배너 리스트 조회  DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		HashMap<String, Object> result = sfuMapper.user_open_comp_banner_list(paramMap);
		logger.info("FAP 오픈잡페어 지원자 메인페이지 기업배너 리스트 조회  DAO 종료");
		return null;
	}

	/**
	 * @Method Name : select_user_board_nm
	 * @Date : 2019. 7. 21.
	 * @User : 김경아		
	 * @Param : 게시판 세부구분
	 * @Return : 게시판 이름 
	 * @Method 설명 : 게시판 이름 조회 
	 */
	public String select_user_board_nm(String board_detail_gb) {
		logger.info("FAP 오픈잡페어 지원자 게시판 이름 조회 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		String result= sfuMapper.select_user_board_nm(board_detail_gb);
		logger.info("FAP 오픈잡페어 지원자 게시판 이름 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_jobfair_divide_gb
	 * @Date : 2019. 8. 26.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : 세부 잡페어 구분
	 * @Method 설명 : 세부 잡페어 구분 조회
	 */
	public String select_jobfair_divide_gb(int fap_jobfair_divide_seq) {
		logger.info("FAP 세부잡페어 구분 조회 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		String result = sfuMapper.select_jobfair_divide_gb(fap_jobfair_divide_seq);
		logger.info("FAP 세부잡페어 구분 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_mainpage_context
	 * @Date : 2019. 9. 3.
	 * @User : 이종호
	 * @Param : 지역정보
	 * @Return : 메인페이지 기업컨텐츠 정보
	 * @Method 설명 : 설정된 메인페이지 기업컨텐츠 조회
	 */
	public ArrayList<HashMap<String, Object>> select_mainpage_context(HashMap<String,Object> paramMap){
		logger.info("설정된 메인페이지 기업컨텐츠 조회 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		ArrayList<HashMap<String, Object>> result = sfuMapper.select_mainpage_context(paramMap);
		logger.info("설정된 메인페이지 기업컨텐츠 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : check_jobfair_join
	 * @Date : 2019. 9. 4.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : 잡페어 참가 승인 완료시 1 아니면 0
	 * @Method 설명 : 해당 잡페어 참가 승인까지 완료했는 조회
	 */
	public int check_jobfair_join(HashMap<String, Object> params) {
		logger.info("해당 잡페어 참가 승인까지 완료했는 조회 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int result = sfuMapper.check_jobfair_join(params);
		logger.info("해당 잡페어 참가 승인까지 완료했는 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : check_user_apply_confirm
	 * @Date : 2019. 9. 6.
	 * @User : 이종호
	 * @Param : 회원 아이디, 잡페어 시퀀스
	 * @Return : 회원 지원하기(보증보험) 동의 완료시 1 미동의시 0
	 * @Method 설명 : 해당 잡페어의 채용공고에 지원시 보증보험 관련 동의를 했는지 조회
	 */
	public int check_user_apply_confirm(HashMap<String, Object> params) {
		logger.info("해당 잡페어의 채용공고에 지원시 보증보험 관련 동의를 했는지 조회 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int result = sfuMapper.check_user_apply_confirm(params);
		logger.info("해당 잡페어의 채용공고에 지원시 보증보험 관련 동의를 했는지 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : insert_user_apply_confirm
	 * @Date : 2019. 9. 6.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스, 회원 아이디
	 * @Return : -
	 * @Method 설명 : 잡페어별 회원 지원동의(보증보험) 동의 등록 
	 */
	public int insert_user_apply_confirm(HashMap<String, Object> params) {
		logger.info("잡페어별 회원 지원동의(보증보험) 동의 등록 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		int result = sfuMapper.insert_user_apply_confirm(params);
		logger.info("잡페어별 회원 지원동의(보증보험) 동의 등록 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_user_list
	 * @Date : 2019. 10. 15.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스 , 회원 아이디
	 * @Return : 도쿄페어 본인 일정 리스트
	 * @Method 설명 : 도쿄페어 본인 일정 리스트 조회
	 */
	public HashMap<String, Object> tokyofair_schedule_user_list(HashMap<String, Object> params){
		logger.info("FAP 도쿄페어 본인 일정 리스트 조회 DAO 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		HashMap<String, Object> result = sfuMapper.tokyofair_schedule_user_list(params);
		logger.info("FAP 도쿄페어 본인 일정 리스트 조회 DAO 종료");
		return result;
	}
	/**
	 * @return 
	 * @Method Name : internship_apply
	 * @Date : 2021. 4. 16.
	 * @User : 김나영
	 * @Param : 회원 ID, 이름, 연락처, 이메일
	 * @Return : -
	 * @Method 설명 : 미국인턴십 지원
	 */
	public int internship_apply(HashMap<String, Object> params) {
		logger.info("FAP 미국인턴십 지원 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		logger.info("FAP 미국인턴십 지원 종료");
		return sfuMapper.internship_apply(params);
	}
	/**
	 * @Method Name : select_internship
	 * @Date : 2021. 4. 16.
	 * @User : 김나영
	 * @Param : 게시글 시퀀스
	 * @Return : 미국인턴십 지원자 정보
	 * @Method 설명 : 미국인턴십 지원여부 조회
	 */
	public HashMap<String, Object> select_internship(HashMap<String, Object> params) {
		logger.info("FAP 미국인턴십 지원여부 조회 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		HashMap<String, Object> result = sfuMapper.select_internship(params);
		logger.info("FAP 미국인턴십 지원여부 조회 종료");
		return result;
	}
	/**
	 * @return 
	 * @Method Name : internship_cancel
	 * @Date : 2021. 4. 16.
	 * @User : 김나영
	 * @Param : 인턴십 시퀀스
	 * @Return : -
	 * @Method 설명 : 미국인턴십 지원취소
	 */
	public int internship_cancel(HashMap<String, Object> params) {
		logger.info("FAP 미국인턴십 지원취소 시작");
		SocietyFapUserMapper sfuMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		logger.info("FAP 미국인턴십 지원취소 종료");
		return sfuMapper.internship_cancel(params);
	}
}
