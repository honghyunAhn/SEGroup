/**
 * 
 */
package global.segroup.society.fap.admincompany.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairApplyRule;
import global.segroup.society.fap.company.domain.SocietyFapJobAd;
import global.segroup.society.fap.company.domain.SocietyFapJobCategory;
import global.segroup.society.fap.company.domain.SocietyFapJobComp;
import global.segroup.society.fap.company.domain.SocietyFapJobDorm;
import global.segroup.society.fap.company.domain.SocietyFapJobExamType;
import global.segroup.society.fap.company.domain.SocietyFapJobFile;
import global.segroup.society.fap.company.domain.SocietyFapJobIsr;
import global.segroup.society.fap.company.domain.SocietyFapJobJaLevel;
import global.segroup.society.fap.company.domain.SocietyFapJobJitEmployee;
import global.segroup.society.fap.company.domain.SocietyFapJobJoinDt;
import global.segroup.society.fap.company.domain.SocietyFapJobPay;
import global.segroup.society.fap.company.domain.SocietyFapJobPayBase;
import global.segroup.society.fap.company.domain.SocietyFapJobPayEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobPref;
import global.segroup.society.fap.company.domain.SocietyFapJobRecruitPcs;
import global.segroup.society.fap.company.domain.SocietyFapJobServiceWork;
import global.segroup.society.fap.company.domain.SocietyFapJobTrial;
import global.segroup.society.fap.company.domain.SocietyFapJobWork;
import global.segroup.society.fap.company.domain.SocietyFapJobWorkplace;
import global.segroup.society.fap.company.domain.SocietyFapJobWorkplaceDtl;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 20.
 * @Class 설명 : Soft Engineer Society 통합잡페어 관리자(기업기능담당) DAO
 * 
 */
