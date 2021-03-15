package global.segroup.society.fap.company.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

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
import global.segroup.society.fap.user.domain.SocietyFapNominee;


/**
 * @Author : 신동철
 * @Date : 2018. 11. 29.
 * @Class 설명 : Soft Engineer Society 통합잡페어 채용기업 DAO
 * 
 */

@Repository
public class SocietyFapCompanyDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyFapCompanyDAO.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	/**
	 * @Method Name : user_id_check
	 * @Date : 2018. 12. 11.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 유저아이디 or null
	 * @Method 설명 : 유저 아이디 중복 검사 중복된 경우 아이디 값이 return되며 중복 되지 않은 경우 null이 return됨
	 */
	public String user_id_check(String user_id){
		logger.info("FAP 유저 아이디 중복체크 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		String user_id_check = sfcMapper.user_id_check(user_id);
		logger.info("FAP 유저 아이디 중복체크 DAO 종료");
		return user_id_check;
	}
	
	/**
	 * @Method Name : insert_com_user
	 * @Date : 2018. 12. 11.
	 * @User : 김준영
	 * @Param : 유저 객체
	 * @Return : -
	 * @Method 설명 : 유저 등록을 하는 함수
	 *//*
	public void insert_com_user(User user){
		logger.info("FAP 유저 등록 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_com_user(user);
		logger.info("FAP 유저 등록 DAO 종료");
	}
	
	*//**
	 * @Method Name : insert_company
	 * @Date : 2018. 12. 11.
	 * @User : 김준영
	 * @Param : 회사 정보 객체
	 * @Return : -
	 * @Method 설명 : 회사 정보를 등록 하는 함수
	 *//*
	public void insert_company(SocietyFapCompanyUser sfcUser){
		logger.info("FAP 회사 등록 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_company(sfcUser);
		logger.info("FAP 회사 등록 DAO 종료");
	}*/
	
	/**
	 * @Method Name : insert_company
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 공통 유저 객체, 회사 정보 객체
	 * @Return : -
	 * @Method 설명 : 회사 정보를 등록 하는 함수
	 */
	@Transactional
	public void insert_company(String company_ck, User user, 
			SocietyFapCompanyUser societyFapCompanyUser, 
			SocietyFapCompanyUserConnect societyFapCompanyUserConnect){
		logger.info("FAP 회사 등록 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		// 존재하는 회사 정보가 없어 담당자가 회사 정보까지 입력; 회원 공통 테이블, 회사회원 둘다 insert
		if(company_ck.equals("nonexistent")){
			sfcMapper.insert_com_user(user);
			sfcMapper.insert_company(societyFapCompanyUser);
			// 회사-담당자 연결을 위해 객체에 값 넣어주기
			societyFapCompanyUserConnect.setUser_id(user.getUser_id());
			societyFapCompanyUserConnect.setFap_comp_id(societyFapCompanyUser.getFap_comp_id());
			societyFapCompanyUserConnect.setFap_comp_user_connect_ck("B3800");
			sfcMapper.comp_user_connect(societyFapCompanyUserConnect);
		// 존재하는 회사 정보가 있어서 담당자가 회사 정보를 입력하지 않음; 회원 공통 테이블
		} else if(company_ck.equals("existent")){
			sfcMapper.insert_com_user(user);
		}
		logger.info("FAP 회사 등록 DAO 종료");
	}
	
	
/*	*//**
	 * @Method Name : comp_user_connect
	 * @Date : 2018. 12. 12.
	 * @User : 김준영
	 * @Param : 회사-담당자 연결 객체
	 * @Return : -
	 * @Method 설명 : 회사와 담당자를 연결해주는 함수
	 */
	public int comp_user_connect(SocietyFapCompanyUserConnect sfCUConnect){
		logger.info("FAP 회사-담당자 연결 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int result = sfcMapper.comp_user_connect(sfCUConnect);
		logger.info("FAP 회사-담당자 연결 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_company_log
	 * @Date : 2019. 03. 11.
	 * @User : 김준영
	 * @Param : 회사아이디
	 * @Return : 회사 로고 정보
	 * @Method 설명 : 특정 회사 로고 정보 획득 함수
	 */
	public SocietyFapCompanyUser select_company_log(String user_id) {
		
		logger.info("FAP 특정 회사 로고 정보 획득 함수 DAO 시작");
		SocietyFapCompanyUser societyFapCompanyUser = new SocietyFapCompanyUser();
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		societyFapCompanyUser = sfcMapper.select_company_log(user_id);
		logger.info("FAP 특정 회사 로고 정보 획득 함수 DAO 종료");
		return societyFapCompanyUser;
		
	}
	
	/**
	 * @Method Name : select_company
	 * @Date : 2018. 12. 13.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 회사 정보 객체
	 * @Method 설명 : 아이디가 가지고 있는 회사 정보를 가져오는 함수
	 */
	public SocietyFapCompanyUser select_company(String user_id){
		logger.info("FAP 회사 정보 가져오기 DAO 시작");
		SocietyFapCompanyUser societyFapCompanyUser = new SocietyFapCompanyUser();
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		societyFapCompanyUser = sfcMapper.select_company(user_id);
		logger.info("FAP 회사 정보 가져오기 DAO 종료");
		return societyFapCompanyUser;
	}
	
	/**
	 * @Method Name : update_company
	 * @Date : 2018. 12. 13.
	 * @User : 김준영
	 * @Param : 회사 정보 객체
	 * @Return : -
	 * @Method 설명 : 회사 정보를 업데이트 하는 함수
	 */
	public void update_company(SocietyFapCompanyUser sfcUser){
		logger.info("FAP 회사 정보 업데이트 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.update_company(sfcUser);
		logger.info("FAP 회사 정보 업데이트 DAO 종료");
	}
	
	/**
	 * @Method Name : select_user
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 공통 유저 객체
	 * @Method 설명 : 공통 유저 객체를 불러오는 함수
	 */
	public User select_user(String user_id){
		logger.info("FAP 기업 담당자 정보 가져오기 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		User user = sfcMapper.select_user(user_id);
		logger.info("FAP 기업 담당자 정보 가져오기 DAO 종료");
		return user;
	}
	
	/**
	 * @Method Name : update_user
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 공통 유저 객체
	 * @Return : -
	 * @Method 설명 : 회사 담당자 정보를 수정하는 함수
	 */
	public void update_user(User user){
		logger.info("FAP 에이전시 담당자 정보 수정 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.update_user(user);
		logger.info("FAP 에이전시 담당자 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : jobfair_search_list
	 * @Date : 2018. 12. 24.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 통합잡페어 정보 리스트
	 * @Method 설명 : 통합잡페어 정보 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> jobfair_search_list(){
		logger.debug("통합잡페어 정보 리스트 검색 DAO 시작");
		ArrayList<HashMap<String, Object>> jobfair_search_list = null;		
		try{
			SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
			jobfair_search_list = sfcMapper.jobfair_search_list();
		}catch(Exception e){
			e.printStackTrace();
		}		
		logger.debug("통합잡페어 정보 리스트 검색 DAO 종료");
		return jobfair_search_list;
	}
	
	/**
	 * @Method Name : jobfair_divide_search_list
	 * @Date : 2018. 12. 24.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어 세부정보 리스트
	 * @Method 설명 : 선택한 잡페어 세부정보 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> jobfair_divide_search_list(int fap_jobfair_seq){
		logger.debug("선택한 잡페어 세부정보 리스트 검색 DAO 시작");
		ArrayList<HashMap<String, Object>> jobfair_divide_search_list = null;		
		try{
			SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
			jobfair_divide_search_list = sfcMapper.jobfair_divide_search_list(fap_jobfair_seq);
		}catch(Exception e){
			e.printStackTrace();
		}		
		logger.debug("선택한 잡페어 세부정보 리스트 검색 DAO 종료");
		return jobfair_divide_search_list;
	}
	
	/**
	 * @Method Name : company_jobfair_divide_participation
	 * @Date : 2018. 12. 24.
	 * @User : 신동철
	 * @Param : 회사잡페어등록정보(잡페어 시퀀스, 잡페어 세부 시퀀스, 회사 아이디, 에이전시 여부구분)
	 * @Return : -
	 * @Method 설명 : 회사잡페어등록정보 입력
	 */
	public void company_jobfair_divide_participation(HashMap<String, Object> hashmap){
		logger.debug("회사잡페어등록정보 입력 DAO 시작");
		try{
			SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
			sfcMapper.company_jobfair_divide_participation(hashmap);
		}catch(Exception e){
			e.printStackTrace();
		}
		logger.debug("회사잡페어등록정보 입력 DAO 종료");
	}

	/**
	 * @Method Name : select_company_jobfair_participation
	 * @Date : 2018. 12. 26.
	 * @User : 신동철
	 * @Param : (잡페어 시퀀스, 회사 아이디)
	 * @Return : -
	 * @Method 설명 : 회사잡페어등록정보 검색
	 */
	public  ArrayList<HashMap<String, Object>> select_company_jobfair_participation(HashMap<String, Object> hashmap){
		logger.debug("회사잡페어등록정보 검색 DAO 시작");
		ArrayList<HashMap<String, Object>> select_company_jobfair_participation_list = null;
		try{
			SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
			select_company_jobfair_participation_list = sfcMapper.select_company_jobfair_participation(hashmap);
		}catch(Exception e){
			e.printStackTrace();
		}
		logger.debug("회사잡페어등록정보 검색 DAO 종료");
		return select_company_jobfair_participation_list;
	}
	
	/**
	 * @Method Name : select_fap_comp_id
	 * @Date : 2018. 12. 27.
	 * @User : 신동철
	 * @Param : 회원 아이디
	 * @Return : 회사 아이디
	 * @Method 설명 : 회사 아이디 발급 여부 검색
	 */
	public String select_fap_comp_id(String user_id){
		logger.debug("회사 아이디 발급 여부 검색 DAO 시작");
		String fap_comp_id = null;
		try{
			SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
			fap_comp_id = sfcMapper.select_fap_comp_id(user_id);
		}catch(Exception e){
			e.printStackTrace();
		}		
		logger.debug("회사 아이디 발급 여부 검색 DAO 종료");
		return fap_comp_id;
	}
	
	/**
	 * @Method Name : delete_company_user_info
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 탈퇴할 기업 담당자 객체
	 * @Return : -
	 * @Method 설명 : 기업 담당자 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(45글자) 변경후 참조 테이블에 적용
	 */
	@Transactional
	public int delete_company_user_info(User user){
		logger.info("FAP 회원 탈퇴 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		
		//비밀번호 체크
		User select_user = sfcMapper.select_user(user.getUser_id());	
		try {
			// 비밀번호가 일치하지 않을 경우				입력	 	불러온거
			if(!passwordEncoder.matches(user.getUser_pw(), select_user.getUser_pw())){
				return 0;
			}
		}catch (NullPointerException e){
			//일치하는 아이디가 없어서 예외 발생할 때 처리부분
			return 0;
		}
		
		// 중복되기 어려운 임의의값 생성
		long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmssSSS"); 
		String deleteUserId = user.getUser_id() + dayTime.format(new Date(time));
		
		// DB에 ID길이가 45이므로 넘을 시 잘라줌
		if(deleteUserId.length() >= 45) {
			deleteUserId = deleteUserId.substring(0, 45);
		}
		
		//변경할 데이터 맵
		HashMap<String, String> updateMap = new HashMap<>();
		
		updateMap.put("user_id", user.getUser_id());
		updateMap.put("user_state", "A0202");
		updateMap.put("user_delete_id", deleteUserId);
							
		// 회원 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(30글자) 변경
		int result = sfcMapper.delete_company_user_info(updateMap);
		// 에이전시 - 기업 담당자 연결 정보 삭제함; 꼭 이거 먼저 삭제해야함
		sfcMapper.delete_ag_comp_connect(user.getUser_id());
		// 기업 - 담당자 연결 정보도 삭제함
		sfcMapper.user_connect_delete(user.getUser_id());
		
		logger.info("FAP 회원 탈퇴 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_comp_user_connect
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 기업 - 유저 연결 객체
	 * @Method 설명 : 해당 하는 아이디에 기업 - 유저 연결 객체를 불러오는 함수
	 */
	public SocietyFapCompanyUserConnect select_comp_user_connect(String user_id){
		logger.info("FAP 기업 - 유저 연결 객체 가져오기 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		SocietyFapCompanyUserConnect comp_user_connect = sfcMapper.select_comp_user_connect(user_id);
		logger.info("FAP 기업 - 유저 연결 객체 가져오기 DAO 종료");
		return comp_user_connect;
	}
	
	/**
	 * @Method Name : select_all_company
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 모든 기업 리스트
	 * @Method 설명 : 모든 기업 리스트를 불러오는 함수 
	 */
	public ArrayList<SocietyFapCompanyUser> select_all_company(){
		logger.info("FAP 기업 리스트 가져오기 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<SocietyFapCompanyUser> company_list = sfcMapper.select_all_company();
		logger.info("FAP 기업 리스트 가져오기 DAO 종료");
		return company_list;
	}
	
	/**
	 * @Method Name : delete_comp_user_connect
	 * @Date : 2018. 12. 27.
	 * @User : 김준영
	 * @Param : 기업 - 유저 연결 시퀀스
	 * @Return : -
	 * @Method 설명 : 기업 - 유저 연결을 삭제하는 함수
	 */
	public int delete_comp_user_connect(int fap_comp_user_connect_seq){
		logger.info("FAP 기업 - 유저 연결 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int result = sfcMapper.delete_comp_user_connect(fap_comp_user_connect_seq);
		logger.info("FAP 기업 - 유저 연결 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_connect_request
	 * @Date : 2018. 12. 31.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 에이전시 정보 리스트
	 * @Method 설명 : 기업에게 연결 요청을 한 에이전시의 정보를 가져오는 함수
	 */
	public ArrayList<SocietyFapCompanyUser> select_connect_request(String user_id){
		logger.info("FAP 연결 요청한 에이전시 리스트 가져오기 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<SocietyFapCompanyUser> agency_list = sfcMapper.select_connect_request(user_id);
		logger.info("FAP 연결 요청한 에이전시 리스트 가져오기 DAO 종료");
		return agency_list;
	}
	
	/**
	 * @Method Name : insert_common_required_doc
	 * @Date : 2019. 1. 1.
	 * @User : 신동철
	 * @Param : 공통 내정서류 정보
	 * @Return : -
	 * @Method 설명 : 공통 내정서류를 등록하는 함수
	 */
	public int insert_common_required_doc(SocietyFapCommonRequiredDoc common_required_doc){
		logger.info("FAP 공통 내정서류를 등록 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int result = sfcMapper.insert_common_required_doc(common_required_doc);
		
		logger.info("FAP 공통 내정서류를 등록 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : delete_common_required_doc
	 * @Date : 2019. 1. 1.
	 * @User : 신동철
	 * @Param : 공통 내정서류 정보
	 * @Return : -
	 * @Method 설명 : 공통 내정서류를 삭제하는 함수
	 */
	public void delete_common_required_doc(SocietyFapCommonRequiredDoc common_required_doc){
		logger.info("FAP 공통 내정서류 삭제 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.delete_common_required_doc(common_required_doc);
		
		logger.info("FAP 공통 내정서류 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : serach_common_required_doc_list
	 * @Date : 2019. 1. 1.
	 * @User : 신동철
	 * @Param : 채용공고 시퀀스, 회사아이디
	 * @Return : 공통 내정서류 리스트
	 * @Method 설명 : 공통 내정서류를 검색하는 함수
	 */
	public ArrayList<SocietyFapCommonRequiredDoc> search_common_required_doc_list(HashMap<String, Object> hashmap){
		logger.info("FAP 공통 내정서류 리스트 검색 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<SocietyFapCommonRequiredDoc> common_required_doc_list =  sfcMapper.search_common_required_doc_list(hashmap);
		
		logger.info("FAP 공통 내정서류 리스트 검색 DAO 종료");
		return common_required_doc_list;
	}
	
	/**
	 * @Method Name : request_handling
	 * @Date : 2019. 1. 2.
	 * @User : 김준영
	 * @Param : 요청 처리를 위한 유저 아이디, 기업 아이디, 처리 상태
	 * @Return : -
	 * @Method 설명 : 에이전시의 기업 연결 요청을 처리하는 함수
	 */
	@Transactional
	public void request_handling(Authentication auth, String fap_comp_id, String handling_ck){
		logger.info("FAP 에이전시 요청 처리 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("fap_ag_id", fap_comp_id);
		hashMap.put("user_id", (String)auth.getPrincipal());
		if(handling_ck.equals("approval")){
			hashMap.put("fap_ag_comp_connect_ck", "B3800");
		} else if (handling_ck.equals("refusal")){
			hashMap.put("fap_ag_comp_connect_ck", "B3802");
		}
		sfcMapper.request_handling(hashMap);
		logger.info("FAP 에이전시 요청 처리 DAO 시작");
	}
	
	/**
	 * @Method Name : select_common_required_doc
	 * @Date : 2019. 1. 1.
	 * @User : 신동철
	 * @Param : 특정 공통 내정서류 시퀀스
	 * @Return : 특정 공통 내정서류 정보
	 * @Method 설명 :  특정 공통 내정서류를 검색하는 함수
	 */
	public SocietyFapCommonRequiredDoc select_common_required_doc(int fap_common_required_doc_seq){
		logger.info("FAP 특정 공통 내정서류 검색 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		SocietyFapCommonRequiredDoc common_required_doc =  sfcMapper.select_common_required_doc(fap_common_required_doc_seq);
		
		logger.info("FAP 특정 공통 내정서류 검색 DAO 종료");
		return common_required_doc;		
	}
	
	/**
	 * @Method Name : update_common_required_doc
	 * @Date : 2019. 1. 2.
	 * @User : 신동철
	 * @Param : 공통 내정서류 정보
	 * @Return : -
	 * @Method 설명 : 공통 내정서류를 수정하는 함수
	 */
	public void update_common_required_doc(SocietyFapCommonRequiredDoc common_required_doc){
		logger.info("FAP 공통 내정서류 수정 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.update_common_required_doc(common_required_doc);
		
		logger.info("FAP 공통 내정서류 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : search_company_job_ad_list
	 * @Date : 2019. 1. 5.
	 * @User : 신동철
	 * @Param : 회사 아이디
	 * @Return : 회사가 참가한 채용공고 리스트 
	 * @Method 설명 : 회사가 참가한 채용공고 리스트 검색하는 함수
	 */
	public ArrayList<SocietyFapJobAd> search_company_job_ad_list(SocietyFapJobAd job_ad){
		logger.info("FAP 회사가 참가한 채용공고 리스트 검색 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<SocietyFapJobAd> company_job_ad_list = sfcMapper.search_company_job_ad_list(job_ad);
		
		logger.info("FAP 회사가 참가한 채용공고 리스트 검색 DAO 종료");
		return company_job_ad_list;
	}
	
	/**
	 * @Method Name : search_nominee_info_list
	 * @Date : 2019. 1. 5.
	 * @User : 신동철
	 * @Param : 채용공고 시퀀스, 회사 아이디
	 * @Return : 특정 회사의 내정자 정보 리스트 
	 * @Method 설명 : 특정 회사의 내정자 정보 리스트  검색하는 함수
	 */
	public ArrayList<HashMap<String, Object>> search_nominee_info_list(HashMap<String, Object> hashmap){
		logger.info("FAP 특정 회사의 내정자 정보 리스트 검색 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<HashMap<String, Object>> nominee_info_list = sfcMapper.search_nominee_info_list(hashmap);
		
		logger.info("FAP 특정 회사의 내정자 정보 리스트 검색 DAO 종료");
		return nominee_info_list;
	}

	/**
	 * @Method Name : select_common_company
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 에이전시를 제외한 기업 객체
	 * @Method 설명 : 모든 기업객체 중 에이전시를 제외한 일반 기업 객체를 가져오는 함수
	 */
	public ArrayList<SocietyFapCompanyUser> select_common_company(){
		logger.info("FAP 일반 기업 가져오기 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<SocietyFapCompanyUser> comp_list = sfcMapper.select_common_company();
		logger.info("FAP 일반 기업 가져오기 DAO 종료");
		return comp_list;
	}
	
	/**
	 * @Method Name : insert_personal_required_doc
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 개인 내정서류 정보
	 * @Return : -
	 * @Method 설명 : 개인 내정서류를 등록하는 함수
	 */
	public int  insert_personal_required_doc(SocietyFapPersonalRequiredDoc personal_required_doc){
		logger.info("FAP 개인 내정서류 등록 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int result = sfcMapper.insert_personal_required_doc(personal_required_doc);		
		logger.info("FAP 개인 내정서류 등록 DAO 종료");
		return result; 
	}
	
	/**
	 * @Method Name : select_user_flag
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 회원 아이디
	 * @Return : -
	 * @Method 설명 : 회원 권한을 검색하는 함수
	 */
	public String select_user_flag(String user_id){
		logger.info("FAP 회원 권한 검색 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		String user_flag = sfcMapper.select_user_flag(user_id);
		
		logger.info("FAP 회원 권한 검색 DAO 종료");
		return user_flag;
	}
	
	/**
	 * @Method Name : select_nominee_info
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 특정 내정자 시퀀스
	 * @Return : 특정 내정자 정보
	 * @Method 설명 : 특정 내정자 정보 검색하는 함수
	 */
	public SocietyFapNominee select_nominee_info(long fap_nominee_seq){
		logger.info("FAP 특정 내정자 정보 검색 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		SocietyFapNominee nominee_info = sfcMapper.select_nominee_info(fap_nominee_seq);
		
		logger.info("FAP 특정 내정자 정보 검색 DAO 종료");
		return nominee_info;
	}
	
	/**
	 * @Method Name : search_personal_required_doc_list
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 특정 내정자 시퀀스
	 * @Return : 개인 내정서류 리스트
	 * @Method 설명 : 개인 내정서류 리스트를 검색하는 함수
	 */
	public ArrayList<HashMap<String, Object>> search_personal_required_doc_list(int fap_nominee_seq){
		logger.info("FAP 개인 내정서류 리스트 검색 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<HashMap<String, Object>> personal_required_doc_list = sfcMapper.search_personal_required_doc_list(fap_nominee_seq);
		
		logger.info("FAP 개인 내정서류 리스트 검색 DAO 종료");
		return personal_required_doc_list;		
	}
	
	/**
	 * @Method Name : select_personal_required_doc
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 특정 내정자 시퀀스
	 * @Return : 특정 개인 내정서류 정보
	 * @Method 설명 : 특정 개인 내정서류 정보를 검색하는 함수
	 */
	public SocietyFapPersonalRequiredDoc select_personal_required_doc(int fap_nominee_seq){
		logger.info("FAP 개인 내정서류 정보 검색 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		SocietyFapPersonalRequiredDoc personal_required_doc = sfcMapper.select_personal_required_doc(fap_nominee_seq);
		
		logger.info("FAP 개인 내정서류 정보 검색 DAO 종료");
		return personal_required_doc;
	}
	
	/**
	 * @Method Name : update_personal_required_doc
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 개인 내정서류
	 * @Return : -
	 * @Method 설명 : 개인 내정서류 수정하는 함수
	 */
	public void update_personal_required_doc(SocietyFapPersonalRequiredDoc personal_required_doc){
		logger.info("FAP 개인 내정서류 정보 수정 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.update_personal_required_doc(personal_required_doc);
		
		logger.info("FAP 개인 내정서류 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : delete_personal_required_doc
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 개인 내정서류
	 * @Return : -
	 * @Method 설명 : 개인 내정서류 삭제 하는 함수
	 */
	public void delete_personal_required_doc(SocietyFapPersonalRequiredDoc personal_required_doc){
		logger.info("FAP 개인 내정서류 정보 삭제 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.delete_personal_required_doc(personal_required_doc);
		
		logger.info("FAP 개인 내정서류 정보 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : search_nominee_info
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 내정자 시퀀스
	 * @Return : 내정자 정보 
	 * @Method 설명 : 특정 회사의 내정자 정보 검색하는 함수
	 */
	public HashMap<String, Object> search_nominee_info(SocietyFapNominee nominee){
		logger.info("FAP 개인 내정서류 정보 삭제 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		HashMap<String, Object> nominee_info = sfcMapper.search_nominee_info(nominee);
		
		logger.info("FAP 개인 내정서류 정보 삭제 DAO 종료");
		return nominee_info;
	}
	
	/**
	 * @Method Name : algorithm_jobfair_setting_use_search
	 * @Date : 2019. 1. 8.
	 * @User : 이종호
	 * @Param : 현지잡페어 설정 사용중인 구분코드
	 * @Return : 현지잡페어 설정 정보 
	 * @Method 설명 : 사용중인 구분코드로 현지잡페어 설정정보를 취득
	 */
	public HashMap<String, Object> algorithm_jobfair_setting_use_search(HashMap<String, Object> params) {
		logger.info("FAP 사용중인 현지잡페어 설정 취득 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		HashMap<String, Object> result = sfcMapper.algorithm_jobfair_setting_use_search(params);
		
		logger.info("FAP 사용중인 현지잡페어 설정 취득 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : user_company_info_insert
	 * @Date : 2019. 1. 10.
	 * @User : 김준영
	 * @Param : 유저 정보, 기업 정보
	 * @Return : -
	 * @Method 설명 : 유저 아이디와 일치하는 연결객체의 값을 삭제 후 기업 정보를 입력하는 함수
	 */
	@Transactional
	public void user_company_info_insert(Authentication auth, SocietyFapCompanyUser company_info){
		logger.info("FAP 기업 담당자 - 기업 정보 입력 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		// 정보 입력 전 연결 객체 삭제
		sfcMapper.user_connect_delete((String)auth.getPrincipal());
		// 기업 정보 입력 
		String company_id = company_info.getFap_comp_en_nm() + "@_@" + (String)auth.getPrincipal();
		// 적용
		company_info.setFap_comp_id(company_id);
		sfcMapper.insert_company(company_info);
		// 기업 담당자 - 기업 연결
		SocietyFapCompanyUserConnect sfCUConnect = new SocietyFapCompanyUserConnect();
		sfCUConnect.setUser_id((String)auth.getPrincipal());
		sfCUConnect.setFap_comp_id(company_id);
		sfCUConnect.setFap_comp_user_connect_ck("B3800");
		sfcMapper.comp_user_connect(sfCUConnect);
		logger.info("FAP 기업 담당자 - 기업 정보 입력 DAO 시작");
	}
	
	
	/**
	 * @Method Name : algorithm_calendar_setting_insert
	 * @Date : 2019. 1. 10.
	 * @User : 이종호
	 * @Param : 현지잡페어 설정 정보
	 * @Return : -
	 * @Method 설명 : 현지잡페어 설정 정보 등록
	 */
	public void algorithm_calendar_setting_insert(SocietyFapLaJobSet jobSet,SocietyFapLaJobPlan jobPlan) {
		logger.info("FAP 현지잡페어 설정 정보 등록 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.algorithm_calendar_setting_insert(jobSet);
		sfcMapper.algorithm_calendar_setting_insert_plan(jobPlan);
		
		logger.info("FAP 현지잡페어 설정 정보 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : algorithm_calendar_setting_update
	 * @Date : 2019. 1. 10.
	 * @User : 이종호
	 * @Param : 현지잡페어 설정 정보
	 * @Return : -
	 * @Method 설명 : 현지잡페어 설정 정보 수정
	 */
	public void algorithm_calendar_setting_update(SocietyFapLaJobSet jobSet,SocietyFapLaJobPlan jobPlan) {
		logger.info("FAP 현지잡페어 설정 정보 수정 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.algorithm_calendar_setting_update(jobSet);
		
		sfcMapper.algorithm_calendar_setting_delete_plan(jobSet.getFap_job_ad_seq());
		sfcMapper.algorithm_calendar_setting_insert_plan(jobPlan);
		
		logger.info("FAP 현지잡페어 설정 정보 수정 DAO 종료");
	}
	//채용공고 이전 시작
	
	/**
	 * @Method Name : insert_job_ad_parent
	 * @Date : 2019. 1. 15.
	 * @User : 원병호
	 * @Param : 채용공고와 채용전형 객체를 담은 맵
	 * @Return : 채용공고와 채용전형 객체를 담은 맵 
	 * @Method 설명 : 채용공고와 채용전형을 진행후 각각의 seq가 세팅하여 반환
	 */
	public HashMap<String, Object> insert_job_ad_parent(HashMap<String, Object> job_ad_parent){
		logger.info("채용공고 정보 부모 등록 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		
		//seq를 return받은 객체를 다시 반환할 map
		 HashMap<String, Object> result = new  HashMap<String, Object>();
		 
		//채용공고 등록
		SocietyFapJobAd jobAd = (SocietyFapJobAd)job_ad_parent.get("jobAd");
		String fap_comp_id = jobAd.getFap_comp_id();
		sfcMapper.insert_job_ad(jobAd);
		result.put("jobAd", jobAd);
		
		//채용전형 등록
		SocietyFapJobRecruitPcs jobRecruitPcs = (SocietyFapJobRecruitPcs)job_ad_parent.get("jobRecruitPcs");
		List<SocietyFapJobRecruitPcs> after = new ArrayList<SocietyFapJobRecruitPcs>();	//seq return받을 중간 map
		for(SocietyFapJobRecruitPcs jrp : jobRecruitPcs.getJobRecruitPcsList()){
			jrp.setFap_job_ad_seq(jobAd.getFap_job_ad_seq());	//부모 seq 세팅
			jrp.setFap_job_recruit_pcs_ins_id(fap_comp_id);
			jrp.setFap_job_recruit_pcs_udt_id(fap_comp_id);
			after.add(jrp);		//중간 map에 add
		}
		sfcMapper.insert_job_recruitpcs(after);		//insert 및 seq 반환
		jobRecruitPcs.setJobRecruitPcsList(after);	//seq가 반환된 리스트를 객체에 세팅
		result.put("jobRecruitPcs", jobRecruitPcs);
		
		logger.info("채용공고 정보 부모 등록 DAO 시작");
		return result;
	}
	
	/*--------------------------------------------채용공고 등록(분리)----------------------------------*/
	/**
	 * @Method Name : insert_job_ad2
	 * @Date : 2019. 1. 16.
	 * @User : 원병호
	 * @Param : 채용공고 
	 * @Return : 
	 * @Method 설명 : 채용공고 등록후 seq까지 넣은 객체를 그대로 반환
	 */
	public SocietyFapJobAd insert_job_ad2(SocietyFapJobAd jobAd){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_ad(jobAd);
		return jobAd;
	}
	
	/**
	 * @Method Name : insert_job_dorm
	 * @Date : 2019. 1. 16.
	 * @User : 원병호
	 * @Param : 기숙사
	 * @Return : 
	 * @Method 설명 : 기숙사 정보 등록
	 */
	public void insert_job_dorm(SocietyFapJobDorm jobDorm){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_dorm(jobDorm);
	}
	
	/**
	 * @Method Name : insert_job_jit_employee
	 * @Date : 2019. 1. 16.
	 * @User : 원병호
	 * @Param : 계약사원정보
	 * @Return : 
	 * @Method 설명 : 계약사원 정보 등록
	 */
	public void insert_job_jit_employee(SocietyFapJobJitEmployee jobJitEmployee){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_jit_employee(jobJitEmployee);
	}
	
	/**
	 * @Method Name : insert_job_ja_level
	 * @Date : 2019. 1. 16.
	 * @User : 원병호
	 * @Param : 업무에 필요한 일본어 능력
	 * @Return : 업무에 필요한 일본어 능력 정보 등록 
	 * @Method 설명 :
	 */
	public void insert_job_ja_level(SocietyFapJobJaLevel jobJaLevel){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_ja_level(jobJaLevel);
	}
	
	/**
	 * @Method Name : insert_job_trial
	 * @Date : 2019. 1. 16.
	 * @User : 원병호
	 * @Param : 시용기간
	 * @Return : 
	 * @Method 설명 : 시용기간 정보 등록
	 */
	public void insert_job_trial(SocietyFapJobTrial jobTrial){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_trial(jobTrial);
	}
	
	/**
	 * @Method Name : insert_job_comp
	 * @Date : 2019. 1. 16.
	 * @User : 원병호
	 * @Param : 채용공고 회사정보
	 * @Return : 
	 * @Method 설명 : 채용공고 회사정보 등록
	 */
	public void insert_job_comp(SocietyFapJobComp jobComp){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_comp(jobComp);
	}
	
	/**
	 * @Method Name : insert_job_file
	 * @Date : 2019. 1. 16.
	 * @User : 원병호
	 * @Param : 채용공고 파일 정보
	 * @Return : 
	 * @Method 설명 : 채용공고 파일 정보 등록
	 */
	public void insert_job_file(SocietyFapJobFile jobFile){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_file(jobFile);
	}
	
	/**
	 * @Method Name : insert_job_isr
	 * @Date : 2019. 1. 16.
	 * @User : 원병호
	 * @Param : 채용공고 보험 정보
	 * @Return : 
	 * @Method 설명 : 채용공고 보험 정보 등록
	 */
	public void insert_job_isr(SocietyFapJobIsr jobIsr){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_isr(jobIsr);
	}
	
	/**
	 * @Method Name : insert_job_join_dt
	 * @Date : 2019. 1. 16.
	 * @User : 원병호
	 * @Param : 입사예정일
	 * @Return : 
	 * @Method 설명 : 입사예정일 정보 등록
	 */
	public void insert_job_join_dt(SocietyFapJobJoinDt jobJoinDt){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_join_dt(jobJoinDt);
	}

	/**
	 * @Method Name : insert_job_work
	 * @Date : 2019. 1. 16.
	 * @User : 원병호
	 * @Param : 채용공고 주요 업무 정보
	 * @Return : 
	 * @Method 설명 : 채용공고 주요 업무 정보 등록
	 */
	public void insert_job_work(SocietyFapJobWork jobWork){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_work(jobWork);
	}
	
	/**
	 * @Method Name : insert_job_category
	 * @Date : 2019. 1. 16.
	 * @User : 원병호
	 * @Param : 모집 직종
	 * @Return : 
	 * @Method 설명 : 모집 직종 정보 입력 
	 */
	public void insert_job_category(List<SocietyFapJobCategory> jobCategory){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_category(jobCategory);
	}
	
	/**
	 * @Method Name : insert_job_category_etc
	 * @Date : 2019. 2. 8.
	 * @User : 이재준
	 * @Param : 채용공고 모집직종(기타) 객체 
	 * @Return : -
	 * @Method 설명 : 모집직종(기타) 정보 저장
	 */
	public void insert_job_category_etc(SocietyFapJobCategoryEtc JobCategoryEtc) {
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_category_etc(JobCategoryEtc);
	}
	
	/**
	 * @Method Name : insert_job_pref
	 * @Date : 2019. 1. 16.
	 * @User : 원병호
	 * @Param : 우대사항
	 * @Return : 
	 * @Method 설명 : 우대사항 정보 객체
	 */
	public void insert_job_pref(SocietyFapJobPref jobPref){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_pref(jobPref);
	}
	
	/**
	 * @Method Name : insert_job_workplace
	 * @Date : 2019. 1. 16.
	 * @User : 원병호
	 * @Param : 근무예정지
	 * @Return : 
	 * @Method 설명 : 근무예정지 정보 등록후 seq입력후 반환
	 */
	public List<SocietyFapJobWorkplace> insert_job_workplace(List<SocietyFapJobWorkplace> jobWorkplace_list){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_workplace(jobWorkplace_list);
		return jobWorkplace_list;
	}
	
	/**
	 * @Method Name : insert_job_workplace_dtl
	 * @Date : 2019. 1. 16.
	 * @User : 원병호
	 * @Param : 상세근무예정지 리스트
	 * @Return : 
	 * @Method 설명 : 상세근무예정지 리스트 등록
	 */
	public void insert_job_workplace_dtl(List<SocietyFapJobWorkplaceDtl> jobWorkplaceDtl_list){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_workplace_dtl(jobWorkplaceDtl_list);
	}
	
	/**
	 * @Method Name : insert_job_workplace_etc
	 * @Date : 2019. 2. 8.
	 * @User : 이재준
	 * @Param : 채용공고 근무예정지(기타) 객체 
	 * @Return : -
	 * @Method 설명 : 근무예정지(기타) 정보 저장
	 */
	public void insert_job_workplace_etc(SocietyFapJobWorkplaceEtc JobWorkplaceEtc) {
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_workplace_etc(JobWorkplaceEtc);
	}
	
	/**
	 * @Method Name : insert_job_recruit_pcs
	 * @Date : 2019. 1. 17.
	 * @User : 원병호
	 * @Param : 채용전형 리스트
	 * @Return : 
	 * @Method 설명 : 채용전형 리스트 등록후 seq 반환
	 */
	public List<SocietyFapJobRecruitPcs> insert_job_recruit_pcs(List<SocietyFapJobRecruitPcs> jobRecruitPcs_list){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_recruitpcs(jobRecruitPcs_list);
		return jobRecruitPcs_list;
	}
	
	/**
	 * @Method Name : insert_job_exam
	 * @Date : 2019. 1. 17.
	 * @User : 원병호
	 * @Param : 시험전형정보
	 * @Return : 
	 * @Method 설명 : 시험전형정보 등록후 seq 반환
	 */
	public SocietyFapJobExam insert_job_exam(SocietyFapJobExam jobExam){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_exam(jobExam);
		return jobExam;
	}
	
	/**
	 * @Method Name : insert_job_itv
	 * @Date : 2019. 1. 17.
	 * @User : 원병호
	 * @Param : 면접전형정보
	 * @Return : 
	 * @Method 설명 : 면접전형정보 등록후 seq 반환
	 */
	public SocietyFapJobItv insert_job_itv(SocietyFapJobItv jobItv){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_itv(jobItv);
		return jobItv;
	}
	
	/**
	 * @Method Name : insert_job_test_etc
	 * @Date : 2019. 1. 17.
	 * @User : 원병호
	 * @Param : 기타전형정보
	 * @Return : 
	 * @Method 설명 : 기타전형정보 등록후 seq 반환
	 */
	public SocietyFapJobTestEtc insert_job_test_etc(SocietyFapJobTestEtc jobTestEtc){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_test_etc(jobTestEtc);
		return jobTestEtc;
	}
	
	/**
	 * @Method Name : insert_job_exam_file
	 * @Date : 2019. 1. 17.
	 * @User : 원병호
	 * @Param : 시험문제파일
	 * @Return : 
	 * @Method 설명 : 시험문제파일 정보 등록
	 */
	public void insert_job_exam_file(SocietyFapJobExamFile jobExamFile){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_exam_file(jobExamFile);
	}
	
	/**
	 * @Method Name : insert_job_exam_obj_etc
	 * @Date : 2019. 1. 17.
	 * @User : 원병호
	 * @Param : 시험대상자(기타)
	 * @Return : 
	 * @Method 설명 : 시험대상자(기타) 정보 등록
	 */
	public void insert_job_exam_obj_etc(SocietyFapJobExamObjEtc jobExamObjEtc){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_exam_obj_etc(jobExamObjEtc);
	}
	
	/**
	 * @Method Name : insert_job_exam_sv_etc
	 * @Date : 2019. 1. 17.
	 * @User : 시험감독관(기타)
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 시험감독관(기타) 정보 등록
	 */
	public void insert_job_exam_sv_etc(SocietyFapJobExamSvEtc jobExamSvEtc){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_exam_sv_etc(jobExamSvEtc);
	}

	/**
	 * @Method Name : insert_job_exam_need_etc
	 * @Date : 2019. 1. 17.
	 * @User : Administrator
	 * @Param : 시험준비물(기타) 
	 * @Return : 
	 * @Method 설명 : 시험준비물(기타) 정보 등록
	 */
	public void insert_job_exam_need_etc(SocietyFapJobExamNeedEtc jobExamNeedEtc){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_exam_need_etc(jobExamNeedEtc);
	}
	
	/**
	 * @Method Name : insert_job_exam_type
	 * @Date : 2019. 1. 17.
	 * @User : 원병호
	 * @Param : 시험종류 리스트
	 * @Return : 
	 * @Method 설명 : 시험종류 리스트 등록
	 */
	public void insert_job_exam_type(List<SocietyFapJobExamType> jobExamType_list){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_exam_type(jobExamType_list);
			
	}
	
	/**
	 * @Method Name : insert_job_itv_tp_etc
	 * @Date : 2019. 1. 17.
	 * @User : 원병호
	 * @Param : 면접방식(기타)
	 * @Return : 
	 * @Method 설명 : 면접방식(기타) 정보 등록
	 */
	public void insert_job_itv_tp_etc(SocietyFapJobItvTpEtc jobItvTpEtc){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_itv_tp_etc(jobItvTpEtc);
	}
	
	/**
	 * @Method Name : insert_job_itv_obj_etc
	 * @Date : 2019. 1. 17.
	 * @User : 원병호
	 * @Param : 면접대상자(기타)
	 * @Return : 
	 * @Method 설명 :
	 */
	public void insert_job_itv_obj_etc(SocietyFapJobItvObjEtc jobItvObjEtc){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_itv_obj_etc(jobItvObjEtc);
	}
	
	/**
	 * @Method Name : insert_job_test_etc_obj
	 * @Date : 2019. 1. 17.
	 * @User : 원병호
	 * @Param : 기타전형대상자(기타)
	 * @Return : 
	 * @Method 설명 : 기타전형대상자(기타) 정보 등록
	 */
	public void insert_job_test_etc_obj(SocietyFapJobTestEtcObj jobTestEtcObj){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_test_etc_obj(jobTestEtcObj);
	}
	
	/**
	 * @Method Name : insert_job_pay
	 * @Date : 2019. 1. 17.
	 * @User : 원병호
	 * @Param : 급여정보 리스트
	 * @Return : 
	 * @Method 설명 : 급여정보 리스트 등록후 seq 반환
	 */
	public List<SocietyFapJobPay> insert_job_pay(List<SocietyFapJobPay> jobPay_list){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_pay(jobPay_list);
		return jobPay_list;
	}
	
	/**
	 * @Method Name : insert_job_pay_base
	 * @Date : 2019. 1. 17.
	 * @User : 원병호
	 * @Param : 기본급 리스트
	 * @Return : 
	 * @Method 설명 : 기본급 리스트 등록후 seq 반환
	 */
	public List<SocietyFapJobPayBase> insert_job_pay_base(List<SocietyFapJobPayBase> jobPayBase_list){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_pay_base(jobPayBase_list);
		return jobPayBase_list;
	}
	
	/**
	 * @Method Name : insert_job_service_work
	 * @Date : 2019. 1. 17.
	 * @User : 원병호
	 * @Param : 서비스잔업수당
	 * @Return : 
	 * @Method 설명 : 서비스잔업수당 정보 등록
	 */
	public void insert_job_service_work(SocietyFapJobServiceWork jobServiceWork){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_service_work(jobServiceWork);
	}
	
	/**
	 * @Method Name : insert_job_pay_etc
	 * @Date : 2019. 1. 17.
	 * @User : Administrator
	 * @Param : 기타수당 리스트
	 * @Return : 
	 * @Method 설명 : 기타수당 리스트 등록
	 */
	public void insert_job_pay_etc(List<SocietyFapJobPayEtc> jobPayEtc_list){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_pay_etc(jobPayEtc_list);
	}
	
	/**
	 * @Method Name : insert_job_pay_extra
	 * @Date : 2019. 1. 17.
	 * @User : 원병호
	 * @Param : 잔업수당
	 * @Return : 
	 * @Method 설명 : 잔업수당 등록
	 */
	public void insert_job_pay_extra(SocietyFapJobPayExtra jobPayExtra){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_job_pay_extra(jobPayExtra);
	}
	
	/*--------------------------------------------채용공고 등록(분리) 끝 ----------------------------------*/
	
	/**
	 * @Method Name : select_job_pay
	 * @Date : 2019. 1. 10.
	 * @User : 원병호
	 * @Param : fap_job_ad_seq
	 * @Return : 급여 관련 모든 정보를 담은 map
	 * @Method 설명 : 급여 관련 모든 정보를 가져옵니다.
	 */
	public HashMap<String, Object> select_job_pay(long fap_jop_ad_seq){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		HashMap<String, Object> result = sfcMapper.select_job_pay(fap_jop_ad_seq);
		return result;
	}
	
	/**
	 * @Method Name : select_job_ad_list
	 * @Date : 2019. 1. 10.
	 * @User : 이재준
	 * @Param : fap_comp_id
	 * @Return : 채용공고 기본정보
	 * @Method 설명 : 채용공고 기본 정보 리스트 출력
	 */
	public ArrayList<SocietyFapJobAd> select_job_ad_list(String fap_comp_id) {
		logger.debug("채용공고 기본 정보 리스트 출력 시작");
		ArrayList<SocietyFapJobAd> jobAdList = null;
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		jobAdList= sfcMapper.select_job_ad_list(fap_comp_id);		
		logger.debug("채용공고 기본 정보 리스트 출력 완료");
		return jobAdList;
	}
	
	//채용공고 이전 끝
	
	/**
	 * @Method Name : select_job_ideal_person
	 * @Date : 2019. 1. 11.
	 * @User : 김준영
	 * @Param : 채용공고 정보 seq
	 * @Return : 채용공고 정보, 주요 업무 정보, 업무에 필요한 능력, 우대사항 
	 * @Method 설명 : 채용공고 정보, 주요 업무, 인재상, 기술상세를 가져오는 함수
	 */
	public HashMap<String, Object> select_job_ideal_person(long fap_job_ad_seq){
		logger.info("FAP 채용공고 정보, 주요 업무 정보, 업무에 필요한 능력, 우대사항 가져오기 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		HashMap<String, Object> job_ideal_person = sfcMapper.select_job_ideal_person(fap_job_ad_seq);
		logger.info("FAP 채용공고 정보, 주요 업무 정보, 업무에 필요한 능력, 우대사항 가져오기 DAO 종료");
		return job_ideal_person;
	}
	
	/**
	 * @Method Name : algorithm_company_setting_search
	 * @Date : 2019. 1. 11.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 
	 * @Method 설명 : 채용공고당 현지잡페어 시간 설정 조회
	 */
	public HashMap<String, Object> algorithm_company_setting_search(Long fap_job_ad_seq){
		logger.debug("채용공고당 알고리즘 시간설정 조회 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		HashMap<String, Object> result = sfcMapper.algorithm_company_setting_search(fap_job_ad_seq);
		logger.debug("채용공고당 알고리즘 시간설정 조회 DAO 종료");
		
		return result;
	}
	
	/**
	 * @Method Name : select_job_ad
	 * @Date : 2019. 1. 14.
	 * @User : 김준영
	 * @Param : 채용공고 정보 seq
	 * @Return : 채용공고 정보
	 * @Method 설명 : 기본 채용공고 정보를 가져오는 함수
	 */
	public SocietyFapJobAd select_job_ad(Long fap_job_ad_seq){
		logger.info("FAP 채용공고 정보 가져오기 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		SocietyFapJobAd jobAd = sfcMapper.select_job_ad(fap_job_ad_seq);
		logger.info("FAP 채용공고 정보 가져오기 DAO 종료");
		return jobAd;
	}
	
	/**
	 * @Method Name : select_job_recruit_pcs
	 * @Date : 2019. 1. 14.
	 * @User : 김준영
	 * @Param : 채용공고 정보 seq
	 * @Return : 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일
	 * @Method 설명 : 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_job_recruit_pcs(Long fap_job_ad_seq){
		logger.info("FAP 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일 정보 가져오기 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<HashMap<String, Object>> job_recruit_pcs = sfcMapper.select_job_recruit_pcs(fap_job_ad_seq);
		logger.info("FAP 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일 정보 가져오기 DAO 종료");
		return job_recruit_pcs;
	}
	
	/**
	 * @Method Name : select_job_category
	 * @Date : 2019. 1. 14.
	 * @User : 이재준
	 * @Param : 채용공고 정보 seq
	 * @Return : 모집직종 관련 모든 정보를 담은 map
	 * @Method 설명 : 모집직종 관련 모든 정보를 가져옵니다.
	 */
	public HashMap<String, Object> select_job_category(long fap_job_ad_seq){
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		HashMap<String, Object> result = sfcMapper.select_job_category(fap_job_ad_seq);
		return result;
	}

	/**
	 * @Method Name : search_company_jobfair_list
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 회사 아이디
	 * @Return : 회사 잡페어 정보 리스트
	 * @Method 설명 : 회사 잡페어 정보 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>>search_company_jobfair_list(String fap_comp_id){
		logger.info("FAP 회사 잡페어 정보 리스트 검색 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<HashMap<String, Object>>company_jobfair_list = sfcMapper.search_company_jobfair_list(fap_comp_id);
		
		logger.info("FAP 회사 잡페어 정보 리스트 검색 DAO 종료");
		return company_jobfair_list;
	}
	
	/**
	 * @Method Name : search_company_jobfair_divide_list
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스, 회사 아이디
	 * @Return : 회사 세부잡페어 정보 리스트
	 * @Method 설명 : 회사 세부잡페어 정보 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>>search_company_jobfair_divide_list(SocietyFapJobRecruitPcsSch recruit_pcs_sch){
		logger.info("FAP 회사 세부잡페어 정보 리스트 검색 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<HashMap<String, Object>>company_jobfair_divide_list = sfcMapper.search_company_jobfair_divide_list(recruit_pcs_sch);
		
		logger.info("FAP 회사 세부잡페어 정보 리스트 검색 DAO 종료");
		return company_jobfair_divide_list;
	}
	
	/**
	 * @Method Name : select_company_recruit_pcs_sch
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 채용기업 전형일정 스케줄 검색 정보
	 * @Return : 채용기업 전형일정 스케줄
	 * @Method 설명 : 채용기업 전형일정 스케줄 검색
	 */
	public ArrayList<HashMap<String, Object>> select_company_recruit_pcs_sch(SocietyFapJobRecruitPcsSch recruit_pcs_sch){
		logger.info("채용기업 전형일정 스케줄 검색 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<HashMap<String, Object>> recruit_pcs_sch_list = sfcMapper.select_company_recruit_pcs_sch(recruit_pcs_sch);
		
		logger.info("채용기업 전형일정 스케줄 검색 DAO 종료");
		return recruit_pcs_sch_list;
	}

	/**
	 * @Method Name : delete_job_recruit_pcs_selective
	 * @Date : 2019. 1. 16.
	 * @User : 김준영
	 * @Param : 채용공고 seq, 채용전형 seq
	 * @Return : -
	 * @Method 설명 : 수정에서 지운 채용전형을 지워주는 함수
	 */
	public void delete_job_recruit_pcs_selective(HashMap<String, Object> hashMap){
		logger.info("FAP 채용전형 선택적 삭제 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.delete_job_recruit_pcs_selective(hashMap);
		logger.info("FAP 채용전형 선택적 삭제 DAO 종료");
	}
	
	/**
	 * @return 
	 * @Method Name : update_job_ad
	 * @Date : 2019.01.16
	 * @User : 이재준
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 채용공고 기본 정보만 업데이트
	 */
	public long update_job_ad(SocietyFapJobAd JobAd) {
		logger.debug("FAP 채용공고 기본 정보 업데이트 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.update_job_ad(JobAd);
		long job_ad_parent_insert_seq = JobAd.getFap_job_ad_seq();
		logger.debug("FAP 채용공고 기본 정보 업데이트 DAO 종료");
		return job_ad_parent_insert_seq;
	}
	
	/**
	 * @Method Name : update_job_recruit_pcs
	 * @Date : 2019. 1. 15.
	 * @User : 김준영
	 * @Param : 채용전형 객체
	 * @Return : -
	 * @Method 설명 : 채용전형 수정
	 */
	public void update_job_recruit_pcs(SocietyFapJobRecruitPcs jobRecruitPcs){
		logger.info("FAP 채용전형 수정 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.update_job_recruit_pcs(jobRecruitPcs);
		logger.info("FAP 채용전형 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : select_pcs_seq_list
	 * @Date : 2019. 1. 16.
	 * @User : 김준영
	 * @Param : 채용공고 seq
	 * @Return : 채용전형 seq list
	 * @Method 설명 : 채용공고에 해당하는 채용전형 seq list를 가져오는 함수
	 */
	public ArrayList<Long> select_pcs_seq_list(Long fap_job_ad_seq){
		logger.info("FAP 채용전형 시퀀스 가져오기 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<Long> select_pcs_seq_list = sfcMapper.select_pcs_seq_list(fap_job_ad_seq);
		logger.info("FAP 채용전형 시퀀스 가져오기 DAO 종료");
		return select_pcs_seq_list;
	}
	/**
	 * @Method Name : delete_job_ad
	 * @Date : 2019.01.16
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 정보 삭제(sub)
	 */
	public void delete_job_ad(long fap_job_ad_seq) {
		logger.debug("FAP 채용공고(sub) 삭제 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.delete_job_dorm(fap_job_ad_seq);
		sfcMapper.delete_job_jit_employee(fap_job_ad_seq);
		sfcMapper.delete_job_category(fap_job_ad_seq);
		sfcMapper.delete_job_comp(fap_job_ad_seq);
		sfcMapper.delete_job_file(fap_job_ad_seq);
		sfcMapper.delete_job_isr(fap_job_ad_seq);
		sfcMapper.delete_job_ja_level(fap_job_ad_seq);
		sfcMapper.delete_job_join_dt(fap_job_ad_seq);
		sfcMapper.delete_job_pay(fap_job_ad_seq);
		sfcMapper.delete_job_pref(fap_job_ad_seq);
		sfcMapper.delete_job_trial(fap_job_ad_seq);
		sfcMapper.delete_job_work(fap_job_ad_seq);
		sfcMapper.delete_job_workplace(fap_job_ad_seq);
		
		logger.debug("FAP 채용공고(sub) 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : select_company_review_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 채용기업 서류전형 시퀀스
	 * @Return : 채용기업 서류전형 정보
	 * @Method 설명 : 채용기업 서류전형 정보 검색
	 */
	public HashMap<String, Object> select_company_review_pcs(long fap_job_recruit_pcs_seq){
		logger.info("채용기업 서류전형 정보 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		HashMap<String, Object> company_review_pcs_info = sfcMapper.select_company_review_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("채용기업 서류전형 정보 DAO 종료");
		return company_review_pcs_info;
	}
	
	/**
	 * @Method Name : select_company_exam_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 채용기업 시험전형 시퀀스
	 * @Return : 채용기업 시험전형 정보
	 * @Method 설명 : 채용기업 시험전형 정보 검색
	 */
	public HashMap<String, Object> select_company_exam_pcs(long fap_job_recruit_pcs_seq){
		logger.info("채용기업 시험전형 정보 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		HashMap<String, Object> company_exam_pcs_info = sfcMapper.select_company_exam_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("채용기업 시험전형 정보 DAO 종료");
		return company_exam_pcs_info;
	}
	
	/**
	 * @Method Name : select_company_itv_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 채용기업 면접전형 시퀀스
	 * @Return : 채용기업 면접전형 정보
	 * @Method 설명 : 채용기업 면접전형 정보 검색
	 */
	public HashMap<String, Object> select_company_itv_pcs(long fap_job_recruit_pcs_seq){
		logger.info("채용기업 면접전형 정보 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		HashMap<String, Object> company_itv_pcs_info = sfcMapper.select_company_itv_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("채용기업 면접전형 정보 DAO 종료");
		return company_itv_pcs_info;
	}
	
	/**
	 * @Method Name : select_company_test_etc_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 채용기업 기타전형 시퀀스
	 * @Return : 채용기업 기타전형 정보
	 * @Method 설명 : 채용기업 기타전형 정보 검색
	 */
	public HashMap<String, Object> select_company_test_etc_pcs(long fap_job_recruit_pcs_seq){
		logger.info("채용기업 기타전형 정보 DAO 시작");
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		HashMap<String, Object> company_test_etc_pcs_info = sfcMapper.select_company_test_etc_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("채용기업 기타전형 정보 DAO 종료");
		return company_test_etc_pcs_info;
	}
	
	/**
	 * @Method Name : editable_check
	 * @Date : 2019. 1. 17.
	 * @User : 김준영
	 * @Param : 채용전형 seq
	 * @Return : 전형별지원결과정보 seq list
	 * @Method 설명 : 채용전형의 수정 가능 여부를 확인 하는 함수
	 */
	public int editable_check(long fap_job_recruit_pcs_seq){
		logger.info("FAP 채용전형 수정 가능 여부 확인 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int editable_check = sfcMapper.editable_check(fap_job_recruit_pcs_seq);
		logger.info("FAP 채용전형 수정 가능 여부 확인 DAO 종료");
		return editable_check;
	}
	
	/**
	 * @Method Name : delete_job_recurit_pcs_sub
	 * @Date : 2019. 1. 18.
	 * @User : 김준영
	 * @Param : 채용전형 seq
	 * @Return : -
	 * @Method 설명 : 시험전형, 면접전형, 기타전형을 삭제하는 함수
	 */
	public void delete_job_recurit_pcs_sub(long fap_job_recruit_pcs_seq){
		logger.info("FAP 시험전형, 면접전형, 기타전형 삭제 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.delete_job_exam(fap_job_recruit_pcs_seq);
		sfcMapper.delete_job_itv(fap_job_recruit_pcs_seq);
		sfcMapper.delete_job_test_etc(fap_job_recruit_pcs_seq);
		logger.info("FAP 시험전형, 면접전형, 기타전형 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : terms_update
	 * @Date : 2019. 1. 23.
	 * @User : 김준영
	 * @Param : 회원 객체
	 * @Return : 함수 작동 여부
	 * @Method 설명 : 회원의 약관 동의를 업데이트 하는 함수
	 */
	public int terms_update(User user){
		logger.info("FAP 회원 약관 동의 변경 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int check = sfcMapper.terms_update(user);
		logger.info("FAP 회원 약관 동의 변경 DAO 종료");
		return check;
	}
	
	/**
	 * @Method Name : select_job_ad_by_state
	 * @Date : 2019. 1. 24.
	 * @User : 원병호
	 * @Param : hashmap (fap_comp_id, jobfair_seq, jobfair_divide_seq)
	 * @Return : 
	 * @Method 설명 : 대기중인 채용공고 정보 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_job_ad_by_state(HashMap<String, Object> parmas){
		logger.info("FAP 대기중인 채용공고를 가져오는 함수 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<HashMap<String, Object>> result = sfcMapper.select_job_ad_by_state(parmas);
		logger.info("FAP 대기중인 채용공고를 가져오는 함수 끝");
		return result;
	}
	
	
	
	/**
	 * @Method Name : update_job_ad_state
	 * @Date : 2019. 1. 26.
	 * @User : Administrator
	 * @Param : SocietyFapJobAd
	 * @Return : 
	 * @Method 설명 : 채용공고 상태를 수정하는 함수
	 */
	public int update_job_ad_state(SocietyFapJobAd jobAd){
		logger.info("FAP 채용공고 상태를 수정하는 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int result = sfcMapper.update_job_ad_state(jobAd);
		logger.info("FAP 채용공고 상태를 수정하는 DAO 끝");
		return result; 
	}

	/**
	 * @Method Name : insert_connect_request
	 * @Date : 2019. 2. 7.
	 * @User : 김준영
	 * @Param : 기업 - 담당자 연결 요청 객체
	 * @Return : 요청 등록 성공 여부
	 * @Method 설명 : 기업 - 담당자 연결을 요청하는 함수
	 */
	public int insert_connect_request(SocietyFapCompUserConnectRequest CompUserConnectRequest){
		logger.info("FAP 기업 - 담당자 연결 요청 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int result = sfcMapper.insert_connect_request(CompUserConnectRequest);
		logger.info("FAP 기업 - 담당자 연결 요청 DAO 종료");
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
	public ArrayList<SocietyFapCompUserConnectRequest> select_comp_user_connect_request(String user_id){
		logger.info("FAP 기업 - 담당자 연결 요청 가져오기 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<SocietyFapCompUserConnectRequest> CompUserConnectRequest = sfcMapper.select_comp_user_connect_request(user_id);
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
	public int delete_connect_request(int fap_comp_user_request_seq){
		logger.info("FAP 기업 - 담당자 연결 요청 삭제 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int result = sfcMapper.delete_connect_request(fap_comp_user_request_seq);
		logger.info("FAP 기업 - 담당자 연결 요청 삭제 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : company_pay_for_cost
	 * @Date : 2019. 2. 8.
	 * @User : 이종호
	 * @Param : 유저 아이디
	 * @Return : -
	 * @Method 설명 : FAP 기업 - 비용결제 검색
	 */
	public ArrayList<HashMap<String, Object>> company_pay_for_cost(HashMap<String, Object> params){
		logger.info("FAP 기업 - 비용결제 검색 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<HashMap<String, Object>> result = sfcMapper.company_pay_for_cost(params);
		logger.info("FAP 기업 - 비용결제 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_job_ad_load_list_paging
	 * @Date : 2019. 2. 9.
	 * @User : 정대영
	 * @Param : 기업 아이디
	 * @Return : 채용공고
	 * @Method 설명 : 기업이 작성한 모든 채용공고를 불러오는 함수(페이징 처리 후) 
	 */
	public ArrayList<HashMap<String, Object>> select_job_ad_load_list_paging(HashMap<String, Object> paramMap, int start, int countPerPage){
		logger.info("FAP 기업이 작성한 채용공고 리스트 가져오기 DAO 시작");
		RowBounds rb = new RowBounds(start, countPerPage);
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<HashMap<String, Object>> select_job_ad_load_list = sfcMapper.select_job_ad_load_list_paging(paramMap, rb);
		logger.info("FAP 기업이 작성한 채용공고 리스트 가져오기 DAO 종료");
		return select_job_ad_load_list;
	}
	
	/**
	 * @Method Name : select_job_ad_load_list_count
	 * @Date : 2019. 2. 9.
	 * @User : 정대영
	 * @Param : 기업 아이디
	 * @Return : 채용공고 개수
	 * @Method 설명 : 기업이 작성한 모든 채용공고 총 개수를 불러오는 함수 
	 */
	public int select_job_ad_load_list_count(HashMap<String, Object> paramMap){
		logger.info("FAP 기업이 작성한 채용공고 리스트 총 개수 가져오기 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int adTotalCount = sfcMapper.select_job_ad_load_list_count(paramMap);
		logger.info("FAP 기업이 작성한 채용공고 리스트 총 개수 가져오기 DAO 종료");
		return adTotalCount;
	}
	
	/**
	 * @Method Name : delete_job_ad_box
	 * @Date : 2019. 2. 11.
	 * @User : 김준영
	 * @Param : 채용공고 seq
	 * @Return : 삭제 여부
	 * @Method 설명 : 채용공고를 삭제하는 함수
	 */
	public int delete_job_ad_box(long fap_job_ad_seq){
		logger.info("FAP 채용공고 삭제 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int result = sfcMapper.delete_job_ad_box(fap_job_ad_seq);
		logger.info("FAP 채용공고 삭제 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_job_file
	 * @Date : 2019. 2. 11.
	 * @User : 원병호
	 * @Param : 채용공고 seq
	 * @Return : 채용공고 파일 리스트
	 * @Method 설명 : 해당 채용공고의 첨부파일을 불러오는 함수
	 */
	public ArrayList<SocietyFapJobFile> select_job_file(long fap_job_ad_seq){
		logger.info("FAP 채용공고 파일 리스트 가져오기 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<SocietyFapJobFile> result = sfcMapper.select_job_file(fap_job_ad_seq);
		logger.info("FAP 채용공고 파일 리스트 가져오기 DAO 종료");
		return result;
	}
		
	/**
	 * @Method Name : board_contents_search
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : 게시판 관리의 특정 게시판 정보 객체
	 * @Return : fap 공지사항 게시글 리스트
	 * @Method 설명 : 게시글 리스트를 가져오는 함수
	 */
	public ArrayList<BoardContent> company_board_contents_search(HashMap<String, Object> map){
		logger.info("FAP 공지사항 가져오기 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<BoardContent> notice_list = sfcMapper.company_board_contents_search(map);
		logger.info("FAP 공지사항 가져오기 DAO 종료");
		return notice_list;
	}
	
	/**
	 * @Method Name : board_contents_count
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : 게시판 관리의 특정 게시판 정보 객체
	 * @Return : fap 공지사항 게시판의 게시글 갯수
	 * @Method 설명 : 페이징을 위한 전체글 갯수 조회하는 함수
	 */
	public int board_contents_count(HashMap<String, Object> map){
		logger.info("FAP 공지사항 게시글 갯수 가져오기 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int count = sfcMapper.board_contents_count(map);
		logger.info("FAP 공지사항 게시글 갯수 가져오기 DAO 시작");
		return count;
	}
	
	/**
	 * @Method Name : company_board_contents_list_search
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : 게시판 시퀀스
	 * @Return : 기업 잡페어 공지사항 게시판 리스트
	 * @Method 설명 : 기업 잡페어 공지사항 게시판 리스트 검색 함수
	 */
	public ArrayList<BoardContent> company_board_contents_list_search(HashMap<String, Object> map){
		
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<BoardContent> notice_list = sfcMapper.company_board_contents_list_search(map);

		return notice_list;
	}
	
	/**
	 * @Method Name : search_applicant_info
	 * @Date : 2019. 2. 15.
	 * @User : 신동철
	 * @Param : 채용공고 seq, 회사 아이디
	 * @Return : 채용전형 진행중, 합격, 추가합격 정규지원자 정보
	 * @Method 설명 : 채용전형 진행중, 합격, 추가합격 정규지원자 정보 불러오는 함수
	 */
	public ArrayList<HashMap<String, Object>> search_applicant_info(HashMap<String, Object> hashmap){
		logger.info("FAP 채용전형 진행중, 합격, 추가합격 정규지원자 정보 불러오기 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<HashMap<String, Object>> missResultMap = sfcMapper.search_applicant_info(hashmap);
		logger.info("FAP 채용전형 진행중, 합격, 추가합격 정규지원자 정보 불러오기 DAO 종료");
		return missResultMap;
	}
		
	/**
	 * @Method Name : select_job_ad_recruit_pcs
	 * @Date : 2019. 2. 15.
	 * @User : 신동철
	 * @Param : 채용공고 시퀀스
	 * @Return : 채용공고 채용전형 정보
	 * @Method 설명 : 채용공고 지원자관리 채용전형 정보 검색 함수
	 */
	public ArrayList<SocietyFapJobRecruitPcs> select_job_ad_recruit_pcs(long fap_job_ad_seq){
		logger.info("FAP 채용공고 지원자관리 채용전형 정보 검색 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<SocietyFapJobRecruitPcs> recruit_pcs = sfcMapper.select_job_ad_recruit_pcs(fap_job_ad_seq);
		logger.info("FAP 채용공고 지원자관리 채용전형 정보 검색 DAO 종료");
		return recruit_pcs;
	}

	/**
	 * @Method Name : select_my_applied_resume
	 * @Date : 2019. 02. 19.
	 * @User : 남유송
	 * @Param : int
	 * @Return : HashMap
	 * @Method 설명 : 채용공고별 지원자 이력서 가져오기
	 */
	public HashMap<String, Object> selectResumeApply(int fap_resume_seq) {
		logger.info("FAP 채용공고별 지원자 이력서 가져오기 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		HashMap<String, Object> wholeResume = sfcMapper.selectResumeApply(fap_resume_seq);
		logger.info("FAP 채용공고별 지원자 이력서 가져오기 시작");
		return wholeResume;
	}
	
	/**
	 * @Method Name : search_unaccepted_applicant_info
	 * @Date : 2019. 2. 19.
	 * @User : 신동철
	 * @Param : 채용공고 seq, 회사 아이디
	 * @Return : 채용전형 불합격 지원자 정보
	 * @Method 설명 : 채용전형 불합격 지원자 정보 불러오는 함수
	 */
	public ArrayList<HashMap<String, Object>> search_unaccepted_applicant_info(HashMap<String, Object> hashmap){
		logger.info("FAP 채용전형 불합격 지원자 정보 불러오기 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<HashMap<String, Object>> resultMap = sfcMapper.search_unaccepted_applicant_info(hashmap);
		logger.info("FAP 채용전형 불합격 지원자 정보 불러오기 DAO 종료");
		return resultMap;
	}
	
	/**
	 * @Method Name : board_contents_detail
	 * @Date : 2019. 2. 19.
	 * @User : 김준영
	 * @Param : 게시판 내용 seq
	 * @Return : 게시판 세부 내용
	 * @Method 설명 : 게시판 세부 내용을 가져오는 함수
	 */
	public HashMap<String, Object> board_contents_detail(int board_content_seq){
		logger.info("FAP 게시판 세부내용 가져오기 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		HashMap<String, Object> board_content = sfcMapper.board_contents_detail(board_content_seq);
		logger.info("FAP 게시판 세부내용 가져오기 DAO 시작");
		return board_content;
	}
	
	/**
	 * @Method Name : select_job_exam_file
	 * @Date : 2019. 2. 19.
	 * @User : 원병호
	 * @Param : 채용공고 시퀀스
	 * @Return : 시험전형 파일 리스트
	 * @Method 설명 : 해당 채용공고의 시험전형 파일 리스트 검색
	 */
	public ArrayList<SocietyFapJobExamFile> select_job_exam_file(long fap_job_ad_seq){
		logger.info("FAP 채용공고 시험전형 파일 정보 검색 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<SocietyFapJobExamFile> result = sfcMapper.select_job_exam_file(fap_job_ad_seq);
		logger.info("FAP 채용공고 시험전형 파일 정보 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : search_missmatching_applicant_info
	 * @Date : 2019. 2. 21.
	 * @User : 신동철
	 * @Param : 채용공고 seq, 회사 아이디
	 * @Return : 채용전형 진행중, 합격, 추가합격 미스매칭 지원자 정보
	 * @Method 설명 : 채용전형 진행중, 합격, 추가합격 미스매칭 지원자 정보 불러오는 함수
	 */
	public ArrayList<HashMap<String, Object>> search_missmatching_applicant_info(HashMap<String, Object> hashmap){
		logger.info("FAP 채용전형 진행중, 합격, 추가합격 미스매칭 지원자 정보 불러오기 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<HashMap<String, Object>> resultMap = sfcMapper.search_missmatching_applicant_info(hashmap);
		logger.info("FAP 채용전형 진행중, 합격, 추가합격 미스매칭 지원자 정보 불러오기 DAO 종료");
		return resultMap;
	}
	
	/**
	 * @Method Name : update_fap_job_apply_result
	 * @Date : 2019. 2. 19.
	 * @User : 신동철
	 * @Param : 전형별 결과
	 * @Return : -
	 * @Method 설명 : 지원자 전형별 지원결과 수정하는 함수
	 */
	public int update_fap_job_apply_result(ArrayList<SocietyFapJobApplyResult> applyResultList){
		logger.info("FAP 채용전형 지원자 전형별 지원결과 수정 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int result = sfcMapper.update_fap_job_apply_result(applyResultList);
		logger.info("FAP 채용전형 지원자 전형별 지원결과 수정 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : update_fap_job_final_result
	 * @Date : 2019. 2. 19.
	 * @User : 신동철
	 * @Param : 최종결과
	 * @Return : -
	 * @Method 설명 : 채용전형 지원자 최종결과 수정하는 함수
	 */
	public void update_fap_job_final_result(ArrayList<SocietyFapJobApplyFinalResult> finalResultList){
		logger.info("FAP 채용전형 지원자 최종결과 수정 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.update_fap_job_final_result(finalResultList);
		logger.info("FAP 채용전형 지원자 최종결과 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : insert_pass_comment
	 * @Date : 2019. 2. 24.
	 * @User : 신동철
	 * @Param : 최종결과 합격사유
	 * @Return : -
	 * @Method 설명 : 지원자 최종결과 합격사유 등록하는 함수
	 */
	public void insert_pass_comment(SocietyFapJobApplyFinalResult passComment){
		logger.info("FAP 채용전형 지원자 최종결과 합격사유 등록 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_pass_comment(passComment);
		logger.info("FAP 채용전형 지원자 최종결과 합격사유 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : insert_nominee
	 * @Date : 2019. 2. 26.
	 * @User : 신동철
	 * @Param : 내정자 리스트
	 * @Return : -
	 * @Method 설명 : 최종결과 합격한 내정자를 등록하는 함수
	 */
	public void insert_nominee(ArrayList<SocietyFapNominee> nomineeList){
		logger.info("FAP 채용전형 지원자 최종결과 합격한 내정자를 등록 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.insert_nominee(nomineeList);
		logger.info("FAP 채용전형 지원자 최종결과 합격한 내정자를 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : select_nominee
	 * @Date : 2019. 2. 26.
	 * @User : 신동철
	 * @Param : 채용공고시퀀스, 지원자 아이디
	 * @Return : 내정자 정보
	 * @Method 설명 : 최종결과 합격한 내정자 정보를 검색하는 함수
	 */
	public SocietyFapNominee select_nominee(HashMap<String, Object> hashmap){
		logger.info("FAP 채용전형 최종결과 합격한 내정자 정보 검색 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		SocietyFapNominee savedNominee = sfcMapper.select_nominee(hashmap);
		logger.info("FAP 채용전형 최종결과 합격한 내정자 정보 검색 DAO 종료");
		return savedNominee;
	}
	
	/**
	 * @Method Name : delete_nominee
	 * @Date : 2019. 2. 26.
	 * @User : 신동철
	 * @Param : 내정자 시퀀스
	 * @Return : -
	 * @Method 설명 : 최종결과가 불합격으로 바뀐 내정자 삭제하는 함수
	 */
	public void delete_nominee(long fap_nominee_seq){
		logger.info("FAP 채용전형 최종결과가 불합격으로 바뀐 내정자 삭제 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.delete_nominee(fap_nominee_seq);
		logger.info("FAP 채용전형 최종결과가 불합격으로 바뀐 내정자 삭제 DAO 종료");
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
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<HashMap<String, Object>> result = sfcMapper.select_job_qna(fap_job_ad_seq);
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
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		HashMap<String, Object> result = sfcMapper.select_job_qna_one(fap_job_qna_question_seq);
		logger.info("FAP 채용전형  Q&A 상세  DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : insert_job_qna_question
	 * @Date : 2019. 3. 6.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 답변 객체
	 * @Return : 
	 * @Method 설명 : 채용공고 Q&A 답변 등록
	 */
	public int insert_job_qna_question(SocietyFapQnaAnswer qnaAnswer){
		logger.info("FAP 채용전형 Q&A 답변 등록 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int result = sfcMapper.insert_job_qna_question(qnaAnswer);
		logger.info("FAP 채용전형  Q&A 답변 등록  DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : update_job_qna_question_approve
	 * @Date : 2019. 3. 6.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 질문 일련번호
	 * @Return : 
	 * @Method 설명 : 답변완료로 상태 변경
	 */
	public void update_job_qna_question_approve(long fap_job_qna_question_seq){
		logger.info("FAP 채용전형 Q&A 답변 완료(질문 테이블 수정)DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.update_job_qna_question_approve(fap_job_qna_question_seq);
		logger.info("FAP 채용전형 Q&A 답변 완료(질문 테이블 수정)DAO 끝");
	}
	
	/**
	 * @Method Name : insert_job_qna_question
	 * @Date : 2019. 3. 6.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 답변 객체
	 * @Return : 
	 * @Method 설명 : 채용공고 Q&A 답변 수정
	 */
	public void update_job_qna_question(SocietyFapQnaAnswer qnaAnswer){
		logger.info("FAP 채용전형 Q&A 답변 수정 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.update_job_qna_question(qnaAnswer);
		logger.info("FAP 채용전형  Q&A 답변 수정  DAO 종료");
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
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);		
		HashMap<String, Object> hashmap = sfcMapper.search_jobfair_divide_final_select_info(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 세부별 최종합격자 결정 시한 설정 정보 검색 DAO 종료");
		return hashmap;
	}
	
	/**
	 * @Method Name : board_contents_hit_update
	 * @Date : 2019. 7. 16.
	 * @User : 김경아	
	 * @Param : 게시글 시퀀스
	 * @Return : 
	 * @Method 설명 : 해당 게시글의 세부 내용 중 조회수를 증가 시키는 DAO 함수
	 */
	public void board_contents_hit_update(int board_content_seq) {
     logger.debug("게시글 세부 내용 중 조회수 증가 DAO 함수 시작");
		
 	    SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
 	    sfcMapper.board_contents_hit_update(board_content_seq);
		
		logger.debug("게시글 세부 내용 중 조회수 증가 DAO 함수 종료");
		
	}

	/**
	 * @Method Name : select_comp_name
	 * @Date : 2019. 7. 21.
	 * @User : 김경아		
	 * @Param : 게시판 세부구분
	 * @Return : 게시판 이름 
	 * @Method 설명 : 게시판 이름 조회 
	 */
	public String select_comp_name(String board_detail_gb) {
		logger.info("FAP 오픈잡페어 기업 게시판 이름 조회 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		String result= sfcMapper.select_comp_name(board_detail_gb);
		logger.info("FAP 오픈잡페어 기업 게시판 이름 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_interview_limit_check
	 * @Date : 2019. 8. 1.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 채용공고별 현지면접인원 제한 정보
	 * @Method 설명 : 채용공고별 현지면접 대상자 인원제한 체크용 검색
	 */
	public HashMap<String, Object> select_interview_limit_check(long fap_job_ad_seq){
		logger.info("FAP 채용공고별 현지면접 대상자 인원제한 체크용 검색 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		HashMap<String, Object> result = sfcMapper.select_interview_limit_check(fap_job_ad_seq);
		logger.info("FAP 채용공고별 현지면접 대상자 인원제한 체크용 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_interview_limit_type
	 * @Date : 2019. 8. 1.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 현지면접인원 제한 계열
	 * @Method 설명 : 잡페어별 현지면접인원 제한 계열 검색
	 */
	public String select_interview_limit_type(int fap_jobfair_seq) {
		logger.info("FAP 잡페어별 현지면접인원 제한 계열 검색 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		String result = sfcMapper.select_interview_limit_type(fap_jobfair_seq);
		logger.info("FAP 잡페어별 현지면접인원 제한 계열 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_screening_date_check
	 * @Date : 2019. 9. 24.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : 도쿄페어 기업 전형 등록 가능 여부 ( 1: 가능 , 0: 불가능 )
	 * @Method 설명 : 도쿄페어 기업 전형 등록 가능 여부 ( 1: 가능 , 0: 불가능 ) 조회
	 */
	public int tokyofair_screening_date_check(int fap_jobfair_divide_seq) {
		logger.info("FAP 도쿄페어 기업 전형 등록 가능 여부 ( 1: 가능 , 0: 불가능 ) 조회 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int result = sfcMapper.tokyofair_screening_date_check(fap_jobfair_divide_seq);
		logger.info("FAP 도쿄페어 기업 전형 등록 가능 여부 ( 1: 가능 , 0: 불가능 ) 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_screening_subject_search
	 * @Date : 2019. 9. 26.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 도쿄페어 전형 대상자
	 * @Method 설명 : 도쿄페어 전형 대상자 조회
	 */
	public ArrayList<HashMap<String, Object>> tokyofair_screening_subject_search(long fap_job_ad_seq){
		logger.info("FAP 도쿄페어 전형 대상자 조회 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<HashMap<String, Object>> result = sfcMapper.tokyofair_screening_subject_search(fap_job_ad_seq);
		logger.info("FAP 도쿄페어 전형 대상자 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_screening_subject_search_some
	 * @Date : 2019. 9. 26.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 도쿄페어 전형 확정대상자 제외 대상자
	 * @Method 설명 : 도쿄페어 전형 확정대상자 제외 대상자 조회 시작
	 */
	public ArrayList<HashMap<String, Object>> tokyofair_screening_subject_search_some(long fap_job_ad_seq){
		logger.info("FAP 도쿄페어 전형 확정대상자 제외 대상자 조회 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<HashMap<String, Object>> result = sfcMapper.tokyofair_screening_subject_search_some(fap_job_ad_seq);
		logger.info("FAP 도쿄페어 전형 확정대상자 제외 대상자 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_scr_user_select_group
	 * @Date : 2019. 9. 30.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 시퀀스
	 * @Return : 도쿄페어 전형별 등록인원
	 * @Method 설명 : 도쿄페어 전형별 등록인원 조회
	 */
	public ArrayList<HashMap<String, Object>> tokyofair_scr_user_select_group(int fap_tokyofair_screening_seq){
		logger.info("FAP 도쿄페어 전형별 등록인원 조회 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<HashMap<String, Object>> result = sfcMapper.tokyofair_scr_user_select_group(fap_tokyofair_screening_seq);
		logger.info("FAP 도쿄페어 전형별 등록인원 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_screening_insert
	 * @Date : 2019. 9. 26.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 전형 정보 등록  
	 */
	public void tokyofair_screening_insert(SocietyFapTokyofairScreening tokyofairScr) {
		logger.info("FAP 도쿄페어 전형 정보 등록 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.tokyofair_screening_insert(tokyofairScr);
		logger.info("FAP 도쿄페어 전형 정보 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : tokyofair_scr_user_insert
	 * @Date : 2019. 9. 26.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 인원 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 전형 인원 정보 등록 
	 */
	public void tokyofair_scr_user_insert(List<SocietyFapTokyofairScrUser> scrUserList) {
		logger.info("FAP 도쿄페어 전형 인원 정보 등록 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.tokyofair_scr_user_insert(scrUserList);
		logger.info("FAP 도쿄페어 전형 인원 정보 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : tokyofair_scr_user_select
	 * @Date : 2019. 9. 26.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 도쿄페어 전형 등록 인원
	 * @Method 설명 : 도쿄페어 전형 등록 인원 조회
	 */
	public ArrayList<SocietyFapTokyofairScrUser> tokyofair_scr_user_select(long fap_job_ad_seq){
		logger.info("FAP 도쿄페어 전형 등록 인원 조회 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<SocietyFapTokyofairScrUser> result = sfcMapper.tokyofair_scr_user_select(fap_job_ad_seq);
		logger.info("FAP 도쿄페어 전형 등록 인원 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_screening_search_count
	 * @Date : 2019. 9. 26.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 도쿄페어 전형 등록 개수
	 * @Method 설명 : 도쿄페어 전형 등록 개수 조회 
	 */
	public int tokyofair_screening_search_count(long fap_job_ad_seq) {
		logger.info("FAP 도쿄페어 전형 등록 개수 조회  DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int count = sfcMapper.tokyofair_screening_search_count(fap_job_ad_seq);
		logger.info("FAP 도쿄페어 전형 등록 개수 조회  DAO 종료");
		return count;
	}
	
	/**
	 * @Method Name : tokyofair_screening_search
	 * @Date : 2019. 9. 27.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 도쿄페어 전형 리스트
	 * @Method 설명 : 도쿄페어 전형 리스트 조회
	 */
	public ArrayList<SocietyFapTokyofairScreening> tokyofair_screening_search(long fap_job_ad_seq){
		logger.info("FAP 도쿄페어 전형 리스트 조회 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<SocietyFapTokyofairScreening> result = sfcMapper.tokyofair_screening_search(fap_job_ad_seq);
		logger.info("FAP 도쿄페어 전형 리스트 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_screening_search_one
	 * @Date : 2019. 9. 27.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 시퀀스
	 * @Return : 도쿄페어 전형 정보
	 * @Method 설명 : 도쿄페어 전형 정보 조회
	 */
	public HashMap<String, Object> tokyofair_screening_search_one(int fap_tokyofair_screening_seq){
		logger.info("FAP 도쿄페어 전형 정보 조회 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		HashMap<String, Object> result = sfcMapper.tokyofair_screening_search_one(fap_tokyofair_screening_seq);
		logger.info("FAP 도쿄페어 전형 정보 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_screening_delete
	 * @Date : 2019. 9. 30.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 전형 삭제 
	 */
	public int tokyofair_screening_delete(int fap_tokyofair_screening_seq) {
		logger.info("FAP 도쿄페어 전형 삭제 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int result =  sfcMapper.tokyofair_screening_delete(fap_tokyofair_screening_seq);
		logger.info("FAP 도쿄페어 전형 삭제 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_screening_update
	 * @Date : 2019. 9. 30.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 전형 정보 수정 
	 */
	public void tokyofair_screening_update(SocietyFapTokyofairScreening tokyofairScr) {
		logger.info("FAP 도쿄페어 전형 정보 수정 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.tokyofair_screening_update(tokyofairScr);
		logger.info("FAP 도쿄페어 전형 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : tokyofair_scr_user_delete
	 * @Date : 2019. 9. 30.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 인원 정보 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 전형 인원 정보 삭제 
	 */
	public void tokyofair_scr_user_delete(int fap_tokyofair_screening_seq) {
		logger.info("FAP 도쿄페어 전형 인원 정보 삭제 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.tokyofair_scr_user_delete(fap_tokyofair_screening_seq);
		logger.info("FAP 도쿄페어 전형 인원 정보 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : tokyofair_schedule_set_search
	 * @Date : 2019. 10. 1.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : 설정된 도쿄페어 설정 정보
	 * @Method 설명 : 설정된 도쿄페어 설정 정보 조회
	 */
	public SocietyFapAdminJobfairSet tokyofair_schedule_set_search(int fap_jobfair_divide_seq) {
		logger.info("FAP 설정된 도쿄페어 설정 정보 조회 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		SocietyFapAdminJobfairSet jobfairSet = sfcMapper.tokyofair_schedule_set_search(fap_jobfair_divide_seq);
		logger.info("FAP 설정된 도쿄페어 설정 정보 조회 DAO 종료");
		return jobfairSet;
	}
	
	/**
	 * @Method Name : tokyofair_screening_search_bookable
	 * @Date : 2019. 10. 4.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 도쿄페어 전형 중 예약 가능한 리스트
	 * @Method 설명 : 도쿄페어 전형 중 예약 가능한 리스트 조회 
	 */
	public ArrayList<SocietyFapTokyofairScreening> tokyofair_screening_search_bookable(long fap_job_ad_seq){
		logger.info("FAP 도쿄페어 전형 중 예약 가능한 리스트 조회 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<SocietyFapTokyofairScreening> result = sfcMapper.tokyofair_screening_search_bookable(fap_job_ad_seq);
		logger.info("FAP 도쿄페어 전형 중 예약 가능한 리스트 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_date_check
	 * @Date : 2019. 10. 4.
	 * @User : 이종호
	 * @Param : 도쿄페어 날짜 정보
	 * @Return : 도쿄페어 날짜 시퀀스
	 * @Method 설명 : 도쿄페어 날짜 등록여부 확인
	 */
	public int tokyofair_schedule_date_check(HashMap<String, Object> params) {
		logger.info("FAP 도쿄페어 날짜 등록여부 확인 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		Integer result = sfcMapper.tokyofair_schedule_date_check(params);
		int fap_tokyofair_date_seq = result == null ? 0 : result;
		logger.info("FAP 도쿄페어 날짜 등록여부 확인 DAO 종료");
		return fap_tokyofair_date_seq;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_date_insert
	 * @Date : 2019. 10. 4.
	 * @User : 이종호
	 * @Param : 도쿄페어 날짜 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 날짜 정보 등록 
	 */
	public int tokyofair_schedule_date_insert(HashMap<String, Object> params) {
		logger.info("FAP 도쿄페어 날짜 정보 등록 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int result = sfcMapper.tokyofair_schedule_date_insert(params);
		logger.info("FAP 도쿄페어 날짜 정보 등록 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_info_insert
	 * @Date : 2019. 10. 4.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 일정 정보 등록 
	 */
	public int tokyofair_schedule_info_insert(HashMap<String, Object> params) {
		logger.info("FAP 도쿄페어 일정 정보 등록 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int result = sfcMapper.tokyofair_schedule_info_insert(params);
		logger.info("FAP 도쿄페어 일정 정보 등록 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_info_check
	 * @Date : 2019. 10. 4.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 정보
	 * @Return : 0 가능, 1 불가능
	 * @Method 설명 : 도쿄페어 일정 가능여부 확인
	 */
	public int tokyofair_schedule_info_check(HashMap<String, Object> params) {
		logger.info("FAP 도쿄페어 일정 가능여부 확인 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int result = sfcMapper.tokyofair_schedule_info_check(params);
		logger.info("FAP 도쿄페어 일정 가능여부 확인 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_delete
	 * @Date : 2019. 10. 7.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 일정 삭제 
	 */
	public int tokyofair_schedule_delete(long fap_tokyofair_schedule_seq) {
		logger.info("FAP 도쿄페어 일정 삭제 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int result = sfcMapper.tokyofair_schedule_delete(fap_tokyofair_schedule_seq);
		logger.info("FAP 도쿄페어 일정 삭제 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_first_check
	 * @Date : 2019. 10. 7.
	 * @User : 이종호
	 * @Param : 도쿄페어 날짜 정보
	 * @Return : 최초일정 여부
	 * @Method 설명 : 도쿄페어 최초등록 일정 여부 판단
	 */
	public int tokyofair_schedule_first_check(SocietyFapTokyofairDate tokyofairDate) {
		logger.info("FAP 도쿄페어 최초등록 일정 여부 판단 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int result = sfcMapper.tokyofair_schedule_first_check(tokyofairDate);
		logger.info("FAP 도쿄페어 최초등록 일정 여부 판단 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_itv_comp_check
	 * @Date : 2019. 10. 7.
	 * @User : 이종호
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 도쿄페어 앞면접 과의 면접준비시간 체크 
	 */
	public int tokyofair_schedule_itv_comp_before_check(HashMap<String, Object> params) {
		logger.info("FAP 도쿄페어 앞면접 과의 면접준비시간 체크 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int result = sfcMapper.tokyofair_schedule_itv_comp_before_check(params);
		logger.info("FAP 도쿄페어 앞면접 과의 면접준비시간 체크 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_term_check
	 * @Date : 2019. 10. 8.
	 * @User : 이종호
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 도쿄페어 앞면접 과의 여유도 체크
	 */
	public int tokyofair_schedule_term_check(HashMap<String, Object> params) {
		logger.info("FAP 도쿄페어 앞면접 과의 여유도 체크 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		int result = sfcMapper.tokyofair_schedule_term_check(params);
		logger.info("FAP 도쿄페어 앞면접 과의 여유도 체크 DAO 종료");
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
	public ArrayList<HashMap<String, Object>> tokyofair_schedule_member_duplicate_check(HashMap<String, Object> scheduleMemberMap){
		logger.info("FAP 도쿄페어 일정 인원 중복 체크 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<HashMap<String, Object>> result = new ArrayList<>();
		for(HashMap<String, Object> member : (ArrayList<HashMap<String, Object>>)scheduleMemberMap.get("memberArr")) {
			HashMap<String, Object> params = new HashMap<>();
			params.put("fap_jobfair_set_seq", scheduleMemberMap.get("fap_jobfair_set_seq"));
			params.put("fap_tokyofair_date_dt", scheduleMemberMap.get("fap_tokyofair_date_dt"));
			params.put("fap_tokyofair_date_room_num", scheduleMemberMap.get("fap_tokyofair_date_room_num"));
			params.put("fap_jobfair_itv_stu_dt", scheduleMemberMap.get("fap_jobfair_itv_stu_dt"));
			params.put("fap_tokyofair_member_id", member.get("fap_tokyofair_member_id"));
			params.put("fap_tokyofair_member_st", member.get("fap_tokyofair_member_st"));
			params.put("fap_tokyofair_member_et", member.get("fap_tokyofair_member_et"));
			
			HashMap<String, Object> checkMap = sfcMapper.tokyofair_schedule_member_duplicate_check(params); 
			if(checkMap != null) {
				result.add(checkMap);
			}
		}
		
		logger.info("FAP 도쿄페어 일정 인원 중복 체크 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_member_insert
	 * @Date : 2019. 10. 8.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 인원 정보
	 * @Return : 
	 * @Method 설명 : 도쿄페어 일정 인원 등록
	 */
	public void tokyofair_schedule_member_insert(HashMap<String, Object> scheduleMemberMap) {
		logger.info("FAP 도쿄페어 일정 인원 등록 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.tokyofair_schedule_member_insert(scheduleMemberMap);
		logger.info("FAP 도쿄페어 일정 인원 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : tokyfair_schedule_booked_search
	 * @Date : 2019. 10. 10.
	 * @User : 이종호
	 * @Param : 현지 잡페어 설정 시퀀스 , 등록된 일정 날짜
	 * @Return : 등록된 일정 정보 리스트
	 * @Method 설명 : 도쿄페어 등록된 일정 정보 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> tokyfair_schedule_booked_search(HashMap<String, Object> params){
		logger.info("FAP 도쿄페어 등록된 일정 정보 리스트 조회 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		ArrayList<HashMap<String, Object>> result = sfcMapper.tokyfair_schedule_booked_search(params);
		logger.info("FAP 도쿄페어 등록된 일정 정보 리스트 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : job_ad_comp_id_search
	 * @Date : 2019. 10. 10.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 회사 아이디
	 * @Method 설명 : 채용공고 회사 아이디 조회
	 */
	public String job_ad_comp_id_search(long fap_job_ad_seq) {
		logger.info("FAP 채용공고 회사 아이디 조회 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		String fap_comp_id = sfcMapper.job_ad_comp_id_search(fap_job_ad_seq);
		logger.info("FAP 채용공고 회사 아이디 조회 DAO 종료");
		return fap_comp_id;
	}
	
	/**
	 * @Method Name : tokyofair_screening_sch_gb_update
	 * @Date : 2019. 10. 11.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 일정등록 구분
	 * @Return : -
	 * @Method 설명 : 도쿄페어 전형 일정등록 구분 변경
	 */
	public void tokyofair_screening_sch_gb_update(HashMap<String, Object> params) {
		logger.info("FAP 도쿄페어 전형 일정등록 구분 변경 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.tokyofair_screening_sch_gb_update(params);
		logger.info("FAP 도쿄페어 전형 일정등록 구분 변경 DAO 종료");
	}
	
	/**
	 * @Method Name : tokyofair_schedule_search_detail
	 * @Date : 2019. 10. 11.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 시퀀스
	 * @Return : 도쿄페어 일정 및 인원 정보
	 * @Method 설명 : 도쿄페어 일정 정보 및 인원 정보 검색
	 */
	public HashMap<String, Object> tokyofair_schedule_search_detail(long fap_tokyofair_schedule_seq){
		logger.info("FAP 도쿄페어 일정 정보 및 인원 정보 검색 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		HashMap<String, Object> result = sfcMapper.tokyofair_schedule_search_detail(fap_tokyofair_schedule_seq);
		logger.info("FAP 도쿄페어 일정 정보 및 인원 정보 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_member_delete
	 * @Date : 2019. 10. 11.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 인원 삭제 
	 */
	public void tokyofair_schedule_member_delete(long fap_tokyofair_schedule_seq) {
		logger.info("FAP 도쿄페어 인원 삭제 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		sfcMapper.tokyofair_schedule_member_delete(fap_tokyofair_schedule_seq);
		logger.info("FAP 도쿄페어 인원 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : tokyofair_screening_search_total
	 * @Date : 2019. 10. 11.
	 * @User : 이종호
	 * @Param : 회사 아이디, 세부 잡페어 시퀀스
	 * @Return : 도쿄페어 전체 전형 일정 정보
	 * @Method 설명 : 도쿄페어 전체 전형 일정 정보 조회 
	 */
	public HashMap<String, Object> tokyofair_screening_search_total(HashMap<String, Object> params){
		logger.info("FAP 도쿄페어 전체 전형 일정 정보 조회 DAO 시작");
		SocietyFapCompanyMapper sfcMapper = sqlSession.getMapper(SocietyFapCompanyMapper.class);
		HashMap<String, Object> result = sfcMapper.tokyofair_screening_search_total(params);
		logger.info("FAP 도쿄페어 전체 전형 일정 정보 조회 DAO 종료");
		return result;
	}
}
