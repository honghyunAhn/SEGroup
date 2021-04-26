/**
 * 
 */
package global.segroup.society.fap.admincommon.service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;

import global.segroup.domain.BoardContent;
import global.segroup.domain.BoardFile;
import global.segroup.domain.BoardGroup;
import global.segroup.domain.FaqConsultingContents;
import global.segroup.domain.User;
import global.segroup.society.fap.admincommon.dao.SocietyFapAdminCommonDAO;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminFaqGb;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminFinalDecisionTime;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfair;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairApply;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairCompGroup;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairDivide;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairDivideRc;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairLo;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairSet;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairSetDate;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairSetTime;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminLimitInterview;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminNoticeAlim;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminNoticeContent;
import global.segroup.society.fap.admincommon.domain.SocietyFapJobRecruitPcsSch;
import global.segroup.society.fap.admincommon.domain.SocietyFapJobfairApplicableTime;
import global.segroup.society.fap.admincommon.domain.SocietyFapMainpageContent;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenJobInfo;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenPt;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenPtResume;
import global.segroup.society.fap.admincommon.domain.SocietyFapPerJobfairDivideTemp;
import global.segroup.society.fap.admincommon.domain.SocietyFapPerJobfairTempGroup;
import global.segroup.society.fap.admincommon.domain.SocietyFapPopup;
import global.segroup.society.fap.company.dao.SocietyFapCompanyDAO;
import global.segroup.society.fap.company.domain.SocietyFapCompanyUser;
import global.segroup.society.fap.company.domain.SocietyFapJobAd;
import global.segroup.society.fap.company.domain.SocietyFapJobAdShow;
import global.segroup.society.fap.company.domain.SocietyFapJobExam;
import global.segroup.society.fap.company.domain.SocietyFapJobExamFile;
import global.segroup.society.fap.company.domain.SocietyFapJobExamNeedEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobExamObjEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobExamSvEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobExamType;
import global.segroup.society.fap.company.domain.SocietyFapJobItv;
import global.segroup.society.fap.company.domain.SocietyFapJobItvObjEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobItvTpEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobRecruitPcs;
import global.segroup.society.fap.company.domain.SocietyFapJobTestEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobTestEtcObj;
import global.segroup.society.fap.company.domain.SocietyFapTokyofairScreening;
import global.segroup.society.fap.companyroadmap.domain.SocietyFapCompanyRoadmapJobfairDivide;
import global.segroup.society.fap.user.domain.SocietyFapPersonalGraduate;
import global.segroup.society.fap.user.domain.SocietyFapPersonalHighschool;
import global.segroup.society.fap.user.domain.SocietyFapPersonalUniversity;
import global.segroup.society.fap.user.domain.SocietyFapPersonalUser;
import global.segroup.society.fap.user.domain.SocietyFapUserApplyNumbers;
import global.segroup.util.FileService;
import global.segroup.util.PageNavigator;

/**
 * @Author : 신동철
 * @Date : 2018. 11. 29.
 * @Class 설명 : Soft Engineer Society 통합잡페어 관리자 서비스
 * 
 */
@Service
public class SocietyFapAdminCommonService {

	private static final Logger logger = LoggerFactory.getLogger(SocietyFapAdminCommonService.class);

	@Autowired
	private SocietyFapAdminCommonDAO sfaDAO;
	
	@Autowired
	private SocietyFapCompanyDAO sfcDAO;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Value("#{props['fap.admin.jobfair_logo_image']}")
	private String fapAdminJobfairLogoImage;
	
	@Value("#{props['fap.company.user.logo_image']}")
	private String fapCompanyUserLogoImage;
	
	@Value("#{props['fap.company.job_recruit_exam_file']}")
	private String fapCompanyJobRecruitExamFile;

	@Value("#{props['fap.admin.notice_file']}")
	private String fapAdminNoticeFile;
	
	@Value("#{props['fap.admin.popup_file']}")
	private String fapAdminPopupFile;
	
	@Value("#{props['fap.admin.job_info_file']}")
	private String fapAdminJobInfoFile;
		
