/**
 * 
 */
package global.segroup.society.fap.adminuser.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import global.segroup.society.fap.admincommon.domain.SocietyFapJobfairApplicableTime;
import global.segroup.society.fap.admincompany.dao.SocietyFapAdminCompanyDAO;
import global.segroup.society.fap.adminuser.dao.SocietyFapAdminUserDAO;
import global.segroup.society.fap.adminuser.domain.SocietyFapAdminUserOfConflictedQuarter;
import global.segroup.util.PageNavigator;

/**
 * @Author : 신동철
 * @Date : 2018. 11. 29.
 * @Class 설명 : Soft Engineer Society 통합잡페어 관리자 서비스
 * 
 */
@Service
public class SocietyFapAdminUserService {

	private static final Logger logger = LoggerFactory.getLogger(SocietyFapAdminUserService.class);

	@Autowired
	private SocietyFapAdminUserDAO sfauDAO;
	
	@Autowired
	private SocietyFapAdminCompanyDAO sfacDAO;

	/**
	 * @Method Name : select_jobfair_divide_ad_apply_status_info
	 * @Date : 2019. 1. 8.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : HashMap
	 * @Method 설명 : FAP 관리자 잡페어 세부 별 채용공고 진행상황 리스트를 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_jobfair_divide_ad_apply_status_info(int fap_jobfair_divide_seq){
		logger.debug("FAP 관리자 잡페어 세부 별 채용공고 진행상황 셀렉트  Service 시작");
		ArrayList<HashMap<String, Object>> adApplyStatusInfoList = sfauDAO.select_jobfair_divide_ad_apply_status_info(fap_jobfair_divide_seq);
		logger.debug("FAP 관리자 잡페어 세부 별 채용공고 진행상황 셀렉트  Service 종료");
		return adApplyStatusInfoList;
	}
	
	/**
	 * @Method Name : select_jobfair_divide_addition_comp_list
	 * @Date : 2019. 1. 8.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : HashMap
	 * @Method 설명 : FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고 리스트 셀렉트
	 */
	public ArrayList<HashMap<String, Object>> select_jobfair_divide_addition_comp_list(int fap_jobfair_divide_seq){
		logger.debug("FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고 리스트 셀렉트 Service 시작");
		ArrayList<HashMap<String, Object>> additionCompList = sfauDAO.select_jobfair_divide_addition_comp_list(fap_jobfair_divide_seq);
		logger.debug("FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고 리스트 셀렉트 Service 종료");
		return additionCompList;
	}
	
	/**
	 * @Method Name : insert_jobfair_divide_addition_comp_list
	 * @Date : 2019. 1. 8.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고로 설정(insert)
	 */
	public String insert_jobfair_divide_addition_comp_list(HashMap<String, Object> insertIntoAdditionalApplyInfoMap){
		logger.debug("FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고로 설정(insert) Service 시작");
		int insertResult = sfauDAO.insert_jobfair_divide_addition_comp_list(insertIntoAdditionalApplyInfoMap);
		String message = (insertResult == 1) ? "insertSuccess" : "insertFail";
	    logger.debug("FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고로 설정(insert) Service 종료");
		return message;
	}
	
	/**
	 * @Method Name : delete_jobfair_divide_addition_comp_list
	 * @Date : 2019. 1. 8.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고에서 설정 삭제
	 */
	public String delete_jobfair_divide_addition_comp_list(HashMap<String, Object> deleteFromAdditionalApplyInfoMap){
		logger.debug("FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고에서 설정 삭제 Service 시작");
		int deleteResult = sfauDAO.delete_jobfair_divide_addition_comp_list(deleteFromAdditionalApplyInfoMap);
		String message = (deleteResult == 1) ? "deleteSuccess" : "deleteFail";
	    logger.debug("FAP 관리자 잡페어 세부 별 추가지원 가능한 채용공고에서 설정 삭제 Service 종료");
		return message;
	}
	
