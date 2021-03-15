/**
 * 
 */
package global.segroup.society.fap.agency.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.mail.MessagingException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import global.segroup.dao.SEGroupCommonDAO;
import global.segroup.domain.CertificationCode;
import global.segroup.domain.User;
import global.segroup.society.fap.agency.dao.SocietyFapAgencyDAO;
import global.segroup.society.fap.agency.domain.SocietyFapAgencyCompanyConnect;
import global.segroup.society.fap.company.domain.SocietyFapCompanyUser;
import global.segroup.society.fap.company.domain.SocietyFapCompanyUserConnect;
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
import global.segroup.society.fap.company.domain.SocietyFapJobPref;
import global.segroup.society.fap.company.domain.SocietyFapJobRecruitPcs;
import global.segroup.society.fap.company.domain.SocietyFapJobServiceWork;
import global.segroup.society.fap.company.domain.SocietyFapJobTestEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobTestEtcObj;
import global.segroup.society.fap.company.domain.SocietyFapJobTrial;
import global.segroup.society.fap.company.domain.SocietyFapJobWork;
import global.segroup.society.fap.company.domain.SocietyFapJobWorkplace;
import global.segroup.society.fap.company.domain.SocietyFapJobWorkplaceDtl;
import global.segroup.society.fap.user.dao.SocietyFapUserDAO;
import global.segroup.util.FileService;
import global.segroup.util.MailService;

/**
 * @Author : 김준영 
 * @Date : 2018. 12. 11.
 * @Class 설명 : Soft Engineer Society 통합잡페어 에이전시 서비스
 */

@Service
public class SocietyFapAgencyService {

	private static final Logger logger = LoggerFactory.getLogger(SocietyFapAgencyService.class);
	
	@Autowired
	private SocietyFapAgencyDAO sfaDAO;
	
	@Autowired
	private SEGroupCommonDAO sgcDAO;
	
	@Autowired
	private SocietyFapUserDAO sfuDAO;
	
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
	
