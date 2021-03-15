package global.segroup.society.smp.admin.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import global.segroup.domain.BoardContent;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculumGisu;
import global.segroup.society.edu.admin.service.SocietyEduAdminService;
import global.segroup.society.edu.apply.domain.SocietyEduApplyForm;
import global.segroup.society.smp.admin.dao.SocietySmpAdminDAO;
import global.segroup.society.smp.admin.domain.SocietySmpApsDetail;
import global.segroup.society.smp.admin.domain.SocietySmpApsDetailExam;
import global.segroup.society.smp.admin.domain.SocietySmpApsDetailSubexam;
import global.segroup.society.smp.admin.domain.SocietySmpApsGroup;
import global.segroup.society.smp.admin.domain.SocietySmpApsGroupConfirmation;
import global.segroup.society.smp.admin.domain.SocietySmpApsGroupExam;
import global.segroup.society.smp.admin.domain.SocietySmpApsGroupSubexam;
import global.segroup.society.smp.admin.domain.SocietySmpApsSetDetail;
import global.segroup.society.smp.admin.domain.SocietySmpApsSetGroup;
import global.segroup.society.smp.admin.domain.SocietySmpApsSetList;
import global.segroup.society.smp.admin.domain.SocietySmpApsSetTotal;
import global.segroup.society.smp.admin.domain.SocietySmpApsTotal;
import global.segroup.society.smp.admin.domain.SocietySmpSchedule;
import global.segroup.society.smp.admin.domain.SocietySmpScheduleColor;
import global.segroup.society.smp.admin.domain.SocietySmpScheduleScheduleColor;
import global.segroup.society.smp.admin.domain.SocietySmpStudentCareer;
import global.segroup.society.smp.admin.domain.SocietySmpStudentEduHistory;
import global.segroup.society.smp.admin.domain.SocietySmpStudentFile;
import global.segroup.society.smp.admin.domain.SocietySmpStudentForm;
import global.segroup.society.smp.admin.domain.SocietySmpStudentLanguage;
import global.segroup.society.smp.admin.domain.SocietySmpStudentLicense;
import global.segroup.society.smp.admin.domain.SocietySmpStudentOverseas;
import global.segroup.society.smp.admin.domain.SocietySmpStudentStudy;
import global.segroup.util.FileService;

/**
 * @Author : 여명환
 * @Date : 2018. 8. 21.
 * @Class 설명 : Soft Engineer Society 학사관리 서비스
 * 
 */
@Service
public class SocietySmpAdminService {

	private static final Logger logger = LoggerFactory.getLogger(SocietyEduAdminService.class);

	/**
	 * file.propertices 의 등록된 지원신청서 증명사진 경로
	 */
	@Value("#{props['smp.student.photo']}")
	private String smpStudentPhotoPath;

	/**
	 * file.propertices 의 등록된 지원신청서 최종 학력증명서 경로
	 */
	@Value("#{props['smp.student.edu_history']}")
	private String smpStudentEduHistoryPath;

	/**
	 * file.propertices 의 등록된 지원신청서 고용보험 상실확인 경로
	 */
	@Value("#{props['smp.student.insurance']}")
	private String smpStudentInsurancePath;

	/**
	 * file.propertices 의 등록된 지원신청서 출입국 사실증명서 경로
	 */
	@Value("#{props['smp.student.immigration']}")
	private String smpStudentImmgrationPath;

	/**
	 * file.propertices 의 등록된 지원신청서 기타 파일 경로
	 */
	@Value("#{props['smp.student.etc']}")
	private String smpStudentEtcPath;

	@Autowired
	private SocietySmpAdminDAO ssaDAO;

	/**
	 * @Method Name : smp_manager_select_count
	 * @Date : 2018. 8. 19.
	 * @User : 여명환
	 * @Param : 기수 시퀀스, 이름
	 * @Return : 해당 기수의 신청자 count
	 * @Method 설명 : 특정 기수의 신청자 count를 조회하는 서비스 함수
	 */
	public int smp_manager_select_count(HashMap<String, Object> map) {
		logger.debug("특정 기수의 신청자 정보들을 조회하는 서비스 시작");
		logger.debug("특정 기수의 신청자 정보들을 조회하는 서비스 종료");
		return ssaDAO.smp_manager_select_count(map);
	}

	/**
	 * @Method Name : smp_student_select
	 * @Date : 2018. 8. 19.
	 * @User : 여명환
	 * @Param : 기수 시퀀스, 검색어, 페이징객체
	 * @Return : 해당 기수의 학생 정보들 리스트 객체
	 * @Method 설명 : 특정 기수의 학생 정보들을 조회하는 서비스 함수
	 */

	public ArrayList<HashMap<String, Object>> smp_student_select(HashMap<String, Object> map) {
		logger.debug("특정 기수의 학생 정보들을 조회하는 서비스 시작");
		logger.debug("특정 기수의 학생 정보들을 조회하는 서비스 종료");
		return ssaDAO.smp_student_select(map);
	}

	/**
	 * @Method Name : smp_copy_studentinfo
	 * @Date : 2018. 8. 19.
	 * @User : 여명환
	 * @Param : 기수 시퀀스, 검색어, 페이징객체
	 * @Return : 해당 기수의 학생 정보들 리스트 객체
	 * @Method 설명 : 특정 기수의 학생 정보들을 조회하는 서비스 함수
	 */

	public void smp_copy_studentinfo(int app_seq) {
		logger.debug("특정 기수의 학생 정보들을 조회하는 서비스 시작");
		ssaDAO.smp_copy_studentinfo(app_seq);
		logger.debug("특정 기수의 학생 정보들을 조회하는 서비스 종료");
	}

	/**
	 * @Method Name : selectSmpStudentUpdateForm
	 * @Date : 2018. 8. 23.
	 * @User : 여명환
	 * @Param :
	 * @Return :
	 * @Method 설명 :
	 */
	public HashMap<String, Object> selectSmpStudentUpdateForm(HashMap<String, Object> map) {
		logger.debug("selectEduApplyForm 시작");
		HashMap<String, Object> result = ssaDAO.selectSmpStudentUpdateForm(map);
		logger.debug("selectEduApplyForm 종료");
		return result;
	}

	/**
	 * @Method Name : smp_delete
	 * @Date : 2018. 8. 23.
	 * @User : 여명환
	 * @Param : 학생정보 시퀀스
	 * @Return : -
	 * @Method 설명 : 해당 지원신청서 정보를 삭제하는 서비스 함수
	 */
	public void smp_delete(int smp_seq) {
		logger.debug("모집홍보 특정 회원 정보 삭제 서비스 시작");

		ssaDAO.deleteSmpStudentForm(smp_seq);

		logger.debug("모집홍보 특정 회원 정보 삭제 서비스 종료");
	}