	/**
	 * @Method Name : select_jobfair_divide_applicable_time
	 * @Date : 2019. 1. 9.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : HashMapList
	 * @Method 설명 : FAP 관리자 잡페어 세부별 지원가능 시간 조회
	 */
	public ArrayList<HashMap<String, Object>> select_jobfair_divide_applicable_time(int fap_jobfair_divide_seq){
		logger.debug("FAP 관리자 잡페어 세부별 지원가능 시간 조회  Service 시작");
		ArrayList<HashMap<String, Object>> applicableTimeList = sfauDAO.select_jobfair_divide_applicable_time(fap_jobfair_divide_seq);
		logger.debug("FAP 관리자 잡페어 세부별 지원가능 시간 조회  Service 종료");
		return applicableTimeList;
	}
	
	/**
	 * @Method Name : resume_approval_after_rule_apply
	 * @Date : 2019. 1. 9.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 관리자 잡페어 세부별 룰 적용 후 취업지원자 이력서 승인
	 */
	@Transactional
	public void resume_approval_after_rule_apply(HashMap<String, Object> approvalInsertInfoMap){
		logger.debug("FAP 관리자 잡페어 세부별 룰 적용 후 취업지원자 이력서 승인 Service 시작");

		//[start] 쿼터에 맞지 않는 지원자 삭제 시작
		ArrayList<SocietyFapAdminUserOfConflictedQuarter> conflictedUserApplyInfoList = sfauDAO.select_user_of_conflicted_quarter_info(approvalInsertInfoMap);
		
		if(conflictedUserApplyInfoList != null && !conflictedUserApplyInfoList.isEmpty()){
			deleteOfConflictedUserInfoMethod(conflictedUserApplyInfoList);
		}
		//[end] 쿼터에 맞지 않는 지원자 삭제 종료
		
		//[start] 지원승인전에 알림처리 해주는 코드 시작
		//여기에 추가 코드 넣어주기(아니면 insert후에 알림 insert해도 됨)
		//[end] 지원승인전에 알림처리 해주는 코드  종료
		
		int insertResultCount = sfauDAO.resume_rule_apply_after_insert(approvalInsertInfoMap);
		
		if(insertResultCount > 0){
			//전형별지원결과정보 테이블에  현재 최종합격여부 insert해주는 부분
			sfauDAO.insert_apply_final_result_tb(approvalInsertInfoMap);
			sfauDAO.apply_after_job_apply_info_update(approvalInsertInfoMap);
		}else {
			sfauDAO.not_applicant_apply_after_job_apply_info_update(approvalInsertInfoMap);
		}
		
		//추가지원가능한 기업 삭제시키는부분
		sfauDAO.delete_addition_apply_company(approvalInsertInfoMap);
		logger.debug("FAP 관리자 잡페어 세부별 룰 적용 후 취업지원자 이력서 승인 Service 종료");
		
	}
	
	/**
	 * @Method Name : resume_ignore_after_rule_apply
	 * @Date : 2019. 1. 9.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 관리자 잡페어 세부별 룰 무시하고 취업지원자 이력서 승인
	 */
	@Transactional
	public void resume_ignore_after_rule_apply(HashMap<String, Object> ignoreInsertInfoMap){
		logger.debug("FAP 관리자 잡페어 세부별 룰 무시하고 취업지원자 이력서 승인 Service 시작");
		
		//[start] 지원승인전에 알림처리 해주는 코드 시작
		//여기에 추가 코드 넣어주기(아니면 insert후에 알림 insert해도 됨)
		//[end] 지원승인전에 알림처리 해주는 코드  종료
		
		int insertResultCount = sfauDAO.resume_rule_apply_after_insert(ignoreInsertInfoMap);
		
		if(insertResultCount > 0){
			//전형별지원결과정보 테이블에  현재 최종합격여부 insert해주는 부분
			sfauDAO.insert_apply_final_result_tb(ignoreInsertInfoMap);
			sfauDAO.apply_after_job_apply_info_update(ignoreInsertInfoMap);
		}else {
			sfauDAO.not_applicant_apply_after_job_apply_info_update(ignoreInsertInfoMap);
		}
		
		//추가지원가능한 기업 삭제시키는부분
		sfauDAO.delete_addition_apply_company(ignoreInsertInfoMap);
		logger.debug("FAP 관리자 잡페어 세부별 룰 무시하고 취업지원자 이력서 승인 Service 종료");
	}
	
