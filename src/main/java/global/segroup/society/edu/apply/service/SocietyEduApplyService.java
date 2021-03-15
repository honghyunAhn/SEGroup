/**
 * 
 */
package global.segroup.society.edu.apply.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.mail.MessagingException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import global.segroup.domain.FaqConsultingContents;
import global.segroup.domain.OfflineConsultingContents;
import global.segroup.domain.OnlineConsultingContents;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculumGisu;
import global.segroup.society.edu.admin.domain.SocietyEduAdminPayment;
import global.segroup.society.edu.apply.dao.SocietyEduApplyDAO;
import global.segroup.society.edu.apply.domain.SocietyEduApplyCareer;
import global.segroup.society.edu.apply.domain.SocietyEduApplyEduHistory;
import global.segroup.society.edu.apply.domain.SocietyEduApplyFile;
import global.segroup.society.edu.apply.domain.SocietyEduApplyForm;
import global.segroup.society.edu.apply.domain.SocietyEduApplyLanguage;
import global.segroup.society.edu.apply.domain.SocietyEduApplyLicense;
import global.segroup.society.edu.apply.domain.SocietyEduApplyOverseas;
import global.segroup.society.edu.apply.domain.SocietyEduApplyStudy;
import global.segroup.util.FileService;
import global.segroup.util.MailService;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 31.
 * @Class 설명 : Soft Engineer Society 모집홍보 지원신청 서비스
 * 
 */
@Service
public class SocietyEduApplyService {

	private static final Logger logger = LoggerFactory.getLogger(SocietyEduApplyService.class);

	/**
	 * file.propertices 의 등록된 지원신청서 증명사진 경로
	 */
	@Value("#{props['edu.apply.photo']}")
	private String eduApplyPhotoPath;

	/**
	 * file.propertices 의 등록된 지원신청서 최종 학력증명서 경로
	 */
	@Value("#{props['edu.apply.edu_history']}")
	private String eduApplyEduHistoryPath;

	/**
	 * file.propertices 의 등록된 지원신청서 고용보험 상실확인 경로
	 */
	@Value("#{props['edu.apply.insurance']}")
	private String eduApplyInsurancePath;

	/**
	 * file.propertices 의 등록된 지원신청서 출입국 사실증명서 경로
	 */
	@Value("#{props['edu.apply.immigration']}")
	private String eduApplyImmgrationPath;

	/**
	 * file.propertices 의 등록된 지원신청서 출입국 사실증명서 경로
	 */
	@Value("#{props['edu.apply.worknet']}")
	private String eduApplyWorknetPath;
	
	/**
	 * file.propertices 의 등록된 지원신청서 기타 파일 경로
	 */
	@Value("#{props['edu.apply.etc']}")
	private String eduApplyEtcPath;
	
	/**
	 * file.propertices 의 등록된 기수 이미지 파일 경로
	 */
	@Value("#{props['edu.admin.curriculum_gisu_insert_image']}")
	private String eduApplyGisuImgPath;
	
	/**
	 * 메일을 보내는 서비스
	 */
	@Autowired
	private MailService mail;

	@Autowired
	private SocietyEduApplyDAO seaDao;