	/**
	 * @Method Name : smp_insert
	 * @Date : 2018. 8. 23.
	 * @User : 여명환
	 * @Param : SMART Cloud IT마스터 학생 정보(기본정보 , 학력, 경력, 교육이수, 언어능력, 자격증, 해외체류, 증빙자료)
	 * @Return : -
	 * @Method 설명 : 컨트롤러로 부터 전달 받은 학생 정보를 DAO로 전달.
	 */
	@Transactional
	public void smp_insert(SocietySmpStudentForm seaForm, SocietySmpStudentEduHistory seaEduHistory,
			SocietySmpStudentCareer seaCareer, SocietySmpStudentStudy seaStudy, SocietySmpStudentLanguage seaLanguage,
			SocietySmpStudentLicense seaLicense, SocietySmpStudentOverseas seaOverseas, SocietySmpStudentFile seaFile) {

		logger.debug("모집홍보 지원신청 서비스 시작");

		// 저장 fullPath
		String fullPath = "/" + seaForm.getApp_id() + "_" + String.valueOf(seaForm.getGisu_seq());

		// 지원신청서 증명사진 기존파일 삭제
		if (seaForm.getSmp_photo_origin() != null) {
			seaForm.setSmp_photo_origin(seaForm.getSmp_photo_origin());
			seaForm.setSmp_photo_saved(seaForm.getSmp_photo_saved());
		} else if (seaForm.getSmp_photo_saved() != null) {
			FileService.deleteFile(seaForm.getSmp_photo_saved(), smpStudentPhotoPath + fullPath);
		}
		// 지원신청서 증명사진 체크
		if (seaForm.getSmp_photo_file() != null && !seaForm.getSmp_photo_file().isEmpty()) {
			String photoOrigin = seaForm.getSmp_photo_file().getOriginalFilename();
			try {
				String photoSaved = FileService.saveFile(seaForm.getSmp_photo_file(), smpStudentPhotoPath + fullPath);
				seaForm.setSmp_photo_saved(photoSaved);
				seaForm.setSmp_photo_origin(photoOrigin);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			}
		}

		// 지원신청서 최종학력증명서 기존파일 삭제
		if (seaForm.getSmp_edu_file_origin() != null) {
			seaForm.setSmp_edu_file_origin(seaForm.getSmp_edu_file_origin());
			seaForm.setSmp_edu_file_saved(seaForm.getSmp_edu_file_saved());
		} else if (seaForm.getSmp_edu_file_saved() != null) {
			FileService.deleteFile(seaForm.getSmp_edu_file_saved(), smpStudentEduHistoryPath + fullPath);
		}
		// 지원신청서 최종학력증명서 체크
		if (seaForm.getSmp_edu_file() != null && !seaForm.getSmp_edu_file().isEmpty()) {
			String eduOrigin = seaForm.getSmp_edu_file().getOriginalFilename();
			try {
				String eduSaved = FileService.saveFile(seaForm.getSmp_edu_file(), smpStudentEduHistoryPath + fullPath);
				seaForm.setSmp_edu_file_saved(eduSaved);
				seaForm.setSmp_edu_file_origin(eduOrigin);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			}
		}

		// 지원신청서 고용보험 상실확인 기존파일 삭제
		if (seaForm.getSmp_isr_file_origin() != null) {
			seaForm.setSmp_isr_file_origin(seaForm.getSmp_isr_file_origin());
			seaForm.setSmp_isr_file_saved(seaForm.getSmp_isr_file_saved());
		} else if (seaForm.getSmp_isr_file_saved() != null) {
			FileService.deleteFile(seaForm.getSmp_isr_file_saved(), smpStudentInsurancePath + fullPath);
		}

		// 지원신청서 고용보험 상실확인 체크
		if (seaForm.getSmp_isr_file() != null && !seaForm.getSmp_isr_file().isEmpty()) {
			String isrOrigin = seaForm.getSmp_isr_file().getOriginalFilename();
			try {
				String isrSaved = FileService.saveFile(seaForm.getSmp_isr_file(), smpStudentInsurancePath + fullPath);
				seaForm.setSmp_isr_file_saved(isrSaved);
				seaForm.setSmp_isr_file_origin(isrOrigin);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			}
		}

		// 지원신청서 출입국 사실증명서 기존파일 삭제
		if (seaForm.getSmp_imm_file_origin() != null) {
			seaForm.setSmp_imm_file_origin(seaForm.getSmp_imm_file_origin());
			seaForm.setSmp_imm_file_saved(seaForm.getSmp_imm_file_saved());
		} else if (seaForm.getSmp_imm_file_saved() != null) {
			FileService.deleteFile(seaForm.getSmp_imm_file_saved(), smpStudentImmgrationPath + fullPath);
		}

		// 지원신청서 출입국 사실증명서 체크
		if (seaForm.getSmp_imm_file() != null && !seaForm.getSmp_imm_file().isEmpty()) {
			String immOrigin = seaForm.getSmp_imm_file().getOriginalFilename();
			try {
				String immSaved = FileService.saveFile(seaForm.getSmp_imm_file(), smpStudentImmgrationPath + fullPath);
				seaForm.setSmp_imm_file_saved(immSaved);
				seaForm.setSmp_imm_file_origin(immOrigin);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			}
		}

		// 지원신청서 기타 증빙자료 체크
		ArrayList<Integer> removeArr = new ArrayList<>();
		for (SocietySmpStudentFile fileObj : seaFile.getFileList()) {

			// 지원시청서 기타 증빙자료 기존파일 삭제
			if (fileObj.getSmp_file_origin() != null) {
				fileObj.setSmp_file_origin(fileObj.getSmp_file_origin());
				fileObj.setSmp_file_saved(fileObj.getSmp_file_saved());
			} else if (fileObj.getSmp_file_saved() != null) {
				FileService.deleteFile(fileObj.getSmp_file_saved(), smpStudentEtcPath + fullPath);
			}

			if (fileObj.getSmp_file() != null && !fileObj.getSmp_file().isEmpty()) {
				String etcOrigin = fileObj.getSmp_file().getOriginalFilename();
				try {
					String etcSaved = FileService.saveFile(fileObj.getSmp_file(), smpStudentEtcPath + fullPath);
					fileObj.setSmp_file_saved(etcSaved);
					fileObj.setSmp_file_origin(etcOrigin);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				}
			} else {
				if (fileObj.getSmp_file_origin() == null) {
					removeArr.add(seaFile.getFileList().indexOf(fileObj));
				}
			}
		}
		// 기타 증빙자료 빈 리스트 제거 후 인덱스 리스트 초기화
		seaFile.setFileList(removeEmptyList(seaFile.getFileList(), removeArr));
		removeArr.clear();

		// 학력정보 빈 리스트 체크
		for (SocietySmpStudentEduHistory eduHistory : seaEduHistory.getEduHistoryList()) {
			if (eduHistory.getSmp_edu_sc_nm().trim().equals("")) {
				removeArr.add(seaEduHistory.getEduHistoryList().indexOf(eduHistory));
			}
		}

		// 학력정보 빈 리스트 제거 후 인덱스 리스트 초기화
		seaEduHistory.setEduHistoryList(removeEmptyList(seaEduHistory.getEduHistoryList(), removeArr));
		removeArr.clear();

		// 경력정보 빈 리스트 체크
		for (SocietySmpStudentCareer career : seaCareer.getCareerList()) {
			if (career.getSmp_crr_place().trim().equals("")) {
				removeArr.add(seaCareer.getCareerList().indexOf(career));
			}
		}

		// 경력정보 빈 리스트 제거 후 인덱스 리스트 초기화
		seaCareer.setCareerList(removeEmptyList(seaCareer.getCareerList(), removeArr));
		removeArr.clear();

		// 교육이수 빈 리스트 체크
		for (SocietySmpStudentStudy study : seaStudy.getStudyList()) {
			if (study.getSmp_study_nm().trim().equals("")) {
				removeArr.add(seaStudy.getStudyList().indexOf(study));
			}
		}

		// 교육이수 빈 리스트 제거 후 인덱스 리스트 초기화
		seaStudy.setStudyList(removeEmptyList(seaStudy.getStudyList(), removeArr));
		removeArr.clear();

		// 언어능력 빈 리스트 체크
		for (SocietySmpStudentLanguage language : seaLanguage.getLanguageList()) {
			if (language.getSmp_lang_test_nm().trim().equals("")) {
				removeArr.add(seaLanguage.getLanguageList().indexOf(language));
			}
		}

		// 언어능력 빈 리스트 제거 후 인덱스 리스트 초기화
		seaLanguage.setLanguageList(removeEmptyList(seaLanguage.getLanguageList(), removeArr));
		removeArr.clear();

		// 자격증 빈 리스트 체크
		for (SocietySmpStudentLicense license : seaLicense.getLicenseList()) {
			if (license.getSmp_license_nm().trim().equals("")) {
				removeArr.add(seaLicense.getLicenseList().indexOf(license));
			}
		}

		// 자격증 빈 리스트 제거 후 인덱스 리스트 초기화
		seaLicense.setLicenseList(removeEmptyList(seaLicense.getLicenseList(), removeArr));
		removeArr.clear();

		// 해외체류 빈 리스트 체크
		for (SocietySmpStudentOverseas overseas : seaOverseas.getOverseasList()) {
			if (overseas.getSmp_overseas_nm().trim().equals("")) {
				removeArr.add(seaOverseas.getOverseasList().indexOf(overseas));
			}
		}

		// 해외체류 빈 리스트 제거 후 인덱스 리스트 초기화
		seaOverseas.setOverseasList(removeEmptyList(seaOverseas.getOverseasList(), removeArr));
		removeArr.clear();

		ssaDAO.smp_insert(seaForm, seaEduHistory, seaCareer, seaStudy, seaLanguage, seaLicense, seaOverseas, seaFile);

		logger.debug("모집홍보 지원신청 서비스 종료");
	}

