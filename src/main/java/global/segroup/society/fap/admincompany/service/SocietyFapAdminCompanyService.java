/**
 * 
 */
package global.segroup.society.fap.admincompany.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import global.segroup.society.fap.admincommon.dao.SocietyFapAdminCommonDAO;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairApplyRule;
import global.segroup.society.fap.admincommon.domain.SocietyFapJobRecruitPcsSch;
import global.segroup.society.fap.admincommon.domain.SocietyFapJobfairApplicableTime;
import global.segroup.society.fap.admincompany.dao.SocietyFapAdminCompanyDAO;
import global.segroup.society.fap.company.domain.SocietyFapJobAd;
import global.segroup.society.fap.company.domain.SocietyFapJobCategory;
import global.segroup.society.fap.company.domain.SocietyFapJobComp;
import global.segroup.society.fap.company.domain.SocietyFapJobDorm;
import global.segroup.society.fap.company.domain.SocietyFapJobFile;
import global.segroup.society.fap.company.domain.SocietyFapJobIsr;
import global.segroup.society.fap.company.domain.SocietyFapJobJaLevel;
import global.segroup.society.fap.company.domain.SocietyFapJobJitEmployee;
import global.segroup.society.fap.company.domain.SocietyFapJobJoinDt;
import global.segroup.society.fap.company.domain.SocietyFapJobPay;
import global.segroup.society.fap.company.domain.SocietyFapJobPref;
import global.segroup.society.fap.company.domain.SocietyFapJobRecruitPcs;
import global.segroup.society.fap.company.domain.SocietyFapJobTrial;
import global.segroup.society.fap.company.domain.SocietyFapJobWork;
import global.segroup.society.fap.company.domain.SocietyFapJobWorkplace;
import global.segroup.util.FileService;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 20.
 * @Class 설명 : Soft Engineer Society 통합잡페어 관리자(기업기능담당) Service
 * 
 */