	/**
	 * @Method Name : apply_insert
	 * @Date : 2017. 7. 31.
	 * @User : 이종호
	 * @Param : SMART Cloud IT마스터 지원신청 정보(기본정보 , 학력, 경력, 교육이수, 언어능력, 자격증, 해외체류,
	 *        증빙자료)
	 * @Return : -
	 * @Method 설명 : 컨트롤러로 부터 전달 받은 지원신청 정보를 DAO로 전달.
	 */
	@Transactional
	public void apply_insert(SocietyEduApplyForm seaForm, SocietyEduApplyEduHistory seaEduHistory,
			SocietyEduApplyCareer seaCareer, SocietyEduApplyStudy seaStudy, SocietyEduApplyLanguage seaLanguage,
			SocietyEduApplyLicense seaLicense, SocietyEduApplyOverseas seaOverseas, SocietyEduApplyFile seaFile) {

		logger.debug("모집홍보 지원신청 서비스 시작");

		// 저장 fullPath
		String fullPath = "/" + seaForm.getApp_id() + "_" + String.valueOf(seaForm.getGisu_seq());

		// 지원신청서 증명사진 기존파일 삭제
		if (seaForm.getApp_photo_origin() != null) {
			seaForm.setApp_photo_origin(seaForm.getApp_photo_origin());
			seaForm.setApp_photo_saved(seaForm.getApp_photo_saved());
		} else if (seaForm.getApp_photo_saved() != null) {
			FileService.deleteFile(seaForm.getApp_photo_saved(), eduApplyPhotoPath + fullPath);
		}
		// 지원신청서 증명사진 체크
		if (seaForm.getApp_photo_file() != null && !seaForm.getApp_photo_file().isEmpty()) {
			String photoOrigin = seaForm.getApp_photo_file().getOriginalFilename();
			try {
				String photoSaved = FileService.saveFile(seaForm.getApp_photo_file(), eduApplyPhotoPath + fullPath);
				seaForm.setApp_photo_saved(photoSaved);
				seaForm.setApp_photo_origin(photoOrigin);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			}
		}

		// 지원신청서 최종학력증명서 기존파일 삭제
		if (seaForm.getApp_edu_file_origin() != null) {
			seaForm.setApp_edu_file_origin(seaForm.getApp_edu_file_origin());
			seaForm.setApp_edu_file_saved(seaForm.getApp_edu_file_saved());
		} else if (seaForm.getApp_edu_file_saved() != null) {
			FileService.deleteFile(seaForm.getApp_edu_file_saved(), eduApplyEduHistoryPath + fullPath);
		}
		// 지원신청서 최종학력증명서 체크
		if (seaForm.getApp_edu_file() != null && !seaForm.getApp_edu_file().isEmpty()) {
			String eduOrigin = seaForm.getApp_edu_file().getOriginalFilename();
			try {
				String eduSaved = FileService.saveFile(seaForm.getApp_edu_file(), eduApplyEduHistoryPath + fullPath);
				seaForm.setApp_edu_file_saved(eduSaved);
				seaForm.setApp_edu_file_origin(eduOrigin);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			}
		}

		// 지원신청서 고용보험 상실확인 기존파일 삭제
		if (seaForm.getApp_isr_file_origin() != null) {
			seaForm.setApp_isr_file_origin(seaForm.getApp_isr_file_origin());
			seaForm.setApp_isr_file_saved(seaForm.getApp_isr_file_saved());
		} else if (seaForm.getApp_isr_file_saved() != null) {
			FileService.deleteFile(seaForm.getApp_isr_file_saved(), eduApplyInsurancePath + fullPath);
		}

		// 지원신청서 고용보험 상실확인 체크
		if (seaForm.getApp_isr_file() != null && !seaForm.getApp_isr_file().isEmpty()) {
			String isrOrigin = seaForm.getApp_isr_file().getOriginalFilename();
			try {
				String isrSaved = FileService.saveFile(seaForm.getApp_isr_file(), eduApplyInsurancePath + fullPath);
				seaForm.setApp_isr_file_saved(isrSaved);
				seaForm.setApp_isr_file_origin(isrOrigin);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			}
		}

		// 지원신청서 출입국 사실증명서 기존파일 삭제
		if (seaForm.getApp_imm_file_origin() != null) {
			seaForm.setApp_imm_file_origin(seaForm.getApp_imm_file_origin());
			seaForm.setApp_imm_file_saved(seaForm.getApp_imm_file_saved());
		} else if (seaForm.getApp_imm_file_saved() != null) {
			FileService.deleteFile(seaForm.getApp_imm_file_saved(), eduApplyImmgrationPath + fullPath);
		}

		// 지원신청서 출입국 사실증명서 체크
		if (seaForm.getApp_imm_file() != null && !seaForm.getApp_imm_file().isEmpty()) {
			String immOrigin = seaForm.getApp_imm_file().getOriginalFilename();
			try {
				String immSaved = FileService.saveFile(seaForm.getApp_imm_file(), eduApplyImmgrationPath + fullPath);
				seaForm.setApp_imm_file_saved(immSaved);
				seaForm.setApp_imm_file_origin(immOrigin);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			}
		}

		// 지원신청서 워크넷 직무평가 결과 기존파일 삭제
		if (seaForm.getApp_worknet_file_origin() != null) {
			seaForm.setApp_worknet_file_origin(seaForm.getApp_worknet_file_origin());
			seaForm.setApp_worknet_file_saved(seaForm.getApp_worknet_file_saved());
		} else if (seaForm.getApp_worknet_file_saved() != null) {
			FileService.deleteFile(seaForm.getApp_worknet_file_saved(), eduApplyWorknetPath + fullPath);
		}

		// 지원신청서 워크넷 직무평가 결과 체크
		if (seaForm.getApp_worknet_file() != null && !seaForm.getApp_worknet_file().isEmpty()) {
			String immOrigin = seaForm.getApp_worknet_file().getOriginalFilename();
			try {
				String immSaved = FileService.saveFile(seaForm.getApp_worknet_file(), eduApplyWorknetPath + fullPath);
				seaForm.setApp_worknet_file_saved(immSaved);
				seaForm.setApp_worknet_file_origin(immOrigin);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			}
		}

		// 지원신청서 기타 증빙자료 체크
		ArrayList<Integer> removeArr = new ArrayList<>();
		for (SocietyEduApplyFile fileObj : seaFile.getFileList()) {

			// 지원시청서 기타 증빙자료 기존파일 삭제
			if (fileObj.getApp_file_origin() != null) {
				fileObj.setApp_file_origin(fileObj.getApp_file_origin());
				fileObj.setApp_file_saved(fileObj.getApp_file_saved());
			} else if (fileObj.getApp_file_saved() != null) {
				FileService.deleteFile(fileObj.getApp_file_saved(), eduApplyEtcPath + fullPath);
			}

			if (fileObj.getApp_file() != null && !fileObj.getApp_file().isEmpty()) {
				String etcOrigin = fileObj.getApp_file().getOriginalFilename();
				try {
					String etcSaved = FileService.saveFile(fileObj.getApp_file(), eduApplyEtcPath + fullPath);
					fileObj.setApp_file_saved(etcSaved);
					fileObj.setApp_file_origin(etcOrigin);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				}
			} else {
				if (fileObj.getApp_file_origin() == null) {
					removeArr.add(seaFile.getFileList().indexOf(fileObj));
				}
			}
		}
		// 기타 증빙자료 빈 리스트 제거 후 인덱스 리스트 초기화
		seaFile.setFileList(removeEmptyList(seaFile.getFileList(), removeArr));
		removeArr.clear();

		// 학력정보 빈 리스트 체크
		for (SocietyEduApplyEduHistory eduHistory : seaEduHistory.getEduHistoryList()) {
			if (eduHistory.getApp_edu_sc_nm().trim().equals("")) {
				removeArr.add(seaEduHistory.getEduHistoryList().indexOf(eduHistory));
			}
		}

		// 학력정보 빈 리스트 제거 후 인덱스 리스트 초기화
		seaEduHistory.setEduHistoryList(removeEmptyList(seaEduHistory.getEduHistoryList(), removeArr));
		removeArr.clear();

		// 경력정보 빈 리스트 체크
		for (SocietyEduApplyCareer career : seaCareer.getCareerList()) {
			if (career.getApp_crr_place().trim().equals("")) {
				removeArr.add(seaCareer.getCareerList().indexOf(career));
			}
		}

		// 경력정보 빈 리스트 제거 후 인덱스 리스트 초기화
		seaCareer.setCareerList(removeEmptyList(seaCareer.getCareerList(), removeArr));
		removeArr.clear();

		// 교육이수 빈 리스트 체크
		for (SocietyEduApplyStudy study : seaStudy.getStudyList()) {
			if (study.getApp_study_nm().trim().equals("")) {
				removeArr.add(seaStudy.getStudyList().indexOf(study));
			}
		}

		// 교육이수 빈 리스트 제거 후 인덱스 리스트 초기화
		seaStudy.setStudyList(removeEmptyList(seaStudy.getStudyList(), removeArr));
		removeArr.clear();

		// 언어능력 빈 리스트 체크
		for (SocietyEduApplyLanguage language : seaLanguage.getLanguageList()) {
			if (language.getApp_lang_test_nm().trim().equals("")) {
				removeArr.add(seaLanguage.getLanguageList().indexOf(language));
			}
		}

		// 언어능력 빈 리스트 제거 후 인덱스 리스트 초기화
		seaLanguage.setLanguageList(removeEmptyList(seaLanguage.getLanguageList(), removeArr));
		removeArr.clear();

		// 자격증 빈 리스트 체크
		for (SocietyEduApplyLicense license : seaLicense.getLicenseList()) {
			if (license.getApp_license_nm().trim().equals("")) {
				removeArr.add(seaLicense.getLicenseList().indexOf(license));
			}
		}

		// 자격증 빈 리스트 제거 후 인덱스 리스트 초기화
		seaLicense.setLicenseList(removeEmptyList(seaLicense.getLicenseList(), removeArr));
		removeArr.clear();

		// 해외체류 빈 리스트 체크
		for (SocietyEduApplyOverseas overseas : seaOverseas.getOverseasList()) {
			if (overseas.getApp_overseas_nm().trim().equals("")) {
				removeArr.add(seaOverseas.getOverseasList().indexOf(overseas));
			}
		}

		// 해외체류 빈 리스트 제거 후 인덱스 리스트 초기화
		seaOverseas.setOverseasList(removeEmptyList(seaOverseas.getOverseasList(), removeArr));
		removeArr.clear();

		seaDao.apply_insert(seaForm, seaEduHistory, seaCareer, seaStudy, seaLanguage, seaLicense, seaOverseas, seaFile);

		logger.debug("모집홍보 지원신청 서비스 종료");
	}

