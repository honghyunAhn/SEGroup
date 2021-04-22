/**
 * 
 */
package global.segroup.society.fap.user.service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import javax.mail.MessagingException;

import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import global.segroup.dao.SEGroupCommonDAO;
import global.segroup.domain.BoardContent;
import global.segroup.domain.CertificationCode;
import global.segroup.domain.User;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminFinalDecisionTime;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenPt;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenPtApply;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenPtResume;
import global.segroup.society.fap.admincommon.domain.SocietyFapPopup;
import global.segroup.society.fap.company.domain.SocietyFapPersonalRequiredDoc;
import global.segroup.society.fap.user.dao.SocietyFapUserDAO;
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
import global.segroup.util.FileService;
import global.segroup.util.MailService;

/**
 * @Author : 신동철
 * @Date : 2018. 11. 29.
 * @Class 설명 : Soft Engineer Society 통합잡페어 지원자 서비스
 * 
 */
@Service
public class SocietyFapUserService {

	private static final Logger logger = LoggerFactory.getLogger(SocietyFapUserService.class);

	/**
	 * 공통 기능 관련 DAO
	 */
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
	
	@Value("#{props['fap.user.resume_photo_image']}")
	private String fapResumePhotoImage;
	@Value("#{props['fap.user.resume_movie_file']}")
	private String fapMovieFile;
	@Value("#{props['fap.user.resume_portfolio_file']}")
	private String fapPortfolioFile;
	@Value("#{props['fap.user.resume_project_file']}")
	private String fapProjectFile;
	@Value("#{props['fap.company.required_doc_file']}")
	private String fapCompanyRequiredDocFile;
	
	/**
	 * @Method Name : select_com_user
	 * @Date : 2019. 2. 27.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 유저 객체
	 * @Method 설명 : 특정 유저의 정보를 가져오는 함수
	 */
	public User select_com_user(String user_id){
		logger.debug("유저 정보 가져오기 서비스 시작");
		User user = sfuDAO.select_com_user(user_id);
		logger.debug("유저 정보 가져오기 서비스 종료");
		return user;
	}
	