	/**
	 * @Method Name : update_applicable_time_deadline_gb
	 * @Date : 2019. 8. 19.
	 * @User : 이종호
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 모든채용공고의 지원룰 적용이 완료 됬다면 세부잡페어별 최종적용여부 변경
	 */
	@Transactional
	public void update_applicable_time_deadline_gb(HashMap<String, Object> ignoreInsertInfoMap) {
		//지원룰 적용 모든채용공고 완료 여부 확인
		Long fap_jobfair_applicable_time_seq = sfauDAO.select_is_applicable_time(ignoreInsertInfoMap);
		
		//모든채용공고의 지원룰 적용이 완료 됬다면 세부잡페어별 최종적용여부 변경
		if(fap_jobfair_applicable_time_seq != null) {
			sfauDAO.update_applicable_time_deadline_gb(fap_jobfair_applicable_time_seq);
		}
	}
	
	/**
	 * @Method Name : deleteOfConflictedUserInfo
	 * @Date : 2019. 1. 10.
	 * @User : 정대영
	 * @Param : SocietyFapAdminUserOfConflictedQuarterList
	 * @Return : SocietyFapAdminUserOfConflictedQuarterMap
	 * @Method 설명 : FAP 관리자 잡페어 세부별 쿼터에 걸리는 취업지원자 지우는 메소드
	 */
	public void deleteOfConflictedUserInfoMethod(ArrayList<SocietyFapAdminUserOfConflictedQuarter> conflictedUserApplyInfoList){
		//채용공고 별로 지망 순위 담을 List
		ArrayList<SocietyFapAdminUserOfConflictedQuarter> forDeleteUserApplyInfoList = new ArrayList<>();
		
		//비교할 시퀀스
		Long compareSeq = (long)0;
	
		//채용공고 시퀀스 별로 forDeleteUserApplyInfoList에 add시켜주고 그 안에 지망 RankList 만들어주는 부분
		for(SocietyFapAdminUserOfConflictedQuarter conflictedUserApplyInfo : conflictedUserApplyInfoList){
			if(conflictedUserApplyInfo.getFap_job_ad_seq() != compareSeq){
				//임시 채용공고별 지원번호 시퀀스 및 지망 리스트 생성 
				LinkedHashMap<Long, Integer> tempAdPerApplyRankList = new LinkedHashMap<>();
				conflictedUserApplyInfo.setAdPerApplyRankList(tempAdPerApplyRankList);
				forDeleteUserApplyInfoList.add(conflictedUserApplyInfo);
				compareSeq = conflictedUserApplyInfo.getFap_job_ad_seq();
			}
		}
		//반복문 종료
		
		//forDeleteUserApplyInfoList안에 있는 RankList에 지망 순으로 Add해주는 부분
		for(SocietyFapAdminUserOfConflictedQuarter conflictedUserApplyInfo : conflictedUserApplyInfoList){
			
			for(SocietyFapAdminUserOfConflictedQuarter forDeleteUserApplyInfo : forDeleteUserApplyInfoList){
				//delete할 정보를 갖고있는 리스트에 이미 해당 채용공고 시퀀스가 있을 때
				if(conflictedUserApplyInfo.getFap_job_ad_seq() == forDeleteUserApplyInfo.getFap_job_ad_seq()){
					forDeleteUserApplyInfo.getAdPerApplyRankList()
						.put(conflictedUserApplyInfo.getFap_job_app_info_seq(), conflictedUserApplyInfo.getFap_job_app_info_rank());
					
				}
			}	
			//안쪽 반복문 종료
		}
		//바깥쪽 반복문 종료
		
		//채용공고 별로 최종적으로 지울 정보를 저장할 List
		ArrayList<SocietyFapAdminUserOfConflictedQuarter> finallyMustDeleteUserApplyInfoList = new ArrayList<>();
		
		//반복문으로 시퀀스 별 VO에 넣어준 후
		for(SocietyFapAdminUserOfConflictedQuarter forDeleteUserApplyInfo : forDeleteUserApplyInfoList){
			//채용공고 별 최대지망 저장변수
			int jobAdPerMaxQuarter = 0;
			//가상 지원 카운트
			int settledNumCount = 1;
			
			//채용공고 별 최대지망을 찾기 위한 반복문
			for(Long adPerApplyRank : forDeleteUserApplyInfo.getAdPerApplyRankList().keySet()){
				Long fap_job_app_info_seq = adPerApplyRank;
				int fap_job_app_info_rank = forDeleteUserApplyInfo.getAdPerApplyRankList().get(fap_job_app_info_seq);
				if(forDeleteUserApplyInfo.getApplicable_num() == settledNumCount){
					jobAdPerMaxQuarter = fap_job_app_info_rank;
				}
				settledNumCount++;
			}
			//최대지망 찾기 반복문 종료
			
			//채용공고 별로 최종적으로 지울 정보를 저장할 List안, 즉 adperApplyRank에 들어갈 Map
			LinkedHashMap<Long, Integer> finallyMustDeleteAdPerApplyRankMap = new LinkedHashMap<>();
			
			//안쪽 반복문만 끝나면 해당 채용공고 별로 저장된 최대지망 변수와 비교해서 지워야 할 채용지원시퀀스를 새로운 랭킹Map에 넣는다.
			for(Long adPerApplyRank : forDeleteUserApplyInfo.getAdPerApplyRankList().keySet()){
				Long fap_job_app_info_seq = adPerApplyRank;
				int fap_job_app_info_rank = forDeleteUserApplyInfo.getAdPerApplyRankList().get(fap_job_app_info_seq);

				//여기서 채용공고 별 지워야 할 랭킹 리스트 들어가기전 Map에 넣어주는 부분
				if(jobAdPerMaxQuarter != 0) {
					if(fap_job_app_info_rank > jobAdPerMaxQuarter){
						finallyMustDeleteAdPerApplyRankMap.put(fap_job_app_info_seq, fap_job_app_info_rank);
					}
				}
			}
			//지워야 할 채용공고정보 Map에 담는 반복문 종료
			
			//지망넘는 인원 판단 반복문이 끝나 랭킹리스트Map에 들어간 정보를 최종 객체에 Add해준다.
			forDeleteUserApplyInfo.setAdPerApplyRankList(finallyMustDeleteAdPerApplyRankMap);
			finallyMustDeleteUserApplyInfoList.add(forDeleteUserApplyInfo);
		}	
		
		//마이바티스로 가져가기 위한 Map
		LinkedHashMap<String, Object> finallyMustDeleteUserApplyInfoListMap = new LinkedHashMap<>();
		//마이바티스로 가져가기 위해 Map에 넣어주는 부분
		finallyMustDeleteUserApplyInfoListMap.put("finallyMustDeleteUserApplyInfoList", finallyMustDeleteUserApplyInfoList);
		//adPerApplyRankList
		
		for(SocietyFapAdminUserOfConflictedQuarter item : finallyMustDeleteUserApplyInfoList){
			if(item.getAdPerApplyRankList().size() != 0){
				//쿼터 튕기는 취업지원자 튕기는 만큼 지망수 올리는 부분
				logger.info("!!!!! {}", finallyMustDeleteUserApplyInfoListMap);
				sfauDAO.quarter_count_return_because_apply_fail(finallyMustDeleteUserApplyInfoListMap);
				//쿼터 충돌된 지원자 지우는 DAO부르는 부분
				sfauDAO.delete_user_of_conflicted_quarter_info(finallyMustDeleteUserApplyInfoListMap);
			}
		}	
	}