	/**
	 * @Method Name : removeEmptyList
	 * @Date : 2017. 8. 2.
	 * @User : 이종호
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
	 * @Method Name : deleteEduApplyForm
	 * @Date : 2017. 8. 16.
	 * @User : 이종호
	 * @Param : 지원신청서 시퀀스
	 * @Return : -
	 * @Method 설명 : 해당 지원신청서 정보를 삭제하는 서비스 함수
	 */
	public void apply_delete(HashMap<String, Object> param) {
		logger.debug("모집홍보 특정 회원 정보 삭제 서비스 시작");

		seaDao.deleteEduApplyForm(param);

		logger.debug("모집홍보 특정 회원 정보 삭제 서비스 종료");
	}

	/**
	 * @param gisu_crc_class 
	 * @Method Name : selectLongTermList
	 * @Date : 2017. 8. 10.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 승인 된 장기 과정 기수 리스트 객체
	 * @Method 설명 : 승인 된 장기 과정 기수 리스트 객체를 전달하는 서비스 함수
	 */
	// ArrayList<HashMap> -> 그냥 HashMap으로 수정; 2018. 10. 10. 김준영
	public HashMap<String, Object> selectLongTermList(String user_id, String gisu_crc_class, String division) {
		logger.debug("모집홍보 승인 된 장기 과정 기수 리스트 검색 서비스 시작");
		logger.debug("모집홍보 승인 된 장기 과정 기수 리스트 검색 서비스 종료");
		return seaDao.selectLongTermList(user_id, gisu_crc_class, division);
	}