	/**
	 * @Method Name : UploadPortfolioServer
	 * @Date : 2018. 12. 16.
	 * @User : 남유송
	 * @Param : 이력서 파일 정보
	 * @Return : -
	 * @Method 설명 : 이력서 포트폴리오 파일을 저장
	 */
	private void UploadPortfolioServer(SocietyFapUserResumeFile resumeFile) {
		logger.info("FAP 이력서 포트폴리오 파일 등록 시작");
		try {
			if (resumeFile.getFap_resume_file() != null) {
				resumeFile.setFap_resume_file_origin(resumeFile.getFap_resume_file().getOriginalFilename());
				resumeFile.setFap_resume_file_saved(FileService.saveFile(resumeFile.getFap_resume_file(), fapPortfolioFile));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		logger.info("FAP 이력서 포트폴리오 파일 등록 종료");
	}

	/**
	 * @Method Name : UploadMovieServer
	 * @Date : 2018. 12. 16.
	 * @User : 남유송
	 * @Param : 이력서 파일 정보
	 * @Return : -
	 * @Method 설명 : 이력서 동영상 파일을 저장
	 */
	private void UploadMovieServer(SocietyFapUserResumeFile resumeFile) {
		logger.info("FAP 이력서 동영상 파일 등록 시작");
		try {
			if (resumeFile.getFap_resume_file() != null) {
				resumeFile.setFap_resume_file_origin(resumeFile.getFap_resume_file().getOriginalFilename());
				resumeFile.setFap_resume_file_saved(FileService.saveFile(resumeFile.getFap_resume_file(), fapMovieFile));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		logger.info("FAP 이력서 동영상 파일 등록 종료");
	}
	
	/**
	 * @Method Name : UploadProjectServer
	 * @Date : 2018. 12. 16.
	 * @User : 남유송
	 * @Param : 이력서 파일 정보
	 * @Return : -
	 * @Method 설명 : 이력서 프로젝트 영상 파일을 저장
	 */
	private void UploadProjectServer(SocietyFapUserResumeFile resumeFile) {
		logger.info("FAP 이력서 프로젝트 영상 파일 등록 시작");
		try {
			if (resumeFile.getFap_resume_file() != null) {
				resumeFile.setFap_resume_file_origin(resumeFile.getFap_resume_file().getOriginalFilename());
				resumeFile.setFap_resume_file_saved(FileService.saveFile(resumeFile.getFap_resume_file(), fapProjectFile));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		logger.info("FAP 이력서 프로젝트 영상 파일 등록 종료");
	}

	/**
	 * @Method Name : UploadFileServer
	 * @Date : 2018. 12. 14.
	 * @User : 남유송
	 * @Param : 이력서 기본 정보 객체
	 * @Return : -
	 * @Method 설명 : 이력서 등록시 사진 파일을 서버에 저장하는 함수
	 */
	private void UploadFileServer(SocietyFapUserResumeForm resumeForm) {
		logger.info("FAP 이력서 사진 등록 시작");
		try {
			if (resumeForm.getFap_resume_pic() != null) {
				resumeForm.setFap_resume_pic_origin(resumeForm.getFap_resume_pic().getOriginalFilename());
				resumeForm.setFap_resume_pic_saved(FileService.saveFile(resumeForm.getFap_resume_pic(), fapResumePhotoImage));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		logger.info("FAP 이력서 사진 등록 종료");
	}
	/**
	 * @Method Name : resume_parent_insert
	 * @Date : 2018. 01. 09.
	 * @User : 남유송
	 * @Param : 이력서 정보(기본정보)
	 * @Return : JSP 리턴페이지
	 * @Method 설명 : 사용자로부터 입력받은 정보로 이력서를 생성하고 이력서 관리 페이지로 이동하는 method
	 */
	public long resume_parent_insert(SocietyFapUserResumeForm resumeForm) {
		
		String temp_resume_birth = resumeForm.getFap_resume_birth();
		temp_resume_birth = temp_resume_birth.replace(",",".");
		resumeForm.setFap_resume_birth(temp_resume_birth);
		UploadFileServer(resumeForm);
		long resume_parent_insert_seq = sfuDAO.resume_parent_insert(resumeForm);
		return resume_parent_insert_seq;
	}
	
	/**
	 * @Method Name : resume_insert
	 * @Date : 2018. 12. 11.
	 * @User : 남유송
	 * @Param : 이력서 정보(기본정보, 학력/관련 교육이수, 사회 경력, 프로젝트 개발 경력, 자격, 역량/재능, PR, 포트폴리오 파일)
	 * @Return : -
	 * @Method 설명 : 이력서 정보 입력
	 */
	@Transactional
	public void resume_insert(SocietyFapUserResumeForm resumeForm, SocietyFapUserResumeEduhistory resumeEduHistory, 
			SocietyFapUserResumeLicense resumeLicense, SocietyFapUserResumeCareer resumeCareer, SocietyFapUserResumeProject resumeProject
			, SocietyFapUserResumeTalent resumeTalent, SocietyFapUserResumeProfile resumeProfile, SocietyFapUserResumeAddr resumeAddr, 
			SocietyFapUserResumeName resumeName, SocietyFapUserResumeFile resumeFile) {
		logger.debug("이력서 등록 시작");
		
		if(resumeEduHistory.getResumeEduList() != null) {
			for (int i = 0; i < resumeEduHistory.getResumeEduList().size(); i++) {
				if (resumeEduHistory.getResumeEduList().get(i).getFap_resume_edu_er_dt().length() < 1) {
					resumeEduHistory.getResumeEduList().get(i).setFap_resume_edu_er_dt(null);
				}
				if(resumeEduHistory.getResumeEduList().get(i).getFap_resume_edu_gd_dt().length() < 1){
					resumeEduHistory.getResumeEduList().get(i).setFap_resume_edu_gd_dt(null);
				}
			}
		}
		
		if(resumeCareer.getResumeCareerList() != null) {
			for (int i = 0; i < resumeCareer.getResumeCareerList().size(); i++) {
				if (resumeCareer.getResumeCareerList().get(i).getFap_resume_crr_st().length() < 1) {
					resumeCareer.getResumeCareerList().get(i).setFap_resume_crr_st(null);
				}
				if(resumeCareer.getResumeCareerList().get(i).getFap_resume_crr_et().length() < 1){
					resumeCareer.getResumeCareerList().get(i).setFap_resume_crr_et(null);;
				}
			}
		}
		
		if(resumeProject.getResumeProjectList() != null) {
			for (int i = 0; i < resumeProject.getResumeProjectList().size(); i++) {
				if (resumeProject.getResumeProjectList().get(i).getFap_resume_project_st().length() < 1) {
					resumeProject.getResumeProjectList().get(i).setFap_resume_project_st(null);
				}
				if(resumeProject.getResumeProjectList().get(i).getFap_resume_project_et().length() < 1){
					resumeProject.getResumeProjectList().get(i).setFap_resume_project_et(null);
				}
			}
		}
	
		//동영상 파일이 있을 때
		if (resumeFile.getResumeFileList().get(0).getFap_resume_file() != null &&
				!resumeFile.getResumeFileList().get(0).getFap_resume_file().isEmpty()) {
			//동영상 파일이 있을 때 전에 파일을 삭제시켜주는 부분
			if(resumeFile.getResumeFileList().get(0).getFap_resume_file_saved() != null){
				FileService.deleteFile(resumeFile.getResumeFileList().get(0).getFap_resume_file_saved(), fapMovieFile);
				resumeFile.getResumeFileList().get(0).setFap_resume_file_saved(null);
				resumeFile.getResumeFileList().get(0).setFap_resume_file_origin(null);
			}
			UploadMovieServer(resumeFile.getResumeFileList().get(0));
		}
		//원래는 동영상 파일이 있었으나 유저가 삭제했을 때
		else {
			if(resumeFile.getResumeFileList().get(0).getFap_resume_file_saved() != null 
					&& resumeFile.getResumeFileList().get(0).getFap_resume_file_origin() == null){
				boolean isDelete = FileService.deleteFile(resumeFile.getResumeFileList().get(0).getFap_resume_file_saved(), fapMovieFile);
				if(isDelete == true) {
					resumeFile.getResumeFileList().get(0).setFap_resume_file_saved(null);
				}
			}
		}
		//포트폴리오 파일이 있을 때 
		if(resumeFile.getResumeFileList().get(1).getFap_resume_file() != null &&
				!resumeFile.getResumeFileList().get(1).getFap_resume_file().isEmpty()){
			//포트폴리오 파일이 있을 때 전에 파일을 삭제시켜주는 부분
			if(resumeFile.getResumeFileList().get(1).getFap_resume_file_saved() != null){
				FileService.deleteFile(resumeFile.getResumeFileList().get(1).getFap_resume_file_saved(), fapPortfolioFile);
				resumeFile.getResumeFileList().get(1).setFap_resume_file_saved(null);
				resumeFile.getResumeFileList().get(1).setFap_resume_file_origin(null);
			}
			UploadPortfolioServer(resumeFile.getResumeFileList().get(1));
		}
		//원래는 포트폴리오 파일이 있었으나 유저가 삭제했을 때
		else {
			if(resumeFile.getResumeFileList().get(1).getFap_resume_file_saved() != null && 
					resumeFile.getResumeFileList().get(1).getFap_resume_file_origin() == null){
			   boolean isDelete = FileService.deleteFile(resumeFile.getResumeFileList().get(1).getFap_resume_file_saved(), fapPortfolioFile);
			   if(isDelete == true){
				   resumeFile.getResumeFileList().get(1).setFap_resume_file_saved(null);
			   }
			}
		}
		//프로젝트 영상 파일이 있을 때
		if (resumeFile.getResumeFileList().get(2).getFap_resume_file() != null &&
				!resumeFile.getResumeFileList().get(2).getFap_resume_file().isEmpty()) {
			//프로젝트 영상이 있을 때 전에 파일을 삭제시켜주는 부분
			if(resumeFile.getResumeFileList().get(2).getFap_resume_file_saved() != null){
				FileService.deleteFile(resumeFile.getResumeFileList().get(2).getFap_resume_file_saved(), fapProjectFile);
				resumeFile.getResumeFileList().get(2).setFap_resume_file_saved(null);
				resumeFile.getResumeFileList().get(2).setFap_resume_file_origin(null);
			}
			UploadProjectServer(resumeFile.getResumeFileList().get(2));
		}
		//원래는 프로젝트 영상이 있었으나 유저가 삭제했을 때
		else {
			if(resumeFile.getResumeFileList().get(2).getFap_resume_file_saved() != null 
					&& resumeFile.getResumeFileList().get(2).getFap_resume_file_origin() == null){
				boolean isDelete = FileService.deleteFile(resumeFile.getResumeFileList().get(2).getFap_resume_file_saved(), fapProjectFile);
				if(isDelete == true) {
					resumeFile.getResumeFileList().get(2).setFap_resume_file_saved(null);
				}
			}
		}
		
		sfuDAO.insert_resume(resumeForm, resumeEduHistory, 
				resumeLicense, resumeCareer, resumeProject
				, resumeTalent, resumeProfile, resumeAddr,  resumeName, resumeFile);
		logger.debug("이력서 등록 종료");
	}
	
	/**
	 * @Method Name : user_id_check
	 * @Date : 2018. 12. 12.
	 * @User : 김준영
	 * @Param : 유저가 입력한 아이디
	 * @Return : 일치하는 아이디 or null
	 * @Method 설명 : 유저가 입력한 아이디가 중복되는지 확인하는 함수
	 */
	public String user_id_check(String user_id){
		logger.debug("유저 아이디 중복 체크 서비스 시작");
		String user_id_check = sfuDAO.user_id_check(user_id);
		logger.debug("유저 아이디 중복 체크 서비스 종료");
		return user_id_check;
	}
	
	/**
	 * @Method Name : insert_com_user
	 * @Date : 2018. 12. 12.
	 * @User : 김준영
	 * @Param : 유저 객체
	 * @Return : -
	 * @Method 설명 : 유저 공통 정보를 등록을 하는 함수 
	 */
	/*public void insert_com_user(User user){
		logger.info("유저 공통 정보 등록 서비스 시작");
		sfuDAO.insert_com_user(user);
		logger.info("유저 공통 정보 등록 서비스 종료");
	}*/
	
	/**
	 * @Method Name : insert_user
	 * @Date : 2018. 12. 14.
	 * @User : 김준영
	 * @Param : 일반 회원 가입 객체
	 * @Return : -
	 * @Method 설명 : 일반 회원의 회원 가입을 하는 함수
	 */
	@Transactional
	public void insert_user(User user, SocietyFapPersonalUser sfpUser, 
			SocietyFapPersonalHighschool sfpHighschool, 
			SocietyFapPersonalUniversity sfpUniversity, 
			SocietyFapPersonalGraduate sfpGraduate){
		logger.info("일반 회원 회원 가입 서비스 시작");
		sfuDAO.insert_user(user, sfpUser, sfpHighschool, sfpUniversity, sfpGraduate);
		logger.info("일반 회원 회원 가입 서비스 종료");
	}
	
	/**
	 * @Method Name : select_personal_user
	 * @Date : 2018. 12. 14.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 개인 유저 객체
	 * @Method 설명 : 개인 유저 객체를 불러오는 함수
	 */
	public SocietyFapPersonalUser select_personal_user(String user_id){
		logger.info("FAP 개인 유저 객체 가져오기 서비스 시작");
		SocietyFapPersonalUser aocietyFapPersonalUser = sfuDAO.select_personal_user(user_id);
		logger.info("FAP 개인 유저 객체 가져오기 서비스 종료");
		return aocietyFapPersonalUser;
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
		logger.info("FAP 개인 유저 학교 객체 가져오기 서비스 시작");
		HashMap<String, Object> hashmap = sfuDAO.select_personal_school(societyFapPersonalUser);
		logger.info("FAP 개인 유저 학교 객체 가져오기 서비스 종료");
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
		logger.debug("FAP 통합잡페어 정보 리스트 출력 Service 시작");
		ArrayList<HashMap<String, Object>> jobfairInfoList = sfuDAO.select_fap_user_jobfair_info_list();
		ArrayList<Integer> jobfairSeqList = new ArrayList<>();
		for(HashMap<String, Object> jobfairInfo : jobfairInfoList){
			jobfairSeqList.add((Integer) jobfairInfo.get("fap_jobfair_seq"));
		}
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("jobfairSeqList", jobfairSeqList);
		ArrayList<HashMap<String, Object>> tempJobfairLocationList = sfuDAO.select_fap_user_jobfair_location_list(params);
		
		for(HashMap<String, Object> jobfairInfo : jobfairInfoList){
			ArrayList<String> jobfairLoList = new ArrayList<>();
			for(HashMap<String, Object> tempJobfairLocation : tempJobfairLocationList){
				if((int) jobfairInfo.get("fap_jobfair_seq") == (int) tempJobfairLocation.get("fap_jobfair_seq")){
					jobfairLoList.add((String) tempJobfairLocation.get("fap_jobfair_lo"));
				}
			}
			jobfairInfo.put("jobfairLoList", jobfairLoList);
		}
		logger.debug("FAP 통합잡페어  정보 리스트 출력 Service 종료");
		return jobfairInfoList;
	}
	
	/**
	 * @Method Name : user_jobfair_entry_request
	 * @Date : 2018. 12. 10.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : -
	 * @Method 설명 : FAP 취업지원자 잡페어 신청 메소드
	 */
	public int  user_jobfair_entry_request(HashMap<String, Object> map){
		logger.debug("FAP 취업지원자 잡페어 신청 Service 시작");
		int result = sfuDAO.user_jobfair_entry_request(map);
		logger.debug("FAP 취업지원자 잡페어 신청 Service 종료");
		return result; 
	}
	
	/**
	 * @Method Name : select_jobfair_job_advertisement_list
	 * @Date : 2018. 12. 13.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 채용공고 리스트 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_jobfair_job_advertisement_list(HashMap<String, Object> params, RowBounds rw){
		logger.debug("FAP 취업지원자 채용공고 리스트 셀렉트 Service 시작");
		ArrayList<HashMap<String, Object>> jobAdvertisementList = sfuDAO.select_jobfair_job_advertisement_list(params, rw);
		if(jobAdvertisementList.size() < 1){return jobAdvertisementList;}
		ArrayList<Long> curJobAdSeqList = new ArrayList<>();
		for(HashMap<String, Object> jobAdvertisement : jobAdvertisementList){
			curJobAdSeqList.add((Long) jobAdvertisement.get("fap_job_ad_seq"));
		}
		ArrayList<HashMap<String, Object>> categoryAndWorkplaceList = sfuDAO.select_category_and_workplace_list(curJobAdSeqList);
		for(HashMap<String, Object> jobAdvertisement : jobAdvertisementList){
			Long parent_fap_job_ad_seq = (Long) jobAdvertisement.get("fap_job_ad_seq");
			ArrayList<String> categoryList = new ArrayList<>();
			ArrayList<String> workPlaceList = new ArrayList<>();
			for(HashMap<String, Object> categoryAndWorkplace : categoryAndWorkplaceList){
				Long children_fap_job_ad_seq = (Long) categoryAndWorkplace.get("fap_job_ad_seq");
				if(parent_fap_job_ad_seq.compareTo(children_fap_job_ad_seq) == 0){
					String category_workplace_gb = (String) categoryAndWorkplace.get("category_workplace_gb");
					if(category_workplace_gb.charAt(2) == '7'){
						categoryList.add(category_workplace_gb);
					}else{
						workPlaceList.add(category_workplace_gb);
					}
				}
			}
			jobAdvertisement.put("categoryList", categoryList);
			jobAdvertisement.put("workPlaceList", workPlaceList);
		}
		logger.debug("FAP 취업지원자 채용공고 리스트 셀렉트 Service 종료");
		return jobAdvertisementList;
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
		logger.debug("FAP 취업지원자 채용공고 리스트 총 개수 셀렉트 Service 시작");
		int adTotalCount = sfuDAO.select_jobfair_job_advertisement_list_count(paramMap);
		logger.debug("FAP 취업지원자 채용공고 리스트 총 개수 셀렉트 Service 종료");
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
		logger.debug("FAP 취업지원자 잡페어별 그룹코드 셀렉트 Service 시작");
		ArrayList<HashMap<String, Object>> companyGroupCodeList = sfuDAO.select_company_group_code_list(fapJobAdvertisement);
		logger.debug("FAP 취업지원자 잡페어별 그룹코드 셀렉트 Service 종료");
		return companyGroupCodeList;
	}
	
	/**
	 * @Method Name : insert_my_favorite_company
	 * @Date : 2018. 12. 14.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 취업지원자 내가담은기업 목록 인서트
	 */
	public String insert_my_favorite_company(HashMap<String, Object> fapMyFavoriteCompany){
		logger.debug("FAP 취업지원자 내가담은기업 인서트 Service 시작");
		String message = null;
		//인서트 전 기업담기목록에 중복된 기업이 있는지 검사
		String isDuplicate = sfuDAO.my_favorite_company_check(fapMyFavoriteCompany);
		if(isDuplicate != null){
			message = "insertDuplicate";
		} else{
			//중복이 안되있다면 인서트 실행
			int insertResult = sfuDAO.insert_my_favorite_company(fapMyFavoriteCompany);
			message = (insertResult == 1) ? "insertSuccess" : "insertFail";
		}	
		logger.debug("FAP 취업지원자 내가담은기업 인서트 Service 종료");
		return message;
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
		logger.debug("FAP 취업지원자 내가담은기업 리스트 출력 Service 시작");
		ArrayList<HashMap<String, Object>> favoriteCompanyList = sfuDAO.select_my_favorite_company_list(params);
		logger.debug("FAP 취업지원자 내가담은기업 리스트 출력 Service 종료");
		return favoriteCompanyList;
	}

	/**
	 * @Method Name : user_update_form
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 회원 공통 객체, 개인 객체, 학교 정보 객체
	 * @Return : -
	 * @Method 설명 : 회원 정보를 수정하는 함수로서, 기존 최종 학력과 수정된 최종 학력을 비교하여 수정, 등록, 삭제를 진행
	 */
	public void user_update_form(User user, SocietyFapPersonalUser sfpUser, 
			SocietyFapPersonalHighschool sfpHighschool, 
			SocietyFapPersonalUniversity sfpUniversity,
			SocietyFapPersonalGraduate sfpGraduate){
		logger.info("회원 정보 수정 서비스 시작");
		sfuDAO.update_user(user, sfpUser, sfpHighschool, sfpUniversity, sfpGraduate);
		logger.info("회원 정보 수정 서비스 종료");
	}
	
	/**
	 * @Method Name : delete_my_favorite_company
	 * @Date : 2018. 12. 17.
	 * @User : 정대영
	 * @Param : SocietyFapUserMyFavoriteCompany
	 * @Return : String
	 * @Method 설명 : FAP 내가담은목록에서 기업삭제
	 */
	public String delete_my_favorite_company_list(HashMap<String, Object> deleteMyFavoriteCompany){
		logger.debug("FAP 내가담은목록에서 기업 삭제 Service 시작");
		String message = null;
		int result = sfuDAO.delete_my_favorite_company_list(deleteMyFavoriteCompany);
		if(result == 0){
			message = "deleteError";
		}else if(result == 1 && Long.parseLong((String) deleteMyFavoriteCompany.get("fap_fav_comp_seq")) != 0){
			message = "deleteOne";
		}else {
			message = "deleteAll";
		}
		logger.debug("FAP 내가담은목록에서 기업 삭제 Service 종료");
		return message;
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
		logger.debug("FAP 이력서 기본 정보 리스트 출력 Service 시작");
		ArrayList<HashMap<String, Object>> resumeFormList = sfuDAO.select_my_resume_list(user_id);
		logger.debug("FAP 이력서 기본 정보 리스트 출력 Service 종료");
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
		logger.debug("지원페이지에서 이력서 리스트 출력 서비스 시작");
		ArrayList<HashMap<String, Object>> resumeFormList = null;
		resumeFormList= sfuDAO.select_my_resume_available_list(paramMap);		
		logger.debug("지원페이지에서 이력서 리스트 출력 서비스 완료");
		return resumeFormList;
	}
	
	/**
	 * @Method Name : total_delete_my_resume
	 * @Date : 2018. 12. 18.
	 * @User : 남유송
	 * @Param : 이력서 일련 번호
	 * @Return : -
	 * @Method 설명 : 이력서 정보 삭제
	 */
	public void delete_my_file(HashMap<String, Object> param) {
		logger.debug("FAP 이력서 전체 파일 삭제 Service 시작");
		ArrayList<HashMap<String, Object>> deletedFiles = sfuDAO.select_files(param);
		String pic_saved = null;
		String movie_saved = null;
		String portfolio_saved = null;
		try{
			pic_saved = (String) deletedFiles.get(0).get("pic_saved");
		}catch (NullPointerException e) {
			pic_saved = null;
		}
		try{
			movie_saved = (String) deletedFiles.get(0).get("file_saved");
		}catch (NullPointerException e){
			movie_saved = null;
		}
		try{
			portfolio_saved = (String) deletedFiles.get(1).get("file_saved");
		}catch (NullPointerException e){
			portfolio_saved = null;
		}
		FileService.deleteFile(pic_saved, fapResumePhotoImage);
		FileService.deleteFile(movie_saved, fapMovieFile);
		FileService.deleteFile(portfolio_saved, fapPortfolioFile);
		logger.debug("FAP 이력서 전체 파일 Service 종료");
	}
	
	/**
	 * @Method Name : delete_my_resume
	 * @Date : 2018. 12. 18.
	 * @User : 남유송
	 * @Param : 이력서 일련 번호
	 * @Return : -
	 * @Method 설명 : 이력서 정보 삭제
	 */
	public void delete_my_resume(HashMap<String, Object> param) {
		logger.debug("FAP 이력서 정보 삭제 Service 시작");
		sfuDAO.delete_my_resume(param);
		logger.debug("FAP 이력서 정보 삭제 Service 종료");
	}
	
	/**
	 * @Method Name : search_jobfair_job_advertisement_list
	 * @Date : 2018. 12. 20.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : SocietyFapUserJobAdvertisementList
	 * @Method 설명 : FAP 채용공고 상세검색
	 */
	public ArrayList<HashMap<String, Object>> search_job_advertisement_list(HashMap<String, Object> selectedCompanyInfoMap){
		logger.debug("FAP 채용공고 상세검색 Service 시작");	
		ArrayList<HashMap<String, Object>> jobAdvertisementList = sfuDAO.search_job_advertisement_list(selectedCompanyInfoMap);
		logger.debug("FAP 채용공고 상세검색 Service 종료");
		return jobAdvertisementList;
	}

	/**
	 * @Method Name : selectResumeApply
	 * @Date : 2018. 12. 21.
	 * @User : 남유송
	 * @Param : hashmap
	 * @Return : hashmap
	 * @Method 설명 : 개인별 이력서 리스트 출력
	 */
	@Transactional
	public HashMap<String, Object> selectResumeApply(HashMap<String, Object> param) {
		logger.debug("FAP 개인별 이력서 리스트 출력 Service 시작");
		HashMap<String, Object> resumeList = sfuDAO.selectResumeApplyBasic(param);
		 ArrayList<HashMap<String, Object>> resumeEduList = sfuDAO.selectResumeApplyEduhistory(param);
		 ArrayList<HashMap<String, Object>> resumeLicenseList = sfuDAO.selectResumeApplyLicense(param);
		 ArrayList<HashMap<String, Object>> resumeCareerList = sfuDAO.selectResumeApplyCareer(param);
		 ArrayList<HashMap<String, Object>> resumeProjectList = sfuDAO.selectResumeApplyProject(param);
		 ArrayList<HashMap<String, Object>> resumeTalentList = sfuDAO.selectResumeApplyTalent(param);
		 ArrayList<HashMap<String, Object>> resumeProfileList = sfuDAO.selectResumeApplyProfile(param);
		 ArrayList<HashMap<String, Object>> resumeAddrList = sfuDAO.selectResumeApplyAddress(param);
		 ArrayList<HashMap<String, Object>> resumeNameList = sfuDAO.selectResumeApplyName(param);
		 ArrayList<HashMap<String, Object>> resumeFileList = sfuDAO.selectResumeApplyFile(param);
		 
		 resumeList.put("resumeEduList", resumeEduList);
		 resumeList.put("resumeLicenseList", resumeLicenseList);
		 resumeList.put("resumeCareerList", resumeCareerList);
		 resumeList.put("resumeProjectList", resumeProjectList);
		 resumeList.put("resumeTalentList", resumeTalentList);
		 resumeList.put("resumeProfileList", resumeProfileList);
		 resumeList.put("resumeAddrList", resumeAddrList);
		 resumeList.put("resumeNameList", resumeNameList);
		 resumeList.put("resumeFileList", resumeFileList);
		 
		logger.debug("FAP 개인별 이력서 리스트 출력 Service 시작");
		return resumeList;
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
		logger.debug("FAP 지원 과정/기수 조회 Service 시작");
		ArrayList<HashMap<String, Object>> openedList = sfuDAO.selectFapOpened(param);

		logger.debug("FAP 지원 과정/기수 조회 Service 종료");
		return openedList;
	}
	
	/**
	 * @Method Name : selectScoreList
	 * @Date : 2020. 10. 05.
	 * @User : 김성미
	 * @Param : HashMap
	 * @Return : ArrayList
	 * @Method 설명 : 지원자 성적표 출력
	 */
	public ArrayList<HashMap<String, Object>> selectScoreList(HashMap<String, Object> param) {
		logger.debug("FAP 지원자 성적표 출력 Service 시작");
		ArrayList<HashMap<String, Object>> scoreList = sfuDAO.selectScoreList(param);

		logger.debug("FAP 지원자 성적표 출력 Service 종료");
		return scoreList;
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
		logger.debug("FAP 유저 정보 검색 서비스 시작");
		
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
		
		logger.debug("FAP 유저 정보 검색 서비스 종료");
		
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
				return 3;
			}
			
			// 코드를 세팅한다
			userInfo.setUser_id(code.getUser_id());
			code.setCertification_code(sendCode.getCertification_code());
			
			sgcDAO.updateCertificationCode(code);
			
			final String FROM = "sesoc2019@gamil.com";
	        final String TO = userInfo.getUser_email();
	        final String SUBJECT = "인증번호";
	        final String TEXT = String.format("인증번호: %04d", code.getCertification_code());
			mail.sendMail(FROM, TO, SUBJECT, TEXT);
			
		} catch (MessagingException e) {
			e.printStackTrace();
			return 2;
		} catch (NullPointerException ne) {
			ne.printStackTrace();
			return 2;
		}
		
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
	 * @Method Name : company_scale_statistics
	 * @Date : 2018. 12. 24.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMap
	 * @Method 설명 : FAP 채용공고 기업규모별 상세통계
	 */
	public HashMap<String, Object> company_scale_statistics(HashMap<String, Object> jobAdvertisementInfoMap){
		logger.debug("FAP 채용공고 기업 규모별 상세통계 Service 시작");	
		HashMap<String, Object> companyScaleStatistics = sfuDAO.company_scale_statistics(jobAdvertisementInfoMap);
		logger.debug("FAP 채용공고 기업 규모별 상세통계 Service 종료");
		return companyScaleStatistics;
	}
	/**
	 * @Method Name : user_forgot_password
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 유저 아이디, 비밀번호
	 * @Return : 변경 여부
	 * @Method 설명 : 유저의 비밀번호를 변경하는 함수
	 */
	public boolean user_forgot_password(String user_id, String user_pw) {
		logger.debug("FAP 유저 비밀번호 변경 서비스 시작");
		
		User userInfo = new User();
		userInfo.setUser_id(user_id);
		
		User found = sgcDAO.selectUser(userInfo);
		if (found == null) {
			return false;
		}
		
		String encodedPw = passwordEncoder.encode(user_pw);
		found.setUser_pw(encodedPw);
		sfuDAO.update_com_user(found);
		
		logger.debug("FAP 유저 비밀번호 변경 서비스 종료");
		return true;
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
		logger.info("FAP 회원 탈퇴 서비스 시작");
		int result=sfuDAO.delete_user_info(user);
		logger.info("FAP 회원 탈퇴 서비스 시작");
		
		return result;
	}
	
	/**
	 * @Method Name : select_company_name_and_apply_rank
	 * @Date : 2018. 12. 28.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMap
	 * @Method 설명 : FAP 취업지업자 회사명 및 지원가능 지망 셀렉트
	 */
	public HashMap<String, Object> select_company_name_and_apply_rank(HashMap<String, Object> advertisementInfoMap){
		logger.debug("FAP 취업지업자 회사명 및 지원가능 지망 셀렉트 Service 시작");
		//채용공고지원정보 테이블에 해당 유저아이디가 있는지 여부 판별(한번이라도 지원했는지 여부)
		int userApplyCount = sfuDAO.select_user_apply_count(advertisementInfoMap);
		//현재 잡페어 지망개수
		int currentJobFairCount = 0;
		//지원이 한번이라도 있는지 여부를 판단하는 부분(지원이 있으면 지망개수 설정 테이블 셀렉트, 지원이 없으면 잡페어 세부테이블 디폴트 지망개수 셀렉트)
		currentJobFairCount = 
				(userApplyCount > 0) ? 
						sfuDAO.select_user_apply_fixed_count(advertisementInfoMap)
						:
						sfuDAO.select_current_jobfair_count(advertisementInfoMap);
		//현재 지원한 지망순위를 제외하고 지원 가능한 지망을 갖고 있는 List
		ArrayList<Integer> applyAvailableRankList = new ArrayList<>();
		//1지망~n지망까지 설정해주는 부분
		for(int i=1; i<=currentJobFairCount; i++){
			applyAvailableRankList.add(i);
		}
		//현재회사이름, 회사아이디, 잡페어 시퀀스, 지원할 수 있는 지원 개수 셀렉트
		HashMap<String, Object> applyInfo = sfuDAO.select_company_name_and_apply_count(advertisementInfoMap);
		
		//해당 유저별 지망 상황 셀렉트
		ArrayList<Integer> appInfoRankList = sfuDAO.select_company_apply_info_rank(advertisementInfoMap);
		//n지망에서 현재 지원된 지망을 제거하고 지원가능한 지망순위를 만드는 부분
		for(Integer appInfoRank : appInfoRankList){
			applyAvailableRankList.remove(appInfoRank);
		}
		//지원이 처음이면 false, 지원을 한적이 있으면 true
		String apply_flag = (userApplyCount > 0) ? "true" : "false";
		
		applyInfo.put("apply_flag", apply_flag);
		applyInfo.put("applyAvailableRankList", applyAvailableRankList);
		logger.debug("FAP 취업지업자 회사명 및 지원가능 지망 셀렉트 Service 종료");
		return applyInfo;
	}
	
	/**
	 * @Method Name : apply_first_this_job_advertisement
	 * @Date : 2018. 12. 31.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 해당 채용공고에 지원하기 첫번째 스탭
	 */
	public int apply_first_this_job_advertisement(HashMap<String, Object> applyJobAdvertisementInfo) {
		logger.debug("FAP 채용지원자 해당 채용공고에 지원하기 First Service 시작");
		String apply_flag = (String) applyJobAdvertisementInfo.get("apply_flag");
		int resultCount = 
				(apply_flag.equalsIgnoreCase("true")) ? 
					sfuDAO.apply_update_this_job_advertisement(applyJobAdvertisementInfo)
					:
					sfuDAO.apply_insert_this_job_advertisement(applyJobAdvertisementInfo);
		logger.debug("FAP 채용지원자 해당 채용공고에 지원하기 First Service 종료");
		return resultCount;
	}
	
	/**
	 * @Method Name : apply_second_this_job_advertisement
	 * @Date : 2018. 12. 28.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : -
	 * @Method 설명 : FAP 취업지원자 해당 채용공고에 지원하기 두번째 스탭
	 */
	public void apply_second_this_job_advertisement(HashMap<String, Object> applyJobAdvertisementInfo) {
		logger.debug("FAP 채용지원자 해당 채용공고에 지원하기 Second Service 시작");
		sfuDAO.apply_second_this_job_advertisement(applyJobAdvertisementInfo);
		logger.debug("FAP 채용지원자 해당 채용공고에 지원하기 Second Service 종료");
	}
	
	/**
	 * @Method Name : select_jobfair_job_advertisement
	 * @Date : 2018. 12. 13.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMap
	 * @Method 설명 : FAP 취업지원자 채용공고 셀렉트(채용공고 읽기)
	 */
	public HashMap<String, Object> select_jobfair_job_advertisement(HashMap<String, Object> fapJobAdvertisement){
		logger.debug("FAP 취업지원자 채용공고 셀렉트 Service 시작");
		HashMap<String, Object> jobAdvertisement = sfuDAO.select_jobfair_job_advertisement(fapJobAdvertisement);
		logger.debug("FAP 취업지원자 채용공고 셀렉트 Service 종료");
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
	public String select_fap_jobfair_applicable_time(HashMap<String, Object> fapJobAdvertisement, String user_id){
		logger.debug("FAP 취업지원자 채용공고 지원가능한지 여부를 판단 Service 시작");
		//채용공고에 지원가능한 시간인지 판단하는 변수(fap_jobfair_applicable_time_first의 공통코드가 리턴됨)
		String applicableTimeFirst = sfuDAO.select_fap_jobfair_applicable_time(fapJobAdvertisement);
		//최종적으로 possible이면 해당 채용공고에 지원가능한 상황
		String whetherJobAdApply = (applicableTimeFirst != null && !applicableTimeFirst.isEmpty()) ? "possible" : "impossible";
		//리턴되는 공통코드를 보고 최초허가, 추가허가 여부를 판단하고 추가여부일 경우 관리자가 등록한 회사만 지원가능하게 하는 부분
		//리턴된 공통코드가 최초가 아닐 경우 관리자가 추가로 설정한 회사임을 확인하는 부분
		if(applicableTimeFirst != null && (applicableTimeFirst.equalsIgnoreCase("D0301") || applicableTimeFirst.equalsIgnoreCase("D0302"))){
			long applicableJobAdSeq = 0;
			//지원가능상태가 추가 허가 됬을 때 해당회사가 추가지원이 가능한 회사인지 판단하는 부분
			//exception이 발생하면 리턴이 null 즉 해당회사는 추가지원가능 회사가 아니라는 뜻으로 0으로 만들어주는 부분
			try {
				applicableJobAdSeq = sfuDAO.select_fap_jobfair_applicable_is_first(fapJobAdvertisement);
			} catch (Exception e) {
				applicableJobAdSeq = 0;
			}
			whetherJobAdApply = (applicableJobAdSeq > 0) ? "possible" : "impossible";
		}
		
		int count = sfuDAO.final_decision_time_count_select(user_id);
		if(whetherJobAdApply.equals("possible")) {
			whetherJobAdApply = (count == 0) ? "possible" : "impossible";
		}
		
		String fap_jobfair_apply_rule_gb = sfuDAO.select_jobfair_apply_rule_gb(fapJobAdvertisement);

		if(fap_jobfair_apply_rule_gb != null) {
			if(!fap_jobfair_apply_rule_gb.equals("D1900")) {
				whetherJobAdApply = "impossible";
			}
		}else {
			whetherJobAdApply = "impossible";
		}
		
		logger.debug("FAP 취업지원자 채용공고 지원가능한지 여부를 판단 Service 종료");
		return whetherJobAdApply;
	}

	/**
	 * @Method Name : apply_job_advertisement_applicable_check
	 * @Date : 2018. 1. 4.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 취업지원자 채용공고 중복지원 여부 체크
	 */
	public String apply_job_advertisement_applicable_check(HashMap<String, Object> applyApplicableCheckInfo) {
		logger.debug("FAP 취업지원자 채용공고 중복지원 여부 체크 Service 시작");
		String message = "applicable";
		//지원가능하다면 시간넘었는지 여부 확인
		int applicableTimeCount = sfuDAO.apply_job_advertisement_time_check(applyApplicableCheckInfo);
		if(1 > applicableTimeCount){
			message = "inapplicableTime";
			return message;
		}
		
		//해당 채용공고 중복지원 여부 확인
		int duplicateCount = sfuDAO.apply_job_advertisement_duplicate_check(applyApplicableCheckInfo);
		if(duplicateCount > 0){
			message = "duplicateTrue";
			return message;
		}
		
		//회원 지원동의(보증보험) 동의여부 
		int result = sfuDAO.check_user_apply_confirm(applyApplicableCheckInfo);
		
		if(result == 0) {
			message = "needConfirmApplyCheck";
			return message;
		}
		
		//유저가 지원할 쿼터가 남아있는지 여부
		int quarterCount = 0;
		//exception이 발생하면 아직 지원을 하지 않았다는 의미이므로 지원가능 메세지를 jsp로 보낸다.
		try{
			quarterCount = sfuDAO.apply_job_advertisement_quarter_check(applyApplicableCheckInfo);
		} catch(Exception e){
			return message;
		}
		//0이 나온다면 지망개수를 모두 소진 했다는 의미이므로 지원을 막는다.
		if(1 > quarterCount){
			message = "useAllQuarter";
			return message;
		}
		
		
		
		logger.debug("FAP 취업지원자 채용공고 중복지원 여부 체크 Service 종료");
		return message;
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
		//사진 파일이 있을때 
		if(resumeForm.getFap_resume_pic() != null && !resumeForm.getFap_resume_pic().isEmpty()){
			//사진 파일이 있을 때 전에 파일을 삭제시켜주는 부분
			if(resumeForm.getFap_resume_pic_saved() != null){
				FileService.deleteFile(resumeForm.getFap_resume_pic_saved(),fapResumePhotoImage);
				resumeForm.setFap_resume_pic_saved(null);
				resumeForm.setFap_resume_pic_origin(null);
			}
			UploadFileServer(resumeForm);
		}
		//사진 파일 없을 때
		else {
			//현재 사진파일에는 null이지만 원래 불러오기했을 때 사진파일이 있었을 때
			//또한 불러온 파일을 제거했을 때 해당 if절에 들어갈 수 있다.
			//orgin의 여부는 불러온 파일중에 현재 시점에서 삭제 했는가 여부이다(불러온 파일을 현재 삭제했을 때 orgin=null, 삭제 안하고 그대로 수정 할 때는 origin != null
			if(resumeForm.getFap_resume_pic_saved() != null && 
					resumeForm.getFap_resume_pic_origin() == null){
				boolean isDelete = FileService.deleteFile(resumeForm.getFap_resume_pic_saved(), fapResumePhotoImage);
				if(isDelete == true){
					resumeForm.setFap_resume_pic_saved(null);
				}
			}
		}
		long resume_parent_insert_seq = sfuDAO.resume_parent_update(resumeForm);
		logger.debug("FAP 기본 이력서 정보 업데이트 Service 종료");
		return resume_parent_insert_seq;
	}

	/**
	 * @Method Name : resume_delete
	 * @Date : 2019.01.07
	 * @User : 남유송
	 * @Param : 이력서 정보(학력/관련 교육이수, 사회 경력, 프로젝트 개발 경력, 자격, 역량/재능, PR, 포트폴리오 파일)
	 * @Return : -
	 * @Method 설명 : 이력서 전체 정보 삭제
	 */
	public void resume_delete(long fap_resume_seq) {
		logger.debug("FAP 이력서 전체 삭제 Service 시작");
		sfuDAO.delete_resume(fap_resume_seq);
		logger.debug("FAP 이력서 전체 삭제 Service 종료");
		
	}
	
	/**
	 * @Method Name : search_nominated_company_list
	 * @Date : 2019. 1. 8.
	 * @User : 신동철
	 * @Param : 회원 아이디
	 * @Return : 내정받은 회사 리스트
	 * @Method 설명 : 취업지원자가 내정받은 기업이 있는지 검색
	 */
	public ArrayList<HashMap<String, Object>> search_nominated_company_list(String user_id){
		logger.debug("FAP 취업지원자 내정기업 리스트 검색 Service 시작");
		ArrayList<HashMap<String, Object>> nominated_company_list = sfuDAO.search_nominated_company_list(user_id);
		logger.debug("FAP 취업지원자 내정기업 리스트 검색 Service 종료");
		return nominated_company_list;
	}
	
	/**
	 * @Method Name : insert_user_required_doc
	 * @Date : 2019. 1. 8.
	 * @User : 신동철
	 * @Param : 내정자 내정서류
	 * @Return : -
	 * @Method 설명 : 내정자 내정서류를 등록하는 함수
	 */
	public int insert_user_required_doc(SocietyFapPersonalRequiredDoc user_required_doc){
		logger.info("FAP 내정자 내정서류 업로드 Service 시작");		
					
		// 저장 fullPath
		String fullPath = "/" + user_required_doc.getFap_comp_id() + "_" + user_required_doc.getFap_job_ad_seq() + "/" + user_required_doc.getFap_nominee_seq();
		//내정자 내정서류 파일저장
		try {
			if (user_required_doc.getFap_personal_required_doc_file() != null) {
				user_required_doc.setFap_personal_required_doc_origin(user_required_doc.getFap_personal_required_doc_file().getOriginalFilename());
				user_required_doc.setFap_personal_required_doc_saved(FileService.saveFile(user_required_doc.getFap_personal_required_doc_file(), fapCompanyRequiredDocFile + fullPath));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		//업로더는 회원
		user_required_doc.setFap_personal_required_doc_uploader_gb("C4801");
		// 내정자 내정서류 등록
		int result = sfuDAO.insert_user_required_doc(user_required_doc);
		
		logger.info("FAP 내정자 내정서류 업로드 Service 종료");
		return result; 
	}

	/**
	 * @Method Name : resume_deletable_check
	 * @Date : 2019. 1. 9.
	 * @User : 남유송
	 * @Param : int(이력서 일련번호)
	 * @Return : int
	 * @Method 설명 : 지원된 이력서를 삭제 못하도록 이력서가 이미 지원되어있는지 여부 검사
	 */
	public String select_undeletable_resume(int fap_resume_seq) {
		logger.info("지원된 이력서 검색 Service 시작");
		int resume_deletable_check = sfuDAO.select_undeletable_resume(fap_resume_seq);
		String message = (1 > resume_deletable_check ) ? "approvalDeleteSuccess":"approvalDeleteFail";
		logger.info("지원된 이력서 검색 Service 종료");
		return message;
	}
	
	/**
	 * @Method Name : select_personal_apply_status_list
	 * @Date : 2019. 1. 15.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMap
	 * @Method 설명 : FAP 취업지원자 개인지원현황 리스트 출력
	 */
	public HashMap<String, Object> select_personal_apply_status_list(HashMap<String, Object> userInfoMap){
		logger.debug("FAP 취업지원자 개인지원현황 리스트 출력 Service 시작");
		
		//승인전, 쿼터판단 전 개인지원현황 리스트
		ArrayList<HashMap<String, Object>> approvalBeforePersonalApplyStatusList = sfuDAO.select_approval_before_personal_apply_status_list(userInfoMap);
		
		//승인전 기업별 개인지원현황 중 쿼터 문제 있는지 확인
		if(!approvalBeforePersonalApplyStatusList.isEmpty() && approvalBeforePersonalApplyStatusList != null){
			//쿼터 비교를 위한 파라미터 맵
			HashMap<String, Object> userPerApplyStatusInfoParamMap = new HashMap<>();
			//파라미터 맵에 넣을 채용공고 List
			ArrayList<Long> adListInMap = new ArrayList<>();
			
			for(HashMap<String, Object> approvalBeforePersonalApplyStatus : approvalBeforePersonalApplyStatusList){
				userPerApplyStatusInfoParamMap.put("fap_jobfair_divide_seq", approvalBeforePersonalApplyStatus.get("fap_jobfair_divide_seq"));
				adListInMap.add((Long) approvalBeforePersonalApplyStatus.get("fap_job_ad_seq"));
			}
			userPerApplyStatusInfoParamMap.put("adListInMap", adListInMap);
			
			//채용공고 별 지원인원 및 지원가능 인원 정보 담는 map
			ArrayList<LinkedHashMap<String, Object>> adPerQuarterMapList = sfuDAO.select_per_ad_apply_info(userPerApplyStatusInfoParamMap);
			
			//채용공고 별 가능한 지망 담고 있을 Map
			LinkedHashMap<Long, Integer> adPerPossibleQuarterMap = new LinkedHashMap<>();
			
			//채용공고 판단 변수
			long culAdSeq = 0;
			//채용공고별 지원가능 지망 변수
			int applyPossibleQuarter = 0;
			//채용공고별  지원가능 인원 변수
			int applyPerSettledNum = 0;
			//반복문안 지망 카운트
			int applyCount = 0;
			
			//[start] 채용공고별 지원가능한 지망수 판단하는 반복문 시작
			for(LinkedHashMap<String, Object> adPerQuarterMap : adPerQuarterMapList){
				//채용공고별 처음 만나는 부분
				if(culAdSeq != (long) adPerQuarterMap.get("fap_job_ad_seq")){
					//지망 카운트 최초 채용공고시 1로 설정해주는 부분
					applyCount = 1;
					culAdSeq = (long) adPerQuarterMap.get("fap_job_ad_seq");
					applyPerSettledNum = Integer.parseInt(adPerQuarterMap.get("applicable_num").toString());
					//지원가능인원이 0명 이하일 때 처리부분
					if(applyPerSettledNum < applyCount){
						applyPossibleQuarter = 0;
						adPerPossibleQuarterMap.put(culAdSeq, applyPossibleQuarter);
					}
					//지원가능인원이 1명일 때 처리해주는 부분
					else if(applyPerSettledNum == applyCount){
						applyPossibleQuarter = (int) adPerQuarterMap.get("fap_job_app_info_rank");
						adPerPossibleQuarterMap.put(culAdSeq, applyPossibleQuarter);
					}
				}
				//같은 채용공고 별 처음이후 지원가능 지망 판단 부분
				else{
					if(applyPerSettledNum == applyCount){
						applyPossibleQuarter = (int) adPerQuarterMap.get("fap_job_app_info_rank");
						adPerPossibleQuarterMap.put(culAdSeq, applyPossibleQuarter);
					}
				}
				applyCount++;
			}
			//[end] 채용공고별 지원가능한 지망수 판단하는 반복문 종료
			
			//JSP로 나가기 전에 현재 지망으로 지원가능 한지 Map에 넣어주는 부분
			for(HashMap<String, Object> approvalBeforePersonalApplyStatus : approvalBeforePersonalApplyStatusList){
				long fap_job_ad_seq = (long) approvalBeforePersonalApplyStatus.get("fap_job_ad_seq");
				//예외발생 이유는 지원가능 하기 때문에 발생하는 에러이므로 -1로 강제 put해준다.
				try{
					approvalBeforePersonalApplyStatus.put("adPerPossibleQuarter", (int) adPerPossibleQuarterMap.get(fap_job_ad_seq));
				}catch(NullPointerException e){
					approvalBeforePersonalApplyStatus.put("adPerPossibleQuarter", -1);
				}
			}
		}
		
		//승인된 개인지원현황 리스트(합격, 불합격 포함) 
		ArrayList<HashMap<String, Object>> approvalAfterpersonalApplyStatusList = sfuDAO.select_approval_after_personal_apply_status_list(userInfoMap);
		//최종합격이거나 진행중인 개인지원현황 리스트
		ArrayList<HashMap<String, Object>> acceptedAndProcessingPersonalApplyStatusList = new ArrayList<>();
		//불합격 된 개인지원현황 리스트
		ArrayList<HashMap<String, Object>> unAcceptedPersonalApplyStatusList = new ArrayList<>();
		
		//E-Type 최종합격 구분
		boolean eTypeFlag = false;
		
		for(HashMap<String, Object> personalApplyStatus : approvalAfterpersonalApplyStatusList){
			String fap_job_app_rt_acp =  (String) personalApplyStatus.get("fap_job_app_rt_acp");
			String fap_job_app_final_rt_acp_user = (String) personalApplyStatus.get("fap_job_app_final_rt_acp_user");
			String fap_job_ad_rule_type = (String) personalApplyStatus.get("fap_job_ad_rule_type");
			
			// E-Type 최종합격자 Flag
			if(fap_job_app_final_rt_acp_user.equalsIgnoreCase("D0001") && fap_job_ad_rule_type.equalsIgnoreCase("D2000")) {
				eTypeFlag = true;
			}
			
			//전형 불합격되지 않았거나 최종합격인 경우
			if((!fap_job_app_final_rt_acp_user.equalsIgnoreCase("D0002")) && (fap_job_app_rt_acp.equalsIgnoreCase("D0000") || fap_job_app_rt_acp.equalsIgnoreCase("D0001"))){
				acceptedAndProcessingPersonalApplyStatusList.add(personalApplyStatus);
			}
			//전형이 불합격된 경우
			else {
				personalApplyStatus.put("fap_job_app_rt_acp", "D0002");
				unAcceptedPersonalApplyStatusList.add(personalApplyStatus);
			}
			
		}
		
		//최종JSP에 가져갈 Map
		HashMap<String, Object> finalPersonalApplyStatusListMap = new HashMap<>();
		finalPersonalApplyStatusListMap.put("acceptedAndProcessingPersonalApplyStatusList", acceptedAndProcessingPersonalApplyStatusList);
		finalPersonalApplyStatusListMap.put("unAcceptedPersonalApplyStatusList", unAcceptedPersonalApplyStatusList);
		finalPersonalApplyStatusListMap.put("approvalBeforePersonalApplyStatusList", approvalBeforePersonalApplyStatusList);
		finalPersonalApplyStatusListMap.put("eTypeFlag", eTypeFlag);
		
		logger.debug("FAP 취업지원자 개인지원현황 리스트 출력 Service 종료");
		return finalPersonalApplyStatusListMap;
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
		logger.info("취업지원자 전형일정 스케줄 검색 Service 시작");
		
		ArrayList<HashMap<String, Object>> recruit_pcs_sch_list = sfuDAO.select_user_recruit_pcs_sch(user_id);
		ArrayList<HashMap<String, Object>> schedule_list = new ArrayList<>();
				
		for(int i=0; i<recruit_pcs_sch_list.size(); i++){			
			HashMap<String, Object> schedule_map = new HashMap<>();
			String schedule_title =  ""; String schedule_color = "";
			
			//schedule_title 설정(title = 회사영문명 + 전형구분)
			schedule_title += (String)recruit_pcs_sch_list.get(i).get("fap_comp_en_nm") + "  ";
			String recruit_pcs_gb = (String)recruit_pcs_sch_list.get(i).get("fap_job_recruit_pcs_gb");	
			
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
			}else{
				schedule_title += "기타전형";
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
		
		logger.info("취업지원자 전형일정 스케줄 검색 Service 종료");
		return schedule_list;
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
		logger.info("취업지원자 서류전형 정보 검색 Service 시작");
		
		HashMap<String, Object> user_review_pcs_info = sfuDAO.select_user_review_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("취업지원자 서류전형 정보 검색 Service 종료");
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
		logger.info("취업지원자 시험전형 정보 검색 Service 시작");
		
		HashMap<String, Object> user_exam_pcs_info = sfuDAO.select_user_exam_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("취업지원자 시험전형 정보 검색 Service 종료");
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
		logger.info("취업지원자 면접전형 정보 검색 Service 시작");
		
		HashMap<String, Object> user_itv_pcs_info = sfuDAO.select_user_itv_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("취업지원자 면접전형 정보 검색 Service 종료");
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
		logger.info("취업지원자 기타전형 정보 검색 Service 시작");
		
		HashMap<String, Object> user_test_etc_pcs_info = sfuDAO.select_user_test_etc_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("취업지원자 기타전형 정보 검색 Service 종료");
		return user_test_etc_pcs_info;
	}
	
	/**
	 * @Method Name : delete_current_apply_info
	 * @Date : 2019. 1. 18.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 취업지원자 승인 전 지원정보 삭제
	 */
	@Transactional
	public String delete_current_apply_info(HashMap<String, Object> userInfoMap){
		logger.debug("FAP 취업지원자 승인 전 지원정보 삭제 Service 시작");
		String message = "";
		int deleteResult = sfuDAO.delete_current_apply_info(userInfoMap);
		if(deleteResult > 0){
			//삭제 후에 쿼터 -1하는 부분
			int resultCount = sfuDAO.minus_quarter_after_apply_cancel(userInfoMap);
			message = (resultCount > 0) ? "deleteSuccess" : "deleteFail";
		}
		logger.debug("FAP 취업지원자 승인 전 지원정보 삭제 Service 종료");
		return message;
	}
	
	/**
	 * @Method Name : select_applied_company_rank_edit_info_modal
	 * @Date : 2019. 1. 21.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : Int
	 * @Method 설명 : FAP 취업지원자 기업지망순위편집 모달창 출력
	 */
	public int select_applied_company_rank_edit_info_modal(HashMap<String, Object> userInfoMap){
		logger.debug("FAP 취업지원자 기업지망순위편집 모달창 출력 Service 시작");
		int perUserFixedCount = sfuDAO.select_user_apply_fixed_count(userInfoMap);
		logger.debug("FAP 취업지원자 기업지망순위편집 모달창 출력 Service 종료");
		return perUserFixedCount;
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
		logger.debug("FAP 통합잡페어 정보 리스트(현재 세션아이디 참가중인지 판단) 출력 Service 시작");
		ArrayList<HashMap<String, Object>> jobfairInfoList = sfuDAO.select_fap_user_jobfair_per_user_info_list(user_id);
		ArrayList<Integer> jobfairSeqList = new ArrayList<>();
		for(HashMap<String, Object> jobfairInfo : jobfairInfoList){
			jobfairSeqList.add((Integer) jobfairInfo.get("fap_jobfair_seq"));
		}
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("jobfairSeqList", jobfairSeqList);
		ArrayList<HashMap<String, Object>> tempJobfairLocationList = sfuDAO.select_fap_user_jobfair_location_list(params);
		
		for(HashMap<String, Object> jobfairInfo : jobfairInfoList){
			ArrayList<String> jobfairLoList = new ArrayList<>();
			for(HashMap<String, Object> tempJobfairLocation : tempJobfairLocationList){
				if((int) jobfairInfo.get("fap_jobfair_seq") == (int) tempJobfairLocation.get("fap_jobfair_seq")){
					jobfairLoList.add((String) tempJobfairLocation.get("fap_jobfair_lo"));
				}
			}
			jobfairInfo.put("jobfairLoList", jobfairLoList);
		}
		logger.debug("FAP 통합잡페어  정보 리스트(현재 세션아이디 참가중인지 판단) 출력 Service 종료");
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
		logger.debug("FAP 취업지원자 해당잡페어 승인된 취업지원자 잡페어 세부선택 셀렉트 Service 시작");
		ArrayList<HashMap<String, Object>> jobfairDivideInfoList = sfuDAO.select_fap_user_jobfair_divide_info_list(params);
		logger.debug("FAP 취업지원자 해당잡페어 승인된 취업지원자 잡페어 세부선택 셀렉트 Service 종료");
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
		logger.debug("FAP 취업지원자 잡페어 선택 모달 눌렀을 때 해당아이디 잡페어 목록 요청 Service 시작");
		ArrayList<HashMap<String, Object>> jobfairInfoList = sfuDAO.select_user_current_participation_jobfair_list(user_id);
		HashMap<String, Object> params = new HashMap<>();
		params.put("jobfairInfoList", jobfairInfoList);
		params.put("user_id", user_id);
		ArrayList<HashMap<String, Object>> tempJobfairDivideInfoList = sfuDAO.select_user_current_participation_jobfair_divide(params);
		for(HashMap<String, Object> jobfairInfo : jobfairInfoList){
			ArrayList<HashMap<String, Object>> jobfairDivideInfoList = new ArrayList<>();
			for(HashMap<String, Object> tempJobfairDivideInfo : tempJobfairDivideInfoList){
				if((int) jobfairInfo.get("fap_jobfair_seq") == (int) tempJobfairDivideInfo.get("fap_jobfair_seq")){
					jobfairDivideInfoList.add(tempJobfairDivideInfo);
				}
			}
			if(!jobfairDivideInfoList.isEmpty()) {
				jobfairInfo.put("jobfairDivideInfoList", jobfairDivideInfoList);
			}
		}
		logger.debug("FAP 취업지원자 잡페어 선택 모달 눌렀을 때 해당아이디 잡페어 목록 요청 Service 종료");
		return jobfairInfoList;
	}
	
	/**
	 * @Method Name : request_apply_info_rank_change
	 * @Date : 2019. 2. 20.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 취업지원자 개인지원현황 지망순위 변경 요청
	 */
	@Transactional
	public String request_apply_info_rank_change(ArrayList<HashMap<String, Object>> appInfoMapAry){
		logger.debug("FAP 취업지원자 개인지원현황 지망순위 변경 요청 Service 시작");
		String message = "";
		if(appInfoMapAry.isEmpty()){ return "changeFail";}
		int changeResult = sfuDAO.request_apply_info_rank_change(appInfoMapAry);
		message = (changeResult > 0) ? "changeSuccess" : "changeFail";
		logger.debug("FAP 취업지원자 개인지원현황 지망순위 변경 요청 Service 종료");
		return message;
	}
	
	/**
	 * @Method Name : select_per_user_apply_detail_info
	 * @Date : 2019. 2. 21.
	 * @User : 정대영
	 * @Param : Long
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 개인별 상세정보 요청
	 */
	public ArrayList<HashMap<String, Object>> select_per_user_apply_detail_info(long fap_job_app_info_seq, String status){
		logger.debug("FAP 취업지원자 개인별 상세정보 요청 Service 시작");
		ArrayList<HashMap<String, Object>> userInfoMapList = 
				(status.equalsIgnoreCase("before")) ? 
						sfuDAO.select_per_user_before_apply_detail_info(fap_job_app_info_seq)
						: 
						sfuDAO.select_per_user_after_apply_detail_info(fap_job_app_info_seq);
		logger.debug("FAP 취업지원자 개인별 상세정보 요청 Service 종료");
		return userInfoMapList;
	}
	
	/**
	 * @Method Name : select_total_apply_status_detail_info
	 * @Date : 2019. 2. 26.
	 * @User : 정대영
	 * @Param : Long, String
	 * @Return : HashMap
	 * @Method 설명 : FAP 취업지원자 기업별 상세정보 요청
	 */
	public HashMap<String, Object> select_total_apply_status_detail_info(long fap_job_ad_seq, String user_id){
		logger.debug("FAP 취업지원자 기업별 상세정보 요청 Service 시작");
		HashMap<String, Object> totalApplyInfoMap = new HashMap<>();
		//전체지원현황정보
		HashMap<String, Object> companyApplyInfo = sfuDAO.select_total_apply_status_detail_info(fap_job_ad_seq);
		//해당 채용공고 지망리스트
		ArrayList<HashMap<String, Object>> companyPerApplyRankInfoList = sfuDAO.select_current_company_rank_info(fap_job_ad_seq);
		
		//해당 채용공고 현재 지원가능한 지망 변수
		int applyPossibleQuarter = 0;
		//해당 채용공고 설정된 지원가능 인원 변수
		int applyPerSettledNum = (int) companyApplyInfo.get("fap_job_app_per_settled_num");
		int nowApplyNum = Integer.parseInt(companyApplyInfo.get("now_apply_nums").toString());
		
		applyPerSettledNum = applyPerSettledNum - nowApplyNum;
		
		//반복문안 지망 카운트
		int applyCount = 1;
		//선택채용공고에 내가 지원했는지 여부(0이면 지원 안한것)
		int myApplyRank = 0;
		
		//[start] 채용공고별 지원가능한 지망수 및 내가 지원했는지 여부 판단 시작
		for(HashMap<String, Object> companyPerApplyRankInfo : companyPerApplyRankInfoList){
			//[start] 채용공고별 지원가능한 지망수 판단 시작
			int curApplyRank = (int) companyPerApplyRankInfo.get("fap_job_app_info_rank");
			if(applyCount == applyPerSettledNum){
				applyPossibleQuarter = curApplyRank;
			}
			applyCount++;
			//[end] 채용공고별 지원가능한 지망수 판단 종료
			
			//[start] 채용공고별 내가 지원했는지 여부  판단 시작
			String applyId = (String) companyPerApplyRankInfo.get("user_id");
			if(user_id.equals(applyId)){
				myApplyRank = curApplyRank;
			}
		}
		//[end] 채용공고별 지원가능한 지망수 및 내가 지원했는지 여부 판단 종료
		
		//order by된 지망수가 현재 반복문에서는 몇지망을 가르키는지를 판단하는 변수
		int iterationCount = 0;
		//같은 지망 몇개인지 개수를 새는 변수
		int equalRankCount = 0;
		//지망 순위별 개수 전체 담는 리스트
		ArrayList<HashMap<Integer, Integer>> rankPerApplyRankList = new ArrayList<>();
		//[start] 채용공고별 지망별 지망수 묶기 시작
		for(int i=0; i<companyPerApplyRankInfoList.size(); i++){
			int curApplyRank = (int) companyPerApplyRankInfoList.get(i).get("fap_job_app_info_rank");
			//지망순위가 바뀌는 부분
			if(iterationCount != curApplyRank){
				iterationCount = curApplyRank;
				equalRankCount = 1;
			}
			//현재 진행되고있는 지망순위가 바뀌지 않는부분
			else{
				equalRankCount += 1;
			}
			/*******************************************************************************************/
			//지망 순위별로 몇명지망했는지를 담는 해쉬맵
			HashMap<Integer, Integer> theNumberOfPerApplyRank = new HashMap<>();
			//반복문의 마지막이면 마지막부분 다음 반복변수의 지망순위 판단없이 리스트에 넣어주고 반복문 종료
			if(i == companyPerApplyRankInfoList.size() - 1){
				theNumberOfPerApplyRank.put(iterationCount, equalRankCount);
				rankPerApplyRankList.add(theNumberOfPerApplyRank);
				break;
			}
			//다음번 리스트의 지망순위가 다를경우 현재까지 카운트한 지망을 list에 담아준다.
			int nextApplyRank = (int) companyPerApplyRankInfoList.get(i+1).get("fap_job_app_info_rank");
			//반복문의 다음 지망순위가 현재 지망순위가 다르다는 의미로 리스트에 넣어준다.
			if(iterationCount != nextApplyRank){
				theNumberOfPerApplyRank.put(iterationCount, equalRankCount);
				rankPerApplyRankList.add(theNumberOfPerApplyRank);
			}
		}
		//[end] 채용공고별 지망별 지망수 묶기 종료
		
		//선택한 기업에서 지원한 최고지망
		totalApplyInfoMap.put("maxApplyRank", iterationCount);
		totalApplyInfoMap.put("applyPerSettledNum", applyPerSettledNum);
		//현재 기업 내가 지원했는지 여부, 지원했으면 지망 순위
		totalApplyInfoMap.put("myApplyRank", myApplyRank);
		//현재 기업 지원가능한 지망랭크
		totalApplyInfoMap.put("applyPossibleQuarter", applyPossibleQuarter);
		//전체지원현황정보
		totalApplyInfoMap.put("companyApplyInfo", companyApplyInfo);
		//해당 채용공고 지망리스트
		totalApplyInfoMap.put("rankPerApplyRankList", rankPerApplyRankList);
		logger.debug("FAP 취업지원자 기업별 상세정보 요청 Service 종료");
		return totalApplyInfoMap;
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
		logger.info("FAP 교육기관 불러오기 서비스 시작");
		ArrayList<HashMap<String, Object>> kmove_list = sfuDAO.select_komve();
		logger.info("FAP 교육기관 불러오기 서비스 시작");
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
		int result = sfuDAO.check_user_personal(user_id);
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
		logger.debug("FAP 취업지원자 잡페어별 전체지원현황 셀렉트 Service 시작");
		ArrayList<HashMap<String, Object>> perJobfairTotalApplyList = sfuDAO.select_job_ad_total_application_status(fap_jobfair_divide_seq);
		logger.debug("FAP 취업지원자 잡페어별 전체지원현황 셀렉트 Service 종료");
		return perJobfairTotalApplyList;
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
		logger.info("FAP 회원 학교 정보 입력 서비스 시작");
		sfuDAO.user_school_insert(sfpUser, sfpHighschool, sfpUniversity, sfpGraduate);
		logger.info("FAP 회원 학교 정보 입력 서비스 종료");
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
		logger.info("FAP 공지사항 가져오기 Service 시작");
		ArrayList<BoardContent> notice_list = sfuDAO.user_board_contents_search(map);
		logger.info("FAP 공지사항 가져오기 Service 종료");
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
		logger.info("FAP 공지사항 게시글 갯수 가져오기 Service 시작");
		int count = sfuDAO.board_contents_count(map);
		logger.info("FAP 공지사항 게시글 갯수 가져오기 Service 종료");
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
		logger.info("FAP 잡페어 지원자 공지사항 게시판 리스트 검색 Service 시작");
		ArrayList<BoardContent> notice_list = sfuDAO.user_board_contents_list_search(map);
		logger.info("FAP 잡페어 지원자 공지사항 게시판 리스트 검색 Service 시작");
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
		logger.info("FAP 지원자 채용공고 Q&A 질문 등록 Service 시작");
		int result = sfuDAO.insert_job_qna_question(qna_q);
		logger.info("FAP 지원자 채용공고 Q&A 질문 등록 Service 종료");
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
		ArrayList<HashMap<String, Object>> result = sfuDAO.select_job_qna(fap_job_ad_seq);
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
		HashMap<String, Object> result = sfuDAO.select_job_qna_one(fap_job_qna_question_seq);
		logger.info("FAP 채용전형  Q&A 상세  Serivce 종료");
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
		logger.info("FAP 사용자 채용전형 Q&A 질문 수정  Service 시작");
		sfuDAO.update_job_qna_question(qna_q);
		logger.info("FAP 사용자 채용전형 Q&A 질문 수정  Service 끝");
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
		logger.info("FAP 사용자 채용전형 Q&A 질문 삭제  Service 시작");
		sfuDAO.delete_job_qna_question(fap_job_qna_question_seq);
		logger.info("FAP 사용자 채용전형 Q&A 질문 삭제  Service 끝");
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
		SocietyFapAdminFinalDecisionTime result = sfuDAO.final_decision_time_select_today(fap_jobfair_divide_seq);
		logger.info("FAP 오늘날짜를 포함한 최종확정 기간 정보 조회  DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : user_personal_apply_final_decision
	 * @Date : 2019. 3. 25.
	 * @User : 이종호
	 * @Param : 최종확정정보
	 * @Return : -
	 * @Method 설명 : 지원자 최종확정 결정 등록
	 */
	@Transactional
	public int user_personal_apply_final_decision(HashMap<String, Object> paramMap) {
		logger.info("FAP 지원자 최종확정 결정 등록  서비스 시작");
			//확정인경우
			int result = 0;
			if(paramMap.get("fap_job_app_choice_comp_gb").toString().equals("D0701")) {
				//지원자 최종확정 개수
				result = sfuDAO.personal_apply_final_decision_select_count(paramMap);
				if(result == 0) {
					//선택 확정
					sfuDAO.personal_apply_final_decision_update(paramMap);
				}
			}
			//포기,대기중 인경우
			else {
				 sfuDAO.personal_apply_final_decision_update(paramMap);
			}
		logger.info("FAP 지원자 최종확정 결정 등록  서비스 종료");
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
		logger.info("FAP 노출된 오픈잡페어 설명회 정보 조회 서비스 시작");
		SocietyFapOpenPt result = sfuDAO.open_pt_info_select();
		logger.info("FAP 노출된 오픈잡페어 설명회 정보 조회 서비스 종료");
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
		SocietyFapOpenPt result = sfuDAO.open_pt_edu_info_select();
		logger.info("FAP 노출된 오픈잡페어 구직자 교육 정보 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : open_pt_apply
	 * @Date : 2019. 4. 12.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 지원자 정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 지원자 신청
	 */
	public void open_pt_apply(SocietyFapOpenPtApply apply) {
		logger.info("FAP 오픈잡페어 설명회 지원자 신청 서비스 시작");
		sfuDAO.open_pt_apply(apply);
		logger.info("FAP 오픈잡페어 설명회 지원자 신청 서비스 종료");
	}
	
	/**
	 * @Method Name : open_pt_edu_apply
	 * @Date : 2019. 4. 15.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 지원자 정보, 오픈잡페어 구직자 교육 지원자 이력서 정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 구직자 교육 지원자 신청
	 */
	@Transactional
	public void open_pt_edu_apply(SocietyFapOpenPtApply apply,SocietyFapOpenPtResume resume) {
		logger.info("FAP 오픈잡페어 구직자 교육 지원자 신청 서비스 시작");
		sfuDAO.open_pt_apply(apply);
		
		resume.setFap_open_pt_apply_seq(apply.getFap_open_pt_apply_seq());
		sfuDAO.open_pt_edu_resume_apply(resume);
		
		logger.info("FAP 오픈잡페어 구직자 교육 지원자 신청 서비스 종료");
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
		logger.info("FAP 오픈잡페어 설명회 지원자 신청 확인 서비스 시작");
		int result = sfuDAO.open_pt_apply_check(apply);
		logger.info("FAP 오픈잡페어 설명회 지원자 신청 확인 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : open_pt_apply_cancel
	 * @Date : 2019. 4. 15.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 지원자 시퀀스
	 * @Return : 취소 후 지원리스트
	 * @Method 설명 : 오픈잡페어 설명회 지원자 신청 취소
	 */
	@Transactional
	public ArrayList<HashMap<String, Object>> open_pt_apply_cancel(int fap_open_pt_apply_seq,String user_id) {
		logger.info("FAP 오픈잡페어 설명회 지원자 신청 취소 서비스 시작");
		sfuDAO.open_pt_apply_cancel(fap_open_pt_apply_seq);
		ArrayList<HashMap<String, Object>> result = sfuDAO.user_open_pt_applied_list(user_id);
		logger.info("FAP 오픈잡페어 설명회 지원자 신청 취소 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : open_pt_edu_apply_cancel
	 * @Date : 2019. 4. 15.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 지원자 시퀀스
	 * @Return : 취소 후 지원리스트
	 * @Method 설명 : 오픈잡페어 구직자 교육 지원자 신청 취소
	 */
	@Transactional
	public ArrayList<HashMap<String, Object>> open_pt_edu_apply_cancel(int fap_open_pt_apply_seq,String user_id) {
		logger.info("FAP 오픈잡페어 구직자 교육 지원자 신청 취소 서비스 시작");
		sfuDAO.open_pt_apply_cancel(fap_open_pt_apply_seq);
		ArrayList<HashMap<String, Object>> result = sfuDAO.user_open_edu_applied_list(user_id);
		logger.info("FAP 오픈잡페어 구직자 교육 지원자 신청 취소 서비스 종료");
		return result;
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
		logger.info("FAP 오픈잡페어 설명회 지원자 신청 리스트 조회 서비스 시작");
		ArrayList<HashMap<String, Object>> result = sfuDAO.user_open_pt_applied_list(user_id);
		logger.info("FAP 오픈잡페어 설명회 지원자 신청 리스트 조회 서비스 종료");
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
		logger.info("FAP 오픈잡페어 구직자교육 지원자 신청 리스트 조회 서비스 시작");
		ArrayList<HashMap<String, Object>> result = sfuDAO.user_open_edu_applied_list(user_id);
		logger.info("FAP 오픈잡페어 구직자교육 지원자 신청 리스트 조회 서비스 종료");
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
		logger.info("FAP 오픈잡페어 구직자 교육 지원자 이력서 리스트 조회 서비스 시작");
		ArrayList<SocietyFapUserResumeForm> result = sfuDAO.user_open_edu_resume_list_select(user_id);
		logger.info("FAP 오픈잡페어 구직자 교육 지원자 이력서 리스트 조회 서비스 종료");
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
		logger.info("FAP 노출 팝업 리스트 조회 서비스 시작");
		ArrayList<SocietyFapPopup> result = sfuDAO.user_popup_check();
		logger.info("FAP 노출 팝업 리스트 조회 서비스 종료");
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
		logger.info("FAP 오픈잡페어 지원자 메인페이지 기업배너 리스트 조회 서비스 시작");
		List<HashMap<String, Object>> result= sfuDAO.user_open_comp_banner_list(paramMap);
		logger.info("FAP 오픈잡페어 지원자 메인페이지 기업배너 리스트 조회 서비스 종료");
		return result;
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
		logger.info("FAP 오픈잡페어 지원자 게시판 이름 조회 서비스 시작");
		String result = sfuDAO.select_user_board_nm(board_detail_gb);
		logger.info("FAP 오픈잡페어 지원자 게시판 이름 조회 서비스 종료");
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
		logger.info("FAP 세부잡페어 구분 조회 서비스 시작");
		String result = sfuDAO.select_jobfair_divide_gb(fap_jobfair_divide_seq);
		logger.info("FAP 세부잡페어 구분 조회 서비스 종료");
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
		logger.info("설정된 메인페이지 기업컨텐츠 조회 서비스 시작");
		ArrayList<HashMap<String, Object>> result = sfuDAO.select_mainpage_context(paramMap);
		logger.info("설정된 메인페이지 기업컨텐츠 조회 서비스 종료");
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
		logger.info("해당 잡페어 참가 승인까지 완료했는 조회 서비스 시작");
		int result = sfuDAO.check_jobfair_join(params);
		logger.info("해당 잡페어 참가 승인까지 완료했는 조회 서비스 종료");
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
		logger.info("잡페어별 회원 지원동의(보증보험) 동의 등록 서비스 시작");
		int result =  sfuDAO.insert_user_apply_confirm(params);
		logger.info("잡페어별 회원 지원동의(보증보험) 동의 등록 서비스 종료");
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
		logger.info("FAP 도쿄페어 본인 일정 리스트 조회 서비스 시작");
		HashMap<String, Object> result = sfuDAO.tokyofair_schedule_user_list(params);
		logger.info("FAP 도쿄페어 본인 일정 리스트 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_user_flag
	 * @Date : 2021. 04. 16.
	 * @User : 안홍현
	 * @Param : 회원 아이디
	 * @Return : com_user_tb테이블의 user_flag
	 * @Method 설명 : user_id로 user_flag 검색
	 */
	public String select_user_flag(String user_id) {
		logger.info("User_flag 검색 시작");
		String user_flag = sfuDAO.select_user_flag(user_id);
		logger.info("User_flag 검색 종료");
		return user_flag;
	}
}