@Service
public class SocietyFapAdminCompanyService {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyFapAdminCompanyService.class);
	
	@Autowired
	private SocietyFapAdminCompanyDAO sfacDAO;
	
	@Autowired
	private SocietyFapAdminCommonDAO sfacmDAO;
	
	
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
	public void job_ad_insert(SocietyFapJobAd JobAd, SocietyFapJobDorm JobDorm, SocietyFapJobJitEmployee JobJitEmployee,
			SocietyFapJobJaLevel JobJaLevel, SocietyFapJobTrial JobTrial, SocietyFapJobComp JobComp, SocietyFapJobFile JobFile
			, SocietyFapJobIsr JobIsr, SocietyFapJobJoinDt JobJoinDt, SocietyFapJobWork JobWork, 
			SocietyFapJobCategory JobCategory, SocietyFapJobPref JobPref, SocietyFapJobWorkplace JobWorkplace,
			SocietyFapJobRecruitPcs JobRecruitPcs, SocietyFapJobPay JobPay) {
		logger.debug("채용공고 등록 시작");
				
				//동영상 파일이 있을 때
				if (JobFile.getJobFileList().get(0).getJob_ad_file() != null &&
						!JobFile.getJobFileList().get(0).getJob_ad_file().isEmpty()) {
					//동영상 파일이 있을 때 전에 파일을 삭제시켜주는 부분
					if(JobFile.getJobFileList().get(0).getFap_job_file_saved() != null){
						FileService.deleteFile(JobFile.getJobFileList().get(0).getFap_job_file_saved(), fapJobAdMovieFile);
						JobFile.getJobFileList().get(0).setFap_job_file_saved(null);
						JobFile.getJobFileList().get(0).setFap_job_file_origin(null);
					}
					UploadJobAdMovieServer(JobFile.getJobFileList().get(0));
				}
				//원래는 동영상 파일이 있었으나 유저가 삭제했을 때
				else {
					if(JobFile.getJobFileList().get(0).getFap_job_file_saved() != null 
							&& JobFile.getJobFileList().get(0).getFap_job_file_origin() == null){
						boolean isDelete = FileService.deleteFile(JobFile.getJobFileList().get(0).getFap_job_file_saved(), fapJobAdMovieFile);
						if(isDelete == true) {
							JobFile.getJobFileList().get(0).setFap_job_file_saved(null);
						}
					}
				}
		
				// pdf 파일이 있을 때
				if (JobFile.getJobFileList().get(1).getJob_ad_file() != null &&
						!JobFile.getJobFileList().get(1).getJob_ad_file().isEmpty()) {
					// pdf 파일이 있을 때 전에 파일을 삭제시켜주는 부분
					if(JobFile.getJobFileList().get(1).getFap_job_file_saved() != null){
						FileService.deleteFile(JobFile.getJobFileList().get(1).getFap_job_file_saved(), fapJobAdPdfFile);
						JobFile.getJobFileList().get(1).setFap_job_file_saved(null);
						JobFile.getJobFileList().get(1).setFap_job_file_origin(null);
					}
					UploadJobAdPdfServer(JobFile.getJobFileList().get(1));
				}
				//원래는 pdf 파일이 있었으나 유저가 삭제했을 때
				else {
					if(JobFile.getJobFileList().get(1).getFap_job_file_saved() != null 
							&& JobFile.getJobFileList().get(1).getFap_job_file_origin() == null){
						boolean isDelete = FileService.deleteFile(JobFile.getJobFileList().get(1).getFap_job_file_saved(), fapJobAdPdfFile);
						if(isDelete == true) {
							JobFile.getJobFileList().get(1).setFap_job_file_saved(null);
						}
					}
				}
				
				//사진 파일이 있을 때
				if (JobFile.getJobFileList().get(2).getJob_ad_file() != null &&
						!JobFile.getJobFileList().get(2).getJob_ad_file().isEmpty()) {
					//사진 파일이 있을 때 전에 파일을 삭제시켜주는 부분
					if(JobFile.getJobFileList().get(2).getFap_job_file_saved() != null){
						FileService.deleteFile(JobFile.getJobFileList().get(2).getFap_job_file_saved(), fapJobAdPhotoFile);
						JobFile.getJobFileList().get(2).setFap_job_file_saved(null);
						JobFile.getJobFileList().get(2).setFap_job_file_origin(null);
					}
					UploadJobAdPhotoServer(JobFile.getJobFileList().get(2));
				}
				//원래는 사진 파일이 있었으나 유저가 삭제했을 때
				else {
					if(JobFile.getJobFileList().get(2).getFap_job_file_saved() != null 
							&& JobFile.getJobFileList().get(2).getFap_job_file_origin() == null){
						boolean isDelete = FileService.deleteFile(JobFile.getJobFileList().get(2).getFap_job_file_saved(), fapJobAdPhotoFile);
						if(isDelete == true) {
							JobFile.getJobFileList().get(2).setFap_job_file_saved(null);
						}
					}
				}
				
		for(SocietyFapJobPay pay : JobPay.getJobPayList()){
			logger.info("!!!급여정보 : {}", pay);
		}
		
		// 시험 파일 저장
		// fullPath = 채용공고 seq _ 채용전형 seq
		String fullPath = "/" + JobAd.getFap_job_ad_seq() + "_" + JobRecruitPcs.getFap_job_recruit_pcs_seq();
		for(SocietyFapJobRecruitPcs RecruitPcs : JobRecruitPcs.getJobRecruitPcsList()){
			try{
				if(RecruitPcs.getJobExam().getJobExamFile().getFap_job_exam_file() != null){
					RecruitPcs.getJobExam().getJobExamFile().setFap_job_exam_file_origin(RecruitPcs.getJobExam().getJobExamFile().getFap_job_exam_file().getOriginalFilename());
					RecruitPcs.getJobExam().getJobExamFile().setFap_job_exam_file_saved(FileService.saveFile(RecruitPcs.getJobExam().getJobExamFile().getFap_job_exam_file(), fapJobRecruitExamFile + fullPath));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		sfacDAO.insert_job_ad(JobAd, JobDorm, JobJitEmployee, JobJaLevel, JobTrial, JobComp, JobFile, JobIsr, JobJoinDt, JobWork
				, JobCategory, JobPref, JobWorkplace, JobRecruitPcs, JobPay);
	
		logger.debug("채용공고 등록 종료");
	}
	
	
	/**
	 * @Method Name : select_job_pay
	 * @Date : 2019. 1. 10.
	 * @User : 원병호
	 * @Param : fap_job_ad_seq
	 * @Return : 급여 관련 모든 정보를 담은 map
	 * @Method 설명 : 급여 관련 모든 정보를 가져옵니다.
	 */
	public ArrayList<HashMap<String, Object>> select_job_pay(int fap_jop_ad_seq){
		return sfacDAO.select_job_pay(fap_jop_ad_seq);
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
		ArrayList<SocietyFapJobAd> jobAdList = sfacDAO.select_job_ad_list(fap_comp_id);
		logger.debug("FAP 채용공고 기본 정보 리스트 출력 Service 종료");
		return jobAdList;
	}

	/**
	 * @Method Name : selectJobAd
	 * @Date : 2019. 1. 10.
	 * @User : 이재준
	 * @Param : hashmap
	 * @Return : hashmap
	 * @Method 설명 : 
	 */
	public HashMap<String, Object> selectJobAd(HashMap<String, Object> param) {
		logger.debug("FAP 채용공고 상세정보 출력 Service 시작");
		HashMap<String, Object> jobAdList = sfacDAO.selectJobAd(param);
		logger.debug("FAP 채용공고 상세정보 출력 Service 시작");
		return jobAdList;
	}
	
	/**
	 * @Method Name : update_job_ad_state
	 * @Date : 2019. 1. 26.
	 * @User : 원병호, 정대영
	 * @Param : SocietyFapJobAd
	 * @Return : 
	 * @Method 설명 : 채용공고를 승인 및 최초 그룹코드 적용하고, 해당 채용전형의 스케쥴을 등록하는 Service
	 */
	@Transactional
	public boolean admin_approve_job_ad(SocietyFapJobAd jobAd, String admin_id){
		logger.debug("FAP 채용공고를 승인하는 서비스 시작");
		
		//들어온 공통코드가 진행중으로 들어오면 진행중으로 바꾼다는 것이기 때문에 승인이라고 판단, 그룹코드 적용해주고 승인처리 해준다.(정대영) - START
		if(jobAd.getFap_job_ad_state().equalsIgnoreCase("C2101")){
			//선택한 회사 그룹코드 관련정보 셀렉트(그룹코드 적용안된 회사만)
			HashMap<String, Object> curJobAdInfo = sfacDAO.select_current_job_ad_info_for_group_code(jobAd.getFap_job_ad_seq());
			if(curJobAdInfo != null && !curJobAdInfo.isEmpty()){
				//승인해주면서 그룹코드 적용해주는 부분
				ArrayList<HashMap<String, Object>> curJobFairGroupCode = sfacDAO.select_current_jobfair_group_code(jobAd.getFap_jobfair_seq());
				String toInsertGroupCode = "D0500";
				long fap_job_ad_stock = (long) curJobAdInfo.get("fap_job_ad_stock");
				long fap_job_ad_3years_avg_sales = (long) curJobAdInfo.get("fap_job_ad_3years_avg_sales");
				int fap_job_ad_employee_num = (int) curJobAdInfo.get("fap_job_ad_employee_num");
				
				for(HashMap<String, Object> groupCode : curJobFairGroupCode){
					String fap_comp_groupcode = (String) groupCode.get("fap_comp_groupcode");
					long fap_comp_stock = (long) groupCode.get("fap_comp_stock");
					long fap_comp_3years_avg_sales = (long) groupCode.get("fap_comp_3years_avg_sales");
					int fap_comp_employee_num = (int) groupCode.get("fap_comp_employee_num");
					if(fap_job_ad_stock >= fap_comp_stock && fap_job_ad_3years_avg_sales >= fap_comp_3years_avg_sales
							&& fap_job_ad_employee_num >= fap_comp_employee_num){
						
						toInsertGroupCode = fap_comp_groupcode;
						break;
					}
				}
				jobAd.setFap_job_ad_groupcode(toInsertGroupCode);	
			}
			
			//이미 지원룰 대상인지 여부 확인
			int ruleCount = sfacDAO.select_jobfair_apply_rule_count(jobAd.getFap_job_ad_seq());
			if(ruleCount == 0) {
				//지원가능 시간 시퀀스 조회
				Long fap_jobfair_applicable_time_seq = sfacDAO.select_jobfair_applicable_time(jobAd.getFap_job_ad_seq());
				
				if(fap_jobfair_applicable_time_seq != null) {
					//지원룰 테이블에 해당 채용공고 등록
					SocietyFapAdminJobfairApplyRule rule = new SocietyFapAdminJobfairApplyRule();
					rule.setFap_job_ad_seq(jobAd.getFap_job_ad_seq());
					rule.setFap_jobfair_applicable_time_seq(fap_jobfair_applicable_time_seq);
					rule.setFap_jobfair_apply_rule_ins_id(admin_id);
					rule.setFap_jobfair_apply_rule_udt_id(admin_id);
					
					sfacDAO.insert_jobfair_apply_rule(rule);
				}else {
					return false;
				}
				
			}
		}
		//승인 취소
		else if(jobAd.getFap_job_ad_state().equalsIgnoreCase("C2100")) {
			sfacDAO.delete_jobfair_apply_rule(jobAd.getFap_job_ad_seq());
		}
		
		
		
		//이미 지원가능인원이 설정되어있는지 여부 확인
		int cntFlag = sfacDAO.admin_select_flag_apply_nums_per_ad(jobAd.getFap_job_ad_seq());
		if(cntFlag == 0){
			//지원가능인원 insert 부분
			jobAd.setFap_comp_id(admin_id);
			sfacDAO.admin_insert_apply_nums_per_ad(jobAd);
		}
		
		//이미 현지면접인원이 설정되어있는지 여부 확인
		int itvFlag = sfacDAO.admin_select_flag_itv_nums_per_ad(jobAd.getFap_job_ad_seq());
		if(itvFlag == 0) {
			//현지면접인원 insert 부분
			jobAd.setFap_comp_id(admin_id);
			sfacDAO.admin_insert_itv_nums_per_ad(jobAd);
		}
		
		//채용공고 상태 수정 : 승인
		sfacDAO.admin_update_job_ad_state(jobAd);
		// - END
		
		
		//승인한 채용공고의 스케줄 등록 - START
		//승인한 채용공고의 전형 리스트
		ArrayList<SocietyFapJobRecruitPcs> pcs_list = sfacmDAO.search_approved_job_recruit_pcs(jobAd.getFap_job_ad_seq());
		
		//각 채용전형에 해당하는 스케줄을 등록하는 for문
		for(SocietyFapJobRecruitPcs pcs : pcs_list){ 
			//재승인일경우 이미등록된 스케줄이 있으면 continue 해준다.
			SocietyFapJobRecruitPcsSch sch_ex = sfacmDAO.select_job_recruit_pcs_sch_by_seq(pcs.getFap_job_recruit_pcs_seq());
			if(sch_ex != null && !(sch_ex.getFap_job_recruit_pcs_sch_seq() == 0)){
				continue;
			}
			SocietyFapJobRecruitPcsSch sch = new SocietyFapJobRecruitPcsSch();	//등록할 스케줄의 정보를 담을 객체
			
			//서류전형 스케줄 등록
			if(pcs.getFap_job_recruit_pcs_gb() != null && pcs.getFap_job_recruit_pcs_gb().equals("C2500")){
				SocietyFapJobfairApplicableTime time = sfacmDAO.search_approved_review_pcs_date(jobAd.getFap_job_ad_seq());
				sch.setFap_job_recruit_pcs_seq(pcs.getFap_job_recruit_pcs_seq());
				try {
					sch.setFap_job_recruit_pcs_sch_st(time.getFap_jobfair_applicable_time_st());
				} catch (Exception e) {
					sch.setFap_job_recruit_pcs_sch_st(null);
				}
				try {
					sch.setFap_job_recruit_pcs_sch_et(time.getFap_jobfair_applicable_time_et());
				} catch (Exception e) {
					sch.setFap_job_recruit_pcs_sch_et(null);
				}
				
				sch.setFap_job_recruit_pcs_sch_detail(pcs.getFap_job_recruit_pcs_dtl());
				sch.setFap_job_recruit_pcs_sch_ins_id(admin_id);
				sch.setFap_job_recruit_pcs_sch_udt_id(admin_id);
				sfacmDAO.insert_approved_review_pcs(sch);
			//그외 전형 등록
			}else{
				sch.setFap_job_recruit_pcs_seq(pcs.getFap_job_recruit_pcs_seq());
				sch.setFap_job_recruit_pcs_sch_ins_id(admin_id);
				sch.setFap_job_recruit_pcs_sch_udt_id(admin_id);
				sfacmDAO.insert_approved_recruit_pcs(sch);
			}
		}
		// - END
		
		logger.debug("FAP 채용공고를 승인하는 서비스 끝");
		
		return true;
	}
	
	/**
	 * @Method Name : admin_select_per_state_job_ad_list
	 * @Date : 2019. 2. 12.
	 * @User : 정대영
	 * @Param : 잡페어 시퀀스, 잡페어세부 시퀀스
	 * @Return : HashMapList(회사별 진행중인 잡페어 리스트)
	 * @Method 설명 : FAP 관리자 채용공고 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> admin_select_per_state_job_ad_list(HashMap<String, Object> parmas){
		logger.debug("FAP 관리자 채용공고 리스트 검색 Service 시작");
		ArrayList<HashMap<String, Object>> result = sfacDAO.admin_select_per_state_job_ad_list(parmas);
		logger.debug("FAP 관리자 채용공고 리스트 검색 Service 종료");
		return result;
	}

	/**
	 * @Method Name : admin_company_group_code_management_per_job_fair
	 * @Date : 2019.2.25 
	 * @User : 남유송
	 * @Param : -
	 * @Return : 기업 그룹코드 설정 JSP
	 * @Method 설명 : 기업 그룹코드 설정 페이지로 이동 
	 */
	public ArrayList<HashMap<String, Object>> select_current_jobfair_group_code(int fap_jobfair_seq) {
		ArrayList<HashMap<String, Object>> companyGroupcodeList = sfacDAO.select_current_jobfair_group_code(fap_jobfair_seq);
		return companyGroupcodeList;
	}

	/**
	 * @Method Name : change_groupcode
	 * @Date : 2019.02.26
	 * @User : 남유송
	 * @Param : Hashmap
	 * @Return : -
	 * @Method 설명 : 그룹코드 업데이트
	 */
	public void admin_update_groupcode(HashMap<String, Object> params) {
		logger.info("기업 그룹코드 업데이트 Service 시작");
		sfacDAO.admin_update_groupcode(params);
		logger.info("기업 그룹코드 업데이트 Service 종료");
	}
	
	/**
	 * @Method Name : update_rank
	 * @Date : 2021.03.09
	 * @User : 안홍현
	 * @Param : Hashmap
	 * @Return : -
	 * @Method 설명 : 순위 변경
	 */
	public int admin_update_rank(HashMap<String, Object> params) {
		logger.info("기업 그룹순위 업데이트 Service 시작");
		int res = sfacDAO.admin_update_rank(params);
		logger.info("기업 그룹순위 업데이트 Service 종료");
		return res;
	}

	/**
	 * @Method Name : select_count_per_group
	 * @Date : 2019.02.26
	 * @User : 남유송
	 * @Param : int
	 * @Return : ArrayList
	 * @Method 설명 : 각 기업그룹코드 별 갯수
	 */
	public ArrayList<HashMap<String, Object>> select_count_per_group(int fap_jobfair_divide_seq) {
		logger.info("기업 그룹코드 갯수 가져오기 Service 시작");
		ArrayList<HashMap<String, Object>> count_per_group = sfacDAO.select_count_per_group(fap_jobfair_divide_seq);
		logger.info("기업 그룹코드 갯수 가져오기 Service 종료");
		return count_per_group;
	}
	
	/**
	 * @Method Name : admin_job_app_per_update
	 * @Date : 2019. 2. 27.
	 * @User : 이종호
	 * @Param : 지원가능인원 시퀀스 , 지원가능 인원 수
	 * @Return : -
	 * @Method 설명 : FAP 관리자 채용공고 지원가능인원 수정
	 */
	public void admin_job_app_per_update(HashMap<String, Object> parmas) {
		logger.info("FAP 관리자 채용공고 지원가능인원 수정 시작");
		sfacDAO.admin_job_app_per_update(parmas);
		logger.info("FAP 관리자 채용공고 지원가능인원 수정 끝");
	}
	
	/**
	 * @Method Name : admin_job_itv_per_update
	 * @Date : 2019. 7. 31.
	 * @User : 이종호
	 * @Param : 현지제한인원 시퀀스 , 인원수
	 * @Return :  -
	 * @Method 설명 : FAP 관리자 채용공고 현지제한인원 수정 
	 */
	public void admin_job_itv_per_update(HashMap<String, Object> params) {
		logger.info("FAP 관리자 채용공고 현지제한인원 수정 서비스 시작");
		sfacDAO.admin_job_itv_per_update(params);
		logger.info("FAP 관리자 채용공고 현지제한인원 수정 서비스 종료");
	}
	
	/**
	 * @Method Name : admin_update_mismatching
	 * @Date : 2019. 2. 27.
	 * @User : 이재준
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : FAP 관리자 미스매칭/일반지원 수정
	 */
	public void admin_update_mismatching(HashMap<String, Object> params) {
		logger.info("FAP 관리자 미스매칭/일반지원 수정 Service 시작");
		sfacDAO.admin_update_mismatching(params);
		logger.info("FAP 관리자 미스매칭/일반지원 수정 Service 종료");
	}
	
	/**
	 * @Method Name : admin_job_apply_approval_yet
	 * @Date : 2019. 4. 26.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스, 회사 아이디
	 * @Return : FAP 관리자 기업별 지원자 리스트 승인전 지원자 리스트
	 * @Method 설명 : FAP 관리자 기업별 지원자 리스트 승인전 지원자 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> admin_job_apply_approval_yet(HashMap<String, Object> params){
		logger.info("FAP 관리자 기업별 지원자 리스트 승인전 지원자 리스트 조회 Service 시작");
		ArrayList<HashMap<String, Object>> result = sfacDAO.admin_job_apply_approval_yet(params);
		logger.info("FAP 관리자 기업별 지원자 리스트 승인전 지원자 리스트 조회 Service 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_user_nm
	 * @Date : 2019. 9. 3.
	 * @User : 김경아	
	 * @Param : id
	 * @Return : 
	 * @Method 설명 : id에 따른 이름 출력
	 */
	public HashMap<String, Object> select_comp_nm(String fap_comp_id) {
		logger.info("FAP id에 따른 이름 출력 서비스 시작");
		HashMap<String, Object> result = sfacDAO.select_comp_nm(fap_comp_id);
		logger.info("FAP id에 따른 이름 출력 서비스 종료");
		return result;
	}
	/**
	 * @Method Name : allow_common_user
	 * @Date : 2021.05.18
	 * @User : 김나영
	 * @Param : Hashmap
	 * @Return : -
	 * @Method 설명 : 잡페어 관리자 그룹코드 일반회원 지원 허용
	 */
	public int allow_common_user_yn(HashMap<String, Object> params) {
		logger.info("잡페어 관리자 그룹코드 일반회원 지원 허용 서비스 시작");
		int result = sfacDAO.allow_common_user_yn(params);
		logger.info("잡페어 관리자 그룹코드 일반회원 지원 허용 서비스 시작");
		return result;
	}

 
 
	
}