	/**
	 * @param gisu_crc_class 
	 * @Method Name : selectShortTermList
	 * @Date : 2017. 8. 10.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 승인 된 단기 과정 기수 리스트 객체
	 * @Method 설명 : 승인 된 단기 과정 기수 리스트 객체를 전달하는 서비스 함수
	 */
	public ArrayList<HashMap<String, Object>> selectShortTermList(String user_id, String gisu_crc_class) {
		logger.debug("모집홍보 승인 된 단기 과정 기수 리스트 검색 서비스 시작");
		logger.debug("모집홍보 승인 된 단기 과정 기수 리스트 검색 서비스 종료");
		return seaDao.selectShortTermList(user_id, gisu_crc_class);
	}
	
	/**
	 * @param gisu_seq 
	 * @Method Name : selectShortTermPayInfo
	 * @Date : 2018. 12. 12.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 승인 된 단기 과정 결제정보 
	 * @Method 설명 : 승인 된 장기 과정 결제정보 전달하는 서비스 함수
	 */	
	public SocietyEduAdminPayment selectShortTermPayInfo(String gisu_seq) {
		logger.debug("모집홍보 승인 된 단기 과정 결제정보 서비스 시작");
		
		logger.debug("모집홍보 승인 된 단기 과정 결제정보 서비스 종료");
		return seaDao.selectShortTermPayInfo(gisu_seq);
	}