	/**
	 * @Method Name : insert_jobfair_apply_rule_info
	 * @Date : 2019. 8. 9.
	 * @User : 김경아
	 * @Param : 지원룰 테이블에 추가될 정보
	 * @Return : 지원룰 테이블 정보 추가여부 
	 * @Method 설명 : 채용공고 관련 정보 추가시 지원룰 테이블에 관련 정보 추가
	 */
	public String insert_jobfair_apply_rule_info(HashMap<String, Object> insertIntoAdditionalApplyInfoMap) {
		logger.debug("FAP 관리자 채용공고 관련 정보 추가시 지원룰 테이블에 관련 정보 추가 Service 시작");
		int ruleCount = sfacDAO.select_jobfair_apply_rule_count(Long.parseLong(insertIntoAdditionalApplyInfoMap.get("fap_job_ad_seq").toString()));
		int result = 0;
		if(ruleCount == 0) {
			result = sfauDAO.insert_jobfair_apply_rule_info(insertIntoAdditionalApplyInfoMap);
		}
		String additionalMessage = (result==1)? "additionalInsertSuccess":"additionalInsertFail";
		logger.debug("FAP 관리자 채용공고 관련 정보 추가시 지원룰 테이블에 관련 정보 추가 Service 종료");
		return additionalMessage;
	}

	
	/**
	 * @Method Name : delete_jobfair_apply_rule_info
	 * @Date : 2019. 8. 9.
	 * @User : 김경아
	 * @Param : 지원룰 테이블에 삭제될 정보
	 * @Return : 지원룰 테이블 정보 삭제여부 
	 * @Method 설명 : 채용공고 관련 정보 삭제시 지원룰 테이블에 관련 정보 삭제
	 */
	public String delete_jobfair_apply_rule_info(HashMap<String, Object> deleteFromAdditionalApplyInfoMap) {
		logger.debug("FAP 관리자 채용공고 관련 정보 추가시 지원룰 테이블에 관련 정보 삭제 Service 시작");
		int result = sfauDAO.delete_jobfair_apply_rule_info(deleteFromAdditionalApplyInfoMap);
		String additionalMessage = (result==1)? "additionalDeleteSuccess":"additionalDeleteFail";
		logger.debug("FAP 관리자 채용공고 관련 정보 추가시 지원룰 테이블에 관련 정보 삭제 Service 종료");
		return additionalMessage;
	}
	
