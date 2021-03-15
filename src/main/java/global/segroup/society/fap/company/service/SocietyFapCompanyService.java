/**
 * 
 */
package global.segroup.society.fap.company.service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;

import global.segroup.dao.SEGroupCommonDAO;
import global.segroup.domain.BoardContent;
import global.segroup.domain.CertificationCode;
import global.segroup.domain.User;
import global.segroup.society.fap.admincommon.dao.SocietyFapAdminCommonDAO;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairSet;
import global.segroup.society.fap.admincommon.domain.SocietyFapJobRecruitPcsSch;
import global.segroup.society.fap.company.dao.SocietyFapCompanyDAO;
import global.segroup.society.fap.company.domain.SocietyFapCommonRequiredDoc;
import global.segroup.society.fap.company.domain.SocietyFapCompUserConnectRequest;
import global.segroup.society.fap.company.domain.SocietyFapCompanyUser;
import global.segroup.society.fap.company.domain.SocietyFapCompanyUserConnect;
import global.segroup.society.fap.company.domain.SocietyFapJobAd;
import global.segroup.society.fap.company.domain.SocietyFapJobApplyFinalResult;
import global.segroup.society.fap.company.domain.SocietyFapJobApplyResult;
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
import global.segroup.society.fap.company.domain.SocietyFapJobPref;
import global.segroup.society.fap.company.domain.SocietyFapJobRecruitPcs;
import global.segroup.society.fap.company.domain.SocietyFapJobServiceWork;
import global.segroup.society.fap.company.domain.SocietyFapJobTestEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobTestEtcObj;
import global.segroup.society.fap.company.domain.SocietyFapJobTrial;
import global.segroup.society.fap.company.domain.SocietyFapJobWork;
import global.segroup.society.fap.company.domain.SocietyFapJobWorkplace;
import global.segroup.society.fap.company.domain.SocietyFapJobWorkplaceDtl;
import global.segroup.society.fap.company.domain.SocietyFapLaJobPlan;
import global.segroup.society.fap.company.domain.SocietyFapLaJobSet;
import global.segroup.society.fap.company.domain.SocietyFapPersonalRequiredDoc;
import global.segroup.society.fap.company.domain.SocietyFapQnaAnswer;
import global.segroup.society.fap.company.domain.SocietyFapTokyofairDate;
import global.segroup.society.fap.company.domain.SocietyFapTokyofairScrUser;
import global.segroup.society.fap.company.domain.SocietyFapTokyofairScreening;
import global.segroup.society.fap.user.dao.SocietyFapUserDAO;
import global.segroup.society.fap.user.domain.SocietyFapNominee;
import global.segroup.util.FileService;
import global.segroup.util.MailService;

/**
 * @Author : 신동철
 * @Date : 2018. 11. 29.
 * @Class 설명 : Soft Engineer Society 통합잡페어 채용기업 서비스
 * 
 */
@Service
public class SocietyFapCompanyService {

	private static final Logger logger = LoggerFactory.getLogger(SocietyFapCompanyService.class);

	@Autowired
	private SocietyFapCompanyDAO sfcDAO;

	@Autowired
	private SocietyFapUserDAO sfuDAO;
	
	@Autowired
	private SEGroupCommonDAO sgcDAO;
	
	@Autowired
	private SocietyFapAdminCommonDAO sfaDAO;
	
	/**
	 * 암호화 관련 클래스
	 */
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	/**
	 * 메일을 보내는 서비스
	 */
	@Autowired
	private MailService mail;
	
	@Value("#{props['fap.company.user.logo_image']}")
	private String fapCompanyUserLogoImage;
	
	@Value("#{props['fap.company.required_doc_file']}")
	private String fapCompanyRequiredDocFile;
	
	private static final String SCREENING_SCH_GB_INSERT = "E0701";
	private static final String SCREENING_SCH_GB_DELETE = "E0700";
	