	/**
	 * @Method Name : selectShortTermInfo
	 * @Date : 2018. 7. 26.
	 * @User : 김지훈
	 * @Param : 과정분류 단위로 검색되는 String Type 값
	 * @Return : 승인 된 단기 과정 기수 리스트 객체
	 * @Method 설명 : 승인 된 장기 과정 기수 리스트 객체를 전달하는 서비스 함수
	 */
	public ArrayList<HashMap<String, Object>> selectShortTermInfo(String gisu_crc_class) {
		logger.debug("모집홍보 승인 된 장기 과정 기수 리스트 검색 서비스 시작");
		logger.debug("모집홍보 승인 된 장기 과정 기수 리스트 검색 서비스 종료");
		return seaDao.selectShortTermInfo(gisu_crc_class);
	}

	/**
	 * @Method Name : select
	 * @Date : 2017. 11. 10.
	 * @User : 전상수
	 * @Param : -
	 * @Return : 이미지 게시판의 등록된 내용의 리스트 객체
	 * @Method 설명 : 관리자가 이미지게시판에 올린 내용의 리스트 객체를 전달하는 서비스 함수
	 */
	public ArrayList<HashMap<String, Object>> selectImageNoticeList(String user_id) {
		logger.debug("이미지 게시판 내용 리스트 검색 서비스 시작");
		logger.debug("이미지 게시판 내용 리스트 검색 서비스 종료");
		return seaDao.selectImageNoticeList(user_id);
	}

	/**
	 * @Method Name : selectEduApplyResult
	 * @Date : 2017. 8. 10.
	 * @User : 이종호
	 * @Param : 회원 아이디와 기수 시퀀스 정보를 가진 맵 객체
	 * @Return : 해당 파람값의 결과를 담은 맵 객체
	 * @Method 설명 : 해당 아이디와 기수 정보를 가진 객체의 유/무를 판단하는 서비스 함수
	 */
	public HashMap<String, Object> selectEduApplyResult(HashMap<String, Object> param) {
		logger.debug("모집홍보 지원 내역 조회 서비스 시작");
		logger.debug("모집홍보 지원 내역 조회 서비스 종료");

		return seaDao.selectEduApplyResult(param);
	}

	/*
	 * @Scheduled(fixedRate = 10000) public void task(){ String result =
	 * seaDao.task();
	 * 
	 * System.out.println(result); }
	 */

	public HashMap<String, Object> selectEduApply(HashMap<String, Object> param) {
		return seaDao.selectEduApply(param);
	}

	public int countBoard(String searchOption, String keyword, String boardSeq) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("searchOption", searchOption);
		param.put("keyword", keyword);
		param.put("boardSeq", boardSeq);