	/**
	 * @Method Name : select_jobfair_applicable_time_nm_list
	 * @Date : 2019. 8. 6.
	 * @User : 이종호
	 * @Param : 세부잡페어 시퀀스
	 * @Return : 지원가능 시간 명칭 리스트
	 * @Method 설명 : 세부잡페어별 지원가능 시간 명칭 리스트 조회
	 */
	public ArrayList<SocietyFapJobfairApplicableTime> select_jobfair_applicable_time_nm_list(int fap_jobfair_divide_seq){
		logger.info("FAP 관리자 세부잡페어별 지원가능 시간 명칭 리스트 조회 서비스 시작");
		ArrayList<SocietyFapJobfairApplicableTime> result = sfauDAO.select_jobfair_applicable_time_nm_list(fap_jobfair_divide_seq);
		logger.info("FAP 관리자 세부잡페어별 지원가능 시간 명칭 리스트 조회 서비스 종료");
		return result;
	}

	/**
	 * @Method Name : select_jobfair_applicable_ad_list
	 * @Date : 2019. 8. 7.
	 * @User : 이종호
	 * @Param : 채용공고 지원가능시간 시퀀스
	 * @Return : 지원룰 대상 채용공고 리스트
	 * @Method 설명 : 세부 채용공고별 지원룰 대상 채용공고 리스트 조회
	 */
	public HashMap<String, Object> select_jobfair_applicable_ad_list(long fap_jobfair_applicable_time_seq,int pageCount, int curPage,int orderNo){
		logger.info("FAP 관리자 세부 채용공고별 지원룰 대상 채용공고 리스트 조회 서비스 시작");
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("fap_jobfair_applicable_time_seq", fap_jobfair_applicable_time_seq);
		params.put("orderNo", orderNo);
		
		int total = sfauDAO.select_jobfair_applicable_ad_list_count(fap_jobfair_applicable_time_seq);
		PageNavigator navi = new PageNavigator(pageCount, 5, curPage, total);
		ArrayList<HashMap<String, Object>> result = sfauDAO.select_jobfair_applicable_ad_list(params,navi);
		
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("navi", navi);
		resultMap.put("result", result);
		
		logger.info("FAP 관리자 세부 채용공고별 지원룰 대상 채용공고 리스트 조회 서비스 종료");
		return resultMap;
	}
}