	/**
	 * @Method Name : removeEmptyList
	 * @Date : 2018. 8. 23.
	 * @User : 여명환
	 * @Param : 빈 리스트 제거할 리스트 , 제거 리스트 인덱스 리스트
	 * @Return : 빈 리스트 제거된 리스트
	 * @Method 설명 : 화면으로 부터 받은 리스트 정보에 비어있는 리스트를 제거하는 함수
	 */
	private <T> List<T> removeEmptyList(List<T> list, ArrayList<Integer> removeArr) {
		// 내림차순 정렬(오름차순 -> 역정렬)
		Collections.sort(removeArr);
		Collections.reverse(removeArr);

		// 비어있는 리스트 제거
		for (Integer index : removeArr) {
			list.remove(index.intValue());
		}

		return list;
	}

	/**
	 * @Method Name : selectAllSocietySmpSchedule
	 * @Date : 2018. 8. 24.
	 * @User : 박찬주
	 * @Param : 기수 시퀀스
	 * @Return : 특정 기수의 일정 리스트
	 * @Method 설명 : 특정 기수의 일정 리스트를 컨트롤러에 전달하는 서비스 함수
	 */
	public List<SocietySmpScheduleScheduleColor> selectAllSocietySmpSchedule(int gisu_seq) {
		logger.debug("특정 기수의 일정 정보들을 조회하는 서비스 시작");
		logger.debug("특정 기수의 일정 정보들을 조회하는 서비스 종료");
		return ssaDAO.selectAllSocietySmpSchedule(gisu_seq);
	}

	/**
	 * @Method Name : deleteSocietySmpSchedule
	 * @Date : 2018. 8. 24.
	 * @User : 박찬주
	 * @Param : 일정 이벤트 시퀀스
	 * @Return : 삭제한 일정 이벤트 count
	 * @Method 설명 : 삭제한 일정 이벤트 count를 조회하는 서비스 함수
	 */
	public int deleteSocietySmpSchedule(int smp_sch_seq) {
		logger.debug("특정 일정 정보를 삭제하는 서비스 시작");
		logger.debug("특정 일정 정보를 삭제하는 서비스 종료");
		return ssaDAO.deleteSocietySmpSchedule(smp_sch_seq);
	}

	/**
	 * @Method Name : updateSocietySmpSchedule
	 * @Date : 2018. 8. 24.
	 * @User : 박찬주
	 * @Param : 일정 이벤트 객체
	 * @Return : 수정한 일정 이벤트 count
	 * @Method 설명 : 수정한 일정 이벤트 count를 조회하는 서비스 함수
	 */
	public int updateSocietySmpSchedule(SocietySmpScheduleScheduleColor sche) {
		logger.debug("특정 일정 정보를 수정하는 서비스 시작");
		logger.debug("특정 일정 정보를 수정하는 서비스 종료");
		return ssaDAO.updateSocietySmpSchedule(sche);
	}

	/**
	 * @Method Name : insertSocietySmpSchedule
	 * @Date : 2018. 8. 24.
	 * @User : 박찬주
	 * @Param : 일정 이벤트 객체
	 * @Return : 입력한 일정 이벤트 count
	 * @Method 설명 : 입력한 일정 이벤트 count를 조회하는 서비스 함수
	 */
	public int insertSocietySmpSchedule(SocietySmpScheduleScheduleColor sche) {
		logger.debug("특정 일정 정보를 입력하는 서비스 시작");
		logger.debug("특정 일정 정보를 입력하는 서비스 종료");
		return ssaDAO.insertSocietySmpSchedule(sche);
	}

	/**
	 * @Method Name : monthEventSelect
	 * @Date : 2018. 8. 24.
	 * @User : 박찬주
	 * @Param :일정 이벤트 객체
	 * @Return : 특정 기수의 월별 일정 이벤트 리스트
	 * @Method 설명 : 특정 기수의 월별 일정 리스트를 컨트롤러에 전달하는 서비스 함수
	 */
	public List<SocietySmpScheduleScheduleColor> monthEventSelect(SocietySmpSchedule sche) {
		logger.debug("특정 기수의 월별 일정 정보를 조회하는 서비스 시작");
		logger.debug("특정 기수의 월별 일정 정보를 조회하는 서비스 종료");
		return ssaDAO.monthEventSelect(sche);
	}

	/**
	 * @Method Name : selectSocietySmpUserGisu
	 * @Date : 2018. 8. 29.
	 * @User : 박찬주
	 * @Param : 학생 아이디
	 * @Return : 특정 학생의 기수
	 * @Method 설명 : 특정 학생의 기수를 컨트롤러에 전달하는 서비스 함수
	 */
	public SocietyEduAdminCurriculumGisu selectSocietySmpUserGisuNum(String app_id) {
		logger.debug("특정 학생의 기수 정보를 조회하는 서비스 시작");
		logger.debug("특정 학생의 기수 정보를 조회하는 서비스 종료");
		return ssaDAO.selectSocietySmpUserGisuNum(app_id);
	}

	/**
	 * @Method Name : selectGisuSeqNumList
	 * @Date : 2018. 8. 30.
	 * @User : 박찬주
	 * @Param : -
	 * @Return : smart cloud it마스터 과정의 전체 기수정보 리스트
	 * @Method 설명 : smart cloud it마스터 과정의 전체 기수정보 리스트를 컨트롤러에 전달하는 서비스 함수
	 */
	public List<SocietyEduAdminCurriculumGisu> selectGisuSeqNumList() {
		logger.debug("smart cloud it마스터 과정의 전체 기수 정보를 조회하는 서비스 시작");
		logger.debug("smart cloud it마스터 과정의 전체 기수 정보를 조회하는 서비스 종료");
		return ssaDAO.selectGisuSeqNumList();

	}

	/**
	 * @Method Name : selectGisuNum
	 * @Date : 2018. 8. 30.
	 * @User : 박찬주
	 * @Param : 기수 시퀀스
	 * @Return : 기수 넘버
	 * @Method 설명 : 기수 시퀀스에 따른 기수 넘버를 컨트롤러에 전달하는 서비스 함수
	 */
	public int selectGisuNum(int gisu_seq) {
		logger.debug("기수 시퀀스에 따른 기수 넘버를 조회하는 서비스 시작");
		logger.debug("기수 시퀀스에 따른 기수 넘버를 조회하는 서비스 종료");
		return ssaDAO.selectGisuNum(gisu_seq);

	}

	public List<SocietySmpScheduleColor> gisuTitleCheck(int gisu_seq) {
		return ssaDAO.gisuTitleCheck(gisu_seq);
	}

	public int schColorInsert(List<SocietySmpScheduleColor> lssSchColor) {
		return ssaDAO.schColorInsert(lssSchColor);
	}

	public int schColorUpdate(SocietySmpScheduleColor ssSchColor) {
		return ssaDAO.schColorUpdate(ssSchColor);
	}

	public int schColorDelete(int smp_sch_color_seq) {
		return ssaDAO.schColorDelete(smp_sch_color_seq);
	}

	/**
	 * @Method Name : board_contents_insert
	 * @Date : 2018. 08. 28.
	 * @User : 전희배
	 * @Param : 게시글 세부내용
	 * @Return : -
	 * @Method 설명 : 게시글을 등록하는 서비스 함수
	 */
	public void smp_board_contents_insert(BoardContent boardContent) {
		logger.debug("게시글 세부 내용 등록 서비스 함수 시작");

		ssaDAO.smp_board_contents_insert(boardContent);

		logger.debug("게시글 세부 내용 등록 서비스 함수 종료");

	}

	/**
	 * @Method Name : smp_select_admin_nm
	 * @Date : 2018. 08. 28.
	 * @User : 전희배
	 * @Param : admin_ids
	 * @Return : admin_nm
	 * @Method 설명 :
	 */
	public String smp_select_admin_nm(String admin_id) {

		return ssaDAO.smp_select_admin_nm(admin_id);

	}

