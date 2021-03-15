/**
 * 
 */
package global.segroup.society.fap.agency.dao;

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

import global.segroup.domain.User;
import global.segroup.society.fap.agency.domain.SocietyFapAgencyCompanyConnect;
import global.segroup.society.fap.company.dao.SocietyFapCompanyMapper;
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
 * @Class 설명 : Soft Engineer Society 통합잡페어 에이전시 DAO
 * 
 */

@Repository
public class SocietyFapAgencyDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyFapAgencyDAO.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	/**
	 * @Method Name : userIdCheck
	 * @Date : 2018. 12. 11.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 유저아이디 or null
	 * @Method 설명 : 유저 아이디 중복 검사 중복된 경우 아이디 값이 return되며 중복 되지 않은 경우 null이 return됨
	 */
	public String user_id_check(String user_id){
		logger.info("FAP 유저 아이디 중복체크 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		String user_id_check = sfaMapper.user_id_check(user_id);			
		logger.info("FAP 유저 아이디 중복체크 DAO 종료");
		return user_id_check;
	}
	
/*	*//**
	 * @Method Name : insert_com_user
	 * @Date : 2018. 12. 13.
	 * @User : 김준영
	 * @Param : 유저 객체
	 * @Return : -
	 * @Method 설명 : 유저 등록을 하는 함수
	 *//*
	public void insert_com_user(User user){
		logger.info("FAP 공통 유저 정보 등록 DAO 시작");
		try {
			SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
			sfaMapper.insert_com_user(user);			
		} catch (Exception e) {
			System.out.println(e);
		}
		logger.info("FAP 공통 유저 정보 등록 DAO 시작");
	}
	
	*//**
	 * @Method Name : insert_agency
	 * @Date : 2018. 12. 13.
	 * @User : 김준영
	 * @Param : 에이전시 정보 객체
	 * @Return : -
	 * @Method 설명 : 에이전시 정보를 등록 하는 함수
	 *//*
	public void insert_agency(SocietyFapCompanyUser sfcUser){
		logger.info("FAP 에이전시 정보 등록 DAO 시작");
		try {
			SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
			sfaMapper.insert_agency(sfcUser);			
		} catch (Exception e) {
			System.out.println(e);
		}
		logger.info("FAP 에이전시 정보 등록 DAO 종료");
	}*/
	
	/*	*//**
	 * @Method Name : comp_user_connect
	 * @Date : 2018. 12. 13.
	 * @User : 김준영
	 * @Param : 에이전시-담당자 연결 객체
	 * @Return : -
	 * @Method 설명 : 에이전시와 담당자를 연결해주는 함수
	 *//*
	public void comp_user_connect(SocietyFapCompanyUserConnect sfCUConnect){
		logger.info("FAP 에이전시-담당자 연결 DAO 시작");
		try {
			SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
			sfaMapper.comp_user_connect(sfCUConnect);
		} catch (Exception e) {
			System.out.println(e);
		}
		logger.info("FAP 에이전시-담당자 연결 DAO 종료");
	}*/
	
	/**
	 * @Method Name : insert_agency
	 * @Date : 2018. 12. 13.
	 * @User : 김준영
	 * @Param : 유저 객체, 에이전시 정보 객체
	 * @Return : -
	 * @Method 설명 : 에이전시 정보를 등록 하는 함수
	 */
	@Transactional
	public void insert_agency(String company_ck, User user, 
			SocietyFapCompanyUser societyFapCompanyUser, 
			SocietyFapCompanyUserConnect societyFapCompanyUserConnect){
		logger.info("FAP 에이전시 정보 등록 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		// 존재하는 에이전시 정보가 없어 담당자가 회사 정보까지 입력; 회원 공통 테이블, 에이전시 회원 둘다 insert
		if(company_ck.equals("nonexistent")){
			sfaMapper.insert_com_user(user);
			sfaMapper.insert_agency(societyFapCompanyUser);
			// 에이전시-담당자 연결을 위해 객체에 값 넣어주기
			societyFapCompanyUserConnect.setUser_id(user.getUser_id());
			societyFapCompanyUserConnect.setFap_comp_id(societyFapCompanyUser.getFap_comp_id());
			societyFapCompanyUserConnect.setFap_comp_user_connect_ck("B3800");
			sfaMapper.comp_user_connect(societyFapCompanyUserConnect);
		// 존재하는 에이전시 정보가 있어서 담당자가 회사 정보를 입력하지 않음; 회원 공통 테이블
		} else if(company_ck.equals("existent")){
			sfaMapper.insert_com_user(user);
		}
		logger.info("FAP 에이전시 정보 등록 DAO 종료");
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
		logger.info("FAP 에이전시 담당자 정보 가져오기 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		User user = sfaMapper.select_user(user_id);
		logger.info("FAP 에이전시 담당자 정보 가져오기 DAO 종료");
		return user;
	}
	
	/**
	 * @Method Name : update_user
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 공통 유저 객체
	 * @Return : -
	 * @Method 설명 : 에이전시 담당자 정보를 수정하는 함수
	 */
	public void update_user(User user){
		logger.info("FAP 에이전시 담당자 정보 수정 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.update_user(user);
		logger.info("FAP 에이전시 담당자 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : insert_company
	 * @Date : 2018. 12. 18.
	 * @User : 김준영
	 * @Param : 회사 정보 객체
	 * @Return : fap_comp_id 
	 * @Method 설명 : 에이전시가 기업 회원 가입을 대신 해주는 함수
	 */
	@Transactional
	public String insert_company(Authentication auth, User user, SocietyFapCompanyUser societyFapCompanyUser){
		logger.info("FAP 에이전시 회사 회원가입 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		
		// 비밀번호 암호화
		String encodedPw = passwordEncoder.encode(user.getUser_pw());
		user.setUser_pw(encodedPw);
		sfaMapper.insert_com_user(user);
		
		String comp_id = ((societyFapCompanyUser.getFap_comp_en_nm()).replaceAll(" ","")) + "@_@" + user.getUser_id();
		societyFapCompanyUser.setFap_comp_id(comp_id);
		societyFapCompanyUser.setFap_comp_ins_id((String)auth.getPrincipal());
		societyFapCompanyUser.setFap_comp_udt_id((String)auth.getPrincipal());
		
		// 함수 이름이 다르지만 회사, 에이전시는 같은 VO를 사용하기 때문에 같은 작동을 함
		sfaMapper.insert_agency(societyFapCompanyUser);
		
		// 에이전시 담당자가 가지고 있는 에이전시 - 담당자 연결 객체를 가져온다.
		SocietyFapCompanyUserConnect CompanyUserConnect = sfaMapper.select_comp_user_connect((String)auth.getPrincipal());
		
		// 기업 - 담당자 연결
		SocietyFapCompanyUserConnect sfcUConnect = new SocietyFapCompanyUserConnect();
		sfcUConnect.setUser_id(user.getUser_id());
		sfcUConnect.setFap_comp_id(comp_id);
		sfcUConnect.setFap_comp_user_connect_ck("B3800");
		sfaMapper.comp_user_connect(sfcUConnect);
		
		// 에이전시 - 기업 연결
		SocietyFapAgencyCompanyConnect societyFapAgencyCompanyConnect = new SocietyFapAgencyCompanyConnect();
		societyFapAgencyCompanyConnect.setFap_ag_id(CompanyUserConnect.getFap_comp_id());
		societyFapAgencyCompanyConnect.setFap_comp_id(societyFapCompanyUser.getFap_comp_id());
		societyFapAgencyCompanyConnect.setFap_ag_comp_connect_ck("B3800");
		sfaMapper.agency_company_connect(societyFapAgencyCompanyConnect);
		
		logger.info("FAP 에이전시 회사 회원가입 DAO 종료");
		return comp_id;
	}
	
	/**
	 * @Method Name : select_agen_user_connect
	 * @Date : 2019. 02. 11.
	 * @User : 김홍일
	 * @Param : 유저 아이디
	 * @Return : 에이전시 기업 - 유저 연결 객체
	 * @Method 설명 : 해당 하는 아이디에 에이전시 기업 - 유저 연결 객체를 불러오는 함수
	 */
	public SocietyFapCompanyUserConnect select_agen_user_connect(String user_id){
		logger.info("FAP 기업 - 유저 연결 객체 가져오기 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		SocietyFapCompanyUserConnect agen_user_connect = sfaMapper.select_agen_user_connect(user_id);
		logger.info("FAP 기업 - 유저 연결 객체 가져오기 DAO 종료");
		return agen_user_connect;
	}
	
	/**
	 * @Method Name : select_ag_comp
	 * @Date : 2018. 12. 18.
	 * @User : Administrator
	 * @Param : 회원 아이디
	 * @Return : 에이전시 - 기업 연결 객체
	 * @Method 설명 : 회원 아이디가 가지고 있는 기업객체(에이전시)와 연결 되어있는 일반 기업을 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_ag_comp(String user_id){
		logger.info("FAP 에이전시가 가지고 있는 기업 가져오기 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		ArrayList<HashMap<String, Object>> select_ag_comp = sfaMapper.select_ag_comp(user_id);
		logger.info("FAP 에이전시가 가지고 있는 기업 가져오기 DAO 종료");
		return select_ag_comp;
	}
	
	/**
	 * @Method Name : select_comp_list
	 * @Date : 2018. 12. 19.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 기업 객체 리스트
	 * @Method 설명 : 기업 객체를 불러오는 함수
	 */
	public ArrayList<SocietyFapCompanyUser> select_comp_list(String user_id){
		logger.info("FAP 기업 정보 가져오기 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		ArrayList<SocietyFapCompanyUser> select_comp_list = sfaMapper.select_comp_list(user_id);
		logger.info("FAP 기업 정보 가져오기 DAO 종료");
		return select_comp_list;
	}
	
	/**
	 * @Method Name : select_company
	 * @Date : 2018. 12. 19.
	 * @User : 김준영
	 * @Param : 에이전시 유저 아이디
	 * @Return : 기업 객체
	 * @Method 설명 : 에이전시 담당자 가지고 있는 기업 객체를 가져오는 함수
	 */
	public SocietyFapCompanyUser select_company(String fap_comp_id){
		logger.info("FAP 에이전시 정보 가져오기 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		SocietyFapCompanyUser societyFapCompanyUser = sfaMapper.select_company(fap_comp_id);
		logger.info("FAP 에이전시 정보 가져오기 DAO 종료");
		return societyFapCompanyUser;
	}
	
	/**
	 * @Method Name : update_company
	 * @Date : 2018. 12. 19.
	 * @User : 김준영
	 * @Param : 기업 정보 객체
	 * @Return : -
	 * @Method 설명 : 기업 정보를 업데이트 해주는 함수 
	 */
	public void update_company(SocietyFapCompanyUser sfcUser){
		logger.info("FAP 회사 정보 업데이트 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.update_company(sfcUser);
		logger.info("FAP 회사 정보 업데이트 DAO 종료");
	}
	
	/**
	 * @Method Name : insert_ag_comp_connect
	 * @Date : 2018. 12. 19.
	 * @User : 김준영
	 * @Param : 에이전시 아이디, 기업아이디
	 * @Return : -
	 * @Method 설명 : 에이전시가 관리하는 기업을 추가하는 함수
	 */
	public void insert_ag_comp_connect(HashMap<String, Object> hashMap){
		logger.info("에이전시 기업 연결 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_ag_comp_connect(hashMap);
		logger.info("에이전시 기업 연결 DAO 종료");
	}

	/**
	 * @Method Name : direct_request_connect
	 * @Date : 2018. 12. 21.
	 * @User : 김준영
	 * @Param : 에이전시 기업 연결 객체(회사 아이디는 배열)
	 * @Return : -
	 * @Method 설명 : 에이전시와 기업을 연결 요청을 보내는 함수
	 */
	public void connect_request(HashMap<String, Object> hashMap){
		logger.info("에이전시 기업 연결 요청 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.connect_request(hashMap);
		logger.info("에이전시 기업 연결 요청 DAO 종료");
	}
	
	/**
	 * @Method Name : agency_company_disconnect
	 * @Date : 2018. 12. 21.
	 * @User : 김준영
	 * @Param : 에이전시 기업 연결 SEQ
	 * @Return : -
	 * @Method 설명 : 에이전시 기업 연결을 끊은 후 기업 관리 페이지로 이동 
	 */
	public void ag_comp_disconnect(int fap_ag_comp_connect_seq){
		logger.info("FAP 에이전시 기업 연결 끊기 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.ag_comp_disconnect(fap_ag_comp_connect_seq);
		logger.info("FAP 에이전시 기업 연결 끊기 DAO 종료");
	}
	
	/**
	 * @Method Name : ck_ag_comp_connect
	 * @Date : 2018. 12. 21.
	 * @User : 김준영
	 * @Param : 기업 아이디
	 * @Return : 에이전시 - 기업 연결 객체
	 * @Method 설명 : 기업에 연결된 에이전시가 있는지 확인함
	 */
	public ArrayList<SocietyFapAgencyCompanyConnect> ck_ag_comp_connect(String user_id){
		logger.info("FAP 기업에 연결된 에이전시 여부 확인 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		ArrayList<SocietyFapAgencyCompanyConnect> societyFapAgencyCompanyConnect = sfaMapper.ck_ag_comp_connect(user_id);
		logger.info("FAP 기업에 연결된 에이전시 여부 확인 DAO 종료");
		return societyFapAgencyCompanyConnect;
	}
	
	/**
	 * @Method Name : update_ag_comp_connect
	 * @Date : 2018. 12. 21.
	 * @User : 김준영
	 * @Param : 에이전시 - 기업 연결 객체
	 * @Return : -
	 * @Method 설명 : 에이전시 - 기업 연결 객체의 승인 여부를 수정하는 함수
	 */
	public void update_ag_comp_connect(SocietyFapAgencyCompanyConnect societyFapAgencyCompanyConnect){
		logger.info("FAP 에이전시 - 기업 승인 여부 수정 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.update_ag_comp_connect(societyFapAgencyCompanyConnect);
		logger.info("FAP 에이전시 - 기업 승인 여부 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : delete_agency_user_info
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 탈퇴할 에이전시 담당자 정보 객체
	 * @Return : -
	 * @Method 설명 : 에이전시 담당자 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(30글자) 변경후 참조 테이블에 적용
	 */
	@Transactional
	public void delete_agency_user_info(User user){
		logger.info("FAP 에이전시 담당자 탈퇴 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
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
		sfaMapper.delete_agency_user_info(updateMap);
		// 에이전시 - 기업 담당자 연결 정보 삭제함; 꼭 이거 먼저 삭제해야함
		sfaMapper.delete_ag_comp_connect(user.getUser_id());
		// 기업 - 담당자 연결 정보도 삭제함
		sfaMapper.user_connect_delete(user.getUser_id());
		
		logger.info("FAP 에이전시 담당자 탈퇴 DAO 종료");
	}
	
	/**
	 * @Method Name : select_exclude_comp_list
	 * @Date : 2018. 12. 27.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 에이전시 - 기업 객체
	 * @Method 설명 : 이미 다른 에이전시와 연결되어 있는 에이전시 - 기업 객체를 가져오는 함수
	 */
	public ArrayList<SocietyFapAgencyCompanyConnect> select_exclude_comp_list(String user_id){
		logger.info("FAP 관리하지 않는 기업 리스트 가져오기 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		ArrayList<SocietyFapAgencyCompanyConnect> select_exclude_comp_list = sfaMapper.select_exclude_comp_list(user_id);
		logger.info("FAP 관리하지 않는 기업 리스트 가져오기 DAO 종료");
		return select_exclude_comp_list;
	}
	
	/**
	 * @Method Name : select_company_compare_id
	 * @Date : 2018. 12. 31.
	 * @User : 김준영
	 * @Param : 기업 아이디
	 * @Return : 기업 객체
	 * @Method 설명 : 기업 아이디와 일치하는 정보를 가져오는 함수
	 */
	public SocietyFapCompanyUser select_company_compare_id(String fap_comp_id){
		logger.info("FAP 기업 정보 가져오기 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		SocietyFapCompanyUser societyFapCompanyUser = sfaMapper.select_company_compare_id(fap_comp_id);
		logger.info("FAP 기업 정보 가져오기 DAO 종료");
		return societyFapCompanyUser;
	}
	
	/**
	 * @Method Name : delete_connect_request
	 * @Date : 2018. 12. 31.
	 * @User : 김준영
	 * @Param : 에이전시 - 기업 연결 객체
	 * @Return : -
	 * @Method 설명 : 에이전시가 기업 연결을 위해 보낸 요청을 삭제하는 함수
	 */
	public void delete_connect_request(SocietyFapAgencyCompanyConnect agencyCompanyConnect){
		logger.info("FAP 에이전시 - 기업 연결 요청 삭제 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.delete_connect_request(agencyCompanyConnect);
		logger.info("FAP 에이전시 - 기업 연결 요청 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : select_agency
	 * @Date : 2019. 1. 2.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 에이전시 기업 객체
	 * @Method 설명 : 기업 중 에이전시 기업을 가져온다.
	 */
	public ArrayList<SocietyFapCompanyUser> select_agency(){
		logger.info("FAP 에이전시 기업 리스트 가져오기 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		ArrayList<SocietyFapCompanyUser> agency_list = sfaMapper.select_agency();
		logger.info("FAP 에이전시 기업 리스트 가져오기 DAO 종료");
		return agency_list;
	}
	
	/**
	 * @Method Name : company_user_check
	 * @Date : 2018. 12. 27.
	 * @User : 김준영
	 * @Param : 유저 객체
	 * @Return : 확인 메시지
	 * @Method 설명 : 에이전시 - 기업을 직접 연결해주는 함수
	 */
	@Transactional
	public String direct_connect(Authentication auth, User user){
		logger.info("FAP 에이전시 - 기업 직접 연결 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		String company_user_check = "complete";
		
		User select_user = sfaMapper.select_user(user.getUser_id());
		
		// 일치하는 아이디가 없을 경우
		if(select_user == null){
			company_user_check = "nonexist_id";
			return company_user_check;
		}
		
		// 비밀번호가 일치하지 않을 경우				입력	 	불러온거
		if(!passwordEncoder.matches(user.getUser_pw(), select_user.getUser_pw())){
			company_user_check = "nonmatch_pw";
			return company_user_check;
		}

		// 입력한 담당자 아이디에 연결된 기업의 에이전시 - 기업 연결 객체
		ArrayList<SocietyFapAgencyCompanyConnect> ag_comp_connect = sfaMapper.ck_ag_comp_connect(user.getUser_id());
		
		// 연결 객체가 없다면 insert
		if(ag_comp_connect == null){
			HashMap<String, Object> hashMap = new HashMap<>();
			hashMap.put("agency_user_id", (String)auth.getPrincipal());
			hashMap.put("company_user_id", select_user.getUser_id());
			hashMap.put("connect_ck", "B3800");
			sfaMapper.insert_ag_comp_connect(hashMap);
			return company_user_check;
		}
		
		for(int i = 0; i < ag_comp_connect.size(); i++){
			// 입력 한 담당자 아이디가 가지고 있는 기업 정보가 들어가 있는 에이전시 - 기업 연결 객체에서 에이전시가 현재 로그인 한 에이전시과 다를 경우
			if(!ag_comp_connect.get(i).getFap_ag_id().equals((String)auth.getPrincipal())){
				// 이미 다른 에이전시가 관리하는 기업일 경우
				if(ag_comp_connect.get(i).getFap_ag_comp_connect_ck().equals("B3800")){
					company_user_check = "another_agency";
					return company_user_check;
				}
			}
		}
		
		for(int i = 0; i < ag_comp_connect.size(); i++){
			if(ag_comp_connect.get(i).getFap_ag_id().equals((String)auth.getPrincipal())){
				// 에이전시가 이미 관리하고 있는 경우
				if(ag_comp_connect.get(i).getFap_ag_comp_connect_ck().equals("B3800")){
					company_user_check = "exist_list";
					return company_user_check;
				// 에이전시가 요청을 보냈지만 대기 중이거나 거절인 경우
				} else if(ag_comp_connect.get(i).getFap_ag_comp_connect_ck().equals("B3801")
							|| ag_comp_connect.get(i).getFap_ag_comp_connect_ck().equals("B3802")){
					ag_comp_connect.get(i).setFap_ag_comp_connect_ck("B3800");
					sfaMapper.update_ag_comp_connect(ag_comp_connect.get(i));
					company_user_check = "complete";
					return company_user_check;
				}
			}
		}
		
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("agency_user_id", (String)auth.getPrincipal());
		hashMap.put("company_user_id", select_user.getUser_id());
		hashMap.put("connect_ck", "B3800");
		sfaMapper.connect_refusal(hashMap);
		sfaMapper.insert_ag_comp_connect(hashMap);
		company_user_check = "complete";

		logger.info("FAP 에이전시 - 기업 직접 연결 DAO 종료");
		return company_user_check;
	}
	
	/**
	 * @Method Name : select_agency_company
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 일반 기업을 제외한 에이전시 객체
	 * @Method 설명 : 기업 리스트중 일반 기업을 제외한 에이전시 객체 리스트를 가져오는 함수
	 */
	public ArrayList<SocietyFapCompanyUser> select_agency_company(){
		logger.info("FAP 에이전시 기업 가져오기 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		ArrayList<SocietyFapCompanyUser> comp_list = sfaMapper.select_agency_company();
		logger.info("FAP 에이전시 기업 가져오기 DAO 종료");
		return comp_list;
	}
	
	/**
	 * @Method Name : user_agency_info_insert
	 * @Date : 2019. 1. 10.
	 * @User : 김준영
	 * @Param : 유저 정보, 기업 정보
	 * @Return : -
	 * @Method 설명 : 유저 아이디와 일치하는 연결객체의 값을 삭제 후 기업 정보를 입력하는 함수
	 */
	@Transactional
	public void user_agency_info_insert(Authentication auth, SocietyFapCompanyUser agency_info){
		logger.info("FAP 에이전시 담당자 - 기업 정보 입력 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		// 정보 입력 전 연결 객체 삭제
		sfaMapper.user_connect_delete((String)auth.getPrincipal());
		// 기업 정보 입력 
		String company_id = agency_info.getFap_comp_en_nm() + "@_@" + (String)auth.getPrincipal();
		// 적용
		agency_info.setFap_comp_id(company_id);
		sfaMapper.insert_agency(agency_info);
		// 기업 담당자 - 기업 연결
		SocietyFapCompanyUserConnect sfCUConnect = new SocietyFapCompanyUserConnect();
		sfCUConnect.setUser_id((String)auth.getPrincipal());
		sfCUConnect.setFap_comp_id(company_id);
		sfCUConnect.setFap_comp_user_connect_ck("B3800");
		sfaMapper.comp_user_connect(sfCUConnect);
		logger.info("FAP 에이전시 담당자 - 기업 정보 입력 DAO 시작");
	}
	
	/**
	 * @Method Name : jobfair_search_list
	 * @Date : 2019. 1. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 통합잡페어 정보 리스트
	 * @Method 설명 : 통합잡페어 정보 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> jobfair_search_list(){
		logger.debug("통합잡페어 정보 리스트 검색 DAO 시작");
		ArrayList<HashMap<String, Object>> jobfair_search_list = null;		
		try{
			SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
			jobfair_search_list = sfaMapper.jobfair_search_list();
		}catch(Exception e){
			e.printStackTrace();
		}		
		logger.debug("통합잡페어 정보 리스트 검색 DAO 종료");
		return jobfair_search_list;
	}
	
	/**
	 * @Method Name : jobfair_divide_search_list
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어 세부정보 리스트
	 * @Method 설명 : 선택한 잡페어 세부정보 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> jobfair_divide_search_list(int fap_jobfair_seq){
		logger.debug("선택한 잡페어 세부정보 리스트 검색 DAO 시작");
		ArrayList<HashMap<String, Object>> jobfair_divide_search_list = null;		
		try{
			SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
			jobfair_divide_search_list = sfaMapper.jobfair_divide_search_list(fap_jobfair_seq);
		}catch(Exception e){
			e.printStackTrace();
		}		
		logger.debug("선택한 잡페어 세부정보 리스트 검색 DAO 종료");
		return jobfair_divide_search_list;
	}
	
	/**
	 * @Method Name : select_job_ad_list
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : fap_comp_id
	 * @Return : 채용공고 기본정보
	 * @Method 설명 : 채용공고 기본 정보 리스트 출력
	 */
	public ArrayList<SocietyFapJobAd> select_job_ad_list(String fap_comp_id) {
		logger.debug("채용공고 기본 정보 리스트 출력 시작");
		ArrayList<SocietyFapJobAd> jobAdList = null;
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		jobAdList= sfaMapper.select_job_ad_list(fap_comp_id);		
		logger.debug("채용공고 기본 정보 리스트 출력 완료");
		return jobAdList;
	}
	
	/**
	 * @Method Name : insert_job_ad2
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 채용공고 
	 * @Return : 
	 * @Method 설명 : 채용공고 등록후 seq까지 넣은 객체를 그대로 반환
	 */
	public SocietyFapJobAd insert_job_ad2(SocietyFapJobAd jobAd){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_ad(jobAd);
		return jobAd;
	}
	
	/**
	 * @Method Name : insert_job_dorm
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 기숙사
	 * @Return : 
	 * @Method 설명 : 기숙사 정보 등록
	 */
	public void insert_job_dorm(SocietyFapJobDorm jobDorm){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_dorm(jobDorm);
	}
	
	/**
	 * @Method Name : insert_job_jit_employee
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 계약사원정보
	 * @Return : 
	 * @Method 설명 : 계약사원 정보 등록
	 */
	public void insert_job_jit_employee(SocietyFapJobJitEmployee jobJitEmployee){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_jit_employee(jobJitEmployee);
	}
	
	/**
	 * @Method Name : insert_job_ja_level
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 업무에 필요한 일본어 능력
	 * @Return : 업무에 필요한 일본어 능력 정보 등록 
	 * @Method 설명 :
	 */
	public void insert_job_ja_level(SocietyFapJobJaLevel jobJaLevel){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_ja_level(jobJaLevel);
	}
	
	/**
	 * @Method Name : insert_job_trial
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 시용기간
	 * @Return : 
	 * @Method 설명 : 시용기간 정보 등록
	 */
	public void insert_job_trial(SocietyFapJobTrial jobTrial){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_trial(jobTrial);
	}
	
	/**
	 * @Method Name : insert_job_comp
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 채용공고 회사정보
	 * @Return : 
	 * @Method 설명 : 채용공고 회사정보 등록
	 */
	public void insert_job_comp(SocietyFapJobComp jobComp){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_comp(jobComp);
	}
	
	/**
	 * @Method Name : insert_job_file
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 채용공고 파일 정보
	 * @Return : 
	 * @Method 설명 : 채용공고 파일 정보 등록
	 */
	public void insert_job_file(SocietyFapJobFile jobFile){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_file(jobFile);
	}
	
	/**
	 * @Method Name : insert_job_isr
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 채용공고 보험 정보
	 * @Return : 
	 * @Method 설명 : 채용공고 보험 정보 등록
	 */
	public void insert_job_isr(SocietyFapJobIsr jobIsr){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_isr(jobIsr);
	}
	
	/**
	 * @Method Name : insert_job_join_dt
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 입사예정일
	 * @Return : 
	 * @Method 설명 : 입사예정일 정보 등록
	 */
	public void insert_job_join_dt(SocietyFapJobJoinDt jobJoinDt){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_join_dt(jobJoinDt);
	}

	/**
	 * @Method Name : insert_job_work
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 채용공고 주요 업무 정보
	 * @Return : 
	 * @Method 설명 : 채용공고 주요 업무 정보 등록
	 */
	public void insert_job_work(SocietyFapJobWork jobWork){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_work(jobWork);
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
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_category(jobCategory);
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
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_category_etc(JobCategoryEtc);
	}
	
	/**
	 * @Method Name : insert_job_pref
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 우대사항
	 * @Return : 
	 * @Method 설명 : 우대사항 정보 객체
	 */
	public void insert_job_pref(SocietyFapJobPref jobPref){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_pref(jobPref);
	}
	
	/**
	 * @Method Name : insert_job_workplace
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 근무예정지
	 * @Return : 
	 * @Method 설명 : 근무예정지 정보 등록후 seq입력후 반환
	 */
	public List<SocietyFapJobWorkplace> insert_job_workplace(List<SocietyFapJobWorkplace> jobWorkplace_list){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_workplace(jobWorkplace_list);
		return jobWorkplace_list;
	}
	
	/**
	 * @Method Name : insert_job_workplace_dtl
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 상세근무예정지 리스트
	 * @Return : 
	 * @Method 설명 : 상세근무예정지 리스트 등록
	 */
	public void insert_job_workplace_dtl(List<SocietyFapJobWorkplaceDtl> jobWorkplaceDtl_list){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_workplace_dtl(jobWorkplaceDtl_list);
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
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_workplace_etc(JobWorkplaceEtc);
	}
	
	/**
	 * @Method Name : insert_job_recruit_pcs
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 채용전형 리스트
	 * @Return : 
	 * @Method 설명 : 채용전형 리스트 등록후 seq 반환
	 */
	public List<SocietyFapJobRecruitPcs> insert_job_recruit_pcs(List<SocietyFapJobRecruitPcs> jobRecruitPcs_list){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_recruitpcs(jobRecruitPcs_list);
		return jobRecruitPcs_list;
	}
	
	/**
	 * @Method Name : insert_job_exam
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 시험전형정보
	 * @Return : 
	 * @Method 설명 : 시험전형정보 등록후 seq 반환
	 */
	public SocietyFapJobExam insert_job_exam(SocietyFapJobExam jobExam){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_exam(jobExam);
		return jobExam;
	}
	
	/**
	 * @Method Name : insert_job_itv
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 면접전형정보
	 * @Return : 
	 * @Method 설명 : 면접전형정보 등록후 seq 반환
	 */
	public SocietyFapJobItv insert_job_itv(SocietyFapJobItv jobItv){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_itv(jobItv);
		return jobItv;
	}
	
	/**
	 * @Method Name : insert_job_test_etc
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 기타전형정보
	 * @Return : 
	 * @Method 설명 : 기타전형정보 등록후 seq 반환
	 */
	public SocietyFapJobTestEtc insert_job_test_etc(SocietyFapJobTestEtc jobTestEtc){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_test_etc(jobTestEtc);
		return jobTestEtc;
	}
	
	/**
	 * @Method Name : insert_job_exam_file
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 시험문제파일
	 * @Return : 
	 * @Method 설명 : 시험문제파일 정보 등록
	 */
	public void insert_job_exam_file(SocietyFapJobExamFile jobExamFile){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_exam_file(jobExamFile);
	}
	
	/**
	 * @Method Name : insert_job_exam_obj_etc
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 시험대상자(기타)
	 * @Return : 
	 * @Method 설명 : 시험대상자(기타) 정보 등록
	 */
	public void insert_job_exam_obj_etc(SocietyFapJobExamObjEtc jobExamObjEtc){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_exam_obj_etc(jobExamObjEtc);
	}
	
	/**
	 * @Method Name : insert_job_exam_sv_etc
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 시험감독관(기타)
	 * @Return : 
	 * @Method 설명 : 시험감독관(기타) 정보 등록
	 */
	public void insert_job_exam_sv_etc(SocietyFapJobExamSvEtc jobExamSvEtc){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_exam_sv_etc(jobExamSvEtc);
	}

	/**
	 * @Method Name : insert_job_exam_need_etc
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 시험준비물(기타) 
	 * @Return : 
	 * @Method 설명 : 시험준비물(기타) 정보 등록
	 */
	public void insert_job_exam_need_etc(SocietyFapJobExamNeedEtc jobExamNeedEtc){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_exam_need_etc(jobExamNeedEtc);
	}
	
	/**
	 * @Method Name : insert_job_exam_type
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 시험종류 리스트
	 * @Return : 
	 * @Method 설명 : 시험종류 리스트 등록
	 */
	public void insert_job_exam_type(List<SocietyFapJobExamType> jobExamType_list){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_exam_type(jobExamType_list);
			
	}
	
	/**
	 * @Method Name : insert_job_itv_tp_etc
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 면접방식(기타)
	 * @Return : 
	 * @Method 설명 : 면접방식(기타) 정보 등록
	 */
	public void insert_job_itv_tp_etc(SocietyFapJobItvTpEtc jobItvTpEtc){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_itv_tp_etc(jobItvTpEtc);
	}
	
	/**
	 * @Method Name : insert_job_itv_obj_etc
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 면접대상자(기타)
	 * @Return : 
	 * @Method 설명 :
	 */
	public void insert_job_itv_obj_etc(SocietyFapJobItvObjEtc jobItvObjEtc){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_itv_obj_etc(jobItvObjEtc);
	}
	
	/**
	 * @Method Name : insert_job_test_etc_obj
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 기타전형대상자(기타)
	 * @Return : 
	 * @Method 설명 : 기타전형대상자(기타) 정보 등록
	 */
	public void insert_job_test_etc_obj(SocietyFapJobTestEtcObj jobTestEtcObj){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_test_etc_obj(jobTestEtcObj);
	}
	
	/**
	 * @Method Name : insert_job_pay
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 급여정보 리스트
	 * @Return : 
	 * @Method 설명 : 급여정보 리스트 등록후 seq 반환
	 */
	public List<SocietyFapJobPay> insert_job_pay(List<SocietyFapJobPay> jobPay_list){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_pay(jobPay_list);
		return jobPay_list;
	}
	
	/**
	 * @Method Name : insert_job_pay_base
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 기본급 리스트
	 * @Return : 
	 * @Method 설명 : 기본급 리스트 등록후 seq 반환
	 */
	public List<SocietyFapJobPayBase> insert_job_pay_base(List<SocietyFapJobPayBase> jobPayBase_list){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_pay_base(jobPayBase_list);
		return jobPayBase_list;
	}
	
	/**
	 * @Method Name : insert_job_service_work
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 서비스잔업수당
	 * @Return : 
	 * @Method 설명 : 서비스잔업수당 정보 등록
	 */
	public void insert_job_service_work(SocietyFapJobServiceWork jobServiceWork){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_service_work(jobServiceWork);
	}
	
	/**
	 * @Method Name : insert_job_pay_etc
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 기타수당 리스트
	 * @Return : 
	 * @Method 설명 : 기타수당 리스트 등록
	 */
	public void insert_job_pay_etc(List<SocietyFapJobPayEtc> jobPayEtc_list){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_pay_etc(jobPayEtc_list);
	}
	
	/**
	 * @Method Name : insert_job_pay_extra
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 잔업수당
	 * @Return : 
	 * @Method 설명 : 잔업수당 등록
	 */
	public void insert_job_pay_extra(SocietyFapJobPayExtra jobPayExtra){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.insert_job_pay_extra(jobPayExtra);
	}
	
	/**
	 * @Method Name : select_job_pay
	 * @Date : 2019. 1. 22.
	 * @User : 원병호
	 * @Param : fap_job_ad_seq
	 * @Return : 급여 관련 모든 정보를 담은 map
	 * @Method 설명 : 급여 관련 모든 정보를 가져옵니다.
	 */
	public HashMap<String, Object> select_job_pay(long fap_jop_ad_seq){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		HashMap<String, Object> result = sfaMapper.select_job_pay(fap_jop_ad_seq);
		return result;
	}
	
	/**
	 * @Method Name : select_job_ideal_person
	 * @Date : 2019. 1. 22.
	 * @User : 김준영
	 * @Param : 채용공고 정보 seq
	 * @Return : 채용공고 정보, 주요 업무 정보, 업무에 필요한 능력, 우대사항 
	 * @Method 설명 : 채용공고 정보, 주요 업무, 인재상, 기술상세를 가져오는 함수
	 */
	public HashMap<String, Object> select_job_ideal_person(long fap_job_ad_seq){
		logger.info("FAP 채용공고 정보, 주요 업무 정보, 업무에 필요한 능력, 우대사항 가져오기 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		HashMap<String, Object> job_ideal_person = sfaMapper.select_job_ideal_person(fap_job_ad_seq);
		logger.info("FAP 채용공고 정보, 주요 업무 정보, 업무에 필요한 능력, 우대사항 가져오기 DAO 종료");
		return job_ideal_person;
	}
	
	/**
	 * @Method Name : select_job_category
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 채용공고 정보 seq
	 * @Return : 모집직종 관련 모든 정보를 담은 map
	 * @Method 설명 : 모집직종 관련 모든 정보를 가져옵니다.
	 */
	public HashMap<String, Object> select_job_category(long fap_job_ad_seq){
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		HashMap<String, Object> result = sfaMapper.select_job_category(fap_job_ad_seq);
		return result;
	}
	
	/**
	 * @Method Name : select_job_ad
	 * @Date : 2019. 1. 22.
	 * @User : 김준영
	 * @Param : 채용공고 정보 seq
	 * @Return : 채용공고 정보
	 * @Method 설명 : 기본 채용공고 정보를 가져오는 함수
	 */
	public SocietyFapJobAd select_job_ad(Long fap_job_ad_seq){
		logger.info("FAP 채용공고 정보 가져오기 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		SocietyFapJobAd jobAd = sfaMapper.select_job_ad(fap_job_ad_seq);
		logger.info("FAP 채용공고 정보 가져오기 DAO 종료");
		return jobAd;
	}
	
	/**
	 * @Method Name : select_job_recruit_pcs
	 * @Date : 2019. 1. 22.
	 * @User : 김준영
	 * @Param : 채용공고 정보 seq
	 * @Return : 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일
	 * @Method 설명 : 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_job_recruit_pcs(Long fap_job_ad_seq){
		logger.info("FAP 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일 정보 가져오기 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		ArrayList<HashMap<String, Object>> job_recruit_pcs = sfaMapper.select_job_recruit_pcs(fap_job_ad_seq);
		logger.info("FAP 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일 정보 가져오기 DAO 종료");
		return job_recruit_pcs;
	}
	
	/**
	 * @Method Name : select_fap_comp_id
	 * @Date : 2019. 1. 23.
	 * @User : 이재준
	 * @Param : 회원 아이디
	 * @Return : 회사 아이디
	 * @Method 설명 : 회사 아이디 발급 여부 검색
	 */
	public String select_fap_comp_id(String user_id){
		logger.debug("회사 아이디 발급 여부 검색 DAO 시작");
		String fap_comp_id = null;
		try{
			SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
			fap_comp_id = sfaMapper.select_fap_comp_id(user_id);
		}catch(Exception e){
			e.printStackTrace();
		}		
		logger.debug("회사 아이디 발급 여부 검색 DAO 종료");
		return fap_comp_id;
	}
	
	/**
	 * @return 
	 * @Method Name : update_job_ad
	 * @Date : 2019.01.23
	 * @User : 이재준
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 채용공고 기본 정보만 업데이트
	 */
	public long update_job_ad(SocietyFapJobAd JobAd) {
		logger.debug("FAP 채용공고 기본 정보 업데이트 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.update_job_ad(JobAd);
		long job_ad_parent_insert_seq = JobAd.getFap_job_ad_seq();
		logger.debug("FAP 채용공고 기본 정보 업데이트 DAO 종료");
		return job_ad_parent_insert_seq;
	}
	
	/**
	 * @Method Name : select_pcs_seq_list
	 * @Date : 2019. 1. 23.
	 * @User : 김준영
	 * @Param : 채용공고 seq
	 * @Return : 채용전형 seq list
	 * @Method 설명 : 채용공고에 해당하는 채용전형 seq list를 가져오는 함수
	 */
	public ArrayList<Long> select_pcs_seq_list(Long fap_job_ad_seq){
		logger.info("FAP 채용전형 시퀀스 가져오기 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		ArrayList<Long> select_pcs_seq_list = sfaMapper.select_pcs_seq_list(fap_job_ad_seq);
		logger.info("FAP 채용전형 시퀀스 가져오기 DAO 종료");
		return select_pcs_seq_list;
	}
	
	/**
	 * @Method Name : delete_job_recruit_pcs_selective
	 * @Date : 2019. 1. 23.
	 * @User : 김준영
	 * @Param : 채용공고 seq, 채용전형 seq
	 * @Return : -
	 * @Method 설명 : 수정에서 지운 채용전형을 지워주는 함수
	 */
	public void delete_job_recruit_pcs_selective(HashMap<String, Object> hashMap){
		logger.info("FAP 채용전형 선택적 삭제 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.delete_job_recruit_pcs_selective(hashMap);
		logger.info("FAP 채용전형 선택적 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : delete_job_recurit_pcs_sub
	 * @Date : 2019. 1. 23.
	 * @User : 김준영
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 
	 */
	public void delete_job_recurit_pcs_sub(long fap_job_recruit_pcs_seq){
		
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.delete_job_exam(fap_job_recruit_pcs_seq);
		sfaMapper.delete_job_itv(fap_job_recruit_pcs_seq);
		sfaMapper.delete_job_test_etc(fap_job_recruit_pcs_seq);
		
	}
	
	/**
	 * @Method Name : update_job_recruit_pcs
	 * @Date : 2019. 1. 23.
	 * @User : 김준영
	 * @Param : 채용전형 객체
	 * @Return : -
	 * @Method 설명 : 채용전형 수정
	 */
	public void update_job_recruit_pcs(SocietyFapJobRecruitPcs jobRecruitPcs){
		logger.info("FAP 채용전형 수정 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.update_job_recruit_pcs(jobRecruitPcs);
		logger.info("FAP 채용전형 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : delete_job_ad
	 * @Date : 2019.01.23
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 정보 삭제(sub)
	 */
	public void delete_job_ad(long fap_job_ad_seq) {
		logger.debug("FAP 채용공고(sub) 삭제 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		sfaMapper.delete_job_dorm(fap_job_ad_seq);
		sfaMapper.delete_job_jit_employee(fap_job_ad_seq);
		sfaMapper.delete_job_category(fap_job_ad_seq);
		sfaMapper.delete_job_comp(fap_job_ad_seq);
		sfaMapper.delete_job_file(fap_job_ad_seq);
		sfaMapper.delete_job_isr(fap_job_ad_seq);
		sfaMapper.delete_job_ja_level(fap_job_ad_seq);
		sfaMapper.delete_job_join_dt(fap_job_ad_seq);
		sfaMapper.delete_job_pay(fap_job_ad_seq);
		sfaMapper.delete_job_pref(fap_job_ad_seq);
		sfaMapper.delete_job_trial(fap_job_ad_seq);
		sfaMapper.delete_job_work(fap_job_ad_seq);
		sfaMapper.delete_job_workplace(fap_job_ad_seq);
		
		logger.debug("FAP 채용공고(sub) 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : editable_check
	 * @Date : 2019. 1. 24.
	 * @User : 김준영
	 * @Param : 채용전형 seq
	 * @Return : 전형별지원결과정보 seq list
	 * @Method 설명 : 채용전형의 수정 가능 여부를 확인 하는 함수
	 */
	public int editable_check(long fap_job_recruit_pcs_seq){
		logger.info("FAP 채용전형 수정 가능 여부 확인 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		int editable_check = sfaMapper.editable_check(fap_job_recruit_pcs_seq);
		logger.info("FAP 채용전형 수정 가능 여부 확인 DAO 종료");
		return editable_check;
	}
	
	public ArrayList<HashMap<String, Object>> select_agency_management_company_list(){
		
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		ArrayList<HashMap<String, Object>> select_agency_management_company_list = sfaMapper.select_agency_management_company_list();
		
		return select_agency_management_company_list;
	}
	
	/**
	 * @Method Name : select_agency_comp
	 * @Date : 2019. 1. 25.
	 * @User : 이재준
	 * @Param : 에이전시 소속기업 아이디
	 * @Return : 기업 객체
	 * @Method 설명 : 에이전시 소속기업 객체를 가져오는 함수
	 */
	public SocietyFapCompanyUser select_agency_comp(String fap_comp_id){
		logger.info("FAP 에이전시 소속기업 정보 가져오기 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		SocietyFapCompanyUser societyFapCompanyUser = sfaMapper.select_agency_comp(fap_comp_id);
		logger.info("FAP 에이전시 소속기업 정보 가져오기 DAO 종료");
		return societyFapCompanyUser;
	}
	
	/**
	 * @Method Name : select_job_ad_by_state
	 * @Date : 2019. 2. 7.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMapList
	 * @Method 설명 : 분류된 채용공고 정보 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_job_ad_by_state(HashMap<String, Object> parmas){
		logger.debug("FAP 대기중인 채용공고를 가져오는 함수 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		ArrayList<HashMap<String, Object>> result = sfaMapper.select_job_ad_by_state(parmas);
		logger.debug("FAP 대기중인 채용공고를 가져오는 함수 끝");
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
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		int result = sfaMapper.update_job_ad_state(jobAd);
		logger.info("FAP 채용공고 상태를 수정하는 DAO 끝");
		return result; 
	}
	
	/**
	 * @Method Name : select_participate_possible_company_list
	 * @Date : 2019. 2. 7.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMapList
	 * @Method 설명 : FAP 에이전시 에이전시 관리 회사들 목록 요청
	 */
	public ArrayList<HashMap<String, Object>> select_participate_possible_company_list(HashMap<String, Object> param){
		logger.debug("FAP 에이전시 에이전시 관리 회사들 목록 요청 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		ArrayList<HashMap<String, Object>> agencyCompanyInfoList = sfaMapper.select_participate_possible_company_list(param);
		logger.debug("FAP 에이전시 에이전시 관리 회사들 목록 요청 DAO 종료");
		return agencyCompanyInfoList;
	}
	
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
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		
		//seq를 return받은 객체를 다시 반환할 map
		 HashMap<String, Object> result = new  HashMap<String, Object>();
		 
		//채용공고 등록
		SocietyFapJobAd jobAd = (SocietyFapJobAd)job_ad_parent.get("jobAd");
		String fap_comp_id = jobAd.getFap_comp_id();
		sfaMapper.insert_job_ad(jobAd);
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
		sfaMapper.insert_job_recruitpcs(after);		//insert 및 seq 반환
		jobRecruitPcs.setJobRecruitPcsList(after);	//seq가 반환된 리스트를 객체에 세팅
		result.put("jobRecruitPcs", jobRecruitPcs);
		
		logger.info("채용공고 정보 부모 등록 DAO 시작");
		return result;
	}
	
	/**
	 * @Method Name : insert_company_jobfair_join_table
	 * @Date : 2019. 2. 8.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : int
	 * @Method 설명 : FAP 에이전시 에이전시 관리 회사 잡페어 참가 요청
	 */
	public int insert_company_jobfair_join_table(HashMap<String, Object> insertCompanyInfo){
		logger.debug("FAP 에이전시 에이전시 관리 회사 잡페어 참가 등록 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		int insertResult = sfaMapper.insert_company_jobfair_join_table(insertCompanyInfo);
		logger.debug("FAP 에이전시 에이전시 관리 회사 잡페어 참가 등록 DAO 종료");
		return insertResult;
	}
	
	/**
	 * @Method Name : select_jobfair_attended_company_list
	 * @Date : 2019. 2. 8.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMapList
	 * @Method 설명 : FAP 에이전시 해당 잡페어에 참가할 회사목록 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_jobfair_attended_company_list(HashMap<String, Object> param){
		logger.debug("FAP 에이전시 해당 잡페어에 참가할 회사목록 셀렉트 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		ArrayList<HashMap<String, Object>> attendCompanyInfoList = sfaMapper.select_jobfair_attended_company_list(param);
		logger.debug("FAP 에이전시 해당 잡페어에 참가할 회사목록 셀렉트 DAO 종료");
		return attendCompanyInfoList;
	}
	
	/**
	 * @Method Name : select_company_of_parameter_comp_id
	 * @Date : 2019. 2. 8.
	 * @User : 정대영
	 * @Param : 선택된 회사 아이디
	 * @Return : 기업 객체
	 * @Method 설명 : 에이전시 담당자 가지고 있는 기업 객체를 가져오는 함수(파라미터 선택된 회사 아이디로)
	 */
	public SocietyFapCompanyUser select_company_of_parameter_comp_id(String chosen_fap_comp_id){
		logger.info("FAP 에이전시 정보 가져오기(파라미터 선택된 회사 아이디로) DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		SocietyFapCompanyUser societyFapCompanyUser = sfaMapper.select_company_of_parameter_comp_id(chosen_fap_comp_id);
		logger.info("FAP 에이전시 정보 가져오기(파라미터 선택된 회사 아이디로) DAO 종료");
		return societyFapCompanyUser;
	}
	
	/**
	 * @Method Name : select_company_name
	 * @Date : 2019. 2. 11.
	 * @User : 정대영
	 * @Param : String
	 * @Return : String
	 * @Method 설명 : FAP 에이전시 회사아이디로 회사명 요청
	 */
	public String select_company_name(String chosen_fap_comp_id){
		logger.info("FAP 에이전시 회사아이디로 회사명 요청 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		String chosen_fap_comp_ja_nm = sfaMapper.select_company_name(chosen_fap_comp_id);
		logger.info("FAP 에이전시 회사아이디로 회사명 요청 DAO 종료");
		return chosen_fap_comp_ja_nm;
	}
	
	/**
	 * @Method Name : select_job_ad_load_list_paging
	 * @Date : 2019. 2. 12.
	 * @User : 김준영
	 * @Param : 기업 아이디
	 * @Return : 채용공고
	 * @Method 설명 : 기업이 작성한 모든 채용공고를 불러오는 함수(페이징 처리 후) 
	 */
	public ArrayList<HashMap<String, Object>> select_job_ad_load_list_paging(HashMap<String, Object> paramMap, int start, int countPerPage){
		logger.info("FAP 기업이 작성한 채용공고 리스트 가져오기 DAO 시작");
		RowBounds rb = new RowBounds(start, countPerPage);
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		ArrayList<HashMap<String, Object>> select_job_ad_load_list = sfaMapper.select_job_ad_load_list_paging(paramMap, rb);
		logger.info("FAP 기업이 작성한 채용공고 리스트 가져오기 DAO 종료");
		return select_job_ad_load_list;
	}
	
	/**
	 * @Method Name : select_job_ad_load_list_count
	 * @Date : 2019. 2. 12.
	 * @User : 김준영
	 * @Param : 기업 아이디
	 * @Return : 채용공고 개수
	 * @Method 설명 : 기업이 작성한 모든 채용공고 총 개수를 불러오는 함수 
	 */
	public int select_job_ad_load_list_count(HashMap<String, Object> paramMap){
		logger.info("FAP 기업이 작성한 채용공고 리스트 총 개수 가져오기 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		int adTotalCount = sfaMapper.select_job_ad_load_list_count(paramMap);
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
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		ArrayList<SocietyFapJobFile> result = sfaMapper.select_job_file(fap_job_ad_seq);
		logger.info("FAP 채용공고 파일 리스트 가져오기 DAO 종료");
		return result;
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
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		ArrayList<SocietyFapJobExamFile> result = sfaMapper.select_job_exam_file(fap_job_ad_seq);
		logger.info("FAP 채용공고 시험전형 파일 정보 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_agency_jobfair_list
	 * @Date : 2019. 3. 12
	 * @User : 원병호
	 * @Param : 회사 아이디
	 * @Return : 
	 * @Method 설명 : 해당 회사가 참가한 잡페어 리스트
	 */
	public ArrayList<HashMap<String, Object>> select_agency_jobfair_list(String fap_comp_id){
		logger.info("FAP 회사가 참가한 잡페어 리스트 검색 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		ArrayList<HashMap<String, Object>> result = sfaMapper.select_agency_jobfair_list(fap_comp_id);
		logger.info("FAP 회사가 참가한 잡페어 리스트 검색 DAO 끝");
		return result;
	}
	
	/**
	 * @Method Name : search_company_jobfair_divide_list
	 * @Date : 2019. 3. 12
	 * @User : 원병호
	 * @Param : map(회사 아이디, 잡페어 일련번호)
	 * @Return : 
	 * @Method 설명 : 해당 회사가 참가한 잡페어 세부 리스트
	 */
	public ArrayList<HashMap<String, Object>> select_company_jobfair_divide_list(HashMap<String, Object> params){
		logger.info("FAP 회사가 참가한 잡페어 세부 리스트 검색 DAO 시작");
		SocietyFapAgencyMapper sfaMapper = sqlSession.getMapper(SocietyFapAgencyMapper.class);
		ArrayList<HashMap<String, Object>> result = sfaMapper.select_company_jobfair_divide_list(params);
		logger.info("FAP 회사가 참가한 잡페어 세부 리스트 검색 DAO 끝");
		return result;
	}
}