		return seaDao.countBoard(param);
	}

	public List<HashMap<String, Object>> boardListAll(int start, int end, String searchOption, String keyword,
			String boardSeq) {

		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("searchOption", searchOption);
		param.put("keyword", keyword);
		// BETWEEN #{start}, #{end}에 입력될 값을 맵에
		param.put("start", start);
		param.put("end", end);
		param.put("boardSeq", boardSeq);
		return seaDao.boardListAll(param);
	}

	public HashMap<String, Object> boardDetail(String seq, String boardSeq) {

		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("seq", seq);
		param.put("boardSeq", boardSeq);
		return seaDao.boardDetail(param);
	}

	public HashMap<String, Object> boardDetail(String seq, String searchOption, String boardSeq) {

		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("seq", seq);
		param.put("searchOption", searchOption);
		param.put("boardSeq", boardSeq);
		return seaDao.boardDetail(param);
	}

	public ArrayList<HashMap<String, Object>> boardFiles(String seq) {

		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("boardSeq", seq);
		return seaDao.boardFile(param);
	}

	public HashMap<String, Object> boardFileDetail(String seq) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("fileSeq", seq);
		return seaDao.boardFileDetail(param);
	}
	
	public void boardHit(int board_content_hit) {
		logger.debug("게시판 글 조회수 올리기 서비스 함수 시작");
			seaDao.boardHit(board_content_hit);
			logger.debug("게시판 글 조회수 올리기 서비스 함수 종료");
	}

	/**
	 * @Method Name : faq_consulting 게시판 페이지 호출 함수
	 * @Date : 2018. 7. 26.
	 * @User : 김도훈
	 * @Param : FAQ 상담 게시판 정보를 가진 맵 객체
	 * @Return : 해당 파람값의 결과를 담은 맵 객체
	 * @Method 설명 : FAQ 상담 페이지를 호출하는 서비스 함수
	 */
	public int faq_consulting_countBoard(String searchOption, String keyword) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("searchOption", searchOption);
		param.put("keyword", keyword);

		return seaDao.faq_consulting_countBoard(param);
	}	

	public List<HashMap<String, Object>> faq_consulting_boardListAll(int start, int end, String searchOption, String keyword) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("searchOption", searchOption);
		param.put("keyword", keyword);
		// BETWEEN #{start}, #{end}에 입력될 값을 맵에
		param.put("start", start);
		param.put("end", end);
		return seaDao.faq_consulting_boardListAll(param);
	}
	
	/**
	 * @Method Name : online_consulting 게시판 페이지 호출 함수
	 * @Date : 2018. 7. 26.
	 * @User : 김도훈
	 * @Param : FAQ 상담 게시판 정보를 가진 맵 객체
	 * @Return : 해당 파람값의 결과를 담은 맵 객체
	 * @Method 설명 : FAQ 상담 페이지를 호출하는 서비스 함수
	 */
	public int online_consulting_countBoard(String searchOption, String keyword, int consulting_tp) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("searchOption", searchOption);
		param.put("keyword", keyword);
		param.put("consulting_tp", consulting_tp);

		return seaDao.online_consulting_countBoard(param);
	}	
	
	public List<HashMap<String, Object>> online_consulting_boardListAll(int start, int end, String searchOption, String keyword,
			int consulting_tp) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("searchOption", searchOption);
		param.put("keyword", keyword);
		// BETWEEN #{start}, #{end}에 입력될 값을 맵에
		param.put("start", start);
		param.put("end", end);
		param.put("consulting_tp", consulting_tp);
		return seaDao.online_consulting_boardListAll(param);
	}

	public HashMap<String, Object> online_consulting_boardDetail(int consulting_seq) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("consulting_seq", consulting_seq);
		return seaDao.online_consulting_boardDetail(param);
	}

	public HashMap<String, Object> online_consulting_boardDetail(int consulting_seq, String searchOption) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("consulting_seq", consulting_seq);
		param.put("searchOption", searchOption);
		return seaDao.online_consulting_boardDetail(param);
	}
	
	/**
	 * @Method Name : online_consulting_hit_update
	 * @Date : 2018. 7. 30.
	 * @User : 김도훈
	 * @Param : 온라인상담 상담 조회수 시퀀스
	 * @Return : -
	 * @Method 설명 : 온라인상담 게시판 글 조회수를 증가시키는 DAO 함수
	 */
	public void online_consulting_hit_update(int consulting_hit) {
		logger.debug("FAQ 상담 게시판 글 조회수 올리기 서비스 함수 시작");
			seaDao.online_consulting_hit_update(consulting_hit);
			logger.debug("FAQ 상담 게시판 글 조회수 올리기 서비스 함수 종료");
	}
	
	/**
	 * @Method Name : apply_online_insert
	 * @Date : 2018. 7. 26.
	 * @User : 김도훈
	 * @Param : occ 온라인 상담 신청자의 정보를 담을 객체
	 * @Return : boolean 성공여부
	 * @Method 설명 : 온라인 상담 신청 정보를 DB에 저장 한다.
	 */
	public boolean apply_online_insert(OnlineConsultingContents occ) {
		logger.debug("온라인 신청 서비스 시작");
		try {
			seaDao.apply_online_insert(occ);
			logger.debug("온라인 신청 서비스 종료");
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("DB 입력 오류");
			return false;
		}
	}

	/**
	 * @Method Name : apply_online_update
	 * @Date : 2018. 7. 30.
	 * @User : 김도훈
	 * @Param : occ 온라인 상담 신청자의 정보를 담을 객체
	 * @Return : boolean 성공여부
	 * @Method 설명 : 온라인 상담 신청 정보를 DB에 저장 한다.
	 */
	public boolean apply_online_update(OnlineConsultingContents occ) {
		logger.debug("온라인 상담 수정 서비스 시작");
		try {
			seaDao.apply_online_update(occ);
			logger.debug("온라인 상담 수정 서비스 종료");
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("DB 입력 오류");
			return false;
		}
	}
	
	/**
	 * @Method Name : apply_online_delete
	 * @Date : 2018. 7. 31.
	 * @User : 김도훈
	 * @Param : occ 온라인 상담 신청자의 정보를 담을 객체
	 * @Return : boolean 성공여부
	 * @Method 설명 : 온라인 상담 신청 정보를 DB에서 삭제 한다.
	 */
	public boolean apply_online_delete(OnlineConsultingContents occ) {
		logger.debug("온라인 상담 삭제 서비스 시작");
		try {
			seaDao.apply_online_delete(occ);
			logger.debug("온라인 상담 삭제 서비스 종료");
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("DB 입력 오류");
			return false;
		}
	}
	
	/**
	 * @Method Name : apply_offline_insert
	 * @Date : 2018. 7. 12.
	 * @User : 김지훈
	 * @Param : occ 오프라인 상담 신청자의 정보를 담을 객체
	 * @Return : boolean 성공여부
	 * @Method 설명 : 오프라인 상담 신청 정보를 DB에 저장 후, 
	 * 신청자에게 접수된 상황을 email 발송으로 알려준다.
	 */
	public boolean apply_offline_insert(OfflineConsultingContents occ) {
		logger.debug("오프라인 신청 서비스 시작");
		try {
			seaDao.apply_offline_insert(occ);

			final String FROM = "sesoc2019@gamil.com";
			// final String TO = "han.jinkyu@softengineer.school";
			final String TO = occ.getUser_email();
			final String SUBJECT = "[Soft Engineer Society] 당신의 오프라인 상담이 접수되었습니다.";
//			final String TEXT = "";
			final String TEXT = occ.toString();
			
			mail.sendMail(FROM, TO, SUBJECT, TEXT);

			logger.debug("오프라인 신청 서비스 종료");
			return true;

		} catch (MessagingException e) {
			e.printStackTrace();
			logger.debug("이메일 전송 오류");
			return false;
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("DB 입력 오류");
			return false;
		}
	}

	/**
	 * @Method Name : searchCurGisu
	 * @Date : 2018. 7. 27.
	 * @User : 김지훈
	 * @Param : 기수 시퀀스 정보
	 * @Return : 기수 정보 객체
	 * @Method 설명 : 전달 받은 기수 시퀀스 정보의 특정 기수 정보를 전달하는 서비스 함수
	 */
	public SocietyEduAdminCurriculumGisu searchCurGisu(int gisu_seq) {
		logger.debug("특정 기수 정보 검색 서비스 시작");

		SocietyEduAdminCurriculumGisu seaCurGisu = seaDao.searchCurGisu(gisu_seq);

		logger.debug("특정 기수 정보 검색 서비스 종료");
		return seaCurGisu;
	}
	
	/**
	 * @Method Name : faq_test_search
	 * @Date : 2018. 7. 20.
	 * @User : 김도훈
	 * @Param : 타입 구분, FAQ 상담 게시판 타입 객체
	 * @Return : FAQ 상담 게시판 시퀀스, FAQ 상담 게시판 타입 리스트 객체
	 * @Method 설명 : 특정 구분값을 가진 게시판. 타입별로 리스트를 조회하는 서비스 함수
	 */
	public ArrayList<FaqConsultingContents> faq_test_search(FaqConsultingContents consultingTp) {
		logger.debug("FAQ 상담 게시판 타입별 리스트 조회 서비스 함수 시작");

		ArrayList<FaqConsultingContents> resultList = seaDao.faq_test_search(consultingTp);

		logger.debug("FAQ 상담 게시판 타입별 리스트 조회 서비스 함수 종료");
		return resultList;
	}

	/**
	 * @Method Name : main_mediainit_list
	 * @Date : 2018. 7. 31.
	 * @User : 김지훈
	 * @Param : 
	 * @Return : ArrayList<HashMap<String, Object>>
	 * @Method 설명 : 메인에서 미디어속 SC IT 마스터 최신글 6개를 보여주기 위해 DB에 접근한다.
	 */
	public ArrayList<HashMap<String, Object>> main_mediainit_list() {
		return seaDao.main_mediainit_list();
	}

	/**
	 * @Method Name : main_graduate_list
	 * @Date : 2018. 7. 31.
	 * @User : 김지훈
	 * @Param : 
	 * @Return : ArrayList<HashMap<String, Object>>
	 * @Method 설명 : 메인에서 졸업생마당 최신글 6개를 보여주기 위해 DB에 접근한다.
	 */
	public ArrayList<HashMap<String, Object>> main_graduate_list() {
		return seaDao.main_graduate_list();
	}

	/**
	 * @Method Name : main_notice_list
	 * @Date : 2018. 7. 31.
	 * @User : 김지훈
	 * @Param : 
	 * @Return : ArrayList<HashMap<String, Object>>
	 * @Method 설명 : 메인에서 공지사항 최신글 6개를 보여주기 위해 DB에 접근한다.
	 */
	public ArrayList<HashMap<String, Object>> main_notice_list() {
		return seaDao.main_notice_list();
	}

	/**
	 * @Method Name : main_faq_list
	 * @Date : 2018. 7. 31.
	 * @User : 김지훈
	 * @Param : 
	 * @Return : ArrayList<HashMap<String, Object>>
	 * @Method 설명 : 메인에서 FAQ 최신글 6개를 보여주기 위해 DB에 접근한다.
	 */
	public ArrayList<HashMap<String, Object>> main_faq_list() {
		return seaDao.main_faq_list();
	}

	/**
	 * @Method Name : mail_send_admin
	 * @Date : 2018. 8. 20.
	 * @User : user
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public void online_consulting_admin_mail_send(OnlineConsultingContents occ, String str) {
		logger.debug("온라인 신청 관리메일 발송 시작");
		System.out.println("occ : "+occ.toString());
		try {
			final String FROM = "sesoc2019@gamil.com";
			final String TO = "wlgnsl1444@sesoc.global";
			final String SUBJECT = "[Soft Engineer Society] " + str;
			final String TEXT = 
				"* " + str + " *\n\n"
				+ "CONSULTING_SEQ : " + occ.getConsulting_seq() + "\n"
				+ "작성자 : " + occ.getConsulting_udt_id() + "\n"
				+ "일자 : " + new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss", Locale.KOREA ).format (new Date ()) + "\n"
				+ "제목 : " + occ.getConsulting_title() + "\n"
				+ "내용 : " + occ.getConsulting_ct().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");	// [java/jsp] Html Tag(태그) 제거하는 정규식
			mail.sendMail(FROM, TO, SUBJECT, TEXT);
		} catch (MessagingException e) {
			e.printStackTrace();
			logger.debug("이메일 전송 오류");
		}
		logger.debug("온라인 신청 관리메일 발송 종료");
	}
	
	/**
	 * @Method Name : fullPath
	 * @Date : 2018. 10. 5.
	 * @User : 김준영
	 * @Param : gisu_crc_img_saved
	 * @Return : gisu_img_fullpath
	 * @Method 설명 : 이미지의 전체 경로를 리턴해준다.
	 */
	public String fullPath(String path){
		String fullPath = eduApplyGisuImgPath + "/" + path;
		return fullPath;
	}
	
	/**
	 * @Method Name : seoul_img_select
	 * @Date : 2018. 10. 10.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 서울 링크에 이미지 등록된 배열
	 * @Method 설명 : 서울 링크 클릭시 배너 관리에 등록되어있는 기수 이미지를 가져옴
	 */
	public ArrayList<String> seoul_img_select(){
		logger.debug("서울 이미지 가져오기 서비스 시작");
		ArrayList<String> seoul_img_select = seaDao.seoul_img_select();
		for(int i = 0; i < seoul_img_select.size(); i++){
			seoul_img_select.set(i, fullPath(seoul_img_select.get(i)));
		}
		logger.debug("서울 이미지 가져오기 서비스 종료");
		return seoul_img_select;
	}
	
	/**
	 * @Method Name : gwangju_img_select
	 * @Date : 2018. 10. 10.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 광주 링크에 이미지 등록된 배열
	 * @Method 설명 : 광주 링크 클릭시 배너 관리에 등록되어있는 기수 이미지를 가져옴
	 */
	public ArrayList<String> gwangju_img_select(){
		logger.debug("광주 이미지 가져오기 서비스 시작");
		ArrayList<String> gwangju_img_select = seaDao.gwangju_img_select();
		for(int i = 0; i < gwangju_img_select.size(); i++){
			gwangju_img_select.set(i, fullPath(gwangju_img_select.get(i)));
		}
		logger.debug("광주 이미지 가져오기 서비스 종료");
		return gwangju_img_select;
	}
	
	
	
	
	
	
	

	
}