	/**
	 * @Method Name : UploadFileServer
	 * @Date : 2018. 12. 11.
	 * @User : 김준영
	 * @Param : 에이전시 정보 객체
	 * @Return : -
	 * @Method 설명 : 에이전시 등록시 로고 파일 서버 저장
	 */
	private void UploadFileServer(SocietyFapCompanyUser sfcUser) {
		logger.info("FAP 로고 등록 시작 ");
		String fullPath = "/" + sfcUser.getFap_comp_id();
		try {
			if (sfcUser.getFap_comp_log_file() != null) {
				sfcUser.setFap_comp_log_origin(sfcUser.getFap_comp_log_file().getOriginalFilename());
				sfcUser.setFap_comp_log_saved(FileService.saveFile(sfcUser.getFap_comp_log_file(), fapCompanyUserLogoImage + fullPath));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		logger.info("FAP 로고 등록 종료");
	}
	
	/**
	 * @Method Name : DeleteFileServer
	 * @Date : 2018. 12. 19.
	 * @User : 김준영
	 * @Param : 파일 이름, 파일 존재 여부
	 * @Return : -
	 * @Method 설명 : 서버에 저장되어있는 파일을 삭제하는 함수
	 */
	private void DeleteFileServer(SocietyFapCompanyUser sfcUser) {
		logger.info("FAP 회사 로고 삭제 시작");
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
		String user_id_check = sfaDAO.user_id_check(user_id);
		logger.info("FAP 유저 아이디 중복체크 서비스 종료");
		return user_id_check;
	}
	
	/**
	 * @Method Name : insert_com_user
	 * @Date : 2018. 12. 13.
	 * @User : 김준영
	 * @Param : 유저 객체
	 * @Return : -
	 * @Method 설명 : 유저 등록을 하는 함수
	 *//*
	public void insert_com_user(User user){
		logger.info("FAP 공통 유저 정보 등록 서비스 시작");
		sfaDAO.insert_com_user(user);
		logger.info("FAP 공통 유저 정보 등록 서비스 종료");
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
		logger.info("FAP 에이전시 정보 등록 서비스 시작");
		UploadFileServer(sfcUser);
		sfaDAO.insert_agency(sfcUser);
		logger.info("FAP 에이전시 정보 등록 서비스 종료");
	}
	
	*//**
	 * @Method Name : comp_user_connect
	 * @Date : 2018. 12. 12.
	 * @User : 김준영
	 * @Param : 에이전시-담당자 연결 객체
	 * @Return : -
	 * @Method 설명 : 에이전시와 담당자를 연결해주는 함수
	 *//*
	public void comp_user_connect(SocietyFapCompanyUserConnect sfCUConnect){
		logger.info("FAP 에이전시-담당자 연결 서비스 시작");
		sfaDAO.comp_user_connect(sfCUConnect);
		logger.info("FAP 에이전시-담당자 연결 서비스 종료");
	}*/
	
	/**
	 * @Method Name : insert_agency
	 * @Date : 2018. 12. 13.
	 * @User : 김준영
	 * @Param : 유저 객체, 에이전시 정보 객체
	 * @Return : -
	 * @Method 설명 : 에이전시 정보를 등록 하는 함수
	 */
	public void insert_agency(String company_ck, User user, 
			SocietyFapCompanyUser societyFapCompanyUser, 
			SocietyFapCompanyUserConnect societyFapCompanyUserConnect){
		logger.info("FAP 에이전시 정보 등록 서비스 시작");
		// 에이전시 이름과 담당자 ID를 합쳐 회사 아이디를 만듦
		String company_id = ((societyFapCompanyUser.getFap_comp_en_nm()).replaceAll(" ",""))+ "@_@" + user.getUser_id();
		societyFapCompanyUser.setFap_comp_id(company_id);
		UploadFileServer(societyFapCompanyUser);
		sfaDAO.insert_agency(company_ck, user, societyFapCompanyUser, societyFapCompanyUserConnect);
		logger.info("FAP 에이전시 정보 등록 서비스 종료");
	}
	
	/**
	 * @Method Name : select_user
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 공통 유저 객체
	 * @Method 설명 : 에이전시 유저 객체를 불러오는 함수
	 */
	public User select_user(String user_id){
		logger.info("FAP 에이전시 담당자 정보 가져오기 서비스 시작");
		User user = sfaDAO.select_user(user_id);
		logger.info("FAP 에이전시 담당자 정보 가져오기 서비스 종료");
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
		logger.info("FAP 에이전시 담당자 정보 수정 서비스 시작");
		sfaDAO.update_user(user);
		logger.info("FAP 에이전시 담당자 정보 수정 서비스 종료");
	}
	
	/**
	 * @Method Name : insert_company
	 * @Date : 2018. 12. 18.
	 * @User : 김준영
	 * @Param : 회사 정보 객체
	 * @Return : -
	 * @Method 설명 : 에이전시가 기업 회원 가입을 대신 해주는 함수
	 */
	public void insert_company(Authentication auth, User user, SocietyFapCompanyUser societyFapCompanyUser){
		logger.info("FAP 에이전시 회사 회원가입 서비스 시작");
		String fap_comp_id = ((societyFapCompanyUser.getFap_comp_en_nm()).replaceAll(" ",""))+ "@_@" + user.getUser_id();
		societyFapCompanyUser.setFap_comp_id(fap_comp_id);
		UploadFileServer(societyFapCompanyUser);
		sfaDAO.insert_company(auth, user, societyFapCompanyUser);
		
		logger.info("FAP 에이전시 회사 회원가입 서비스 종료");
	}
	
	/**
	 * @Method Name : select_ag_comp
	 * @Date : 2018. 12. 18.
	 * @User : Administrator
	 * @Param : 회원 아이디
	 * @Return : 에이전시 - 기업 연결 객체
	 * @Method 설명 : 회원 아이디가 가지고 있는 기업객체(에이전시)와 연결 되어있는 일반 기업을 가져오는 함수
	 */
	/*public ArrayList<HashMap<String, Object>> select_ag_comp(String user_id){
		logger.info("에이전시가 가지고 있는 기업 가져오기 서비스 시작");
		// 함수를 같이 쓰기 위해 승인 상태를 체크 안해줬기 때문에 서비스에서 승인 상태를 체크해줌
		ArrayList<HashMap<String, Object>> select_ag_comp = sfaDAO.select_ag_comp(user_id);
		
		for(int i = 0; i < select_ag_comp.size(); i++){
			if(!select_ag_comp.get(i).get("fap_ag_comp_connect_ck").equals("B3800")){
				select_ag_comp.remove(i);
			}
		}
		
		logger.info("에이전시가 가지고 있는 기업 가져오기 서비스 종료");
		return select_ag_comp;
	}*/
	
	/**
	 * @Method Name : select_comp_list
	 * @Date : 2018. 12. 19.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 기업 객체 리스트
	 * @Method 설명 : 기업 객체를 불러오는 함수
	 */
	public HashMap<String, Object> select_comp_list(String user_id){
		logger.info("FAP 기업 정보 가져오기 서비스 시작");
		// 자기 자신을 제외한 모든 기업 정보
		ArrayList<SocietyFapCompanyUser> select_comp_list = sfaDAO.select_comp_list(user_id);
		// 에이전시가 관리하고 있는 기업들의 정보
		ArrayList<HashMap<String, Object>> select_ag_comp = sfaDAO.select_ag_comp(user_id);
		// 다른 에이전시가 관리하고 있는 기업들의 connect_tb정보
		ArrayList<SocietyFapAgencyCompanyConnect> select_exclude_comp_list = sfaDAO.select_exclude_comp_list(user_id);
		// 다른 에이전시 기업 리스트
		ArrayList<SocietyFapCompanyUser> agency_list = sfaDAO.select_agency();
		
		// 승인 된 기업 목록
		ArrayList<HashMap<String, Object>> select_approval_comp = new ArrayList<>();
		// 요청을 보낸 후 승인 대기 중인 기업 목록
		ArrayList<HashMap<String, Object>> select_standBy_comp = new ArrayList<>();
		// 요청을 보냈지만 거절 당한 기업 목록
		ArrayList<HashMap<String, Object>> select_refusal_comp = new ArrayList<>();
		
		for(int i = 0; i < select_ag_comp.size(); i++){
			if(select_ag_comp.get(i).get("fap_ag_comp_connect_ck").equals("B3800")){
				select_approval_comp.add(select_ag_comp.get(i));
			} else if(select_ag_comp.get(i).get("fap_ag_comp_connect_ck").equals("B3801")){
				select_standBy_comp.add(select_ag_comp.get(i));
			} else if(select_ag_comp.get(i).get("fap_ag_comp_connect_ck").equals("B3802")){
				select_refusal_comp.add(select_ag_comp.get(i));
			}
		}
		
		// 기업리스트 중 에이전시가 이미 관리하고 있는 기업리스트를 빼주는 함수
		ArrayList<SocietyFapCompanyUser> delete_include_list = new ArrayList<>();
		for(int i = 0; i < select_comp_list.size(); i++){
			for(int j = 0; j < select_ag_comp.size(); j++){
				if(select_comp_list.get(i).getFap_comp_id().equals(select_ag_comp.get(j).get("fap_comp_id"))){
					delete_include_list.add(select_comp_list.get(i));
				}
			}
		}
		
		// 기업리스트 중 다른 에이전시가 이미 관리하고 있는(B3800) 기업리스트를 빼주는 함수
		ArrayList<SocietyFapCompanyUser> delete_exclude_list = new ArrayList<>();
		for(int i = 0; i < select_comp_list.size(); i++){
			for(int j = 0; j < select_exclude_comp_list.size(); j++){
				if(select_comp_list.get(i).getFap_comp_id().equals(select_exclude_comp_list.get(j).getFap_comp_id())
						&& select_exclude_comp_list.get(j).getFap_ag_comp_connect_ck().equals("B3800")){
					delete_exclude_list.add(select_comp_list.get(i));
				}
			}
		}
		
		// 기업리스트 중 에이전시를 빼주는 함수 agency_list
		ArrayList<SocietyFapCompanyUser> delete_agency_list = new ArrayList<>();
		for(int i = 0; i < select_comp_list.size(); i++){
			for(int j = 0; j < agency_list.size(); j++){
				if(select_comp_list.get(i).getFap_comp_id().equals(agency_list.get(j).getFap_comp_id())){
					delete_agency_list.add(select_comp_list.get(i));
				}
			}
		}
			
		// 기업리스트 중 에이전시가 이미 관리하고 있는 기업리스트를 빼주는 함수
		for(SocietyFapCompanyUser data : delete_include_list){
			select_comp_list.remove(data);
		}
		// 기업리스트 중 다른 에이전시가 이미 관리하고 있는 기업리스트를 빼주는 함수
		for(SocietyFapCompanyUser data : delete_exclude_list){
			select_comp_list.remove(data);
		}
		// 기업리스트 중 다른 에이전시 기업을 뺴주는 함수
		for(SocietyFapCompanyUser data : delete_agency_list){
			select_comp_list.remove(data);
		}
		
		HashMap<String, Object> hashMap = new HashMap<>();
		// 에이전시가 관리하고 있는(B3800, B3801, B3802) 기업과 자기자신을 제외한 기업 리스트 and 다른 에이전시가 관리 하고 있는 기업
		hashMap.put("select_comp_list", select_comp_list);
		// hashMap.put("select_ag_comp", select_ag_comp);
		// 에이전시가 관리 하고 있는 기업 리스트 (승인 : B3800)
		hashMap.put("select_approval_comp", select_approval_comp);
		// 에이전시가 관리 하고 있는 기업 리스트 (대기 : B3801)
		hashMap.put("select_standBy_comp", select_standBy_comp);
		// 에이전시가 관리 하고 있는 기업 리스트 (거절 : B3802)
		hashMap.put("select_refusal_comp", select_refusal_comp);
		
		logger.info("FAP 기업 정보 가져오기 서비스 종료");
		return hashMap;
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
		logger.info("FAP 에이전시 정보 가져오기 서비스 시작");
		SocietyFapCompanyUser societyFapCompanyUser = sfaDAO.select_company(fap_comp_id);
		logger.info("FAP 에이전시 정보 가져오기 서비스 종료");
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
		logger.info("FAP 회사 정보 업데이트 서비스 시작");
		if(sfcUser.getFap_comp_log_file() != null && !sfcUser.getFap_comp_log_file().isEmpty()){
			if (sfcUser.getFap_comp_log_saved() != null) {
				DeleteFileServer(sfcUser);
			}
			UploadFileServer(sfcUser);
		}
		sfaDAO.update_company(sfcUser);
		logger.info("FAP 회사 정보 업데이트 서비스 종료");
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
		logger.info("에이전시 기업 연결 서비스 시작");
		sfaDAO.insert_ag_comp_connect(hashMap);
		logger.info("에이전시 기업 연결 서비스 종료");
	}
	
	/**
	 * @Method Name : direct_request_connect
	 * @Date : 2018. 12. 21.
	 * @User : 김준영
	 * @Param : 에이전시 기업 연결 객체(회사 아이디는 배열)
	 * @Return : -
	 * @Method 설명 : 에이전시와 기업을 연결 요청을 보내는 함수
	 */
	public void connect_request(Authentication auth, ArrayList<String> comp_list){
		logger.info("에이전시 기업 연결 요청 서비스 시작");
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("agency_user_id", (String)auth.getPrincipal());
		hashMap.put("comp_nm_list", comp_list);
		hashMap.put("fap_ag_comp_connect_ck", "B3801");
		sfaDAO.connect_request(hashMap);
		logger.info("에이전시 기업 연결 요청 서비스 종료");
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
		logger.info("FAP 에이전시 기업 연결 끊기 서비스 시작");
		sfaDAO.ag_comp_disconnect(fap_ag_comp_connect_seq);
		logger.info("FAP 에이전시 기업 연결 끊기 서비스 종료");
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
		logger.info("FAP 기업에 연결된 에이전시 여부 확인 서비스 시작");
		ArrayList<SocietyFapAgencyCompanyConnect> societyFapAgencyCompanyConnect = sfaDAO.ck_ag_comp_connect(user_id);
		logger.info("FAP 기업에 연결된 에이전시 여부 확인 서비스 종료");
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
		logger.info("FAP 에이전시 - 기업 승인 여부 수정 서비스 시작");
		sfaDAO.update_ag_comp_connect(societyFapAgencyCompanyConnect);
		logger.info("FAP 에이전시 - 기업 승인 여부 수정 서비스 종료");
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
	 * @Method Name : select_agen_user_connect
	 * @Date : 2019. 02. 11.
	 * @User : 김홍일
	 * @Param : 유저 아이디
	 * @Return : 에이전시 기업 - 유저 연결 객체
	 * @Method 설명 : 해당 하는 아이디에 에이전시 기업 - 유저 연결 객체를 불러오는 함수
	 */
	public SocietyFapCompanyUserConnect select_agen_user_connect(String user_id){
		logger.info("FAP 기업 - 유저 연결 객체 가져오기 서비스 시작");
		SocietyFapCompanyUserConnect agen_user_connect = sfaDAO.select_agen_user_connect(user_id);
		logger.info("FAP 기업 - 유저 연결 객체 가져오기 서비스 종료");
		return agen_user_connect;
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
	 * @Method Name : agency_forgot_password
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 에이전시 담당자 아이디, 비밀번호
	 * @Return : 변경 여부
	 * @Method 설명 : 에이전시 담당자의 비밀번호를 변경하는 함수
	 */
	public boolean agency_forgot_password(String user_id, String user_pw) {
		logger.debug("FAP 에이전시 담당자 비밀번호 변경 서비스 시작");
		
		User userInfo = new User();
		userInfo.setUser_id(user_id);
		
		User found = sgcDAO.selectUser(userInfo);
		if (found == null) {
			return false;
		}
		
		String encodedPw = passwordEncoder.encode(user_pw);
		found.setUser_pw(encodedPw);
		sfuDAO.update_com_user(found);
		
		logger.debug("FAP 에이전시 담당자 비밀번호 변경 서비스 종료");
		return true;
	}
	
	/**
	 * @Method Name : delete_agency_user_info
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 탈퇴할 에이전시 담당자 정보 객체
	 * @Return : -
	 * @Method 설명 : 에이전시 담당자 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(30글자) 변경후 참조 테이블에 적용
	 */
	public void delete_agency_user_info(User user){
		logger.info("FAP 에이전시 담당자 탈퇴 서비스 시작");
		sfaDAO.delete_agency_user_info(user);
		logger.info("FAP 에이전시 담당자 탈퇴 서비스 종료");
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
		logger.info("FAP 기업 정보 가져오기 서비스 시작");
		SocietyFapCompanyUser societyFapCompanyUser = sfaDAO.select_company_compare_id(fap_comp_id);
		logger.info("FAP 기업 정보 가져오기 서비스 종료");
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
	public void delete_connect_request(Authentication auth, String fap_comp_id, String request_ck){
		logger.info("FAP 에이전시 - 기업 연결 요청 삭제 서비스 시작");
		SocietyFapAgencyCompanyConnect agencyCompanyConnect = new SocietyFapAgencyCompanyConnect();
		agencyCompanyConnect.setFap_ag_id((String)auth.getPrincipal());
		agencyCompanyConnect.setFap_comp_id(fap_comp_id);
		if(request_ck.equals("standBy")){
			agencyCompanyConnect.setFap_ag_comp_connect_ck("B3801");	
		} else if(request_ck.equals("refusal")){
			agencyCompanyConnect.setFap_ag_comp_connect_ck("B3802");
		}
		
		sfaDAO.delete_connect_request(agencyCompanyConnect);
		logger.info("FAP 에이전시 - 기업 연결 요청 삭제 서비스 종료");
	}
	
	/**
	 * @Method Name : company_user_check
	 * @Date : 2018. 12. 27.
	 * @User : 김준영
	 * @Param : 유저 객체
	 * @Return : 확인 메시지
	 * @Method 설명 : 에이전시 - 기업을 직접 연결해주는 함수
	 */
	public String direct_connect(Authentication auth, User user){
		logger.info("FAP 에이전시 - 기업 직접 연결 서비스 시작");
		String company_user_check = sfaDAO.direct_connect(auth, user);
		logger.info("FAP 에이전시 - 기업 직접 연결 서비스 종료");
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
		ArrayList<SocietyFapCompanyUser> comp_list = sfaDAO.select_agency_company();
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
	public void user_agency_info_insert(Authentication auth, SocietyFapCompanyUser agency_info){
		logger.info("FAP 에이전시 담당자 - 기업 정보 입력 DAO 시작");
		UploadFileServer(agency_info);
		sfaDAO.user_agency_info_insert(auth, agency_info);
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
		logger.info("통합잡페어 정보 리스트 검색 Service 시작");
		
		ArrayList<HashMap<String, Object>> jobfair_search_list = sfaDAO.jobfair_search_list();
		
		logger.info("통합잡페어 정보 리스트 검색 Service 종료");
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
		logger.info("선택한 잡페어 세부정보 리스트 검색 Service 시작");
		
		ArrayList<HashMap<String, Object>> jobfair_divide_search_list = sfaDAO.jobfair_divide_search_list(fap_jobfair_seq);
		
		logger.info("선택한 잡페어 세부정보 리스트 검색 Service 종료");
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
		logger.debug("FAP 채용공고 기본 정보 리스트 출력 Service 시작");
		ArrayList<SocietyFapJobAd> jobAdList = sfaDAO.select_job_ad_list(fap_comp_id);
		logger.debug("FAP 채용공고 기본 정보 리스트 출력 Service 종료");
		return jobAdList;
	}
	
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
	 * @Date : 2019. 1. 22.
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
	 * @Method Name : job_ad_insert2
	 * @Date : 2019. 1. 22.
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
		logger.info("채용공고2 등록 시작");
			
		
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
		
		
			
				/*************************** 채용공고 등록 시작 *******************************/
				String fap_comp_id = JobAd.getFap_comp_id();
				
				JobAd = sfaDAO.insert_job_ad2(JobAd);
				
				//기숙사 (C0800:기숙사 제도있음)
				if(JobAd.getFap_job_ad_isdorm() != null && JobAd.getFap_job_ad_isdorm().equals("C0800")){
				JobDorm.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				sfaDAO.insert_job_dorm(JobDorm);
				}
				
				//계약사원 (C0401:모집형태 계약사원)
				if(JobAd.getFap_job_ad_hire_type() != null && JobAd.getFap_job_ad_hire_type().equals("C0401")){
				JobJitEmployee.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				sfaDAO.insert_job_jit_employee(JobJitEmployee);
				}
				
				//업무에 필요한 일본어 능력 03.13 수정(원병호)
				if( !JobJaLevel.getFap_job_ja_level_dtl().equals("") || JobJaLevel.getFap_job_ja_level_gb() != null){
				JobJaLevel.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				sfaDAO.insert_job_ja_level(JobJaLevel);
				}
				
				//시용기간 (C0500:시용기간 있음)
				if(JobAd.getFap_job_ad_intern() != null && JobAd.getFap_job_ad_intern().equals("C0500")){
				JobTrial.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());	
				sfaDAO.insert_job_trial(JobTrial);
				}
				
				//없으면 들어오지 않는 값
				if(JobComp.getJobCompList() != null && JobComp.getJobCompList().size() !=0){
					for (int i = 0; i < JobComp.getJobCompList().size(); i++) {
						JobComp.getJobCompList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
						JobComp.getJobCompList().get(i).setFap_job_comp_ins_id(fap_comp_id);
						JobComp.getJobCompList().get(i).setFap_job_comp_udt_id(fap_comp_id);
					}
					sfaDAO.insert_job_comp(JobComp);
				}
				
				if(JobFile != null && JobFile.getJobFileList().size() !=0){
					for (int i = 0; i < JobFile.getJobFileList().size(); i++) {
						JobFile.getJobFileList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
						JobFile.getJobFileList().get(i).setFap_job_file_ins_id(fap_comp_id);
						JobFile.getJobFileList().get(i).setFap_job_file_udt_id(fap_comp_id);
					}
					sfaDAO.insert_job_file(JobFile);
				}
				
				if(JobIsr.getJobIsrList() != null && JobIsr.getJobIsrList().size() !=0){
					for (int i = 0; i < JobIsr.getJobIsrList().size(); i++) {
						JobIsr.getJobIsrList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
						JobIsr.getJobIsrList().get(i).setFap_job_isr_ins_id(fap_comp_id);
						JobIsr.getJobIsrList().get(i).setFap_job_isr_udt_id(fap_comp_id);
					}
					sfaDAO.insert_job_isr(JobIsr);
				}
				
				if(JobJoinDt != null && JobJoinDt.getJobJoinDtList().size() !=0){
					for (int i = 0; i < JobJoinDt.getJobJoinDtList().size(); i++) {
						JobJoinDt.getJobJoinDtList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
						JobJoinDt.getJobJoinDtList().get(i).setFap_job_join_dt_ins_id(fap_comp_id);
						JobJoinDt.getJobJoinDtList().get(i).setFap_job_join_dt_udt_id(fap_comp_id);
					}
					sfaDAO.insert_job_join_dt(JobJoinDt);
				}
				
				if(JobWork != null && JobWork.getJobWorkList().size() !=0){
					for (int i = 0; i < JobWork.getJobWorkList().size(); i++) {
						JobWork.getJobWorkList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
						JobWork.getJobWorkList().get(i).setFap_job_work_ins_id(fap_comp_id);
						JobWork.getJobWorkList().get(i).setFap_job_work_udt_id(fap_comp_id);
					}
					sfaDAO.insert_job_work(JobWork);
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
						sfaDAO.insert_job_category(list);
					}
					
					for (int i = 0; i < list.size(); i++) {
						if(list.get(i).getJobCategoryEtc() != null) {
							list.get(i).getJobCategoryEtc().setFap_job_category_etc_ins_id(fap_comp_id);
							list.get(i).getJobCategoryEtc().setFap_job_category_etc_udt_id(fap_comp_id);
							list.get(i).getJobCategoryEtc().setFap_job_category_seq(list.get(i).getFap_job_category_seq());
							sfaDAO.insert_job_category_etc(list.get(i).getJobCategoryEtc());
						}
					}
					
				}
				
				if(JobPref != null && JobPref.getJobPrefList().size() !=0){
					for (int i = 0; i < JobPref.getJobPrefList().size(); i++) {
						JobPref.getJobPrefList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
						JobPref.getJobPrefList().get(i).setFap_job_pref_ins_id(fap_comp_id);
						JobPref.getJobPrefList().get(i).setFap_job_pref_udt_id(fap_comp_id);
					}
					sfaDAO.insert_job_pref(JobPref);
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
					sfaDAO.insert_job_workplace(jobWorkplaceList);
					
					for(int i = 0; i < jobWorkplaceList.size(); i++) {
						if(jobWorkplaceList.get(i).getJobWorkplaceEtc() != null) {
							jobWorkplaceList.get(i).getJobWorkplaceEtc().setFap_job_workplace_etc_ins_id(fap_comp_id);
							jobWorkplaceList.get(i).getJobWorkplaceEtc().setFap_job_workplace_etc_udt_id(fap_comp_id);
							jobWorkplaceList.get(i).getJobWorkplaceEtc().setFap_job_workplace_seq(jobWorkplaceList.get(i).getFap_job_workplace_seq());
							
							sfaDAO.insert_job_workplace_etc(jobWorkplaceList.get(i).getJobWorkplaceEtc());
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
					sfaDAO.insert_job_workplace_dtl(jobWorkplaceDtlList);
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
					sfaDAO.insert_job_recruit_pcs(job_recruit_pcs_list);
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
								
								je = sfaDAO.insert_job_exam(je);	//시험 전형 등록 + seq 받아오기
								job_exam_list.add(je);			//리스트에 담기(자식테이블 등록정보를 위해서)
								
							}else if(jrp.getFap_job_recruit_pcs_gb().equals("C2502")){
								//2.면접 전형
								SocietyFapJobItv ji = jrp.getJobItv();
								ji.setFap_job_recruit_pcs_seq(jrp.getFap_job_recruit_pcs_seq());
								ji.setFap_job_itv_ins_id(fap_comp_id);
								ji.setFap_job_itv_udt_id(fap_comp_id);
								
								ji = sfaDAO.insert_job_itv(ji);
								job_itv_list.add(ji);
								
							}else if(jrp.getFap_job_recruit_pcs_gb().equals("C2503")){
								//3.기타 전형
								SocietyFapJobTestEtc jte = jrp.getJobTestEtc();
								jte.setFap_job_recruit_pcs_seq(jrp.getFap_job_recruit_pcs_seq());
								jte.setFap_job_test_etc_ins_id(fap_comp_id);
								jte.setFap_job_test_etc_udt_id(fap_comp_id);
								
								jte = sfaDAO.insert_job_test_etc(jte);
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
								sfaDAO.insert_job_exam_file(jef);
							}
						}
						
					}
					if(je.getFap_job_exam_obj().equals("C2702") && je.getJobExamObjEtc() != null){
						//1-2 시험전형 > 시험대상자(기타) 상위 테이블에서 시험대상자를 기타로 입력했을때만 등록
						SocietyFapJobExamObjEtc jeoe = je.getJobExamObjEtc();
						jeoe.setFap_job_exam_seq(je.getFap_job_exam_seq());
						jeoe.setFap_job_exam_obj_etc_ins_id(fap_comp_id);
						jeoe.setFap_job_exam_obj_etc_udt_id(fap_comp_id);
						sfaDAO.insert_job_exam_obj_etc(jeoe);
					}
					if(je.getFap_job_exam_sv().equals("C2903") && je.getJobExamSvEtc() != null){
						//1-3 시험전형 > 시험감독관(기타) 상위 테이블에서 감독관을 기타로 입력했을때만 등록
						SocietyFapJobExamSvEtc jese = je.getJobExamSvEtc();
						jese.setFap_job_exam_seq(je.getFap_job_exam_seq());
						jese.setFap_job_exam_sv_etc_ins_id(fap_comp_id);
						jese.setFap_job_exam_sv_etc_udt_id(fap_comp_id);
						sfaDAO.insert_job_exam_sv_etc(jese);
					}
					if(je.getFap_job_exam_need().equals("C3002") && je.getJobExamNeedEtc() != null){
						//1-4 시험전형 > 시험준비물(기타) 상위 테이블에서 시험준비물을 기타로 했을때만 등록
						SocietyFapJobExamNeedEtc jene = je.getJobExamNeedEtc();
						jene.setFap_job_exam_seq(je.getFap_job_exam_seq());
						jene.setFap_job_exam_need_etc_ins_id(fap_comp_id);
						jene.setFap_job_exam_need_etc_udt_id(fap_comp_id);
						sfaDAO.insert_job_exam_need_etc(jene);
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
							sfaDAO.insert_job_exam_type(job_exam_type_list);
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
						sfaDAO.insert_job_itv_tp_etc(jite);
					
					}
					if(ji.getFap_job_itv_obj().equals("C3403") && ji.getJobItvObjEtc() != null){
						//2-2 면접전형 > 면접대상자(기타) 상위테이블에서 대상자를 기타로 입력 했을때만 등록
						SocietyFapJobItvObjEtc jioe = ji.getJobItvObjEtc();
						jioe.setFap_job_itv_seq(ji.getFap_job_itv_seq());
						jioe.setFap_job_itv_obj_etc_ins_id(fap_comp_id);
						jioe.setFap_job_itv_obj_etc_udt_id(fap_comp_id);
						sfaDAO.insert_job_itv_obj_etc(jioe);
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
						sfaDAO.insert_job_test_etc_obj(jteo);
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
				
				//logger.info("페이 등록 직전 리스트 랜스 {}", job_pay_list.size());
				job_pay_list = sfaDAO.insert_job_pay(job_pay_list);	//급여 등록
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
						job_pay_base_list = sfaDAO.insert_job_pay_base(job_pay_base_list);
						jp.getJobPayBase().setJobPayBaseList(job_pay_base_list);
						
						for(SocietyFapJobPayBase jpb : job_pay_base_list){
							
							if(jpb.getFap_job_pay_base_gb().equals("C2302")){
								//기본급중 서비스 잔업 수당
								SocietyFapJobServiceWork jsw = jpb.getJobServiceWork();
								jsw.setFap_job_pay_base_seq(jpb.getFap_job_pay_base_seq());
								jsw.setFap_job_service_work_udt_id(fap_comp_id);
								jsw.setFap_job_service_work_ins_id(fap_comp_id);
								sfaDAO.insert_job_service_work(jsw);
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
								sfaDAO.insert_job_pay_etc(job_pay_etc_list);
							}
						}//for
					
					}else if(jp.getFap_job_pay_gb().equals("C2202")){
						
						//logger.info("!!!!!!!!!!!!!!!!부모시퀀스{}", jp.getFap_job_pay_seq());
						
						jp.getJobPayExtra().setFap_job_pay_seq(jp.getFap_job_pay_seq());
						jp.getJobPayExtra().setFap_job_pay_extra_ins_id(fap_comp_id);
						jp.getJobPayExtra().setFap_job_pay_extra_udt_id(fap_comp_id);
							
						sfaDAO.insert_job_pay_extra(jp.getJobPayExtra());
						
					}
				}//for
				/*************************** 채용공고 등록 끝 *******************************/
		
		logger.info("채용공고2 등록 종료");
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
		return sfaDAO.select_job_pay(fap_jop_ad_seq);
	}
	
	/**
	 * @Method Name : select_job_category
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : fap_job_ad_seq
	 * @Return : 모집직종 관련 모든 정보를 담은 map
	 * @Method 설명 : 모집직종 관련 모든 정보를 가져옵니다.
	 */
	public HashMap<String, Object> select_job_category(long fap_jop_ad_seq){
		return sfaDAO.select_job_category(fap_jop_ad_seq);
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
		logger.info("FAP 채용공고 정보, 주요 업무 정보, 업무에 필요한 능력, 우대사항 가져오기 서비스 시작");
		HashMap<String, Object> job_ideal_person = sfaDAO.select_job_ideal_person(fap_job_ad_seq);
		logger.info("FAP 채용공고 정보, 주요 업무 정보, 업무에 필요한 능력, 우대사항 가져오기 서비스 종료");
		return job_ideal_person;
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
		logger.info("FAP 채용공고 정보 가져오기 서비스 시작");
		SocietyFapJobAd jobAd = sfaDAO.select_job_ad(fap_job_ad_seq);
		logger.info("FAP 채용공고 정보 가져오기 서비스 종료");
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
		logger.info("FAP 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일 정보 가져오기 서비스 시작");
		ArrayList<HashMap<String, Object>> job_recruit_pcs = sfaDAO.select_job_recruit_pcs(fap_job_ad_seq);
		logger.info("FAP 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일 정보 가져오기 서비스 종료");
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
		logger.debug("회사 아이디 발급 여부 검색 Service 시작");
		
		String fap_comp_id = sfaDAO.select_fap_comp_id(user_id);
		
		logger.debug("회사 아이디 발급 여부 검색 Service 종료");		
		return fap_comp_id;
	}
	
	/**
	 * @return 
	 * @Method Name : job_ad_parent_update
	 * @Date : 2019.01.23
	 * @User : 이재준
	 * @Param : 
	 * @Return :
	 * @Method 설명 : 채용공고 부모테이블 업데이트
	 */
	@Transactional
	public long job_ad_parent_update(ArrayList<Long> fap_job_recruit_pcs_seq_list, SocietyFapJobAd JobAd,
			SocietyFapJobRecruitPcs JobRecruitPcs) {
		logger.debug("FAP 채용공고 부모테이블 업데이트 Service 시작");
		
		// 채용 공고 수정
		long job_ad_parent_insert_seq = sfaDAO.update_job_ad(JobAd);
		// 채용 공고에 해당하는 채용 전형 seq list를 가져옴
		ArrayList<Long> pcs_seq_list = sfaDAO.select_pcs_seq_list(JobAd.getFap_job_ad_seq());
		
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
			sfaDAO.delete_job_recruit_pcs_selective(delete_pcs);
		}		

		// 시험 전형, 면접 전형, 기타 전형 정보 삭제
		for(Long seq : fap_job_recruit_pcs_seq_list){
			sfaDAO.delete_job_recurit_pcs_sub(seq);			
		}		

		// 채용 전형 수정
		if(JobRecruitPcs.getJobRecruitPcsList() != null){
			sfaDAO.update_job_recruit_pcs(JobRecruitPcs);
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
				sfaDAO.insert_job_recruit_pcs(job_recruit_pcs_list);
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
						
						je = sfaDAO.insert_job_exam(je);	//시험 전형 등록 + seq 받아오기
						job_exam_list.add(je);			//리스트에 담기(자식테이블 등록정보를 위해서)
						
					}else if(jrp.getFap_job_recruit_pcs_gb().equals("C2502")){
						//2.면접 전형
						SocietyFapJobItv ji = jrp.getJobItv();
						ji.setFap_job_recruit_pcs_seq(jrp.getFap_job_recruit_pcs_seq());
						ji.setFap_job_itv_ins_id(fap_comp_id);
						ji.setFap_job_itv_udt_id(fap_comp_id);
						
						ji = sfaDAO.insert_job_itv(ji);
						job_itv_list.add(ji);
						
					}else if(jrp.getFap_job_recruit_pcs_gb().equals("C2503")){
						//3.기타 전형
						SocietyFapJobTestEtc jte = jrp.getJobTestEtc();
						jte.setFap_job_recruit_pcs_seq(jrp.getFap_job_recruit_pcs_seq());
						jte.setFap_job_test_etc_ins_id(fap_comp_id);
						jte.setFap_job_test_etc_udt_id(fap_comp_id);
						
						jte = sfaDAO.insert_job_test_etc(jte);
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
						sfaDAO.insert_job_exam_file(jef);
					}
				}
				
				
			}
			
			
			if(je.getJobExamObjEtc() != null){
				//1-2 시험전형 > 시험대상자(기타)
				SocietyFapJobExamObjEtc jeoe = je.getJobExamObjEtc();
				jeoe.setFap_job_exam_seq(je.getFap_job_exam_seq());
				jeoe.setFap_job_exam_obj_etc_ins_id(fap_comp_id);
				jeoe.setFap_job_exam_obj_etc_udt_id(fap_comp_id);
				sfaDAO.insert_job_exam_obj_etc(jeoe);
			}
			if(je.getJobExamSvEtc() != null){
				//1-3 시험전형 > 시험감독관(기타)
				SocietyFapJobExamSvEtc jese = je.getJobExamSvEtc();
				jese.setFap_job_exam_seq(je.getFap_job_exam_seq());
				jese.setFap_job_exam_sv_etc_ins_id(fap_comp_id);
				jese.setFap_job_exam_sv_etc_udt_id(fap_comp_id);
				sfaDAO.insert_job_exam_sv_etc(jese);
			}
			if(je.getJobExamNeedEtc() != null){
				//1-4 시험전형 > 시험준비물(기타)
				SocietyFapJobExamNeedEtc jene = je.getJobExamNeedEtc();
				jene.setFap_job_exam_seq(je.getFap_job_exam_seq());
				jene.setFap_job_exam_need_etc_ins_id(fap_comp_id);
				jene.setFap_job_exam_need_etc_udt_id(fap_comp_id);
				sfaDAO.insert_job_exam_need_etc(jene);
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
					sfaDAO.insert_job_exam_type(job_exam_type_list);
				}
				
			}
		}

		// 시험 파일 저장
		// fullPath = 채용공고 seq _ 채용전형 seq
		String fullPath = "/" + JobAd.getFap_job_ad_seq() + "_" + JobRecruitPcs.getFap_job_recruit_pcs_seq();
		if(JobRecruitPcs.getJobRecruitPcsList() != null && JobRecruitPcs.getJobRecruitPcsList().size() != 0){
			for(SocietyFapJobRecruitPcs RecruitPcs : JobRecruitPcs.getJobRecruitPcsList()){
				try{
					if(RecruitPcs.getJobExam() != null){
						if(RecruitPcs.getJobExam().getJobExamFile().getFap_job_exam_file() != null){
							RecruitPcs.getJobExam().getJobExamFile().setFap_job_exam_file_origin(RecruitPcs.getJobExam().getJobExamFile().getFap_job_exam_file().getOriginalFilename());
							RecruitPcs.getJobExam().getJobExamFile().setFap_job_exam_file_saved(FileService.saveFile(RecruitPcs.getJobExam().getJobExamFile().getFap_job_exam_file(), fapJobRecruitExamFile + fullPath));
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		for(SocietyFapJobItv ji : job_itv_list){
			if(ji.getJobItvTpEtc() != null){
				//2-1 면접전형 > 면접방식(기타)
				SocietyFapJobItvTpEtc jite = ji.getJobItvTpEtc();
				jite.setFap_job_itv_seq(ji.getFap_job_itv_seq());
				jite.setFap_job_itv_tp_etc_ins_id(fap_comp_id);
				jite.setFap_job_itv_tp_etc_udt_id(fap_comp_id);
				sfaDAO.insert_job_itv_tp_etc(jite);
			
			}
			if(ji.getJobItvObjEtc() != null){
				//2-2 면접전형 > 면접대상자(기타)
				SocietyFapJobItvObjEtc jioe = ji.getJobItvObjEtc();
				jioe.setFap_job_itv_seq(ji.getFap_job_itv_seq());
				jioe.setFap_job_itv_obj_etc_ins_id(fap_comp_id);
				jioe.setFap_job_itv_obj_etc_udt_id(fap_comp_id);
				sfaDAO.insert_job_itv_obj_etc(jioe);
			}
		}
		
		//3-1 기타전형 > 기타전형대상자(기타)
		for(SocietyFapJobTestEtc jte : job_test_etc_list){
			if(jte.getJobTestEtcObj() != null){
				SocietyFapJobTestEtcObj jteo = jte.getJobTestEtcObj();
				jteo.setFap_job_test_etc_seq(jte.getFap_job_test_etc_seq());
				jteo.setFap_job_test_etc_obj_ins_id(fap_comp_id);
				jteo.setFap_job_test_etc_obj_udt_id(fap_comp_id);
				sfaDAO.insert_job_test_etc_obj(jteo);
			}
		}
		
		logger.debug("FAP 채용공고 부모테이블 업데이트 Service 종료");
		return job_ad_parent_insert_seq;
	}
	
	/**
	 * @Method Name : delete_job_ad
	 * @Date : 2019.01.23.
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : 채용공고 삭제(sub)
	 */
	public void delete_job_ad(long fap_job_ad_seq) {
		logger.debug("채용공고 삭제(sub) Service 시작");
		sfaDAO.delete_job_ad(fap_job_ad_seq);
		logger.debug("채용공고 삭제(sub) Service 종료");
		
	}
	
	/**
	 * @Method Name : job_ad_children_insert
	 * @Date : 2019. 1. 23.
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
				logger.info("jump {}", job_file);
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
				//logger.info("empty : {}", job_file);
				boolean isDelete = FileService.deleteFile(job_file.getFap_job_file_saved(), file_path);
				//logger.info("empty : {}", isDelete);
				//이전파일 정보를 지운다.
				job_file.setFap_job_file_saved(null);
				job_file.setFap_job_file_origin(null);
				
				job_file_list.add(job_file);
				
			}else{
				//있던파일 삭제후 새로 등록 (들어있는 input file) 삭제후 등록)
				logger.info("not empty");
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
		sfaDAO.insert_job_dorm(JobDorm);
		}
		
		//계약사원 (C0401:모집형태 계약사원)
		if(JobAd.getFap_job_ad_hire_type() != null && JobAd.getFap_job_ad_hire_type().equals("C0401")){
		JobJitEmployee.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
		sfaDAO.insert_job_jit_employee(JobJitEmployee);
		}
		
		//업무에 필요한 일본어 능력 03.13 수정(원병호)
		if( !JobJaLevel.getFap_job_ja_level_dtl().equals("") || JobJaLevel.getFap_job_ja_level_gb() != null){
		JobJaLevel.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
		sfaDAO.insert_job_ja_level(JobJaLevel);
		}
		
		//시용기간 (C0500:시용기간 있음)
		if(JobAd.getFap_job_ad_intern() != null && JobAd.getFap_job_ad_intern().equals("C0500")){
		JobTrial.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());	
		sfaDAO.insert_job_trial(JobTrial);
		}
		
		if(JobComp.getJobCompList().size() !=0){
			for (int i = 0; i < JobComp.getJobCompList().size(); i++) {
				JobComp.getJobCompList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobComp.getJobCompList().get(i).setFap_job_comp_ins_id(fap_comp_id);
				JobComp.getJobCompList().get(i).setFap_job_comp_udt_id(fap_comp_id);
			}
			sfaDAO.insert_job_comp(JobComp);
		}
		if(JobFile.getJobFileList().size() !=0){
			for (int i = 0; i < JobFile.getJobFileList().size(); i++) {
				JobFile.getJobFileList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobFile.getJobFileList().get(i).setFap_job_file_ins_id(fap_comp_id);
				JobFile.getJobFileList().get(i).setFap_job_file_udt_id(fap_comp_id);
			}
			sfaDAO.insert_job_file(JobFile);
		}
		if(JobIsr.getJobIsrList() != null){
			if(JobIsr.getJobIsrList().size() !=0){
				for (int i = 0; i < JobIsr.getJobIsrList().size(); i++) {
					JobIsr.getJobIsrList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
					JobIsr.getJobIsrList().get(i).setFap_job_isr_ins_id(fap_comp_id);
					JobIsr.getJobIsrList().get(i).setFap_job_isr_udt_id(fap_comp_id);
				}
				sfaDAO.insert_job_isr(JobIsr);
			}
		}
		if(JobJoinDt.getJobJoinDtList().size() !=0){
			for (int i = 0; i < JobJoinDt.getJobJoinDtList().size(); i++) {
				JobJoinDt.getJobJoinDtList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobJoinDt.getJobJoinDtList().get(i).setFap_job_join_dt_ins_id(fap_comp_id);
				JobJoinDt.getJobJoinDtList().get(i).setFap_job_join_dt_udt_id(fap_comp_id);
			}
			sfaDAO.insert_job_join_dt(JobJoinDt);
		}
		if(JobWork.getJobWorkList().size() !=0){
			for (int i = 0; i < JobWork.getJobWorkList().size(); i++) {
				JobWork.getJobWorkList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobWork.getJobWorkList().get(i).setFap_job_work_ins_id(fap_comp_id);
				JobWork.getJobWorkList().get(i).setFap_job_work_udt_id(fap_comp_id);
			}
			sfaDAO.insert_job_work(JobWork);
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
				sfaDAO.insert_job_category(list);
			}
			//그 외 모집직종
			for (int i = 0; i < list.size(); i++) {
				if(list.get(i).getJobCategoryEtc() != null) {
					list.get(i).getJobCategoryEtc().setFap_job_category_etc_ins_id(fap_comp_id);
					list.get(i).getJobCategoryEtc().setFap_job_category_etc_udt_id(fap_comp_id);
					list.get(i).getJobCategoryEtc().setFap_job_category_seq(list.get(i).getFap_job_category_seq());
					sfaDAO.insert_job_category_etc(list.get(i).getJobCategoryEtc());
				}
			}
			
		}
		if(JobPref.getJobPrefList().size() !=0){
			for (int i = 0; i < JobPref.getJobPrefList().size(); i++) {
				JobPref.getJobPrefList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobPref.getJobPrefList().get(i).setFap_job_pref_ins_id(fap_comp_id);
				JobPref.getJobPrefList().get(i).setFap_job_pref_udt_id(fap_comp_id);
			}
			sfaDAO.insert_job_pref(JobPref);
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
			sfaDAO.insert_job_workplace(jobWorkplaceList);
			
			for(int i = 0; i < jobWorkplaceList.size(); i++) {
				if(jobWorkplaceList.get(i).getJobWorkplaceEtc() != null) {
					jobWorkplaceList.get(i).getJobWorkplaceEtc().setFap_job_workplace_etc_ins_id(fap_comp_id);
					jobWorkplaceList.get(i).getJobWorkplaceEtc().setFap_job_workplace_etc_udt_id(fap_comp_id);
					jobWorkplaceList.get(i).getJobWorkplaceEtc().setFap_job_workplace_seq(jobWorkplaceList.get(i).getFap_job_workplace_seq());
					
					sfaDAO.insert_job_workplace_etc(jobWorkplaceList.get(i).getJobWorkplaceEtc());
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
			sfaDAO.insert_job_workplace_dtl(jobWorkplaceDtlList);
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
			
			job_pay_list = sfaDAO.insert_job_pay(job_pay_list);	//급여 등록
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
					job_pay_base_list = sfaDAO.insert_job_pay_base(job_pay_base_list);
					jp.getJobPayBase().setJobPayBaseList(job_pay_base_list);
					
					for(SocietyFapJobPayBase jpb : job_pay_base_list){
						
						if(jpb.getFap_job_pay_base_gb().equals("C2302")){
							//기본급중 서비스 잔업 수당
							SocietyFapJobServiceWork jsw = jpb.getJobServiceWork();
							jsw.setFap_job_pay_base_seq(jpb.getFap_job_pay_base_seq());
							jsw.setFap_job_service_work_udt_id(fap_comp_id);
							jsw.setFap_job_service_work_ins_id(fap_comp_id);
							sfaDAO.insert_job_service_work(jsw);
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
								sfaDAO.insert_job_pay_etc(job_pay_etc_list);
							}
						}
					}//for
				
				}else if(jp.getFap_job_pay_gb().equals("C2202")){
					
					//logger.info("!!!!!!!!!!!!!!!!부모시퀀스{}", jp.getFap_job_pay_seq());
					jp.getJobPayExtra().setFap_job_pay_seq(jp.getFap_job_pay_seq());
					jp.getJobPayExtra().setFap_job_pay_extra_ins_id(fap_comp_id);
					jp.getJobPayExtra().setFap_job_pay_extra_udt_id(fap_comp_id);
						
					sfaDAO.insert_job_pay_extra(jp.getJobPayExtra());
					
				}
			}//for
			//급여등록 끝 (원병호)
			logger.info("채용공고 chidren 수정 Service 끝");
					
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
		logger.info("FAP 채용전형 수정 가능 여부 확인 서비스 시작");
		int editable_check = sfaDAO.editable_check(fap_job_recruit_pcs_seq);
		logger.info("FAP 채용전형 수정 가능 여부 확인 서비스 종료");
		return editable_check;
	}
	
	public ArrayList<HashMap<String, Object>> select_agency_management_company_list(){
		
		ArrayList<HashMap<String, Object>> select_agency_management_company_list = sfaDAO.select_agency_management_company_list();
		
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
		logger.info("FAP 에이전시 소속기업 정보 가져오기 서비스 시작");
		SocietyFapCompanyUser societyFapCompanyUser = sfaDAO.select_agency_comp(fap_comp_id);
		logger.info("FAP 에이전시 소속기업 정보 가져오기 서비스 종료");
		return societyFapCompanyUser;
	}
	
	/**
	 * @Method Name : select_job_ad_by_state
	 * @Date : 2019. 2. 7.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMapList
	 * @Method 설명 : 분류된 채용공고 리스트 가져오는 함수(fap_job_ad_state에 의한)
	 */
	public ArrayList<HashMap<String, Object>> select_job_ad_by_state(HashMap<String, Object> parmas){
		logger.debug("FAP 분류된 채용공고 리스트 출력 Service 시작");
		ArrayList<HashMap<String, Object>> result = sfaDAO.select_job_ad_by_state(parmas);
		logger.debug("FAP 분류된 채용공고 리스트 출력 Service 시작");
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
		logger.info("FAP 채용공고 상태를 수정하는 서비스 시작");
		int result = sfaDAO.update_job_ad_state(jobAd);
		logger.info("FAP 채용공고 상태를 수정하는 서비스 끝");
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
		logger.debug("FAP 에이전시 에이전시 관리 회사들 목록 요청 Service 시작");
		ArrayList<HashMap<String, Object>> agencyCompanyInfoList = sfaDAO.select_participate_possible_company_list(param);
		logger.debug("FAP 에이전시 에이전시 관리 회사들 목록 요청 Service 종료");
		return agencyCompanyInfoList;
	}
	
	/**
	 * @Method Name : insert_company_jobfair_join_table
	 * @Date : 2019. 2. 8.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 에이전시 에이전시 관리 회사 잡페어 참가 요청
	 */
	public String insert_company_jobfair_join_table(HashMap<String, Object> insertCompanyInfo){
		logger.debug("FAP 에이전시 에이전시 관리 회사 잡페어 참가 등록 Service 시작");
		int insertResult = sfaDAO.insert_company_jobfair_join_table(insertCompanyInfo);
		String message = (insertResult > 0) ? "insertSuccess" : "insertFail";
		logger.debug("FAP 에이전시 에이전시 관리 회사 잡페어 참가 등록 Service 끝");
		return message;
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
		logger.debug("FAP 에이전시 해당 잡페어에 참가할 회사목록 셀렉트 Service 시작");
		ArrayList<HashMap<String, Object>> attendCompanyInfoList = sfaDAO.select_jobfair_attended_company_list(param);
		logger.debug("FAP 에이전시 해당 잡페어에 참가할 회사목록 셀렉트 Service 종료");
		return attendCompanyInfoList;
	}
	
	/**
	 * @Method Name : select_company_of_parameter_comp_id
	 * @Date : 2019. 2. 8.
	 * @User : 정대영
	 * @Param : 선택된 회사 아이디
	 * @Return : 기업 객체
	 * @Method 설명 : FAP 에이전시 담당자 가지고 있는 기업 객체를 가져오는 함수(파라미터 선택된 회사 아이디로)
	 */
	public SocietyFapCompanyUser select_company_of_parameter_comp_id(String chosen_fap_comp_id){
		logger.info("FAP 에이전시 정보 가져오기(파라미터 선택된 회사 아이디로) 서비스 시작");
		SocietyFapCompanyUser societyFapCompanyUser = sfaDAO.select_company_of_parameter_comp_id(chosen_fap_comp_id);
		logger.info("FAP 에이전시 정보 가져오기(파라미터 선택된 회사 아이디로) 서비스 종료");
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
		logger.debug("FAP 에이전시 회사아이디로 회사명 요청 Service 시작");
		String chosen_fap_comp_ja_nm = sfaDAO.select_company_name(chosen_fap_comp_id);
		logger.debug("FAP 에이전시 회사아이디로 회사명 요청 Service 끝");
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
		ArrayList<HashMap<String, Object>> select_job_ad_load_list = sfaDAO.select_job_ad_load_list_paging(paramMap, start, countPerPage);
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
		int adTotalCount = sfaDAO.select_job_ad_load_list_count(paramMap);
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
		logger.info("FAP 채용공고 삭제 서비스 시작");
		
		//서버에 저장된 파일 삭제	
		ArrayList<SocietyFapJobFile> file_list = sfaDAO.select_job_file(fap_job_ad_seq);
		
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
		ArrayList<SocietyFapJobExamFile> exam_file_list = sfaDAO.select_job_exam_file(fap_job_ad_seq);
		
		for(SocietyFapJobExamFile exam_file : exam_file_list){
			/*file path에 recruit_pcs_seq가 필요하므로, 편의상 exam_seq에 담아옴*/
			// path : / + fap_job_ad_seq + _ + fap_job_recruit_pcs_seq
			String path = "/" + fap_job_ad_seq + "_" + exam_file.getFap_job_exam_seq();
			String fullPath = fapJobRecruitExamFile + path;
			FileService.deleteFile(exam_file.getFap_job_exam_file_saved(), fullPath);
		}
		
		
		//시험전형 파일 삭제
		int result = sfaDAO.delete_job_ad_box(fap_job_ad_seq);
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
		for(SocietyFapJobFile job_file : sfaDAO.select_job_file(fap_job_ad_seq)){
			job_file.setFile_path(find_job_file_path(job_file.getFap_job_file_gb()));
			result.add(job_file);
		}
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
		logger.info("FAP 회사가 참가한 잡페어 리스트 검색 Service 시작");
		ArrayList<HashMap<String, Object>> result = sfaDAO.select_agency_jobfair_list(fap_comp_id);
		logger.info("FAP 회사가 참가한 잡페어 리스트 검색 Service 끝");
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
		logger.info("FAP 회사가 참가한 잡페어 세부 리스트 검색 Servie 시작");
		ArrayList<HashMap<String, Object>> result = sfaDAO.select_company_jobfair_divide_list(params);
		logger.info("FAP 회사가 참가한 잡페어 세부 리스트 검색 Servie 끝");
		return result;
	}
	
}