	/**
	 * @Method Name : smp_board_contents_update
	 * @Date : 2018. 08. 30.
	 * @User : 전희배
	 * @Param : 게시글 세부내용
	 * @Return : -
	 * @Method 설명 : 게시글을 수정하는 서비스 함수
	 */
	public void smp_board_contents_update(BoardContent boardContent) {
		logger.debug("게시글 세부 내용 수정 서비스 함수 시작");

		ssaDAO.smp_board_contents_update(boardContent);

		logger.debug("게시글 세부 내용 수정 서비스 함수 종료");
	}

	/**
	 * @Method Name : dataModify
	 * @Date : 2018. 8. 27.
	 * @User : 여명환
	 * @Param : 학생 데이터
	 * @Return : 학생 데이터
	 * @Method 설명 : 학생 데이터를 가공해서 리턴(나이(만), 출생년도, 최종학력, 어학수준, 정보처리기사)
	 */
	public ArrayList<HashMap<String, Object>> dataModify(ArrayList<HashMap<String, Object>> resultList) {
		ArrayList<HashMap<String, Object>> languageList = null;
		ArrayList<HashMap<String, Object>> eduHistoryList = null;
		ArrayList<HashMap<String, Object>> licenseList = null;
		Calendar calendar = new GregorianCalendar(Locale.KOREA);
		int nYear = calendar.get(Calendar.YEAR);
		int nMonth = calendar.get(Calendar.MONTH) + 1;
		int nDay = calendar.get(Calendar.DAY_OF_MONTH);
		int index = 0;
		String otherLang = "";
		for (int i = 0; i < resultList.size(); i++) {

			String userBirth = (String) resultList.get(i).get("user_birth");
			String finalEduGdDt = null;

			finalEduGdDt = "1900-01-01";

			String birthYear = userBirth.substring(0, 4);
			String birthMonth = userBirth.substring(5, 7);
			String birthDay = userBirth.substring(8, 10);
			int userAge = nYear - Integer.parseInt(birthYear);
			resultList.get(i).put("birthYear", birthYear);
			resultList.get(i).put("userAge", userAge);
			// 생일 안 지난 경우 -1컨트롤러 이미지전달
			if (Integer.parseInt(birthMonth) * 100 + Integer.parseInt(birthDay) > nMonth * 100 + nDay)
				userAge--;

			String old_phone = (String) resultList.get(i).get("user_phone"); // 전화번호에 '-' 넣기
			String new_phone = old_phone.substring(0, 3);
			new_phone += '-';
			new_phone += old_phone.substring(3, 7);
			new_phone += '-';
			new_phone += old_phone.substring(7, 11);
			resultList.get(i).get("user_phone");
			resultList.get(i).put("user_phone", new_phone);

			languageList = (ArrayList<HashMap<String, Object>>) resultList.get(i).get("languageList");
			eduHistoryList = (ArrayList<HashMap<String, Object>>) resultList.get(i).get("eduHistoryList");
			licenseList = (ArrayList<HashMap<String, Object>>) resultList.get(i).get("licenseList");

			resultList.get(i).put("cLicense", "");
			resultList.get(i).put("Japanese", "");

			for (int j = 0; j < languageList.size(); j++) {
				if (languageList.get(j).get("smp_lang_test_nm").equals("JLPT")
						|| languageList.get(j).get("smp_lang_test_nm").equals("JPT")) {
					resultList.get(i).put("Japanese", languageList.get(j).get("smp_lang_test_nm") + " "
							+ languageList.get(j).get("smp_lang_grade"));
					languageList.get(j).clear();
				} else {
					// 기타어휘
					otherLang = otherLang + (String) languageList.get(j).get("smp_lang_test_nm") + " ";
				}
			} // 일본어 자격증 찾기
			resultList.get(i).put("otherLang", otherLang);
			otherLang = "";
			for (int j = 0; j < licenseList.size(); j++) {
				String license = (String) licenseList.get(j).get("smp_license_nm");
				license.trim();
				if (license.equals("정보처리기사") || license.equals("정보처리산업기사") || license.equals("정보처리")) {
					if (!license.equals("정보처리")) {
						resultList.get(i).put("cLicense", licenseList.get(j).get("smp_license_nm"));
					} else {
						resultList.get(i).put("cLicense", licenseList.get(j).get("smp_license_nm") + " "
								+ licenseList.get(j).get("smp_license_grade"));
					}
					licenseList.get(j).clear();
				} // 정보처리기사 자격증 찾기
			}
			if (!eduHistoryList.isEmpty()) {
				for (int j = 0; j < eduHistoryList.size(); j++) {
					int compare = finalEduGdDt.compareTo((String) eduHistoryList.get(j).get("smp_edu_gd_dt"));
					if (compare < 0) {
						index = j;
					} // 최종학력찾기
				}
				resultList.get(i).put("finalEduNm", eduHistoryList.get(index).get("smp_edu_sc_nm"));
				resultList.get(i).put("finalEduMajor", eduHistoryList.get(index).get("smp_edu_major"));
				resultList.get(i).put("finalEduGdCheck", eduHistoryList.get(index).get("smp_edu_gd_ck"));
				resultList.get(i).put("finalEduGdRq", eduHistoryList.get(index).get("smp_edu_gd_rq"));
			}
			index = 0;
		}
		return resultList;
	}

	/**
	 * @Method Name : printCourse()
	 * @Date : 2018. 08. 30.
	 * @User : 여명환
	 * @Param :
	 * @Return :
	 * @Method 설명 : 프린트 하기 위해 학생의 필요정보 조회
	 */
	public HashMap<String, Object> smp_select_print_student(String app_id) {
		return ssaDAO.smp_select_print_student(app_id);
	}

	/**
	 * @Method Name : get_specific_user_gisu
	 * @Date : 2018. 08. 31.
	 * @User : 김진환
	 * @Param : userId
	 * @Return : gisu_seq
	 * @Method 설명 :
	 */
	public SocietyEduAdminCurriculumGisu get_specific_user_gisu(String id) {

		return ssaDAO.get_specific_user_gisu(id);
	}

	/**
	 * @Method Name : smp_copy_studentinfo
	 * @Date : 2018. 8. 19.
	 * @User : 여명환
	 * @Param : 기수 시퀀스, 검색어, 페이징객체
	 * @Return : 해당 기수의 학생 정보들 리스트 객체
	 * @Method 설명 : 특정 기수의 학생 정보들을 조회하는 서비스 함수
	 */

	public int smp_check_student(SocietyEduApplyForm sf) {
		logger.debug("특정 기수의 학생 정보들을 조회하는 서비스 시작");
		int result = ssaDAO.smp_check_student(sf);
		logger.debug("특정 기수의 학생 정보들을 조회하는 서비스 종료");
		return result;
	}

	/**
	 * @Method Name : board_gisu_search
	 * @Date : 2018. 09. 04.
	 * @User : 전희배
	 * @Param : 기수이름
	 * @Return : board_num, board_seq
	 * @Method 설명 : 특정 기수의 게시판 정보를 조회하는 서비스 함수
	 */

	public ArrayList<HashMap<String, Object>> board_gisu_search() {
		logger.debug("특정 기수의 게시판 정보를 조회하는 서비스 시작");
		ArrayList<HashMap<String, Object>> result = ssaDAO.board_gisu_search();
		logger.debug("특정 기수의 게시판 정보를 조회하는 서비스 종료");
		return result;
	}

	/**
	 * @Method Name : smpBoardListAll
	 * @Date : 2018. 09. 04.
	 * @User : 전희배
	 * @Param :
	 * @Return :
	 * @Method 설명 : 게시물 조회 하는 서비스 함수
	 */
	public List<HashMap<String, Object>> smpBoardListAll(RowBounds rb, String searchOption, String keyword, String boardSeq,
			String gisu_seq) {
		logger.debug("특정 기수의 게시판 정보를 조회하는 서비스 시작");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("searchOption", searchOption);
		param.put("keyword", keyword);
		param.put("boardSeq", boardSeq);
		param.put("gisu_seq", gisu_seq);
		logger.debug("특정 기수의 게시판 정보를 조회하는 서비스 시작");
		return ssaDAO.smpBoardListAll(rb, param);
	}