	/**
	 * @Method Name : UploadFileServer
	 * @Date : 2018. 12. 11.
	 * @User : 김준영
	 * @Param : 회사 정보 객체
	 * @Return : -
	 * @Method 설명 : 회사 등록시 로고 파일을 서버에 저장하는 함수
	 */
	private void UploadFileServer(SocietyFapCompanyUser sfcUser) {
		logger.info("FAP 회사 로고 등록 시작");
		// 저장 fullPath
		String fullPath = "/" + sfcUser.getFap_comp_id();
		try {
			if (sfcUser.getFap_comp_log_file() != null) {
				sfcUser.setFap_comp_log_origin(sfcUser.getFap_comp_log_file().getOriginalFilename());
				sfcUser.setFap_comp_log_saved(FileService.saveFile(sfcUser.getFap_comp_log_file(), fapCompanyUserLogoImage + fullPath));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		logger.info("FAP 회사 로고 등록 종료");
	}
	
	/**
	 * @Method Name : DeleteFileServer
	 * @Date : 2018. 12. 13.
	 * @User : 김준영
	 * @Param : 파일 이름, 파일 존재 여부
	 * @Return : -
	 * @Method 설명 : 서버에 저장되어있는 파일을 삭제하는 함수
	 */
	private void DeleteFileServer(SocietyFapCompanyUser sfcUser) {
		logger.info("FAP 회사 로고 삭제 시작");
		// 삭제 fullPath
		String fullPath = "/" + sfcUser.getFap_comp_id();
		try {
			//로고 이미지 파일 삭제
			FileService.deleteFile(sfcUser.getFap_comp_log_saved(), fapCompanyUserLogoImage + fullPath);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		logger.info("FAP 회사 로고 삭제 종료");
	}
	
	/**
	 * @Method Name : userIdCheck
	 * @Date : 2018. 12. 11.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 유저아이디 or null
	 * @Method 설명 : 유저 아이디 중복 검사 중복된 경우 아이디 값이 return되며 중복 되지 않은 경우 null이 return됨
	 */
	public String user_id_check(String user_id){
		logger.info("FAP 유저 아이디 중복체크 서비스 시작");
		String user_id_check = sfcDAO.user_id_check(user_id);
		logger.info("FAP 유저 아이디 중복체크 서비스 종료");
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
		logger.info("FAP 유저 등록 서비스 시작");
		sfcDAO.insert_com_user(user);
		logger.info("FAP 유저 등록 서비스 종료");
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
		logger.info("FAP 회사 등록 서비스 시작");
		// 로고 파일 저장
		UploadFileServer(sfcUser);
		sfcDAO.insert_company(sfcUser);
		logger.info("FAP 회사 등록 서비스 종료");
	}*/
	
	/**
	 * @Method Name : comp_user_connect
	 * @Date : 2018. 12. 12.
	 * @User : 김준영
	 * @Param : 회사-담당자 연결 객체
	 * @Return : -
	 * @Method 설명 : 회사와 담당자를 연결해주는 함수
	 */
	public int comp_user_connect(SocietyFapCompanyUserConnect sfCUConnect){
		logger.info("FAP 회사-담당자 연결 서비스 시작");
		int result = sfcDAO.comp_user_connect(sfCUConnect);
		logger.info("FAP 회사-담당자 연결 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : insert_company
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 공통 유저 객체, 회사 정보 객체
	 * @Return : -
	 * @Method 설명 : 회사 정보를 등록 하는 함수
	 */
	public void insert_company(String company_ck, User user, 
			SocietyFapCompanyUser societyFapCompanyUser, 
			SocietyFapCompanyUserConnect societyFapCompanyUserConnect){
		logger.info("FAP 회사 등록 서비스 시작");
		// 회사 이름과 담당자 ID를 합쳐 회사 아이디를 만듦
		String company_id = ((societyFapCompanyUser.getFap_comp_en_nm()).replaceAll(" ","")) + "@_@" + user.getUser_id();
		societyFapCompanyUser.setFap_comp_id(company_id);
		UploadFileServer(societyFapCompanyUser);
		sfcDAO.insert_company(company_ck, user, societyFapCompanyUser, societyFapCompanyUserConnect);
		logger.info("FAP 회사 등록 서비스 종료");
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
		
		logger.info("FAP 특정 회사 로고 정보 획득 함수 서비스 시작");
		SocietyFapCompanyUser societyFapCompanyUser = new SocietyFapCompanyUser();
		societyFapCompanyUser = sfcDAO.select_company_log(user_id);
		logger.info("FAP 특정 회사 로고 정보 획득 함수 서비스 종료");
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
		logger.info("FAP 회사 정보 가져오기 서비스 시작");
		SocietyFapCompanyUser societyFapCompanyUser = new SocietyFapCompanyUser();
		societyFapCompanyUser = sfcDAO.select_company(user_id);
		logger.info("FAP 회사 정보 가져오기 서비스 종료");
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
		logger.info("FAP 회사 정보 업데이트 서비스 시작");
		if(sfcUser.getFap_comp_log_file() != null && !sfcUser.getFap_comp_log_file().isEmpty()){
			
			if (sfcUser.getFap_comp_log_saved() != null) {
				
				DeleteFileServer(sfcUser);
			}
			UploadFileServer(sfcUser);
		}
		sfcDAO.update_company(sfcUser);
		logger.info("FAP 회사 정보 업데이트 서비스 종료");
	
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
		logger.info("FAP 기업 담당자 정보 가져오기 서비스 시작");
		User user = sfcDAO.select_user(user_id);
		logger.info("FAP 기업 담당자 정보 가져오기 서비스 종료");
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
		logger.info("FAP 회사 담당자 정보 수정 서비스 시작");
		sfcDAO.update_user(user);
		logger.info("FAP 회사 담당자 정보 수정 서비스 종료");
	}
	
	/**
	 * @Method Name : user_forgot_id
	 * @Date : 2018. 12. 24.
	 * @User : 김준영
	 * @Param : 공통 유저 객체
	 * @Return : 공통 유저 객체
	 * @Method 설명 : 유저 아이디가 존재하는지 검색 하는 함수
	 */
	public String user_forgot_id(User userInfo) {
		logger.debug("유저 정보 검색 서비스 시작");
		
		User found = sgcDAO.selectUser(userInfo);
		String foundId = null;
		String blindId = "";
		String cutedId = "";
		
		if (found != null) {
			foundId = found.getUser_id();
			
			final int INDEX = foundId.length();
			
			for (int i = INDEX; i > 4; i--) {
				blindId += "*";
			}
			
			cutedId = foundId.substring(0,4);
			foundId = cutedId + blindId;
			
		}
		
		logger.debug("유저 정보 검색 서비스 종료");
		
		return foundId;
	}
	
	/**
	 * @Method Name : user_request_certification_code
	 * @Date : 2018. 12. 24.
	 * @User : 김준영
	 * @Param : 공통 유저 객체
	 * @Return : 인증번호
	 * @Method 설명 : 인증번호를 생성하여 메일을 보내는 함수
	 */
	public int user_request_certification_code(User userInfo) {
		logger.info("FAP 인증번호 요청 서비스 시작");
		try {
			// 유저 정보 검색
			User found = sgcDAO.selectUser(userInfo);
			if (found == null) {
				logger.info("FAP 인증번호 요청 서비스 종료");
				return 1;
			}
			
			// 유저가 사용하고 있는 코드가 있는지 검색한다
			CertificationCode code = new CertificationCode();
			code.setUser_id(found.getUser_id());
			CertificationCode foundCode = sgcDAO.selectCertificationCode(code);
	
			// 만약 유저에 해당되는 코드가 존재한다면 없애버린다
			if (foundCode != null) {
				foundCode.setUser_id(null);
				sgcDAO.updateCertificationCode(foundCode);
			}
	
			// 랜덤으로 숫자를 골라온다
			CertificationCode sendCode = sgcDAO.chooseCertificationCode();
			if (sendCode == null) {
				logger.info("FAP 인증번호 요청 서비스 종료");
				return 3;
			}
			
			// 코드를 세팅한다
			userInfo.setUser_id(code.getUser_id());
			code.setCertification_code(sendCode.getCertification_code());
			
			sgcDAO.updateCertificationCode(code);
			
			final String FROM = "sesoc2019@gamil.com";
	        final String TO = userInfo.getUser_email();
	        final String SUBJECT = "認証番号";
	        final String TEXT = String.format("認証番号: %04d", code.getCertification_code());
			mail.sendMail(FROM, TO, SUBJECT, TEXT);
			
		} catch (MessagingException e) {
			e.printStackTrace();
			logger.info("FAP 인증번호 요청 서비스 종료");
			return 2;
		} catch (NullPointerException ne) {
			ne.printStackTrace();
			logger.info("FAP 인증번호 요청 서비스 종료");
			return 2;
		}
		logger.info("FAP 인증번호 요청 서비스 종료");
		return 0;
	}
	
	/**
	 * @Method Name : user_check_certification_code
	 * @Date : 2018. 12. 24.
	 * @User : 김준영
	 * @Param : 인증번호
	 * @Return : 인증번호의 확인 결과
	 * @Method 설명 : 인증번호가 일치하는지 확인 하여 결과를 리턴하는 함수
	 */
	public boolean user_check_certification_code(CertificationCode code) {
		logger.info("FAP 인증번호 확인 서비스 시작");
		if (code.getUser_id() == null) {
			return false;
		}
		
		// 유저가 사용하고 있는 코드가 있는지 검색한다
		CertificationCode foundCode = sgcDAO.selectCertificationCode(code);
		if (foundCode == null) {
			return false;
		}
		
		// 찾았다면 갱신하여 삭제한다
		code.setUser_id(null);
		sgcDAO.updateCertificationCode(foundCode);
	
		return true;
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
		logger.info("통합잡페어 정보 리스트 검색 Service 시작");
		
		ArrayList<HashMap<String, Object>> jobfair_search_list = sfcDAO.jobfair_search_list();
		
		logger.info("통합잡페어 정보 리스트 검색 Service 종료");
		return jobfair_search_list;
	}	
	
	/**
	 * @Method Name : jobfair_company_search_list
	 * @Date : 2018. 12. 24.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어 세부정보 리스트
	 * @Method 설명 : 선택한 잡페어 세부정보 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> jobfair_divide_search_list(int fap_jobfair_seq){
		logger.info("선택한 잡페어 세부정보 리스트 검색 Service 시작");
		
		ArrayList<HashMap<String, Object>> jobfair_divide_search_list = sfcDAO.jobfair_divide_search_list(fap_jobfair_seq);
		
		logger.info("선택한 잡페어 세부정보 리스트 검색 Service 종료");
		return jobfair_divide_search_list;
	}
	
	/**
	 * @Method Name : company_jobfair_divide_participation
	 * @Date : 2018. 12. 24.
	 * @User : 신동철
	 * @Param : 회사잡페어등록정보(잡페어 시퀀스, 잡페어 세부 시퀀스, 회사 아이디, 에이전시 여부구분)
	 * @Return : -
	 * @Method 설명 : 회사잡페어 등록정보 입력
	 */
	public void company_jobfair_divide_participation(HashMap<String, Object> hashmap){
		logger.info("회사잡페어 등록정보 입력 Service 시작");
		
		sfcDAO.company_jobfair_divide_participation(hashmap);
		
		logger.info("회사잡페어 등록정보 입력 Service 종료");
	}
	
	/**
	 * @Method Name : company_forgot_password
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 기업 담당자 아이디, 비밀번호
	 * @Return : 변경 여부
	 * @Method 설명 : 기업 담당자의 비밀번호를 변경하는 함수
	 */
	public boolean company_forgot_password(String user_id, String user_pw) {
		logger.debug("FAP 기업 담당자 비밀번호 변경 서비스 시작");
		
		User userInfo = new User();
		userInfo.setUser_id(user_id);
		
		User found = sgcDAO.selectUser(userInfo);
		if (found == null) {
			return false;
		}
		
		String encodedPw = passwordEncoder.encode(user_pw);
		found.setUser_pw(encodedPw);
		sfuDAO.update_com_user(found);
		
		logger.debug("FAP 기업 담당자 비밀번호 변경 서비스 종료");
		return true;
	}
	
	/**
	 * @Method Name : delete_company_user_info
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 탈퇴할 기업 담당자 객체
	 * @Return : -
	 * @Method 설명 : 기업 담당자 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(45글자) 변경후 참조 테이블에 적용
	 */
	public int delete_company_user_info(User user){
		logger.info("FAP 회원 탈퇴 서비스 시작");
		int result = sfcDAO.delete_company_user_info(user);
		logger.info("FAP 회원 탈퇴 서비스 시작");
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
		logger.info("FAP 기업 - 유저 연결 객체 가져오기 서비스 시작");
		SocietyFapCompanyUserConnect comp_user_connect = sfcDAO.select_comp_user_connect(user_id);
		logger.info("FAP 기업 - 유저 연결 객체 가져오기 서비스 종료");
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
		logger.info("FAP 기업 리스트 가져오기 서비스 시작");
		ArrayList<SocietyFapCompanyUser> company_list = sfcDAO.select_all_company();
		logger.info("FAP 기업 리스트 가져오기 서비스 종료");
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
		logger.info("FAP 기업 - 유저 연결 서비스 시작");
		int result = sfcDAO.delete_comp_user_connect(fap_comp_user_connect_seq);
		logger.info("FAP 기업 - 유저 연결 서비스 종료");
		return result;
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
		logger.debug("회사잡페어등록정보 검색 Service 시작");
		
		ArrayList<HashMap<String, Object>> select_company_jobfair_participation_list = sfcDAO.select_company_jobfair_participation(hashmap);	
				
		logger.debug("회사잡페어등록정보 검색 Service 종료");
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
		logger.debug("회사 아이디 발급 여부 검색 Service 시작");
		
		String fap_comp_id = sfcDAO.select_fap_comp_id(user_id);
		
		logger.debug("회사 아이디 발급 여부 검색 Service 종료");		
		return fap_comp_id;
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
		logger.info("FAP 연결 요청한 에이전시 리스트 가져오기 서비스 시작");
		ArrayList<SocietyFapCompanyUser> agency_list = sfcDAO.select_connect_request(user_id);	
		logger.info("FAP 연결 요청한 에이전시 리스트 가져오기 서비스 종료");
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
		logger.info("FAP 공통 내정서류 등록 Service 시작");
		
		// 저장 fullPath
		String fullPath = "/" + common_required_doc.getFap_comp_id() + "_" + common_required_doc.getFap_job_ad_seq();
		// 공통 내정서류 파일저장
		try {
			if (common_required_doc.getFap_common_required_doc_file() != null) {
				common_required_doc.setFap_common_required_doc_origin(common_required_doc.getFap_common_required_doc_file().getOriginalFilename());
				common_required_doc.setFap_common_required_doc_saved(FileService.saveFile(common_required_doc.getFap_common_required_doc_file(), fapCompanyRequiredDocFile + fullPath));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		// 공통 내정서류 등록
		int result = sfcDAO.insert_common_required_doc(common_required_doc);
		
		logger.info("FAP 공통 내정서류 등록 Service 종료");
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
		logger.info("FAP 공통 내정서류 삭제 Service 시작");
		
		// 저장 fullPath
		String fullPath = "/" + common_required_doc.getFap_comp_id() + "_" + common_required_doc.getFap_job_ad_seq();
		//공통 내정서류 파일삭제
		try {
			//공통 내정서류 파일 삭제
			FileService.deleteFile(common_required_doc.getFap_common_required_doc_saved(), fapCompanyRequiredDocFile + fullPath);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		//공통 내정서류 삭제
		sfcDAO.delete_common_required_doc(common_required_doc);
		
		logger.info("FAP 공통 내정서류 삭제 Service 종료");
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
		logger.info("FAP 공통 내정서류 리스트 검색 Service 시작");
		
		ArrayList<SocietyFapCommonRequiredDoc> common_required_doc_list =  sfcDAO.search_common_required_doc_list(hashmap);		
		
		logger.info("FAP 공통 내정서류 리스트 검색 Service 종료");
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
	public void request_handling(Authentication auth, String fap_comp_id, String handling_ck){
		logger.info("FAP 에이전시 요청 처리 DAO 시작");
		sfcDAO.request_handling(auth, fap_comp_id, handling_ck);
		logger.info("FAP 에이전시 요청 처리 DAO 시작");
	}
	
	/**
	 * @Method Name : select_common_required_doc
	 * @Date : 2019. 1. 2.
	 * @User : 신동철
	 * @Param : 공통내정서류 시퀀스
	 * @Return : 공통내정서류 정보
	 * @Method 설명 : 특정 공통내정서류를 검색하는 함수
	 */
	public SocietyFapCommonRequiredDoc select_common_required_doc(int fap_required_doc_seq){
		logger.info("FAP  특정 공통내정서류 검색 DAO 시작");
		
		SocietyFapCommonRequiredDoc common_required_doc = sfcDAO.select_common_required_doc(fap_required_doc_seq);
		
		logger.info("FAP  특정 공통내정서류 검색 DAO 종료");
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
		logger.info("FAP 공통 내정서류 수정 Service 시작");
		
		// 저장 fullPath
		String fullPath = "/" + common_required_doc.getFap_comp_id() + "_" + common_required_doc.getFap_job_ad_seq();
			
			//공통 내정서류 체크
			if(common_required_doc.getFap_common_required_doc_file() != null && !common_required_doc.getFap_common_required_doc_file().isEmpty()){
				if(common_required_doc.getFap_common_required_doc_origin() != null && common_required_doc.getFap_common_required_doc_saved() != null){
					FileService.deleteFile(common_required_doc.getFap_common_required_doc_saved(), fapCompanyRequiredDocFile + fullPath);
				}				
				String docOrigin = common_required_doc.getFap_common_required_doc_file().getOriginalFilename();
				String docSaved = FileService.saveFile(common_required_doc.getFap_common_required_doc_file(), fapCompanyRequiredDocFile + fullPath);
				common_required_doc.setFap_common_required_doc_origin(docOrigin);
				common_required_doc.setFap_common_required_doc_saved(docSaved);
			}
			//공통 내정서류 수정
			sfcDAO.update_common_required_doc(common_required_doc);
		
		logger.info("FAP 공통 내정서류 수정 Service 종료");
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
		logger.info("FAP 회사가 참가한 채용공고 리스트 검색 Service 시작");
		
		ArrayList<SocietyFapJobAd> company_job_ad_list = sfcDAO.search_company_job_ad_list(job_ad);
		
		logger.info("FAP 회사가 참가한 채용공고 리스트 검색 Service 종료");
		return company_job_ad_list;
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
		logger.info("FAP 일반 기업 가져오기 서비스 시작");
		ArrayList<SocietyFapCompanyUser> comp_list = sfcDAO.select_common_company();
		logger.info("FAP 일반 기업 가져오기 서비스 종료");
		return comp_list;
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
		logger.info("FAP 특정 회사의 내정자 정보 리스트 검색 Service 시작");
		
		ArrayList<HashMap<String, Object>> nominee_info_list = sfcDAO.search_nominee_info_list(hashmap);
		
		logger.info("FAP 특정 회사의 내정자 정보 리스트 검색 Service 종료");
		return nominee_info_list;
	}
	
	/**
	 * @Method Name : insert_personal_required_doc
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 개인 내정서류 정보
	 * @Return : -
	 * @Method 설명 : 개인 내정서류를 등록하는 함수
	 */
	public int insert_personal_required_doc(SocietyFapPersonalRequiredDoc personal_required_doc){
		logger.info("FAP 개인 내정서류 등록 Service 시작");		
		
		String user_id = personal_required_doc.getFap_personal_required_doc_ins_id();
		String user_flag = sfcDAO.select_user_flag(user_id);
		
		if(user_flag == null){		//채용기업
			personal_required_doc.setFap_personal_required_doc_uploader_gb("C4800");	//업로더는 채용기업
		}else if(user_flag.equals("A0100") || user_flag.equals("A0101") || user_flag.equals("A0106")){		//지원자(마스터, K-move, 일반)
			personal_required_doc.setFap_personal_required_doc_uploader_gb("C4801");		//업로더는 지원자
		}
		
		// 저장 fullPath
		String fullPath = "/" + personal_required_doc.getFap_comp_id() + "_" + personal_required_doc.getFap_job_ad_seq() + "/" + personal_required_doc.getFap_nominee_seq();
		//개인 내정서류 파일저장
		try {
			if (personal_required_doc.getFap_personal_required_doc_file() != null) {
				personal_required_doc.setFap_personal_required_doc_origin(personal_required_doc.getFap_personal_required_doc_file().getOriginalFilename());
				personal_required_doc.setFap_personal_required_doc_saved(FileService.saveFile(personal_required_doc.getFap_personal_required_doc_file(), fapCompanyRequiredDocFile + fullPath));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		// 개인 내정서류 등록
		int result = sfcDAO.insert_personal_required_doc(personal_required_doc);
		
		logger.info("FAP 개인 내정서류 등록 Service 종료");
		return result; 
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
		logger.info("FAP 특정 내정자 정보 검색 Service 시작");
	
		SocietyFapNominee nominee_info = sfcDAO.select_nominee_info(fap_nominee_seq);
		
		logger.info("FAP 특정 내정자 정보 검색 Service 종료");
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
		logger.info("FAP 개인 내정서류 리스트 검색 Service 시작");
		
		ArrayList<HashMap<String, Object>> personal_required_doc_list = sfcDAO.search_personal_required_doc_list(fap_nominee_seq);
		
		logger.info("FAP 개인 내정서류 리스트 검색 Service 종료");
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
		
		SocietyFapPersonalRequiredDoc personal_required_doc = sfcDAO.select_personal_required_doc(fap_nominee_seq);
		
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
		logger.info("FAP 개인 내정서류 정보 수정 Service 시작");
		
		//내정자 정보 검색
		SocietyFapNominee nominee_info = sfcDAO.select_nominee_info((int)personal_required_doc.getFap_nominee_seq());
		// 저장 fullPath
		String fullPath = "/" + nominee_info.getFap_comp_id() + "_" + nominee_info.getFap_job_ad_seq() + "/" + nominee_info.getFap_nominee_seq();
					
		//공통 내정서류 체크
		if(personal_required_doc.getFap_personal_required_doc_file() != null && !personal_required_doc.getFap_personal_required_doc_file().isEmpty()){
			if(personal_required_doc.getFap_personal_required_doc_origin() != null && personal_required_doc.getFap_personal_required_doc_saved() != null){
				FileService.deleteFile(personal_required_doc.getFap_personal_required_doc_saved(), fapCompanyRequiredDocFile + fullPath);
			}				
			String docOrigin = personal_required_doc.getFap_personal_required_doc_file().getOriginalFilename();
			String docSaved = FileService.saveFile(personal_required_doc.getFap_personal_required_doc_file(), fapCompanyRequiredDocFile + fullPath);
			personal_required_doc.setFap_personal_required_doc_origin(docOrigin);
			personal_required_doc.setFap_personal_required_doc_saved(docSaved);	
		}
		//공통 내정서류 수정		
		sfcDAO.update_personal_required_doc(personal_required_doc);
		
		logger.info("FAP 개인 내정서류 정보 수정 Service 종료");
	}
	
	/**
	 * @Method Name : delete_personal_required_doc
	 * @Date : 2019. 1. 1.
	 * @User : 신동철
	 * @Param : 개인 내정서류 정보
	 * @Return : -
	 * @Method 설명 : 개인 내정서류를 삭제하는 함수
	 */
	public void delete_personal_required_doc(SocietyFapPersonalRequiredDoc personal_required_doc){
		logger.info("FAP 공통 내정서류 삭제 Service 시작");
		
		//내정자 정보 검색
		SocietyFapNominee nominee_info = sfcDAO.select_nominee_info((long)personal_required_doc.getFap_nominee_seq());
		// 저장 fullPath
		String fullPath = "/" + nominee_info.getFap_comp_id() + "_" + nominee_info.getFap_job_ad_seq() + "/" + nominee_info.getFap_nominee_seq();
		//공통 내정서류 파일삭제
		try {
			//공통 내정서류 파일 삭제
			FileService.deleteFile(personal_required_doc.getFap_personal_required_doc_saved(), fapCompanyRequiredDocFile + fullPath);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		//공통 내정서류 삭제
		sfcDAO.delete_personal_required_doc(personal_required_doc);
		
		logger.info("FAP 공통 내정서류 삭제 Service 종료");
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
		logger.info("FAP 개인 내정서류 정보 삭제 Service 시작");
		
		HashMap<String, Object> nominee_info = sfcDAO.search_nominee_info(nominee);
		
		logger.info("FAP 개인 내정서류 정보 삭제 Service 종료");
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
		logger.info("FAP 사용중인 현지잡페어 설정 취득 Service 시작");
		
		HashMap<String, Object> result = sfcDAO.algorithm_jobfair_setting_use_search(params);
		
		logger.info("FAP 사용중인 현지잡페어 설정 취득 Service 종료");
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
	public void user_company_info_insert(Authentication auth, SocietyFapCompanyUser company_info){
		logger.info("FAP 기업 담당자 - 기업 정보 입력 서비스 시작");
		UploadFileServer(company_info);
		sfcDAO.user_company_info_insert(auth, company_info);
		logger.info("FAP 기업 담당자 - 기업 정보 입력 서비스 시작");
	}
	
	//채용공고 이전 시작
	
	
	@Value("#{props['fap.company.job_ad_movie_file']}")
	private String fapJobAdMovieFile;
	@Value("#{props['fap.company.job_ad_pdf_file']}")
	private String fapJobAdPdfFile;
	@Value("#{props['fap.company.job_ad_photo_file']}")
	private String fapJobAdPhotoFile;
	@Value("#{props['fap.company.job_recruit_exam_file']}")
	private String fapJobRecruitExamFile;
	
	/**
	 * @Method Name : UploadJobAdMovieServer
	 * @Date : 2018. 12. 30.
	 * @User : 이재준
	 * @Param : 채용공고 동영상 파일 정보
	 * @Return : -
	 * @Method 설명 : 채용공고 동영상 파일을 저장
	 */
	private void UploadJobAdMovieServer(SocietyFapJobFile JobFile) {
		logger.info("FAP 채용공고 동영상 파일 등록 시작");
		try {
			if (JobFile.getJob_ad_file() != null) {
				JobFile.setFap_job_file_origin(JobFile.getJob_ad_file().getOriginalFilename());
				JobFile.setFap_job_file_saved(FileService.saveFile(JobFile.getJob_ad_file(), fapJobAdMovieFile));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		logger.info("FAP 채용공고 동영상 파일 등록 종료");
	}

	private void UploadJobAdPdfServer(SocietyFapJobFile JobFile) {
		logger.info("FAP 채용공고 Pdf 파일 등록 시작");
		try {
			if (JobFile.getJob_ad_file() != null) {
				JobFile.setFap_job_file_origin(JobFile.getJob_ad_file().getOriginalFilename());
				JobFile.setFap_job_file_saved(FileService.saveFile(JobFile.getJob_ad_file(), fapJobAdPdfFile));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		logger.info("FAP 채용공고 Pdf 파일 등록 종료");
	}
	
	private void UploadJobAdPhotoServer(SocietyFapJobFile JobFile) {
		logger.info("FAP 채용공고 이미지 파일 등록 시작");
		try {
			if (JobFile.getJob_ad_file() != null) {
				JobFile.setFap_job_file_origin(JobFile.getJob_ad_file().getOriginalFilename());
				JobFile.setFap_job_file_saved(FileService.saveFile(JobFile.getJob_ad_file(), fapJobAdPhotoFile));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		logger.info("FAP 채용공고 이미지 파일 등록 종료");
	}
	
	/**
	 * @Method Name : job_ad_insert
	 * @Date : 2018. 12. 24.
	 * @User : 이재준
	 * @Param : 채용공고 정보
	 * @Return : 
	 * @Method 설명 : 
	 */
	@Transactional
	public void job_ad_insert2(SocietyFapJobAd JobAd, SocietyFapJobDorm JobDorm, SocietyFapJobJitEmployee JobJitEmployee,
			SocietyFapJobJaLevel JobJaLevel, SocietyFapJobTrial JobTrial, SocietyFapJobComp JobComp, SocietyFapJobFile JobFile
			, SocietyFapJobIsr JobIsr, SocietyFapJobJoinDt JobJoinDt, SocietyFapJobWork JobWork, 
			SocietyFapJobCategory JobCategory, SocietyFapJobPref JobPref, SocietyFapJobWorkplace JobWorkplace,
			SocietyFapJobRecruitPcs JobRecruitPcs, SocietyFapJobPay JobPay) {
		logger.info("분리된 채용공고 등록 시작");
			
		String file_path = "";
		List<SocietyFapJobFile> job_file_list = new ArrayList<SocietyFapJobFile>();	//파일 저장후 db저장값을 담기위한 중간 객체
		
		/*파일 등록 */
		for(SocietyFapJobFile job_file : JobFile.getJobFileList()){
			
			if(job_file.getJob_ad_file() == null){
				//load한 파일을 등록하는 경우
				logger.info("jump {}", job_file);
				// file service로 clone 만들고 해당 saved와 origin을 객체에 셋팅함고 add해준다.
				/*file path 설정*/
				if(job_file.getFap_job_file_gb().equals("C0700")){
					//video
					file_path = fapJobAdMovieFile;
				}else if(job_file.getFap_job_file_gb().equals("C0701")){
					//pdf
					file_path = fapJobAdPdfFile;
				}else if(job_file.getFap_job_file_gb().equals("C0702")){
					//photo
					file_path = fapJobAdPhotoFile;
				}
				job_file.setFap_job_file_saved(FileService.fileCopy(job_file.getFap_job_file_origin(), job_file.getFap_job_file_saved(), file_path, file_path));
				job_file_list.add(job_file);
				
			}else if(job_file.getJob_ad_file().isEmpty()){
				//있던 파일을 삭제한 경우(빈 input file이 있는 경우) 삭제만 한다
				logger.info("empty");
				
				job_file.setFap_job_file_saved(null);
				job_file.setFap_job_file_origin(null);
				
				job_file_list.add(job_file);
				
			}else{
				//있던파일 삭제후 새로 등록 (들어있는 input file) 삭제후 등록)
				logger.info("not empty");
				
				if(job_file.getFap_job_file_gb().equals("C0700")){
					//video
					file_path = fapJobAdMovieFile;
					UploadJobAdMovieServer(job_file);
				}else if(job_file.getFap_job_file_gb().equals("C0701")){
					//pdf
					file_path = fapJobAdPdfFile;
					UploadJobAdPdfServer(job_file);
				}else if(job_file.getFap_job_file_gb().equals("C0702")){
					//photo
					file_path = fapJobAdPhotoFile;
					UploadJobAdPhotoServer(job_file);
				}
				logger.info("객체 : {}", job_file);
				job_file_list.add(job_file);
			}
			
		}
		JobFile.setJobFileList(job_file_list);
		/*파일 수정 끝*/
		
		
	
		/*************************** 채용공고 등록 시작 *******************************/
		String fap_comp_id = JobAd.getFap_comp_id();
		
		JobAd = sfcDAO.insert_job_ad2(JobAd);
		
		//기숙사 (C0800:기숙사 제도있음)
		if(JobAd.getFap_job_ad_isdorm() != null && JobAd.getFap_job_ad_isdorm().equals("C0800")){
		JobDorm.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
		sfcDAO.insert_job_dorm(JobDorm);
		}
		
		//계약사원 (C0401:모집형태 계약사원)
		if(JobAd.getFap_job_ad_hire_type() != null && JobAd.getFap_job_ad_hire_type().equals("C0401")){
		JobJitEmployee.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
		sfcDAO.insert_job_jit_employee(JobJitEmployee);
		}
		
		//업무에 필요한 일본어 능력 03.13 수정(원병호)
		if( !JobJaLevel.getFap_job_ja_level_dtl().equals("") || JobJaLevel.getFap_job_ja_level_gb() != null){
		JobJaLevel.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
		sfcDAO.insert_job_ja_level(JobJaLevel);
		}
		
		//시용기간 (C0500:시용기간 있음)
		if(JobAd.getFap_job_ad_intern() != null && JobAd.getFap_job_ad_intern().equals("C0500")){
		JobTrial.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());	
		sfcDAO.insert_job_trial(JobTrial);
		}
		
		//없으면 들어오지 않는 값
		if(JobComp.getJobCompList() != null && JobComp.getJobCompList().size() !=0){
			for (int i = 0; i < JobComp.getJobCompList().size(); i++) {
				JobComp.getJobCompList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobComp.getJobCompList().get(i).setFap_job_comp_ins_id(fap_comp_id);
				JobComp.getJobCompList().get(i).setFap_job_comp_udt_id(fap_comp_id);
			}
			sfcDAO.insert_job_comp(JobComp);
		}
		
		if(JobFile != null && JobFile.getJobFileList().size() !=0){
			for (int i = 0; i < JobFile.getJobFileList().size(); i++) {
				JobFile.getJobFileList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobFile.getJobFileList().get(i).setFap_job_file_ins_id(fap_comp_id);
				JobFile.getJobFileList().get(i).setFap_job_file_udt_id(fap_comp_id);
			}
			sfcDAO.insert_job_file(JobFile);
		}
		
		if(JobIsr.getJobIsrList() != null && JobIsr.getJobIsrList().size() !=0){
			for (int i = 0; i < JobIsr.getJobIsrList().size(); i++) {
				JobIsr.getJobIsrList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobIsr.getJobIsrList().get(i).setFap_job_isr_ins_id(fap_comp_id);
				JobIsr.getJobIsrList().get(i).setFap_job_isr_udt_id(fap_comp_id);
			}
			sfcDAO.insert_job_isr(JobIsr);
		}
		
		if(JobJoinDt != null && JobJoinDt.getJobJoinDtList().size() !=0){
			for (int i = 0; i < JobJoinDt.getJobJoinDtList().size(); i++) {
				JobJoinDt.getJobJoinDtList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobJoinDt.getJobJoinDtList().get(i).setFap_job_join_dt_ins_id(fap_comp_id);
				JobJoinDt.getJobJoinDtList().get(i).setFap_job_join_dt_udt_id(fap_comp_id);
			}
			sfcDAO.insert_job_join_dt(JobJoinDt);
		}
		
		if(JobWork != null && JobWork.getJobWorkList().size() !=0){
			for (int i = 0; i < JobWork.getJobWorkList().size(); i++) {
				JobWork.getJobWorkList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobWork.getJobWorkList().get(i).setFap_job_work_ins_id(fap_comp_id);
				JobWork.getJobWorkList().get(i).setFap_job_work_udt_id(fap_comp_id);
			}
			sfcDAO.insert_job_work(JobWork);
		}
		
		ArrayList<SocietyFapJobCategory> list = new ArrayList<>();
		
		if(JobCategory != null && JobCategory.getJobCategoryList().size() !=0){
			for (int i = 0; i < JobCategory.getJobCategoryList().size(); i++) {
				JobCategory.getJobCategoryList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobCategory.getJobCategoryList().get(i).setFap_job_category_ins_id(fap_comp_id);
				JobCategory.getJobCategoryList().get(i).setFap_job_category_udt_id(fap_comp_id);
			
				if(JobCategory.getJobCategoryList().get(i).getFap_job_category_gb() != null) {
					list.add(JobCategory.getJobCategoryList().get(i));
				}
			}

			if(list != null && list.size() != 0){
				sfcDAO.insert_job_category(list);
			}
			
			for (int i = 0; i < list.size(); i++) {
				if(list.get(i).getJobCategoryEtc() != null) {
					list.get(i).getJobCategoryEtc().setFap_job_category_etc_ins_id(fap_comp_id);
					list.get(i).getJobCategoryEtc().setFap_job_category_etc_udt_id(fap_comp_id);
					list.get(i).getJobCategoryEtc().setFap_job_category_seq(list.get(i).getFap_job_category_seq());
					sfcDAO.insert_job_category_etc(list.get(i).getJobCategoryEtc());
				}
			}
			
		}
		
		if(JobPref != null && JobPref.getJobPrefList().size() !=0){
			for (int i = 0; i < JobPref.getJobPrefList().size(); i++) {
				JobPref.getJobPrefList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobPref.getJobPrefList().get(i).setFap_job_pref_ins_id(fap_comp_id);
				JobPref.getJobPrefList().get(i).setFap_job_pref_udt_id(fap_comp_id);
			}
			sfcDAO.insert_job_pref(JobPref);
		}
		
		
		List<SocietyFapJobWorkplace> jobWorkplaceList = new ArrayList<>();
		
		for (int i = 0; i < JobWorkplace.getJobWorkplaceList().size(); i++) {
			JobWorkplace.getJobWorkplaceList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
			JobWorkplace.getJobWorkplaceList().get(i).setFap_job_workplace_ins_id(fap_comp_id);
			JobWorkplace.getJobWorkplaceList().get(i).setFap_job_workplace_udt_id(fap_comp_id);
			
			if(JobWorkplace.getJobWorkplaceList().get(i).getFap_job_workplace_gb() != null){
				jobWorkplaceList.add(JobWorkplace.getJobWorkplaceList().get(i));
			}
		}
		
		if(jobWorkplaceList.size() != 0){
			sfcDAO.insert_job_workplace(jobWorkplaceList);
			
			for(int i = 0; i < jobWorkplaceList.size(); i++) {
				if(jobWorkplaceList.get(i).getJobWorkplaceEtc() != null) {
					jobWorkplaceList.get(i).getJobWorkplaceEtc().setFap_job_workplace_etc_ins_id(fap_comp_id);
					jobWorkplaceList.get(i).getJobWorkplaceEtc().setFap_job_workplace_etc_udt_id(fap_comp_id);
					jobWorkplaceList.get(i).getJobWorkplaceEtc().setFap_job_workplace_seq(jobWorkplaceList.get(i).getFap_job_workplace_seq());
					
					sfcDAO.insert_job_workplace_etc(jobWorkplaceList.get(i).getJobWorkplaceEtc());
				}
			}
			
		}
		
		List<SocietyFapJobWorkplaceDtl> jobWorkplaceDtlList = new ArrayList<>();
		
		for(SocietyFapJobWorkplace workplace : jobWorkplaceList) {
			if(workplace.getJobWorkplaceDtl() != null) {
				for(SocietyFapJobWorkplaceDtl dtl : workplace.getJobWorkplaceDtl().getJobWorkplaceDtlList()) {
					dtl.setFap_job_workplace_seq(workplace.getFap_job_workplace_seq());
					dtl.setFap_job_workplace_dtl_ins_id(fap_comp_id);
					dtl.setFap_job_workplace_dtl_udt_id(fap_comp_id);
					
					if(dtl.getFap_job_workplace_dtl_gb() != null) {
						jobWorkplaceDtlList.add(dtl);
					}
				}
			}
		}
		
		if(jobWorkplaceDtlList != null && jobWorkplaceDtlList.size() != 0){
			sfcDAO.insert_job_workplace_dtl(jobWorkplaceDtlList);
		}
			
		//채용 전형 (1월 14일 수정)
			
		//채용전형 리스트
		List<SocietyFapJobRecruitPcs> job_recruit_pcs_list = new ArrayList<SocietyFapJobRecruitPcs>();
		if(JobRecruitPcs.getJobRecruitPcsList() != null && JobRecruitPcs.getJobRecruitPcsList().size() != 0){
			for(SocietyFapJobRecruitPcs jrp : JobRecruitPcs.getJobRecruitPcsList()){
				
				jrp.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				jrp.setFap_job_recruit_pcs_ins_id(fap_comp_id);
				jrp.setFap_job_recruit_pcs_udt_id(fap_comp_id);
				job_recruit_pcs_list.add(jrp);
			}
			sfcDAO.insert_job_recruit_pcs(job_recruit_pcs_list);
			JobRecruitPcs.setJobRecruitPcsList(job_recruit_pcs_list);
		}
	
		//없으면 안넘어 오는것
		// 시험 파일 저장
		// fullPath = 채용공고 seq _ 채용전형 seq
		/*String fullPath = "/" + JobAd.getFap_job_ad_seq() + "_" + JobRecruitPcs.getFap_job_recruit_pcs_seq();
		if(JobRecruitPcs.getJobRecruitPcsList() != null){
			for(SocietyFapJobRecruitPcs RecruitPcs : JobRecruitPcs.getJobRecruitPcsList()){
				try{
					if(RecruitPcs.getFap_job_recruit_pcs_gb().equals("C2501") &&
							RecruitPcs.getJobExam().getJobExamFile().getFap_job_exam_file() != null){
						RecruitPcs.getJobExam().getJobExamFile().setFap_job_exam_file_origin(RecruitPcs.getJobExam().getJobExamFile().getFap_job_exam_file().getOriginalFilename());
						RecruitPcs.getJobExam().getJobExamFile().setFap_job_exam_file_saved(FileService.saveFile(RecruitPcs.getJobExam().getJobExamFile().getFap_job_exam_file(), fapJobRecruitExamFile + fullPath));
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}*/
		
		//채용전형 하위 테이블 등록 시작
		List<SocietyFapJobExam> job_exam_list = new ArrayList<SocietyFapJobExam>();
		List<SocietyFapJobItv> job_itv_list = new ArrayList<SocietyFapJobItv>();
		List<SocietyFapJobTestEtc> job_test_etc_list = new ArrayList<SocietyFapJobTestEtc>();
		if(JobRecruitPcs.getJobRecruitPcsList() != null){
			for(SocietyFapJobRecruitPcs jrp : JobRecruitPcs.getJobRecruitPcsList()){
				if(jrp != null && jrp.getFap_job_recruit_pcs_gb() != null) {
					if(jrp.getFap_job_recruit_pcs_gb().equals("C2501")){
						//1.시험 전형
						
						SocietyFapJobExam je = jrp.getJobExam();
						je.setFap_job_recruit_pcs_seq(jrp.getFap_job_recruit_pcs_seq());
						je.setFap_job_exam_ins_id(fap_comp_id);
						je.setFap_job_exam_udt_id(fap_comp_id);
						
						je = sfcDAO.insert_job_exam(je);	//시험 전형 등록 + seq 받아오기
						job_exam_list.add(je);			//리스트에 담기(자식테이블 등록정보를 위해서)
						
					}else if(jrp.getFap_job_recruit_pcs_gb().equals("C2502")){
						//2.면접 전형
						SocietyFapJobItv ji = jrp.getJobItv();
						ji.setFap_job_recruit_pcs_seq(jrp.getFap_job_recruit_pcs_seq());
						ji.setFap_job_itv_ins_id(fap_comp_id);
						ji.setFap_job_itv_udt_id(fap_comp_id);
						
						ji = sfcDAO.insert_job_itv(ji);
						job_itv_list.add(ji);
						
					}else if(jrp.getFap_job_recruit_pcs_gb().equals("C2503")){
						//3.기타 전형
						SocietyFapJobTestEtc jte = jrp.getJobTestEtc();
						jte.setFap_job_recruit_pcs_seq(jrp.getFap_job_recruit_pcs_seq());
						jte.setFap_job_test_etc_ins_id(fap_comp_id);
						jte.setFap_job_test_etc_udt_id(fap_comp_id);
						
						jte = sfcDAO.insert_job_test_etc(jte);
						job_test_etc_list.add(jte);
						
					}
				}
			}
		}
		
		for(SocietyFapJobExam je : job_exam_list){
			//logger.info("je : {}", je);
			if(je.getJobExamFile() != null){
				//1-1 시험전형 > 시험문제파일
				SocietyFapJobExamFile jef = je.getJobExamFile();
				String path = "/" + JobAd.getFap_job_ad_seq() + "_" + je.getFap_job_recruit_pcs_seq();
				String fullPath = fapJobRecruitExamFile + path;

				//1-1-1시험파일 서버 저장
				if(jef.getFap_job_exam_file() == null){
					//1. 로드폼으로 불러온 파일을 그대로 저장한 경우 
					//해당 파일을 카피후 그 saved 이름을 db에 저장하기위해 객체에 setting
					logger.info("1:{}", jef.getFile_path());
					logger.info("2:{}", fullPath);
					if(jef.getFile_path() == null){
						jef.setFile_path(path);
					}
					jef.setFap_job_exam_file_saved(FileService.fileCopy(jef.getFap_job_exam_file_origin(), jef.getFap_job_exam_file_saved(), jef.getFile_path(), fullPath));
					
				}else{
					//2. 아닌경우(일반 등록)
					try{
						
						jef.setFap_job_exam_file_origin(jef.getFap_job_exam_file().getOriginalFilename());
						jef.setFap_job_exam_file_saved(FileService.saveFile(jef.getFap_job_exam_file(), fullPath));
							
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				
				//1-1-2시험파일 db 저장
				if(jef.getFap_job_exam_file_saved() != null && !jef.getFap_job_exam_file_saved().equals("")){
					if(jef.getFap_job_exam_file_origin() != null && !jef.getFap_job_exam_file_origin().equals("")){
						jef.setFap_job_exam_seq(je.getFap_job_exam_seq());
						jef.setFap_job_exam_file_ins_id(fap_comp_id);
						jef.setFap_job_exam_file_udt_id(fap_comp_id);
						sfcDAO.insert_job_exam_file(jef);
					}
				}
				
			}
			if(je.getFap_job_exam_obj().equals("C2702") && je.getJobExamObjEtc() != null){
				//1-2 시험전형 > 시험대상자(기타) 상위 테이블에서 시험대상자를 기타로 입력했을때만 등록
				SocietyFapJobExamObjEtc jeoe = je.getJobExamObjEtc();
				jeoe.setFap_job_exam_seq(je.getFap_job_exam_seq());
				jeoe.setFap_job_exam_obj_etc_ins_id(fap_comp_id);
				jeoe.setFap_job_exam_obj_etc_udt_id(fap_comp_id);
				sfcDAO.insert_job_exam_obj_etc(jeoe);
			}
			if(je.getFap_job_exam_sv().equals("C2903") && je.getJobExamSvEtc() != null){
				//1-3 시험전형 > 시험감독관(기타) 상위 테이블에서 감독관을 기타로 입력했을때만 등록
				SocietyFapJobExamSvEtc jese = je.getJobExamSvEtc();
				jese.setFap_job_exam_seq(je.getFap_job_exam_seq());
				jese.setFap_job_exam_sv_etc_ins_id(fap_comp_id);
				jese.setFap_job_exam_sv_etc_udt_id(fap_comp_id);
				sfcDAO.insert_job_exam_sv_etc(jese);
			}
			if(je.getFap_job_exam_need().equals("C3002") && je.getJobExamNeedEtc() != null){
				//1-4 시험전형 > 시험준비물(기타) 상위 테이블에서 시험준비물을 기타로 했을때만 등록
				SocietyFapJobExamNeedEtc jene = je.getJobExamNeedEtc();
				jene.setFap_job_exam_seq(je.getFap_job_exam_seq());
				jene.setFap_job_exam_need_etc_ins_id(fap_comp_id);
				jene.setFap_job_exam_need_etc_udt_id(fap_comp_id);
				sfcDAO.insert_job_exam_need_etc(jene);
			}
			if(je.getJobExamTypeList() != null){
				//1-5 시험전형 > 시험종류
				List<SocietyFapJobExamType> job_exam_type_list = new ArrayList<SocietyFapJobExamType>();
				for(SocietyFapJobExamType jet : je.getJobExamTypeList()){
					//체크박스의 구분값이 null이거나 공백이면 저장하지 않는다.
					if(jet.getFap_job_exam_type_gb() == null || jet.getFap_job_exam_type_gb().equals("")){
						continue;
					}
					
					jet.setFap_job_exam_seq(je.getFap_job_exam_seq());
					jet.setFap_job_exam_type_ins_id(fap_comp_id);
					jet.setFap_job_exam_type_udt_id(fap_comp_id);
					job_exam_type_list.add(jet);
				
				}
				if(!job_exam_type_list.isEmpty()){
					sfcDAO.insert_job_exam_type(job_exam_type_list);
				}
				
			}
		}
		
		for(SocietyFapJobItv ji : job_itv_list){
			if(ji.getFap_job_itv_tp().equals("C3503") && ji.getJobItvTpEtc() != null){
				//2-1 면접전형 > 면접방식(기타) 상위테이블에서 면접방식을 기타로 입력 했을때만 등록
				SocietyFapJobItvTpEtc jite = ji.getJobItvTpEtc();
				jite.setFap_job_itv_seq(ji.getFap_job_itv_seq());
				jite.setFap_job_itv_tp_etc_ins_id(fap_comp_id);
				jite.setFap_job_itv_tp_etc_udt_id(fap_comp_id);
				sfcDAO.insert_job_itv_tp_etc(jite);
			
			}
			if(ji.getFap_job_itv_obj().equals("C3403") && ji.getJobItvObjEtc() != null){
				//2-2 면접전형 > 면접대상자(기타) 상위테이블에서 대상자를 기타로 입력 했을때만 등록
				SocietyFapJobItvObjEtc jioe = ji.getJobItvObjEtc();
				jioe.setFap_job_itv_seq(ji.getFap_job_itv_seq());
				jioe.setFap_job_itv_obj_etc_ins_id(fap_comp_id);
				jioe.setFap_job_itv_obj_etc_udt_id(fap_comp_id);
				sfcDAO.insert_job_itv_obj_etc(jioe);
			}
		}
		
		//3-1 기타전형 > 기타전형대상자(기타)
		for(SocietyFapJobTestEtc jte : job_test_etc_list){
			if(jte.getFap_job_test_etc_obj().equals("C3603") && jte.getJobTestEtcObj() != null){
				//상위테이블에서 대상자를 기타로 입력 했을때만 등록
				SocietyFapJobTestEtcObj jteo = jte.getJobTestEtcObj();
				jteo.setFap_job_test_etc_seq(jte.getFap_job_test_etc_seq());
				jteo.setFap_job_test_etc_obj_ins_id(fap_comp_id);
				jteo.setFap_job_test_etc_obj_udt_id(fap_comp_id);
				sfcDAO.insert_job_test_etc_obj(jteo);
			}
		}

		//급여등록 시작 (원병호)
		List<SocietyFapJobPay> job_pay_list = new ArrayList<SocietyFapJobPay>();	//등록할 객체를 모아두는 리스트
		//비어있는 객체 판별하는 반복문
		for(SocietyFapJobPay job_pay : JobPay.getJobPayList()){
			/*기타수당중 금액과 설명부분이 없는건 등록하지 않는다.*/
			job_pay.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
			job_pay.setFap_job_pay_ins_id(fap_comp_id);
			job_pay.setFap_job_pay_udt_id(fap_comp_id);
			job_pay_list.add(job_pay);
		}//비어있는 객체 판별하는 반복문 종료
		
		job_pay_list = sfcDAO.insert_job_pay(job_pay_list);	//급여 등록
		JobPay.setJobPayList(job_pay_list);
		
		//급여중 구분이 기본값이 값은 기본값 하위 테이블 저장해야된다.
		for(SocietyFapJobPay jp : JobPay.getJobPayList()){
			if(jp.getFap_job_pay_gb().equals("C2200")){	//공통코드가 기본급일 경우
				
				List<SocietyFapJobPayBase> job_pay_base_list = new ArrayList<SocietyFapJobPayBase>();
				//하위 테이블 객체 등록작업 실시
				for(SocietyFapJobPayBase jpb : jp.getJobPayBase().getJobPayBaseList()){
					
					//필요한 파라미터 세팅
					jpb.setFap_job_pay_seq(jp.getFap_job_pay_seq());
					jpb.setFap_job_pay_base_udt_id(fap_comp_id);
					jpb.setFap_job_pay_base_ins_id(fap_comp_id);
					
					//리스트에 담아서
					job_pay_base_list.add(jpb);
				}
				//담음 리스트를 객체에 넣고
				
				//등록
				job_pay_base_list = sfcDAO.insert_job_pay_base(job_pay_base_list);
				jp.getJobPayBase().setJobPayBaseList(job_pay_base_list);
				
				for(SocietyFapJobPayBase jpb : job_pay_base_list){
					
					if(jpb.getFap_job_pay_base_gb().equals("C2302")){
						//기본급중 서비스 잔업 수당
						SocietyFapJobServiceWork jsw = jpb.getJobServiceWork();
						jsw.setFap_job_pay_base_seq(jpb.getFap_job_pay_base_seq());
						jsw.setFap_job_service_work_udt_id(fap_comp_id);
						jsw.setFap_job_service_work_ins_id(fap_comp_id);
						sfcDAO.insert_job_service_work(jsw);
					}else if(jpb.getFap_job_pay_base_gb().equals("C2303")){
						//기본급중 기타 수당
						List<SocietyFapJobPayEtc> job_pay_etc_list = new ArrayList<SocietyFapJobPayEtc>();
						
						/*기본급중 기타수당 객체가 항상 공통코드만 있는채로 넘어온다. 빈 객체 걸러주는 코드*/
						if(jpb.getJobPayEtc() == null || jpb.getJobPayEtc().getJobPayEtcList() == null){
							continue;
						}
						
						for(SocietyFapJobPayEtc jpe : jpb.getJobPayEtc().getJobPayEtcList()){
							jpe.setFap_job_pay_base_seq(jpb.getFap_job_pay_base_seq());
							jpe.setFap_job_pay_etc_udt_id(fap_comp_id);
							jpe.setFap_job_pay_etc_ins_id(fap_comp_id);
							job_pay_etc_list.add(jpe);
						}
						sfcDAO.insert_job_pay_etc(job_pay_etc_list);
					}
				}//for
			
			}else if(jp.getFap_job_pay_gb().equals("C2202")){
				
				//logger.info("!!!!!!!!!!!!!!!!부모시퀀스{}", jp.getFap_job_pay_seq());
				
				jp.getJobPayExtra().setFap_job_pay_seq(jp.getFap_job_pay_seq());
				jp.getJobPayExtra().setFap_job_pay_extra_ins_id(fap_comp_id);
				jp.getJobPayExtra().setFap_job_pay_extra_udt_id(fap_comp_id);
					
				sfcDAO.insert_job_pay_extra(jp.getJobPayExtra());
				
			}
		}//for
		/*************************** 채용공고 등록 끝 *******************************/		
		
		logger.info("분리된 채용공고 등록 종료");
	}
		
	/**
	 * @Method Name : select_job_pay
	 * @Date : 2019. 1. 10.
	 * @User : 원병호
	 * @Param : fap_job_ad_seq
	 * @Return : 급여 관련 모든 정보를 담은 map
	 * @Method 설명 : 급여 관련 모든 정보를 가져옵니다.
	 */
	public HashMap<String, Object> select_job_pay(long fap_jop_ad_seq){
		return sfcDAO.select_job_pay(fap_jop_ad_seq);
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
		logger.debug("FAP 채용공고 기본 정보 리스트 출력 Service 시작");
		ArrayList<SocietyFapJobAd> jobAdList = sfcDAO.select_job_ad_list(fap_comp_id);
		logger.debug("FAP 채용공고 기본 정보 리스트 출력 Service 종료");
		return jobAdList;
	}
	
	/**
	 * @Method Name : select_job_ad_by_state
	 * @Date : 2019. 1. 24.
	 * @User : 원병호
	 * @Param : hashmap (fap_comp_id, jobfair_seq, jobfair_divide_seq)
	 * @Return : 
	 * @Method 설명 : 분류된 채용공고 리스트 가져오는 함수(fap_job_ad_state에 의한)
	 */
	public ArrayList<HashMap<String, Object>> select_job_ad_by_state(HashMap<String, Object> parmas){
		logger.debug("FAP 분류된 채용공고 리스트 출력 Service 시작");
		ArrayList<HashMap<String, Object>> result = sfcDAO.select_job_ad_by_state(parmas);
		logger.debug("FAP 분류된 채용공고 리스트 출력 Service 시작");
		return result;
	}
	

	//채용공고 이전 끝
	
	/**
	 * @Method Name : algorithm_calendar_setting_insert
	 * @Date : 2019. 1. 10.
	 * @User : 이종호
	 * @Param : 현지잡페어 설정 정보
	 * @Return : -
	 * @Method 설명 : 현지잡페어 설정 정보 등록
	 */
	@Transactional
	public void algorithm_calendar_setting_insert(SocietyFapLaJobSet jobSet,SocietyFapLaJobPlan jobPlan) {
		logger.info("FAP 현지잡페어 설정 정보 등록 DAO 시작");
		
		sfcDAO.algorithm_calendar_setting_insert(jobSet,jobPlan);
		
		logger.info("FAP 현지잡페어 설정 정보 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : select_job_ideal_person
	 * @Date : 2019. 1. 11.
	 * @User : 김준영
	 * @Param : 채용공고 정보 seq
	 * @Return : 채용공고 정보, 주요 업무 정보, 업무에 필요한 능력, 우대사항 
	 * @Method 설명 : 채용공고 정보, 주요 업무, 인재상, 기술상세를 가져오는 함수
	 */
	public HashMap<String, Object> select_job_ideal_person(long fap_job_ad_seq){
		logger.info("FAP 채용공고 정보, 주요 업무 정보, 업무에 필요한 능력, 우대사항 가져오기 서비스 시작");
		HashMap<String, Object> job_ideal_person = sfcDAO.select_job_ideal_person(fap_job_ad_seq);
		logger.info("FAP 채용공고 정보, 주요 업무 정보, 업무에 필요한 능력, 우대사항 가져오기 서비스 종료");
		return job_ideal_person;
	}
	
	/**
	 * @Method Name : algorithm_calendar_setting_update
	 * @Date : 2019. 1. 10.
	 * @User : 이종호
	 * @Param : 현지잡페어 설정 정보
	 * @Return : -
	 * @Method 설명 : 현지잡페어 설정 정보 수정
	 */
	@Transactional
	public void algorithm_calendar_setting_update(SocietyFapLaJobSet jobSet,SocietyFapLaJobPlan jobPlan) {
		logger.info("FAP 현지잡페어 설정 정보 수정 DAO 시작");
		
		sfcDAO.algorithm_calendar_setting_update(jobSet,jobPlan);
		
		logger.info("FAP 현지잡페어 설정 정보 수정 DAO 종료");
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
		logger.debug("채용공고당 알고리즘 시간설정 조회 서비스 시작");
		HashMap<String, Object> result = sfcDAO.algorithm_company_setting_search(fap_job_ad_seq);
		logger.debug("채용공고당 알고리즘 시간설정 조회 서비스 종료");
		
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
		logger.info("FAP 채용공고 정보 가져오기 서비스 시작");
		SocietyFapJobAd jobAd = sfcDAO.select_job_ad(fap_job_ad_seq);
		logger.info("FAP 채용공고 정보 가져오기 서비스 종료");
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
		logger.info("FAP 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일 정보 가져오기 서비스 시작");
		ArrayList<HashMap<String, Object>> job_recruit_pcs = sfcDAO.select_job_recruit_pcs(fap_job_ad_seq);
		logger.info("FAP 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일 정보 가져오기 서비스 종료");
		return job_recruit_pcs;
	}
	
	/**
	 * @Method Name : select_job_category
	 * @Date : 2019. 1. 14.
	 * @User : 이재준
	 * @Param : fap_job_ad_seq
	 * @Return : 모집직종 관련 모든 정보를 담은 map
	 * @Method 설명 : 모집직종 관련 모든 정보를 가져옵니다.
	 */
	public HashMap<String, Object> select_job_category(long fap_jop_ad_seq){
		return sfcDAO.select_job_category(fap_jop_ad_seq);
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
		logger.info("FAP 회사 잡페어 정보 리스트 검색 Service 시작");
		
		ArrayList<HashMap<String, Object>>company_jobfair_list = sfcDAO.search_company_jobfair_list(fap_comp_id);
		
		logger.info("FAP 회사 잡페어 정보 리스트 검색 Service 종료");
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
		logger.info("FAP 회사 세부잡페어 정보 리스트 검색 Service 시작");
		
		ArrayList<HashMap<String, Object>>company_jobfair_divide_list = sfcDAO.search_company_jobfair_divide_list(recruit_pcs_sch);
		
		logger.info("FAP 회사 세부잡페어 정보 리스트 검색 Service 종료");
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
	public ArrayList<HashMap<String, Object>> select_company_recruit_pcs_sch(SocietyFapJobRecruitPcsSch recruit_pcs_sch, HttpSession session){
		logger.info("채용기업 전형일정 스케줄 검색 Service 시작");
		
		String localeString  = (String)session.getAttribute("localeString");		
		ArrayList<HashMap<String, Object>> recruit_pcs_sch_list = sfcDAO.select_company_recruit_pcs_sch(recruit_pcs_sch);
		ArrayList<HashMap<String, Object>> schedule_list = new ArrayList<>();	
		
		for(int i=0; i<recruit_pcs_sch_list.size(); i++){			
			HashMap<String, Object> schedule_map = new HashMap<>();
			String schedule_title =  ""; String schedule_color = "";
			
			//schedule_title 설정(title = 회사영문명 + 전형구분)
			schedule_title += (String)recruit_pcs_sch_list.get(i).get("fap_comp_en_nm") + "  ";
			String recruit_pcs_gb = (String)recruit_pcs_sch_list.get(i).get("fap_job_recruit_pcs_gb");	
			
			if(localeString == null || localeString.equals("ja")){
				if(recruit_pcs_gb.equals("C2500")){
					schedule_title += "書類選考";
				}else if(recruit_pcs_gb.equals("C2501")){
					if(recruit_pcs_sch_list.get(i).get("fap_job_exam_gb").equals("C2600")){
						schedule_title += "筆記試験";
					}else{
						schedule_title += "web試験";
					}
				}else if(recruit_pcs_gb.equals("C2502")){
					if(recruit_pcs_sch_list.get(i).get("fap_job_itv_gb").equals("C3300")){
						schedule_title += "対面の面接";
					}else{
						schedule_title += "web面接";
					}
				}else if(recruit_pcs_gb.equals("C2503")){
					schedule_title += "その他の選考";
				}else{
					schedule_title += "面接選考(日本)";
				}
			}else{
				if(recruit_pcs_gb.equals("C2500")){
					schedule_title += "서류전형";
				}else if(recruit_pcs_gb.equals("C2501")){
					if(recruit_pcs_sch_list.get(i).get("fap_job_exam_gb").equals("C2600")){
						schedule_title += "필기시험";
					}else{
						schedule_title += "WEB시험";
					}
				}else if(recruit_pcs_gb.equals("C2502")){
					if(recruit_pcs_sch_list.get(i).get("fap_job_itv_gb").equals("C3300")){
						schedule_title += "대면면접";
					}else{
						schedule_title += "화상면접";
					}
				}else if(recruit_pcs_gb.equals("C2503")){
					schedule_title += "기타전형";
				}else{
					schedule_title += "현지 면접전형";
				}
			}
			
			//schedule_color 설정
			String color = (String)recruit_pcs_sch_list.get(i).get("fap_job_recruit_pcs_sch_color");
			if(color.equals("C4600")) schedule_color = "#ed090d";
			if(color.equals("C4601")) schedule_color = "#ff6100";
			if(color.equals("C4602")) schedule_color = "#fcfc80";
			if(color.equals("C4603")) schedule_color = "#abfc80";
			if(color.equals("C4604")) schedule_color = "#8cf7f0";
			if(color.equals("C4605")) schedule_color = "#3b41ed";
			if(color.equals("C4606")) schedule_color = "#8716e2";
			if(color.equals("C4607")) schedule_color = "#fcb0b9";
			if(color.equals("C4608")) schedule_color = "#c1bfc0";
			
			long schedule_seq = (Long)recruit_pcs_sch_list.get(i).get("fap_job_recruit_pcs_seq");
			String date_start = (String)recruit_pcs_sch_list.get(i).get("fap_job_recruit_pcs_sch_st");
			String date_end = (String)recruit_pcs_sch_list.get(i).get("fap_job_recruit_pcs_sch_et");
			
			schedule_map.put("schedule_color", color);
			schedule_map.put("schedule_seq", schedule_seq);
			schedule_map.put("schedule_title", schedule_title);
			schedule_map.put("date_start", date_start);
			schedule_map.put("date_end", date_end);
			schedule_map.put("schedule_gb", recruit_pcs_gb);
			schedule_map.put("schedule_color", schedule_color);
			schedule_list.add(schedule_map);
		}
		
		logger.info("채용기업 전형일정 스케줄 검색 Service 종료");
		return schedule_list;
	}
	
	/**
	 * @return 
	 * @Method Name : job_ad_parent_update
	 * @Date : 2019.01.16
	 * @User : 김준영
	 * @Param : 
	 * @Return :
	 * @Method 설명 : 채용공고 기본 정보만 업데이트
	 */
	@Transactional
	public long job_ad_parent_update(ArrayList<Long> fap_job_recruit_pcs_seq_list, SocietyFapJobAd JobAd,
			SocietyFapJobRecruitPcs JobRecruitPcs) {
		logger.info("FAP 채용공고 기본 정보 업데이트 Service 시작");
		
		// 채용 공고 수정
		long job_ad_parent_insert_seq = sfcDAO.update_job_ad(JobAd);
		// 채용 공고에 해당하는 채용 전형 seq list를 가져옴
		ArrayList<Long> pcs_seq_list = sfcDAO.select_pcs_seq_list(JobAd.getFap_job_ad_seq());
		
		// 지워줄 시퀀스만 남겨주는 함수
		if(fap_job_recruit_pcs_seq_list != null){
			for(Long data : fap_job_recruit_pcs_seq_list){
				pcs_seq_list.remove(data);
			}
		}

		// 채용 전형 삭제
		HashMap<String, Object> delete_pcs = new HashMap<>();
		delete_pcs.put("fap_job_ad_seq", JobAd.getFap_job_ad_seq());
		for(Long data : pcs_seq_list){
			delete_pcs.put("fap_job_recruit_pcs_seq", data);
			sfcDAO.delete_job_recruit_pcs_selective(delete_pcs);
		}		

		// 시험 전형, 면접 전형, 기타 전형 정보 삭제
		for(Long seq : fap_job_recruit_pcs_seq_list){
			sfcDAO.delete_job_recurit_pcs_sub(seq);			
		}		

		// 채용 전형 수정
		if(JobRecruitPcs.getJobRecruitPcsList() != null){
			sfcDAO.update_job_recruit_pcs(JobRecruitPcs);
		}
		
		// 채용 전형 등록
		String fap_comp_id = JobAd.getFap_comp_id();
		// 채용 전형등록 위해 새로 등록된 채용 전형만 남기는 작업 
		ArrayList<SocietyFapJobRecruitPcs> tmp_list = new ArrayList<>();
		ArrayList<SocietyFapJobRecruitPcs> in_list = new ArrayList<>();
		if(JobRecruitPcs.getJobRecruitPcsList() != null && JobRecruitPcs.getJobRecruitPcsList().size() != 0){
			for(SocietyFapJobRecruitPcs jobRecruitPcs : JobRecruitPcs.getJobRecruitPcsList()){
				if(jobRecruitPcs.getFap_job_recruit_pcs_seq() != 0){
					tmp_list.add(jobRecruitPcs);
				} else if(jobRecruitPcs.getFap_job_recruit_pcs_seq() == 0){
					in_list.add(jobRecruitPcs);
				}
			}
		}

		//채용전형 리스트 등록
		List<SocietyFapJobRecruitPcs> job_recruit_pcs_list = new ArrayList<SocietyFapJobRecruitPcs>();
		if(JobRecruitPcs.getJobRecruitPcsList() != null && JobRecruitPcs.getJobRecruitPcsList().size() != 0){
			for(SocietyFapJobRecruitPcs jrp : in_list){
				jrp.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				jrp.setFap_job_recruit_pcs_ins_id(fap_comp_id);
				jrp.setFap_job_recruit_pcs_udt_id(fap_comp_id);
				job_recruit_pcs_list.add(jrp);
			}
			if(job_recruit_pcs_list != null && job_recruit_pcs_list.size() != 0){
				sfcDAO.insert_job_recruit_pcs(job_recruit_pcs_list);
			}
		}
		
		//채용전형 하위 테이블 등록 시작
		List<SocietyFapJobExam> job_exam_list = new ArrayList<SocietyFapJobExam>();
		List<SocietyFapJobItv> job_itv_list = new ArrayList<SocietyFapJobItv>();
		List<SocietyFapJobTestEtc> job_test_etc_list = new ArrayList<SocietyFapJobTestEtc>();
		if(JobRecruitPcs.getJobRecruitPcsList() != null && JobRecruitPcs.getJobRecruitPcsList().size() != 0){
			for(SocietyFapJobRecruitPcs jrp : JobRecruitPcs.getJobRecruitPcsList()){
				if(jrp != null && jrp.getFap_job_recruit_pcs_gb() != null) {
					if(jrp.getFap_job_recruit_pcs_gb().equals("C2501")){
						//1.시험 전형
						SocietyFapJobExam je = new SocietyFapJobExam(); 
						je = jrp.getJobExam();
						logger.info("je : {}", je);
						je.setFap_job_recruit_pcs_seq(jrp.getFap_job_recruit_pcs_seq());
						je.setFap_job_exam_ins_id(fap_comp_id);
						je.setFap_job_exam_udt_id(fap_comp_id);
						
						je = sfcDAO.insert_job_exam(je);	//시험 전형 등록 + seq 받아오기
						job_exam_list.add(je);			//리스트에 담기(자식테이블 등록정보를 위해서)
						
					}else if(jrp.getFap_job_recruit_pcs_gb().equals("C2502")){
						//2.면접 전형
						SocietyFapJobItv ji = jrp.getJobItv();
						ji.setFap_job_recruit_pcs_seq(jrp.getFap_job_recruit_pcs_seq());
						ji.setFap_job_itv_ins_id(fap_comp_id);
						ji.setFap_job_itv_udt_id(fap_comp_id);
						
						ji = sfcDAO.insert_job_itv(ji);
						job_itv_list.add(ji);
						
					}else if(jrp.getFap_job_recruit_pcs_gb().equals("C2503")){
						//3.기타 전형
						SocietyFapJobTestEtc jte = jrp.getJobTestEtc();
						jte.setFap_job_recruit_pcs_seq(jrp.getFap_job_recruit_pcs_seq());
						jte.setFap_job_test_etc_ins_id(fap_comp_id);
						jte.setFap_job_test_etc_udt_id(fap_comp_id);
						
						jte = sfcDAO.insert_job_test_etc(jte);
						job_test_etc_list.add(jte);
						
					}
				}
			}
		}

		for(SocietyFapJobExam je : job_exam_list){
			//logger.info("je : {}", je);
			if(je.getJobExamFile() != null){
				//1-1 시험전형 > 시험문제파일
				
				SocietyFapJobExamFile jef = je.getJobExamFile();
				
				String path = "/" + JobAd.getFap_job_ad_seq() + "_" + je.getFap_job_recruit_pcs_seq();
				String fullPath = fapJobRecruitExamFile + path;
				
				
				if(jef.getFap_job_exam_file() == null){
					//파일 수정하지 않은 경우
					logger.info("null");
				
				}else if(jef.getFap_job_exam_file().isEmpty()){
					//있던 파일 삭제후 재업로드 하지 않은 경우
					logger.info("true");
					
					FileService.deleteFile(jef.getFap_job_exam_file_saved(), fullPath);
					jef.setFap_job_exam_file_saved(null);
					jef.setFap_job_exam_file_origin(null);
					
				}else {
					//있던 파일 삭제후 다른파일 재업로드 한 경우
					logger.info("false");
					
					FileService.deleteFile(jef.getFap_job_exam_file_saved(), fullPath);
					jef.setFap_job_exam_file_saved(null);
					jef.setFap_job_exam_file_origin(null);
					
					
					//파일(서버)등록
					try{
						jef.setFap_job_exam_file_saved(FileService.saveFile(jef.getFap_job_exam_file(), fullPath));
						jef.setFap_job_exam_file_origin(jef.getFap_job_exam_file().getOriginalFilename());
							
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				
				//db등록
				if(jef.getFap_job_exam_file_saved() != null && !jef.getFap_job_exam_file_saved().equals("")){
					if(jef.getFap_job_exam_file_origin() != null && !jef.getFap_job_exam_file_origin().equals("")){
						jef.setFap_job_exam_seq(je.getFap_job_exam_seq());
						jef.setFap_job_exam_file_ins_id(fap_comp_id);
						jef.setFap_job_exam_file_udt_id(fap_comp_id);
						sfcDAO.insert_job_exam_file(jef);
					}
				}
				
				
			}
			
			
			if(je.getJobExamObjEtc() != null){
				//1-2 시험전형 > 시험대상자(기타)
				SocietyFapJobExamObjEtc jeoe = je.getJobExamObjEtc();
				jeoe.setFap_job_exam_seq(je.getFap_job_exam_seq());
				jeoe.setFap_job_exam_obj_etc_ins_id(fap_comp_id);
				jeoe.setFap_job_exam_obj_etc_udt_id(fap_comp_id);
				sfcDAO.insert_job_exam_obj_etc(jeoe);
			}
			if(je.getJobExamSvEtc() != null){
				//1-3 시험전형 > 시험감독관(기타)
				SocietyFapJobExamSvEtc jese = je.getJobExamSvEtc();
				jese.setFap_job_exam_seq(je.getFap_job_exam_seq());
				jese.setFap_job_exam_sv_etc_ins_id(fap_comp_id);
				jese.setFap_job_exam_sv_etc_udt_id(fap_comp_id);
				sfcDAO.insert_job_exam_sv_etc(jese);
			}
			if(je.getJobExamNeedEtc() != null){
				//1-4 시험전형 > 시험준비물(기타)
				SocietyFapJobExamNeedEtc jene = je.getJobExamNeedEtc();
				jene.setFap_job_exam_seq(je.getFap_job_exam_seq());
				jene.setFap_job_exam_need_etc_ins_id(fap_comp_id);
				jene.setFap_job_exam_need_etc_udt_id(fap_comp_id);
				sfcDAO.insert_job_exam_need_etc(jene);
			}
			if(je.getJobExamTypeList() != null){
				//1-5 시험전형 > 시험종류
				List<SocietyFapJobExamType> job_exam_type_list = new ArrayList<SocietyFapJobExamType>();
				for(SocietyFapJobExamType jet : je.getJobExamTypeList()){
					//체크박스의 구분값이 null이거나 공백이면 저장하지 않는다.
					if(jet.getFap_job_exam_type_gb() == null || jet.getFap_job_exam_type_gb().equals("")){
						continue;
					}
					
					jet.setFap_job_exam_seq(je.getFap_job_exam_seq());
					jet.setFap_job_exam_type_ins_id(fap_comp_id);
					jet.setFap_job_exam_type_udt_id(fap_comp_id);
					job_exam_type_list.add(jet);
				
				}
				if(!job_exam_type_list.isEmpty()){
					sfcDAO.insert_job_exam_type(job_exam_type_list);
				}
				
			}
		}

		// 시험 파일 저장
		// fullPath = 채용공고 seq _ 채용전형 seq
	/*	String fullPath = "/" + JobAd.getFap_job_ad_seq() + "_" + JobRecruitPcs.getFap_job_recruit_pcs_seq();
		if(JobRecruitPcs.getJobRecruitPcsList() != null && JobRecruitPcs.getJobRecruitPcsList().size() != 0){
			for(SocietyFapJobRecruitPcs RecruitPcs : JobRecruitPcs.getJobRecruitPcsList()){
				try{
					if(RecruitPcs.getJobExam() != null){
						if(RecruitPcs.getJobExam().getJobExamFile().getFap_job_exam_file() != null){
							fullPath = "/" + JobAd.getFap_job_ad_seq() + "_" + RecruitPcs.getFap_job_recruit_pcs_seq();
							RecruitPcs.getJobExam().getJobExamFile().setFap_job_exam_file_origin(RecruitPcs.getJobExam().getJobExamFile().getFap_job_exam_file().getOriginalFilename());
							RecruitPcs.getJobExam().getJobExamFile().setFap_job_exam_file_saved(FileService.saveFile(RecruitPcs.getJobExam().getJobExamFile().getFap_job_exam_file(), fapJobRecruitExamFile + fullPath));
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}*/
		
		for(SocietyFapJobItv ji : job_itv_list){
			if(ji.getJobItvTpEtc() != null){
				//2-1 면접전형 > 면접방식(기타)
				SocietyFapJobItvTpEtc jite = ji.getJobItvTpEtc();
				jite.setFap_job_itv_seq(ji.getFap_job_itv_seq());
				jite.setFap_job_itv_tp_etc_ins_id(fap_comp_id);
				jite.setFap_job_itv_tp_etc_udt_id(fap_comp_id);
				sfcDAO.insert_job_itv_tp_etc(jite);
			
			}
			if(ji.getJobItvObjEtc() != null){
				//2-2 면접전형 > 면접대상자(기타)
				SocietyFapJobItvObjEtc jioe = ji.getJobItvObjEtc();
				jioe.setFap_job_itv_seq(ji.getFap_job_itv_seq());
				jioe.setFap_job_itv_obj_etc_ins_id(fap_comp_id);
				jioe.setFap_job_itv_obj_etc_udt_id(fap_comp_id);
				sfcDAO.insert_job_itv_obj_etc(jioe);
			}
		}
		
		//3-1 기타전형 > 기타전형대상자(기타)
		for(SocietyFapJobTestEtc jte : job_test_etc_list){
			if(jte.getJobTestEtcObj() != null){
				SocietyFapJobTestEtcObj jteo = jte.getJobTestEtcObj();
				jteo.setFap_job_test_etc_seq(jte.getFap_job_test_etc_seq());
				jteo.setFap_job_test_etc_obj_ins_id(fap_comp_id);
				jteo.setFap_job_test_etc_obj_udt_id(fap_comp_id);
				sfcDAO.insert_job_test_etc_obj(jteo);
			}
		}		

		logger.info("FAP 채용공고 기본 정보 업데이트 Service 종료");
		return job_ad_parent_insert_seq;
	}
	
	/**
	 * @Method Name : delete_job_ad
	 * @Date : 2019.01.16
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 삭제(sub)
	 */
	public void delete_job_ad(long fap_job_ad_seq) {
		logger.debug("채용공고 삭제(sub) Service 시작");
		sfcDAO.delete_job_ad(fap_job_ad_seq);
		logger.debug("채용공고 삭제(sub) Service 종료");		
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
		logger.info("채용기업 서류전형 정보 검색 Service 시작");
		
		HashMap<String, Object> company_review_pcs_info = sfcDAO.select_company_review_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("채용기업 서류전형 정보 검색 Service 종료");
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
		logger.info("채용기업 시험전형 정보 검색 Service 시작");
		
		HashMap<String, Object> company_exam_pcs_info = sfcDAO.select_company_exam_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("채용기업 시험전형 정보 검색 Service 종료");
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
		logger.info("채용기업 면접전형 정보 검색 Service 시작");
		
		HashMap<String, Object> company_itv_pcs_info = sfcDAO.select_company_itv_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("채용기업 면접전형 정보 검색 Service 종료");
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
		logger.info("채용기업 기타전형 정보 검색 Service 시작");
		
		HashMap<String, Object> company_test_etc_pcs_info = sfcDAO.select_company_test_etc_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("채용기업 기타전형 정보 검색 Service 종료");
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
		logger.info("FAP 채용전형 수정 가능 여부 확인 서비스 시작");
		int editable_check = sfcDAO.editable_check(fap_job_recruit_pcs_seq);
		logger.info("FAP 채용전형 수정 가능 여부 확인 서비스 종료");
		return editable_check;
	}
	
	/**
	 * @Method Name : job_ad_children_insert
	 * @Date : 2019. 1. 17.
	 * @User : 이재준
	 * @Param : 채용공고 정보
	 * @Return : 
	 * @Method 설명 : 
	 */
	@Transactional
	public void job_ad_children_insert(SocietyFapJobAd JobAd, SocietyFapJobDorm JobDorm, SocietyFapJobJitEmployee JobJitEmployee,
			SocietyFapJobJaLevel JobJaLevel, SocietyFapJobTrial JobTrial, SocietyFapJobComp JobComp, SocietyFapJobFile JobFile
			, SocietyFapJobIsr JobIsr, SocietyFapJobJoinDt JobJoinDt, SocietyFapJobWork JobWork, 
			SocietyFapJobCategory JobCategory, SocietyFapJobPref JobPref, SocietyFapJobWorkplace JobWorkplace,
			SocietyFapJobPay JobPay) {
			logger.info("채용공고 chidren 수정 Service 시작");
			
			String file_path = "";
			List<SocietyFapJobFile> job_file_list = new ArrayList<SocietyFapJobFile>();	//파일 저장후 db저장값을 담기위한 중간 객체
			
			/*파일 수정 */
			for(SocietyFapJobFile job_file : JobFile.getJobFileList()){
				
				if(job_file.getJob_ad_file() == null){
					//기업소개 파일을 수정 안한경우 jump (input file 자체조차 없는경우)
					//logger.info("jump {}", job_file);
					job_file_list.add(job_file);
					
				}else if(job_file.getJob_ad_file().isEmpty()){
					//있던 파일을 삭제한 경우(빈 input file이 있는 경우) 삭제만 한다
					//logger.info("empty");
					
					/*file path 설정*/
					if(job_file.getFap_job_file_gb().equals("C0700")){
						//video
						file_path = fapJobAdMovieFile;
					}else if(job_file.getFap_job_file_gb().equals("C0701")){
						//pdf
						file_path = fapJobAdPdfFile;
					}else if(job_file.getFap_job_file_gb().equals("C0702")){
						//photo
						file_path = fapJobAdPhotoFile;
					}
					
					FileService.deleteFile(job_file.getFap_job_file_saved(), file_path);
					
					//이전파일 정보를 지운다.
					job_file.setFap_job_file_saved(null);
					job_file.setFap_job_file_origin(null);
					
					job_file_list.add(job_file);
					
				}else{
					//있던파일 삭제후 새로 등록 (들어있는 input file) 삭제후 등록)
					//logger.info("not empty");
					/*file path 설정*/
					if(job_file.getFap_job_file_gb().equals("C0700")){
						//video
						file_path = fapJobAdMovieFile;
					}else if(job_file.getFap_job_file_gb().equals("C0701")){
						//pdf
						file_path = fapJobAdPdfFile;
					}else if(job_file.getFap_job_file_gb().equals("C0702")){
						//photo
						file_path = fapJobAdPhotoFile;
					}
					FileService.deleteFile(job_file.getFap_job_file_saved(), file_path);
					
					job_file.setFap_job_file_saved(null);
					job_file.setFap_job_file_origin(null);
					
					if(job_file.getFap_job_file_gb().equals("C0700")){
						//video
						file_path = fapJobAdMovieFile;
						UploadJobAdMovieServer(job_file);
					}else if(job_file.getFap_job_file_gb().equals("C0701")){
						//pdf
						file_path = fapJobAdPdfFile;
						UploadJobAdPdfServer(job_file);
					}else if(job_file.getFap_job_file_gb().equals("C0702")){
						//photo
						file_path = fapJobAdPhotoFile;
						UploadJobAdPhotoServer(job_file);
					}
					logger.info("객체 : {}", job_file);
					job_file_list.add(job_file);
				}
				
			}
			JobFile.setJobFileList(job_file_list);
			/*파일 수정 끝*/
				
	
		String fap_comp_id = JobAd.getFap_comp_id();
		
		//기숙사 (C0800:기숙사 제도있음)
		if(JobAd.getFap_job_ad_isdorm() != null && JobAd.getFap_job_ad_isdorm().equals("C0800")){
		JobDorm.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
		sfcDAO.insert_job_dorm(JobDorm);
		}
		
		//계약사원 (C0401:모집형태 계약사원)
		if(JobAd.getFap_job_ad_hire_type() != null && JobAd.getFap_job_ad_hire_type().equals("C0401")){
		JobJitEmployee.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
		sfcDAO.insert_job_jit_employee(JobJitEmployee);
		}
		
		//업무에 필요한 일본어 능력 03.13 수정(원병호)
		if( !JobJaLevel.getFap_job_ja_level_dtl().equals("") || JobJaLevel.getFap_job_ja_level_gb() != null){
		JobJaLevel.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
		sfcDAO.insert_job_ja_level(JobJaLevel);
		}
		
		//시용기간 (C0500:시용기간 있음)
		if(JobAd.getFap_job_ad_intern() != null && JobAd.getFap_job_ad_intern().equals("C0500")){
		JobTrial.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());	
		sfcDAO.insert_job_trial(JobTrial);
		}
		
		if(JobComp.getJobCompList().size() !=0){
			for (int i = 0; i < JobComp.getJobCompList().size(); i++) {
				JobComp.getJobCompList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobComp.getJobCompList().get(i).setFap_job_comp_ins_id(fap_comp_id);
				JobComp.getJobCompList().get(i).setFap_job_comp_udt_id(fap_comp_id);
			}
			sfcDAO.insert_job_comp(JobComp);
		}
		//기업소개 파일 등록
		if(JobFile.getJobFileList().size() !=0){
			for (int i = 0; i < JobFile.getJobFileList().size(); i++) {
				JobFile.getJobFileList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobFile.getJobFileList().get(i).setFap_job_file_ins_id(fap_comp_id);
				JobFile.getJobFileList().get(i).setFap_job_file_udt_id(fap_comp_id);
			}
			sfcDAO.insert_job_file(JobFile);
		}
		if(JobIsr.getJobIsrList() != null){
			if(JobIsr.getJobIsrList().size() !=0){
				for (int i = 0; i < JobIsr.getJobIsrList().size(); i++) {
					JobIsr.getJobIsrList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
					JobIsr.getJobIsrList().get(i).setFap_job_isr_ins_id(fap_comp_id);
					JobIsr.getJobIsrList().get(i).setFap_job_isr_udt_id(fap_comp_id);
				}
				sfcDAO.insert_job_isr(JobIsr);
			}
		}
		if(JobJoinDt.getJobJoinDtList().size() !=0){
			for (int i = 0; i < JobJoinDt.getJobJoinDtList().size(); i++) {
				JobJoinDt.getJobJoinDtList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobJoinDt.getJobJoinDtList().get(i).setFap_job_join_dt_ins_id(fap_comp_id);
				JobJoinDt.getJobJoinDtList().get(i).setFap_job_join_dt_udt_id(fap_comp_id);
			}
			sfcDAO.insert_job_join_dt(JobJoinDt);
		}
		if(JobWork.getJobWorkList().size() !=0){
			for (int i = 0; i < JobWork.getJobWorkList().size(); i++) {
				JobWork.getJobWorkList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobWork.getJobWorkList().get(i).setFap_job_work_ins_id(fap_comp_id);
				JobWork.getJobWorkList().get(i).setFap_job_work_udt_id(fap_comp_id);
			}
			sfcDAO.insert_job_work(JobWork);
		}
		
		//모집직종
		ArrayList<SocietyFapJobCategory> list = new ArrayList<>();		
		if(JobCategory != null && JobCategory.getJobCategoryList().size() !=0){
			for (int i = 0; i < JobCategory.getJobCategoryList().size(); i++) {
				JobCategory.getJobCategoryList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobCategory.getJobCategoryList().get(i).setFap_job_category_ins_id(fap_comp_id);
				JobCategory.getJobCategoryList().get(i).setFap_job_category_udt_id(fap_comp_id);
			
				if(JobCategory.getJobCategoryList().get(i).getFap_job_category_gb() != null) {
					list.add(JobCategory.getJobCategoryList().get(i));
				}
			}

			if(list != null && list.size() != 0){
				sfcDAO.insert_job_category(list);
			}
			//그 외 모집직종
			for (int i = 0; i < list.size(); i++) {
				if(list.get(i).getJobCategoryEtc() != null) {
					list.get(i).getJobCategoryEtc().setFap_job_category_etc_ins_id(fap_comp_id);
					list.get(i).getJobCategoryEtc().setFap_job_category_etc_udt_id(fap_comp_id);
					list.get(i).getJobCategoryEtc().setFap_job_category_seq(list.get(i).getFap_job_category_seq());
					sfcDAO.insert_job_category_etc(list.get(i).getJobCategoryEtc());
				}
			}
			
		}
		if(JobPref.getJobPrefList().size() !=0){
			for (int i = 0; i < JobPref.getJobPrefList().size(); i++) {
				JobPref.getJobPrefList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobPref.getJobPrefList().get(i).setFap_job_pref_ins_id(fap_comp_id);
				JobPref.getJobPrefList().get(i).setFap_job_pref_udt_id(fap_comp_id);
			}
			sfcDAO.insert_job_pref(JobPref);
		}
		
		
		List<SocietyFapJobWorkplace> jobWorkplaceList = new ArrayList<>();
		
		for (int i = 0; i < JobWorkplace.getJobWorkplaceList().size(); i++) {
			JobWorkplace.getJobWorkplaceList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
			JobWorkplace.getJobWorkplaceList().get(i).setFap_job_workplace_ins_id(fap_comp_id);
			JobWorkplace.getJobWorkplaceList().get(i).setFap_job_workplace_udt_id(fap_comp_id);
			
			if(JobWorkplace.getJobWorkplaceList().get(i).getFap_job_workplace_gb() != null){
				jobWorkplaceList.add(JobWorkplace.getJobWorkplaceList().get(i));
			}
		}
		
		if(jobWorkplaceList.size() != 0){
			sfcDAO.insert_job_workplace(jobWorkplaceList);
			
			for(int i = 0; i < jobWorkplaceList.size(); i++) {
				if(jobWorkplaceList.get(i).getJobWorkplaceEtc() != null) {
					jobWorkplaceList.get(i).getJobWorkplaceEtc().setFap_job_workplace_etc_ins_id(fap_comp_id);
					jobWorkplaceList.get(i).getJobWorkplaceEtc().setFap_job_workplace_etc_udt_id(fap_comp_id);
					jobWorkplaceList.get(i).getJobWorkplaceEtc().setFap_job_workplace_seq(jobWorkplaceList.get(i).getFap_job_workplace_seq());
					
					sfcDAO.insert_job_workplace_etc(jobWorkplaceList.get(i).getJobWorkplaceEtc());
				}
			}
			
		}
		
		List<SocietyFapJobWorkplaceDtl> jobWorkplaceDtlList = new ArrayList<>();
		
		for(SocietyFapJobWorkplace workplace : jobWorkplaceList) {
			if(workplace.getJobWorkplaceDtl() != null) {
				for(SocietyFapJobWorkplaceDtl dtl : workplace.getJobWorkplaceDtl().getJobWorkplaceDtlList()) {
					dtl.setFap_job_workplace_seq(workplace.getFap_job_workplace_seq());
					dtl.setFap_job_workplace_dtl_ins_id(fap_comp_id);
					dtl.setFap_job_workplace_dtl_udt_id(fap_comp_id);
					
					if(dtl.getFap_job_workplace_dtl_gb() != null) {
						jobWorkplaceDtlList.add(dtl);
					}
				}
			}
		}
		
		if(jobWorkplaceDtlList != null && jobWorkplaceDtlList.size() != 0){
			sfcDAO.insert_job_workplace_dtl(jobWorkplaceDtlList);
		}
		
		//급여등록 시작 (원병호)
		List<SocietyFapJobPay> job_pay_list = new ArrayList<SocietyFapJobPay>();	//등록할 객체를 모아두는 리스트
		
		//비어있는 객체 판별하는 반복문
		for(SocietyFapJobPay job_pay : JobPay.getJobPayList()){
			/*기타수당중 금액과 설명부분이 없는건 등록하지 않는다.*/
			if(job_pay.getFap_job_pay_gb().equals("C2201")){
				if(job_pay.getFap_job_pay_info() == 0 && 
						(job_pay.getFap_job_pay_dtl() == null || job_pay.getFap_job_pay_dtl().equals("")) ){
					continue;
				}
			}
			job_pay.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
			job_pay.setFap_job_pay_ins_id(fap_comp_id);
			job_pay.setFap_job_pay_udt_id(fap_comp_id);
			job_pay_list.add(job_pay);
		}//비어있는 객체 판별하는 반복문 종료
		
		job_pay_list = sfcDAO.insert_job_pay(job_pay_list);	//급여 등록
		JobPay.setJobPayList(job_pay_list);
		
		//급여중 구분이 기본값이 값은 기본값 하위 테이블 저장해야된다.
		for(SocietyFapJobPay jp : JobPay.getJobPayList()){
			if(jp.getFap_job_pay_gb().equals("C2200")){	//공통코드가 기본급일 경우
				
				List<SocietyFapJobPayBase> job_pay_base_list = new ArrayList<SocietyFapJobPayBase>();
				//하위 테이블 객체 등록작업 실시
				for(SocietyFapJobPayBase jpb : jp.getJobPayBase().getJobPayBaseList()){
					
					//필요한 파라미터 세팅
					jpb.setFap_job_pay_seq(jp.getFap_job_pay_seq());
					jpb.setFap_job_pay_base_udt_id(fap_comp_id);
					jpb.setFap_job_pay_base_ins_id(fap_comp_id);
					
					//리스트에 담아서
					job_pay_base_list.add(jpb);
				}
				//담음 리스트를 객체에 넣고
				
				//등록
				job_pay_base_list = sfcDAO.insert_job_pay_base(job_pay_base_list);
				jp.getJobPayBase().setJobPayBaseList(job_pay_base_list);
				
				for(SocietyFapJobPayBase jpb : job_pay_base_list){
					
					if(jpb.getFap_job_pay_base_gb().equals("C2302")){
						//기본급중 서비스 잔업 수당
						SocietyFapJobServiceWork jsw = jpb.getJobServiceWork();
						jsw.setFap_job_pay_base_seq(jpb.getFap_job_pay_base_seq());
						jsw.setFap_job_service_work_udt_id(fap_comp_id);
						jsw.setFap_job_service_work_ins_id(fap_comp_id);
						sfcDAO.insert_job_service_work(jsw);
					}else if(jpb.getFap_job_pay_base_gb().equals("C2303")){
						//기본급중 기타 수당
						List<SocietyFapJobPayEtc> job_pay_etc_list = new ArrayList<SocietyFapJobPayEtc>();
						if(jpb.getJobPayEtc() != null){
							for(SocietyFapJobPayEtc jpe : jpb.getJobPayEtc().getJobPayEtcList()){
								jpe.setFap_job_pay_base_seq(jpb.getFap_job_pay_base_seq());
								jpe.setFap_job_pay_etc_udt_id(fap_comp_id);
								jpe.setFap_job_pay_etc_ins_id(fap_comp_id);
								job_pay_etc_list.add(jpe);
							}			
							sfcDAO.insert_job_pay_etc(job_pay_etc_list);
						}
					}
				}//for
			
			}else if(jp.getFap_job_pay_gb().equals("C2202")){
				
				//logger.info("!!!!!!!!!!!!!!!!부모시퀀스{}", jp.getFap_job_pay_seq());
				jp.getJobPayExtra().setFap_job_pay_seq(jp.getFap_job_pay_seq());
				jp.getJobPayExtra().setFap_job_pay_extra_ins_id(fap_comp_id);
				jp.getJobPayExtra().setFap_job_pay_extra_udt_id(fap_comp_id);
					
				sfcDAO.insert_job_pay_extra(jp.getJobPayExtra());
				
			}
		}//for
		//급여등록 끝 (원병호)
		
		logger.info("채용공고 chidren 수정 Service 시작");
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
		logger.info("FAP 회원 약관 동의 변경 서비스 시작");
		int check = sfcDAO.terms_update(user);
		logger.info("FAP 회원 약관 동의 변경 서비스 종료");
		return check;
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
		logger.info("FAP 채용공고 상태를 수정하는 서비스 시작");
		int result = sfcDAO.update_job_ad_state(jobAd);
		logger.info("FAP 채용공고 상태를 수정하는 서비스 끝");
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
	public int insert_connect_request(Authentication auth, SocietyFapCompUserConnectRequest CompUserConnectRequest){
		logger.info("FAP 기업 - 담당자 연결 요청 서비스 시작");
		CompUserConnectRequest.setUser_id((String)auth.getPrincipal());
		CompUserConnectRequest.setFap_comp_user_request_ck("B3801");
		int result = sfcDAO.insert_connect_request(CompUserConnectRequest);
		logger.info("FAP 기업 - 담당자 연결 요청 서비스 종료");
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
		logger.info("FAP 기업 - 담당자 연결 요청 가져오기 서비스 시작");
		ArrayList<SocietyFapCompUserConnectRequest> CompUserConnectRequest = sfcDAO.select_comp_user_connect_request(user_id);
		logger.info("FAP 기업 - 담당자 연결 요청 가져오기 서비스 종료");
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
		logger.info("FAP 기업 - 담당자 연결 요청 삭제 서비스 시작");
		int result = sfcDAO.delete_connect_request(fap_comp_user_request_seq);
		logger.info("FAP 기업 - 담당자 연결 요청 삭제 서비스 종료");
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
		logger.info("FAP 기업 - 비용결제 검색 서비스 시작");
		ArrayList<HashMap<String, Object>> result = sfcDAO.company_pay_for_cost(params);
		logger.info("FAP 기업 - 비용결제 검색 서비스 종료");
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
		ArrayList<HashMap<String, Object>> select_job_ad_load_list = sfcDAO.select_job_ad_load_list_paging(paramMap, start, countPerPage);
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
		int adTotalCount = sfcDAO.select_job_ad_load_list_count(paramMap);
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
	@Transactional
	public int delete_job_ad_box(long fap_job_ad_seq){
		logger.info("FAP 채용공고 삭제 서비스 시작");
		
		//서버에 저장된 파일 삭제	
		ArrayList<SocietyFapJobFile> file_list = sfcDAO.select_job_file(fap_job_ad_seq);
		
		//기업소개 파일 삭제
		for(SocietyFapJobFile job_file : file_list){
			/*file path 설정*/
			String file_path  = "";
			if(job_file.getFap_job_file_gb().equals("C0700")){
				//video
				file_path = fapJobAdMovieFile;
			}else if(job_file.getFap_job_file_gb().equals("C0701")){
				//pdf
				file_path = fapJobAdPdfFile;
			}else if(job_file.getFap_job_file_gb().equals("C0702")){
				//photo
				file_path = fapJobAdPhotoFile;
			}
			
			FileService.deleteFile(job_file.getFap_job_file_saved(), file_path);
			
		}
		
		//시험파일 삭제
		ArrayList<SocietyFapJobExamFile> exam_file_list = sfcDAO.select_job_exam_file(fap_job_ad_seq);
		
		for(SocietyFapJobExamFile exam_file : exam_file_list){
			/*file path에 recruit_pcs_seq가 필요하므로, 편의상 exam_seq에 담아옴*/
			// path : / + fap_job_ad_seq + _ + fap_job_recruit_pcs_seq
			String path = "/" + fap_job_ad_seq + "_" + exam_file.getFap_job_exam_seq();
			String fullPath = fapJobRecruitExamFile + path;
			FileService.deleteFile(exam_file.getFap_job_exam_file_saved(), fullPath);
		}
		
		
		//시험전형 파일 삭제
		
		int result = sfcDAO.delete_job_ad_box(fap_job_ad_seq);
		logger.info("FAP 채용공고 삭제 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : find_job_file_path
	 * @Date : 2019. 2. 12.
	 * @User : 원병호
	 * @Param : fap_job_file_gb
	 * @Return : file path
	 * @Method 설명 : job_ad_file의 path를 반환
	 */
	public String find_job_file_path(String fap_job_file_gb){
		String result = "";
		if(fap_job_file_gb.equals("C0700")){
			//기업소개 영상
			result = fapJobAdMovieFile;
		}else if(fap_job_file_gb.equals("C0701")){
			//기업소개 자료(PDF)
			result = fapJobAdPdfFile;
		}else if(fap_job_file_gb.equals("C0702")){
			//기업소개 사진
			result = fapJobAdPhotoFile;
		}
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
		ArrayList<SocietyFapJobFile> result = new ArrayList<SocietyFapJobFile>();
		
		//해당하는 gb(동영상, pdf, 사진)의 path 세팅
		for(SocietyFapJobFile job_file : sfcDAO.select_job_file(fap_job_ad_seq)){
			job_file.setFile_path(find_job_file_path(job_file.getFap_job_file_gb()));
			result.add(job_file);
		}
		return result;
	}
		
	/**
	 * @Method Name : find_job_exam_path
	 * @Date : 2019. 2. 15.
	 * @User : 원병호
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 시험 파일 저장 경로 리턴
	 */
	public String get_job_exam_path(){
		return fapJobRecruitExamFile;
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
		logger.info("FAP 공지사항 가져오기 서비스 시작");
		ArrayList<BoardContent> notice_list = sfcDAO.company_board_contents_search(map);
		logger.info("FAP 공지사항 가져오기 서비스 종료");
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
		logger.info("FAP 공지사항 게시글 갯수 가져오기 서비스 시작");
		int count = sfcDAO.board_contents_count(map);
		logger.info("FAP 공지사항 게시글 갯수 가져오기 서비스 시작");
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
		
		ArrayList<BoardContent> notice_list = sfcDAO.company_board_contents_list_search(map);
		
		return notice_list;
	}
	
	/**
	 * @Method Name : search_applicant_info
	 * @Date : 2019. 2. 15.
	 * @User : 신동철
	 * @Param : 채용공고 seq, 회사 아이디
	 * @Return : 채용전형 진행중, 합격, 추가합격 정규 지원자 정보
	 * @Method 설명 : 채용전형 진행중, 합격, 추가합격 정규 지원자 정보 불러오는 함수
	 */
	public ArrayList<HashMap<String, Object>> search_applicant_info(HashMap<String, Object> hashmap){
		logger.info("FAP 채용전형 진행중, 합격, 추가합격 정규 지원자 정보 불러오기 Service 시작");
		ArrayList<HashMap<String, Object>> resultMap = sfcDAO.search_applicant_info(hashmap);
		logger.info("FAP 채용전형 진행중, 합격, 추가합격 정규 지원자 정보 불러오기 Service 종료");
		return resultMap;
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
		logger.info("FAP 채용공고 지원자관리 채용전형 정보 검색 Service 시작");
		ArrayList<SocietyFapJobRecruitPcs> recruit_pcs = sfcDAO.select_job_ad_recruit_pcs(fap_job_ad_seq);
		logger.info("FAP 채용공고 지원자관리 채용전형 정보 검색 Service 종료");
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
		HashMap<String, Object> wholeResume = sfcDAO.selectResumeApply(fap_resume_seq);
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
		logger.info("FAP 채용전형 불합격 지원자 정보 불러오기 Service 시작");
		ArrayList<HashMap<String, Object>> resultMap = sfcDAO.search_unaccepted_applicant_info(hashmap);
		logger.info("FAP 채용전형 불합격 지원자 정보 불러오기 Service 종료");
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
		logger.info("FAP 게시판 세부내용 가져오기 서비스 시작");
		HashMap<String, Object> board_content = sfcDAO.board_contents_detail(board_content_seq);
		logger.info("FAP 게시판 세부내용 가져오기 서비스 시작");
		return board_content;
	}
	
	/**
	 * @Method Name : update_fap_job_apply_result
	 * @Date : 2019. 2. 19.
	 * @User : 신동철
	 * @Param : 전형별 결과, 최종결과
	 * @Return : -
	 * @Method 설명 : 지원자 전형결과를 수정하는 함수
	 */
	public int update_fap_job_apply_result(Authentication auth, SocietyFapJobApplyResult applyResult, SocietyFapJobApplyFinalResult finalResult){
		logger.info("FAP 채용전형별 지원결과 정보 수정 Service 시작");
		
		String fap_comp_id = (String)auth.getPrincipal();
		SocietyFapJobAd job_ad = sfcDAO.select_job_ad(finalResult.getFap_job_ad_seq());
		ArrayList<SocietyFapJobApplyResult> applyResultList = new ArrayList<>();
		ArrayList<SocietyFapJobApplyFinalResult> finalResultList = new ArrayList<>();
		ArrayList<SocietyFapNominee>insertNomineeList = new ArrayList<>();
		
		//전형별 지원결과
		if(applyResult.getFap_job_apply_info_list() != null) {
			for(int i=0; i<applyResult.getFap_job_apply_info_list().size(); i++){
				for(int j=0; j<applyResult.getFap_job_apply_info_list().get(i).getJobApplyResult().getFap_job_app_rt_list().size(); j++){
					SocietyFapJobApplyResult newApplyResult = new SocietyFapJobApplyResult();
					newApplyResult.setFap_job_app_rt_seq(applyResult.getFap_job_apply_info_list().get(i).getJobApplyResult().getFap_job_app_rt_list().get(j).getFap_job_app_rt_seq());
					newApplyResult.setFap_job_app_rt_acp(applyResult.getFap_job_apply_info_list().get(i).getJobApplyResult().getFap_job_app_rt_list().get(j).getFap_job_app_rt_acp());
					newApplyResult.setFap_job_app_rt_udt_id(fap_comp_id);
					applyResultList.add(newApplyResult);
				}
			}
		}
		
		//최종결과
		if(finalResult.getFap_job_apply_info_list() != null) {
			for(int i=0; i<finalResult.getFap_job_apply_info_list().size(); i++){
				HashMap<String, Object> hashmap = new HashMap<>();
				SocietyFapJobApplyFinalResult newFinalResult = new SocietyFapJobApplyFinalResult();
				newFinalResult.setFap_job_app_final_rt_seq(finalResult.getFap_job_apply_info_list().get(i).getFap_job_app_final_rt_seq());
				newFinalResult.setFap_job_app_final_rt_acp(finalResult.getFap_job_apply_info_list().get(i).getFap_job_app_final_rt_acp());
				if(finalResult.getFap_job_apply_info_list().get(i).getFap_job_app_standby_rank() == null){
					newFinalResult.setFap_job_app_standby_rank(("0"));
				}else{
					String stanbyRanking = finalResult.getFap_job_apply_info_list().get(i).getFap_job_app_standby_rank();
					String[] split = stanbyRanking.split(":");
					newFinalResult.setFap_job_app_standby_rank(split[1]);
				}
				newFinalResult.setFap_job_app_final_rt_udt_id(fap_comp_id);
				finalResultList.add(newFinalResult);
				
				//최종결과가 합격인 경우 내정자
				if(finalResult.getFap_job_apply_info_list().get(i).getFap_job_app_final_rt_acp().equals("D0001")){
					hashmap.put("fap_job_ad_seq", finalResult.getFap_job_ad_seq());
					hashmap.put("user_id", finalResult.getFap_job_apply_info_list().get(i).getUser_id());
					SocietyFapNominee savedNominee = sfcDAO.select_nominee(hashmap);
					if(savedNominee == null){
						SocietyFapNominee insertNominee = new SocietyFapNominee();
						insertNominee.setFap_job_ad_seq(finalResult.getFap_job_ad_seq());
						insertNominee.setFap_comp_id(finalResult.getFap_comp_id());
						insertNominee.setUser_id(finalResult.getFap_job_apply_info_list().get(i).getUser_id());
						insertNominee.setFap_jobfair_seq(job_ad.getFap_jobfair_seq());
						insertNominee.setFap_jobfair_divide_seq(job_ad.getFap_jobfair_divide_seq());
						insertNominee.setFap_nominee_enter_gb("C4700");
						insertNominee.setFap_nominee_ins_id(finalResult.getFap_comp_id());
						insertNominee.setFap_nominee_udt_id(finalResult.getFap_comp_id());
						insertNomineeList.add(insertNominee);
					}
				}else{	//최종결과가 합격이 아닌 다른 결과로 바뀐 내정자 삭제
					hashmap.put("fap_job_ad_seq", finalResult.getFap_job_ad_seq());
					hashmap.put("user_id", finalResult.getFap_job_apply_info_list().get(i).getUser_id());
					SocietyFapNominee savedNominee = sfcDAO.select_nominee(hashmap);
					if(savedNominee != null){
						sfcDAO.delete_nominee(savedNominee.getFap_nominee_seq());
					}
				}
			}
		}
		 int result = 0;
		if(!applyResultList.isEmpty()) {
			result = sfcDAO.update_fap_job_apply_result(applyResultList);
		}
		if(!finalResultList.isEmpty()) sfcDAO.update_fap_job_final_result(finalResultList);
		if(!insertNomineeList.isEmpty()) sfcDAO.insert_nominee(insertNomineeList);
		
		logger.info("FAP 채용전형별 지원결과 정보 수정 Service 종료");
		return result;
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
		logger.info("FAP 채용전형 지원자 최종결과 합격사유 등록 Service 시작");
		sfcDAO.insert_pass_comment(passComment);
		logger.info("FAP 채용전형 지원자 최종결과 합격사유 등록 Service 종료");
	}
	
	/**
	 * @Method Name : search_missmatching_applicant_info
	 * @Date : 2019. 2. 15.
	 * @User : 신동철
	 * @Param : 채용공고 seq, 회사 아이디
	 * @Return : 채용전형 진행중, 합격, 추가합격 미스매칭 지원자 정보
	 * @Method 설명 : 채용전형 진행중, 합격, 추가합격 미스매칭 지원자 정보 불러오는 함수
	 */
	public ArrayList<HashMap<String, Object>> search_missmatching_applicant_info(HashMap<String, Object> hashmap){
		logger.info("FAP 채용전형 진행중, 합격, 추가합격 미스매칭 지원자 정보 불러오기 Service 시작");
		ArrayList<HashMap<String, Object>> missResultMap = sfcDAO.search_missmatching_applicant_info(hashmap);
		logger.info("FAP 채용전형 진행중, 합격, 추가합격 미스매칭 지원자 정보 불러오기 Service 종료");
		return missResultMap;
	}
	
	/**
	 * @Method Name : update_missmatching_fap_job_apply_result
	 * @Date : 2019. 2. 24.
	 * @User : 신동철
	 * @Param : 미스매칭 지원자 전형별 결과, 최종결과
	 * @Return : -
	 * @Method 설명 : 미스매칭 지원자 전형결과를 수정하는 함수
	 */
	public int update_missmatching_fap_job_apply_result(Authentication auth, SocietyFapJobApplyResult applyResult, SocietyFapJobApplyFinalResult finalResult){
		logger.info("FAP 미스매칭 지원자의 채용전형 지원결과 정보 수정 Service 시작");
		
		String fap_comp_id = (String)auth.getPrincipal();
		SocietyFapJobAd job_ad = sfcDAO.select_job_ad(finalResult.getFap_job_ad_seq());
		ArrayList<SocietyFapJobApplyResult> applyResultList = new ArrayList<>();
		ArrayList<SocietyFapJobApplyFinalResult> finalResultList = new ArrayList<>();
		ArrayList<SocietyFapNominee>insertNomineeList = new ArrayList<>();
		
		//전형별 지원결과
		if(applyResult.getFap_job_apply_info_list() != null) {
			for(int i=0; i<applyResult.getFap_job_apply_info_list().size(); i++){
				for(int j=0; j<applyResult.getFap_job_apply_info_list().get(i).getJobApplyResult().getFap_job_app_rt_list().size(); j++){
					SocietyFapJobApplyResult newApplyResult = new SocietyFapJobApplyResult();
					newApplyResult.setFap_job_app_rt_seq(applyResult.getFap_job_apply_info_list().get(i).getJobApplyResult().getFap_job_app_rt_list().get(j).getFap_job_app_rt_seq());
					newApplyResult.setFap_job_app_rt_acp(applyResult.getFap_job_apply_info_list().get(i).getJobApplyResult().getFap_job_app_rt_list().get(j).getFap_job_app_rt_acp_miss());
					newApplyResult.setFap_job_app_rt_udt_id(fap_comp_id);
					applyResultList.add(newApplyResult);
				}
			}
		}
		
		//최종결과
		if(finalResult.getFap_job_apply_info_list() != null) {
			for(int i=0; i<finalResult.getFap_job_apply_info_list().size(); i++){
				HashMap<String, Object> hashmap = new HashMap<>();
				SocietyFapJobApplyFinalResult newFinalResult = new SocietyFapJobApplyFinalResult();
				newFinalResult.setFap_job_app_final_rt_seq(finalResult.getFap_job_apply_info_list().get(i).getFap_job_app_final_rt_seq());
				newFinalResult.setFap_job_app_final_rt_acp(finalResult.getFap_job_apply_info_list().get(i).getFap_job_app_final_rt_acp_miss());
				if(finalResult.getFap_job_apply_info_list().get(i).getFap_job_app_standby_rank() == null){
					newFinalResult.setFap_job_app_standby_rank(("0"));
				}else{
					String stanbyRanking = finalResult.getFap_job_apply_info_list().get(i).getFap_job_app_standby_rank();
					String[] split = stanbyRanking.split(":");
					newFinalResult.setFap_job_app_standby_rank(split[1]);
				}
				newFinalResult.setFap_job_app_final_rt_udt_id(fap_comp_id);
				finalResultList.add(newFinalResult);
				
				//최종결과가 합격인 경우 내정자
				if(finalResult.getFap_job_apply_info_list().get(i).getFap_job_app_final_rt_acp_miss().equals("D0001")){
					hashmap.put("fap_job_ad_seq", finalResult.getFap_job_ad_seq());
					hashmap.put("user_id", finalResult.getFap_job_apply_info_list().get(i).getUser_id());
					SocietyFapNominee savedNominee = sfcDAO.select_nominee(hashmap);
					if(savedNominee == null){
						SocietyFapNominee insertNominee = new SocietyFapNominee();
						insertNominee.setFap_job_ad_seq(finalResult.getFap_job_ad_seq());
						insertNominee.setFap_comp_id(finalResult.getFap_comp_id());
						insertNominee.setUser_id(finalResult.getFap_job_apply_info_list().get(i).getUser_id());
						insertNominee.setFap_jobfair_seq(job_ad.getFap_jobfair_seq());
						insertNominee.setFap_jobfair_divide_seq(job_ad.getFap_jobfair_divide_seq());
						insertNominee.setFap_nominee_enter_gb("C4700");
						insertNominee.setFap_nominee_ins_id(finalResult.getFap_comp_id());
						insertNominee.setFap_nominee_udt_id(finalResult.getFap_comp_id());
						insertNomineeList.add(insertNominee);
					}
				}else{	//최종결과가 합격이 아닌 다른 결과로 바뀐 내정자 삭제
					hashmap.put("fap_job_ad_seq", finalResult.getFap_job_ad_seq());
					hashmap.put("user_id", finalResult.getFap_job_apply_info_list().get(i).getUser_id());
					SocietyFapNominee savedNominee = sfcDAO.select_nominee(hashmap);
					if(savedNominee != null){
						sfcDAO.delete_nominee(savedNominee.getFap_nominee_seq());
					}
				}		
			}
		}
		int result = 0;
		if(!applyResultList.isEmpty()){
			result = sfcDAO.update_fap_job_apply_result(applyResultList);
		}
		if(!finalResultList.isEmpty()) sfcDAO.update_fap_job_final_result(finalResultList);
		if(!insertNomineeList.isEmpty()) sfcDAO.insert_nominee(insertNomineeList);
		
		logger.info("FAP 미스매칭 지원자의 채용전형 지원결과 정보 수정 Service 종료");
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
		logger.info("FAP 채용전형 Q&A리스트 검색  Serivce 시작");
		ArrayList<HashMap<String, Object>> result = sfcDAO.select_job_qna(fap_job_ad_seq);
		logger.info("FAP 채용전형  Q&A리스트 검색 Serivce 종료");
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
		logger.info("FAP 채용전형 Q&A 상세  Serivce 시작");
		HashMap<String, Object> result = sfcDAO.select_job_qna_one(fap_job_qna_question_seq);
		logger.info("FAP 채용전형  Q&A 상세  Serivce 종료");
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
	@Transactional
	public int insert_job_qna_question(SocietyFapQnaAnswer qnaAnswer){
		logger.info("FAP 채용전형 Q&A 답변 등록 Service 시작");
		//답변등록
		int result = sfcDAO.insert_job_qna_question(qnaAnswer);
		//질문테이블의 상태를 답변완료로 변경
		sfcDAO.update_job_qna_question_approve(qnaAnswer.getFap_job_qna_question_seq());
		logger.info("FAP 채용전형  Q&A 답변 등록  Service 종료");
		return result;
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
		logger.info("FAP 채용전형 Q&A 답변 수정 Service 시작");
		sfcDAO.update_job_qna_question(qnaAnswer);
		logger.info("FAP 채용전형  Q&A 답변 수정  Service 종료");
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
		logger.info("FAP 잡페어 세부별 최종합격자 결정 시한 설정 정보 검색 Service 시작");	
		HashMap<String, Object> hashmap = sfcDAO.search_jobfair_divide_final_select_info(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 세부별 최종합격자 결정 시한 설정 정보 검색 Service 종료");
		return hashmap;
	}
	
	/**
	 * @Method Name : board_contents_hit_update
	 * @Date : 2019. 7. 16.
	 * @User : 김경아	
	 * @Param : 게시글 시퀀스
	 * @Return : 
	 * @Method 설명 : 해당 게시글의 세부 내용 중 조회수를 증가 시키는 서비스 함수
	 */
	public void board_contents_hit_update(int board_content_seq) {
		logger.debug("게시글 세부 내용 중 조회수 증가 서비스 함수 시작");

		sfcDAO.board_contents_hit_update(board_content_seq);

		logger.debug("게시글 세부 내용 중 조회수 증가 서비스 함수 종료");
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
		logger.info("FAP 오픈잡페어 기업 게시판 이름 조회 서비스 시작");
		String result = sfcDAO.select_comp_name(board_detail_gb);
		logger.info("FAP 오픈잡페어 기업 게시판 이름 조회 서비스 종료");
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
		logger.info("FAP 채용공고별 현지면접 대상자 인원제한 체크용 검색 서비스 시작");
		HashMap<String, Object> result = sfcDAO.select_interview_limit_check(fap_job_ad_seq);
		logger.info("FAP 채용공고별 현지면접 대상자 인원제한 체크용 검색 서비스 종료");
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
		logger.info("FAP 잡페어별 현지면접인원 제한 계열 검색 서비스 시작");
		String result = sfcDAO.select_interview_limit_type(fap_jobfair_seq);
		logger.info("FAP 잡페어별 현지면접인원 제한 계열 검색 서비스 종료");
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
		logger.info("FAP 도쿄페어 기업 전형 등록 가능 여부 ( 1: 가능 , 0: 불가능 ) 조회 서비스 시작");
		int result = sfcDAO.tokyofair_screening_date_check(fap_jobfair_divide_seq);
		logger.info("FAP 도쿄페어 기업 전형 등록 가능 여부 ( 1: 가능 , 0: 불가능 ) 조회 서비스 종료");
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
		logger.info("FAP 도쿄페어 전형 대상자 조회 서비스 시작");
		ArrayList<HashMap<String, Object>> result = sfcDAO.tokyofair_screening_subject_search(fap_job_ad_seq);
		logger.info("FAP 도쿄페어 전형 대상자 조회 서비스 종료");
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
		logger.info("FAP 도쿄페어 전형 확정대상자 제외 대상자 조회 서비스 시작");
		ArrayList<HashMap<String, Object>> result = sfcDAO.tokyofair_screening_subject_search_some(fap_job_ad_seq);
		logger.info("FAP 도쿄페어 전형 확정대상자 제외 대상자 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_screening_subject_search_two
	 * @Date : 2019. 9. 26.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 도쿄페어 전형 대상자 일부
	 * @Method 설명 : 도쿄페어 전형 대상자 일부 조회
	 */
	public ArrayList<HashMap<String, Object>> tokyofair_screening_subject_search_two(long fap_job_ad_seq){
		logger.info("FAP 도쿄페어 전형 대상자 조회 서비스 시작");
		ArrayList<HashMap<String, Object>> result = sfcDAO.tokyofair_screening_subject_search(fap_job_ad_seq);
		ArrayList<SocietyFapTokyofairScrUser> delList = sfcDAO.tokyofair_scr_user_select(fap_job_ad_seq);
		
		ArrayList<HashMap<String, Object>> check = new ArrayList<>();
		
		for(HashMap<String, Object> map : result) {
			for(SocietyFapTokyofairScrUser user : delList) {
				if(Long.parseLong(map.get("fap_resume_seq").toString()) == user.getFap_tokyofair_scr_resume_seq()) {
					check.add(map);
				}
			}
		}
		result.removeAll(check);
		
		logger.info("FAP 도쿄페어 전형 대상자 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_screening_subject_search_three
	 * @Date : 2019. 9. 30.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 대상자
	 * @Return : 도쿄페어 전형별 대상자
	 * @Method 설명 : 도쿄페어 전형별 대상자 조회 
	 */
	public HashMap<String, Object> tokyofair_screening_subject_search_three(ArrayList<HashMap<String, Object>> paramList , int fap_tokyofair_screening_seq){
		logger.info("FAP 도쿄페어 전형별 대상자 조회 서비스 시작");
		
		HashMap<String, Object> resultMap = new HashMap<>();
		ArrayList<HashMap<String, Object>> selectedList = sfcDAO.tokyofair_scr_user_select_group(fap_tokyofair_screening_seq);
		
		ArrayList<HashMap<String, Object>> check = new ArrayList<>();
		
		for(HashMap<String, Object> map : selectedList) {
			for(HashMap<String, Object> user : paramList) {
				if(Long.parseLong(map.get("fap_resume_seq").toString()) == Long.parseLong(user.get("fap_resume_seq").toString())) {
					check.add(map);
				}
			}
		}
		selectedList.removeAll(check);
		
		resultMap.put("selectableList", paramList);
		resultMap.put("selectedList", selectedList);
		
		logger.info("FAP 도쿄페어 전형별 대상자 조회 서비스 종료");
		return resultMap;
	}
	
	/**
	 * @Method Name : tokyofair_screening_insert
	 * @Date : 2019. 9. 26.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 전형 정보 등록  
	 */
	@Transactional
	public void tokyofair_screening_insert(SocietyFapTokyofairScreening tokyofairScr) {
		logger.info("FAP 도쿄페어 전형 정보 등록 서비스 시작");
		sfcDAO.tokyofair_screening_insert(tokyofairScr);
		
		List<SocietyFapTokyofairScrUser> scrUserList = new ArrayList<>();
		
		for(SocietyFapTokyofairScrUser user : tokyofairScr.getScrUser().getScrUserList()) {
			if(user.getFap_tokyofair_scr_resume_seq() != 0) {
				user.setFap_tokyofair_screening_seq(tokyofairScr.getFap_tokyofair_screening_seq());
				scrUserList.add(user);
			}
		}
		
		sfcDAO.tokyofair_scr_user_insert(scrUserList);
		
		logger.info("FAP 도쿄페어 전형 정보 등록 서비스 종료");
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
		logger.info("FAP 도쿄페어 전형 등록 개수 조회  서비스 시작");
		int count = sfcDAO.tokyofair_screening_search_count(fap_job_ad_seq);
		logger.info("FAP 도쿄페어 전형 등록 개수 조회  서비스 종료");
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
		logger.info("FAP 도쿄페어 전형 리스트 조회 서비스 시작");
		ArrayList<SocietyFapTokyofairScreening> result = sfcDAO.tokyofair_screening_search(fap_job_ad_seq);
		logger.info("FAP 도쿄페어 전형 리스트 조회 서비스 종료");
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
		logger.info("FAP 도쿄페어 전형 정보 조회 서비스 시작");
		HashMap<String, Object> result = sfcDAO.tokyofair_screening_search_one(fap_tokyofair_screening_seq);
		logger.info("FAP 도쿄페어 전형 정보 조회 서비스 종료");
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
		logger.info("FAP 도쿄페어 전형 삭제 서비스 시작");
		int result = sfcDAO.tokyofair_screening_delete(fap_tokyofair_screening_seq);
		logger.info("FAP 도쿄페어 전형 삭제 서비스 종료");
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
	@Transactional
	public void tokyofair_screening_update(SocietyFapTokyofairScreening tokyofairScr) {
		logger.info("FAP 도쿄페어 전형 정보 수정 서비스 시작");
		sfcDAO.tokyofair_screening_update(tokyofairScr);
		sfcDAO.tokyofair_scr_user_delete(tokyofairScr.getFap_tokyofair_screening_seq());
		
		List<SocietyFapTokyofairScrUser> scrUserList = new ArrayList<>();
		
		for(SocietyFapTokyofairScrUser user : tokyofairScr.getScrUser().getScrUserList()) {
			if(user.getFap_tokyofair_scr_resume_seq() != 0) {
				user.setFap_tokyofair_screening_seq(tokyofairScr.getFap_tokyofair_screening_seq());
				scrUserList.add(user);
			}
		}
		
		sfcDAO.tokyofair_scr_user_insert(scrUserList);
		
		logger.info("FAP 도쿄페어 전형 정보 수정 서비스 종료");
	}
	
	/**
	 * @Method Name : tokyofair_schedule_set_search
	 * @Date : 2019. 10. 1.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : 설정된 도쿄페어 설정 정보
	 * @Method 설명 : 설정된 도쿄페어 설정 정보 조회
	 */
	@Transactional
	public HashMap<String, Object> tokyofair_schedule_set_search(int fap_jobfair_divide_seq) {
		logger.info("FAP 설정된 도쿄페어 설정 정보 조회 DAO 시작");
		
		Gson gson = new Gson();
		HashMap<String, Object> result = new HashMap<>();
		
		SocietyFapAdminJobfairSet tokyofairSet = sfcDAO.tokyofair_schedule_set_search(fap_jobfair_divide_seq);
		HashMap<String, Object> tokyofairDate = sfaDAO.tokyofair_schedule_set_date_search(tokyofairSet.getFap_jobfair_set_seq());
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("fap_jobfair_set_seq", tokyofairSet.getFap_jobfair_set_seq());
		params.put("fap_tokyofair_date_dt", tokyofairSet.getFap_jobfair_set_st());
		
		ArrayList<HashMap<String, Object>> tokyofairSch = sfcDAO.tokyfair_schedule_booked_search(params);
		
		String sch_json = gson.toJson(tokyofairSch);
		String schReplace_json = sch_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		
		String set_json = gson.toJson(tokyofairSet);
		String setReplace_json = set_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		
		String date_json = gson.toJson(tokyofairDate);
		String replace_json = date_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		
		result.put("tokyofairSet", setReplace_json);
		result.put("tokyofairDate", replace_json);
		result.put("tokyofairSch", schReplace_json);
		
		logger.info("FAP 설정된 도쿄페어 설정 정보 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_reload
	 * @Date : 2019. 10. 10.
	 * @User : 이종호
	 * @Param : 현지 잡페어 설정 시퀀스 , 등록된 일정 날짜
	 * @Return : 등록된 일정 정보 리스트
	 * @Method 설명 : 도쿄페어 등록된 일정 정보 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> tokyofair_schedule_reload(HashMap<String, Object> params){
		logger.info("FAP 도쿄페어 등록된 일정 정보 리스트 조회 DAO 시작");
		ArrayList<HashMap<String, Object>> tokyofairSch = sfcDAO.tokyfair_schedule_booked_search(params);
		logger.info("FAP 도쿄페어 등록된 일정 정보 리스트 조회 DAO 종료");
		return tokyofairSch;
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
		logger.info("FAP 도쿄페어 전형 중 예약 가능한 리스트 조회 서비스 시작");
		ArrayList<SocietyFapTokyofairScreening> result = sfcDAO.tokyofair_screening_search_bookable(fap_job_ad_seq);
		logger.info("FAP 도쿄페어 전형 중 예약 가능한 리스트 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_insert
	 * @Date : 2019. 10. 4.
	 * @User : 이종호
	 * @Param : 등록할 도쿄페어 일정 정보
	 * @Return : 등록 가능여부, 등록시 일정 시퀀스
	 * @Method 설명 : 등록가능여부를 판단하여 도쿄페어 일정을 등록
	 */
	@Transactional
	public long tokyofair_schedule_insert(HashMap<String, Object> params, String user_id) {
		logger.info("FAP 도쿄페어 날짜 정보 등록 서비스 시작");
		params.put("user_id", user_id);
		//날짜 정보 확인
		int fap_tokyofair_date_seq = sfcDAO.tokyofair_schedule_date_check(params);
		if(fap_tokyofair_date_seq == 0) {
			//날짜 없을경우 등록
			sfcDAO.tokyofair_schedule_date_insert(params);
		} else {
			params.put("fap_tokyofair_date_seq", fap_tokyofair_date_seq);
		}
		//날짜 등록된거 확인후 일정 등록
		sfcDAO.tokyofair_schedule_info_insert(params);
		long fap_tokyofair_schedule_seq = Long.parseLong(params.get("fap_tokyofair_schedule_seq").toString());
		logger.info("FAP 도쿄페어 날짜 정보 등록 서비스 종료");
		return fap_tokyofair_schedule_seq;
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
		logger.info("FAP 도쿄페어 일정 가능여부 확인 서비스 시작");
		int result = sfcDAO.tokyofair_schedule_info_check(params);
		logger.info("FAP 도쿄페어 일정 가능여부 확인 서비스 종료");
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
		logger.info("FAP 도쿄페어 일정 삭제 서비스 시작");
		int result = sfcDAO.tokyofair_schedule_delete(fap_tokyofair_schedule_seq);
		logger.info("FAP 도쿄페어 일정 삭제 서비스 종료");
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
		logger.info("FAP 도쿄페어 최초등록 일정 여부 판단 서비스 시작");
		int result = sfcDAO.tokyofair_schedule_first_check(tokyofairDate);
		logger.info("FAP 도쿄페어 최초등록 일정 여부 판단 서비스 종료");
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
		logger.info("FAP 도쿄페어 앞면접 과의 면접준비시간 체크 서비스 시작");
		int result = sfcDAO.tokyofair_schedule_itv_comp_before_check(params);
		logger.info("FAP 도쿄페어 앞면접 과의 면접준비시간 체크 서비스 종료");
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
		logger.info("FAP 도쿄페어 앞면접 과의 여유도 체크 서비스 시작");
		int result = sfcDAO.tokyofair_schedule_term_check(params);
		logger.info("FAP 도쿄페어 앞면접 과의 여유도 체크 서비스 종료");
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
		logger.info("FAP 도쿄페어 일정 인원 중복 체크 서비스 시작");
		ArrayList<HashMap<String, Object>> result = sfcDAO.tokyofair_schedule_member_duplicate_check(scheduleMemberMap);
		logger.info("FAP 도쿄페어 일정 인원 중복 체크 서비스 종료");
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
	@Transactional
	public void tokyofair_schedule_member_insert(HashMap<String, Object> scheduleMemberMap) {
		logger.info("FAP 도쿄페어 일정 인원 등록 서비스 시작");
		sfcDAO.tokyofair_schedule_member_insert(scheduleMemberMap);
		scheduleMemberMap.put("fap_tokyofair_screening_sch_gb", SCREENING_SCH_GB_INSERT);
		sfcDAO.tokyofair_screening_sch_gb_update(scheduleMemberMap);
		logger.info("FAP 도쿄페어 일정 인원 등록 서비스 종료");
	}
	
	/**
	 * @Method Name : tokyofair_schedule_member_update
	 * @Date : 2019. 10. 11.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 인원 정보
	 * @Return : 
	 * @Method 설명 : 도쿄페어 일정 인원 수정
	 */
	@Transactional
	public void tokyofair_schedule_member_update(HashMap<String, Object> scheduleMemberMap) {
		logger.info("FAP 도쿄페어 일정 인원 수정 서비스 시작");
		sfcDAO.tokyofair_schedule_member_delete(Long.parseLong(scheduleMemberMap.get("fap_tokyofair_schedule_seq").toString()));
		sfcDAO.tokyofair_schedule_member_insert(scheduleMemberMap);
		logger.info("FAP 도쿄페어 일정 인원 수정 서비스 종료");
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
		logger.info("FAP 채용공고 회사 아이디 조회 서비스 시작");
		String fap_comp_id = sfcDAO.job_ad_comp_id_search(fap_job_ad_seq);
		logger.info("FAP 채용공고 회사 아이디 조회 서비스 종료");
		return fap_comp_id;
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
		logger.info("FAP 도쿄페어 일정 정보 및 인원 정보 검색 서비스 시작");
		HashMap<String, Object> result = sfcDAO.tokyofair_schedule_search_detail(fap_tokyofair_schedule_seq);
		logger.info("FAP 도쿄페어 일정 정보 및 인원 정보 검색 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_member_delete
	 * @Date : 2019. 10. 11.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 시퀀스, 도쿄페어 전형 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 일정 인원 삭제 
	 */
	@Transactional
	public int tokyofair_schedule_member_delete(long fap_tokyofair_schedule_seq, int fap_tokyofair_screening_seq) {
		logger.info("FAP 도쿄페어 일정 인원 삭제 서비스 시작");
		int result = sfcDAO.tokyofair_schedule_delete(fap_tokyofair_schedule_seq);
		HashMap<String, Object> params = new HashMap<>();
		params.put("fap_tokyofair_screening_sch_gb", SCREENING_SCH_GB_DELETE);
		params.put("fap_tokyofair_screening_seq", fap_tokyofair_screening_seq);
		sfcDAO.tokyofair_screening_sch_gb_update(params);
		logger.info("FAP 도쿄페어 일정 인원 삭제 서비스 종료");
		return result;
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
		logger.info("FAP 도쿄페어 전체 전형 일정 정보 조회 서비스 시작");
		HashMap<String, Object> result = sfcDAO.tokyofair_screening_search_total(params);
		logger.info("FAP 도쿄페어 전체 전형 일정 정보 조회 서비스 종료");
		return result;
	}
}