	/**
	 * @Method Name : UploadFileServer
	 * @Date : 2018. 12. 11.
	 * @User : 신동철
	 * @Param : 잡페어 객체
	 * @Return : -
	 * @Method 설명 : 잡페어 등록시 로고 파일 서버 저장
	 */
	private void UploadFileServer(SocietyFapAdminJobfair sfaJobfair) {
		try {
			if (sfaJobfair.getFap_jobfair_log_file() != null) {
				sfaJobfair.setFap_jobfair_log_origin(sfaJobfair.getFap_jobfair_log_file().getOriginalFilename());
				sfaJobfair.setFap_jobfair_log_saved(FileService.saveFile(sfaJobfair.getFap_jobfair_log_file(), fapAdminJobfairLogoImage));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @Method Name : insert_Jobfair
	 * @Date : 2018. 12. 11.
	 * @User : 신동철
	 * @Param : 잡페어 객체
	 * @Return : -
	 * @Method 설명 : 잡페어 등록을 하는 함수
	 */
	@Transactional
	public void insert_Jobfair(SocietyFapAdminJobfair sfaJobfair, SocietyFapAdminJobfairDivide sfaJobfairDivide, SocietyFapAdminJobfairLo sfaJobfairLo, 
			SocietyFapAdminJobfairDivideRc sfaJobfairDivideRc, SocietyFapAdminJobfairCompGroup sfaJobfairCompGroup, SocietyFapJobfairApplicableTime jobfairapplicableTime, SocietyFapAdminLimitInterview limitInterview){
		logger.info("FAP 잡페어 등록 서비스 시작");		
		
		SocietyFapAdminJobfairDivide sfaKfair = new SocietyFapAdminJobfairDivide();
		SocietyFapAdminJobfairDivide sfaJfair= new SocietyFapAdminJobfairDivide();
		SocietyFapAdminJobfairDivide sfaPostSeason = new SocietyFapAdminJobfairDivide();		
		ArrayList<SocietyFapAdminJobfairLo> sfaJobfairLoList = new ArrayList<>();
		ArrayList<SocietyFapAdminJobfairDivideRc> sfaKfairRcList = new ArrayList<>();
		ArrayList<SocietyFapAdminJobfairDivideRc> sfaJfairRcList = new ArrayList<>();
		ArrayList<SocietyFapAdminJobfairDivideRc> sfaPostSeasonRcList = new ArrayList<>();
		ArrayList<SocietyFapAdminJobfairCompGroup> sfaCompGroupList = new ArrayList<>();
		//SocietyFapAdminJobfairDivide sfaMissmatching = new SocietyFapAdminJobfairDivide();
		//ArrayList<SocietyFapAdminJobfairDivideRc> sfaMissmatchingRcList = new ArrayList<>();
		
		
		// 잡페어 로고 파일 저장
		UploadFileServer(sfaJobfair);		
		// 잡페어 기본 정보 등록
		sfaDAO.insert_jobfair(sfaJobfair);
		// 잡페어 지원가능 인원 등록
		sfaDAO.insert_apply_max_num(sfaJobfair);
		
		// 잡페어 현지면접 인원제한 등록
		limitInterview.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
		sfaDAO.insert_limit_interview(limitInterview);
		
		// 잡페어 회사그룹 정보 설정
		for(int i = 0; i < sfaJobfairCompGroup.getFap_comp_group_list().size(); i++){
			sfaJobfairCompGroup.getFap_comp_group_list().get(i).setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
			sfaJobfairCompGroup.getFap_comp_group_list().get(i).setFap_comp_group_ins_id(sfaJobfair.getFap_jobfair_ins_id());
			sfaJobfairCompGroup.getFap_comp_group_list().get(i).setFap_comp_group_udt_id(sfaJobfair.getFap_jobfair_udt_id());
			sfaCompGroupList.add(sfaJobfairCompGroup.getFap_comp_group_list().get(i));			
		}
		// 잡페어 회사그룹 정보 등록
		sfaDAO.insert_comp_group_set(sfaCompGroupList);
		
		// 잡페어 개최지 정보 설정
		for(int i= 0; i < sfaJobfairLo.getFap_jobfair_lo_list().size(); i++){			
			if(sfaJobfairLo.getFap_jobfair_lo_list().get(i).getFap_jobfair_lo() != null){
				SocietyFapAdminJobfairLo newSfaJobfairLo = new SocietyFapAdminJobfairLo();
				newSfaJobfairLo.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
				newSfaJobfairLo.setFap_jobfair_lo(sfaJobfairLo.getFap_jobfair_lo_list().get(i).getFap_jobfair_lo());
				sfaJobfairLoList.add(newSfaJobfairLo);
			}
		}
		// 잡페어 개최지 정보 등록
		sfaDAO.insert_jobfair_lo(sfaJobfairLoList);
		
		// 잡페어 세부 정보 설정
		for(int i = 0; i < sfaJobfairDivide.getFap_jobfair_divide_gb_list().size(); i++){
			if(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb() != null) {
				//K-fair 세부 정보 설정
				 if(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb().equals("C0100")){
					 sfaKfair.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
					 sfaKfair.setFap_jobfair_divide_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_st());
					 sfaKfair.setFap_jobfair_divide_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_et());
					 sfaKfair.setFap_jobfair_divide_app_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_st());
					 sfaKfair.setFap_jobfair_divide_app_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_et());
					 sfaKfair.setFap_jobfair_divide_app_num(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_num());
					 sfaKfair.setFap_jobfair_divide_detail(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_detail());
					 sfaKfair.setFap_jobfair_divide_gb(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb());
					 sfaKfair.setFap_jobfair_divide_gb_eps(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb_eps());
					 sfaKfair.setFap_jobfair_divide_ins_id(sfaJobfair.getFap_jobfair_ins_id());
					 sfaKfair.setFap_jobfair_divide_udt_id(sfaJobfair.getFap_jobfair_udt_id());
					//K-fair 세부 정보 등록
					sfaDAO.insert_jobfair_divide(sfaKfair);
					
					//K-fair 세부채용대상 정보 설정
					for(int j = 0; j < sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().size(); j++){
						if(sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().get(j).getFap_jobfair_divide_rc() != null){
							SocietyFapAdminJobfairDivideRc newSfaJobfairDivideRc = new SocietyFapAdminJobfairDivideRc();
							newSfaJobfairDivideRc.setFap_jobfair_divide_seq(sfaKfair.getFap_jobfair_divide_seq());
							newSfaJobfairDivideRc.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
							newSfaJobfairDivideRc.setFap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().get(j).getFap_jobfair_divide_rc());
							sfaKfairRcList.add(newSfaJobfairDivideRc);
						}
					}
					//K-fair 세부채용대상 등록
					sfaDAO.insert_jobfair_divide_rc(sfaKfairRcList);
					
					//K-fair 지원자 지원가능시간 설정
					for(int j = 0; j < jobfairapplicableTime.getFap_k_fair_applicable_time_list().size(); j++){
						if(jobfairapplicableTime.getFap_k_fair_applicable_time_list().get(j).getFap_jobfair_divide_user_date_st() != null){
							jobfairapplicableTime.getFap_k_fair_applicable_time_list().get(j).setFap_jobfair_divide_seq(sfaKfair.getFap_jobfair_divide_seq());
							jobfairapplicableTime.getFap_k_fair_applicable_time_list().get(j).setFap_jobfair_applicable_time_ins_id(sfaKfair.getFap_jobfair_divide_ins_id());
							jobfairapplicableTime.getFap_k_fair_applicable_time_list().get(j).setFap_jobfair_applicable_time_udt_id(sfaKfair.getFap_jobfair_divide_udt_id());
							String date_st = jobfairapplicableTime.getFap_k_fair_applicable_time_list().get(j).getFap_jobfair_divide_user_date_st();
							String time_st = jobfairapplicableTime.getFap_k_fair_applicable_time_list().get(j).getFap_jobfair_divide_user_time_st();
							String date_et = jobfairapplicableTime.getFap_k_fair_applicable_time_list().get(j).getFap_jobfair_divide_user_date_et();
							String time_et = jobfairapplicableTime.getFap_k_fair_applicable_time_list().get(j).getFap_jobfair_divide_user_time_et();
							jobfairapplicableTime.getFap_k_fair_applicable_time_list().get(j).setFap_jobfair_applicable_time_st(date_st + " " + time_st);
							jobfairapplicableTime.getFap_k_fair_applicable_time_list().get(j).setFap_jobfair_applicable_time_et(date_et + " " + time_et);
						}						
					}
					//K-fair 지원자 지원가능시간 등록
					sfaDAO.insert_jobfair_applicable_time(jobfairapplicableTime.getFap_k_fair_applicable_time_list());
				 }
				
				//J-fair 세부 정보 설정
				 if(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb().equals("C0101")){
					 sfaJfair.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
					 sfaJfair.setFap_jobfair_divide_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_st());
					 sfaJfair.setFap_jobfair_divide_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_et());
					 sfaJfair.setFap_jobfair_divide_app_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_st());
					 sfaJfair.setFap_jobfair_divide_app_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_et());
					 sfaJfair.setFap_jobfair_divide_app_num(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_num());
					 sfaJfair.setFap_jobfair_divide_detail(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_detail());
					 sfaJfair.setFap_jobfair_divide_gb(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb());
					 sfaJfair.setFap_jobfair_divide_gb_eps(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb_eps());
					 sfaJfair.setFap_jobfair_divide_ins_id(sfaJobfair.getFap_jobfair_ins_id());
					 sfaJfair.setFap_jobfair_divide_udt_id(sfaJobfair.getFap_jobfair_udt_id());
					//J-fair 세부 정보 등록
					sfaDAO.insert_jobfair_divide(sfaJfair);
					
					//J-fair 세부채용대상 정보 설정
					for(int j = 0; j < sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().size(); j++){
						if(sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().get(j).getFap_jobfair_divide_rc() != null){
							SocietyFapAdminJobfairDivideRc newSocietyFapAdminJobfairDivideRc = new SocietyFapAdminJobfairDivideRc();
							newSocietyFapAdminJobfairDivideRc.setFap_jobfair_divide_seq(sfaJfair.getFap_jobfair_divide_seq());
							newSocietyFapAdminJobfairDivideRc.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
							newSocietyFapAdminJobfairDivideRc.setFap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().get(j).getFap_jobfair_divide_rc());
							sfaJfairRcList.add(newSocietyFapAdminJobfairDivideRc);
						}
					}
					//J-fair 세부채용대상 등록
					sfaDAO.insert_jobfair_divide_rc(sfaJfairRcList);
					
					//J-fair 지원가능시간 설정
					for(int j = 0; j < jobfairapplicableTime.getFap_j_fair_applicable_time_list().size(); j++){
						if(jobfairapplicableTime.getFap_j_fair_applicable_time_list().get(j).getFap_jobfair_divide_user_date_st() != null){
							jobfairapplicableTime.getFap_j_fair_applicable_time_list().get(j).setFap_jobfair_divide_seq(sfaJfair.getFap_jobfair_divide_seq());
							jobfairapplicableTime.getFap_j_fair_applicable_time_list().get(j).setFap_jobfair_applicable_time_ins_id(sfaJfair.getFap_jobfair_divide_ins_id());
							jobfairapplicableTime.getFap_j_fair_applicable_time_list().get(j).setFap_jobfair_applicable_time_udt_id(sfaJfair.getFap_jobfair_divide_udt_id());
							String date_st = jobfairapplicableTime.getFap_j_fair_applicable_time_list().get(j).getFap_jobfair_divide_user_date_st();
							String time_st = jobfairapplicableTime.getFap_j_fair_applicable_time_list().get(j).getFap_jobfair_divide_user_time_st();
							String date_et = jobfairapplicableTime.getFap_j_fair_applicable_time_list().get(j).getFap_jobfair_divide_user_date_et();
							String time_et = jobfairapplicableTime.getFap_j_fair_applicable_time_list().get(j).getFap_jobfair_divide_user_time_et();
							jobfairapplicableTime.getFap_j_fair_applicable_time_list().get(j).setFap_jobfair_applicable_time_st(date_st + " " + time_st);
							jobfairapplicableTime.getFap_j_fair_applicable_time_list().get(j).setFap_jobfair_applicable_time_et(date_et + " " + time_et);
						}
					}
					//J-fair 지원자 지원가능시간 등록
					sfaDAO.insert_jobfair_applicable_time(jobfairapplicableTime.getFap_j_fair_applicable_time_list());
				 }
				 
				//포스트시즌 세부 정보 설정
				 if(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb().equals("C0102")){
					 sfaPostSeason.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
					 sfaPostSeason.setFap_jobfair_divide_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_st());
					 sfaPostSeason.setFap_jobfair_divide_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_et());
					 sfaPostSeason.setFap_jobfair_divide_app_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_st());
					 sfaPostSeason.setFap_jobfair_divide_app_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_et());
					 sfaPostSeason.setFap_jobfair_divide_app_num(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_num());
					 sfaPostSeason.setFap_jobfair_divide_detail(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_detail());
					 sfaPostSeason.setFap_jobfair_divide_gb(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb());
					 sfaPostSeason.setFap_jobfair_divide_gb_eps(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb_eps());
					 sfaPostSeason.setFap_jobfair_divide_ins_id(sfaJobfair.getFap_jobfair_ins_id());
					 sfaPostSeason.setFap_jobfair_divide_udt_id(sfaJobfair.getFap_jobfair_udt_id());
					//포스트시즌 세부 정보 등록
					sfaDAO.insert_jobfair_divide(sfaPostSeason);
					
					//포스트시즌 세부채용대상 정보 설정
					for(int j = 0; j < sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().size(); j++){
						if(sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().get(j).getFap_jobfair_divide_rc() != null){
							SocietyFapAdminJobfairDivideRc newSfaJobfairDivideRc = new SocietyFapAdminJobfairDivideRc();
							newSfaJobfairDivideRc.setFap_jobfair_divide_seq(sfaPostSeason.getFap_jobfair_divide_seq());
							newSfaJobfairDivideRc.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
							newSfaJobfairDivideRc.setFap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().get(j).getFap_jobfair_divide_rc());
							sfaPostSeasonRcList.add(newSfaJobfairDivideRc);
						}
					}
					//포스트시즌 세부채용대상 등록
					sfaDAO.insert_jobfair_divide_rc(sfaPostSeasonRcList);
					
					//포스트시즌 지원자 지원가능시간 설정
					for(int j = 0; j < jobfairapplicableTime.getFap_post_season_applicable_time_list().size(); j++){
						if(jobfairapplicableTime.getFap_post_season_applicable_time_list().get(j).getFap_jobfair_divide_user_date_st() != null){
							jobfairapplicableTime.getFap_post_season_applicable_time_list().get(j).setFap_jobfair_divide_seq(sfaPostSeason.getFap_jobfair_divide_seq());
							jobfairapplicableTime.getFap_post_season_applicable_time_list().get(j).setFap_jobfair_applicable_time_ins_id(sfaPostSeason.getFap_jobfair_divide_ins_id());
							jobfairapplicableTime.getFap_post_season_applicable_time_list().get(j).setFap_jobfair_applicable_time_udt_id(sfaPostSeason.getFap_jobfair_divide_udt_id());
							String date_st = jobfairapplicableTime.getFap_post_season_applicable_time_list().get(j).getFap_jobfair_divide_user_date_st();
							String time_st = jobfairapplicableTime.getFap_post_season_applicable_time_list().get(j).getFap_jobfair_divide_user_time_st();
							String date_et = jobfairapplicableTime.getFap_post_season_applicable_time_list().get(j).getFap_jobfair_divide_user_date_et();
							String time_et = jobfairapplicableTime.getFap_post_season_applicable_time_list().get(j).getFap_jobfair_divide_user_time_et();
							jobfairapplicableTime.getFap_post_season_applicable_time_list().get(j).setFap_jobfair_applicable_time_st(date_st + " " + time_st);
							jobfairapplicableTime.getFap_post_season_applicable_time_list().get(j).setFap_jobfair_applicable_time_et(date_et + " " + time_et);
						}
					}
					//포스트시즌 지원자 지원가능시간 등록
					sfaDAO.insert_jobfair_applicable_time(jobfairapplicableTime.getFap_post_season_applicable_time_list());
				 }				
				 
				/*//미스매칭 세부 정보 설정
				 if(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb().equals("C0103")){
					 sfaMissmatching.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
					 sfaMissmatching.setFap_jobfair_divide_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_st());
					 sfaMissmatching.setFap_jobfair_divide_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_et());
					 sfaMissmatching.setFap_jobfair_divide_app_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_st());
					 sfaMissmatching.setFap_jobfair_divide_app_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_et());
					 sfaMissmatching.setFap_jobfair_divide_app_num(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_num());
					 sfaMissmatching.setFap_jobfair_divide_detail(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_detail());
					 sfaMissmatching.setFap_jobfair_divide_gb(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb());
					 sfaMissmatching.setFap_jobfair_divide_gb_eps(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb_eps());
					 sfaMissmatching.setFap_jobfair_divide_ins_id(sfaJobfair.getFap_jobfair_ins_id());
					 sfaMissmatching.setFap_jobfair_divide_udt_id(sfaJobfair.getFap_jobfair_udt_id());
					//미스매칭 세부 정보 등록
					sfaDAO.insert_jobfair_divide(sfaMissmatching);
					
					//미스매칭 세부채용대상 정보 설정
					for(int j = 0; j < sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().size(); j++){
						if(sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().get(j).getFap_jobfair_divide_rc() != null){
							SocietyFapAdminJobfairDivideRc newSocietyFapAdminJobfairDivideRc = new SocietyFapAdminJobfairDivideRc();
							newSocietyFapAdminJobfairDivideRc.setFap_jobfair_divide_seq(sfaMissmatching.getFap_jobfair_divide_seq());
							newSocietyFapAdminJobfairDivideRc.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
							newSocietyFapAdminJobfairDivideRc.setFap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().get(j).getFap_jobfair_divide_rc());							
							sfaMissmatchingRcList.add(newSocietyFapAdminJobfairDivideRc);
						}
					}
					//미스매칭 세부채용대상 등록
					sfaDAO.insert_jobfair_divide_rc(sfaMissmatchingRcList);
					
					//미스매칭 지원자 지원가능시간 설정
					for(int j = 0; j < jobfairapplicableTime.getFap_missmatching_applicable_time_list().size(); j++){
						if(jobfairapplicableTime.getFap_missmatching_applicable_time_list().get(j).getFap_jobfair_divide_user_date_st() != null){
							jobfairapplicableTime.getFap_missmatching_applicable_time_list().get(j).setFap_jobfair_divide_seq(sfaMissmatching.getFap_jobfair_divide_seq());
							jobfairapplicableTime.getFap_missmatching_applicable_time_list().get(j).setFap_jobfair_applicable_time_ins_id(sfaMissmatching.getFap_jobfair_divide_ins_id());
							jobfairapplicableTime.getFap_missmatching_applicable_time_list().get(j).setFap_jobfair_applicable_time_udt_id(sfaMissmatching.getFap_jobfair_divide_udt_id());
							String date_st = jobfairapplicableTime.getFap_missmatching_applicable_time_list().get(j).getFap_jobfair_divide_user_date_st();
							String time_st = jobfairapplicableTime.getFap_missmatching_applicable_time_list().get(j).getFap_jobfair_divide_user_time_st();
							String date_et = jobfairapplicableTime.getFap_missmatching_applicable_time_list().get(j).getFap_jobfair_divide_user_date_et();
							String time_et = jobfairapplicableTime.getFap_missmatching_applicable_time_list().get(j).getFap_jobfair_divide_user_time_et();
							jobfairapplicableTime.getFap_missmatching_applicable_time_list().get(j).setFap_jobfair_applicable_time_st(date_st + " " + time_st);
							jobfairapplicableTime.getFap_missmatching_applicable_time_list().get(j).setFap_jobfair_applicable_time_et(date_et + " " + time_et);
						}
					}
					//미스매칭 지원자 지원가능시간 등록
					sfaDAO.insert_jobfair_applicable_time(jobfairapplicableTime.getFap_missmatching_applicable_time_list());
				 }*/
				 
			}
		}
		
		logger.info("FAP 잡페어 등록 서비스 종료");
	}
	
	/**
	 * @Method Name : update_Jobfair
	 * @Date : 2018. 12. 11.
	 * @User : 신동철
	 * @Param : 잡페어 객체
	 * @Return : -
	 * @Method 설명 : 잡페어 수정을 하는 함수
	 */
	@Transactional
	public void update_Jobfair(SocietyFapAdminJobfair sfaJobfair, SocietyFapAdminJobfairDivide sfaJobfairDivide, SocietyFapAdminJobfairLo sfaJobfairLo, 
			SocietyFapAdminJobfairDivideRc sfaJobfairDivideRc, SocietyFapAdminJobfairCompGroup sfaJobfairCompGroup, SocietyFapJobfairApplicableTime jobfairApplicableTime, SocietyFapAdminLimitInterview limitInterview){
		logger.info("FAP 잡페어 수정 Service 시작");	
		
		SocietyFapAdminJobfairDivide insertKfair = new SocietyFapAdminJobfairDivide();
		SocietyFapAdminJobfairDivide insertJfair= new SocietyFapAdminJobfairDivide();
		SocietyFapAdminJobfairDivide insertPostSeason = new SocietyFapAdminJobfairDivide();
		SocietyFapAdminJobfairDivide updateKfair = new SocietyFapAdminJobfairDivide();
		SocietyFapAdminJobfairDivide updateJfair= new SocietyFapAdminJobfairDivide();		
		SocietyFapAdminJobfairDivide updatePostSeason = new SocietyFapAdminJobfairDivide();		
		ArrayList<SocietyFapAdminJobfairLo> insertLoList = new ArrayList<>();
		ArrayList<SocietyFapAdminJobfairLo> updateLoList = new ArrayList<>();
		ArrayList<SocietyFapAdminJobfairDivideRc> insertKfairRcList = new ArrayList<>();		
		ArrayList<SocietyFapAdminJobfairDivideRc> insertJfairRcList = new ArrayList<>();
		ArrayList<SocietyFapAdminJobfairDivideRc> insertPostSeasonRcList = new ArrayList<>();		
		ArrayList<SocietyFapAdminJobfairDivideRc> updateKfairRcList = new ArrayList<>();
		ArrayList<SocietyFapAdminJobfairDivideRc> updateJfairRcList = new ArrayList<>();
		ArrayList<SocietyFapAdminJobfairDivideRc> updatePostSeasonRcList = new ArrayList<>();		
		ArrayList<SocietyFapAdminJobfairCompGroup> insertCompGroupList = new ArrayList<>();
		insertLoList.clear();updateLoList.clear();insertKfairRcList.clear();insertPostSeasonRcList.clear();insertJfairRcList.clear();
		updateKfairRcList.clear();updatePostSeasonRcList.clear();updateJfairRcList.clear();insertCompGroupList.clear();
		
		/*SocietyFapAdminJobfairDivide insertMissmatching = new SocietyFapAdminJobfairDivide();
		SocietyFapAdminJobfairDivide updateMissmatching = new SocietyFapAdminJobfairDivide();
		ArrayList<SocietyFapAdminJobfairDivideRc> insertMissmatchingRcList = new ArrayList<>();
		ArrayList<SocietyFapAdminJobfairDivideRc> updateMissmatchingRcList = new ArrayList<>();*/		
		
		//잡페어 로고 체크
		if(sfaJobfair.getFap_jobfair_log_file() != null && !sfaJobfair.getFap_jobfair_log_file().isEmpty()){
			if(sfaJobfair.getFap_jobfair_log_origin() != null && sfaJobfair.getFap_jobfair_log_saved() != null){
				FileService.deleteFile(sfaJobfair.getFap_jobfair_log_saved(), fapAdminJobfairLogoImage);
			}				
			String logoOrigin = sfaJobfair.getFap_jobfair_log_file().getOriginalFilename();
			String logoSaved = FileService.saveFile(sfaJobfair.getFap_jobfair_log_file(), fapAdminJobfairLogoImage);
			sfaJobfair.setFap_jobfair_log_origin(logoOrigin);
			sfaJobfair.setFap_jobfair_log_saved(logoSaved);
		}	
		//잡페어 수정
		sfaDAO.update_jobfair(sfaJobfair);
		//잡페어 지원가능 인원 수정
		sfaDAO.update_apply_max_num(sfaJobfair);
		//잡페어 현지인원 제한 수정
		limitInterview.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
		sfaDAO.update_limit_interview(limitInterview);
		
		//잡페어 회사그룹 설정 삭제
		sfaDAO.delete_comp_group_set(sfaJobfair.getFap_jobfair_seq());		
		//잡페어 회사그룹 설정
		for(int i=0; i < sfaJobfairCompGroup.getFap_comp_group_list().size(); i++){
			sfaJobfairCompGroup.getFap_comp_group_list().get(i).setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
			sfaJobfairCompGroup.getFap_comp_group_list().get(i).setFap_comp_group_ins_id(sfaJobfair.getFap_jobfair_ins_id());
			sfaJobfairCompGroup.getFap_comp_group_list().get(i).setFap_comp_group_udt_id(sfaJobfair.getFap_jobfair_udt_id());
			insertCompGroupList.add(sfaJobfairCompGroup.getFap_comp_group_list().get(i));
		}		
		// 회사그룹 정보 등록
		if(!insertCompGroupList.isEmpty()){
			sfaDAO.insert_comp_group_set(insertCompGroupList);
		}
		
		// 잡페어 개최지 정보 설정
		for(int i= 0; i < sfaJobfairLo.getFap_jobfair_lo_list().size(); i++){
			//새로운 개최지 정보
			if(sfaJobfairLo.getFap_jobfair_lo_list().get(i).getFap_jobfair_lo() != null && sfaJobfairLo.getFap_jobfair_lo_list().get(i).getFap_jobfair_lo() != ""){
				if(sfaJobfairLo.getFap_jobfair_lo_list().get(i).getFap_jobfair_lo_seq() == 0){
					SocietyFapAdminJobfairLo newSfaJobfairLo = new SocietyFapAdminJobfairLo();
					newSfaJobfairLo.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
					newSfaJobfairLo.setFap_jobfair_lo(sfaJobfairLo.getFap_jobfair_lo_list().get(i).getFap_jobfair_lo());
					insertLoList.add(newSfaJobfairLo);
				}else if(sfaJobfairLo.getFap_jobfair_lo_list().get(i).getFap_jobfair_lo_seq() != 0){		//기존의 개최지 정보
					SocietyFapAdminJobfairLo newSfaJobfairLo = new SocietyFapAdminJobfairLo();
					newSfaJobfairLo.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
					newSfaJobfairLo.setFap_jobfair_lo_seq(sfaJobfairLo.getFap_jobfair_lo_list().get(i).getFap_jobfair_lo_seq());
					newSfaJobfairLo.setFap_jobfair_lo(sfaJobfairLo.getFap_jobfair_lo_list().get(i).getFap_jobfair_lo());
					updateLoList.add(newSfaJobfairLo);
				}				
			}else if(sfaJobfairLo.getFap_jobfair_lo_list().get(i).getFap_jobfair_lo() == null || sfaJobfairLo.getFap_jobfair_lo_list().get(i).getFap_jobfair_lo() == ""){
				if(sfaJobfairLo.getFap_jobfair_lo_list().get(i).getFap_jobfair_lo_seq() != 0){		//삭제된 기존의 개최지 정보
					sfaDAO.delete_jobfair_lo(sfaJobfairLo.getFap_jobfair_lo_list().get(i).getFap_jobfair_lo_seq());		//잡페어 개최지 정보 삭제
				}					
			}
		}		
		// 잡페어 개최지 정보 등록
		if(!insertLoList.isEmpty()){
			sfaDAO.insert_jobfair_lo(insertLoList);
		}		
		// 잡페어 개최지 정보 수정
		if(!updateLoList.isEmpty()){
			sfaDAO.update_jobfair_lo(updateLoList);
		}		
		
		// 잡페어 세부 정보 설정
		for(int i = 0; i < sfaJobfairDivide.getFap_jobfair_divide_gb_list().size(); i++){
			//새로운 세부 정보
			if(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb() != null && sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb() != ""){
				if( sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_seq() == 0) {
					//K-fair 세부 정보 설정
					 if(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb().equals("C0100")){
						 insertKfair.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
						 insertKfair.setFap_jobfair_divide_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_st());
						 insertKfair.setFap_jobfair_divide_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_et());
						 insertKfair.setFap_jobfair_divide_app_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_st());
						 insertKfair.setFap_jobfair_divide_app_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_et());
						 insertKfair.setFap_jobfair_divide_app_num(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_num());
						 insertKfair.setFap_jobfair_divide_detail(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_detail());
						 insertKfair.setFap_jobfair_divide_gb(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb());
						 insertKfair.setFap_jobfair_divide_gb_eps(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb_eps());
						 insertKfair.setFap_jobfair_divide_ins_id(sfaJobfair.getFap_jobfair_ins_id());
						 insertKfair.setFap_jobfair_divide_udt_id(sfaJobfair.getFap_jobfair_udt_id());
						//K-fair 세부 정보 등록
						sfaDAO.insert_jobfair_divide(insertKfair);
					
						//K-fair 세부채용대상 정보 설정
						for(int j = 0; j < sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().size(); j++){
							if(sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().get(j).getFap_jobfair_divide_rc() != null && sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().get(j).getFap_jobfair_divide_rc() != ""){
								if(sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().get(j).getFap_jobfair_divide_rc_seq() == 0){
									SocietyFapAdminJobfairDivideRc newSfaJobfairDivideRc = new SocietyFapAdminJobfairDivideRc();
									newSfaJobfairDivideRc.setFap_jobfair_divide_seq(insertKfair.getFap_jobfair_divide_seq());									
									newSfaJobfairDivideRc.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
									newSfaJobfairDivideRc.setFap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().get(j).getFap_jobfair_divide_rc());
									insertKfairRcList.add(newSfaJobfairDivideRc);
								}								
							}
						}
						//K-fair 세부채용대상 등록
						sfaDAO.insert_jobfair_divide_rc(insertKfairRcList);
					 }
					 
					//J-fair 세부 정보 설정
					 if(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb().equals("C0101")){
						 insertJfair.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
						 insertJfair.setFap_jobfair_divide_seq(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_seq());
						 insertJfair.setFap_jobfair_divide_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_st());
						 insertJfair.setFap_jobfair_divide_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_et());
						 insertJfair.setFap_jobfair_divide_app_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_st());
						 insertJfair.setFap_jobfair_divide_app_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_et());
						 insertJfair.setFap_jobfair_divide_app_num(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_num());
						 insertJfair.setFap_jobfair_divide_detail(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_detail());
						 insertJfair.setFap_jobfair_divide_gb(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb());
						 insertJfair.setFap_jobfair_divide_gb_eps(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb_eps());
						 insertJfair.setFap_jobfair_divide_ins_id(sfaJobfair.getFap_jobfair_ins_id());
						 insertJfair.setFap_jobfair_divide_udt_id(sfaJobfair.getFap_jobfair_udt_id());
						//J-fair 세부 정보 등록
						sfaDAO.insert_jobfair_divide(insertJfair);
						
						//J-fair 세부채용대상 정보 설정
						for(int j = 0; j < sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().size(); j++){
							if(sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().get(j).getFap_jobfair_divide_rc() != null && sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().get(j).getFap_jobfair_divide_rc() != ""){
								if(sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().get(j).getFap_jobfair_divide_rc_seq() == 0){
									SocietyFapAdminJobfairDivideRc newSfaJobfairDivideRc = new SocietyFapAdminJobfairDivideRc();
									newSfaJobfairDivideRc.setFap_jobfair_divide_seq(insertJfair.getFap_jobfair_divide_seq());
									newSfaJobfairDivideRc.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
									newSfaJobfairDivideRc.setFap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().get(j).getFap_jobfair_divide_rc());
									insertJfairRcList.add(newSfaJobfairDivideRc);
								}								
							}
						}
						//J-fair 세부채용대상 등록
						sfaDAO.insert_jobfair_divide_rc(insertJfairRcList);
					 }
					 
					//포스트시즌 세부 정보 설정
					 if(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb().equals("C0102")){
						 insertPostSeason.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
						 insertPostSeason.setFap_jobfair_divide_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_st());
						 insertPostSeason.setFap_jobfair_divide_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_et());
						 insertPostSeason.setFap_jobfair_divide_app_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_st());
						 insertPostSeason.setFap_jobfair_divide_app_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_et());
						 insertPostSeason.setFap_jobfair_divide_app_num(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_num());
						 insertPostSeason.setFap_jobfair_divide_detail(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_detail());
						 insertPostSeason.setFap_jobfair_divide_gb(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb());
						 insertPostSeason.setFap_jobfair_divide_gb_eps(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb_eps());
						 insertPostSeason.setFap_jobfair_divide_ins_id(sfaJobfair.getFap_jobfair_ins_id());
						 insertPostSeason.setFap_jobfair_divide_udt_id(sfaJobfair.getFap_jobfair_udt_id());
						//포스트시즌 세부 정보 등록
						sfaDAO.insert_jobfair_divide(insertPostSeason);
					
						//포스트시즌 세부채용대상 정보 설정
						for(int j = 0; j < sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().size(); j++){
							if(sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().get(j).getFap_jobfair_divide_rc() != null && sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().get(j).getFap_jobfair_divide_rc() != ""){
								if(sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().get(j).getFap_jobfair_divide_rc_seq() == 0){
									SocietyFapAdminJobfairDivideRc newSfaJobfairDivideRc = new SocietyFapAdminJobfairDivideRc();
									newSfaJobfairDivideRc.setFap_jobfair_divide_seq(insertPostSeason.getFap_jobfair_divide_seq());									
									newSfaJobfairDivideRc.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
									newSfaJobfairDivideRc.setFap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().get(j).getFap_jobfair_divide_rc());
									insertPostSeasonRcList.add(newSfaJobfairDivideRc);
								}								
							}
						}
						//포스트시즌 세부채용대상 등록
						sfaDAO.insert_jobfair_divide_rc(insertPostSeasonRcList);
					 }
					
					/*//미스매칭 세부 정보 설정
					 if(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb().equals("C0103")){
						 insertMissmatching.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
						 insertMissmatching.setFap_jobfair_divide_seq(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_seq());
						 insertMissmatching.setFap_jobfair_divide_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_st());
						 insertMissmatching.setFap_jobfair_divide_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_et());
						 insertMissmatching.setFap_jobfair_divide_app_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_st());
						 insertMissmatching.setFap_jobfair_divide_app_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_et());
						 insertMissmatching.setFap_jobfair_divide_app_num(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_num());
						 insertMissmatching.setFap_jobfair_divide_detail(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_detail());
						 insertMissmatching.setFap_jobfair_divide_gb(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb());
						 insertMissmatching.setFap_jobfair_divide_gb_eps(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb_eps());
						 insertMissmatching.setFap_jobfair_divide_ins_id(sfaJobfair.getFap_jobfair_ins_id());
						 insertMissmatching.setFap_jobfair_divide_udt_id(sfaJobfair.getFap_jobfair_udt_id());
						//미스매칭 세부 정보 등록
						sfaDAO.insert_jobfair_divide(insertMissmatching);
						
						//미스매칭 세부채용대상 정보 설정
						for(int j = 0; j < sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().size(); j++){
							if(sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().get(j).getFap_jobfair_divide_rc() != null && sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().get(j).getFap_jobfair_divide_rc() != ""){
								if(sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().get(j).getFap_jobfair_divide_rc_seq() == 0){
									SocietyFapAdminJobfairDivideRc newSfaJobfairDivideRc = new SocietyFapAdminJobfairDivideRc();
									newSfaJobfairDivideRc.setFap_jobfair_divide_seq(insertMissmatching.getFap_jobfair_divide_seq());
									newSfaJobfairDivideRc.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
									newSfaJobfairDivideRc.setFap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().get(j).getFap_jobfair_divide_rc());							
									insertMissmatchingRcList.add(newSfaJobfairDivideRc);
								}								
							}
						}
						//미스매칭 세부채용대상 등록
						sfaDAO.insert_jobfair_divide_rc(insertMissmatchingRcList);
					 }*/
					 
				}				
			}				
			
			//기존의 세부 정보
			if(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb() != null && sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb() != ""){
				if( sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_seq() != 0) {
					//K-fair 세부 정보 설정
					 if(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb().equals("C0100")){
						 updateKfair.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
						 updateKfair.setFap_jobfair_divide_seq(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_seq());
						 updateKfair.setFap_jobfair_divide_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_st());
						 updateKfair.setFap_jobfair_divide_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_et());
						 updateKfair.setFap_jobfair_divide_app_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_st());
						 updateKfair.setFap_jobfair_divide_app_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_et());
						 updateKfair.setFap_jobfair_divide_app_num(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_num());
						 updateKfair.setFap_jobfair_divide_detail(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_detail());
						 updateKfair.setFap_jobfair_divide_gb(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb());
						 updateKfair.setFap_jobfair_divide_gb_eps(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb_eps());
						 updateKfair.setFap_jobfair_divide_ins_id(sfaJobfair.getFap_jobfair_ins_id());
						 updateKfair.setFap_jobfair_divide_udt_id(sfaJobfair.getFap_jobfair_udt_id());
						//K-fair 세부 정보 수정
						sfaDAO.update_jobfair_divide(updateKfair);
						
						//K-fair 세부채용대상 정보 설정
						for(int j = 0; j < sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().size(); j++){
							if(sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().get(j).getFap_jobfair_divide_rc() != null && sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().get(j).getFap_jobfair_divide_rc() != ""){
								if( sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().get(j).getFap_jobfair_divide_rc_seq() != 0){		//기존의 K-fair 세부채용대상 수정
									SocietyFapAdminJobfairDivideRc newSfaJobfairDivideRc = new SocietyFapAdminJobfairDivideRc();
									newSfaJobfairDivideRc.setFap_jobfair_divide_seq(updateKfair.getFap_jobfair_divide_seq());
									newSfaJobfairDivideRc.setFap_jobfair_divide_rc_seq(sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().get(j).getFap_jobfair_divide_rc_seq());
									newSfaJobfairDivideRc.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
									newSfaJobfairDivideRc.setFap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().get(j).getFap_jobfair_divide_rc());
									updateKfairRcList.add(newSfaJobfairDivideRc);		
								}
								if( sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().get(j).getFap_jobfair_divide_rc_seq() == 0){		//새로운 K-fair 세부채용대상 등록
									SocietyFapAdminJobfairDivideRc newSfaJobfairDivideRc = new SocietyFapAdminJobfairDivideRc();
									newSfaJobfairDivideRc.setFap_jobfair_divide_seq(updateKfair.getFap_jobfair_divide_seq());
									newSfaJobfairDivideRc.setFap_jobfair_divide_rc_seq(sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().get(j).getFap_jobfair_divide_rc_seq());
									newSfaJobfairDivideRc.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
									newSfaJobfairDivideRc.setFap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().get(j).getFap_jobfair_divide_rc());
									insertKfairRcList.add(newSfaJobfairDivideRc);																								
								}	
							}
							if(sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().get(j).getFap_jobfair_divide_rc() == null || sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().get(j).getFap_jobfair_divide_rc() == ""){
								if(sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().get(j).getFap_jobfair_divide_rc_seq() != 0){		//삭제된 기존의 K-fair 세부채용대상
									sfaDAO.delete_fap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_k_fair_rc_list().get(j).getFap_jobfair_divide_rc_seq());		//삭제된 기존의 K-fair 세부채용대상 삭제
								}
							}								
						}
						//K-fair 세부채용대상 수정
						if(!updateKfairRcList.isEmpty()){
							sfaDAO.update_jobfair_divide_rc(updateKfairRcList);
						}
						//K-fair 세부채용대상 등록
						if(!insertKfairRcList.isEmpty()){
							sfaDAO.insert_jobfair_divide_rc(insertKfairRcList);
						}
						
						//K-fair 취업지원자 채용공고 지원가능시간정보 설정
						for(int j = 0; j < jobfairApplicableTime.getFap_k_fair_applicable_time_list().size(); j++){
							if(jobfairApplicableTime.getFap_k_fair_applicable_time_list().get(j).getFap_jobfair_applicable_time_first() != null && jobfairApplicableTime.getFap_k_fair_applicable_time_list().get(j).getFap_jobfair_applicable_time_first() != ""){
								if( jobfairApplicableTime.getFap_k_fair_applicable_time_list().get(j).getFap_jobfair_applicable_time_seq() != 0){		//기존의 K-fair 채용공고 지원가능시간 수정
									jobfairApplicableTime.getFap_k_fair_applicable_time_list().get(j).setFap_jobfair_divide_seq(updateKfair.getFap_jobfair_divide_seq());
									jobfairApplicableTime.getFap_k_fair_applicable_time_list().get(j).setFap_jobfair_applicable_time_udt_id(updateKfair.getFap_jobfair_divide_udt_id());
									String date_st = jobfairApplicableTime.getFap_k_fair_applicable_time_list().get(j).getFap_jobfair_divide_user_date_st();
									String time_st = jobfairApplicableTime.getFap_k_fair_applicable_time_list().get(j).getFap_jobfair_divide_user_time_st();
									String date_et = jobfairApplicableTime.getFap_k_fair_applicable_time_list().get(j).getFap_jobfair_divide_user_date_et();
									String time_et = jobfairApplicableTime.getFap_k_fair_applicable_time_list().get(j).getFap_jobfair_divide_user_time_et();
									jobfairApplicableTime.getFap_k_fair_applicable_time_list().get(j).setFap_jobfair_applicable_time_st(date_st + " " + time_st);
									jobfairApplicableTime.getFap_k_fair_applicable_time_list().get(j).setFap_jobfair_applicable_time_et(date_et + " " + time_et);
									//K-fair 취업지원자 채용공고 지원가능시간 수정
									sfaDAO.update_jobfair_applicable_time(jobfairApplicableTime.getFap_k_fair_applicable_time_list());
								}
							}
						}						
					 }				
					 
					//J-fair 세부 정보 설정
					 if(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb().equals("C0101")){
						 updateJfair.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
						 updateJfair.setFap_jobfair_divide_seq(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_seq());
						 updateJfair.setFap_jobfair_divide_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_st());
						 updateJfair.setFap_jobfair_divide_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_et());
						 updateJfair.setFap_jobfair_divide_app_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_st());
						 updateJfair.setFap_jobfair_divide_app_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_et());
						 updateJfair.setFap_jobfair_divide_app_num(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_num());
						 updateJfair.setFap_jobfair_divide_detail(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_detail());
						 updateJfair.setFap_jobfair_divide_gb(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb());
						 updateJfair.setFap_jobfair_divide_gb_eps(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb_eps());
						 updateJfair.setFap_jobfair_divide_ins_id(sfaJobfair.getFap_jobfair_ins_id());
						 updateJfair.setFap_jobfair_divide_udt_id(sfaJobfair.getFap_jobfair_udt_id());
						//J-fair 세부 정보 수정
						sfaDAO.update_jobfair_divide(updateJfair);
						
						//J-fair 세부채용대상 정보 설정
						for(int j = 0; j < sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().size(); j++){
							if(sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().get(j).getFap_jobfair_divide_rc() != null && sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().get(j).getFap_jobfair_divide_rc() != ""){
								if( sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().get(j).getFap_jobfair_divide_rc_seq() != 0){
									SocietyFapAdminJobfairDivideRc newSfaJobfairDivideRc = new SocietyFapAdminJobfairDivideRc();
									newSfaJobfairDivideRc.setFap_jobfair_divide_seq(updateJfair.getFap_jobfair_divide_seq());
									newSfaJobfairDivideRc.setFap_jobfair_divide_rc_seq(sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().get(j).getFap_jobfair_divide_rc_seq());
									newSfaJobfairDivideRc.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
									newSfaJobfairDivideRc.setFap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().get(j).getFap_jobfair_divide_rc());
									updateJfairRcList.add(newSfaJobfairDivideRc);
								}
								if( sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().get(j).getFap_jobfair_divide_rc_seq() == 0){
									SocietyFapAdminJobfairDivideRc newSfaJobfairDivideRc = new SocietyFapAdminJobfairDivideRc();
									newSfaJobfairDivideRc.setFap_jobfair_divide_seq(updateJfair.getFap_jobfair_divide_seq());
									newSfaJobfairDivideRc.setFap_jobfair_divide_rc_seq(sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().get(j).getFap_jobfair_divide_rc_seq());
									newSfaJobfairDivideRc.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
									newSfaJobfairDivideRc.setFap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().get(j).getFap_jobfair_divide_rc());
									insertJfairRcList.add(newSfaJobfairDivideRc);																							
								}	
							}
							if(sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().get(j).getFap_jobfair_divide_rc() == null || sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().get(j).getFap_jobfair_divide_rc() == ""){
								if(	sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().get(j).getFap_jobfair_divide_rc_seq() != 0){		//삭제된 기존의 J-fair 세부채용대상
									sfaDAO.delete_fap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_j_fair_rc_list().get(j).getFap_jobfair_divide_rc_seq());		//삭제된 기존의 J-fair 세부채용대상 삭제
								}
							}									
						}
						//J-fair 세부채용대상 수정
						if(!updateJfairRcList.isEmpty()){
							sfaDAO.update_jobfair_divide_rc(updateJfairRcList);
						}
						//J-fair 세부채용대상 등록
						if(!insertJfairRcList.isEmpty()){
							sfaDAO.insert_jobfair_divide_rc(insertJfairRcList);
						}	
						
						//J-fair 취업지원자 채용공고 지원가능시간정보 설정
						for(int j = 0; j < jobfairApplicableTime.getFap_j_fair_applicable_time_list().size(); j++){
							if(jobfairApplicableTime.getFap_j_fair_applicable_time_list().get(j).getFap_jobfair_applicable_time_first() != null && jobfairApplicableTime.getFap_j_fair_applicable_time_list().get(j).getFap_jobfair_applicable_time_first() != ""){
								if( jobfairApplicableTime.getFap_j_fair_applicable_time_list().get(j).getFap_jobfair_applicable_time_seq() != 0){		//기존의 J-fair 채용공고 지원가능시간 수정
									jobfairApplicableTime.getFap_j_fair_applicable_time_list().get(j).setFap_jobfair_divide_seq(updateJfair.getFap_jobfair_divide_seq());
									jobfairApplicableTime.getFap_j_fair_applicable_time_list().get(j).setFap_jobfair_applicable_time_udt_id(updateJfair.getFap_jobfair_divide_udt_id());
									String date_st = jobfairApplicableTime.getFap_j_fair_applicable_time_list().get(j).getFap_jobfair_divide_user_date_st();
									String time_st = jobfairApplicableTime.getFap_j_fair_applicable_time_list().get(j).getFap_jobfair_divide_user_time_st();
									String date_et = jobfairApplicableTime.getFap_j_fair_applicable_time_list().get(j).getFap_jobfair_divide_user_date_et();
									String time_et = jobfairApplicableTime.getFap_j_fair_applicable_time_list().get(j).getFap_jobfair_divide_user_time_et();
									jobfairApplicableTime.getFap_j_fair_applicable_time_list().get(j).setFap_jobfair_applicable_time_st(date_st + " " + time_st);
									jobfairApplicableTime.getFap_j_fair_applicable_time_list().get(j).setFap_jobfair_applicable_time_et(date_et + " " + time_et);
									//J-fair 취업지원자 채용공고 지원가능시간 수정
									sfaDAO.update_jobfair_applicable_time(jobfairApplicableTime.getFap_j_fair_applicable_time_list());
								}
							}
						}
					 }
					 
					//포스트시즌 세부 정보 설정
					 if(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb().equals("C0102")){
						 updatePostSeason.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
						 updatePostSeason.setFap_jobfair_divide_seq(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_seq());
						 updatePostSeason.setFap_jobfair_divide_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_st());
						 updatePostSeason.setFap_jobfair_divide_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_et());
						 updatePostSeason.setFap_jobfair_divide_app_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_st());
						 updatePostSeason.setFap_jobfair_divide_app_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_et());
						 updatePostSeason.setFap_jobfair_divide_app_num(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_num());
						 updatePostSeason.setFap_jobfair_divide_detail(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_detail());
						 updatePostSeason.setFap_jobfair_divide_gb(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb());
						 updatePostSeason.setFap_jobfair_divide_gb_eps(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb_eps());
						 updatePostSeason.setFap_jobfair_divide_ins_id(sfaJobfair.getFap_jobfair_ins_id());
						 updatePostSeason.setFap_jobfair_divide_udt_id(sfaJobfair.getFap_jobfair_udt_id());
						//포스트시즌 세부 정보 수정
						sfaDAO.update_jobfair_divide(updatePostSeason);
						
						//포스트시즌 세부채용대상 정보 설정
						for(int j = 0; j < sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().size(); j++){
							if(sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().get(j).getFap_jobfair_divide_rc() != null && sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().get(j).getFap_jobfair_divide_rc() != ""){
								if( sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().get(j).getFap_jobfair_divide_rc_seq() != 0){		//기존의 포스트시즌 세부채용대상 수정
									SocietyFapAdminJobfairDivideRc newSfaJobfairDivideRc = new SocietyFapAdminJobfairDivideRc();
									newSfaJobfairDivideRc.setFap_jobfair_divide_seq(updatePostSeason.getFap_jobfair_divide_seq());
									newSfaJobfairDivideRc.setFap_jobfair_divide_rc_seq(sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().get(j).getFap_jobfair_divide_rc_seq());
									newSfaJobfairDivideRc.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
									newSfaJobfairDivideRc.setFap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().get(j).getFap_jobfair_divide_rc());
									updatePostSeasonRcList.add(newSfaJobfairDivideRc);		
								}
								if( sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().get(j).getFap_jobfair_divide_rc_seq() == 0){		//새로운 포스트시즌 세부채용대상 등록
									SocietyFapAdminJobfairDivideRc newsfaJobfairDivideRc = new SocietyFapAdminJobfairDivideRc();
									newsfaJobfairDivideRc.setFap_jobfair_divide_seq(updatePostSeason.getFap_jobfair_divide_seq());
									newsfaJobfairDivideRc.setFap_jobfair_divide_rc_seq(sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().get(j).getFap_jobfair_divide_rc_seq());
									newsfaJobfairDivideRc.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
									newsfaJobfairDivideRc.setFap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().get(j).getFap_jobfair_divide_rc());
									insertPostSeasonRcList.add(newsfaJobfairDivideRc);																								
								}	
							}
							if(sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().get(j).getFap_jobfair_divide_rc() == null || sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().get(j).getFap_jobfair_divide_rc() == ""){
								if(sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().get(j).getFap_jobfair_divide_rc_seq() != 0){		//삭제된 기존의 포스트시즌 세부채용대상
									sfaDAO.delete_fap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_post_season_rc_list().get(j).getFap_jobfair_divide_rc_seq());		//삭제된 기존의 포스트시즌 세부채용대상 삭제
								}
							}								
						}
						//포스트시즌 세부채용대상 수정
						if(!updatePostSeasonRcList.isEmpty()){
							sfaDAO.update_jobfair_divide_rc(updatePostSeasonRcList);
						}
						//포스트시즌 세부채용대상 등록
						if(!insertPostSeasonRcList.isEmpty()){
							sfaDAO.insert_jobfair_divide_rc(insertPostSeasonRcList);
						}
						
						//포스트시즌 취업지원자 채용공고 지원가능시간정보 설정
						for(int j = 0; j < jobfairApplicableTime.getFap_post_season_applicable_time_list().size(); j++){
							if(jobfairApplicableTime.getFap_post_season_applicable_time_list().get(j).getFap_jobfair_applicable_time_first() != null && jobfairApplicableTime.getFap_post_season_applicable_time_list().get(j).getFap_jobfair_applicable_time_first() != ""){
								if( jobfairApplicableTime.getFap_post_season_applicable_time_list().get(j).getFap_jobfair_applicable_time_seq() != 0){		//기존의 포스트시즌 채용공고 지원가능시간 수정
									jobfairApplicableTime.getFap_post_season_applicable_time_list().get(j).setFap_jobfair_divide_seq(updatePostSeason.getFap_jobfair_divide_seq());
									jobfairApplicableTime.getFap_post_season_applicable_time_list().get(j).setFap_jobfair_applicable_time_udt_id(updatePostSeason.getFap_jobfair_divide_udt_id());
									String date_st = jobfairApplicableTime.getFap_post_season_applicable_time_list().get(j).getFap_jobfair_divide_user_date_st();
									String time_st = jobfairApplicableTime.getFap_post_season_applicable_time_list().get(j).getFap_jobfair_divide_user_time_st();
									String date_et = jobfairApplicableTime.getFap_post_season_applicable_time_list().get(j).getFap_jobfair_divide_user_date_et();
									String time_et = jobfairApplicableTime.getFap_post_season_applicable_time_list().get(j).getFap_jobfair_divide_user_time_et();
									jobfairApplicableTime.getFap_post_season_applicable_time_list().get(j).setFap_jobfair_applicable_time_st(date_st + " " + time_st);
									jobfairApplicableTime.getFap_post_season_applicable_time_list().get(j).setFap_jobfair_applicable_time_et(date_et + " " + time_et);
									//포스트시즌 취업지원자 채용공고 지원가능시간 수정
									sfaDAO.update_jobfair_applicable_time(jobfairApplicableTime.getFap_post_season_applicable_time_list());
								}
							}
						}
					 }
					 
					/*//미스매칭 세부 정보 설정
					 if(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb().equals("C0103")){
						 updateMissmatching.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
						 updateMissmatching.setFap_jobfair_divide_seq(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_seq());
						 updateMissmatching.setFap_jobfair_divide_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_st());
						 updateMissmatching.setFap_jobfair_divide_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_et());
						 updateMissmatching.setFap_jobfair_divide_app_st(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_st());
						 updateMissmatching.setFap_jobfair_divide_app_et(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_et());
						 updateMissmatching.setFap_jobfair_divide_app_num(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_app_num());
						 updateMissmatching.setFap_jobfair_divide_detail(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_detail());
						 updateMissmatching.setFap_jobfair_divide_gb(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb());
						 updateMissmatching.setFap_jobfair_divide_gb_eps(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb_eps());
						 updateMissmatching.setFap_jobfair_divide_ins_id(sfaJobfair.getFap_jobfair_ins_id());
						 updateMissmatching.setFap_jobfair_divide_udt_id(sfaJobfair.getFap_jobfair_udt_id());
						//미스매칭 세부 정보 수정
						sfaDAO.update_jobfair_divide(updateMissmatching);
						
						//미스매칭 세부채용대상 정보 설정
						for(int j = 0; j < sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().size(); j++){
							if(sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().get(j).getFap_jobfair_divide_rc() != null && sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().get(j).getFap_jobfair_divide_rc() != ""){
								if(sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().get(j).getFap_jobfair_divide_rc_seq() != 0){
									SocietyFapAdminJobfairDivideRc newSfaJobfairDivideRc = new SocietyFapAdminJobfairDivideRc();
									newSfaJobfairDivideRc.setFap_jobfair_divide_seq(updateMissmatching.getFap_jobfair_divide_seq());
									newSfaJobfairDivideRc.setFap_jobfair_divide_rc_seq(sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().get(j).getFap_jobfair_divide_rc_seq());
									newSfaJobfairDivideRc.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
									newSfaJobfairDivideRc.setFap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().get(j).getFap_jobfair_divide_rc());							
									updateMissmatchingRcList.add(newSfaJobfairDivideRc);
								}	
								if( sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().get(j).getFap_jobfair_divide_rc_seq() == 0){
									SocietyFapAdminJobfairDivideRc newSfaJobfairDivideRc = new SocietyFapAdminJobfairDivideRc();
									newSfaJobfairDivideRc.setFap_jobfair_divide_seq(updateMissmatching.getFap_jobfair_divide_seq());
									newSfaJobfairDivideRc.setFap_jobfair_divide_rc_seq(sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().get(j).getFap_jobfair_divide_rc_seq());
									newSfaJobfairDivideRc.setFap_jobfair_seq(sfaJobfair.getFap_jobfair_seq());
									newSfaJobfairDivideRc.setFap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().get(j).getFap_jobfair_divide_rc());
									insertMissmatchingRcList.add(newSfaJobfairDivideRc);																							
								}	
							}
							if(sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().get(j).getFap_jobfair_divide_rc() == null || sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().get(j).getFap_jobfair_divide_rc() == ""){
								if(sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().get(j).getFap_jobfair_divide_rc_seq() != 0){		//삭제된 기존의 미스매칭 세부채용대상
									sfaDAO.delete_fap_jobfair_divide_rc(sfaJobfairDivideRc.getFap_jobfair_missmatching_rc_list().get(j).getFap_jobfair_divide_rc_seq());		//삭제된 기존의 미스매칭 세부채용대상 삭제
								}
							}								
						}
						//미스매칭 세부채용대상 수정
						if(!updateMissmatchingRcList.isEmpty()){
							sfaDAO.update_jobfair_divide_rc(updateMissmatchingRcList);
						}
						//미스매칭 세부채용대상 등록
						if(!insertMissmatchingRcList.isEmpty()){
							sfaDAO.insert_jobfair_divide_rc(insertMissmatchingRcList);
						}
						//미스매칭 취업지원자 채용공고 지원가능시간정보 설정
						for(int j = 0; j < jobfairApplicableTime.getFap_missmatching_applicable_time_list().size(); j++){
							if(jobfairApplicableTime.getFap_missmatching_applicable_time_list().get(j).getFap_jobfair_applicable_time_first() != null && jobfairApplicableTime.getFap_missmatching_applicable_time_list().get(j).getFap_jobfair_applicable_time_first() != ""){
								if( jobfairApplicableTime.getFap_missmatching_applicable_time_list().get(j).getFap_jobfair_applicable_time_seq() != 0){		//기존의 미스매칭 채용공고 지원가능시간 수정
									jobfairApplicableTime.getFap_missmatching_applicable_time_list().get(j).setFap_jobfair_divide_seq(updateMissmatching.getFap_jobfair_divide_seq());
									jobfairApplicableTime.getFap_missmatching_applicable_time_list().get(j).setFap_jobfair_applicable_time_udt_id(updateMissmatching.getFap_jobfair_divide_udt_id());
									String date_st = jobfairApplicableTime.getFap_missmatching_applicable_time_list().get(j).getFap_jobfair_divide_user_date_st();
									String time_st = jobfairApplicableTime.getFap_missmatching_applicable_time_list().get(j).getFap_jobfair_divide_user_time_st();
									String date_et = jobfairApplicableTime.getFap_missmatching_applicable_time_list().get(j).getFap_jobfair_divide_user_date_et();
									String time_et = jobfairApplicableTime.getFap_missmatching_applicable_time_list().get(j).getFap_jobfair_divide_user_time_et();
									jobfairApplicableTime.getFap_missmatching_applicable_time_list().get(j).setFap_jobfair_applicable_time_st(date_st + " " + time_st);
									jobfairApplicableTime.getFap_missmatching_applicable_time_list().get(j).setFap_jobfair_applicable_time_et(date_et + " " + time_et);
									//미스매칭 취업지원자 채용공고 지원가능시간 수정
									sfaDAO.update_jobfair_applicable_time(jobfairApplicableTime.getFap_missmatching_applicable_time_list());									
								}
							}
						}
					 }*/	
					 
				}				
			}
			
			//미선택된 세부 정보
			if(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb() == null || sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_gb() == ""){
				if( sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_seq() != 0) {		
					sfaDAO.delete_fap_jobfair_divide(sfaJobfairDivide.getFap_jobfair_divide_gb_list().get(i).getFap_jobfair_divide_seq());		//미선택된 세부정보 삭제
				}
			}				
		}	
		
		logger.info("FAP 잡페어 수정 Service 종료");
	}
	
	
	/**
	 * @Method Name : select_fap_jobfair_info
	 * @Date : 2018. 12. 13.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 선택한 잡페어 전체 정보 검색 리스트
	 * @Method 설명 : 선택한 잡페어 전체 정보 검색
	 */
	public HashMap<String, Object> select_fap_jobfair_info(int fap_jobfair_seq){
		logger.info("통합잡페어 정보 검색 Service 시작");
		
		HashMap<String, Object> resultMap = sfaDAO.select_fap_jobfair_info(fap_jobfair_seq);
		
		logger.info("통합잡페어 정보 검색 Service 종료");
		return resultMap;
	}
	
	/**
	 * @Method Name : jobfair_search_list
	 * @Date : 2018. 12. 14.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 잡페어 정보 검색 리스트
	 * @Method 설명 : 통합잡페어 정보 리스트 검색
	 */
	public ArrayList<SocietyFapAdminJobfair> jobfair_search_list(HashMap<String, Object>hashmap){
		logger.info("통합잡페어 정보 리스트 검색 Service 시작");
		
		ArrayList<SocietyFapAdminJobfair> jobfair_search_list = sfaDAO.jobfair_search_list(hashmap);
		
		logger.info("통합잡페어 정보 리스트 검색 Service 종료");
		return jobfair_search_list;
	}
	
	/**
	 * @Method Name : select_fap_jobfair_divide
	 * @Date : 2018. 12. 14.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 잡페어 세부정보 검색 리스트
	 * @Method 설명 : 통합잡페어 세부정보 검색
	 */
	public ArrayList<SocietyFapAdminJobfairDivide> select_fap_jobfair_divide(int fap_jobfair_seq){
		logger.info("통합잡페어 정보 검색 Service 시작");
		
		ArrayList<SocietyFapAdminJobfairDivide> select_fap_jobfair_divide = sfaDAO.select_fap_jobfair_divide(fap_jobfair_seq);
		
		logger.info("통합잡페어 정보 검색 Service 종료");
		return select_fap_jobfair_divide;
	}
	
	/**
	 * @Method Name : delete_fap_jobfair
	 * @Date : 2018. 12. 14.
	 * @User : 신동철
	 * @Param : 삭제할 잡페어 시퀀스 리스트
	 * @Return : -
	 * @Method 설명 : 잡페어 삭제
	 */
	public void delete_fap_jobfair(List<Integer> fap_jobfair_seq_list){
		logger.info("잡페어 삭제 Service 시작");
		
		for(int i=0; i<fap_jobfair_seq_list.size(); i++){
			SocietyFapAdminJobfair fapAdminJobfair= sfaDAO.select_fap_jobfair(fap_jobfair_seq_list.get(i));
			//잡페어 로고 삭제
			if(fapAdminJobfair.getFap_jobfair_log_saved() != null){
				DeleteFileServer(fapAdminJobfair);
			}
			//잡페어 삭제
			sfaDAO.delete_fap_jobfair(fap_jobfair_seq_list.get(i));		
		}				
		
		logger.info("잡페어 삭제 Service 종료");
	}
	
	/**
	 * @Method Name : DeleteFileServer
	 * @Date : 2018. 12. 14
	 * @User : 신동철
	 * @Param : 잡페어 로고 파일 저장명
	 * @Return : -
	 * @Method 설명 : 파일서버에 저장된 잡페어 로고제거
	 */
	private void DeleteFileServer(SocietyFapAdminJobfair fapJobfairLoImg) {
		try {			
				FileService.deleteFile(fapJobfairLoImg.getFap_jobfair_log_saved(), fapAdminJobfairLogoImage);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @Method Name : search_jobfair_user_apply_info
	 * @Date : 2018. 12. 20.
	 * @User : 신동철
	 * @Param : (잡페어 시퀀스, 회원타입, 승인여부, 이름)
	 * @Return : 잡페어 지원자 등록정보
	 * @Method 설명 : 잡페어 지원자 등록정보 검색
	 */
	public ArrayList<HashMap<String, Object>> search_jobfair_user_apply_info(HashMap<String, Object> hashmap){
		logger.info("잡페어 지원자 등록정보 검색 Service 시작");
		
		ArrayList<HashMap<String, Object>> resultList = sfaDAO.search_jobfair_user_apply_info(hashmap);
		
		logger.info("잡페어 지원자 등록정보 검색 Service 종료");
		return resultList;
	}

	/**
	 * @Method Name : jobfair_user_apply_permission
	 * @Date : 2018. 12. 21.
	 * @User : 신동철
	 * @Param : 지원자 잡페어 신청 등록 시퀀스
	 * @Return : -
	 * @Method 설명 : 지원자 잡페어 신청
	 */
	public void jobfair_user_apply_permission(HashMap<String, Object> hashmap){
		logger.info("잡페어 지원자 신청 승인 Service 시작");
		
		ArrayList<SocietyFapAdminJobfairApply> sfaJobfairApplyList = new ArrayList<>();		
		List<Integer> fap_jobfair_user_seq_list = (List<Integer>) hashmap.get("fap_jobfair_user_seq_list");
		
		for(int i = 0; i<fap_jobfair_user_seq_list.size(); i++){
			int fap_jobfair_user_seq = fap_jobfair_user_seq_list.get(i);
			String fap_jobfair_user_per_id = (String)hashmap.get("fap_jobfair_user_per_id");
			SocietyFapAdminJobfairApply sfaJobfairApply = new SocietyFapAdminJobfairApply();
			sfaJobfairApply.setFap_jobfair_user_seq(fap_jobfair_user_seq);
			sfaJobfairApply.setFap_jobfair_user_per_id(fap_jobfair_user_per_id);
			sfaJobfairApplyList.add(sfaJobfairApply);			
		}		
		
		sfaDAO.jobfair_user_apply_permission(sfaJobfairApplyList);
		
		logger.info("잡페어 지원자 신청 승인 Service 종료");
	}
	
	/**
	 * @Method Name : select_user_list
	 * @Date : 2019. 3. 4.
	 * @User : 정병준
	 * @Param : -
	 * @Return : 회원 리스트를 가져오는 함수
	 * @Method 설명 : 유저 리스트를 가져오는 함수
	 */
	public ArrayList<User> select_user_list(HashMap<String, Object> map){
		logger.info("FAP 회원 리스트 가져오기 서비스 시작");
		ArrayList<User> user_list = sfaDAO.select_user_list(map);
		logger.info("FAP 회원 리스트 가져오기 서비스 종료");
		return user_list;
	}
	
	/**
	 * @Method Name : select_user_list_count
	 * @Date : 2019. 3. 4.
	 * @User : 정병준
	 * @Param : -
	 * @Return : 회원 리스트 개수를 가져오는 함수
	 * @Method 설명 : 유저 리스트 개수를 가져오는 함수
	 */
	public int select_user_list_count(HashMap<String, Object> map){
		logger.info("FAP 회원 리스트 개수 가져오기 서비스 시작");
		int result = sfaDAO.select_user_list_count(map);
		logger.info("FAP 회원 리스트 개수 가져오기 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_company_list
	 * @Date : 2019. 1. 2.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 기업 리스트를 가져오는 함수
	 * @Method 설명 : 기업 리스트를 가져오는 함수
	 */
	public ArrayList<SocietyFapCompanyUser> select_company_list(int start, int countPerPage, HashMap<String,Object> paramMap){
		logger.info("FAP 기업 리스트 가져오기 서비스 시작");
		ArrayList<SocietyFapCompanyUser> company_list = sfaDAO.select_company_list(start, countPerPage, paramMap);
		logger.info("FAP 기업 리스트 가져오기 서비스 종료");
		return company_list;
	}

	/**
	 * @Method Name : read_all_job_fair_ad_list
	 * @Date : 2018. 01. 02.
	 * @User : 남유송
	 * @Param : int
	 * @Return : HashMap
	 * @Method 설명 : 잡페어별 채용공고 리스트 출력
	 */
	public ArrayList<HashMap<String, Object>> select_jobfair_job_ad(HashMap<String, Object> params) {
		logger.info("잡페어별 채용공고 리스트 출력 컨트롤러 시작");
		ArrayList<HashMap<String, Object>> jobFairAdList = sfaDAO.select_jobfair_job_ad(params);
		logger.info("잡페어별 채용공고 리스트 출력 컨트롤러 종료");
		return jobFairAdList;
	}

	/**
	 * @Method Name : applicant_list_per_job_ad
	 * @Date : 2018. 01. 03.
	 * @User : 남유송
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 지원자 리스트 출력 페이지 )
	 * @Method 설명 : 기업별 지원자 현황 페이지에서 채용공고별 지원자 리스트 출력 페이지
	 */
	public ArrayList<HashMap<String, Object>> select_applicant_list(int fap_job_ad_seq) {
		logger.info("채용공고별 지원자 리스트 출력 페이지 이동 컨트롤러 시작");
		ArrayList<HashMap<String, Object>> allApplicantList = sfaDAO.select_applicant_list(fap_job_ad_seq);
		logger.info("채용공고별 지원자 리스트 출력 페이지 이동 컨트롤러 종료");
		return allApplicantList;
	}
	
	/**
	 * @Method Name : select_personal_user
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 회원 아이디
	 * @Return : 공통 회원 객체, 개인 회원 객체
	 * @Method 설명 : 회원이 가지오 있는 개인 회원 정보를 가져오는 함수
	 */
	public HashMap<String, Object> select_personal_user(String user_id){
		logger.info("FAP 개인 유저 객체 가져오기 서비스 시작");
		HashMap<String, Object> user_info = sfaDAO.select_personal_user(user_id);
		logger.info("FAP 개인 유저 객체 가져오기 서비스 종료");
		return user_info;
	}
	
	/**
	 * @Method Name : select_personal_school
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 개인 회원 객체
	 * @Return : 회원 학교 정보 객체
	 * @Method 설명 : 개인 회원이 가지고 있는 학교 정보를 가져오는 함수
	 */
	public HashMap<String, Object> select_personal_school(HashMap<String, Object> hashMap){
		logger.info("FAP 개인 유저 학교 객체 가져오기 서비스 시작");
		HashMap<String, Object> user_school = sfaDAO.select_personal_school(hashMap);
		logger.info("FAP 개인 유저 학교 객체 가져오기 서비스 종료");
		return user_school;
	}
	
	/**
	 * @Method Name : personal_user_update
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 공통, 개인 회원 객체, 학교 객체
	 * @Return : -
	 * @Method 설명 : 개인 회원 정보를 수정 하는 함수
	 */
	public void personal_user_update(Authentication auth, User user, SocietyFapPersonalUser sfpUser, 
			SocietyFapPersonalHighschool sfpHighschool, 
			SocietyFapPersonalUniversity sfpUniversity,
			SocietyFapPersonalGraduate sfpGraduate, String origin_level){
		logger.info("FAP 관리자 개인 회원 정보 수정 서비스 시작");
		// 비밀번호 변경시 암호화; 입력 하지 않을 경우는 변경 되지 않음
		if(!user.getUser_pw().equals("")){
			String encodedPw = passwordEncoder.encode(user.getUser_pw());
			user.setUser_pw(encodedPw);
		}
		
		user.setUser_udt_id((String)auth.getPrincipal());
		sfpUser.setFap_personal_user_udt_id((String)auth.getPrincipal());
		sfpHighschool.setFap_personal_hs_udt_id((String)auth.getPrincipal());
		sfpUniversity.setFap_personal_univ_udt_id((String)auth.getPrincipal());
		sfpGraduate.setFap_personal_grad_udt_id((String)auth.getPrincipal());
		
		sfaDAO.porsonal_user_update(user, sfpUser, sfpHighschool, sfpUniversity, sfpGraduate, origin_level);
		logger.info("FAP 관리자 개인 회원 정보 수정 서비스 종료");
	}
	
	/**
	 * @Method Name : delete_user_info
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 탈퇴할 회원 객체
	 * @Return : -
	 * @Method 설명 : 회원 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(30글자) 변경후 참조 테이블에 적용
	 */
	public void delete_user_info(User user){
		logger.info("FAP 관리자 회원 탈퇴 서비스 시작");
		sfaDAO.delete_user_info(user);
		logger.info("FAP 관리자 회원 탈퇴 서비스 시작");
	}
	
	/**
	 * @Method Name : select_user
	 * @Date : 2019. 1. 3. 김준영
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 공통 유저 객체
	 * @Method 설명 : 공통 유저 객체를 불러오는 함수
	 */
	public User select_user(String user_id){
		logger.info("FAP 회사 담당자 정보 가져오기 서비스 시작");
		User user = sfaDAO.select_user(user_id);
		logger.info("FAP 회사 담당자 정보 가져오기 서비스 종료");
		return user;
	}
		
	/**
	 * @Method Name : update_user
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 공통 회원 객체
	 * @Return : -
	 * @Method 설명 : 공통 회원 정보를 수정하는 함수
	 */
	public void update_user(Authentication auth, User user){
		logger.info("FAP 관리자 기업, 에이전시 관리자 정보 수정 서비스 시작");
		if(!user.getUser_pw().equals("")){
			String encodedPw = passwordEncoder.encode(user.getUser_pw());
			user.setUser_pw(encodedPw);
		}
		user.setUser_udt_id((String)auth.getPrincipal());
		sfaDAO.update_user(user);
		logger.info("FAP 관리자 기업, 에이전시 관리자 정보 수정 서비스 종료");
	}

	/**
	 * @Method Name : select_company
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 기업 아이디
	 * @Return : 기업 객체
	 * @Method 설명 : 해당하는 아이디의 기업 정보를 가져오는 함수
	 */
	public SocietyFapCompanyUser select_company(String fap_comp_id){
		logger.info("FAP 관리자 기업 정보 가져오기 서비스 시작");
		SocietyFapCompanyUser company_info = sfaDAO.select_company(fap_comp_id);
		logger.info("FAP 관리자 기업 정보 가져오기 서비스 종료");
		return company_info;
	}
	
	/**
	 * @Method Name : UploadLogo
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 기업 정보 객체
	 * @Return : -
	 * @Method 설명 : 로고 파일을 서버에 저장하는 함수
	 */
	private void UploadLogo(SocietyFapCompanyUser sfcUser) {
		logger.info("FAP 기업 로고 등록 시작");
		try {
			if (sfcUser.getFap_comp_log_file() != null) {
				sfcUser.setFap_comp_log_origin(sfcUser.getFap_comp_log_file().getOriginalFilename());
				sfcUser.setFap_comp_log_saved(FileService.saveFile(sfcUser.getFap_comp_log_file(), fapCompanyUserLogoImage+"/"+sfcUser.getFap_comp_ins_id()));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		logger.info("FAP 기업 로고 등록 종료");
	}
	
	/**
	 * @Method Name : DeleteLogo
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 파일 이름, 파일 존재 여부
	 * @Return : -
	 * @Method 설명 : 서버에 저장되어있는 파일을 삭제하는 함수
	 */
	private void DeleteLogo(SocietyFapCompanyUser sfcUser) {
		logger.info("FAP 기업 로고 삭제 시작");
		try {
			//로고 이미지 파일 삭제
			FileService.deleteFile(sfcUser.getFap_comp_log_saved(), fapCompanyUserLogoImage+"/"+sfcUser.getFap_comp_ins_id());
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		logger.info("FAP 기업 로고 삭제 종료");
	}
	
	/**
	 * @Method Name : update_company
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 기업 정보 객체
	 * @Return : -
	 * @Method 설명 : 기업 정보를 업데이트 하는 함수
	 */
	public void update_company(Authentication auth, SocietyFapCompanyUser societyFapCompanyUser){
		logger.info("FAP 관리자 기업 정보 수정 서비스 시작");
		societyFapCompanyUser.setFap_comp_udt_id((String)auth.getPrincipal());
		// 사진 변경을 하지 않았을 경우
		if(societyFapCompanyUser.getFap_comp_log_file().isEmpty()){
			sfaDAO.update_company(societyFapCompanyUser);
		// 사진 변경을 했을 경우
		} else {
			DeleteLogo(societyFapCompanyUser);
			UploadLogo(societyFapCompanyUser);
			sfaDAO.update_company(societyFapCompanyUser);
		}
		logger.info("FAP 관리자 기업 정보 수정 서비스 종료");
	}
	
	/**
	 * @Method Name : select_email
	 * @Date : 2019. 1. 15.
	 * @User : 전상수
	 * @Param : -
	 * @Return : 모든 이메일 정보 객체
	 * @Method 설명 : 모든 이메일정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_email(HashMap<String,String>data,PageNavigator pn){
		logger.info("FAP 관리자 메일정보 호출 서비스 시작");
		ArrayList<HashMap<String, Object>> mail_list=sfaDAO.select_email(data,pn);
		logger.info("FAP 관리자 메일정보 호출 서비스 시작");
		return mail_list;
	}
	/**
	 * @Method Name : select_email_content
	 * @Date : 2019. 1. 15.
	 * @User : 전상수
	 * @Param : -
	 * @Return : 모든 이메일 정보 객체
	 * @Method 설명 : 모든 이메일정보를 가져오는 함수
	 */
	public String select_email_content(String uid){
		logger.info("FAP 관리자 메일정보 호출 서비스 시작");
		String result=sfaDAO.select_email_content(uid);
		logger.info("FAP 관리자 메일정보 호출 서비스 시작");
		return result;
	}
	/**
	 * @Method Name : select_email_max_uid
	 * @Date : 2019. 1. 15.
	 * @User : 전상수
	 * @Param : -
	 * @Return : DB에 저장되어있는 이메일중 가장 최근의 것의 UID
	 * @Method 설명 : 이메일들중 가장 UID가 최근의 것을 가져오는 함수
	 */
	public HashMap<String, Object> select_email_max_uid(){
		HashMap<String, Object> max_mail;
		logger.info("FAP 관리자 max uid메일정보 호출 서비스 시작");
		max_mail=sfaDAO.select_email_max_uid();
		logger.info("FAP 관리자 max uid메일정보 호출 서비스 종료");
		return max_mail;
	}
	
	/**
	 * @Method Name : select_email_max_uid
	 * @Date : 2019. 1. 15.
	 * @User : 전상수
	 * @Param : -
	 * @Return : DB에 저장되어있는 이메일중 가장 최근의 것의 UID
	 * @Method 설명 : 이메일들중 가장 UID가 최근의 것을 가져오는 함수
	 */
	public int select_count_email(HashMap<String, String>hm){
		int result=0;
		logger.info("FAP 관리자 max uid메일정보 호출 서비스 시작");
		result=sfaDAO.select_count_email(hm);
		logger.info("FAP 관리자 max uid메일정보 호출 서비스 종료");
		return result;
	}
	
	
	/**
	 * @Method Name : insert_email
	 * @Date : 2019. 1. 15.
	 * @User : 전상수
	 * @Param : DB에 저장할 메일 객체들
	 * @Return : -
	 * @Method 설명 : 모든 이메일정보를 가져오는 함수
	 */
	public void insert_email(ArrayList<HashMap<String, Object>> allMailList){
		logger.info("FAP 관리자 기업 정보 수정 서비스 시작");
		sfaDAO.insert_email(allMailList);
		logger.info("FAP 관리자 기업 정보 수정 서비스 종료");
	}
	
	/**
	 * @Method Name : comp_user_connect_tb
	 * @Date : 2019. 1. 4.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 담당자 - 기업 연결 객체
	 * @Method 설명 : 담당자 - 기업 연결 리스트를 가져오는 함수
	 */
	public HashMap<String, Object> select_comp_user_connect(){
		logger.info("FAP 담당자 - 기업 연결 리스트 가져오기 서비스 시작");
		ArrayList<HashMap<String, Object>> connect_list = sfaDAO.select_comp_user_connect();
				
		// 승인 한 리스트
		ArrayList<HashMap<String, Object>> approval_list = new ArrayList<>();
		// 대기 중인 리스트(담당자가 기업 연결을 요청한 리스트)
		ArrayList<HashMap<String, Object>> standBy_list = new ArrayList<>();
		// 거절 한 리스트
		ArrayList<HashMap<String, Object>> refusal_list = new ArrayList<>();
		
		// 각각의 리스트에 넣어줌
		for(int i = 0; i < connect_list.size(); i++){
			
			if(connect_list.get(i).get("fap_comp_user_connect_ck").equals("B3800")){
				approval_list.add(connect_list.get(i));
			} else if(connect_list.get(i).get("fap_comp_user_connect_ck").equals("B3801")){
				standBy_list.add(connect_list.get(i));
			} else if(connect_list.get(i).get("fap_comp_user_connect_ck").equals("B3802")){
				refusal_list.add(connect_list.get(i));
			}
			
		}
		
		
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("approval_list", approval_list);
		hashMap.put("standBy_list", standBy_list);
		hashMap.put("refusal_list", refusal_list);
		
		logger.info("FAP 담당자 - 기업 연결 리스트 가져오기 서비스 종료");
		return hashMap;
	}
	
	/**
	 * @Method Name : connect_update
	 * @Date : 2019. 1. 4.
	 * @User : 김준영
	 * @Param : 변경 리스트, 승인 상태
	 * @Return : -
	 * @Method 설명 : 선택한 리스트의 승인 상태를 바꿔주는 함수
	 */
	public void connect_update(HashMap<String, Object> hashMap){
		logger.info("FAP 관리자 담당자 - 기업 연결 승인 상태 변경 서비스 시작");
		sfaDAO.connect_update(hashMap);
		logger.info("FAP 관리자 담당자 - 기업 연결 승인 상태 변경 서비스 종료");
	}
	
	/**
	 * @Method Name : connect_all_update
	 * @Date : 2019. 1. 4.
	 * @User : 김준영
	 * @Param : 변경 대상 승인 상태, 변경 할 승인 상태
	 * @Return : -
	 * @Method 설명 : 변경 대상을 변경 할 승인 상태로 바꿔주는 함수
	 */
	public void connect_all_update(HashMap<String, Object> hashMap){
		logger.info("FAP 관리자 담당자 - 기업 연결 승인 상태 전부 변경 서비스 시작");
		sfaDAO.connect_all_update(hashMap);
		logger.info("FAP 관리자 담당자 - 기업 연결 승인 상태 전부 변경 서비스 종료");
	}
	
	/**
	 * @Method Name : connect_delete
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : 삭제 할 기업 - 담당자 연결 객체 seq
	 * @Return : -
	 * @Method 설명 : 기업 - 담당자 연결을 끊는 함수
	 */
	public void connect_delete(ArrayList<Integer> seq_list){
		logger.info("FAP 관리자 담당자 - 기업 연결 끊기 서비스 시작");
		sfaDAO.connect_delete(seq_list);
		logger.info("FAP 관리자 담당자 - 기업 연결 끊기 서비스 종료");
	}
	
	/**
	 * @Method Name : select_unconnect_user_list
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 유저 객체 리스트
	 * @Method 설명 : 기업과 연결 되지 않은 유저 객체 리스트를 가져오는 함수
	 */
	public HashMap<String, Object> select_unconnect_user_list(){
		logger.info("FAP 기업과 연결 되지 않은 유저 가져오기 서비스 시작");
		ArrayList<User> user = sfaDAO.select_unconnect_user_list();
		ArrayList<User> company_user = new ArrayList<>();
		ArrayList<User> agency_user = new ArrayList<>();
		
		for(int i = 0; i < user.size(); i++){
			if(user.get(i).getUser_flag().equals("A0103")){
				company_user.add(user.get(i));
			} else if(user.get(i).getUser_flag().equals("A0104")){
				agency_user.add(user.get(i));
			}
		}
		
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("company_user", company_user);
		hashMap.put("agency_user", agency_user);
		
		logger.info("FAP 기업과 연결 되지 않은 유저 가져오기 서비스 종료");
		return hashMap;
	}
	
	/**
	 * @Method Name : select_connect_company
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 연결 할 기업 리스트
	 * @Method 설명 : 담당자와 연결할 기업 리스트를 가져오는 함수
	 */
	public HashMap<String, Object> select_connect_company(){
		logger.info("FAP 담당자와 연결 할 기업 리스트 가져오기 서비스 시작");
		ArrayList<HashMap<String, Object>> comp_all = sfaDAO.select_connect_company();
		ArrayList<HashMap<String, Object>> company_list = new ArrayList<>();
		ArrayList<HashMap<String, Object>> agency_list = new ArrayList<>();
		
		for(int i = 0; i < comp_all.size(); i++){
			if(comp_all.get(i).get("user_flag").equals("A0103")){
				company_list.add(comp_all.get(i));
			} else if(comp_all.get(i).get("user_flag").equals("A0104")){
				agency_list.add(comp_all.get(i));
			}
		}
		
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("company_list", company_list);
		hashMap.put("agency_list", agency_list);
		
		logger.info("FAP 담당자와 연결 할 기업 리스트 가져오기 서비스 종료");
		return hashMap;
	}
	
	/**
	 * @Method Name : insert_comp_user_connect
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : 연결 할 유저 아이디 리스트, 연결 할 기업 아이디
	 * @Return : - 
	 * @Method 설명 : 기업 - 담당자 연결하는 함수
	 */
	@Transactional
	public void insert_comp_user_connect(ArrayList<String> user_id_list, String fap_comp_id){
		logger.info("FAP 기업 - 담당자 연결 서비스 시작");
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("user_id_list", user_id_list);
		hashMap.put("fap_comp_id", fap_comp_id);
		hashMap.put("fap_comp_user_connect_ck", "B3800");
		sfaDAO.insert_comp_user_connect(hashMap);
		
		// 해당하는 아이디의 요청을 삭제하는 함수
		for(String user_id : user_id_list){
			sfaDAO.delete_connect_request(user_id);			
		}
		
		logger.info("FAP 기업 - 담당자 연결 서비스 종료");
	}
	
	/**
	 * @Method Name : select_ag_comp_connect
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트
	 * @Method 설명 : 에이전시 - 기업이 연결 되어있는 에이전시와 기업의 정보를 가져오는 함수
	 */
	public HashMap<String, Object> select_ag_comp_connect(){
		logger.info("FAP 에이전시 - 기업 연결 리스트 가져오기 서비스 시작");
		ArrayList<HashMap<String, Object>> connect_list = sfaDAO.select_ag_comp_connect();
		// 승인 한 리스트
		ArrayList<HashMap<String, Object>> approval_list = new ArrayList<>();
		// 대기 중인 리스트(에이전시가 기업 연결을 요청한 리스트)
		ArrayList<HashMap<String, Object>> standBy_list = new ArrayList<>();
		// 거절 한 리스트
		ArrayList<HashMap<String, Object>> refusal_list = new ArrayList<>();
		
		// 각각의 리스트에 넣어줌
		for(int i = 0; i < connect_list.size(); i++){
			if(connect_list.get(i).get("fap_ag_comp_connect_ck").equals("B3800")){
				approval_list.add(connect_list.get(i));
			} else if(connect_list.get(i).get("fap_ag_comp_connect_ck").equals("B3801")){
				standBy_list.add(connect_list.get(i));
			} else if(connect_list.get(i).get("fap_ag_comp_connect_ck").equals("B3802")){
				refusal_list.add(connect_list.get(i));
			}
		}
		
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("approval_list", approval_list);
		hashMap.put("standBy_list", standBy_list);
		hashMap.put("refusal_list", refusal_list);
		
		logger.info("FAP 에이전시 - 기업 연결 리스트 가져오기 서비스 종료");
		return hashMap;
	}
	
	/**
	 * @Method Name : select_unconnect_comp_list
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 에이전시와 연결 되어 있지 않은 기업 리스트
	 * @Method 설명 : 에이전시와 연결 되어 있지 않은 기업 리스트를 가져오는 함수
	 * 				(연결 테이블에 값이 존재 하지 않는 기업만 가져옴; 대기, 거절 등의 기업은 관리에서 처리)
	 */
	public ArrayList<SocietyFapCompanyUser> select_unconnect_comp_list(int start, int countPerPage){
		logger.info("FAP 에이전시와 연결 되어 있지 않은 기업 리스트 가져오기 서비스 시작");
		ArrayList<SocietyFapCompanyUser> unconnect_comp_list = sfaDAO.select_unconnect_comp_list(start, countPerPage);
		logger.info("FAP 에이전시와 연결 되어 있지 않은 기업 리스트 가져오기 서비스 종료");
		return unconnect_comp_list;
	}
	
	/**
	 * @Method Name : select_agency_list
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 일반기업을 제외한 에이전시 객체
	 * @Method 설명 : 기업 객체 중 일반 기업을 제외한 에이전시 객체 리스트를 가져오는 함수
	 */
	public ArrayList<SocietyFapCompanyUser> select_agency_list(int start, int countPerPage){
		logger.info("FAP 에이전시 리스트 가져오기 서비스 시작");
		ArrayList<SocietyFapCompanyUser> select_agency_list = sfaDAO.select_agency_list(start, countPerPage);
		logger.info("FAP 에이전시 리스트 가져오기 서비스 종료");
		return select_agency_list;
	}
	
	/**
	 * @Method Name : connect_ag_comp
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : 연결 객체
	 * @Return : -
	 * @Method 설명 : 에이전시 - 기업을 연결 하는 함수
	 */
	public void connect_ag_comp(String company_id, String agency_id){
		logger.info("FAP 에이전시 - 기업 연결 서비스 시작");
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("company_id", company_id);
		hashMap.put("agency_id", agency_id);
		hashMap.put("fap_ag_comp_connect_ck", "B3800");
		sfaDAO.connect_ag_comp(hashMap);
		logger.info("FAP 에이전시 - 기업 연결 서비스 종료");
	}
	
	/**
	 * @Method Name : ag_comp_connect_delete
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : 에이전시 - 기업 연결 seq 리스트
	 * @Return : -
	 * @Method 설명 : 에이전시 - 기업 연결을 끊는 함수
	 */
	public void ag_comp_connect_delete(ArrayList<Integer> seq_list){
		logger.info("FAP 에이전시 - 기업 연결 끊기 서비스 시작");
		sfaDAO.ag_comp_connect_delete(seq_list);
		logger.info("FAP 에이전시 - 기업 연결 끊기 서비스 종료");
	}
	
	/**
	 * @Method Name : ag_comp_connect_update
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : 에이전시 - 기업 연결 객체
	 * @Return : -
	 * @Method 설명 : 에이전시 - 기업 연결 객체의 승인 상태를 변경하는 함수
	 */
	public void ag_comp_connect_update(ArrayList<Integer> seq_list, String fap_ag_comp_connect_ck){
		logger.info("FAP 에이전시 - 기업 연결 승인 상태 변경 서비스 시작");
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("seq_list", seq_list);
		hashMap.put("fap_ag_comp_connect_ck", fap_ag_comp_connect_ck);
		sfaDAO.ag_comp_connect_update(hashMap);
		logger.info("FAP 에이전시 - 기업 연결 승인 상태 변경 서비스 종료");
	}
	
	/**
	 * @Method Name : select_uncertain_company
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 기업 객체
	 * @Method 설명 : 기업 - 유저 연결 객체가 없어 기업, 에이전시 구분이 모호한 기업 리스트를 가져오는 함수
	 */
	public ArrayList<SocietyFapCompanyUser> select_uncertain_company(int start, int countPerPage){
		logger.info("FAP 불분명한 기업 리스트 가져오기 서비스 시작");
		ArrayList<SocietyFapCompanyUser> uncertain_company_list = sfaDAO.select_uncertain_company(start, countPerPage);
		logger.info("FAP 불분명한 기업 리스트 가져오기 서비스 종료");
		return uncertain_company_list;
	}	
	
	/**
	 * @Method Name : search_job_ad_info
	 * @Date : 2019. 1. 10.
	 * @User : 신동철
	 * @Param : 잡페어시퀀스, 잡페어세부 시퀀스, 채용전형 설정여부, 회사명
	 * @Return : 채용공고 정보
	 * @Method 설명 : 채용공고 정보 검색
	 */
	public ArrayList<HashMap<String, Object>> search_job_ad_info(int fap_jobfair_seq, int fap_jobfair_divide_seq, String fap_job_recruit_pcs_sch_ck, String comp_nm){
		logger.info("채용공고 정보 검색 Service 시작");
		
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_jobfair_seq", fap_jobfair_seq);
		hashmap.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		hashmap.put("fap_job_recruit_pcs_sch_ck", fap_job_recruit_pcs_sch_ck);
		hashmap.put("comp_nm", comp_nm);
		ArrayList<HashMap<String, Object>> job_ad_info_list = sfaDAO.search_job_ad_info(hashmap);		
		
		logger.info("채용공고 정보 검색 Service 종료");
		return job_ad_info_list;
	}
	
	/**
	 * @Method Name : search_recruit_process_info
	 * @Date : 2019. 1. 10.
	 * @User : 신동철
	 * @Param : 잡페어시퀀스, 잡페어세부 시퀀스, 채용전형 설정여부, 회사명
	 * @Return : 채용전형 정보
	 * @Method 설명 : 채용전형 정보 검색
	 */
	public ArrayList<HashMap<String, Object>> search_recruit_process_info(int fap_jobfair_seq, int fap_jobfair_divide_seq, String fap_job_recruit_pcs_sch_ck, String comp_nm){
		logger.info("채용전형 정보 검색 Service 시작");
		
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_jobfair_seq", fap_jobfair_seq);
		hashmap.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		hashmap.put("fap_job_recruit_pcs_sch_ck", fap_job_recruit_pcs_sch_ck);
		hashmap.put("comp_nm", comp_nm);
		ArrayList<HashMap<String, Object>> recruit_process_info_list = sfaDAO.search_recruit_process_info(hashmap);
		
		logger.info("채용전형 정보 검색 Service 종료");
		return recruit_process_info_list;
	}
	
	/**
	 * @Method Name : select_review_pcs
	 * @Date : 2019. 1. 12.
	 * @User : 신동철
	 * @Param : 서류전형 스케줄 시퀀스
	 * @Return : 서류전형 정보
	 * @Method 설명 : 서류전형 정보 검색
	 */
	public HashMap<String, Object> select_review_pcs(String fap_job_recruit_pcs_seq){
		logger.info("서류전형 정보 검색 Service 시작");
		
		HashMap<String, Object> review_pcs_info = sfaDAO.select_review_pcs(Long.parseLong(fap_job_recruit_pcs_seq));
		
		logger.info("서류전형 정보 검색 Service 종료");
		return review_pcs_info;
	}
	
	/**
	 * @Method Name : select_exam_pcs
	 * @Date : 2019. 1. 12.
	 * @User : 신동철
	 * @Param : 시험전형 스케줄 시퀀스
	 * @Return : 시험전형 정보
	 * @Method 설명 : 시험전형 정보 검색
	 */
	public HashMap<String, Object> select_exam_pcs(String fap_job_recruit_pcs_seq){
		logger.info("시험전형 정보 검색 Service 시작");
		
		HashMap<String, Object> exam_pcs_info = sfaDAO.select_exam_pcs(Long.parseLong(fap_job_recruit_pcs_seq));
		
		logger.info("시험전형 정보 검색 Service 종료");
		return exam_pcs_info;
	}
	
	/**
	 * @Method Name : select_itv_pcs
	 * @Date : 2019. 1. 12.
	 * @User : 신동철
	 * @Param : 면접전형 시퀀스
	 * @Return : 면접전형 정보
	 * @Method 설명 : 면접전형 정보 검색
	 */
	public HashMap<String, Object> select_itv_pcs(String fap_job_recruit_pcs_seq){
		logger.info("면접전형 정보 검색 Service 시작");
		
		HashMap<String, Object> itv_pcs_info = sfaDAO.select_itv_pcs(Long.parseLong(fap_job_recruit_pcs_seq));
		
		logger.info("면접전형 정보 검색 Service 종료");
		return itv_pcs_info;
	}
	
	/**
	 * @Method Name : select_test_etc_pcs
	 * @Date : 2019. 1. 12.
	 * @User : 신동철
	 * @Param : 기타전형 시퀀스
	 * @Return : 기타전형 정보
	 * @Method 설명 : 기타전형 정보 검색
	 */
	public HashMap<String, Object> select_test_etc_pcs(String fap_job_recruit_pcs_seq){
		logger.info("기타전형 정보 검색 Service 시작");
		
		HashMap<String, Object> test_etc_pcs_info = sfaDAO.select_test_etc_pcs(Long.parseLong(fap_job_recruit_pcs_seq));
		
		logger.info("기타전형 정보 검색 Service 종료");
		return test_etc_pcs_info;
	}
	
	/**
	 * @Method Name : update_review_process_schedule
	 * @Date : 2019. 1. 13.
	 * @User : 신동철
	 * @Param : 서류전형 정보
	 * @Return : -
	 * @Method 설명 : 서류전형 스케줄 설정
	 */
	public void update_review_process_schedule(SocietyFapJobRecruitPcsSch review_process_schedule, SocietyFapJobRecruitPcs review_process){
		logger.info("서류전형 스케줄 설정 Service 시작");		
		
		//udt_id
		
		
		//서류전형 시작일, 종료일
		String date_st = review_process_schedule.getFap_job_review_date_st();
		String time_st = review_process_schedule.getFap_job_review_time_st();
		String date_et = review_process_schedule.getFap_job_review_date_et();
		String time_et = review_process_schedule.getFap_job_review_time_et();
		review_process_schedule.setFap_job_recruit_pcs_sch_st(date_st + " " + time_st);
		review_process_schedule.setFap_job_recruit_pcs_sch_et(date_et + " " + time_et);			
		
		sfaDAO.update_review_process_schedule(review_process_schedule);
		sfaDAO.update_review_process(review_process);
		
		logger.info("서류전형 스케줄 설정 Service 종료");
	}
	
	/**
	 * @Method Name : update_exam_process_schedule
	 * @Date : 2019. 1. 13.
	 * @User : 신동철
	 * @Param : 시험전형 정보
	 * @Return : -
	 * @Method 설명 : 시험전형 스케줄 설정
	 */
	public void update_exam_process_schedule(SocietyFapJobRecruitPcsSch exam_process_schedule, SocietyFapJobExam exam_process, SocietyFapJobExamFile exam_file,
			SocietyFapJobExamObjEtc exam_obj_etc, SocietyFapJobExamSvEtc exam_sv_etc, SocietyFapJobExamNeedEtc exam_need_etc, SocietyFapJobExamType exam_type
			, Authentication auth){
		logger.info("시험전형 스케줄 설정 Service 시작");
		
		//시험전형 시작일, 종료일
		String date_st = exam_process_schedule.getFap_job_exam_date_st();
		String time_st = exam_process_schedule.getFap_job_exam_time_st();
		String date_et = exam_process_schedule.getFap_job_exam_date_et();
		String time_et = exam_process_schedule.getFap_job_exam_time_et();
		exam_process_schedule.setFap_job_recruit_pcs_sch_st(date_st + " " + time_st);
		exam_process_schedule.setFap_job_recruit_pcs_sch_et(date_et + " " + time_et);		
		
		sfaDAO.update_exam_process_schedule(exam_process_schedule);
		sfaDAO.update_exam_process(exam_process);		
		sfaDAO.update_exam_obj_etc(exam_obj_etc);
		sfaDAO.update_exam_sv_etc(exam_sv_etc);
		sfaDAO.update_exam_need_etc(exam_need_etc);
		//다중처리로 인해 임시 주석
		//sfaDAO.update_exam_type(exam_type);
		
		//시험파일 체크
		//새로 들어온 파일이 있는지  
		if(exam_file.getFap_job_exam_file() != null && !exam_file.getFap_job_exam_file().isEmpty()){ 
			//기존 업로드된 파일이 있는지
			if(exam_file.getFap_job_exam_file_origin() != null && exam_file.getFap_job_exam_file_saved() != null){				
				//디렉토리에서 파일 삭제
				boolean result = FileService.deleteFile(exam_file.getFap_job_exam_file_saved(), fapCompanyJobRecruitExamFile);			 
				 
				//db에서 파일 삭제 				 
				int result2 = sfaDAO.delete_exam_file(exam_file.getFap_job_exam_file_saved());						 
			}				
			String logoOrigin = exam_file.getFap_job_exam_file().getOriginalFilename();
			String logoSaved = FileService.saveFile(exam_file.getFap_job_exam_file(), fapCompanyJobRecruitExamFile);
			exam_file.setFap_job_exam_file_origin(logoOrigin);
			exam_file.setFap_job_exam_file_saved(logoSaved);		
			exam_file.setFap_job_exam_file_ins_id((String)auth.getPrincipal());
			exam_file.setFap_job_exam_file_udt_id((String)auth.getPrincipal());
			sfaDAO.insert_exam_file(exam_file);  
		}
		
		logger.info("시험전형 스케줄 설정 Service 종료");
	}
	
	/**
	 * @Method Name : update_itv_process_schedule
	 * @Date : 2019. 1. 13.
	 * @User : 신동철
	 * @Param : 면접전형 정보
	 * @Return : -
	 * @Method 설명 : 면접전형 스케줄 설정
	 */
	public void update_itv_process_schedule(SocietyFapJobRecruitPcsSch itv_process_schedule, SocietyFapJobRecruitPcs itv_process,
			SocietyFapJobItv itv_process_info, SocietyFapJobItvTpEtc itv_tp_etc, SocietyFapJobItvObjEtc itv_obj_etc){
		logger.info("면접전형 스케줄 설정 Service 시작");
		
		//면접 전형 시작일, 종료일, 수정자
		String date_st = itv_process_schedule.getFap_job_itv_date_st();
		String time_st = itv_process_schedule.getFap_job_itv_time_st();
		String date_et = itv_process_schedule.getFap_job_itv_date_et();
		String time_et = itv_process_schedule.getFap_job_itv_time_et();
		itv_process_schedule.setFap_job_recruit_pcs_sch_st(date_st + " " + time_st);
		itv_process_schedule.setFap_job_recruit_pcs_sch_et(date_et + " " + time_et);		
		
		sfaDAO.update_itv_process_schedule(itv_process_schedule);
		sfaDAO.update_itv_process(itv_process);
		sfaDAO.update_itv_process_info(itv_process_info);
		sfaDAO.update_itv_tp_etc(itv_tp_etc);
		sfaDAO.update_itv_obj_etc(itv_obj_etc);
		
		logger.info("면접전형 스케줄 설정 Service 종료");
	}
	
	/**
	 * @Method Name : update_test_etc_process_schedule
	 * @Date : 2019. 1. 13.
	 * @User : 신동철
	 * @Param : 기타전형 정보
	 * @Return : -
	 * @Method 설명 : 기타전형 스케줄 설정
	 */
	public void update_test_etc_process_schedule(SocietyFapJobRecruitPcsSch test_etc_process_schedule, 
			SocietyFapJobTestEtc test_etc_info, SocietyFapJobTestEtcObj test_etc_obj){
		logger.info("기타전형 스케줄 설정 Service 시작");
		
		//기타전형 시작일, 종료일, 수정자
		String date_st = test_etc_process_schedule.getFap_job_test_etc_date_st();
		String time_st = test_etc_process_schedule.getFap_job_test_etc_time_st();
		String date_et = test_etc_process_schedule.getFap_job_test_etc_date_et();
		String time_et = test_etc_process_schedule.getFap_job_test_etc_time_et();
		test_etc_process_schedule.setFap_job_recruit_pcs_sch_st(date_st + " " + time_st);
		test_etc_process_schedule.setFap_job_recruit_pcs_sch_et(date_et + " " + time_et);		
		
		sfaDAO.update_test_etc_process_schedule(test_etc_process_schedule);
		sfaDAO.update_test_etc_info(test_etc_info);
		sfaDAO.update_test_etc_obj(test_etc_obj);		
		
		logger.info("기타전형 스케줄 설정 Service 종료");
	}
	
	/**
	 * @Method Name : select_recruit_pcs_sch
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 전형일정 스케줄 검색 정보
	 * @Return : 전형일정 스케줄
	 * @Method 설명 : 전형일정 스케줄 검색
	 */
	public ArrayList<HashMap<String, Object>> select_recruit_pcs_sch(SocietyFapJobRecruitPcsSch recruit_pcs_sch){
		logger.info("전형일정 스케줄 검색 Service 시작");
		
		ArrayList<HashMap<String, Object>> recruit_pcs_sch_list = sfaDAO.select_recruit_pcs_sch(recruit_pcs_sch);
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
		
		logger.info("전형일정 스케줄 검색 Service 종료");
		return schedule_list;
	}
	
	/**
	 * @Method Name : search_job_ad_jobfair_list
	 * @Date : 2019. 1. 18.
	 * @User : 신동철
	 * @Param : -
	 * @Method 설명 : 승인된 채용공고의 모든 잡페어 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> search_job_ad_jobfair_list(){
		logger.info("승인된 채용공고의 모든 잡페어 리스트 검색 Service 시작");
		
		ArrayList<HashMap<String, Object>> job_ad_jobfair_list = sfaDAO.search_job_ad_jobfair_list();
		
		logger.info("승인된 채용공고의 모든 잡페어 리스트 검색 Service 종료");
		return job_ad_jobfair_list;
	}
	
	/**
	 * @Method Name : search_job_ad_comp_list
	 * @Date : 2019. 1. 18.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 승인된 채용공고의 모든 회사 리스트
	 * @Method 설명 : 승인된 채용공고의 모든 회사 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> search_job_ad_comp_list(){
		logger.info("회사가 참가하여 승인받은 채용공고 리스트 검색 Service 시작");
		
		ArrayList<HashMap<String, Object>> job_ad_comp_list = sfaDAO.search_job_ad_comp_list();
		
		logger.info("회사가 참가하여 승인받은 채용공고 리스트 검색 Service 종료");
		return job_ad_comp_list;
	}
	
	/**
	 * @Method Name : search_job_ad_list
	 * @Date : 2019. 1. 18.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스, 잡페어세부 시퀀스, 회사 아이디
	 * @Return : 회사가 참가하여 승인받은 채용공고 리스트
	 * @Method 설명 : 회사가 참가하여 승인받은 채용공고 리스트 검색
	 */
	public ArrayList<SocietyFapJobAd> search_job_ad_list(SocietyFapJobAd jobAd){
		logger.info("회사가 참가하여 승인받은 채용공고 리스트 검색 Service 시작");
		
		ArrayList<SocietyFapJobAd> job_ad_list = sfaDAO.search_job_ad_list(jobAd);
		
		logger.info("회사가 참가하여 승인받은 채용공고 리스트 검색 Service 종료");
		return job_ad_list;
	}
	
	/**
	 * @Method Name : select_job_ad_comp_list
	 * @Date : 2019. 1. 18.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스
	 * @Return : 해당 잡페어의 채용공고에 승인받은 회사 목록
	 * @Method 설명 : 해당잡페어의 채용공고에 승인받은 회사 목록 검색
	 */
	public ArrayList<HashMap<String, Object>> select_job_ad_comp_list(int fap_jobfair_seq){
		logger.info("해당 잡페어의 채용공고에 승인받은 회사 목록 검색 Service 시작");
		
		ArrayList<HashMap<String, Object>> job_ad_comp_list = sfaDAO.select_job_ad_comp_list(fap_jobfair_seq);
		
		logger.info("해당 잡페어의 채용공고에 승인받은 회사 목록 검색 Service 종료");
		return job_ad_comp_list;
	}

	/**
	 * @Method Name : applied_result_list
	 * @Date : 2018. 01. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : ArrayList
	 * @Method 설명 : 지원자별 전형 결과 가져오기
	 */
	public ArrayList<HashMap<String, Object>> select_applied_result(HashMap<String, Object> params) {
		logger.info("지원자별 전형 결과 출력 컨트롤러 시작");
		ArrayList<HashMap<String, Object>> applied_result_list=sfaDAO.select_applied_result(params);
		logger.info("지원자별 전형 결과 출력 컨트롤러 종료");
		return applied_result_list;
	}
	
	/**
	 * @Method Name : select_jobfair_apply_count
	 * @Date : 2019. 1. 21.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스, 회원타입, 승인여부, 지원자명
	 * @Return : 잡페어의 지원자 count
	 * @Method 설명 : 잡페어의 지원자 count 조회
	 */
	public int select_jobfair_apply_count(HashMap<String,Object> map){
		logger.info("잡페어의 지원자 count 조회 Service 시작");
		
		int apply_count = sfaDAO.select_jobfair_apply_count(map);
		
		logger.info("잡페어의 지원자 count 조회 Service 종료");
		return apply_count;
	}
	
	/**
	 * @Method Name : per_jobfair_temp_group_insert
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 잡페어별 임시 결제 그룹 정보, 세부잡페어별 임시 결제 정보
	 * @Return : -
	 * @Method 설명 : 잡페어별 임시 결제 그룹 정보 등록
	 */
	@Transactional
	public void per_jobfair_temp_group_insert(SocietyFapPerJobfairTempGroup perGroup, SocietyFapPerJobfairDivideTemp divideTemp) {
		logger.debug("잡페어별 임시 결제 그룹 정보 등록 서비스 시작");
		
		sfaDAO.per_jobfair_temp_group_insert(perGroup, divideTemp);
		
		logger.debug("잡페어별 임시 결제 그룹 정보 등록 서비스 종료");
	}
	
	/**
	 * @Method Name : per_jobfair_temp_group_search
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 임시 결제 그룹 정보
	 * @Method 설명 : 잡페어별 임시 결제 그룹 정보 검색
	 */
	public ArrayList<HashMap<String, Object>> per_jobfair_temp_group_search(int fap_jobfair_seq){
		logger.debug("잡페어별 임시 결제 그룹 정보 검색 서비스 시작");
		
		ArrayList<HashMap<String, Object>> result = sfaDAO.per_jobfair_temp_group_search(fap_jobfair_seq);
		
		logger.debug("잡페어별 임시 결제 그룹 정보 검색 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : per_jobfair_temp_group_delete
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 잡페어별 임시 결제 그룹 정보 시퀀스
	 * @Return : -
	 * @Method 설명 : 잡페어별 임시 결제 그룹 정보 삭제
	 */
	public void per_jobfair_temp_group_delete(int fap_per_jobfair_temp_group_seq) {
		logger.debug("잡페어별 임시 결제 그룹 정보 삭제 서비스 시작");
		
		sfaDAO.per_jobfair_temp_group_delete(fap_per_jobfair_temp_group_seq);
		
		logger.debug("잡페어별 임시 결제 그룹 정보 삭제 서비스 종료");
	}
	
	/**
	 * @Method Name : per_jobfair_temp_group_search_detail
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 잡페어별 임시 결제 그룹 정보 시퀀스
	 * @Return : 잡페어별 임시 결제 그룹 정보
	 * @Method 설명 : 잡페어별 임시 결제 그룹 정보 상세 검색
	 */
	public HashMap<String, Object> per_jobfair_temp_group_search_detail(SocietyFapPerJobfairTempGroup perGroup){
		logger.debug("잡페어별 임시 결제 그룹 정보 검색 서비스 시작");
		
		HashMap<String, Object> result = sfaDAO.per_jobfair_temp_group_search_detail(perGroup);
		
		logger.debug("잡페어별 임시 결제 그룹 정보 검색 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : per_jobfair_temp_group_update
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 잡페어별 임시 결제 그룹 정보
	 * @Return : -
	 * @Method 설명 : 잡페어별 임시 결제 그룹 정보 수정
	 */
	public void per_jobfair_temp_group_update(SocietyFapPerJobfairTempGroup perGroup,SocietyFapPerJobfairDivideTemp divideTemp) {
		logger.debug("잡페어별 임시 결제 그룹 정보 수정 서비스 시작");
		
		sfaDAO.per_jobfair_temp_group_update(perGroup,divideTemp);
		
		logger.debug("잡페어별 임시 결제 그룹 정보 수정 서비스 종료");
	}
	
	/**
	 * @Method Name : select_comp_list_include_agency
	 * @Date : 2019. 1. 28.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 기업(에이전시 포함) 리스트 맵
	 * @Method 설명 : 기업(에이전시 포함) 리스트 검색
	 */
	public ArrayList<HashMap<String, Object>> select_comp_list_include_agency(int fap_jobfair_seq){
		logger.debug("기업(에이전시 포함) 리스트 검색 서비스 시작");
		
		ArrayList<HashMap<String, Object>> result = sfaDAO.select_comp_list_include_agency(fap_jobfair_seq);
		
		logger.debug("기업(에이전시 포함) 리스트 검색 서비스 종료");
		
		return result;
	}
	
	/**
	 * @Method Name : per_comp_temp_payment_update
	 * @Date : 2019. 2. 7.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 회사 결제정보 수정
	 * @Method 설명 : 잡페어별 회사 결제정보 수정
	 */
	public void per_comp_temp_payment_update(HashMap<String, Object> params) {
		logger.debug("잡페어별 회사 결제정보 수정 서비스 시작");
		
		sfaDAO.per_comp_temp_payment_update(params);
		
		logger.debug("잡페어별 회사 결제정보 수정 서비스 종료");
	}
	
	/**
	 * @Method Name : per_comp_temp_payment_insert
	 * @Date : 2019. 2. 7.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 회사 결제정보 등록
	 * @Method 설명 : 잡페어별 회사 결제정보 등록
	 */
	public void per_comp_temp_payment_insert(HashMap<String, Object> params) {
		logger.debug("잡페어별 회사 결제정보 등록 서비스 시작");
		
		sfaDAO.per_comp_temp_payment_insert(params);
		
		logger.debug("잡페어별 회사 결제정보 등록 서비스 종료");
	}
	
	/**
	 * @Method Name : per_comp_temp_payment_delete
	 * @Date : 2019. 2. 7.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 회사 결제정보 삭제
	 * @Method 설명 : 잡페어별 회사 결제정보 삭제
	 */
	public void per_comp_temp_payment_delete(int fap_per_comp_temp_payment_seq) {
		logger.debug("잡페어별 회사 결제정보 삭제 서비스 시작");
		
		sfaDAO.per_comp_temp_payment_delete(fap_per_comp_temp_payment_seq);
		
		logger.debug("잡페어별 회사 결제정보 삭제 서비스 종료");
	}
	
	/**
	 * @Method Name : select_connect_request
	 * @Date : 2019. 2. 7.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 기업 - 담당자 연결 요청 객체
	 * @Method 설명 : 기업 - 담당자 연결 요청 객체를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_connect_request(int start, int countPerPage){
		logger.info("FAP 기업 - 담당자 연결 요청 가져오기 서비스 시작");
		ArrayList<HashMap<String, Object>> CompUserConnectRequest = sfaDAO.select_connect_request(start, countPerPage);
		logger.info("FAP 기업 - 담당자 연결 요청 가져오기 서비스 종료");
		return CompUserConnectRequest;
	}
	
	/**
	 * @Method Name : delete_connect_request_seq
	 * @Date : 2019. 2. 8.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : -
	 * @Method 설명 : 기업 - 담당자 연결 요청을 삭제하는 함수
	 */
	public int delete_connect_request_seq(int fap_comp_user_request_seq){
		logger.info("FAP 기업 - 담당자 연결 요청 삭제 DAO 시작");
		int result = sfaDAO.delete_connect_request_seq(fap_comp_user_request_seq);
		logger.info("FAP 기업 - 담당자 연결 요청 삭제 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_user_list_paging_count
	 * @Date : 2019. 2. 11.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 회원 수
	 * @Method 설명 : 회원 수를 불러오는 함수 
	 */
	public int select_user_list_paging_count(){
		logger.info("회원 수 가져오기 서비스 시작");
		int userTotalCount = sfaDAO.select_user_list_paging_count();
		logger.info("회원 수 가져오기 서비스 종료");
		return userTotalCount;
	}
	
	/**
	 * @Method Name : select_company_list_paging_count
	 * @Date : 2019. 8. 1.
	 * @User : 김경아
	 * @Param : 검색 관련 정보
	 * @Return : 기업 수
	 * @Method 설명 : 기업 수를 불러오는 함수 
	 */
	public int select_company_list_paging_count(HashMap<String, Object> paramMap){
		logger.info("기업 수 가져오기 서비스 시작");
		System.out.println("search단어:"+paramMap.get("searchEnNm"));
		int companyTotalCount = sfaDAO.select_company_list_paging_count(paramMap);
		logger.info("기업 수 가져오기 서비스 종료");
		return companyTotalCount;
	}
	
	/**
	 * @Method Name : select_fap_notice
	 * @Date : 2019. 2. 14.
	 * @User : 김준영
	 * @Param : -
	 * @Return : FAP 공지사항 hashmap 객체
	 * @Method 설명 : FAP 공지사항을 불러오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_fap_notice(){
		logger.info("FAP 공지사항 가져오기 서비스 시작");
		ArrayList<HashMap<String, Object>> notice_list = sfaDAO.select_fap_notice();
		logger.info("FAP 공지사항 가져오기 서비스 종료");
		return notice_list;
	}
	
	/**
	 * @Method Name : select_standby_ag_comp_connect_list
	 * @Date : 2019. 2. 14.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 대기중인 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트
	 * @Method 설명 : 대기중인 에이전시 - 기업이 연결 되어있는 에이전시와 기업의 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_standby_ag_comp_connect_list(int start, int countPerPage){
		logger.info("FAP 대기중인 에이전시 - 기업 연결 리스트 가져오기 서비스 시작");
		
		ArrayList<HashMap<String, Object>> select_standby_ag_comp_connect_list = sfaDAO.select_standby_ag_comp_connect_list(start, countPerPage);
		
		logger.info("FAP 대기중인 에이전시 - 기업 연결 리스트 가져오기 서비스 종료");
		return select_standby_ag_comp_connect_list;
	}
	
	/**
	 * @Method Name : select_standby_ag_comp_connect_list_paging_count
	 * @Date : 2019. 2. 14.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 대기중인 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수
	 * @Method 설명 : 대기중인 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수를 불러오는 함수
	 */
	public int select_standby_ag_comp_connect_list_paging_count(){
		logger.info("대기중인 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수 가져오기 서비스 시작");
		int standbyTotalCount = sfaDAO.select_standby_ag_comp_connect_list_paging_count();
		logger.info("대기중인 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수 가져오기 서비스 종료");
		return standbyTotalCount;
	}
	
	/**
	 * @Method Name : board_search_all_count
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 관리자 게시판의 모든 게시물 개수
	 * @Method 설명 : 관리자 게시판 진입 시 모든 게시물 개수 조회
	 */
	public int board_search_all_count(HashMap<String, Object> map){
		logger.debug("FAP 관리자 게시판 모든 게시물 개수 조회 서비스 함수 시작");
		int board_all_count = sfaDAO.board_search_all_count(map);
		logger.debug("FAP 관리자 게시판 모든 게시물 개수 조회 서비스 함수 종료");
		return board_all_count;
	}
	
	/**
	 * @Method Name : board_search_all
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 관리자 게시판의 모든 게시물
	 * @Method 설명 : 관리자 게시판 진입 시 모든 게시물 조회
	 */
	public ArrayList<BoardGroup> board_search_all(HashMap<String, Object> map){
		logger.debug("FAP 관리자 게시판 모든 게시물 조회 서비스 함수 시작");
		ArrayList<BoardGroup> resultList = sfaDAO.board_search_all(map);
		logger.debug("FAP 관리자 게시판 모든 게시물 조회 서비스 함수 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : board_contents_search
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : 관리자 게시판 관리의 특정 게시판 정보 객체
	 * @Return : 관리자 게시판의 특정 게시판의 게시글 리스트
	 * @Method 설명 : 게시글 리스트를 가져오는 함수
	 */
	public ArrayList<HashMap<String,Object>> board_contents_search(HashMap<String, Object> map){
		logger.info("FAP 관리자 게시글 가져오기 서비스 시작");
		ArrayList<HashMap<String,Object>> board_list = sfaDAO.board_contents_search(map);
		logger.info("FAP 관리자 게시글 가져오기 서비스 종료");
		return board_list;
	}
	
	/**
	 * @Method Name : board_contents_count
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : 관리자 게시판 관리의 특정 게시판 정보 객체
	 * @Return : 관리자 게시판의 특정 게시판의 게시글 갯수
	 * @Method 설명 : 페이징을 위한 전체글 갯수 조회하는 함수
	 */
	public int board_contents_count(HashMap<String, Object> map){
		logger.info("FAP 관리자 게시글 갯수 가져오기 서비스 시작");
		int count = sfaDAO.board_contents_count(map);
		logger.info("FAP 관리자 게시글 갯수 가져오기 서비스 종료");
		return count;
	}
	
	/**
	 * @Method Name : select_approval_ag_comp_connect_list
	 * @Date : 2019. 2. 15.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 승인받은 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트
	 * @Method 설명 : 승인받은 에이전시 - 기업이 연결 되어있는 에이전시와 기업의 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_approval_ag_comp_connect_list(int start, int countPerPage){
		logger.info("FAP 승인받은 에이전시 - 기업 연결 리스트 가져오기 서비스 시작");
		
		ArrayList<HashMap<String, Object>> select_approval_ag_comp_connect_list = sfaDAO.select_approval_ag_comp_connect_list(start, countPerPage);
		
		logger.info("FAP 승인받은 에이전시 - 기업 연결 리스트 가져오기 서비스 종료");
		return select_approval_ag_comp_connect_list;
	}
	
	/**
	 * @Method Name : select_approval_ag_comp_connect_list_paging_count
	 * @Date : 2019. 2. 15.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 승인받은 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수
	 * @Method 설명 : 승인받은 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수를 불러오는 함수
	 */
	public int select_approval_ag_comp_connect_list_paging_count(){
		logger.info("승인받은 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수 가져오기 서비스 시작");
		int approvalTotalCount = sfaDAO.select_approval_ag_comp_connect_list_paging_count();
		logger.info("승인받은 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수 가져오기 서비스 종료");
		return approvalTotalCount;
	}
	
	/**
	 * @Method Name : select_unconnect_comp_list_paging_count
	 * @Date : 2019. 2. 15.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 에이전시에 연결 되어있지 않은 기업 리스트 총 개수 
	 * @Method 설명 : 에이전시에 연결 되어있지 않은 기업 리스트 총 개수를 불러오는 함수
	 */
	public int select_unconnect_comp_list_paging_count(){
		logger.info("에이전시에 연결 되어있지 않은 기업 리스트 총 개수 가져오기 서비스 시작");
		int unconnectTotalCount = sfaDAO.select_unconnect_comp_list_paging_count();
		logger.info("에이전시에 연결 되어있지 않은 기업 리스트 총 개수 가져오기 서비스 종료");
		return unconnectTotalCount;
	}
	
	/**
	 * @Method Name : select_agency_list_paging_count
	 * @Date : 2019. 2. 15.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 기업에 연결 될 에이전시 리스트 총 개수
	 * @Method 설명 : 기업에 연결 될 에이전시 리스트 총 개수를 불러오는 함수
	 */
	public int select_agency_list_paging_count(){
		logger.info("기업에 연결 될 에이전시 리스트 총 개수 가져오기 서비스 시작");
		int agencyTotalCount = sfaDAO.select_agency_list_paging_count();
		logger.info("기업에 연결 될 에이전시 리스트 총 개수 가져오기 서비스 종료");
		return agencyTotalCount;
	}
	
	/**
	 * @Method Name : UploadFileServer
	 * @Date : 2018. 12. 11.
	 * @User : 신동철
	 * @Param : 잡페어 객체
	 * @Return : -
	 * @Method 설명 : 잡페어 등록시 로고 파일 서버 저장
	 */
	private void UploadNoticeFile(BoardFile boardFile) {
		try {
			if(boardFile.getBoard_file() != null){
				boardFile.setBoard_file_origin(boardFile.getBoard_file().getOriginalFilename());
				boardFile.setBoard_file_saved(FileService.saveFile(boardFile.getBoard_file(), fapAdminNoticeFile));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @Method Name : notice_insert
	 * @Date : 2019. 2. 19.
	 * @User : 신동철
	 * @Param : 공지사항 내용, 부가내용
	 * @Return : -
	 * @Method 설명 : FAP 공지사항 내용, 부가내용 등록 함수
	 */
	@Transactional
	public void notice_insert(Authentication auth, BoardContent boardContent, SocietyFapAdminNoticeContent noticeContent, 
			BoardFile boardFile){
		logger.info("FAP 관리자 공지사항 등록 DAO 시작");
		// 파일을 넣어줌
		if(boardFile.getBoardFileList() != null){
			for(BoardFile data : boardFile.getBoardFileList()){
				UploadNoticeFile(data);
			}
		}
		sfaDAO.insert_board_content(boardContent);
		noticeContent.setBoard_content_seq(boardContent.getBoard_content_seq());
		sfaDAO.insert_notice_content(noticeContent);
		
		
		if(boardFile.getBoardFileList() != null){			
			for(BoardFile data : boardFile.getBoardFileList()){
				data.setBoard_content_seq(boardContent.getBoard_content_seq());
				data.setBoard_ins_id((String)auth.getPrincipal());
				data.setBoard_udt_id((String)auth.getPrincipal());
				sfaDAO.insert_board_file(data);			
			}
		}
		
		logger.info("FAP 관리자 공지사항 등록 DAO 종료");
	}
	
	/**
	 * @Method Name :  fap_open_job_info_content_list
	 * @Date : 2019. 6. 28.
	 * @User : 김경아
	 * @Param :  게시판 시퀀스, RowBounds : 페이징
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 취업정보 & 전략 게시판 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> fap_open_job_info_content_list(HashMap<String, Object> map){ 
		logger.info("오픈잡페어 취업정보 & 전략 게시판 리스트 조회 서비스 시작");		
		int pageBegin = (int)map.get("pageBegin");
		int pageScale = (int)map.get("pageCount");
		
		RowBounds rb = new RowBounds(pageBegin,pageScale);
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		result = sfaDAO.fap_open_job_info_content_list(map, rb); 
		logger.info("오픈잡페어 취업정보 & 전략 게시판 리스트 조회 서비스 종료");		
		return result;
	}

	 
	
	
	/**
	 * @Method Name :  fap_open_job_info_additional_detail
	 * @Date : 2019. 6. 26.
	 * @User : 김경아
	 * @Param : 게시판 글 시퀀스 
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 취업정보 & 전략 게시판 글 상세조회 추가항목
	 */
	public HashMap<String, Object> fap_open_job_info_additional_detail(HashMap<String,Object> paramMap){
		logger.info("오픈잡페어 취업정보 & 전략 게시판 글 상세조회 추가항목 서비스 시작");		
		HashMap<String, Object> result = new HashMap<String,Object>();		
		result = sfaDAO.fap_open_job_info_content_additional_detail(paramMap);
		logger.info("오픈잡페어 취업정보 & 전략 게시판 글 상세조회 추가항목 서비스 종료");
		return result;
	}
		
	/**
	 * @Method Name :  fap_open_insert_job_info
	 * @Date : 2019. 6. 26.
	 * @User : 김경아
	 * @Param : 인증정보, 공통게시판 정보, FAP 오픈잡페어 취업정보 & 전략게시판 정보, 파일정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어  게시판 글 등록 
	 */
	@Transactional
	public int fap_open_insert_additional_info(Authentication auth, BoardContent boardContent, 
			 SocietyFapOpenJobInfo openJobInfo, SocietyFapAdminNoticeContent noticeContent, BoardFile boardFile, String board_detail_gb){
		logger.info("FAP 오픈잡페어 게시판 등록 서비스 시작");
		
		if(boardFile.getBoardFileList()!=null){
			for(BoardFile data : boardFile.getBoardFileList()){			 
				if(data.getBoard_file() != null){
					data.setBoard_file_origin(data.getBoard_file().getOriginalFilename());
					data.setBoard_file_saved(FileService.saveFile(data.getBoard_file(), fapAdminNoticeFile));
					}		 
				}
			}
		
		//공통게시판 정보 추가 
		int result = sfaDAO.insert_board_content(boardContent);
		
		 
		//게시판마다 추가정보  
		if(board_detail_gb.equals("A1700")){ //공지사항 게시판 
			noticeContent.setBoard_content_seq(boardContent.getBoard_content_seq());
			sfaDAO.fap_open_insert_notice_content(noticeContent);		
		}
		if(board_detail_gb.equals("A1706")){ //미국인턴십 게시판
			noticeContent.setBoard_content_seq(boardContent.getBoard_content_seq());
			sfaDAO.fap_insert_internship_content(noticeContent);
		}
		if(board_detail_gb.equals("A1701")){ //취업정보 & 전략 게시판  
			openJobInfo.setBoard_content_seq(boardContent.getBoard_content_seq());
			sfaDAO.fap_open_insert_job_info_content(openJobInfo);
		}
		
		
		//파일 추가 
		if(boardFile.getBoardFileList()!=null){
			for(BoardFile file : boardFile.getBoardFileList()){
				file.setBoard_content_seq(boardContent.getBoard_content_seq());
				file.setBoard_ins_id((String)auth.getPrincipal());
				file.setBoard_udt_id((String)auth.getPrincipal());
				sfaDAO.insert_board_file(file);
			}
		}	
		logger.info("FAP 오픈잡페어 게시판 등록 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name :  fap_open_update_job_info
	 * @Date : 2019. 6. 27.
	 * @User : 김경아
	 * @Param : 인증정보, 공통게시판 정보, FAP 오픈잡페어 취업정보 & 전략게시판 정보, 파일정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 취업정보 & 전략 게시판 글 수정 
	 */
	@Transactional
	public int fap_open_update_job_info(Authentication auth, BoardContent boardContent, 
			 SocietyFapOpenJobInfo openJobInfo, SocietyFapAdminNoticeContent noticeContent, BoardFile boardFile, String board_detail_gb){
		logger.info("FAP 오픈잡페어 취업정보 & 전략게시판 수정 서비스 시작");

    //파일 저장 
		if(boardFile.getBoardFileList() != null){
			for(BoardFile file : boardFile.getBoardFileList()){
				if(file.getBoard_file() != null && !file.getBoard_file().isEmpty()){
					if(file.getBoard_file_origin() != null && file.getBoard_file_saved() != null){
					 
						FileService.deleteFile(file.getBoard_file_saved(), fapAdminNoticeFile);  
					}
					 
						String fileOrigin = file.getBoard_file().getOriginalFilename();
						String fileSaved = FileService.saveFile(file.getBoard_file(), fapAdminNoticeFile);
						file.setBoard_file_origin(fileOrigin);
						file.setBoard_file_saved(fileSaved);
						file.setBoard_content_seq(boardContent.getBoard_content_seq());
						file.setBoard_ins_id((String)auth.getPrincipal());
						file.setBoard_udt_id((String)auth.getPrincipal());
						 System.out.println("boardFileAfter:"+boardFile);			
						//새로 추가된 파일 
						if(file.getBoard_file_seq() ==0){
							System.out.println(file);
							sfaDAO.insert_board_file(file);
					}
				}
			}
		}
		//게시판 공통정보 수정
		int result = sfaDAO.update_board_content(boardContent);
		
		// 추가정보 수정
		if(board_detail_gb.equals("A1700")){ //공지사항 게시판 
			 noticeContent.setBoard_content_seq(boardContent.getBoard_content_seq());
			 sfaDAO.fap_open_update_notice_content(noticeContent);	
		}
		if(board_detail_gb.equals("A1706")){ //미국인턴십 게시판 
			 noticeContent.setBoard_content_seq(boardContent.getBoard_content_seq());
			 sfaDAO.fap_update_internship_content(noticeContent);	
		}
		if(board_detail_gb.equals("A1701")){ //취업정보 & 전략 게시판  
			openJobInfo.setBoard_content_seq(boardContent.getBoard_content_seq());
			 sfaDAO.fap_open_update_job_info_content(openJobInfo);			
		}
		 
		logger.info("FAP 오픈잡페어 취업정보 & 전략게시판 수정 서비스 종료");
		return result;
	}
	

	/**
	 * @Method Name :  fap_open_delete_job_info
	 * @Date : 2019. 6. 27.
	 * @User : 김경아
	 * @Param : 게시판 글 시퀀스
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 취업정보 & 전략 게시판 글 삭제
	 */
	 public int fap_open_delete_job_info_content(int board_content_seq){
		 logger.info("FAP 오픈잡페어 취업정보 & 전략게시판 삭제 서비스 시작");
		 int result = sfaDAO.fap_open_delete_job_info_content(board_content_seq);
		 logger.info("FAP 오픈잡페어 취업정보 & 전략게시판 삭제 서비스 시작");
		 return result;
		}
	 

	/**
	 * @Method Name : delete_notice
	 * @Date : 2019. 2. 20.
	 * @User : 김준영
	 * @Param : 게시판 seq
	 * @Return : 삭제 여부
	 * @Method 설명 : 공지사항을 삭제하는 함수
	 */
	public int delete_notice(int board_content_seq){
		logger.info("FAP 공지사항 삭제 서비스 시작");
		int result = sfaDAO.delete_notice(board_content_seq);
		logger.info("FAP 공지사항 삭제 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : search_jobfair_attended_comp_list
	 * @Date : 2019. 2. 21.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 잡페어 참가 기업 리스트
	 * @Method 설명 : 잡페어 참가 기업 리스트를 검색하는 함수
	 */
	public ArrayList<HashMap<String, Object>> search_jobfair_attended_comp_list(){
		logger.info("FAP 잡페어 참가 기업 리스트를 검색 SERVICE 시작");
		ArrayList<HashMap<String, Object>> resultList = sfaDAO.search_jobfair_attended_comp_list();
		logger.info("FAP 잡페어 참가 기업 리스트를 검색 SERVICE 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : searched_jobfair_attended_comp_list
	 * @Date : 2019. 2. 21.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 잡페어별 참가 기업 리스트
	 * @Method 설명 : 잡페어별 참가 기업 리스트를 검색하는 함수
	 */
	public ArrayList<HashMap<String, Object>> searched_jobfair_attended_comp_list(HashMap<String, Object> hashmap){
		logger.info("FAP 잡페어별 참가 기업 리스트를 검색 SERVICE 시작");
		ArrayList<HashMap<String, Object>> resultList = sfaDAO.searched_jobfair_attended_comp_list(hashmap);
		logger.info("FAP 잡페어별 참가 기업 리스트를 검색 SERVICE 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : select_refusal_ag_comp_connect_list
	 * @Date : 2019. 2. 20.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 거절한 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트
	 * @Method 설명 : 거절한 에이전시 - 기업이 연결 되어있는 에이전시와 기업의 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_refusal_ag_comp_connect_list(int start, int countPerPage){
		logger.info("FAP 거절한 에이전시 - 기업 연결 리스트 가져오기 서비스 시작");
		
		ArrayList<HashMap<String, Object>> select_refusal_ag_comp_connect_list = sfaDAO.select_refusal_ag_comp_connect_list(start, countPerPage);
		
		logger.info("FAP 거절한 에이전시 - 기업 연결 리스트 가져오기 서비스 종료");
		return select_refusal_ag_comp_connect_list;
	}
	
	/**
	 * @Method Name : select_refusal_ag_comp_connect_list_paging_count
	 * @Date : 2019. 2. 20.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 거절한 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수
	 * @Method 설명 : 거절한 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수를 불러오는 함수
	 */
	public int select_refusal_ag_comp_connect_list_paging_count(){
		logger.info("거절한 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수 가져오기 서비스 시작");
		int refusalTotalCount = sfaDAO.select_refusal_ag_comp_connect_list_paging_count();
		logger.info("거절한 에이전시, 기업, 에이전시 - 기업 연결 객체 리스트 총 개수 가져오기 서비스 종료");
		return refusalTotalCount;
	}
	
	/**
	 * @Method Name : select_standby_comp_user_connect
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 대기중인 담당자 - 기업 연결 리스트
	 * @Method 설명 : 대기중인 담당자 - 기업 연결 리스트의 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_standby_comp_user_connect(int start, int countPerPage){
		logger.info("FAP 대기중인 담당자 - 기업 연결 리스트 가져오기 서비스 시작");
		
		ArrayList<HashMap<String, Object>> select_standby_comp_user_connect = sfaDAO.select_standby_comp_user_connect(start, countPerPage);
		
		logger.info("FAP 대기중인 담당자 - 기업 연결 리스트 가져오기 서비스 종료");
		return select_standby_comp_user_connect;
	}
	
	/**
	 * @Method Name : select_standby_comp_user_connect_list_paging_count
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 대기중인 담당자 - 기업 연결 리스트 총 개수
	 * @Method 설명 : 대기중인 담당자 - 기업 연결 리스트 총 개수를 불러오는 함수
	 */
	public int select_standby_comp_user_connect_list_paging_count(){
		logger.info("대기중인 담당자 - 기업 연결 리스트 총 개수 가져오기 서비스 시작");
		int userStandbyTotalCount = sfaDAO.select_standby_comp_user_connect_list_paging_count();
		logger.info("대기중인 담당자 - 기업 연결 리스트 총 개수 가져오기 서비스 종료");
		return userStandbyTotalCount;
	}
	
	/**
	 * @Method Name : select_approval_comp_user_connect
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 승인한 담당자 - 기업 연결 리스트
	 * @Method 설명 : 승인한 담당자 - 기업 연결 리스트의 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_approval_comp_user_connect(int start, int countPerPage){
		logger.info("FAP 승인한 담당자 - 기업 연결 리스트 가져오기 서비스 시작");
		
		ArrayList<HashMap<String, Object>> select_approval_comp_user_connect = sfaDAO.select_approval_comp_user_connect(start, countPerPage);
		
		logger.info("FAP 승인한 담당자 - 기업 연결 리스트 가져오기 서비스 종료");
		return select_approval_comp_user_connect;
	}
	
	/**
	 * @Method Name : select_approval_comp_user_connect_list_paging_count
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 승인한 담당자 - 기업 연결 리스트 총 개수
	 * @Method 설명 : 승인한 담당자 - 기업 연결 리스트 총 개수를 불러오는 함수
	 */
	public int select_approval_comp_user_connect_list_paging_count(){
		logger.info("승인한 담당자 - 기업 연결 리스트 총 개수 가져오기 서비스 시작");
		int userApprovalTotalCount = sfaDAO.select_approval_comp_user_connect_list_paging_count();
		logger.info("승인한 담당자 - 기업 연결 리스트 총 개수 가져오기 서비스 종료");
		return userApprovalTotalCount;
	}
	
	/**
	 * @Method Name : select_refusal_comp_user_connect
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 거절한 담당자 - 기업 연결 리스트
	 * @Method 설명 : 거절한 담당자 - 기업 연결 리스트의 정보를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_refusal_comp_user_connect(int start, int countPerPage){
		logger.info("FAP 거절한 담당자 - 기업 연결 리스트 가져오기 서비스 시작");
		
		ArrayList<HashMap<String, Object>> select_refusal_comp_user_connect = sfaDAO.select_refusal_comp_user_connect(start, countPerPage);
		
		logger.info("FAP 거절한 담당자 - 기업 연결 리스트 가져오기 서비스 종료");
		return select_refusal_comp_user_connect;
	}
	
	/**
	 * @Method Name : select_refusal_comp_user_connect_list_paging_count
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 거절한 담당자 - 기업 연결 리스트 총 개수
	 * @Method 설명 : 거절한 담당자 - 기업 연결 리스트 총 개수를 불러오는 함수
	 */
	public int select_refusal_comp_user_connect_list_paging_count(){
		logger.info("거절한 담당자 - 기업 연결 리스트 총 개수 가져오기 서비스 시작");
		int userRefusalTotalCount = sfaDAO.select_refusal_comp_user_connect_list_paging_count();
		logger.info("거절한 담당자 - 기업 연결 리스트 총 개수 가져오기 서비스 종료");
		return userRefusalTotalCount;
	}
	
	/**
	 * @Method Name : select_uncertain_company_paging_count
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 연결 객체가 없어 불명확한 기업 리스트 개수
	 * @Method 설명 : 연결 객체가 없어 불명확한 기업 리스트 개수
	 */
	public int select_uncertain_company_paging_count(){
		logger.info("연결 객체가 없어 불명확한 기업 리스트 개수 가져오기 서비스 시작");
		int uncertainTotalCount = sfaDAO.select_uncertain_company_paging_count();
		logger.info("연결 객체가 없어 불명확한 기업 리스트 개수 가져오기 서비스 종료");
		return uncertainTotalCount;
	}
	
	/**
	 * @Method Name : select_connect_request_paging_count
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 담당자 연결 요청 개수
	 * @Method 설명 : 담당자 연결 요청 개수를 불러오는 함수
	 */
	public int select_connect_request_paging_count(){
		logger.info("담당자 연결 요청 개수 가져오기 서비스 시작");
		int requestTotalCount = sfaDAO.select_connect_request_paging_count();
		logger.info("담당자 연결 요청 개수 가져오기 서비스 종료");
		return requestTotalCount;
	}
	
	/**
	 * @Method Name : select_unconnect_company_list
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 유저(기업) 객체 리스트
	 * @Method 설명 : 기업과 연결 되지 않은 유저(기업) 객체 리스트를 가져오는 함수
	 */
	public ArrayList<User> select_unconnect_company_list(int start, int countPerPage){
		logger.info("FAP 기업과 연결 되지 않은 유저(기업) 가져오기 서비스 시작");
		ArrayList<User> company_user = sfaDAO.select_unconnect_company_list(start, countPerPage);
		logger.info("FAP 기업과 연결 되지 않은 유저(기업) 가져오기 서비스 종료");
		return company_user;
	}
	
	/**
	 * @Method Name : select_unconnect_company_list_paging_count
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 유저(기업) 수
	 * @Method 설명 : 유저(기업) 수를 불러오는 함수
	 */
	public int select_unconnect_company_list_paging_count(){
		logger.info("유저(기업)수 가져오기 서비스 시작");
		int companyUserTotalCount = sfaDAO.select_unconnect_company_list_paging_count();
		logger.info("유저(기업)수 가져오기 서비스 종료");
		return companyUserTotalCount;
	}
	
	/**
	 * @Method Name : select_unconnect_agency_list
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 유저(에이전시) 객체 리스트
	 * @Method 설명 : 기업과 연결 되지 않은 유저(에이전시) 객체 리스트를 가져오는 함수
	 */
	public ArrayList<User> select_unconnect_agency_list(int start, int countPerPage){
		logger.info("FAP 기업과 연결 되지 않은 유저(에이전시) 가져오기 서비스 시작");
		ArrayList<User> agency_user = sfaDAO.select_unconnect_agency_list(start, countPerPage);
		logger.info("FAP 기업과 연결 되지 않은 유저(에이전시) 가져오기 서비스 종료");
		return agency_user;
	}
	
	/**
	 * @Method Name : select_unconnect_agency_list_paging_count
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 유저(에이전시)수
	 * @Method 설명 : 유저(에이전시)수를 불러오는 함수
	 */
	public int select_unconnect_agency_list_paging_count(){
		logger.info("유저(에이전시) 수 가져오기 서비스 시작");
		int agencyUserTotalCount = sfaDAO.select_unconnect_agency_list_paging_count();
		logger.info("유저(에이전시) 수 가져오기 서비스 종료");
		return agencyUserTotalCount;
	}
	
	/**
	 * @Method Name : select_connect_company_list
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 연결 할 기업 리스트
	 * @Method 설명 : 담당자와 연결할 기업 리스트를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_connect_company_list(int start, int countPerPage){
		logger.info("FAP 담당자와 연결 할 기업 리스트 가져오기 서비스 시작");
		
		ArrayList<HashMap<String, Object>> company_list = sfaDAO.select_connect_company_list(start, countPerPage);
		
		logger.info("FAP 담당자와 연결 할 기업 리스트 가져오기 서비스 종료");
		return company_list;
	}
	
	/**
	 * @Method Name : select_connect_company_list_paging_count
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 연결 할 기업 리스트 개수
	 * @Method 설명 : 연결 할 기업 리스트 개수를 불러오는 함수
	 */
	public int select_connect_company_list_paging_count(){
		logger.info("연결 할 기업 리스트 개수 가져오기 서비스 시작");
		int connectCompanyTotalCount = sfaDAO.select_connect_company_list_paging_count();
		logger.info("연결 할 기업 리스트 개수 가져오기 서비스 종료");
		return connectCompanyTotalCount;
	}
	
	/**
	 * @Method Name : select_connect_agency_list
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 연결 할 에이전시 리스트
	 * @Method 설명 : 담당자와 연결할 에이전시 리스트를 가져오는 함수
	 */
	public ArrayList<HashMap<String, Object>> select_connect_agency_list(int start, int countPerPage){
		logger.info("FAP 담당자와 연결 할 에이전시 리스트 가져오기 서비스 시작");
		
		ArrayList<HashMap<String, Object>> agency_list = sfaDAO.select_connect_agency_list(start, countPerPage);
		
		logger.info("FAP 담당자와 연결 할 에이전시 리스트 가져오기 서비스 종료");
		return agency_list;
	}
	
	/**
	 * @Method Name : select_connect_agency_list_paging_count
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 연결 할 에이전시 리스트 개수
	 * @Method 설명 : 연결 할 에이전시 리스트 개수를 불러오는 함수
	 */
	public int select_connect_agency_list_paging_count(){
		logger.info("연결 할 에이전시 리스트 개수 가져오기 서비스 시작");
		int connectAgencyTotalCount = sfaDAO.select_connect_agency_list_paging_count();
		logger.info("연결 할 에이전시 리스트 개수 가져오기 서비스 종료");
		return connectAgencyTotalCount;
	}
	
	/**
	 * @Method Name : select_jobfair_applicable_time
	 * @Date : 2019. 2. 21.
	 * @User : 원병호
	 * @Param : 잡페어 세부
	 * @Return : 
	 * @Method 설명 : 잡페어 지원가능 시간 정보 검색
	 */
	public HashMap<String, Object> select_jobfair_applicable_time(int fap_jobfair_divide_seq){
		logger.info("FAP 잡페어 지원가능 시간 정보 검색 Service 시작");
		HashMap<String, Object> result = new HashMap<String, Object>();
		//추가지원/미스매칭
		result.put("jobfair_applicable_time_list", sfaDAO.select_jobfair_applicable_time(fap_jobfair_divide_seq));

		//최초허가
		result.put("jobfair_applicable_time_list_first", sfaDAO.select_jobfair_applicable_time_first(fap_jobfair_divide_seq));
				
		logger.info("FAP 잡페어 지원가능 시간 정보 검색 Service 종료");
		return result;
	}
	
	/**
	 * @Method Name : search_user_apply_numbers
	 * @Date : 2019. 2. 25.
	 * @User : 신동철
	 * @Param : 잡페어 세부 시퀀스
	 * @Return : 잡페어별 취업지원자 지망개수
	 * @Method 설명 : 잡페어별 취업지원자 지망개수 검색
	 */
	public ArrayList<HashMap<String, Object>> search_user_apply_numbers(int fap_jobfair_divide_seq){
		logger.info("FAP 잡페어별 취업지원자 지망개수 검색 Service 시작");
		ArrayList<HashMap<String, Object>> resultList = sfaDAO.search_user_apply_numbers(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어별 취업지원자 지망개수 검색 Service 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : update_user_apply_numbers
	 * @Date : 2019. 2. 25.
	 * @User : 신동철
	 * @Param : 지원자 지망가능 갯수
	 * @Return : -
	 * @Method 설명 : 잡페어 지원자 지원가능 갯수 수정
	 */
	public void update_user_apply_numbers(Authentication auth, SocietyFapUserApplyNumbers userApplyNumbers){
		logger.debug("잡페어 지원자 지원가능 갯수 수정 Service 시작");
		
		ArrayList<HashMap<String, Object>> originNumbersList = sfaDAO.search_user_apply_numbers(userApplyNumbers.getFap_jobfair_divide_seq());
		ArrayList<SocietyFapUserApplyNumbers> newUserApplyNumbersList =  new ArrayList<>();
		
		//기존의 지망개수와 변경된 지망개수 비교
		for(int i=0; i<userApplyNumbers.getFap_user_apply_numbers_list().size(); i++){
			SocietyFapUserApplyNumbers newYserApplyNumbers =  new SocietyFapUserApplyNumbers();
			for(int j=0; j<originNumbersList.size(); j++){
				//지망개수 바뀐경우 수동으로 설정구분 변경
				if((long)originNumbersList.get(j).get("fap_user_apply_numbers_seq") == (long)userApplyNumbers.getFap_user_apply_numbers_list().get(i).getFap_user_apply_numbers_seq()){
					if((int)originNumbersList.get(j).get("fap_user_apply_numbers_fixed") != (int)userApplyNumbers.getFap_user_apply_numbers_list().get(i).getFap_user_apply_numbers_fixed()){
						userApplyNumbers.getFap_user_apply_numbers_list().get(i).setFap_user_apply_numbers_auto_gb("D0101");
					}
				}
			}
			newYserApplyNumbers.setFap_user_apply_numbers_seq(userApplyNumbers.getFap_user_apply_numbers_list().get(i).getFap_user_apply_numbers_seq());
			newYserApplyNumbers.setFap_user_apply_numbers_fixed(userApplyNumbers.getFap_user_apply_numbers_list().get(i).getFap_user_apply_numbers_fixed());
			newYserApplyNumbers.setFap_user_apply_numbers_auto_gb(userApplyNumbers.getFap_user_apply_numbers_list().get(i).getFap_user_apply_numbers_auto_gb());
			newYserApplyNumbers.setFap_user_apply_numbers_udt_id((String)auth.getPrincipal());
			newUserApplyNumbersList.add(newYserApplyNumbers);
		}
		
		sfaDAO.update_user_apply_numbers(newUserApplyNumbersList);
		
		logger.debug("잡페어 지원자 지원가능 갯수 수정 Service 종료");
	}


	/**
	 * @Method Name : insert_jobfair_applicable_time_one
	 * @Date : 2019. 2. 27.
	 * @User : 원병호
	 * @Param : 잡페어 추가지원 객체
	 * @Return : 
	 * @Method 설명 : 잡페어 추가지원/미스매칭 등록
	 */
	public void insert_jobfair_applicable_time_one(SocietyFapJobfairApplicableTime jobfairApplicableTime){
		logger.info("FAP 관리자 잡페어 추가지원/미스매칭 등록 Service 시작");
		sfaDAO.insert_jobfair_applicable_time_one(jobfairApplicableTime);
		logger.info("FAP 관리자 잡페어 추가지원/미스매칭 등록 Service 종료");
	}
	
	/**
	 * @Method Name : notice_udpate
	 * @Date : 2019. 3. 4.
	 * @User : 신동철
	 * @Param : 공지사항 내용, 부가내용
	 * @Return : -
	 * @Method 설명 : FAP 공지사항 내용, 부가내용 수정 함수
	 */
	public void notice_update(Authentication auth, BoardContent boardContent, SocietyFapAdminNoticeContent noticeContent, 
			BoardFile boardFile){
		logger.info("FAP 관리자 공지사항 수정 DAO 시작");
		
		//파일 저장
		if(boardFile.getBoardFileList() != null){
			for(BoardFile file : boardFile.getBoardFileList()){
				if(file.getBoard_file() != null && !file.getBoard_file().isEmpty()){
					if(file.getBoard_file_origin() != null && file.getBoard_file_saved() != null){
						FileService.deleteFile(file.getBoard_file_saved(), fapAdminNoticeFile);
					}
					String fileOrigin = file.getBoard_file().getOriginalFilename();
					String fileSaved = FileService.saveFile(file.getBoard_file(), fapAdminNoticeFile);
					file.setBoard_file_origin(fileOrigin);
					file.setBoard_file_saved(fileSaved);
					file.setBoard_content_seq(boardContent.getBoard_content_seq());
					file.setBoard_ins_id((String)auth.getPrincipal());
					file.setBoard_udt_id((String)auth.getPrincipal());
					
					//새로 추가된 파일
					if(file.getBoard_file_seq() == 0){
						System.out.println(file);
						sfaDAO.insert_board_file(file);
					}			
				}		
			}
		}
		sfaDAO.update_board_content(boardContent);
		sfaDAO.update_notice_content(noticeContent);
		
		logger.info("FAP 관리자 공지사항 수정 DAO 종료");
	}
	/**
	 * @Method Name : update_jobfair_applicable_time_one
	 * @Date : 2019. 3. 04.
	 * @User : 원병호
	 * @Param : 잡페어 추가지원 객체
	 * @Return : 
	 * @Method 설명 : 잡페어 추가지원/미스매칭 수정
	 */
	public void update_jobfair_applicable_time_one(SocietyFapJobfairApplicableTime jobfairApplicableTime){
		logger.info("FAP 관리자 잡페어 추가지원/미스매칭 수정 Service 시작");
		sfaDAO.update_jobfair_applicable_time_one(jobfairApplicableTime);
		logger.info("FAP 관리자 잡페어 추가지원/미스매칭 수정 Service 종료");
	}
	
	/**
	 * @Method Name : delete_jobfair_applicable_time
	 * @Date : 2019. 3. 4.
	 * @User : 원병호
	 * @Param : 잡페어 추가지원 일련번호
	 * @Return : 
	 * @Method 설명 : 잡페어 추가지원/미스매칭 정보 삭제
	 */
	@Transactional
	public void delete_jobfair_applicable_time(int fap_jobfair_applicable_time_seq, int fap_jobfair_divide_seq){
		logger.info("FAP 관리자 잡페어 추가지원 정보 삭제  Service 시작");
		//지원시간 관리 정보 삭제 
		sfaDAO.delete_jobfair_applicable_time(fap_jobfair_applicable_time_seq);
		//지원정보 삭제 
		sfaDAO.delete_jobfair_divide_seq_from_apply_info(fap_jobfair_divide_seq);
		logger.info("FAP 관리자 잡페어 추가지원 정보 삭제 Service 종료");
	}
	
	/**
	 * @Method Name : delete_board_file
	 * @Date : 2019. 3. 5.
	 * @User : 신동철
	 * @Param : 잡페어 공지사항 파일 시퀀스
	 * @Return : -
	 * @Method 설명 : 잡페어 공지사항 파일 삭제
	 */
	public void delete_board_file(int board_file_seq, String board_file_saved){
		logger.info("FAP 잡페어 공지사항 파일 삭제 Service 시작");
		FileService.deleteFile(board_file_saved, fapAdminNoticeFile);
		sfaDAO.delete_board_file(board_file_seq);
		logger.info("FAP 잡페어 공지사항 파일 삭제 Service 종료");
	}
	
	/**
	 * @Method Name : delete_board_file_list
	 * @Date : 2019. 3. 5.
	 * @User : 신동철
	 * @Param : 잡페어 공지사항 파일 리스트 시퀀스
	 * @Return : -
	 * @Method 설명 : 잡페어 공지사항 파일 리스트 삭제
	 */
	public void delete_board_file_list(ArrayList<Integer> board_file_seq_list, ArrayList<String> board_file_saved_list ){
		logger.info("FAP 잡페어 공지사항 파일 삭제 Service 시작");
		for(int i=0; i<board_file_seq_list.size(); i++){
			FileService.deleteFile(board_file_saved_list.get(i), fapAdminNoticeFile);
			sfaDAO.delete_board_file(board_file_seq_list.get(i));
		}
		
		logger.info("FAP 잡페어 공지사항 파일 삭제 Service 종료");
	}
	
	/**
	 * @Method Name : search_qna_comp
	 * @Date : 2019. 3. 6.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 채용공고 Q&A 기업명
	 * @Method 설명 : 채용공고 Q&A 기업명 검색
	 */
	public ArrayList<HashMap<String, Object>> search_qna_comp(){
		logger.info("FAP 잡페어 채용공고 Q&A 기업명 검색 Service 시작");
		ArrayList<HashMap<String, Object>> resultList = sfaDAO.search_qna_comp();
		logger.info("FAP 잡페어 채용공고 Q&A 기업명 검색 Service 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : search_qna_job_ad
	 * @Date : 2019. 3. 6.
	 * @User : 신동철
	 * @Param : 채용기업 아이디
	 * @Return : 채용공고 Q&A 채용공고
	 * @Method 설명 : 채용공고 Q&A 채용공고 검색
	 */
	public ArrayList<HashMap<String, Object>> search_qna_job_ad(String fap_comp_id){
		logger.info("FAP 잡페어 채용공고 Q&A 채용공고 검색 Service 시작");
		ArrayList<HashMap<String, Object>> resultList = sfaDAO.search_qna_job_ad(fap_comp_id);
		logger.info("FAP 잡페어 채용공고 Q&A 채용공고 검색 Service 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : search_job_qna_question_info
	 * @Date : 2019. 3. 6.
	 * @User : 신동철
	 * @Param : 채용기업 아이디, 채용공고 시퀀스, 질문승인여부, 작성자 이름
	 * @Return : 채용공고 Q&A 질문 정보
	 * @Method 설명 : 채용공고 Q&A 질문 정보 검색 
	 */
	public ArrayList<HashMap<String, Object>> search_job_qna_question_info(HashMap<String, Object> hashmap){
		logger.info("FAP 잡페어 채용공고 Q&A 질문 정보 검색 Service 시작");
		ArrayList<HashMap<String, Object>> resultList = sfaDAO.search_job_qna_question_info(hashmap);		
		logger.info("FAP 잡페어 채용공고 Q&A 질문 정보 검색 Service 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : jobfair_user_qna_permission
	 * @Date : 2019. 3. 7.
	 * @User : 신동철
	 * @Param : 질문 승인할 채용공고 Q&A질문일련번호
	 * @Return : -
	 * @Method 설명 : 채용공고 Q&A 질문 승인
	 */
	public void jobfair_user_qna_permission(List<Integer>fap_jobfair_user_qna_seq_list){
		logger.info("FAP 잡페어 채용공고 Q&A 질문 승인 DAO 시작");
		sfaDAO.jobfair_user_qna_permission(fap_jobfair_user_qna_seq_list);		
		logger.info("FAP 잡페어 채용공고 Q&A 질문 승인 DAO 종료");
	}
	
	/**
	 * @Method Name : jobfair_user_qna_nonpermission
	 * @Date : 2019. 3. 7.
	 * @User : 신동철
	 * @Param : 질문 미승인할 채용공고 Q&A질문일련번호
	 * @Return : -
	 * @Method 설명 : 채용공고 Q&A 질문 미승인
	 */
	public void jobfair_user_qna_nonpermission(List<Integer>fap_jobfair_user_qna_seq_list){
		logger.info("FAP 잡페어 채용공고 Q&A 질문 미승인 DAO 시작");
		sfaDAO.jobfair_user_qna_nonpermission(fap_jobfair_user_qna_seq_list);		
		logger.info("FAP 잡페어 채용공고 Q&A 질문 미승인 DAO 종료");
	}
	
	/**
	 * @Method Name : insert_qna_question_refuse_reason
	 * @Date : 2019. 3. 7.
	 * @User : 신동철
	 * @Param : Q&A질문일련번호, 미승인사유
	 * @Return : -
	 * @Method 설명 : 채용공고 Q&A 질문 미승인사유 등록
	 */
	public void insert_qna_question_refuse_reason(HashMap<String, Object> hashmap){
		logger.info("FAP 잡페어 채용공고 Q&A 질문 미승인사유 등록 Service 시작");
		sfaDAO.insert_qna_question_refuse_reason(hashmap);		
		logger.info("FAP 잡페어 채용공고 Q&A 질문 미승인사유 등록 Service 종료");
	}
	
	/**
	 * @Method Name : select_jobfair_divide_info
	 * @Date : 2019. 3. 12.
	 * @User : 신동철
	 * @Param : fap_jobfair_seq 담은 hashmap
	 * @Return : SocietyFapCompanyRoadmapJobfairDivide 객체
	 * @Method 설명 : fap_jobfair_seq로 잡페어 세부정보 가져오기
	 */
	public ArrayList<SocietyFapCompanyRoadmapJobfairDivide> select_jobfair_divide_info(HashMap<String, Object> params){
		logger.info("FAP 잡페어 세부정보 가져오기 Service 시작");
		ArrayList<SocietyFapCompanyRoadmapJobfairDivide> result = sfaDAO.select_jobfair_divide_info(params);
		logger.info("FAP 잡페어 세부정보 가져오기 Service 시작");
		return result;
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
		HashMap<String, Object> hashmap = sfaDAO.search_jobfair_divide_final_select_info(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 세부별 최종합격자 결정 시한 설정 정보 검색 Service 종료");
		return hashmap;
	}
	
	/**
	 * @Method Name : insert_fap_jobfair_divide_final_select
	 * @Date : 2019. 3. 14.
	 * @User : 신동철 
	 * @Param : 잡페어 세부 시퀀스, 최종합격 결정 시작일, 최종합격 결정 마감일
	 * @Return : -
	 * @Method 설명 : 잡페어 세부별 최종합격자 결정 시한 설정 등록
	 */
	public void insert_fap_jobfair_divide_final_select(HashMap<String, Object> hashmap){
		logger.info("FAP 잡페어 세부별 최종합격자 결정 시한 설정 등록 Service 시작");	
		sfaDAO.insert_fap_jobfair_divide_final_select(hashmap);
		logger.info("FAP 잡페어 세부별 최종합격자 결정 시한 설정 등록 Service 종료");
	}
	
	/**
	 * @Method Name : final_decision_time_duplicate_check
	 * @Date : 2019. 3. 25.
	 * @User : 이종호
	 * @Param : 최종확정 기간정보
	 * @Return : -
	 * @Method 설명 : 최종확정 기간 중복 조회
	 */
	public int final_decision_time_duplicate_check(SocietyFapAdminFinalDecisionTime finalDecision) {
		logger.info("FAP 잡페어 최종확정 기간 중복 조회 서비스 시작");
		int result = sfaDAO.final_decision_time_duplicate_check(finalDecision);
		logger.info("FAP 잡페어 최종확정 기간 중복 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : final_decision_time_insert
	 * @Date : 2019. 3. 21.
	 * @User : 이종호
	 * @Param : 최종확정 기간정보
	 * @Return : -
	 * @Method 설명 : 최종확정 기간 등록
	 */
	public void final_decision_time_insert(SocietyFapAdminFinalDecisionTime finalDecision) {
		logger.info("FAP 잡페어 최종확정 기간 등록 서비스 시작");
		sfaDAO.final_decision_time_insert(finalDecision);
		logger.info("FAP 잡페어 최종확정 기간 등록 서비스 종료");
	}
	
	/**
	 * @Method Name : final_decision_time_select
	 * @Date : 2019. 3. 21.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : -
	 * @Method 설명 : 세부 잡페어 별 최종확정 기간 조회
	 */
	public ArrayList<SocietyFapAdminFinalDecisionTime> final_decision_time_select(int fap_jobfair_divide_seq){
		logger.info("FAP 잡페어 최종확정 기간 조회 서비스 시작");
		ArrayList<SocietyFapAdminFinalDecisionTime> result = sfaDAO.final_decision_time_select(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 최종확정 기간 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : final_decision_time_delete
	 * @Date : 2019. 3. 25.
	 * @User : 이종호
	 * @Param : 최종확정 기간 시퀀스들
	 * @Return : -
	 * @Method 설명 : 세부 잡페어 별 최종확정 기간 삭제
	 */
	public void final_decision_time_delete(HashMap<String, Object> fap_jobfair_set_seq_map) {
		logger.info("FAP 잡페어 최종확정 기간 삭제 서비스 시작");
		sfaDAO.final_decision_time_delete(fap_jobfair_set_seq_map);
		logger.info("FAP 잡페어 최종확정 기간 삭제 서비스 종료");
	}
	
	/**
	 * @Method Name : final_decision_commit_op
	 * @Date : 2019. 5. 10.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 최종확정 알고리즘 적용(확정유예가능)
	 */
	@Transactional
	public void final_decision_commit_op(int fap_jobfair_divide_seq) {
		logger.info("FAP 최종확정 알고리즘 적용(확정유예가능) 서비스 시작");
		sfaDAO.final_decision_algorithm_step_one(fap_jobfair_divide_seq);
		sfaDAO.final_decision_algorithm_step_two(fap_jobfair_divide_seq);
		ArrayList<HashMap<String, Object>> list = sfaDAO.final_decision_algorithm_step_three(fap_jobfair_divide_seq);
		if(!(list == null || list.isEmpty())) {
			sfaDAO.final_decision_algorithm_step_four(list);
		}
		sfaDAO.final_decision_algorithm_step_five(fap_jobfair_divide_seq);
		sfaDAO.final_decision_algorithm_nominee_update(fap_jobfair_divide_seq);
		logger.info("FAP 최종확정 알고리즘 적용(확정유예가능) 서비스 종료");
	}
	
	/**
	 * @Method Name : final_decision_commit_ns
	 * @Date : 2019. 5. 15.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 최종확정 알고리즘 적용(확정필수)
	 */
	@Transactional
	public void final_decision_commit_ns(int fap_jobfair_divide_seq) {
		logger.info("FAP 최종확정 알고리즘 적용(확정필수) 서비스 시작");
		sfaDAO.final_decision_algorithm_step_one(fap_jobfair_divide_seq);
		sfaDAO.final_decision_algorithm_step_one_ns(fap_jobfair_divide_seq);
		sfaDAO.final_decision_algorithm_step_two(fap_jobfair_divide_seq);
		ArrayList<HashMap<String, Object>> list = sfaDAO.final_decision_algorithm_step_three(fap_jobfair_divide_seq);
		if(!(list == null || list.isEmpty())) {
			sfaDAO.final_decision_algorithm_step_four(list);
		}
		sfaDAO.final_decision_algorithm_step_five(fap_jobfair_divide_seq);
		sfaDAO.final_decision_algorithm_nominee_update(fap_jobfair_divide_seq);
		logger.info("FAP 최종확정 알고리즘 적용(확정필수) 서비스 종료");
	}
	
	/**
	 * @Method Name : final_decision_commit_last
	 * @Date : 2019. 5. 15.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 최종확정 알고리즘 적용(최종)
	 */
	@Transactional
	public void final_decision_commit_last(int fap_jobfair_divide_seq) {
		logger.info("FAP 최종확정 알고리즘 적용(최종) 서비스 시작");
		sfaDAO.final_decision_algorithm_step_one(fap_jobfair_divide_seq);
		sfaDAO.final_decision_algorithm_step_one_ns(fap_jobfair_divide_seq);
		sfaDAO.final_decision_algorithm_step_two(fap_jobfair_divide_seq);
		sfaDAO.final_decision_algorithm_step_final(fap_jobfair_divide_seq);
		sfaDAO.final_decision_algorithm_gb_update(fap_jobfair_divide_seq);
		sfaDAO.final_decision_algorithm_nominee_update(fap_jobfair_divide_seq);
		logger.info("FAP 최종확정 알고리즘 적용(최종) 서비스 종료");
	}
	
	/**
	 * @Method Name : final_decision_algorithm_pass_to_comp
	 * @Date : 2019. 5. 15.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 최종적용 이후 기업에 전달
	 */
	public void final_decision_algorithm_pass_to_comp(int fap_jobfair_divide_seq) {
		logger.info("FAP 잡페어 최종확정 알고리즘 최종적용 이후 기업에 전달 서비스 시작");
		sfaDAO.final_decision_algorithm_pass_to_comp(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 최종확정 알고리즘 최종적용 이후 기업에 전달 서비스 종료");
	}
	
	/**
	 * @Method Name : fap_ad_show_code_select
	 * @Date : 2019. 3. 22.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 채용공고 대상자 공통코드 맵
	 * @Method 설명 : 채용공고 대상자 설정을 위한 조회
	 */
	public ArrayList<HashMap<String, Object>> fap_ad_show_code_select(){
		logger.info("FAP 채용공고 대상자 공통코드 조회 서비스 시작");
		ArrayList<HashMap<String, Object>> result = sfaDAO.fap_ad_show_code_select();
		logger.info("FAP 채용공고 대상자 공통코드 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_ad_show_link_code_select
	 * @Date : 2019. 3. 22.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 채용공고 연결된 대상자 공통코드 맵
	 * @Method 설명 : 채용공고 연결된 대상자 설정을 위한 조회
	 */
	public ArrayList<SocietyFapJobAdShow> fap_ad_show_link_code_select(long fap_job_ad_seq){
		logger.info("FAP 채용공고 연결된 대상자 설정을 위한 조회 서비스 시작");
		ArrayList<SocietyFapJobAdShow> result = sfaDAO.fap_ad_show_link_code_select(fap_job_ad_seq);
		logger.info("FAP 채용공고 연결된 대상자 설정을 위한 조회 서비스 시작");
		
		return result;
	}
	
	/**
	 * @Method Name : fap_ad_show_link_code_delete
	 * @Date : 2019. 3. 22.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 채용공고 시퀀스
	 * @Method 설명 : 채용공고 연결된 대상자 설정을 위한 삭제
	 */
	public void fap_ad_show_link_code_delete(long fap_job_ad_seq) {
		logger.info("FAP 채용공고 연결된 대상자 설정을 위한 삭제 서비스 시작");
		sfaDAO.fap_ad_show_link_code_delete(fap_job_ad_seq);
		logger.info("FAP 채용공고 연결된 대상자 설정을 위한 삭제 서비스 시작");
	}
	
	/**
	 * @Method Name : fap_ad_show_link_code_insert
	 * @Date : 2019. 3. 22.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 채용공고 연결된 대상자 정보 리스트
	 * @Method 설명 : 채용공고 연결된 대상자 설정을 위한 등록
	 */
	public void fap_ad_show_link_code_insert(ArrayList<SocietyFapJobAdShow> show_list) {
		logger.info("FAP 채용공고 연결된 대상자 설정을 위한 등록 서비스 시작");
		sfaDAO.fap_ad_show_link_code_insert(show_list);
		logger.info("FAP 채용공고 연결된 대상자 설정을 위한 등록 서비스 시작");
	}
	
	/**
	 * @Method Name : fap_faq_select_list
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 파인애플 FAQ 리스트
	 * @Method 설명 : 파인애플 FAQ 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> fap_faq_select_list(){
		logger.info("FAP FAQ 리스트 조회 서비스 시작");
		ArrayList<HashMap<String, Object>> result = sfaDAO.fap_faq_select_list();
		logger.info("FAP FAQ 리스트 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_faq_select_list_gb
	 * @Date : 2019. 4. 10.
	 * @User : 이종호
	 * @Param : FAQ 구분값
	 * @Return : 파인애플 FAQ 리스트(구분된)
	 * @Method 설명 : 파인애플 FAQ 리스트(구분된) 조회
	 */
	public ArrayList<HashMap<String, Object>> fap_faq_select_list_gb(HashMap<String, Object> paramMap,int startRecord, int countPerPage){
		logger.info("FAP FAQ 리스트(구분된) 조회 DAO 시작");
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		
		ArrayList<HashMap<String, Object>> result = sfaDAO.fap_faq_select_list_gb(paramMap,rb);
		logger.info("FAP FAQ 리스트(구분된) 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_faq_select_list_gb_count
	 * @Date : 2019. 4. 10.
	 * @User : 이종호
	 * @Param : FAQ 구분값
	 * @Return : 파인애플 FAQ 리스트(구분된) 갯수
	 * @Method 설명 : 파인애플 FAQ 리스트(구분된) 갯수 조회
	 */
	public int fap_faq_select_list_gb_count(HashMap<String, Object> paramMap) {
		logger.info("FAP FAQ 리스트(구분된) 갯수 조회 DAO 시작");
		int result = sfaDAO.fap_faq_select_list_gb_count(paramMap);
		logger.info("FAP FAQ 리스트(구분된) 갯수 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_faq_insert_content
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : 파인애플 FAQ 정보
	 * @Return : -
	 * @Method 설명 : 파인애플 FAQ 등록
	 */
	@Transactional
	public void fap_faq_insert_content(FaqConsultingContents content,  SocietyFapAdminFaqGb faqGb) {
		logger.info("FAP FAQ 등록 서비스 시작");
		sfaDAO.fap_faq_insert_content(content);
		
		faqGb.setConsulting_seq(content.getConsulting_seq());
		sfaDAO.fap_faq_insert_gb(faqGb);
		
		logger.info("FAP FAQ 등록 서비스 종료");
	}
	
	/**
	 * @Method Name : fap_faq_select_list
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 파인애플 FAQ 단일정보
	 * @Method 설명 : 파인애플 FAQ 단일 조회
	 */
	public HashMap<String, Object> fap_faq_select_one(int consulting_seq){
		logger.info("FAP FAQ 단일 조회 서비스 시작");
		HashMap<String, Object> result = sfaDAO.fap_faq_select_one(consulting_seq);
		logger.info("FAP FAQ 단일 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_faq_update_content
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : 파인애플 FAQ 정보
	 * @Return : -
	 * @Method 설명 : 파인애플 FAQ 수정
	 */
	@Transactional
	public void fap_faq_update_content(FaqConsultingContents content,  SocietyFapAdminFaqGb faqGb) {
		logger.info("FAP FAQ 수정 서비스 시작");
		sfaDAO.fap_faq_update_content(content);
		
		sfaDAO.fap_faq_update_gb(faqGb);
		logger.info("FAP FAQ 수정 서비스 종료");
	}
	
	/**
	 * @Method Name : fap_faq_delete
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : 파인애플 FAQ 시퀀스
	 * @Return : -
	 * @Method 설명 : 파인애플 FAQ 삭제
	 */
	public void fap_faq_delete(int consulting_seq) {
		logger.info("FAP FAQ 삭제 서비스 시작");
		sfaDAO.fap_faq_delete(consulting_seq);
		logger.info("FAP FAQ 삭제 서비스 종료");
	}
	
	/**
	 * @Method Name : fap_open_pt_insert
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 정보 등록
	 */
	public void fap_open_pt_insert(SocietyFapOpenPt openPt) {
		logger.info("FAP 오픈잡페어 설명회 등록 서비스 시작");
		sfaDAO.fap_open_pt_insert(openPt);
		logger.info("FAP 오픈잡페어 설명회 등록 서비스 종료");
	}
	
	/**
	 * @Method Name : fap_open_pt_select_list
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 오픈잡페어 설명회 정보 리스트
	 * @Method 설명 : 오픈잡페어 설명회 정보 리스트 조회
	 */
	public ArrayList<SocietyFapOpenPt> fap_open_pt_select_list(){
		logger.info("FAP 오픈잡페어 설명회 정보 리스트 조회 서비스 시작");
		ArrayList<SocietyFapOpenPt> result = sfaDAO.fap_open_pt_select_list();
		logger.info("FAP 오픈잡페어 설명회 정보 리스트 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_pt_select_one
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 시퀀스
	 * @Return : 오픈잡페어 설명회 정보
	 * @Method 설명 : 오픈잡페어 설명회 정보 조회
	 */
	public SocietyFapOpenPt fap_open_pt_select_one(int fap_open_pt_seq) {
		logger.info("FAP 오픈잡페어 설명회 정보 조회 서비스 시작");
		SocietyFapOpenPt result = sfaDAO.fap_open_pt_select_one(fap_open_pt_seq);
		logger.info("FAP 오픈잡페어 설명회 정보 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_pt_update_gb
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 수정정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 구분 정보 수정
	 */
	@Transactional
	public void fap_open_pt_update_gb(SocietyFapOpenPt openPt) {
		logger.info("FAP 오픈잡페어 설명회 구분 정보 수정 서비스 시작");
		
		//노출로 변경일 경우
		if(openPt.getFap_open_pt_show_gb().equals("D1101")) {
			sfaDAO.fap_open_pt_update_show_gb(openPt);
		}
		
		sfaDAO.fap_open_pt_update_gb(openPt);
		logger.info("FAP 오픈잡페어 설명회 구분 정보 수정 서비스 종료");
	}
	
	/**
	 * @Method Name : fap_open_pt_update
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 수정정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 정보 수정
	 */
	public void fap_open_pt_update(SocietyFapOpenPt openPt) {
		logger.info("FAP 오픈잡페어 설명회 정보 수정 서비스 시작");
		sfaDAO.fap_open_pt_update(openPt);
		logger.info("FAP 오픈잡페어 설명회 정보 수정 서비스 종료");
	}
	
	/**
	 * @Method Name : fap_open_pt_delete
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 시퀀스
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 정보 삭제
	 */
	public void fap_open_pt_delete(int fap_open_pt_seq) {
		logger.info("FAP 오픈잡페어 설명회 정보 삭제 서비스 시작");
		sfaDAO.fap_open_pt_delete(fap_open_pt_seq);
		logger.info("FAP 오픈잡페어 설명회 정보 삭제 서비스 종료");
	}
	
	/**
	 * @Method Name : fap_open_pt_applier_list_count
	 * @Date : 2019. 4. 17.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 정보
	 * @Return : 오픈잡페어 설명회 총 지원자 수(검색 포함)
	 * @Method 설명 : 해당 설명회 총 지원자 수(검색 포함) 조회
	 */
	public int fap_open_pt_applier_list_count(HashMap<String, Object> paramMap) {
		logger.info("FAP 해당 설명회 총 지원자 수(검색 포함) 조회 서비스 시작");
		int result =  sfaDAO.fap_open_pt_applier_list_count(paramMap);
		logger.info("FAP 해당 설명회 총 지원자 수(검색 포함) 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_edu_applier_list_count
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 정보
	 * @Return : 오픈잡페어 구직자 교육 총 지원자 수(검색 포함)
	 * @Method 설명 : 해당 구직자 교육 총 지원자 수(검색 포함) 조회
	 */
	public int fap_open_edu_applier_list_count(HashMap<String, Object> paramMap) {
		logger.info("FAP 해당 구직자 교육 총 지원자 수(검색 포함) 서비스 DAO 시작");
		int result =  sfaDAO.fap_open_edu_applier_list_count(paramMap);
		logger.info("FAP 해당 구직자 교육 총 지원자 수(검색 포함) 서비스 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_pt_applier_list
	 * @Date : 2019. 4. 16.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 정보
	 * @Return : 해당 설명회 지원자 정보 리스트
	 * @Method 설명 : 해당 설명회 지원자 정보 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> fap_open_pt_applier_list(HashMap<String, Object> paramMap,int startRecord, int countPerPage){
		logger.info("FAP 해당 설명회 지원자 정보 리스트 조회 서비스 시작");
		
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		 ArrayList<HashMap<String, Object>> result =  sfaDAO.fap_open_pt_applier_list(paramMap,rb);
		logger.info("FAP 해당 설명회 지원자 정보 리스트 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_edu_applier_list
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 정보
	 * @Return : 해당 구직자 교육 지원자 정보 리스트
	 * @Method 설명 : 해당 구직자 교육 지원자 정보 리스트 조회
	 */
	public ArrayList<HashMap<String, Object>> fap_open_edu_applier_list(HashMap<String, Object> paramMap,int startRecord, int countPerPage){
		logger.info("FAP 해당 구직자 교육 지원자 정보 리스트 조회 서비스 시작");
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		 ArrayList<HashMap<String, Object>> result =  sfaDAO.fap_open_edu_applier_list(paramMap,rb);
		logger.info("FAP 해당 구직자 교육 지원자 정보 리스트 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_pt_applier_list_excel
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 지원자 시퀀스 정보
	 * @Return : 해당 설명회 지원자 정보 리스트
	 * @Method 설명 : 해당 설명회 지원자 정보 리스트 엑셀출력용 조회
	 */
	public ArrayList<LinkedHashMap<String, Object>> fap_open_pt_applier_list_excel(HashMap<String, Object> paramMap){
		logger.info("FAP 해당 설명회 지원자 정보 리스트 엑셀출력용 조회 서비스 시작");
		 ArrayList<LinkedHashMap<String, Object>> result =  sfaDAO.fap_open_pt_applier_list_excel(paramMap);
		logger.info("FAP 해당 설명회 지원자 정보 리스트 엑셀출력용 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_edu_applier_list_excel
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 지원자 시퀀스 정보
	 * @Return : 해당 구직자 교육 지원자 정보 리스트
	 * @Method 설명 : 해당 구직자 교육 지원자 정보 리스트 엑셀출력용 조회
	 */
	public ArrayList<LinkedHashMap<String, Object>> fap_open_edu_applier_list_excel(HashMap<String, Object> paramMap){
		logger.info("FAP 해당 구직자 교육 지원자 정보 리스트 엑셀출력용 조회 서비스 시작");
		 ArrayList<LinkedHashMap<String, Object>> result =  sfaDAO.fap_open_edu_applier_list_excel(paramMap);
		logger.info("FAP 해당 구직자 교육 지원자 정보 리스트 엑셀출력용 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_pt_only_list
	 * @Date : 2019. 4. 16.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 구분
	 * @Return : 해당 구분 설명회 정보 리스트
	 * @Method 설명 : 해당 구분 설명회 정보 리스트 조회
	 */
	public ArrayList<SocietyFapOpenPt> fap_open_pt_only_list(String fap_open_pt_gb){
		logger.info("FAP 해당 구분 설명회 정보 리스트 조회 서비스 시작");
		 ArrayList<SocietyFapOpenPt> result =  sfaDAO.fap_open_pt_only_list(fap_open_pt_gb);
		logger.info("FAP 해당 구분 설명회 정보 리스트 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_edu_applier_resume_update
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 지원자 이력서 정보
	 * @Return : -
	 * @Method 설명 : 해당 구분 구직자 교육 지원자 합/불 처리
	 */
	public void fap_open_edu_applier_resume_update(SocietyFapOpenPtResume openResume) {
		logger.info("FAP  해당 구분 구직자 교육 지원자 합/불 처리 서비스 시작");
		sfaDAO.fap_open_edu_applier_resume_update(openResume);
		logger.info("FAP  해당 구분 구직자 교육 지원자 합/불 처리 서비스 종료");
	}
	
	/**
	 * @Method Name : fap_open_edu_close_fail_update
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 정보
	 * @Return : -
	 * @Method 설명 : 해당 오픈잡페어 구직자 교육 마감처리 시 대기 지원자 불합격 처리
	 */
	public void fap_open_edu_close_fail_update(SocietyFapOpenPt openPt) {
		logger.info("FAP  해당 오픈잡페어 구직자 교육 마감처리 시 대기 지원자 불합격 처리 서비스 시작");
		sfaDAO.fap_open_edu_close_fail_update(openPt);
		logger.info("FAP  해당 오픈잡페어 구직자 교육 마감처리 시 대기 지원자 불합격 처리 서비스 종료");
	}
	
	/**
	 * @Method Name : fap_popup_insert
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : FAP 팝업 정보
	 * @Return : -
	 * @Method 설명 : FAP 팝업 정보 등록
	 */
	public void fap_popup_insert(SocietyFapPopup popup) {
		logger.info("FAP 팝업 정보 등록 서비스 시작");
		
		try {
			if(popup.getFap_popup_img() != null){
				popup.setFap_popup_img_origin(popup.getFap_popup_img().getOriginalFilename());
				popup.setFap_popup_img_saved(FileService.saveFile(popup.getFap_popup_img(), fapAdminPopupFile));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		sfaDAO.fap_popup_insert(popup);
		logger.info("FAP 팝업 정보 등록 서비스 종료");
	}
	
	/**
	 * @Method Name : fap_popup_select_list
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : -
	 * @Return : FAP 팝업 정보 리스트
	 * @Method 설명 : FAP 팝업 정보 리스트 조회
	 */
	public ArrayList<SocietyFapPopup> fap_popup_select_list(){
		logger.info("FAP 팝업 정보 리스트 조회 서비스 시작");
		ArrayList<SocietyFapPopup> result = sfaDAO.fap_popup_select_list();
		logger.info("FAP 팝업 정보 리스트 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_popup_select_one
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : -
	 * @Return : FAP 팝업 정보 단일
	 * @Method 설명 : FAP 팝업 정보 단일 조회
	 */
	public SocietyFapPopup fap_popup_select_one(int fap_popup_seq) {
		logger.info("FAP 팝업 정보 단일 조회 서비스 시작");
		SocietyFapPopup result = sfaDAO.fap_popup_select_one(fap_popup_seq);
		logger.info("FAP 팝업 정보 단일 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_popup_update
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : -
	 * @Return : FAP 팝업 정보
	 * @Method 설명 : FAP 팝업 정보 수정
	 */
	@Transactional
	public void fap_popup_update(SocietyFapPopup popup) {
		logger.info("FAP 팝업 정보 수정 서비스 시작");
		sfaDAO.fap_popup_delete(popup.getFap_popup_seq());
		
		try {
			if(popup.getFap_popup_img() != null){
				popup.setFap_popup_img_origin(popup.getFap_popup_img().getOriginalFilename());
				popup.setFap_popup_img_saved(FileService.saveFile(popup.getFap_popup_img(), fapAdminPopupFile));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		sfaDAO.fap_popup_insert(popup);
		logger.info("FAP 팝업 정보 수정 서비스 종료");
	}
	
	/**
	 * @Method Name : fap_popup_delete
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : -
	 * @Return : FAP 팝업 시퀀스
	 * @Method 설명 : FAP 팝업 정보 삭제
	 */
	public void fap_popup_delete(int fap_popup_seq) {
		logger.info("FAP 팝업 정보 삭제 서비스 시작");
		sfaDAO.fap_popup_delete(fap_popup_seq);
		logger.info("FAP 팝업 정보 삭제 서비스 시작");
	}
	
	/**
	 * @Method Name : fap_job_resume_update_gb
	 * @Date : 2019. 4. 30.
	 * @User : 이종호
	 * @Param : FAP 이력서 수정여부 구분
	 * @Return : -
	 * @Method 설명 : FAP 이력서 수정여부 구분 변경
	 */
	public void fap_job_resume_update_gb(String fap_job_resume_update_gb) {
		logger.info("FAP 이력서 수정여부 구분 변경 서비스 시작");
		sfaDAO.fap_job_resume_update_gb(fap_job_resume_update_gb);
		logger.info("FAP 이력서 수정여부 구분 변경 서비스 종료");
	}
	
	/**
	 * @Method Name : applicant_status_per_applier_search
	 * @Date : 2019. 5. 17.
	 * @User : 이종호
	 * @Param : 지원자별 지원현황 검색 조건
	 * @Return : 지원자별 지원 현황 리스트
	 * @Method 설명 : 지원자별 지원 현황 리스트 검색
	 */
	public ArrayList<LinkedHashMap<String, Object>> applicant_status_per_applier_search(HashMap<String, Object> search_map){
		logger.info("FAP 관리자 지원자별 지원 현황 리스트 검색 서비스 시작");
		ArrayList<LinkedHashMap<String, Object>> result = sfaDAO.applicant_status_per_applier_search(search_map);
		logger.info("FAP 관리자 지원자별 지원 현황 리스트 검색 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : applicant_status_per_comp_excel_one
	 * @Date : 2019. 6. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 기업별 지원현황 정보1
	 * @Method 설명 : 기업별 지원현황 엑셀 다운로드1
	 */
	@Transactional
	public HashMap<String, Object> applicant_status_per_comp_excel_one(int jobfair_seq){
		logger.info("FAP 관리자 기업별 지원 현황 정보1 검색 서비스 시작");
		HashMap<String, Object> map = new HashMap<>();
		ArrayList<LinkedHashMap<String, Object>> one = sfaDAO.applicant_status_per_comp_excel_one(jobfair_seq);
		ArrayList<LinkedHashMap<String, Object>> two = sfaDAO.applicant_status_per_comp_excel_two(jobfair_seq);
		ArrayList<LinkedHashMap<String, Object>> three = sfaDAO.applicant_status_per_comp_excel_three(jobfair_seq);
		ArrayList<LinkedHashMap<String, Object>> four = sfaDAO.applicant_status_per_comp_excel_four(jobfair_seq);
		ArrayList<LinkedHashMap<String, Object>> five = sfaDAO.applicant_status_per_comp_excel_five(jobfair_seq);
		ArrayList<LinkedHashMap<String, Object>> six = sfaDAO.applicant_status_per_comp_excel_six(jobfair_seq);
		ArrayList<LinkedHashMap<String, Object>> seven = sfaDAO.applicant_status_per_comp_excel_seven(jobfair_seq);
		ArrayList<LinkedHashMap<String, Object>> eight = sfaDAO.applicant_status_per_comp_excel_eight(jobfair_seq);
		ArrayList<LinkedHashMap<String, Object>> nine = sfaDAO.applicant_status_per_comp_excel_nine(jobfair_seq);
		ArrayList<LinkedHashMap<String, Object>> ten = sfaDAO.applicant_status_per_comp_excel_ten(jobfair_seq);
		ArrayList<LinkedHashMap<String, Object>> eleven = sfaDAO.applicant_status_per_comp_excel_eleven(jobfair_seq);
		ArrayList<LinkedHashMap<String, Object>> twelve = sfaDAO.applicant_status_per_comp_excel_twelve(jobfair_seq);
		ArrayList<LinkedHashMap<String, Object>> thirteen = sfaDAO.applicant_status_per_comp_excel_thirteen(jobfair_seq);
		ArrayList<LinkedHashMap<String, Object>> fourteen = sfaDAO.applicant_status_per_comp_excel_fourteen(jobfair_seq);
		ArrayList<LinkedHashMap<String, Object>> fifteen = sfaDAO.applicant_status_per_comp_excel_fifteen(jobfair_seq);
		ArrayList<LinkedHashMap<String, Object>> sixteen = sfaDAO.applicant_status_per_comp_excel_sixteen(jobfair_seq);
		map.put("one", one);
		map.put("two", two);
		map.put("three", three);
		map.put("four", four);
		map.put("five", five);
		map.put("six", six);
		map.put("seven", seven);
		map.put("eight", eight);
		map.put("nine", nine);
		map.put("ten", ten);
		map.put("eleven", eleven);
		map.put("twelve", twelve);
		map.put("thirteen", thirteen);
		map.put("fourteen", fourteen);
		map.put("fifteen", fifteen);
		map.put("sixteen", sixteen);
		
		logger.info("FAP 관리자 기업별 지원 현황 정보1 검색 서비스 종료");
		return map;
	}
	
	/**
	 * @Method Name : jobfair_apply_max_count
	 * @Date : 2019. 5. 20.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 지원자가 최대 지원한 갯수
	 * @Method 설명 : 잡페어별 지원자가 최대 지원한 갯수 검색
	 */
	public int jobfair_apply_max_count(HashMap<String, Object> params) {
		logger.info("FAP 관리자 잡페어별 지원자가 최대 지원한 갯수 검색 서비스 시작");
		int result = sfaDAO.jobfair_apply_max_count(params);
		logger.info("FAP 관리자 잡페어별 지원자가 최대 지원한 갯수 검색 서비스 종료");
		return result;
	}

	/**
	 * @Method Name : select_company_group_code_list
	 * @Date : 2019. 7. 25. 
	 * @User : 김경아
	 * @Param : HashMap
	 * @Return : HashMap
	 * @Method 설명 : FAP 관리자 잡페어별 그룹코드 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> admin_select_company_group_code_list(
			HashMap<String, Object> fapJobAdvertisement) {
		logger.info(" FAP 관리자 잡페어별 그룹코드 셀렉트 서비스 시작");
		ArrayList<HashMap<String, Object>> result = sfaDAO.admin_select_company_group_code_list(fapJobAdvertisement);
		logger.info(" FAP 관리자 잡페어별 그룹코드 셀렉트 서비스 종료");
		return result; 
	}

	/**
	 * @Method Name : search_job_advertisement_list
	 * @Date : 2019. 07. 25.
	 * @User : 김경아
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 채용공고 상세검색
	 */
	public ArrayList<HashMap<String, Object>> admin_search_job_advertisement_list(
			HashMap<String, Object> selectedCompanyInfoMap) {
		logger.info("FAP 채용공고 상세검색 서비스 시작");
		ArrayList<HashMap<String,Object>> result=sfaDAO.admin_search_job_advertisement_list(selectedCompanyInfoMap);
		logger.info("FAP 채용공고 상세검색 서비스 종료");
		return result;
	}

	
	/**
	 * @Method Name : board_contents_detail
	 * @Date : 2019. 7. 31.
	 * @User : 김경아
	 * @Param : 게시판 글 seq
	 * @Return : 게시판 세부 내용
	 * @Method 설명 : 게시판 세부 내용을 가져오는 함수
	 */
	public HashMap<String, Object> board_contents_detail(int board_content_seq){
		logger.info("FAP 게시판 세부내용 가져오기 서비스 시작");
		HashMap<String, Object> board_content = sfaDAO.board_contents_detail(board_content_seq);
		logger.info("FAP 게시판 세부내용 가져오기 서비스 시작");
		return board_content;
	}

	/**
	 * @Method Name : board_contents_hit_update
	 * @Date : 2019. 7. 31.
	 * @User : 김경아	
	 * @Param : 게시판 글 seq
	 * @Return : 
	 * @Method 설명 : 게시판 조회수를 추가하는 함수 
	 */
	public void board_contents_hit_update(int board_content_seq) {
		logger.info("게시글 세부 내용 중 조회수 증가 서비스 함수 시작");
		sfaDAO.board_contents_hit_update(board_content_seq);
		logger.info("게시글 세부 내용 중 조회수 증가 서비스 함수 종료");		
	}

	/**
	 * @Method Name : insert_admin_notice_info
	 * @Date : 2019. 8. 29.
	 * @User : 김경아
	 * @Param : 등록자 id, 잡페어 시퀀스 
	 * @Return : 
	 * @Method 설명 : FAP 잡페어 참가신청시 관리자 알림테이블에 해당 정보 추가 
	 */
	public int insert_admin_notice_info(HashMap<String, Object> map) {
		logger.info("FAP 잡페어 참가신청시 관리자 알림테이블에 정보 추가 서비스 시작");
		int result = sfaDAO.insert_admin_notice_info(map);
		logger.info("FAP 잡페어 참가신청시 관리자 알림테이블에 정보 추가 서비스 종료");
		return result;
	}	 

	/**
	 * @Method Name : select_admin_notice_alim_list
	 * @Date : 2019. 8. 30.
	 * @User : 김경아
	 * @Param :  
	 * @Return :   관리자 알림 list   
	 * @Method 설명 :   관리자 알림 list 출력 
	 */
	public HashMap<String,Object> select_admin_notice_alim_list(String selected_handle_gb, int pageCount, int currentPage) {
		logger.info("FAP 관리자 알림 list 출력 서비스 시작"); 
		 
		HashMap<String, Object> paramMap =new HashMap<>();
		paramMap.put("selected_handle_gb",selected_handle_gb);
		
		int total = sfaDAO.select_admin_notice_alim_list_count(selected_handle_gb);
		PageNavigator navi  = new PageNavigator(pageCount, 5, currentPage, total);
		ArrayList<HashMap<String,Object>> result =  sfaDAO.select_admin_notice_alim_list(paramMap, navi);		 
		
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("navi", navi);
		resultMap.put("result", result);
		logger.info("FAP 관리자 알림 list 출력 서비스 종료");
		return resultMap;
	}

	/**
	 * @Method Name : select_job_ad_title
	 * @Date : 2019. 9. 3.
	 * @User : 김경아	
	 * @Param : 채용공고 시퀀스 
	 * @Return : 채용공고명 
	 * @Method 설명 : FAP 채용공고명 조회
	 */
	public String select_job_ad_title(long fap_job_ad_seq) {
		logger.info("FAP 채용공고명 조회 서비스 시작");
		String result =  sfaDAO.select_job_ad_title(fap_job_ad_seq);		 
		logger.info("FAP 채용공고명 조회 서비스 종료");
		return result;
	}

	/**
	 * @Method Name : select_job_qna_question_title
	 * @Date : 2019. 9. 3.
	 * @User : 김경아	
	 * @Param : 질문글 시퀀스 
	 * @Return : 질문글 제목 
	 * @Method 설명 : FAP 질문글 조회 
	 */
	public String select_job_qna_question_title(long fap_job_qna_question_seq) {
		logger.info("FAP 질문글 조회  서비스 시작");
		String result =  sfaDAO.select_job_qna_question_title(fap_job_qna_question_seq);		 
		logger.info("FAP 질문글 조회  서비스 종료");
		return result;
	}


	
	
	

	/**
	 * @Method Name : mainpage_cct_select
	 * @Date : 2019. 9. 3.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 지원자 메인페이지 기업컨텐츠 관리 정보
	 * @Method 설명 : 설정된 지원자 메인페이지 기업컨텐츠 관리 정보를 조회
	 */
	public SocietyFapMainpageContent mainpage_ct_select() {
		logger.info("설정된 지원자 메인페이지 기업컨텐츠 관리 정보를 조회 서비스 시작");
		SocietyFapMainpageContent result = sfaDAO.mainpage_ct_select();
		logger.info("설정된 지원자 메인페이지 기업컨텐츠 관리 정보를 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : mainpage_ct_insert
	 * @Date : 2019. 9. 3.
	 * @User : 이종호
	 * @Param : 지원자 메인페이지 기업컨텐츠 관리 정보
	 * @Return : -
	 * @Method 설명 : 지원자 메인페이지 기업컨텐츠 관리 정보 등록
	 */
	public void mainpage_ct_insert(SocietyFapMainpageContent mainCt) {
		logger.info("지원자 메인페이지 기업컨텐츠 관리 정보 등록 DAO 시작");
		sfaDAO.mainpage_ct_insert(mainCt);
		logger.info("지원자 메인페이지 기업컨텐츠 관리 정보 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : mainpage_ct_update
	 * @Date : 2019. 9. 3.
	 * @User : 이종호
	 * @Param : 지원자 메인페이지 기업컨텐츠 관리 정보
	 * @Return : -
	 * @Method 설명 : 지원자 메인페이지 기업컨텐츠 관리 정보 수정
	 */
	public void mainpage_ct_update(SocietyFapMainpageContent mainCt) {
		logger.info("지원자 메인페이지 기업컨텐츠 관리 정보 수정 DAO 시작");
		sfaDAO.mainpage_ct_update(mainCt);
		logger.info("지원자 메인페이지 기업컨텐츠 관리 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : mainpage_ct_delete
	 * @Date : 2019. 9. 3.
	 * @User : 이종호
	 * @Param : 지원자 메인페이지 기업컨텐츠 관리 정보
	 * @Return : -
	 * @Method 설명 : 지원자 메인페이지 기업컨텐츠 관리 정보 삭제
	 */
	public void mainpage_ct_delete(int fap_mainpage_ct_seq) {
		logger.info("지원자 메인페이지 기업컨텐츠 관리 정보 삭제 DAO 시작");
		sfaDAO.mainpage_ct_delete(fap_mainpage_ct_seq);
		logger.info("지원자 메인페이지 기업컨텐츠 관리 정보 삭제 DAO 종료");
	}

	/**
	 * @Method Name : admin_notice_update_handle_fin_gb
	 * @Date : 2019. 9. 06.
	 * @User : 김경아
	 * @Param :  알림 seq, 알림처리여부 
	 * @Return :     
	 * @Method 설명 :   알림내용 처리상태 변경 
	 */
	public int admin_notice_update_handle_fin_gb(HashMap<String, Object> paramMap) {
		logger.debug("FAP 관리자 알림내용 처리상태 변경 서비스 시작");	
		int result = sfaDAO.admin_notice_update_handle_fin_gb(paramMap);
		logger.debug("FAP 관리자 알림내용 처리상태 변경 서비스 시작");
		return result;
	}

	/**
	 * @Method Name : admin_notice_update_handle_fin_gb_all_selected
	 * @Date : 2019. 9. 06.
	 * @User : 김경아
	 * @Param :  알림 seq, 알림처리여부 
	 * @Return :     
	 * @Method 설명 :   알림내용 처리상태 단체변경 
	 */
	public int admin_notice_update_handle_fin_gb_all_selected(HashMap<String, Object> paramMap) {	 
		logger.debug("FAP 관리자 알림내용 처리상태  단체변경 서비스 시작");	 

		ArrayList<SocietyFapAdminNoticeAlim> adminNoticeAlimList= new ArrayList<>();
		List<Integer> fap_admin_notice_seq_list = (List<Integer>) paramMap.get("fap_admin_notice_seq_list");
				 
		for (int i = 0; i < fap_admin_notice_seq_list.size(); i++) {
			int fap_admin_notice_seq= fap_admin_notice_seq_list.get(i);
			String admin_notice_handle_fin_gb = (String)paramMap.get("fap_admin_notice_handle_fin_gb");
			SocietyFapAdminNoticeAlim adminNoticeAlim = new SocietyFapAdminNoticeAlim();
			adminNoticeAlim.setFap_admin_notice_seq(fap_admin_notice_seq);
			adminNoticeAlim.setFap_admin_notice_handle_fin_gb(admin_notice_handle_fin_gb);
			adminNoticeAlimList.add(adminNoticeAlim);
		}
			
		int result = sfaDAO.admin_notice_update_handle_fin_gb_all_selected(adminNoticeAlimList);
		logger.debug("FAP 관리자 알림내용 처리상태  단체변경 서비스 시작");
		return result;
	}

	/**
	 * @Method Name : select_admin_notice_list_not_handled
	 * @Date : 2019. 9. 9.
	 * @User : 김경아
	 * @Param :   처리여부 
	 * @Return :     
	 * @Method 설명 :  처리되지 않은 항목 갯수 조회 
	 */
	public int select_admin_notice_list_not_handled() {
		 logger.debug("FAP 관리자 처리되지 않은 항목 갯수 조회 서비스 시작");
		 int result = sfaDAO.select_admin_notice_list_not_handled();
		 logger.debug("FAP 관리자 처리되지 않은 항목 갯수 조회 서비스 종료");
		return result;
	}

	/**
	 * @Method Name : delete_job_exam_file_uploaded
	 * @Date :2019. 09. 30
	 * @User : 김경아
	 * @Param : 파일정보
	 * @Return : 
	 * @Method 설명 :  채용전형 정보 첨부파일 삭제
	 */
	public int delete_exam_file(String fap_job_exam_file_saved) {
		logger.info("채용전형 정보 첨부파일 DB삭제 서비스 시작");
		int result = sfaDAO.delete_exam_file(fap_job_exam_file_saved);
		logger.info("채용전형 정보 첨부파일 DB삭제 서비스 종료");
		return result;
	}
 
	/**
	 * @Method Name : tokyofair_schedule_insert
	 * @Date : 2019. 9. 17.
	 * @User : 이종호
	 * @Param : 현지 잡페어 설정 정보
	 * @Return : -
	 * @Method 설명 : 현지 잡페어 설정 정보 등록 
	 */
	@Transactional
	public int tokyofair_schedule_insert(SocietyFapAdminJobfairSet fap_jobfair_set, String user_id) {
		logger.info("FAP 관리자 현지 잡페어 설정 정보 등록 서비스 시작");
		
		//설정등록
		fap_jobfair_set.setFap_jobfair_set_ins_id(user_id);
		fap_jobfair_set.setFap_jobfair_set_udt_id(user_id);
		int result = sfaDAO.tokyofair_schedule_set_insert(fap_jobfair_set);
		
		//날짜등록
		for(SocietyFapAdminJobfairSetDate fap_jobfair_set_date : fap_jobfair_set.getFap_jobfair_set_date_info_arr()) {
			fap_jobfair_set_date.setFap_jobfair_set_seq(fap_jobfair_set.getFap_jobfair_set_seq());
			fap_jobfair_set_date.setFap_jobfair_set_date_ins_id(user_id);
			fap_jobfair_set_date.setFap_jobfair_set_date_udt_id(user_id);
		}
		if(!fap_jobfair_set.getFap_jobfair_set_date_info_arr().isEmpty()) {
			sfaDAO.tokyofair_schedule_set_date_insert(fap_jobfair_set.getFap_jobfair_set_date_info_arr());
		}
		
		//일정등록
		for(SocietyFapAdminJobfairSetDate fap_jobfair_set_date : fap_jobfair_set.getFap_jobfair_set_date_info_arr()) {
			for(SocietyFapAdminJobfairSetTime fap_jobfair_set_time : fap_jobfair_set_date.getFap_jobfair_set_time_arr()) {
				fap_jobfair_set_time.setFap_jobfair_set_date_seq(fap_jobfair_set_date.getFap_jobfair_set_date_seq());
				fap_jobfair_set_time.setFap_jobfair_set_time_ins_id(user_id);
				fap_jobfair_set_time.setFap_jobfair_set_time_udt_id(user_id);
			}
			if(!fap_jobfair_set_date.getFap_jobfair_set_time_arr().isEmpty()) {
				sfaDAO.tokyofair_schedule_set_time_insert(fap_jobfair_set_date.getFap_jobfair_set_time_arr());
			}
		}
		
		logger.info("FAP 관리자 현지 잡페어 설정 정보 등록 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_update
	 * @Date : 2019. 9. 20.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 설정 정보 수정 
	 */
	@Transactional
	public int tokyofair_schedule_update(SocietyFapAdminJobfairSet fap_jobfair_set, String user_id) {
		logger.info("FAP 관리자 도쿄페어 설정 정보 수정 서비스 시작");
		//설정 수정
		fap_jobfair_set.setFap_jobfair_set_udt_id(user_id);
		int result = sfaDAO.tokyofair_schedule_set_update(fap_jobfair_set);
		
		//등록된 날짜 정보 삭제
		sfaDAO.tokyofair_schedule_set_date_delete(fap_jobfair_set.getFap_jobfair_set_seq());
		
		//날짜등록
		for(SocietyFapAdminJobfairSetDate fap_jobfair_set_date : fap_jobfair_set.getFap_jobfair_set_date_info_arr()) {
			fap_jobfair_set_date.setFap_jobfair_set_seq(fap_jobfair_set.getFap_jobfair_set_seq());
			fap_jobfair_set_date.setFap_jobfair_set_date_ins_id(user_id);
			fap_jobfair_set_date.setFap_jobfair_set_date_udt_id(user_id);
		}
		if(!fap_jobfair_set.getFap_jobfair_set_date_info_arr().isEmpty()) {
			sfaDAO.tokyofair_schedule_set_date_insert(fap_jobfair_set.getFap_jobfair_set_date_info_arr());
		}
		
		//일정등록
		for(SocietyFapAdminJobfairSetDate fap_jobfair_set_date : fap_jobfair_set.getFap_jobfair_set_date_info_arr()) {
			for(SocietyFapAdminJobfairSetTime fap_jobfair_set_time : fap_jobfair_set_date.getFap_jobfair_set_time_arr()) {
				fap_jobfair_set_time.setFap_jobfair_set_date_seq(fap_jobfair_set_date.getFap_jobfair_set_date_seq());
				fap_jobfair_set_time.setFap_jobfair_set_time_ins_id(user_id);
				fap_jobfair_set_time.setFap_jobfair_set_time_udt_id(user_id);
			}
			if(!fap_jobfair_set_date.getFap_jobfair_set_time_arr().isEmpty()) {
				sfaDAO.tokyofair_schedule_set_time_insert(fap_jobfair_set_date.getFap_jobfair_set_time_arr());
			}
		}
		logger.info("FAP 관리자 도쿄페어 설정 정보 수정 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_set_search_list
	 * @Date : 2019. 9. 19.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : 도쿄페어 설정 정보 리스트 
	 * @Method 설명 : 도쿄페어 설정 정보 리스트 조회
	 */
	public ArrayList<SocietyFapAdminJobfairSet> tokyofair_schedule_set_search_list(int fap_jobfair_divide_seq){
		logger.info("FAP 관리자 도쿄페어 설정 정보 리스트 조회 서비스 시작");
		ArrayList<SocietyFapAdminJobfairSet> result = sfaDAO.tokyofair_schedule_set_search_list(fap_jobfair_divide_seq);
		logger.info("FAP 관리자 도쿄페어 설정 정보 리스트 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_set_gb_update
	 * @Date : 2019. 9. 19.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 시퀀스, 도쿄페어 설정 사용여부 구분
	 * @Return : -
	 * @Method 설명 : 도쿄페어 설정 사용여부 구분 변경 
	 */
	@Transactional
	public void tokyofair_schedule_set_gb_update(int fap_jobfair_divide_seq,int fap_jobfair_set_seq, String fap_jobfair_set_gb,String user_id) {
		logger.info("FAP 관리자 도쿄페어 설정 사용여부 구분 변경 서비스 시작");
		HashMap<String, Object> params = new HashMap<>();
		
		if(fap_jobfair_set_gb.equals("E0001")) {
			params.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
			params.put("fap_jobfair_set_gb", fap_jobfair_set_gb);
			sfaDAO.tokyofair_schedule_set_gb_init(params);
		}
		
		fap_jobfair_set_gb = fap_jobfair_set_gb.equals("E0000") ? "E0001" : "E0000" ;
		params.put("fap_jobfair_set_seq", fap_jobfair_set_seq);
		params.put("fap_jobfair_set_gb", fap_jobfair_set_gb);
		params.put("user_id", user_id);
		
		sfaDAO.tokyofair_schedule_set_gb_update(params);
		logger.info("FAP 관리자 도쿄페어 설정 사용여부 구분 변경 서비스 종료");
	}
	
	/**
	 * @Method Name : tokyofair_schedule_set_delete
	 * @Date : 2019. 9. 19.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 설정 삭제 
	 */
	public void tokyofair_schedule_set_delete(int fap_jobfair_set_seq) {
		logger.info("FAP 관리자 도쿄페어 설정 삭제 서비스 시작");
		sfaDAO.tokyofair_schedule_set_delete(fap_jobfair_set_seq);
		logger.info("FAP 관리자 도쿄페어 설정 삭제 서비스 종료");
	}
	
	/**
	 * @Method Name : tokyofair_schedule_set_search
	 * @Date : 2019. 9. 19.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 시퀀스
	 * @Return : 도쿄페어 설정 정보
	 * @Method 설명 : 도쿄페어 설정 정보 조회
	 */
	@Transactional
	public HashMap<String, Object> tokyofair_schedule_set_search(int fap_jobfair_set_seq) {
		logger.info("FAP 관리자 도쿄페어 설정 정보 조회 서비스 시작");
		
		Gson gson = new Gson();
		
		HashMap<String, Object> result = new HashMap<>();
		
		SocietyFapAdminJobfairSet tokyofairSet = sfaDAO.tokyofair_schedule_set_search(fap_jobfair_set_seq);
		HashMap<String, Object> tokyofairDate = sfaDAO.tokyofair_schedule_set_date_search(fap_jobfair_set_seq);
		
		String date_json = gson.toJson(tokyofairDate);
		String replace_json = date_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		
		result.put("tokyofairSet", tokyofairSet);
		result.put("tokyofairDate", replace_json);
		
		logger.info("FAP 관리자 도쿄페어 설정 정보 조회 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_screening_search_bookable
	 * @Date : 2019. 10. 13.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : 채용공고 리스트
	 * @Method 설명 : 관리자 도쿄페어 설명회,시험 등록가능 조회
	 */
	public ArrayList<HashMap<String, Object>> tokyofair_screening_search_bookable(int fap_jobfair_divide_seq){
		logger.info("FAP 관리자 도쿄페어 설명회,시험 등록가능 조회 서비스 시작");
		ArrayList<HashMap<String, Object>> result = sfaDAO.tokyofair_screening_search_bookable(fap_jobfair_divide_seq);
		logger.info("FAP 관리자 도쿄페어 설명회,시험 등록가능 조회 서비스 종료");
		return result;
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
	public HashMap<String, Object> tokyfair_schedule_booked_search(int fap_jobfair_divide_seq) {
		logger.info("FAP 설정된 도쿄페어 설정 정보 조회 DAO 시작");
		
		Gson gson = new Gson();
		HashMap<String, Object> result = new HashMap<>();
		
		SocietyFapAdminJobfairSet tokyofairSet = sfcDAO.tokyofair_schedule_set_search(fap_jobfair_divide_seq);
		HashMap<String, Object> tokyofairDate = sfaDAO.tokyofair_schedule_set_date_search(tokyofairSet.getFap_jobfair_set_seq());
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("fap_jobfair_set_seq", tokyofairSet.getFap_jobfair_set_seq());
		params.put("fap_tokyofair_date_dt", tokyofairSet.getFap_jobfair_set_st());
		
		ArrayList<HashMap<String, Object>> tokyofairSch = sfaDAO.tokyfair_schedule_booked_search(params);
		
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
		ArrayList<HashMap<String, Object>> tokyofairSch = sfaDAO.tokyfair_schedule_booked_search(params);
		logger.info("FAP 도쿄페어 등록된 일정 정보 리스트 조회 DAO 종료");
		return tokyofairSch;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_admin_insert
	 * @Date : 2019. 10. 13.
	 * @User : 이종호
	 * @Param : 추가전형 정보
	 * @Return : 등록 여부
	 * @Method 설명 : 관리자 도쿄페어 추가전형 등록
	 */
	@Transactional(isolation=Isolation.SERIALIZABLE)
	public HashMap<String, Object> tokyofair_schedule_admin_insert(HashMap<String, Object> scheduleMap) {
		logger.info("FAP 관리자 도쿄페어 추가전형 등록 서비스 시작");
		HashMap<String, Object> result = new HashMap<>();
		boolean flag = false;
		//일정 중복 체크
		int schCheck = sfcDAO.tokyofair_schedule_info_check(scheduleMap);
		
		ArrayList<HashMap<String, Object>> duplicateList = new ArrayList<>();
		if(schCheck == 0) {
			flag = true;
			ArrayList<HashMap<String, Object>> resumeList = sfcDAO.tokyofair_screening_subject_search(Long.parseLong(scheduleMap.get("fap_job_ad_seq").toString()));
			//인원 중복 체크
			duplicateList = sfaDAO.tokyofair_schedule_member_duplicate_check(scheduleMap, resumeList);
			if(duplicateList.size() == 0) {
				//전형등록
				sfaDAO.tokyofair_screening_insert_admin(scheduleMap);
				//전형인원 등록
				for(HashMap<String, Object> map : resumeList) {
					map.put("fap_tokyofair_screening_seq", Integer.parseInt(scheduleMap.get("fap_tokyofair_screening_seq").toString()));
				}
				sfaDAO.tokyofair_scr_user_insert_admin(resumeList);
				
				//날짜 정보 확인
				int fap_tokyofair_date_seq = sfaDAO.tokyofair_schedule_date_check_admin(scheduleMap);
				if(fap_tokyofair_date_seq == 0) {
					//날짜 없을경우 등록
					sfaDAO.tokyofair_schedule_date_insert_admin(scheduleMap);
				} else {
					scheduleMap.put("fap_tokyofair_date_seq", fap_tokyofair_date_seq);
				}
				//날짜 등록된거 확인후 일정 등록
				sfaDAO.tokyofair_schedule_info_insert_admin(scheduleMap);
				long fap_tokyofair_schedule_seq = Long.parseLong(scheduleMap.get("fap_tokyofair_schedule_seq").toString());
				
				//일정 인원 등록
				for(HashMap<String, Object> map : resumeList) {
					map.put("fap_tokyofair_schedule_seq", fap_tokyofair_schedule_seq);
					map.put("fap_tokyofair_member_st", scheduleMap.get("fap_tokyofair_schedule_st").toString());
					map.put("fap_tokyofair_member_et", scheduleMap.get("fap_tokyofair_schedule_et").toString());
				}
				sfaDAO.tokyofair_member_insert_admin(resumeList);
			}
		}
		
		result.put("flag", flag);
		result.put("duplicateList", duplicateList);
		
		logger.info("FAP 관리자 도쿄페어 추가전형 등록 서비스 종료");
		return result;
	}
}