	/**
	 * @Method Name : gettotal
	 * @Date : 2018. 09. 04.
	 * @User : 전희배
	 * @Param :
	 * @Return :
	 * @Method 설명 : 게시물 개수를 조회하는 서비스 함수
	 */
	public int gettotal(String searchOption, String keyword, String boardSeq, String gisu_seq) {
		logger.debug(" 게시물 개수를 조회하는 서비스 시작");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("searchOption", searchOption);
		param.put("keyword", keyword);
		param.put("boardSeq", boardSeq);
		param.put("gisu_seq", gisu_seq);
		logger.debug(" 게시물 개수를 조회하는 서비스 시작");
		return ssaDAO.gettotal(param);
	}

	/**
	 * @Method Name : insertBoardGisu
	 * @Date : 2018. 09. 04.
	 * @User : 전희배
	 * @Param :
	 * @Return :
	 * @Method 설명 : 게시판 기수 등록하는 서비스 함수
	 */
	public void insertBoardGisu(String board_content_seq, String gisu_seq) {
		logger.debug("게시판 기수 등록하는 서비스 시작");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("board_content_seq", board_content_seq);
		param.put("gisu_seq", gisu_seq);
		logger.debug("게시판 기수 등록하는 서비스 시작");
		ssaDAO.insertBoardGisu(param);
	}