@Repository
public class SocietyFapAdminCompanyDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyFapAdminCompanyDAO.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	/**
	 * @Method Name : insert_job_ad
	 * @Date : 2018. 12. 24.
	 * @User : 이재준
	 * @Param : 채용공고 모든 정보 객체
	 * @Return : -
	 * @Method 설명 : 채용공고 모든 정보 객체 입력 
	 */
	
	public void insert_job_ad(SocietyFapJobAd JobAd, SocietyFapJobDorm JobDorm, SocietyFapJobJitEmployee JobJitEmployee,
			SocietyFapJobJaLevel JobJaLevel, SocietyFapJobTrial JobTrial, SocietyFapJobComp JobComp
			, SocietyFapJobFile JobFile, SocietyFapJobIsr JobIsr, SocietyFapJobJoinDt JobJoinDt, 
			SocietyFapJobWork JobWork, SocietyFapJobCategory JobCategory
			, SocietyFapJobPref JobPref, SocietyFapJobWorkplace JobWorkplace, SocietyFapJobRecruitPcs JobRecruitPcs
			, SocietyFapJobPay JobPay){
		logger.info("채용공고 기본 정보 등록 DAO 시작");
		
		String admin_id = JobAd.getFap_comp_id();
		
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);

		sfacMapper.insert_job_ad(JobAd);
		if(!JobDorm.getFap_job_dorm_lo().equals("")){
		JobDorm.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
		sfacMapper.insert_job_dorm(JobDorm);
		}
		if(!JobJitEmployee.getFap_job_jit_employee_dtl().equals("")){
		JobJitEmployee.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
		sfacMapper.insert_job_jit_employee(JobJitEmployee);
		}
		if(!JobJaLevel.getFap_job_ja_level_dtl().equals("")){
		JobJaLevel.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
		sfacMapper.insert_job_ja_level(JobJaLevel);
		}
		if(!JobTrial.getFap_job_trial_pay().equals("")){
		JobTrial.setFap_job_ad_seq(JobAd.getFap_job_ad_seq());	
		sfacMapper.insert_job_trial(JobTrial);
		}
		
		if(JobComp.getJobCompList().size() !=0){
			for (int i = 0; i < JobComp.getJobCompList().size(); i++) {
				JobComp.getJobCompList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobComp.getJobCompList().get(i).setFap_job_comp_ins_id(admin_id);
				JobComp.getJobCompList().get(i).setFap_job_comp_udt_id(admin_id);
			}
			sfacMapper.insert_job_comp(JobComp);
		}
		
		if(JobFile.getJobFileList().size() !=0){
			for (int i = 0; i < JobFile.getJobFileList().size(); i++) {
				JobFile.getJobFileList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobFile.getJobFileList().get(i).setFap_job_file_ins_id(admin_id);
				JobFile.getJobFileList().get(i).setFap_job_file_udt_id(admin_id);
			}
			sfacMapper.insert_job_file(JobFile);
		}
		
		if(JobIsr.getJobIsrList().size() !=0){
			for (int i = 0; i < JobIsr.getJobIsrList().size(); i++) {
				JobIsr.getJobIsrList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobIsr.getJobIsrList().get(i).setFap_job_isr_ins_id(admin_id);
				JobIsr.getJobIsrList().get(i).setFap_job_isr_udt_id(admin_id);
			}
			sfacMapper.insert_job_isr(JobIsr);
		}
		
		if(JobJoinDt.getJobJoinDtList().size() !=0){
			for (int i = 0; i < JobJoinDt.getJobJoinDtList().size(); i++) {
				JobJoinDt.getJobJoinDtList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobJoinDt.getJobJoinDtList().get(i).setFap_job_join_dt_ins_id(admin_id);
				JobJoinDt.getJobJoinDtList().get(i).setFap_job_join_dt_udt_id(admin_id);
			}
			sfacMapper.insert_job_join_dt(JobJoinDt);
		}
		
		if(JobWork.getJobWorkList().size() !=0){
			for (int i = 0; i < JobWork.getJobWorkList().size(); i++) {
				JobWork.getJobWorkList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobWork.getJobWorkList().get(i).setFap_job_work_ins_id(admin_id);
				JobWork.getJobWorkList().get(i).setFap_job_work_udt_id(admin_id);
			}
			sfacMapper.insert_job_work(JobWork);
		}
		
		if(JobCategory.getJobCategoryList().size() !=0){
			for (int i = 0; i < JobCategory.getJobCategoryList().size(); i++) {
				JobCategory.getJobCategoryList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobCategory.getJobCategoryList().get(i).setFap_job_category_ins_id(admin_id);
				JobCategory.getJobCategoryList().get(i).setFap_job_category_udt_id(admin_id);
			}
			sfacMapper.insert_job_category(JobCategory);
		}
		
		if(JobPref.getJobPrefList().size() !=0){
			for (int i = 0; i < JobPref.getJobPrefList().size(); i++) {
				JobPref.getJobPrefList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobPref.getJobPrefList().get(i).setFap_job_pref_ins_id(admin_id);
				JobPref.getJobPrefList().get(i).setFap_job_pref_udt_id(admin_id);
			}
			sfacMapper.insert_job_pref(JobPref);
		}
		
		
			List<SocietyFapJobWorkplace> jobWorkplaceList = new ArrayList<>();
			
			for (int i = 0; i < JobWorkplace.getJobWorkplaceList().size(); i++) {
				JobWorkplace.getJobWorkplaceList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobWorkplace.getJobWorkplaceList().get(i).setFap_job_workplace_ins_id(admin_id);
				JobWorkplace.getJobWorkplaceList().get(i).setFap_job_workplace_udt_id(admin_id);
				
				if(JobWorkplace.getJobWorkplaceList().get(i).getFap_job_workplace_gb() != null){
					jobWorkplaceList.add(JobWorkplace.getJobWorkplaceList().get(i));
				}
			}
			
			if(jobWorkplaceList.size() != 0){
			sfacMapper.insert_job_workplace(jobWorkplaceList);
			}
			
			List<SocietyFapJobWorkplaceDtl> jobWorkplaceDtlList = new ArrayList<>();
			
			for(SocietyFapJobWorkplace workplace : jobWorkplaceList) {
				for(SocietyFapJobWorkplaceDtl dtl : workplace.getJobWorkplaceDtl().getJobWorkplaceDtlList()) {
					dtl.setFap_job_workplace_seq(workplace.getFap_job_workplace_seq());
					dtl.setFap_job_workplace_dtl_ins_id(admin_id);
					dtl.setFap_job_workplace_dtl_udt_id(admin_id);
					
					if(dtl.getFap_job_workplace_dtl_gb() != null) {
						jobWorkplaceDtlList.add(dtl);
					}
				}
				
			}
			
			if(jobWorkplaceDtlList.size() != 0){
			sfacMapper.insert_job_workplace_dtl(jobWorkplaceDtlList);
			}
			
		//채용 전형
		if(JobRecruitPcs.getJobRecruitPcsList().size() !=0){
			for (int i = 0; i < JobRecruitPcs.getJobRecruitPcsList().size(); i++) {
				System.out.println(JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv());
				System.out.println(JobRecruitPcs.getJobRecruitPcsList().get(i).getJobTestEtc());
				JobRecruitPcs.getJobRecruitPcsList().get(i).setFap_job_ad_seq(JobAd.getFap_job_ad_seq());
				JobRecruitPcs.getJobRecruitPcsList().get(i).setFap_job_recruit_pcs_ins_id(admin_id);
				JobRecruitPcs.getJobRecruitPcsList().get(i).setFap_job_recruit_pcs_udt_id(admin_id);
			}
			sfacMapper.insert_job_recruitpcs(JobRecruitPcs);
		}
		
		//면접
		if(JobRecruitPcs.getJobRecruitPcsList().size() !=0){
			for (int i = 0; i < JobRecruitPcs.getJobRecruitPcsList().size(); i++) {
				if(!JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv().getFap_job_itv_tm().equals("")){
				JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv().setFap_job_recruit_pcs_seq(JobRecruitPcs.getFap_job_recruit_pcs_seq());
				JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv().setFap_job_itv_ins_id(admin_id);
				JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv().setFap_job_itv_udt_id(admin_id);
				sfacMapper.insert_job_itv(JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv());
				}
			}
			
		}
		
		//기타전형
		if(JobRecruitPcs.getJobRecruitPcsList().size() !=0){
			for (int i = 0; i < JobRecruitPcs.getJobRecruitPcsList().size(); i++) {
				if(!JobRecruitPcs.getJobRecruitPcsList().get(i).getJobTestEtc().getFap_job_test_etc_dtl().equals("")){
				JobRecruitPcs.getJobRecruitPcsList().get(i).getJobTestEtc().setFap_job_recruit_pcs_seq(JobRecruitPcs.getFap_job_recruit_pcs_seq());
				JobRecruitPcs.getJobRecruitPcsList().get(i).getJobTestEtc().setFap_job_test_etc_ins_id(admin_id);
				JobRecruitPcs.getJobRecruitPcsList().get(i).getJobTestEtc().setFap_job_test_etc_udt_id(admin_id);
				sfacMapper.insert_job_test_etc(JobRecruitPcs.getJobRecruitPcsList().get(i).getJobTestEtc());
				}
			}
					
		}
		
		//기타전형대상자(기타)
		if(JobRecruitPcs.getJobRecruitPcsList().size() !=0){
			for (int i = 0; i < JobRecruitPcs.getJobRecruitPcsList().size(); i++) {
				if(!JobRecruitPcs.getJobRecruitPcsList().get(i).getJobTestEtc().getFap_job_test_etc_dtl().equals("")){
					if(!JobRecruitPcs.getJobRecruitPcsList().get(i).getJobTestEtc().getJobTestEtcObj().getFap_job_test_etc_obj_dtl().equals("")){
					logger.info("{}", JobRecruitPcs.getJobRecruitPcsList().get(i));
					JobRecruitPcs.getJobRecruitPcsList().get(i).getJobTestEtc().getJobTestEtcObj().setFap_job_test_etc_seq(JobRecruitPcs.getJobRecruitPcsList().get(i).getJobTestEtc().getFap_job_test_etc_seq());
					JobRecruitPcs.getJobRecruitPcsList().get(i).getJobTestEtc().getJobTestEtcObj().setFap_job_test_etc_obj_ins_id(admin_id);
					JobRecruitPcs.getJobRecruitPcsList().get(i).getJobTestEtc().getJobTestEtcObj().setFap_job_test_etc_obj_udt_id(admin_id);
					sfacMapper.insert_job_test_etc_obj(JobRecruitPcs.getJobRecruitPcsList().get(i).getJobTestEtc().getJobTestEtcObj());
					}
				}
			}
					
		}
		
		//면접대상자(기타)
		if(JobRecruitPcs.getJobRecruitPcsList().size() !=0){
			for (int i = 0; i < JobRecruitPcs.getJobRecruitPcsList().size(); i++) {
				if(!JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv().getFap_job_itv_tm().equals("")){
					if(!JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv().getJobItvObjEtc().getFap_job_itv_obj_etc_dtl().equals("")){
					JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv().getJobItvObjEtc().setFap_job_itv_seq(JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv().getFap_job_itv_seq());
					JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv().getJobItvObjEtc().setFap_job_itv_obj_etc_ins_id(admin_id);
					JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv().getJobItvObjEtc().setFap_job_itv_obj_etc_udt_id(admin_id);
					sfacMapper.insert_job_itv_obj_etc(JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv().getJobItvObjEtc());
					}
				}
			}				
		}
		
		//면접방식(기타)
		if(JobRecruitPcs.getJobRecruitPcsList().size() !=0){
			for (int i = 0; i < JobRecruitPcs.getJobRecruitPcsList().size(); i++) {
				if(!JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv().getFap_job_itv_tm().equals("")){
					if(!JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv().getJobItvTpEtc().getFap_job_itv_tp_etc_dtl().equals("")){
					JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv().getJobItvTpEtc().setFap_job_itv_seq(JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv().getFap_job_itv_seq());
					JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv().getJobItvTpEtc().setFap_job_itv_tp_etc_ins_id(admin_id);
					JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv().getJobItvTpEtc().setFap_job_itv_tp_etc_udt_id(admin_id);
					sfacMapper.insert_job_itv_tp_etc(JobRecruitPcs.getJobRecruitPcsList().get(i).getJobItv().getJobItvTpEtc());
					}
				}
			}				
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
			job_pay.setFap_job_pay_ins_id(admin_id);
			job_pay.setFap_job_pay_udt_id(admin_id);
			job_pay_list.add(job_pay);
		}//비어있는 객체 판별하는 반복문 종료
		
		sfacMapper.insert_job_pay(job_pay_list);	//급여 등록
		JobPay.setJobPayList(job_pay_list);
		
		//급여중 구분이 기본값이 값은 기본값 하위 테이블 저장해야된다.
		for(SocietyFapJobPay jp : JobPay.getJobPayList()){
			if(jp.getFap_job_pay_gb().equals("C2200")){	//공통코드가 기본급일 경우
				
				ArrayList<SocietyFapJobPayBase> job_pay_base_list = new ArrayList<SocietyFapJobPayBase>();
				//하위 테이블 객체 등록작업 실시
				for(SocietyFapJobPayBase jpb : jp.getJobPayBase().getJobPayBaseList()){
					
					//필요한 파라미터 세팅
					jpb.setFap_job_pay_seq(jp.getFap_job_pay_seq());
					jpb.setFap_job_pay_base_udt_id(admin_id);
					jpb.setFap_job_pay_base_ins_id(admin_id);
					
					//리스트에 담아서
					job_pay_base_list.add(jpb);
				}
				//담음 리스트를 객체에 넣고
				
				//등록
				sfacMapper.insert_job_pay_base(job_pay_base_list);
				jp.getJobPayBase().setJobPayBaseList(job_pay_base_list);
				
				for(SocietyFapJobPayBase jpb : job_pay_base_list){
					
					if(jpb.getFap_job_pay_base_gb().equals("C2302")){
						//기본급중 서비스 잔업 수당
						SocietyFapJobServiceWork jsw = jpb.getJobServiceWork();
						jsw.setFap_job_pay_base_seq(jpb.getFap_job_pay_base_seq());
						jsw.setFap_job_service_work_udt_id(admin_id);
						jsw.setFap_job_service_work_ins_id(admin_id);
						sfacMapper.insert_job_service_work(jsw);
					}else if(jpb.getFap_job_pay_base_gb().equals("C2303")){
						//기본급중 기타 수당
						List<SocietyFapJobPayEtc> job_pay_etc_list = new ArrayList<SocietyFapJobPayEtc>();
						for(SocietyFapJobPayEtc jpe : jpb.getJobPayEtc().getJobPayEtcList()){
							jpe.setFap_job_pay_base_seq(jpb.getFap_job_pay_base_seq());
							jpe.setFap_job_pay_etc_udt_id(admin_id);
							jpe.setFap_job_pay_etc_ins_id(admin_id);
							job_pay_etc_list.add(jpe);
						}
						sfacMapper.insert_job_pay_etc(job_pay_etc_list);
					}
				}//for
				
				
				
				
				
			
			}else if(jp.getFap_job_pay_gb().equals("C2202")){
				
				logger.info("!!!!!!!!!!!!!!!!부모시퀀스{}", jp.getFap_job_pay_seq());
				jp.getJobPayExtra().setFap_job_pay_seq(jp.getFap_job_pay_seq());
				jp.getJobPayExtra().setFap_job_pay_extra_ins_id(admin_id);
				jp.getJobPayExtra().setFap_job_pay_extra_udt_id(admin_id);
					
				sfacMapper.insert_job_pay_extra(jp.getJobPayExtra());
				
			}
		}//for
		
		
		
		
		//급여등록 끝 (원병호)
		
		//시험
		if(JobRecruitPcs.getJobRecruitPcsList().size() !=0){
			for (int i = 0; i < JobRecruitPcs.getJobRecruitPcsList().size(); i++) {
				if(!JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getFap_job_exam_tm().equals("")){
				JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().setFap_job_recruit_pcs_seq(JobRecruitPcs.getFap_job_recruit_pcs_seq());
				JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().setFap_job_exam_ins_id(admin_id);
				JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().setFap_job_exam_udt_id(admin_id);
				sfacMapper.insert_job_exam(JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam());
				}
			}
					
		}
		
		//시험대상자(기타)
		if(JobRecruitPcs.getJobRecruitPcsList().size() !=0){
			for (int i = 0; i < JobRecruitPcs.getJobRecruitPcsList().size(); i++) {
				if(!JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getFap_job_exam_tm().equals("")){
					if(!JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getJobExamObjEtc().getFap_job_exam_obj_etc_dtl().equals("")){
					JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getJobExamObjEtc().setFap_job_exam_seq(JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getFap_job_exam_seq());
					JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getJobExamObjEtc().setFap_job_exam_obj_etc_ins_id(admin_id);
					JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getJobExamObjEtc().setFap_job_exam_obj_etc_udt_id(admin_id);
					sfacMapper.insert_job_exam_obj_etc(JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getJobExamObjEtc());
					}
				}
			}				
		}
		
		//시험감독관(기타)
		if(JobRecruitPcs.getJobRecruitPcsList().size() !=0){
			for (int i = 0; i < JobRecruitPcs.getJobRecruitPcsList().size(); i++) {
				if(!JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getFap_job_exam_tm().equals("")){
					if(!JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getJobExamSvEtc().getFap_job_exam_sv_etc_dtl().equals("")){
					JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getJobExamSvEtc().setFap_job_exam_seq(JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getFap_job_exam_seq());
					JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getJobExamSvEtc().setFap_job_exam_sv_etc_ins_id(admin_id);
					JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getJobExamSvEtc().setFap_job_exam_sv_etc_udt_id(admin_id);
					sfacMapper.insert_job_exam_sv_etc(JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getJobExamSvEtc());
					}
				}
			}				
		}
		
		//시험준비물(기타)
		if(JobRecruitPcs.getJobRecruitPcsList().size() !=0){
			for (int i = 0; i < JobRecruitPcs.getJobRecruitPcsList().size(); i++) {
				if(!JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getFap_job_exam_tm().equals("")){
					if(!JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getJobExamNeedEtc().getFap_job_exam_need_etc_dtl().equals("")){
					JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getJobExamNeedEtc().setFap_job_exam_seq(JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getFap_job_exam_seq());
					JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getJobExamNeedEtc().setFap_job_exam_need_etc_ins_id(admin_id);
					JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getJobExamNeedEtc().setFap_job_exam_need_etc_udt_id(admin_id);
					sfacMapper.insert_job_exam_need_etc(JobRecruitPcs.getJobRecruitPcsList().get(i).getJobExam().getJobExamNeedEtc());
					}
				}
			}				
		}
		
		// 시험 문제 파일
		if(JobRecruitPcs.getJobRecruitPcsList().size() !=0){
			for(SocietyFapJobRecruitPcs RecruitPcs : JobRecruitPcs.getJobRecruitPcsList()){
				if(!RecruitPcs.getJobExam().getFap_job_exam_tm().equals("")){
					if(!RecruitPcs.getJobExam().getJobExamNeedEtc().getFap_job_exam_need_etc_dtl().equals("")){
						RecruitPcs.getJobExam().getJobExamFile().setFap_job_exam_seq(RecruitPcs.getJobExam().getFap_job_exam_seq());
						RecruitPcs.getJobExam().getJobExamFile().setFap_job_exam_file_ins_id(admin_id);
						RecruitPcs.getJobExam().getJobExamFile().setFap_job_exam_file_udt_id(admin_id);
						sfacMapper.insert_job_exam_file(RecruitPcs.getJobExam().getJobExamFile());
					}
				}
			}
		}
		
		//시험종류
		List<SocietyFapJobExamType> jobExamTypeList = new ArrayList<>();
		
		if(JobRecruitPcs.getJobRecruitPcsList().size() !=0){
			for(SocietyFapJobRecruitPcs recruitpcs : JobRecruitPcs.getJobRecruitPcsList()) {
				if(!recruitpcs.getJobExam().getFap_job_exam_tm().equals("")){
				for(SocietyFapJobExamType jobExamType : recruitpcs.getJobExam().getJobExamTypeList()) {
					jobExamType.setFap_job_exam_seq(recruitpcs.getJobExam().getFap_job_exam_seq());
					jobExamType.setFap_job_exam_type_ins_id(admin_id);
					jobExamType.setFap_job_exam_type_udt_id(admin_id);
				
					if(jobExamType.getFap_job_exam_type_gb() != null) {
					jobExamTypeList.add(jobExamType);
					}
				}
				}
			}
		}
		if(jobExamTypeList.size() != 0){	
		sfacMapper.insert_job_exam_type(jobExamTypeList);
		}
		
		logger.info("채용공고 기본 정보 등록 DAO 종료");
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
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		ArrayList<HashMap<String, Object>> result = sfacMapper.select_job_pay(fap_jop_ad_seq);
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
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		jobAdList= sfacMapper.select_job_ad_list(fap_comp_id);		
		logger.debug("채용공고 기본 정보 리스트 출력 완료");
		return jobAdList;
	}
	
	/**
	 * @Method Name : selectJobAd
	 * @Date : 2019. 1. 10.
	 * @User : 이재준
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public HashMap<String, Object> selectJobAd(HashMap<String, Object> param) {
		logger.debug("FAP 채용공고 상세정보(수정) DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		logger.debug("FAP 채용공고 상세정보(수정) DAO 종료");
		return sfacMapper.selectJobAd(param);
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
		logger.info("FAP 관리자 채용공고 리스트 검색 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		ArrayList<HashMap<String, Object>> result = sfacMapper.admin_select_per_state_job_ad_list(parmas);
		logger.info("FAP 관리자 채용공고 리스트 검색 끝");
		return result;
	}
	
	/**
	 * @Method Name : admin_update_job_ad_state
	 * @Date : 2019. 2. 12.
	 * @User : 정대영
	 * @Param : SocietyFapJobAd
	 * @Return : -
	 * @Method 설명 : FAP 관리자 채용공고 상태를 수정하는 함수
	 */
	public void admin_update_job_ad_state(SocietyFapJobAd jobAd){
		logger.debug("FAP 채용공고 상태를 수정하는 DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		sfacMapper.admin_update_job_ad_state(jobAd);
		logger.debug("FAP 채용공고 상태를 수정하는 DAO 끝");
	}
	
	/**
	 * @Method Name : select_current_jobfair_group_code
	 * @Date : 2019. 2. 12.
	 * @User : 정대영
	 * @Param : Int(잡페어 시퀀스)
	 * @Return : HashMap
	 * @Method 설명 : FAP 관리자 해당 잡페어 그룹코드 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_current_jobfair_group_code(int fap_jobfair_seq){
		logger.debug("FAP 관리자 해당 잡페어 그룹코드 셀렉트 DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		ArrayList<HashMap<String, Object>> curJobFairGroupCode = sfacMapper.select_current_jobfair_group_code(fap_jobfair_seq);
		logger.debug("FAP 관리자 해당 잡페어 그룹코드 셀렉트 DAO 종료");
		return curJobFairGroupCode;
	}
	
	/**
	 * @Method Name : select_current_job_ad_info_for_group_code
	 * @Date : 2019. 2. 12.
	 * @User : 정대영
	 * @Param : Int(잡페어 시퀀스)
	 * @Return : HashMap
	 * @Method 설명 : FAP 관리자 해당 채용공고 그룹코드에 필요한 정보 셀렉트
	 */
	public HashMap<String, Object> select_current_job_ad_info_for_group_code(long fap_job_ad_seq){
		logger.debug("FAP 관리자 해당 채용공고 그룹코드에 필요한 정보 셀렉트 DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		HashMap<String, Object> curJobAdInfo = sfacMapper.select_current_job_ad_info_for_group_code(fap_job_ad_seq);
		logger.debug("FAP 관리자 해당 채용공고 그룹코드에 필요한 정보 셀렉트 DAO 종료");
		return curJobAdInfo;
	}
	
	
	/**
	 * @Method Name : admin_insert_apply_nums_per_ad
	 * @Date : 2019. 2. 12.
	 * @User : 정대영
	 * @Param : SocietyFapJobAd
	 * @Return : -
	 * @Method 설명 : FAP 관리자 채용공고 채용예정인원으로 채용가능인원 인서트하는 함수
	 */
	public void admin_insert_apply_nums_per_ad(SocietyFapJobAd jobAd){
		logger.debug("FAP 관리자 채용공고 채용예정인원으로 채용가능인원 인서트 DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		sfacMapper.admin_insert_apply_nums_per_ad(jobAd);
		logger.debug("FAP 관리자 채용공고 채용예정인원으로 채용가능인원 인서트 DAO 끝");
	}
	
	/**
	 * @Method Name : admin_insert_itv_nums_per_ad
	 * @Date : 2019. 7. 31.
	 * @User : 이종호
	 * @Param : 채용공고 정보
	 * @Return : -
	 * @Method 설명 : FAP 관리자 채용공고 채용예정인원으로 현지면접인원 등록
	 */
	public void admin_insert_itv_nums_per_ad(SocietyFapJobAd jobAd) {
		logger.info("FAP 관리자 채용공고 채용예정인원으로 현지면접인원 등록 DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		sfacMapper.admin_insert_itv_nums_per_ad(jobAd);
		logger.info("FAP 관리자 채용공고 채용예정인원으로 현지면접인원 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : admin_select_flag_apply_nums_per_ad
	 * @Date : 2019. 2. 12.
	 * @User : 정대영
	 * @Param : long
	 * @Return : Int
	 * @Method 설명 : FAP 관리자 지원가능인원이 설정되어있는지 여부 확인
	 */
	public int admin_select_flag_apply_nums_per_ad(long fap_job_ad_seq){
		logger.debug("FAP 관리자 지원가능인원이 설정되어있는지 여부 확인 DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		int cntFlag = sfacMapper.admin_select_flag_apply_nums_per_ad(fap_job_ad_seq);
		logger.debug("FAP 관리자 지원가능인원이 설정되어있는지 여부 확인 DAO 끝");
		return cntFlag;
	}
	
	/**
	 * @Method Name : admin_select_flag_itv_nums_per_ad
	 * @Date : 2019. 7. 31.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 검색 갯수
	 * @Method 설명 : FAP 관리자 현지면접인원이 설정되어 있는지 여부 확인
	 */
	public int admin_select_flag_itv_nums_per_ad(long fap_job_ad_seq) {
		logger.info("FAP 관리자 현지면접인원이 설정되어 있는지 여부 확인 DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		int result = sfacMapper.admin_select_flag_itv_nums_per_ad(fap_job_ad_seq);
		logger.info("FAP 관리자 현지면접인원이 설정되어 있는지 여부 확인 DAO 끝");
		return result;
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
		logger.info("기업 그룹코드 업데이트 DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		sfacMapper.admin_update_groupcode(params);
		logger.info("기업 그룹코드 업데이트 DAO 종료");
		
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
		logger.info("기업 그룹코드 갯수 가져오기 DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		 ArrayList<HashMap<String, Object>>count_per_group = sfacMapper.select_count_per_group(fap_jobfair_divide_seq);
		logger.info("기업 그룹코드 갯수 가져오기 DAO 종료");
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
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		sfacMapper.admin_job_app_per_update(parmas);
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
		logger.info("FAP 관리자 채용공고 현지제한인원 수정 DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		sfacMapper.admin_job_itv_per_update(params);
		logger.info("FAP 관리자 채용공고 현지제한인원 수정 DAO 종료");
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
		logger.info("FAP 관리자 미스매칭/일반지원 수정 DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		sfacMapper.admin_update_mismatching(params);
		logger.info("FAP 관리자 미스매칭/일반지원 수정 DAO 종료");
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
		logger.info("FAP 관리자 기업별 지원자 리스트 승인전 지원자 리스트 조회 DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		ArrayList<HashMap<String, Object>> result = sfacMapper.admin_job_apply_approval_yet(params);
		logger.info("FAP 관리자 기업별 지원자 리스트 승인전 지원자 리스트 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_jobfair_apply_rule_count
	 * @Date : 2019. 8. 7.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 지원룰 시퀀스 갯수
	 * @Method 설명 : 채용공고 승인 시 지원룰 대상 등록여부 확인
	 */
	public int select_jobfair_apply_rule_count(long fap_job_ad_seq) {
		logger.info("FAP 관리자 채용공고 승인 시 지원룰 대상 등록여부 확인 DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		int count = sfacMapper.select_jobfair_apply_rule_count(fap_job_ad_seq);
		logger.info("FAP 관리자 채용공고 승인 시 지원룰 대상 등록여부 확인 DAO 종료");
		return count;
	}
	
	/**
	 * @Method Name : delete_jobfair_apply_rule
	 * @Date : 2019. 8. 20.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : -
	 * @Method 설명 : 채용공고 승인 취소시 지원룰 대상 삭제 
	 */
	public void delete_jobfair_apply_rule(long fap_job_ad_seq) {
		logger.info("채용공고 승인 취소시 지원룰 대상 삭제 DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		sfacMapper.delete_jobfair_apply_rule(fap_job_ad_seq);
		logger.info("채용공고 승인 취소시 지원룰 대상 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : select_jobfair_applicable_time
	 * @Date : 2019. 8. 7.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 지원가능시간 시퀀스
	 * @Method 설명 : 세부잡페어별 진행중인 지원가능시간 시퀀스 조회
	 */
	public Long select_jobfair_applicable_time(long fap_job_ad_seq) {
		logger.info("FAP 관리자 세부잡페어별 진행중인 지원가능시간 시퀀스 조회 DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		Long fap_jobfair_applicable_time_seq = sfacMapper.select_jobfair_applicable_time(fap_job_ad_seq);
		logger.info("FAP 관리자 세부잡페어별 진행중인 지원가능시간 시퀀스 조회 DAO 종료");
		return fap_jobfair_applicable_time_seq;
	}
	
	/**
	 * @Method Name : insert_jobfair_apply_rule
	 * @Date : 2019. 8. 7.
	 * @User : 이종호
	 * @Param : 지원룰 정보
	 * @Return : -
	 * @Method 설명 : 지원룰 정보 등록
	 */
	public void insert_jobfair_apply_rule(SocietyFapAdminJobfairApplyRule rule) {
		logger.info("FAP 관리자 지원룰 정보 등록 DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		sfacMapper.insert_jobfair_apply_rule(rule);
		logger.info("FAP 관리자 지원룰 정보 등록 DAO 종료");
	}


	/**
	 * @Method Name : select_user_nm
	 * @Date : 2019. 9. 3.
	 * @User : 김경아	
	 * @Param :  id
	 * @Return : 
	 * @Method 설명 : id에 따른 이름 출력
	 */
	public HashMap<String, Object> select_comp_nm(String fap_comp_id) {
		logger.info("FAP id에 따른 이름 출력 DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		HashMap<String, Object> result = sfacMapper.select_comp_nm(fap_comp_id);
		logger.info("FAP id에 따른 이름 출력 DAO 종료");
		return result;
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
		logger.info("기업 그룹순위 업데이트 DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		ArrayList<String> list = sfacMapper.admin_select_rank(params);
		int res = 0;
		if(list.isEmpty()) {
			sfacMapper.admin_update_rank(params);
		}else{
			res = sfacMapper.admin_delete_rank(params);
			sfacMapper.admin_update_rank(params);
		}
		
		logger.info("기업 그룹순위 업데이트 DAO 종료");
		return res;
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
		logger.info("잡페어 관리자 그룹코드 일반회원 지원 허용 DAO 시작");
		SocietyFapAdminCompanyMapper sfacMapper = sqlSession.getMapper(SocietyFapAdminCompanyMapper.class);
		int res = 0;
		res = sfacMapper.allow_common_user_yn(params);
		logger.info("잡페어 관리자 그룹코드 일반회원 지원 허용 DAO 시작");
		return res;
	}
}
