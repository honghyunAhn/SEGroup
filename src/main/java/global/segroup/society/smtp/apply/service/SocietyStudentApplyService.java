package global.segroup.society.smtp.apply.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import global.segroup.domain.User;
import global.segroup.society.edu.apply.service.SocietyEduApplyService;
import global.segroup.society.smtp.apply.dao.SocietyStudentApplyDAO;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyCareer;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyEduHistory;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyForm;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyIntroduce;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyKmove;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyLanguage;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyLicense;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyOverseas;
import global.segroup.society.smtp.apply.domain.SocietyStuApplySes;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyStudy;
import global.segroup.util.FileService;

@Service
public class SocietyStudentApplyService {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyEduApplyService.class);

	/**
	 * file.propertices 의 등록된 지원신청서 증명사진 경로
	 */
	@Value("#{props['stu.apply.photo']}")
	private String stuApplyPhotoPath;

	/**
	 * file.propertices 의 등록된 지원신청서 최종 학력증명서 경로
	 */
	@Value("#{props['stu.apply.edu_history']}")
	private String stuApplyEduHistoryPath;

	/**
	 * file.propertices 의 등록된 지원신청서 고용보험 상실확인 경로
	 */
	@Value("#{props['stu.apply.insurance']}")
	private String stuApplyInsurancePath;

	/**
	 * file.propertices 의 등록된 지원신청서 출입국 사실증명서 경로
	 */
	@Value("#{props['stu.apply.immigration']}")
	private String stuApplyImmgrationPath;

	/**
	 * file.propertices 의 등록된 지원신청서 출입국 사실증명서 경로
	 */
	@Value("#{props['stu.apply.worknet']}")
	private String stuApplyWorknetPath;

	@Autowired
	SocietyStudentApplyDAO ssaDao;
	
	// 지원이력 조회
	public HashMap<String, Object> selectApplyInfo(HashMap<String, Object> param) {
		return ssaDao.selectApplyInfo(param);
	}

	// 수정하기 위해 기존 지원서 내용 조회
	public HashMap<String, Object> selectSmtpApply(HashMap<String, Object> param) {
		return ssaDao.selectSmtpApply(param);
	}
	
	// 지원서로 이동시 기수 이름, 지원 마감일 정보 조회
	public HashMap<String, Object> selectGisuInfo(String cardinal_id) {
		return ssaDao.selectGisuInfo(cardinal_id);
	}
	
	/**
	 * @Method Name : apply_insert
	 * @Date : 2020. 8. 5.
	 * @User : 김성미
	 * @Param : 교육 프로그램 지원신청 정보(기본정보 , 학력, 경력, 교육이수, 언어능력, 자격증, 본 과정 응시여부, K-MOVE스쿨 참여여부, 
	 *        해외체류경험, 자기소개서, 증빙자료)
	 * @Return : -
	 * @Method 설명 : 컨트롤러로 부터 전달 받은 지원신청 정보를 DAO로 전달.
	 */
	@Transactional
	public boolean apply_insert(SocietyStuApplyForm ssaForm, SocietyStuApplyEduHistory ssaEduHistory
			,SocietyStuApplyCareer ssaCareer, SocietyStuApplyStudy ssaStudy, SocietyStuApplyLanguage ssaLanguage
			,SocietyStuApplyLicense ssaLicense, SocietyStuApplySes ssaSes, SocietyStuApplyKmove ssaKmove
			,SocietyStuApplyOverseas ssaOverseas, SocietyStuApplyIntroduce ssaIntroduce, String app_end_date, HashMap<String, Object> param) {

		logger.debug("지원신청 서비스 시작");
		
		// 지원신청 기간 유효성 검사
		SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd");
		Date time = new Date();
		String today = format.format(time);
		
		int compare = today.compareTo(app_end_date);
		if(compare > 0) return false;
		
		// 업데이트의 경우, 이전에 작성한 신청서 내용 삭제
		//if(ssaForm.getStu_app_seq() != 0) deleteApply(param); 
		deleteApply(param); 
		
		// 첨부파일 처리
		attachFiles(ssaForm);
		
		// 비어있는 리스트 삭제
		emptyListCheck(ssaEduHistory, ssaCareer, ssaStudy, ssaLanguage, ssaLicense, ssaSes, ssaKmove, ssaOverseas, ssaIntroduce);
		
		ssaDao.apply_insert(ssaForm, ssaEduHistory, ssaCareer, ssaStudy, ssaLanguage, ssaLicense, ssaSes, ssaKmove, ssaOverseas, ssaIntroduce);
		logger.debug("지원신청 서비스 종료");
		return true;
	}

	public void deleteApply(HashMap<String, Object> param) {
		ssaDao.deleteSmtpApplyForm(param);
	}
	
	public void attachFiles(SocietyStuApplyForm ssaForm){
		// 저장 fullPath
		String fullPath = "/" + ssaForm.getUser_id() + "_" + String.valueOf(ssaForm.getGisu_id());

		// 지원신청서 증명사진 기존파일 삭제
		if (ssaForm.getStu_app_photo_origin() != null) {
			ssaForm.setStu_app_photo_origin(ssaForm.getStu_app_photo_origin());
			ssaForm.setStu_app_photo_saved(ssaForm.getStu_app_photo_saved());
		} else if (ssaForm.getStu_app_photo_saved() != null) {
			FileService.deleteFile(ssaForm.getStu_app_photo_saved(), stuApplyPhotoPath + fullPath);
		}
		// 지원신청서 증명사진 체크
		if (ssaForm.getStu_app_photo_file() != null && !ssaForm.getStu_app_photo_file().isEmpty()) {
			String photoOrigin = ssaForm.getStu_app_photo_file().getOriginalFilename();
			try {
				String photoSaved = FileService.saveFile(ssaForm.getStu_app_photo_file(), stuApplyPhotoPath + fullPath);
				ssaForm.setStu_app_photo_saved(photoSaved);
				ssaForm.setStu_app_photo_origin(photoOrigin);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			}
		}

		// 지원신청서 최종학력증명서 기존파일 삭제
		if (ssaForm.getStu_app_edu_file_origin() != null) {
			ssaForm.setStu_app_edu_file_origin(ssaForm.getStu_app_edu_file_origin());
			ssaForm.setStu_app_edu_file_saved(ssaForm.getStu_app_edu_file_saved());
		} else if (ssaForm.getStu_app_edu_file_saved() != null) {
			FileService.deleteFile(ssaForm.getStu_app_edu_file_saved(), stuApplyEduHistoryPath + fullPath);
		}
		// 지원신청서 최종학력증명서 체크
		if (ssaForm.getStu_app_edu_file() != null && !ssaForm.getStu_app_edu_file().isEmpty()) {
			String eduOrigin = ssaForm.getStu_app_edu_file().getOriginalFilename();
			try {
				String eduSaved = FileService.saveFile(ssaForm.getStu_app_edu_file(), stuApplyEduHistoryPath + fullPath);
				ssaForm.setStu_app_edu_file_saved(eduSaved);
				ssaForm.setStu_app_edu_file_origin(eduOrigin);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			}
		}

		// 지원신청서 고용보험 상실확인 기존파일 삭제
		if (ssaForm.getStu_app_isr_file_origin() != null) {
			ssaForm.setStu_app_isr_file_origin(ssaForm.getStu_app_isr_file_origin());
			ssaForm.setStu_app_isr_file_saved(ssaForm.getStu_app_isr_file_saved());
		} else if (ssaForm.getStu_app_isr_file_saved() != null) {
			FileService.deleteFile(ssaForm.getStu_app_isr_file_saved(), stuApplyInsurancePath + fullPath);
		}
		// 지원신청서 고용보험 상실확인 체크
		if (ssaForm.getStu_app_isr_file() != null && !ssaForm.getStu_app_isr_file().isEmpty()) {
			String isrOrigin = ssaForm.getStu_app_isr_file().getOriginalFilename();
			try {
				String isrSaved = FileService.saveFile(ssaForm.getStu_app_isr_file(), stuApplyInsurancePath + fullPath);
				ssaForm.setStu_app_isr_file_saved(isrSaved);
				ssaForm.setStu_app_isr_file_origin(isrOrigin);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			}
		}

		// 지원신청서 출입국 사실증명서 기존파일 삭제
		if (ssaForm.getStu_app_imm_file_origin() != null) {
			ssaForm.setStu_app_imm_file_origin(ssaForm.getStu_app_imm_file_origin());
			ssaForm.setStu_app_imm_file_saved(ssaForm.getStu_app_imm_file_saved());
		} else if (ssaForm.getStu_app_imm_file_saved() != null) {
			FileService.deleteFile(ssaForm.getStu_app_imm_file_saved(), stuApplyImmgrationPath + fullPath);
		}
		// 지원신청서 출입국 사실증명서 체크
		if (ssaForm.getStu_app_imm_file() != null && !ssaForm.getStu_app_imm_file().isEmpty()) {
			String immOrigin = ssaForm.getStu_app_imm_file().getOriginalFilename();
			try {
				String immSaved = FileService.saveFile(ssaForm.getStu_app_imm_file(), stuApplyImmgrationPath + fullPath);
				ssaForm.setStu_app_imm_file_saved(immSaved);
				ssaForm.setStu_app_imm_file_origin(immOrigin);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			}
		}

		// 지원신청서 워크넷 직무평가 결과 기존파일 삭제
		if (ssaForm.getStu_app_worknet_file_origin() != null) {
			ssaForm.setStu_app_worknet_file_origin(ssaForm.getStu_app_worknet_file_origin());
			ssaForm.setStu_app_worknet_file_saved(ssaForm.getStu_app_worknet_file_saved());
		} else if (ssaForm.getStu_app_worknet_file_saved() != null) {
			FileService.deleteFile(ssaForm.getStu_app_worknet_file_saved(), stuApplyWorknetPath + fullPath);
		}
		// 지원신청서 워크넷 직무평가 결과 체크
		if (ssaForm.getStu_app_worknet_file() != null && !ssaForm.getStu_app_worknet_file().isEmpty()) {
			String immOrigin = ssaForm.getStu_app_worknet_file().getOriginalFilename();
			try {
				String immSaved = FileService.saveFile(ssaForm.getStu_app_worknet_file(), stuApplyWorknetPath + fullPath);
				ssaForm.setStu_app_worknet_file_saved(immSaved);
				ssaForm.setStu_app_worknet_file_origin(immOrigin);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void emptyListCheck(SocietyStuApplyEduHistory ssaEduHistory
			,SocietyStuApplyCareer ssaCareer, SocietyStuApplyStudy ssaStudy, SocietyStuApplyLanguage ssaLanguage
			,SocietyStuApplyLicense ssaLicense, SocietyStuApplySes ssaSes, SocietyStuApplyKmove ssaKmove
			,SocietyStuApplyOverseas ssaOverseas, SocietyStuApplyIntroduce ssaIntroduce){
		
		ArrayList<Integer> removeArr = new ArrayList<>();
		
		// 학력정보 빈 리스트 체크
		for (SocietyStuApplyEduHistory eduHistory : ssaEduHistory.getEduHistoryList()) {
			if (eduHistory.getStu_app_edu_sc_nm().trim().equals(""))
				removeArr.add(ssaEduHistory.getEduHistoryList().indexOf(eduHistory));
		}
		// 학력정보 빈 리스트 제거 후 인덱스 리스트 초기화
		ssaEduHistory.setEduHistoryList(removeEmptyList(ssaEduHistory.getEduHistoryList(), removeArr));
		removeArr.clear();

		// 경력정보
		for (SocietyStuApplyCareer career : ssaCareer.getCareerList()) {
			if (career.getStu_app_crr_place().trim().equals(""))
				removeArr.add(ssaCareer.getCareerList().indexOf(career));
		}
		ssaCareer.setCareerList(removeEmptyList(ssaCareer.getCareerList(), removeArr));
		removeArr.clear();

		// 교육이수내용
		for (SocietyStuApplyStudy study : ssaStudy.getStudyList()) {
			if (study.getStu_app_study_nm().trim().equals(""))
				removeArr.add(ssaStudy.getStudyList().indexOf(study));
		}
		ssaStudy.setStudyList(removeEmptyList(ssaStudy.getStudyList(), removeArr));
		removeArr.clear();

		// 언어능력 
		for (SocietyStuApplyLanguage language : ssaLanguage.getLanguageList()) {
			if (language.getStu_app_lang_test_nm().trim().equals(""))
				removeArr.add(ssaLanguage.getLanguageList().indexOf(language));
		}
		ssaLanguage.setLanguageList(removeEmptyList(ssaLanguage.getLanguageList(), removeArr));
		removeArr.clear();

		// 자격증
		for (SocietyStuApplyLicense license : ssaLicense.getLicenseList()) {
			if (license.getStu_app_license_nm().trim().equals(""))
				removeArr.add(ssaLicense.getLicenseList().indexOf(license));
		}
		ssaLicense.setLicenseList(removeEmptyList(ssaLicense.getLicenseList(), removeArr));
		removeArr.clear();

		// 본 과정 응시여부
		for (SocietyStuApplySes ses : ssaSes.getSesList()) {
			if(ses.getStu_app_ses_ck() == null){
				//if(ses.getStu_app_ses_apply_rt() == null || ses.getStu_app_ses_apply_rt().trim().equals(""))
					removeArr.add(ssaSes.getSesList().indexOf(ses));
			}
		}
		ssaSes.setSesList(removeEmptyList(ssaSes.getSesList(), removeArr));
		removeArr.clear();

		// K-MOVE 참가여부
		for (SocietyStuApplyKmove kmove : ssaKmove.getKmoveList()) {
			if(kmove.getStu_app_kmove_ck() == null)
				removeArr.add(ssaKmove.getKmoveList().indexOf(kmove));
		}
		ssaKmove.setKmoveList(removeEmptyList(ssaKmove.getKmoveList(), removeArr));
		removeArr.clear();
		
		// 해외경험
		for (SocietyStuApplyOverseas overseas : ssaOverseas.getOverseasList()) {
			if(overseas.getStu_app_overseas_ck() == null)
				removeArr.add(ssaOverseas.getOverseasList().indexOf(overseas));
		}
		ssaOverseas.setOverseasList(removeEmptyList(ssaOverseas.getOverseasList(), removeArr));
		removeArr.clear();

		// 자기소개
		for (SocietyStuApplyIntroduce introduce : ssaIntroduce.getIntroduceList()) {
			if (introduce.getStu_app_introduce_title().trim().equals(""))
				removeArr.add(ssaIntroduce.getIntroduceList().indexOf(introduce));
		}
		ssaIntroduce.setIntroduceList(removeEmptyList(ssaIntroduce.getIntroduceList(), removeArr));
		removeArr.clear();
	}
	
	/**
	 * @Method Name : removeEmptyList
	 * @Date : 2020. 8. 5.
	 * @User : 김성미
	 * @Param : 빈 리스트 제거할 리스트 , 제거 리스트 인덱스 리스트
	 * @Return : 빈 리스트 제거된 리스트
	 * @Method 설명 : 화면으로 부터 받은 리스트 정보에 비어있는 리스트를 제거하는 함수
	 */
	private <T> List<T> removeEmptyList(List<T> list, ArrayList<Integer> removeArr) {
		// 내림차순 정렬(오름차순 -> 역정렬)
		Collections.sort(removeArr);
		Collections.reverse(removeArr);

		// 비어있는 리스트 제거
		for (Integer index : removeArr) list.remove(index.intValue());
		return list;
	}
	
	// (나의 강의실 - 지원현황) 지원현황 목록 조회 
	public ArrayList<HashMap<String, Object>> selectApplyResult(String user_id) {
		return ssaDao.selectApplyResult(user_id);
	}

	public User selectUserById(String loginId) {
		return ssaDao.selectUserById(loginId);
	}
	
}