	/**
	 * @Method Name : smpMainBoardListAll
	 * @Date : 2018. 09. 05.
	 * @User : 여명환
	 * @Param :
	 * @Return :
	 * @Method 설명 : 주요공지 조회
	 */
	public List<HashMap<String, Object>> smpMainBoardListAll(String searchOption, String keyword, String boardSeq, String gisu_seq) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("searchOption", searchOption);
		param.put("keyword", keyword);
		param.put("boardSeq", boardSeq);
		param.put("gisu_seq", gisu_seq);
		return ssaDAO.smpMainBoardListAll(param);
	}

	/**
	 * @Method Name : smp_board_delete
	 * @Date : 2018. 09. 05.
	 * @User : 여명환
	 * @Param :
	 * @Return :
	 * @Method 설명 : 공지삭제
	 */
	public void smp_board_delete(int board_content_seq) {
		ssaDAO.smp_board_delete(board_content_seq);
	}

	/**
	 * @Method Name : selectMainPageBoard
	 * @Date : 2018. 09. 05.
	 * @User : 여명환
	 * @Param :
	 * @Return :
	 * @Method 설명 : 공지삭제
	 */
	public ArrayList<BoardContent> selectMainPageBoard(int gisu_seq) {
		return ssaDAO.selectMainPageBoard(gisu_seq);
	}

	/**
	 * @Method Name : selectSmpNumberOfStudent
	 * @Date : 2018. 09. 05.
	 * @User : 여명환
	 * @Param :
	 * @Return :
	 * @Method 설명 : smp학생수 조회
	 */
	public int selectSmpNumberOfStudent() {
		return ssaDAO.selectSmpNumberOfStudent();
	}

	/**
	 * @Method Name : smp_insert_memo
	 * @Date : 2018. 09. 07.
	 * @User : 여명환
	 * @Param :
	 * @Return :
	 * @Method 설명 : 학적부 메모 삽입
	 */
	public void smp_insert_memo(HashMap<String, Object> memo) {
		ssaDAO.smp_insert_memo(memo);
	}

	/**
	 * @Method Name : smp_select_memo
	 * @Date : 2018. 09. 07.
	 * @User : 여명환
	 * @Param :
	 * @Return :
	 * @Method 설명 : 학적부 메모 삽입
	 */
	public String smp_select_memo(String memo) {
		return ssaDAO.smp_select_memo(memo);
	}

	/**
	 * @Method Name : selectApsTotalNm
	 * @Date : 2018. 09. 10.
	 * @User : 전희배
	 * @Param :
	 * @Return :
	 * @Method 설명 : aps_total의 시퀀스, 이름 select
	 */
	public List<HashMap<String, Object>> selectApsTotalNm(int gisu_seq) {
		return ssaDAO.selectApsTotalNm(gisu_seq);
	}

	/**
	 * @Method Name : selectApsGroupNm
	 * @Date : 2018. 09. 10.
	 * @User : 전희배
	 * @Param :
	 * @Return :
	 * @Method 설명 : aps_group의 시퀀스, 이름 select
	 */
	public List<HashMap<String, Object>> selectApsGroupNm(int gisu_seq) {
		return ssaDAO.selectApsGroupNm(gisu_seq);
	}

	/**
	 * @Method Name : selectApsDetailNm
	 * @Date : 2018. 09. 10.
	 * @User : 전희배
	 * @Param :
	 * @Return :
	 * @Method 설명 : aps_detail의 시퀀스, 이름 select
	 */
	public List<HashMap<String, Object>> selectApsDetailNm(int gisu_seq) {
		return ssaDAO.selectApsDetailNm(gisu_seq);
	}

	/**
	 * @Method Name : getApsTotal
	 * @Date : 2018. 09. 10.
	 * @User : 여명환
	 * @Param :
	 * @Return : ApsTotal정보
	 * @Method 설명 : 종합평가 정보 리턴
	 */
	public ArrayList<String> getApsTotal() {
		return ssaDAO.getApsTotal();
	}

	/**
	 * @Method Name : getApsGroup
	 * @Date : 2018. 09. 10.
	 * @User : 여명환
	 * @Param :
	 * @Return : ApsGroup 정보
	 * @Method 설명 : 그룹평가 정보 리턴
	 */
	/*public ArrayList<String> getApsGroup() {
		return ssaDAO.getApsGroup();
	}*/

	/**
	 * @Method Name : getApsDetail
	 * @Date : 2018. 09. 10.
	 * @User : 여명환
	 * @Param :
	 * @Return : ApsDetail 정보
	 * @Method 설명 : 개별평가 정보 리턴
	 */
	public ArrayList<String> getApsDetail() {
		return ssaDAO.getApsDetail();
	}
	/**
	 * @Method Name : selectGisuNumberOfTotal
	 * @Date : 2018. 09. 11.
	 * @User : 여명환
	 * @Param : 
	 * @Return : 종합평가 기수별 수 정보
	 * @Method 설명 : 갯수 리턴
	 */
	public int selectGisuNumberOfTotal(int gisu_seq) {
		return ssaDAO.selectGisuNumberOfTotal(gisu_seq);
	}
	/**
	 * @Method Name : selectGisuNumberOfGroup
	 * @Date : 2018. 09. 11.
	 * @User : 여명환
	 * @Param : 
	 * @Return : 그룹평가 기수별 수 정보
	 * @Method 설명 : 갯수 리턴
	 */
	public int selectGisuNumberOfGroup(String gisu_seq) {
		return ssaDAO.selectGisuNumberOfGroup(gisu_seq);
	}
	/**
	 * @Method Name : selectGisuNumberOfDetail
	 * @Date : 2018. 09. 11.
	 * @User : 여명환
	 * @Param : 
	 * @Return : 상세평가 기수별 수 정보
	 * @Method 설명 : 갯수 리턴
	 */
	public int selectGisuNumberOfDetail(String gisu_seq) {
		return ssaDAO.selectGisuNumberOfDetail(gisu_seq);
	}
	
	/**
	 * @Method Name : selectAPSTotal
	 * @Date : 2018. 09. 07.
	 * @User : 여명환
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 학적부 메모 삽입
	 */
	public ArrayList<HashMap<String, Object>> selectAPSTotal(int gisu_seq) {
		return ssaDAO.selectAPSTotal(gisu_seq);
	}
	
	/**
	 * @Method Name : selectAPSGroup
	 * @Date : 2019. 02. 21.
	 * @User : 김홍일
	 * @Param :  
	 * @Return : 
	 * @Method 설명 :기수 값에 따른 그룹평가 리스트 전체 
	 */
	public ArrayList<HashMap<String, Object>> selectAPSGroup(int gisu_seq) {
		return ssaDAO.selectAPSGroup(gisu_seq);
	}
	
	/**
	 * @Method Name : selectAPSGroup
	 * @Date : 2019. 02. 28.
	 * @User : 김홍일
	 * @Param :  
	 * @Return : 
	 * @Method 설명 :기수 값에 따른 상세평가 리스트 전체 
	 */
	public ArrayList<HashMap<String, Object>> selectAPSDetail(int smp_aps_total_seq) {
		return ssaDAO.selectAPSDetail(smp_aps_total_seq);
	}
	
	/**
	 * @Method Name : selectAPSDetail
	 * @Date : 2018. 09. 07.
	 * @User : 여명환
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 학적부 메모 삽입
	 */
	/*public ArrayList<HashMap<String, Object>> selectAPSDetail(HashMap<String, Object> map) {
		return ssaDAO.selectAPSDetail(map);
	}*/
	
	
	/**
	 * @Method Name : deleteTotal
	 * @Date : 2018. 09. 11.
	 * @User : 여명환
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 종합평가 정보 삭제
	 */
	public void deleteTotal(String smp_aps_total_seq) {
		ssaDAO.deleteTotal(smp_aps_total_seq);
	}
	
	/**
	 * @Method Name : deleteGroup
	 * @Date : 2018. 09. 11.
	 * @User : 여명환
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 그룹평가 정보 삭제
	 */
	public void deleteGroup(String smp_aps_group_seq) {
		ssaDAO.deleteGroup(smp_aps_group_seq);
	}
	
	/**
	 * @Method Name : deleteDetail
	 * @Date : 2018. 09. 11.
	 * @User : 여명환
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 상세평가 정보 삭제
	 */
	public void deleteDetail(String smp_aps_detail_seq) {
		ssaDAO.deleteDetail(smp_aps_detail_seq);
	}

	/**
	 * @Method Name : SmpApsTotal
	 * @Date : 2018. 09. 11.
	 * @User : 강인석
	 * @Param :
	 * @Return :
	 * @Method 설명 : 평가항목 전체 서비스
	 */

	public void insertSmpApsTotal(int gisu_seq, String smp_aps_total_nm, int smp_aps_total_ratio, String smp_aps_total_ins_id,
			String smp_aps_total_udt_id, String smp_aps_total_ct) {
		logger.debug("평가항목 전체 서비스 시작");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("gisu_seq", gisu_seq);
		param.put("smp_aps_total_nm", smp_aps_total_nm);
		param.put("smp_aps_total_ratio", smp_aps_total_ratio);
		param.put("smp_aps_total_ins_id", smp_aps_total_ins_id);
		param.put("smp_aps_total_udt_id", smp_aps_total_udt_id);
		param.put("smp_aps_total_ct", smp_aps_total_ct);
		logger.debug("평가항목 전체 서비스 시작");
		ssaDAO.insertSmpApsTotal(param);
	}

	/**
	 * @Method Name : SmpApsGroup
	 * @Date : 2018. 01. 17.
	 * @User : 김홍일
	 * @Param :
	 * @Return :
	 * @Method 설명 : 그룹항목 그룹 타입 서비스
	 */

	public void insertSmpApsGroup(SocietySmpApsGroup societySmpApsGroup){
		logger.debug("평가항목 그룹 타입 서비스 시작");
		
		SocietySmpApsGroup param_group = new SocietySmpApsGroup();
		param_group = societySmpApsGroup;
		
		ssaDAO.insertSmpApsGroup(param_group);
	}
	
	/**
	 * @Method Name : SmpApsGroup
	 * @Date : 2018. 01. 18.
	 * @User : 김홍일
	 * @Param :
	 * @Return :
	 * @Method 설명 : 그룹항목 정규시험 그룹 서비스
	 */
	
	public void insertSmpApsGroupExam(SocietySmpApsGroupExam societySmpApsGroupExam) {
		logger.debug("평가항목 정규시험 그룹 서비스 시작");
		SocietySmpApsGroupExam param_group_exam = new SocietySmpApsGroupExam();
		param_group_exam = societySmpApsGroupExam;
		
		ssaDAO.insertSmpApsGroupExam(param_group_exam);
	}
	
	/**
	 * @Method Name : SmpApsGroup
	 * @Date : 2018. 01. 18.
	 * @User : 김홍일
	 * @Param :
	 * @Return :
	 * @Method 설명 : 그룹항목 과목평가 그룹 서비스
	 */
	
	public void insertSmpApsGroupSubexam(SocietySmpApsGroupSubexam societySmpApsGroupSubexam) {
		logger.debug("평가항목 정규시험 그룹 서비스 시작");
		SocietySmpApsGroupSubexam param_group_subexam = new SocietySmpApsGroupSubexam();
		param_group_subexam = societySmpApsGroupSubexam;
		
		ssaDAO.insertSmpApsGroupSubexam(param_group_subexam);
	}
	
	/**
	 * @Method Name : SmpApsGroup
	 * @Date : 2018. 01. 18.
	 * @User : 김홍일
	 * @Param :
	 * @Return :
	 * @Method 설명 : 그룹항목 개별점수 및 확인서 그룹 서비스
	 */
	
	public void insertSmpApsGroupConfirmation(SocietySmpApsGroupConfirmation societySmpApsGroupConfirmation) {
		logger.debug("평가항목 정규시험 그룹 서비스 시작");
		SocietySmpApsGroupConfirmation param_group_confirmation = new SocietySmpApsGroupConfirmation();
		param_group_confirmation = societySmpApsGroupConfirmation;
		
		ssaDAO.insertSmpApsGroupConfirmation(param_group_confirmation);
	}

	/**
	 * @Method Name : SmpApsDetail
	 * @Date : 2018. 09. 11.
	 * @User : 강인석
	 * @Param :
	 * @Return :
	 * @Method 설명 : 상세항목 세부 서비스
	 */
	
	public void insertSmpApsDetail(int smp_aps_group_seq, String smp_aps_detail_nm, int smp_aps_detail_ratio,
		String smp_aps_detail_ins_id, String smp_aps_detail_udt_id ,String smp_aps_detail_ct) {
		logger.debug("평가항목 세부 서비스 시작");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("smp_aps_group_seq", smp_aps_group_seq);
		param.put("smp_aps_detail_nm", smp_aps_detail_nm);
		param.put("smp_aps_detail_ratio", smp_aps_detail_ratio);
		param.put("smp_aps_detail_ins_id", smp_aps_detail_ins_id);
		param.put("smp_aps_detail_udt_id", smp_aps_detail_udt_id);
		param.put("smp_aps_detail_ct", smp_aps_detail_ct);
		logger.debug("평가항목 세부 서비스 시작");
		ssaDAO.insertApsDetail(param);
			
	}
	
	/**
	 * @Method Name : SmpApsDetailExam
	 * @Date : 2019. 02. 27.
	 * @User : 김홍일
	 * @Param :
	 * @Return :
	 * @Method 설명 : 상세항목 세부 서비스
	 */
	
	public void insertSmpApsDetailExam(SocietySmpApsDetailExam societySmpApsDetailExam) {
		logger.debug("평가항목 세부 서비스 시작");
		ssaDAO.insertSmpApsDetailExam(societySmpApsDetailExam);
			
	}
	
	/**
	 * @Method Name : SmpApsDetailSubexam
	 * @Date : 2019. 02. 27.
	 * @User : 김홍일
	 * @Param :
	 * @Return :
	 * @Method 설명 : 상세항목 세부 서비스
	 */
	
	public void insertSmpApsDetailSubexam(SocietySmpApsDetailSubexam societySmpApsDetailSubexam) {
		logger.debug("평가항목 세부 서비스 시작");
		ssaDAO.insertSmpApsDetailSubexam(societySmpApsDetailSubexam);
			
	}
	
	/**
	 * @Method Name : selectApsTotalDetail
	 * @Date : 2018. 09. 12.
	 * @User : 전희배
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 평가항목종합 상세 조회
	 */
	public HashMap<String, Object> selectApsTotalDetail(int smp_aps_total_seq) {
		logger.debug("평가항목종합 상세조회 서비스 시작");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("smp_aps_total_seq", smp_aps_total_seq);
		logger.debug("평가항목종합 상세조회 서비스 종료");
		return ssaDAO.selectApsTotalDetail(param);
	}
	
	/**
	 * @Method Name : selectApsGroupDetail
	 * @Date : 2018. 09. 12.
	 * @User : 전희배
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 평가항목그룹 상세 조회
	 */
	public HashMap<String, Object> selectApsGroupDetail(int smp_aps_group_seq) {
		logger.debug("평가항목그룹 상세조회 서비스 시작");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("smp_aps_group_seq", smp_aps_group_seq);
		logger.debug("평가항목그룹 상세조회 서비스 종료");
		return ssaDAO.selectApsGroupDetail(param);
	}
	
	/**
	 * @Method Name : selectApsDetailDetail
	 * @Date : 2018. 09. 12.
	 * @User : 전희배
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 평가항목종합 상세 조회
	 */
	public HashMap<String, Object> selectApsDetailDetail(int smp_aps_detail_seq) {
		logger.debug("평가항목상세 상세조회 서비스 시작");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("smp_aps_detail_seq", smp_aps_detail_seq);
		logger.debug("평가항목상세 상세조회 서비스 종료");
		return ssaDAO.selectApsDetailDetail(param);
	}
	
	/**
	 * @Method Name : updateApsTotal
	 * @Date : 2018. 09. 12.
	 * @User : 전희배
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 평가항목종합 수정
	 */
	public void updateApsTotal(int gisu_seq,int smp_aps_total_seq, String smp_aps_total_nm, int smp_aps_total_ratio, String smp_aps_total_udt_id,String smp_aps_total_ct) {
		logger.debug("평가항목상세 수정 서비스 시작");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("gisu_seq", gisu_seq);
		param.put("smp_aps_total_seq", smp_aps_total_seq);
		param.put("smp_aps_total_nm", smp_aps_total_nm);
		param.put("smp_aps_total_ratio", smp_aps_total_ratio);
		param.put("smp_aps_total_udt_id", smp_aps_total_udt_id);
		param.put("smp_aps_total_ct", smp_aps_total_ct);
		logger.debug("평가항목상세 수정 서비스 종료");
		ssaDAO.updateApsTotal(param);
	}
	
	/**
	 * @Method Name : updateApsGroup
	 * @Date : 2018. 09. 12.
	 * @User : 전희배
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 평가항목그룹 수정
	 */ 
	public void updateApsGroup(int smp_aps_group_seq, String smp_aps_group_nm, String smp_aps_group_tp, int smp_aps_group_ratio, String smp_aps_group_udt_id,String smp_aps_group_ct) {
		logger.debug("평가항목상세 수정 서비스 시작");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("smp_aps_group_seq", smp_aps_group_seq);
		param.put("smp_aps_group_nm", smp_aps_group_nm);
		param.put("smp_aps_group_tp", smp_aps_group_tp);
		param.put("smp_aps_group_ratio", smp_aps_group_ratio);
		param.put("smp_aps_group_udt_id", smp_aps_group_udt_id);
		param.put("smp_aps_group_ct", smp_aps_group_ct);
		logger.debug("평가항목상세 수정 서비스 종료");
		ssaDAO.updateApsGroup(param);
	}
	
	/**
	 * @Method Name : updateApsDetail
	 * @Date : 2018. 09. 12.
	 * @User : 전희배
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 평가항목상세 수정
	 */ 
	public void updateApsDetail(int smp_aps_detail_seq, String smp_aps_detail_nm, int smp_aps_detail_ratio, String smp_aps_detail_udt_id,String smp_aps_detail_ct) {
		logger.debug("평가항목상세 수정 서비스 시작");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("smp_aps_detail_seq", smp_aps_detail_seq);
		param.put("smp_aps_detail_nm", smp_aps_detail_nm);
		param.put("smp_aps_detail_ratio", smp_aps_detail_ratio);
		param.put("smp_aps_detail_udt_id", smp_aps_detail_udt_id);
		param.put("smp_aps_detail_ct", smp_aps_detail_ct);
		logger.debug("평가항목상세 수정 서비스 종료");
		ssaDAO.updateApsDetail(param);
	}
	
	/**
	 * @Method Name : selectSmpApsSetList
	 * @Date : 2018. 09. 11.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public List<SocietySmpApsSetList> selectSmpApsSetList() {
		return ssaDAO.selectSmpApsSetList();
	}
	
	/**
	 * @Method Name : deleteSmpApsTotal
	 * @Date : 2018. 09. 13.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int deleteSmpApsTotal(int gisu_seq) {
		return ssaDAO.deleteSmpApsTotal(gisu_seq);
	}
	
	/**
	 * @Method Name : selectSmpApsSetTotal
	 * @Date : 2018. 09. 13.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public List<SocietySmpApsSetTotal> selectSmpApsSetTotal(int smp_aps_setlist_seq) {
		return ssaDAO.selectSmpApsSetTotal(smp_aps_setlist_seq);
	}
	
	/**
	 * @Method Name : insertApsTotalSetting
	 * @Date : 2018. 09. 13.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public void insertApsTotalSetting(SocietySmpApsTotal total) {
		ssaDAO.insertApsTotalSetting(total);
	}
	
	/**
	 * @Method Name : insertApsGroupSetting
	 * @Date : 2018. 09. 14.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public void insertApsGroupSetting(SocietySmpApsGroup group) {
		ssaDAO.insertApsGroupSetting(group);
	}
	
	/**
	 * @Method Name : insertApsDetailSetting
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public void insertApsDetailSetting(SocietySmpApsDetail detail) {
		ssaDAO.insertApsDetailSetting(detail);
	}
	
	/**
	 * @Method Name : selectApsTotalListByGisuSeq
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public List<SocietySmpApsTotal> selectApsTotalListByGisuSeq(int gisu_seq) {
		return ssaDAO.selectApsTotalListByGisuSeq(gisu_seq);
	}
	
	/**
	 * @Method Name : selectApsGroupList
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	/*public List<SocietySmpApsGroup> selectApsGroupList(int smp_aps_total_seq) {
		return ssaDAO.selectApsGroupList(smp_aps_total_seq);
	}*/
	
	/**
	 * @Method Name : selectApsGroupList
	 * @Date : 2019. 02. 13.
	 * @User : 김홍일
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public ArrayList<HashMap<String, Object>> selectApsGroupList(HashMap<String, Object> params) {
		return ssaDAO.selectApsGroupList(params);
	}
	
	/**
	 * @Method Name : selectApsDetailList
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public List<SocietySmpApsDetail> selectApsDetailList(int smp_aps_group_seq) {
		return ssaDAO.selectApsDetailList(smp_aps_group_seq);
	}
	
	/**
	 * @Method Name : insertApsSetList
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int insertApsSetList(SocietySmpApsSetList SMPApsSetList){
		return ssaDAO.insertApsSetList(SMPApsSetList);
	}
	
	/**
	 * @Method Name : insertApsSetTotal
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int insertApsSetTotal(SocietySmpApsSetTotal SMPApsSetTotal){
		return ssaDAO.insertApsSetTotal(SMPApsSetTotal);
	}
	
	/**
	 * @Method Name : insertApsSetGroup
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int insertApsSetGroup(SocietySmpApsSetGroup SMPApsSetGroup){
		return ssaDAO.insertApsSetGroup(SMPApsSetGroup);
	}
	
	/**
	 * @Method Name : insertApsSetDetail
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int insertApsSetDetail(SocietySmpApsSetDetail SMPApsSetDetail){
		return ssaDAO.insertApsSetDetail(SMPApsSetDetail);
	}
	
	/**
	 * @Method Name : selectSmpApsSetGroup
	 * @Date : 2018. 09. 13.
	 * @User : 김진환
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public List<SocietySmpApsSetGroup> selectSmpApsSetGroup(int smp_aps_settotal_seq) {
		return ssaDAO.selectSmpApsSetGroup(smp_aps_settotal_seq);
	}
	
	/**
	 * @Method Name : selectSmpApsSetDetail
	 * @Date : 2018. 09. 13.
	 * @User : 김진환
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public List<SocietySmpApsSetDetail> selectSmpApsSetDetail(int smp_aps_setgroup_seq) {
		return ssaDAO.selectSmpApsSetDetail(smp_aps_setgroup_seq);
	}
	
	/**
	 * @Method Name : selectSmpApsSetTotal
	 * @Date : 2018. 09. 13.
	 * @User : 김진환
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public List<SocietySmpApsSetTotal> selectSmpApsSetTotal() {
		return ssaDAO.selectSmpApsSetTotal();
	}
	
	/**
	 * @Method Name : selectTotalOverlap
	 * @Date : 2018. 09. 14.
	 * @User : 전희배
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 평가항목 total 중복체크
	 */
	public List<String> selectTotalOverlap(int gisu_seq, String smp_aps_total_nm,int smp_aps_total_seq){
		logger.debug("평가항목 total 중복체크 서비스 시작");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("gisu_seq", gisu_seq);
		param.put("smp_aps_total_nm", smp_aps_total_nm);
		param.put("smp_aps_total_seq", smp_aps_total_seq);
		logger.debug("평가항목 total 중복체크 종료");
		return ssaDAO.selectTotalOverlap(param);
	}
	
	/**
	 * @Method Name : selectGroupOverlap
	 * @Date : 2018. 09. 14.
	 * @User : 전희배
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 평가항목 group 중복체크
	 */
	public List<String> selectGroupOverlap(int smp_aps_total_seq, String smp_aps_group_nm,int smp_aps_group_seq){
		logger.debug("평가항목 total 중복체크 서비스 시작");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("smp_aps_total_seq", smp_aps_total_seq);
		param.put("smp_aps_group_nm", smp_aps_group_nm);
		param.put("smp_aps_group_seq", smp_aps_group_seq);
		logger.debug("평가항목 total 중복체크 종료");
		return ssaDAO.selectGroupOverlap(param);
	}
	
	/**
	 * @Method Name : selectDetailOverlap
	 * @Date : 2018. 09. 14.
	 * @User : 전희배
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 평가항목 detail 중복체크
	 */
	public List<String> selectDetailOverlap(int smp_aps_group_seq, String smp_aps_detail_nm,int smp_aps_detail_seq){
		logger.debug("평가항목 total 중복체크 서비스 시작");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("smp_aps_group_seq",smp_aps_group_seq);
		param.put("smp_aps_detail_nm", smp_aps_detail_nm);
		param.put("smp_aps_detail_seq", smp_aps_detail_seq);
		logger.debug("평가항목 total 중복체크 종료");
		return ssaDAO.selectDetailOverlap(param);
	}
	
	/**
	 * @Method Name : sumTotalRatio
	 * @Date : 2018. 09. 15.
	 * @User : 전희배
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 평가항목 total 비율 합계 조회
	 */
	public int sumTotalRatio(int gisu_seq, int smp_aps_total_seq) {
		logger.debug("평가항목 total 비율 합계 조회 서비스 시작");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("gisu_seq",gisu_seq);
		param.put("smp_aps_total_seq", smp_aps_total_seq);
		logger.debug("평가항목 total 비율 합계 조회 종료");
		return ssaDAO.sumTotalRatio(param);	
	};
	/**
	 * @Method Name : sumGroupRatio
	 * @Date : 2018. 09. 16.
	 * @User : 전희배
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 평가항목 group 비율 합계 조회
	 */
	public List<HashMap<String, Object>>  sumGroupRatio(int gisu_seq, int smp_aps_total_seq, int smp_aps_group_seq) {
		logger.debug("평가항목 group 비율 합계 조회 서비스 시작");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("gisu_seq",gisu_seq);
		param.put("smp_aps_total_seq", smp_aps_total_seq);
		param.put("smp_aps_group_seq", smp_aps_group_seq);
		logger.debug("평가항목 group 비율 합계 조회 종료");
		return ssaDAO.sumGroupRatio(param);	
	};
	
	/**
	 * @Method Name : sumDetailRatio
	 * @Date : 2018. 09. 16.
	 * @User : 전희배
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 평가항목 detail 비율 합계 조회
	 */
	/*public List<HashMap<String, Object>>  sumDetailRatio(int gisu_seq, int smp_aps_group_seq, int smp_aps_detail_seq) {
		logger.debug("평가항목 detail 비율 합계 조회 서비스 시작");
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("gisu_seq",gisu_seq);
		param.put("smp_aps_group_seq", smp_aps_group_seq);
		param.put("smp_aps_detail_seq", smp_aps_detail_seq);
		logger.debug("평가항목 detail 비율 합계 조회 종료");
		return ssaDAO.sumDetailRatio(param);	
	};*/
	
	/**
	 * @Method Name : deleteSetList
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int deleteSetList(int smp_aps_setlist_seq) {
		return ssaDAO.deleteSetList(smp_aps_setlist_seq);
	};

	/**
	 * @Method Name : deleteSetTotal
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int deleteSetTotal(int smp_aps_settotal_seq){
		return ssaDAO.deleteSetTotal(smp_aps_settotal_seq);
	}
	
	/**
	 * @Method Name : deleteSetGroup
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int deleteSetGroup(int smp_aps_setgroup_seq){
		return ssaDAO.deleteSetGroup(smp_aps_setgroup_seq);
	}	
	
	/**
	 * @Method Name : deleteSetDetail
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int deleteSetDetail(int smp_aps_setdetail_seq){
		return ssaDAO.deleteSetDetail(smp_aps_setdetail_seq);
	}
	
	/**
	 * @Method Name : selectSetTotal
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public SocietySmpApsSetTotal selectApsSetTotal(int smp_aps_settotal_seq){
		return ssaDAO.selectApsSetTotal(smp_aps_settotal_seq);
	}
	
	/**
	 * @Method Name : selectSetGroup
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public SocietySmpApsSetGroup selectSetGroup(int smp_aps_setgroup_seq){
		return ssaDAO.selectSetGroup(smp_aps_setgroup_seq);
	}
	
	/**
	 * @Method Name : selectSetDetail
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public SocietySmpApsSetDetail selectSetDetail(int smp_aps_setdetail_seq){
		return ssaDAO.selectSetDetail(smp_aps_setdetail_seq);
	}
	
	/**
	 * @Method Name : updateSetTotal
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int updateSetTotal(SocietySmpApsSetTotal SMPApsSetTotal){
		return ssaDAO.updateSetTotal(SMPApsSetTotal);
		
	}
	
	/**
	 * @Method Name : updateSetGroup
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int updateSetGroup(SocietySmpApsSetGroup SMPApsSetGroup){
		return ssaDAO.updateSetGroup(SMPApsSetGroup);
	}
	
	/**
	 * @Method Name :updateSetDetail
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int updateSetDetail(SocietySmpApsSetDetail SMPApsSetDetail){
		return ssaDAO.updateSetDetail(SMPApsSetDetail);
	}
	
	/**
	 * 
	 * @Method Name : selectBoardGisuSeq
	 * @Date : 2018. 12. 3.
	 * @User : 원병호
	 * @Param : board_content_seq 
	 * @Return : gisu_seq
	 * @Method 설명 : 게시판 번호로 기수를 찾는 메소드
	 */
	public int selectBoardGisuSeq(int board_content_seq){
		return ssaDAO.selectBoardGisuSeq(board_content_seq);
	}
	
	/**
	 * @Method Name : select_board_detail2
	 * @Date : 2018. 12. 4.
	 * @User : 원병호
	 * @Param : board_content_seq
	 * @Return : hashMap<String,String>(key : gisu_crc_nm, board_content_imp)
	 * @Method 설명 : 게시판 상세보기(학사,기수별)에 필요한 정보중 com_board_content_tb에 없는 항목 가져오는 메소드
	 */
	public HashMap<String, String> select_board_detail2(int board_content_seq){
		return ssaDAO.select_board_detail2(board_content_seq);
	}
	
	/**
	 * @Method Name : update_board_pd
	 * @Date : 2018. 12. 6.
	 * @User : Administrator
	 * @Param : board_seq, board_icon_pd
	 * @Return : 
	 * @Method 설명 : 해당 boardGroup의 갱신아이콘 표시기간(board_icon_pd) 수정
	 */
	public int update_board_pd(int board_seq, int board_icon_pd){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("board_seq", board_seq);
		map.put("board_icon_pd", board_icon_pd);
		return ssaDAO.update_board_pd(map);
	}
	
	/**
	 * @Method Name : select_board_pd
	 * @Date : 2018. 12. 6.
	 * @User : Administrator
	 * @Param : board_seq
	 * @Return : board_icon_pd
	 * @Method 설명 : 해당 board_seq의 boardGroup의 아이콘갱신표시기간(board_icon_pd) 반환
	 */
	public int select_board_pd(int board_seq){
		return ssaDAO.select_board_pd(board_seq);
	}
	
	
	
}
