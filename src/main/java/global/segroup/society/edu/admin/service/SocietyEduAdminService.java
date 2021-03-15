/**
 * 
 */
package global.segroup.society.edu.admin.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.mail.MessagingException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import global.segroup.dao.SEGroupCommonDAO;
import global.segroup.domain.Admin;
import global.segroup.domain.BoardContent;
import global.segroup.domain.BoardFile;
import global.segroup.domain.BoardGroup;
import global.segroup.domain.FaqConsultingContents;
import global.segroup.domain.OfflineConsultingContents;
import global.segroup.domain.OnlineConsultingContents;
import global.segroup.domain.User;
import global.segroup.society.edu.admin.dao.SocietyEduAdminDAO;
import global.segroup.society.edu.admin.domain.SocietyEduAdminBanner;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculum;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculumGisu;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculumGisuImg;
import global.segroup.society.edu.admin.domain.SocietyEduAdminPayment;
import global.segroup.society.edu.admin.domain.SocietyEduAdminSubBanner;
import global.segroup.society.edu.apply.domain.SocietyEduApplyResult;
import global.segroup.society.edu.user.domain.RefundInfo;
import global.segroup.util.FileService;
import global.segroup.util.MailService;

/**
 * @Author : 이종호
 * @Date : 2017. 8. 4.
 * @Class 설명 : Soft Engineer Society 모집홍보 관리자 서비스
 * 
 */
@Service
public class SocietyEduAdminService {

	private static final Logger logger = LoggerFactory.getLogger(SocietyEduAdminService.class);

	@Autowired
	private SocietyEduAdminDAO seaDAO;

	@Autowired
	private SEGroupCommonDAO segDAO;

	/**
	 * 메일을 보내는 서비스
	 */
	@Autowired
	private MailService mail;

	/**
	 * file.propertices 의 등록된 도서관리 공지사항 파일 경로
	 */
	@Value("#{props['edu.book.board_file']}")
	private String eduBookBoardFile;

	/**
	 * file.propertices 의 등록된 도서관리 동영상 게시판 파일 경로
	 */
	@Value("#{props['edu.book.board_movie']}")
	private String eduBookBoardMovie;

	/**
	 * file.propertices 의 등록된 도서관리 사진 게시판 파일 경로
	 */
	@Value("#{props['edu.book.board_photo']}")
	private String eduBookBoardPhoto;

	/**
	 * file.propertices 의 등록된 도서관리 질문 게시판 파일 경로
	 */
	@Value("#{props['edu.book.board_question']}")
	private String eduBookBoardQuestion;

	/**
	 * file.propertices 의 등록된 모집홍보 공지사항 파일 경로
	 */
	@Value("#{props['edu.apply.board_file']}")
	private String eduApplyBoardFile;

	/**
	 * file.propertices 의 등록된 모집홍보 동영상 게시판 파일 경로
	 */
	@Value("#{props['edu.apply.board_movie']}")
	private String eduApplyBoardMovie;

	/**
	 * file.propertices 의 등록된 모집홍보 사진 게시판 파일 경로
	 */
	@Value("#{props['edu.apply.board_photo']}")
	private String eduApplyBoardPhoto;

	/**
	 * file.propertices 의 등록된 모집홍보 질문 게시판 파일 경로
	 */
	@Value("#{props['edu.apply.board_question']}")
	private String eduApplyBoardQuestion;

	/**
	 * file.propertices 의 등록된 과정 기수 등록 이미지 파일 경로
	 */
	@Value("#{props['edu.apply.curriculum_gisu_insert_image']}")
	private String eduApplyCurriculumGisuInsertImage;
	
	/**
	 * file.propertices 의 등록된 서브 배너 등록 이미지 파일 경로
	 */
	@Value("#{props['edu.admin.subbanner_save_image']}")
	private String eduAdminSubbanerSaveImage;
	
	/**
	 * file.propertices 의 등록된 배너 등록 이미지 파일 경로
	 */
	@Value("#{props['edu.admin.banner_save_image']}")
	private String eduAdminBannerSaveImage;
	
	/**
	 * file.propertices 의 등록된 과정 기수 세부 등록 이미지 파일 경로
	 */
	@Value("#{props['edu.admin.curriculum_gisu_insert_image']}")
	private String eduAdminCurriculumGisuInsertImage;
	
	/**
	 * file.propertices 의 등록된 메일 관련 파일 경로
	 */
	@Value("#{props['edu.apply.mail']}")
	private String eduApplyMailPath;

	/**
	 * file.propertices 의 등록된 잡페어 기업메인 공지사항 파일
	 */
	@Value("#{props['fap.company.board_file']}")
	private String fapCompanyBoardFile;
	
	/**
	 * file.propertices 의 등록된 잡페어 기업메인 공지사항 동영상
	 */
	@Value("#{props['fap.company.board_movie']}")
	private String fapCompanyBoardMovie;
	
	/**
	 * file.propertices 의 등록된 잡페어 기업메인 공지사항 사진
	 */
	@Value("#{props['fap.company.board_photo']}")
	private String fapCompanyBoardPhoto;
	
	/**
	 * file.propertices 의 등록된 잡페어 기업메인 공지사항 질문
	 */
	@Value("#{props['fap.company.board_question']}")
	private String fapCompanyBoardQuestion;
	
	/**
	 * @Method Name : curriculum_insert
	 * @Date : 2018. 9. 17.
	 * @User : 이종호
	 * @Param : 관리자 정보
	 * @Return : -
	 * @Method 설명 : 관리자 회원 가입 서비스 함수
	 */
	public void admin_insert(Admin admin) {
		logger.debug("관리자 회원 가입 서비스 시작");
		
		seaDAO.admin_insert(admin);
		
		logger.debug("관리자 회원 가입 서비스 종료");
	}
	
	/**
	 * @Method Name : admin_info_list_select
	 * @Date : 2018. 9. 17.
	 * @User : 이종호
	 * @Param : 페이징 및 검색어
	 * @Return : 관리자 정보 리스트
	 * @Method 설명 : 관리자 정보 리스트 조회 서비스 함수
	 */	
	public ArrayList<Admin> admin_info_list_select(HashMap<String, Object> map){
		logger.debug("관리자 정보 리스트 조회 서비스 시작");
		
		ArrayList<Admin> result = seaDAO.admin_info_list_select(map);
		
		logger.debug("관리자 정보 리스트 조회 서비스 종료");
		
		return result;
	}
	
	/**
	 * @Method Name : admin_info_list_select_count
	 * @Date : 2018. 9. 17.
	 * @User : 이종호
	 * @Param : 관리자 이름 (검색어)
	 * @Return : 관리자 정보 전체 개수 (검색된)
	 * @Method 설명 : 관리자 정보 전체 개수 조회 
	 */
	public int admin_info_list_select_count(HashMap<String, Object> map) {
		logger.debug("관리자 정보 전체 개수 조회 서비스 시작");
		
		int result = seaDAO.admin_info_list_select_count(map);
		
		logger.debug("관리자 정보 전체 개수 조회 서비스 종료");
		
		return result;
	}
	
	/**
	 * @Method Name : admin_info_update
	 * @Date : 2018. 9. 17
	 * @User : 이종호
	 * @Param : 관리자 정보 공통코드 (권한 , 상태 , 프로젝트) 및 권한기간
	 * @Return : -
	 * @Method 설명 : 관리자 정보 수정 서비스 함수
	 */		
	public void admin_info_update(Admin admin) {
		logger.debug("관리자 정보 수정 서비스 시작");
		
		seaDAO.admin_info_update(admin);
		
		logger.debug("관리자 정보 수정 서비스 종료");
	}
	
	/**
	 * @Method Name : curriculum_insert
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 과정 개설 정보
	 * @Return : -
	 * @Method 설명 : 과정 개설 정보를 등록하는 서비스 함수
	 */
	public void curriculum_insert(SocietyEduAdminCurriculum seaCur) {
		logger.debug("과정 개설 등록 서비스 시작");

		seaDAO.curriculum_insert(seaCur);

		logger.debug("과정 개설 등록 서비스 종료");
	}

	/**
	 * @Method Name : payInfoInsert
	 * @Date : 2017. 12. 4.
	 * @User : 전상수
	 * @Param : 과정 결제 정보
	 * @Return : -
	 * @Method 설명 : 과정 결제 정보를 등록하는 서비스 함수
	 */
	public void payInfoInsert(SocietyEduAdminPayment seap) {
		logger.debug("과정 개설 등록 서비스 시작");

		seaDAO.payInfoInsert(seap);

		logger.debug("과정 개설 등록 서비스 종료");
	}

	/**
	 * @Method Name : payInfoInsert
	 * @Date : 2017. 12. 4.
	 * @User : 전상수
	 * @Param : 과정 결제 정보
	 * @Return : -
	 * @Method 설명 : 과정 결제 정보를 등록하는 서비스 함수
	 */
	public void payInfoDelete(SocietyEduAdminPayment seap) {
		logger.debug("과정 개설 삭제 서비스 시작");

		seaDAO.payInfoDelete(seap);

		logger.debug("과정 개설 삭제 서비스 종료");
	}

	/**
	 * @Method Name : searchCurriculumAndGisu
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 과정 시퀀스 정보
	 * @Return : 과정 정보 및 해당 과정의 기수 정보들을 가진 맵 객체
	 * @Method 설명 : 과정 시퀀스로 과정 정보와 기수정보들을 조회 하는 서비스 함수
	 */
	@Transactional
	public HashMap<String, Object> searchCurriculumAndGisu(int crc_seq) {
		logger.debug("특정 과정 정보 및 기수 정보들을 조회하는 서비스 시작");

		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("seaCurriculum", seaDAO.searchCurriculum(crc_seq));
		resultMap.put("seaCurGisuList", seaDAO.searchCurGisuList(crc_seq));

		logger.debug("특정 과정 정보 및 기수 정보들을 조회하는 서비스 종료");
		return resultMap;
	}

	/**
	 * @Method Name : searchCurriculumGisuOrder
	 * @Date : 2017. 12. 19.
	 * @User : 전상수
	 * @Param : 기수 시퀀스 정보
	 * @Return : 과정 정보 및 해당 기수의 결제 정보들을 가진 맵 객체
	 * @Method 설명 : 과기수시퀀스로 결제분납 정보를 조회 하는 서비스 함수
	 */
	@Transactional
	public ArrayList<HashMap<String, Object>> searchCurriculumGisuOrder(int gisu_seq) {
		logger.debug("특정 과정 정보 및 기수 정보들을 조회하는 서비스 시작");

		ArrayList<HashMap<String, Object>> resultMap = new ArrayList<HashMap<String, Object>>();
		resultMap = seaDAO.searchCurriculumGisuOrder(gisu_seq);
		logger.debug("특정 과정 정보 및 기수 정보들을 조회하는 서비스 종료");
		return resultMap;
	}

	/**
	 * @Method Name : searchCurriculumAllCount
	 * @Date : 2017. 02. 08.
	 * @User : 박기호
	 * @Param : -
	 * @Return : 전체 과정 정보 리스트 count
	 * @Method 설명 : 전체 과정 정보 count를 조회하는 서비스 함수
	 */
	public int searchCurriculumAllCount() {
		logger.debug("전체 과정 정보 count를 조회하는 서비스 시작");

		int result = seaDAO.searchCurriculumAllCount();

		logger.debug("전체 과정 정보 count를 조회하는 서비스 종료");
		return result;
	}

	/**
	 * @Method Name : searchCurriculumAll
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 전체 과정 정보 리스트 객체
	 * @Method 설명 : 전체 과정 정보를 조회하는 서비스 함수
	 */
	public ArrayList<SocietyEduAdminCurriculum> searchCurriculumAll(HashMap<String, Object> map) {
		logger.debug("전체 과정 정보를 조회하는 서비스 시작");

		ArrayList<SocietyEduAdminCurriculum> resultList = new ArrayList<>();
		resultList = seaDAO.searchCurriculumAll(map);

		logger.debug("전체 과정 정보를 조회하는 서비스 종료");
		return resultList;
	}

	/**
	 * @Method Name : searchCurriculumPermission
	 * @Date : 2017. 8. 18.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 승인된 과정들 정보 리스트 객체
	 * @Method 설명 : 승인된 과정들 정보를 조회하는 서비스 함수
	 */
	public ArrayList<SocietyEduAdminCurriculum> searchCurriculumPermission() {
		logger.debug("승인된 과정들 정보를 조회하는 서비스 시작");

		ArrayList<SocietyEduAdminCurriculum> resultList = new ArrayList<>();
		resultList = seaDAO.searchCurriculumPermission();

		logger.debug("승인된 과정들 정보를 조회하는 서비스 종료");
		return resultList;
	}

	/**
	 * @Method Name : searchCurriculumRefund
	 * @Date : 2017. 12. 26.
	 * @User : 전상수
	 * @Param : -
	 * @Return : 환불 정보 리스트 객체
	 * @Method 설명 : 환불 정보를 조회하는 서비스 함수
	 */
	public ArrayList<HashMap<String, Object>> searchCurriculumRefund() {
		logger.debug("승인된 과정들 정보를 조회하는 서비스 시작");

		ArrayList<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();
		resultList = seaDAO.searchCurriculumRefund();

		logger.debug("승인된 과정들 정보를 조회하는 서비스 종료");
		return resultList;
	}

	/**
	 * @param map
	 * @Method Name : searchCurriculumGisuAllCount
	 * @Date : 2018. 02. 08.
	 * @User : 박기호
	 * @Param : -
	 * @Return : 전체 과정의 전체 기수 count
	 * @Method 설명 : 전체 과정의 전체 기수 count를 조회하는 서비스 함수
	 */
	public int searchCurriculumGisuAllCount(HashMap<String, Object> map) {
		logger.debug("전체 과정의 전체 기수 count를 조회하는 서비스 시작");

		int result = seaDAO.searchCurriculumGisuAllCount(map);

		logger.debug("전체 과정의 전체 기수 정보를 조회하는 서비스 종료");
		return result;
	}

	/**
	 * @Method Name : searchCurriculumGisuAll
	 * @Date : 2017. 8. 16.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 전체 과정의 전체 기수 정보 리스트 객체
	 * @Method 설명 : 전체 과정의 전체 기수 정보를 조회하는 서비스 함수
	 */
	public ArrayList<SocietyEduAdminCurriculumGisu> searchCurriculumGisuAll(HashMap<String, Object> map) {
		logger.debug("전체 과정의 전체 기수 정보를 조회하는 서비스 시작");

		ArrayList<SocietyEduAdminCurriculumGisu> resultList = new ArrayList<>();
		resultList = seaDAO.searchCurriculumGisuAll(map);

		logger.debug("전체 과정의 전체 기수 정보를 조회하는 서비스 종료");
		return resultList;
	}

	/**
	 * @Method Name : searchCurriculum
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 과정 시퀀스 정보
	 * @Return : 과정 정보 객체
	 * @Method 설명 : 과정 시퀀스로 특정 과정 정보를 조회 하는 서비스 함수
	 */
	public SocietyEduAdminCurriculum searchCurriculum(int crc_seq) {
		logger.debug("특정 과정 정보를 조회하는 서비스 시작");

		SocietyEduAdminCurriculum seaCurriculum = seaDAO.searchCurriculum(crc_seq);

		logger.debug("특정 과정 정보를 조회하는 서비스 종료");
		return seaCurriculum;
	}

	/**
	 * @Method Name : curriculum_update
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 과정 수정 정보
	 * @Return : -
	 * @Method 설명 : 전달 받은 과정 정보를 수정하는 서비스 함수
	 */
	public void curriculum_update(SocietyEduAdminCurriculum seaCur) {
		logger.debug("특정 과정 정보를 수정하는 서비스 시작");

		seaDAO.curriculum_update(seaCur);

		logger.debug("특정 과정 정보를 수정하는 서비스 종료");

	}

	/**
	 * @Method Name : searchCurGisuList
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 과정 시퀀스 정보
	 * @Return : 기수 정보 리스트 객체
	 * @Method 설명 : 전달 받은 과정 시퀀스 정보의 기수 정보 리스트를 전달하는 서비스 함수
	 */
	public ArrayList<SocietyEduAdminCurriculumGisu> searchCurGisuList(int crc_seq) {
		logger.debug("기수 정보 검색 서비스 시작");

		ArrayList<SocietyEduAdminCurriculumGisu> resultList = new ArrayList<>();
		resultList = seaDAO.searchCurGisuList(crc_seq);

		logger.debug("기수 정보 검색 서비스 종료");

		return resultList;
	}

	/**
	 * @Method Name : searchCurGisuImgList
	 * @Date : 2018. 9. 28.
	 * @User : 신동철
	 * @Param : 과정 시퀀스 정보
	 * @Return : 기수 이미지 정보 리스트 객체
	 * @Method 설명 : 전달 받은 과정 시퀀스 정보의 기수 이미지 정보 리스트를 전달하는 서비스 함수
	 */
	public ArrayList<SocietyEduAdminCurriculumGisuImg> searchCurGisuImgList(int gisu_seq) {
		logger.debug("기수 정보 검색 서비스 시작");

		ArrayList<SocietyEduAdminCurriculumGisuImg> resultList = new ArrayList<>();
		resultList = seaDAO.searchCurGisuImgList(gisu_seq);

		logger.debug("기수 정보 검색 서비스 종료");

		return resultList;
	}
	
	/**
	 * @Method Name : searchCurGisu
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 기수 시퀀스 정보
	 * @Return : 기수 정보 객체
	 * @Method 설명 : 전달 받은 기수 시퀀스 정보의 특정 기수 정보를 전달하는 서비스 함수
	 */
	public SocietyEduAdminCurriculumGisu searchCurGisu(int gisu_seq) {
		logger.debug("특정 기수 정보 검색 서비스 시작");

		SocietyEduAdminCurriculumGisu seaCurGisu = seaDAO.searchCurGisu(gisu_seq);

		logger.debug("특정 기수 정보 검색 서비스 종료");

		return seaCurGisu;
	}
	
	/**
	 * @Method Name : subbanner_insert
	 * @Date : 2018. 9. 20.
	 * @User : 정대영
	 * @Param : 서브 배너 정보 객체
	 * @Return : -
	 * @Method 설명 : 전달 받은 서브 배너 정보를 등록하는 서비스 함수
	 */
	public void subbanner_insert(SocietyEduAdminSubBanner seaSb) {
		logger.debug("기수 정보 등록 서비스 시작");
		// 파일서버에 파일 업로드
		UploadFileServer(seaSb);		
		seaDAO.subbanner_insert(seaSb);

		logger.debug("기수 정보 등록 서비스 종료");
	}
	
	/**
	 * @Method Name : subbanner_update
	 * @Date : 2018. 9. 28.
	 * @User : 정대영
	 * @Param : 서브 배너 정보 객체
	 * @Return : -
	 * @Method 설명 : 전달 받은 서브 배너 정보를 수정하는 서비스 함수
	 */
	public void subbanner_update(SocietyEduAdminSubBanner seaSb) {
		logger.debug("서브 배너 정보 수정 서비스 시작");
		boolean isMainBanner = false;
		
		//사진파일을 변경했을 때
		if(!seaSb.getEdu_sub_ban_file().isEmpty()){
			// 파일서버에서 파일 제거
			DeleteFileServer(seaSb.getEdu_sub_ban_saved(), isMainBanner);
			// 새로운파일 새로 저장하고 DB수정
			UploadFileServer(seaSb);
		}		
		seaDAO.subbanner_update(seaSb);

		logger.debug("서브 배너 정보 수정 서비스 종료");
	}
	
	/**
	 * @Method Name : subbanner_delete
	 * @Date : 2018. 10. 1.
	 * @User : 정대영
	 * @Param : 서브 배너 정보 시퀀스, 파일의 저장 명
	 * @Return : -
	 * @Method 설명 : 전달 받은 서브 배너 정보를 삭제하는 서비스 함수
	 */
	public void subbanner_delete(int edu_sub_ban_seq, String edu_sub_ban_saved) {
		logger.debug("서브 배너 정보 삭제 서비스 시작");
		boolean isMainBanner = false;
		
		//파일 삭제 후 데이터베이스 정보 삭제
		DeleteFileServer(edu_sub_ban_saved, isMainBanner);
		seaDAO.subbanner_delete(edu_sub_ban_seq);

		logger.debug("서브 배너 정보 수정 서비스 종료");
	}
	
	/**
	 * @Method Name : banner_delete
	 * @Date : 2018. 10. 2.
	 * @User : 정대영
	 * @Param : 배너 정보 시퀀스, 파일의 저장 명
	 * @Return : -
	 * @Method 설명 : 전달 받은 배너 정보를 삭제하는 서비스 함수
	 */
	public void banner_delete(int edu_ban_seq, String edu_ban_saved) {
		logger.debug("메인 배너 삭제 서비스 시작");
		boolean isMainBanner = true;
		
		//파일 삭제 후 데이터베이스 정보 삭제
		DeleteFileServer(edu_ban_saved, isMainBanner);
		seaDAO.banner_delete(edu_ban_seq);

		logger.debug("메인 배너 정보 수정 서비스 종료");
	}
	
	/**
	 * @Method Name : DeleteFileServer
	 * @Date : 2018. 9. 20
	 * @User : 정대영
	 * @Param : Society 서브 배너 정보 객체에 이미지 파일 저장명
	 * @Return : -
	 * @Method 설명 : 파일서버에서 중복 저장된 파일제거
	 */
	private void DeleteFileServer(String edu_sub_ban_saved, Boolean isMainBanner) {
		try {
			if(isMainBanner == true){
				//배너 이미지 파일 삭제
				FileService.deleteFile(edu_sub_ban_saved, eduAdminBannerSaveImage);
			} else{
				//서브배너 이미지 파일 삭제
				FileService.deleteFile(edu_sub_ban_saved, eduAdminSubbanerSaveImage);
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @Method Name : UploadFileServer
	 * @Date : 2018. 9. 20
	 * @User : 정대영
	 * @Param : Society 서브 배너 정보 객체
	 * @Return : -
	 * @Method 설명 : 파일서버에 이미지파일을 업로드하고 경로를 돌려받아 과정정보 객체에 설정
	 */
	private void UploadFileServer(SocietyEduAdminSubBanner seaSb) {
		try {
			if (seaSb.getEdu_sub_ban_file() != null) {
				seaSb.setEdu_sub_ban_origin(seaSb.getEdu_sub_ban_file().getOriginalFilename());
				seaSb.setEdu_sub_ban_saved(FileService.saveFile(seaSb.getEdu_sub_ban_file(), eduAdminSubbanerSaveImage));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @Method Name : curriculum_gisu_update
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 기수 정보 객체
	 * @Return : -
	 * @Method 설명 : 전달 받은 기수 정보를 수정하는 서비스 함수
	 */
	public void curriculum_gisu_update(SocietyEduAdminCurriculumGisu seaCurGisu) {
		logger.debug("기수 정보 수정 서비스 시작");

		seaDAO.curriculum_gisu_update(seaCurGisu);

		logger.debug("기수 정보 수정 서비스 종료");
	}

	/**
	 * @Method Name : curriculum_permission_update
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 과정 정보 객체(과정 시퀀스, 승인 코드, 수정 인)
	 * @Return : 변경 여부, 변경된 코드 , 메세지 등을 포함하는 맵 객체
	 * @Method 설명 : 전달 받은 과정 승인 정보를 수정하는 서비스 함수
	 */
	public HashMap<String, Object> curriculum_permission_update(SocietyEduAdminCurriculum seaCur) {
		logger.debug("과정 승인 정보 수정 서비스 시작");

		HashMap<String, Object> resultMap = new HashMap<>();

		boolean crc_per_flag = true;
		String crc_per = seaCur.getCrc_per();
		String message = "과정 승인 정보가 변경 되었습니다.";

		// 미승인 -> 승인 의 경우
		if (crc_per.equals("B1300")) {
			seaCur.setCrc_per("B1301");
			seaDAO.curriculum_permission_update(seaCur);
		}
		// 승인 -> 미승인 의 경우
		else if (crc_per.equals("B1301")) {
			int count = seaDAO.curriculum_apply_select(seaCur.getCrc_seq());
			if (count == 0) {
				seaCur.setCrc_per("B1300");
				seaDAO.curriculum_permission_update(seaCur);
			} else {
				crc_per_flag = false;
				message = "과정 신청자 정보가 있습니다.";
			}
		}
		resultMap.put("crc_per_flag", crc_per_flag);
		resultMap.put("crc_per", seaCur.getCrc_per());
		resultMap.put("message", message);

		logger.debug("과정 승인 정보 수정 서비스 종료");
		return resultMap;
	}

	/**
	 * @Method Name : curriculum_gisu_permission_update
	 * @Date : 2017. 8. 18.
	 * @User : 이종호
	 * @Param : 기수 정보 객체(기수 시퀀스, 노출 승인 코드, 수정 인)
	 * @Return : -
	 * @Method 설명 : 기수 노출 승인 정보를 수정하는 서비스 함수
	 */
	public HashMap<String, Object> curriculum_gisu_permission_update(SocietyEduAdminCurriculumGisu seaCurGisu) {
		logger.debug("기수 노출 승인 정보 수정 서비스 시작");

		HashMap<String, Object> resultMap = new HashMap<>();
		boolean gisu_per_flag = true;
		String gisu_per = seaCurGisu.getGisu_per();
		String message = "기수 노출 승인 정보가 변경 되었습니다.";

		// 미승인 -> 승인 의 경우
		if (gisu_per.equals("B1500")) {
			seaCurGisu.setGisu_per("B1501");
			seaDAO.curriculum_gisu_permission_update(seaCurGisu);
		}
		// 승인 -> 미승인 의 경우
		else if (gisu_per.equals("B1501")) {
			int count = seaDAO.curriculum_gisu_apply_select(seaCurGisu.getGisu_seq());
			if (count == 0) {
				seaCurGisu.setGisu_per("B1500");
				seaDAO.curriculum_gisu_permission_update(seaCurGisu);
			} else {
				gisu_per_flag = false;
				message = "기수 신청자 정보가 있습니다.";
			}
		}
		resultMap.put("gisu_per_flag", gisu_per_flag);
		resultMap.put("gisu_per", seaCurGisu.getGisu_per());
		resultMap.put("message", message);

		logger.debug("기수 노출 승인 정보 수정 서비스 종료");
		return resultMap;
	}

	/**
	 * @Method Name : apply_manager_select_count
	 * @Date : 2018. 02. 08.
	 * @User : 박기호
	 * @Param : 기수 시퀀스, 이름
	 * @Return : 해당 기수의 신청자 count
	 * @Method 설명 : 특정 기수의 신청자 count를 조회하는 서비스 함수
	 */
	public int apply_manager_select_count(HashMap<String, Object> map) {
		logger.debug("특정 기수의 신청자 정보들을 조회하는 서비스 시작");
		logger.debug("특정 기수의 신청자 정보들을 조회하는 서비스 종료");
		return seaDAO.apply_manager_select_count(map);
	}

	/**
	 * @Method Name : apply_manager_select
	 * @Date : 2017. 8. 18.
	 * @User : 이종호, 박기호 수정
	 * @Param : 기수 시퀀스, 검색어, 페이징객체
	 * @Return : 해당 기수의 신청자 정보들 리스트 객체
	 * @Method 설명 : 특정 기수의 신청자 정보들을 조회하는 서비스 함수
	 */
	public ArrayList<HashMap<String, Object>> apply_manager_select(HashMap<String, Object> map) {
		logger.debug("특정 기수의 신청자 정보들을 조회하는 서비스 시작");
		logger.debug("특정 기수의 신청자 정보들을 조회하는 서비스 종료");
		return seaDAO.apply_manager_select(map);
	}

	/**
	 * @Method Name : paid_manager_select
	 * @Date : 2017. 12. 19.
	 * @User : 전상수
	 * @Param : 기수 시퀀스
	 * @Return : 해당 기수의 결제자 정보들 리스트 객체
	 * @Method 설명 : 특정 기수의 결제자 정보들을 조회하는 서비스 함수
	 */
	public ArrayList<HashMap<String, Object>> paid_manager_select(HashMap<String, Object> map) {
		logger.debug("특정 기수의 결제자 정보들을 조회하는 서비스 시작");
		logger.debug("특정 기수의 결제자 정보들을 조회하는 서비스 종료");
		return seaDAO.paid_manager_select(map);
	}

	/**
	 * @Method Name : paid_manager_select
	 * @Date : 2017. 12. 19.
	 * @User : 전상수
	 * @Param : 기수 시퀀스
	 * @Return : 해당 기수의 결제자 정보들 리스트 객체
	 * @Method 설명 : 특정 기수의 결제자 정보들을 조회하는 서비스 함수
	 */
	public ArrayList<HashMap<String, Object>> refund_manager_select(HashMap<String, Object> map) {
		logger.debug("특정 기수의 환불 신청자 정보들을 조회하는 서비스 시작");
		logger.debug("특정 기수의 환불 신청자 정보들을 조회하는 서비스 종료");
		return seaDAO.refund_manager_select(map);
	}

	/**
	 * @Method Name : paid_name_select
	 * @Date : 2017. 12. 19.
	 * @User : 전상수
	 * @Param : 이름
	 * @Return : 해당 이름의 결제자 정보들 리스트 객체
	 * @Method 설명 : 특정 이름의 결제자 정보들을 조회하는 서비스 함수
	 */
	public ArrayList<HashMap<String, Object>> paid_name_select(HashMap<String, Object> map) {
		logger.debug("특정 기수의 결제자 정보들을 조회하는 서비스 시작");
		logger.debug("특정 기수의 결제자 정보들을 조회하는 서비스 종료");
		return seaDAO.paid_name_select(map);
	}

	/**
	 * @Method Name : refund_name_select
	 * @Date : 2017. 12. 19.
	 * @User : 전상수
	 * @Param : 이름
	 * @Return : 해당 이름의 결제자 정보들 리스트 객체
	 * @Method 설명 : 특정 이름의 결제자 정보들을 조회하는 서비스 함수
	 */
	public ArrayList<HashMap<String, Object>> refund_name_select(HashMap<String, Object> map) {
		logger.debug("특정 기수의 환불신청자 정보들을 조회하는 서비스 시작");
		logger.debug("특정 기수의 환불신청자 정보들을 조회하는 서비스 종료");
		return seaDAO.refund_name_select(map);
	}

	/**
	 * @Method Name : eduApply_result_update
	 * @Date : 2017. 8. 24.
	 * @User : 이종호
	 * @Param : 특정 지원자의 결과 정보 객체
	 * @Return : -
	 * @Method 설명 : 특정 지원자의 결과 정보 수정하는 서비스 함수
	 */
	public void eduApply_result_update(SocietyEduApplyResult seaResult) {
		logger.debug("특정 지원자의 결과 정보 수정 서비스 시작");
		seaDAO.eduApply_result_update(seaResult);
		logger.debug("특정 지원자의 결과 정보 수정 서비스 시작");
	}

	/**
	 * @Method Name : board_name_search
	 * @Date : 2017. 8. 25.
	 * @User : 이종호
	 * @Param : 게시판 구분, 게시판 타입을 가진 게시판 그룹 객체
	 * @Return : 게시판 시퀀스, 게시판 이름을 가진 게시판 그룹 리스트 객체
	 * @Method 설명 : 특정 구분, 타입 값을 가진 게시판 그룹 리스트를 조회하는 서비스 함수
	 */
	public ArrayList<BoardGroup> board_name_search(BoardGroup boardGb) {
		logger.debug("게시판 그룹 리스트 조회 서비스 함수 시작");

		ArrayList<BoardGroup> resultList = seaDAO.board_name_search(boardGb);

		logger.debug("게시판 그룹 리스트 조회 서비스 함수 종료");
		return resultList;
	}

	/**
	 * @Method Name : board_contents_search
	 * @Date : 2017. 9. 8.
	 * @User : 이종호
	 * @Param : 게시판 시퀀스
	 * @Return : 특정 게시판 시퀀스에 해당하는 게시글 리스트 객체
	 * @Method 설명 : 특정 게시판 시퀀스에 해당하는 게시글을 조회하는 서비스함수
	 */
	public ArrayList<BoardContent> board_contents_search(HashMap<String, Object> map) {
		logger.debug("게시글 리스트 조회 서비스 함수 시작");

		ArrayList<BoardContent> resultList = seaDAO.board_contents_search(map);

		logger.debug("게시글 리스트 조회 서비스 함수 종료");

		return resultList;
	}
	
	/**
	 * @Method Name : company_board_contents_search
	 * @Date : 2019. 1. 23.
	 * @User : 신동철
	 * @Param : 게시판 시퀀스
	 * @Return : 잡페어 채용기업 메인 공지사항 정보
	 * @Method 설명 : 잡페어 채용기업 메인 공지사항 검색 서비스함수
	 */
	public ArrayList<BoardContent> company_board_contents_search(HashMap<String, Object> map) {
		logger.debug("잡페어 채용기업 메인 공지사항 검색 서비스함수 시작");

		ArrayList<BoardContent> resultList = seaDAO.company_board_contents_search(map);

		logger.debug("잡페어 채용기업 메인 공지사항 검색 서비스함수 종료");

		return resultList;
	}

	/**
	 * @Method Name : board_contents_hit_update
	 * @Date : 2017. 9. 29.
	 * @User : 이종호
	 * @Param : 게시글 시퀀스
	 * @Return : -
	 * @Method 설명 : 해당 게시글의 세부 내용 중 조회수를 증가 시키는 서비스 함수
	 */
	public void board_contents_hit_update(int board_content_seq) {
		logger.debug("게시글 세부 내용 중 조회수 증가 서비스 함수 시작");

		seaDAO.board_contents_hit_update(board_content_seq);

		logger.debug("게시글 세부 내용 중 조회수 증가 서비스 함수 종료");
	}

	/**
	 * @Method Name : board_contents_detail
	 * @Date : 2017. 9. 13.
	 * @User : 이종호
	 * @Param : 게시글 시퀀스
	 * @Return : 특정 게시글의 세부 정보 및 파일 정보를 담은 맵 객체
	 * @Method 설명 : 특정 게시글의 세부 정보 및 파일 정보를 조회하는 서비스함수
	 */
	public HashMap<String, Object> board_contents_detail(int board_content_seq) {
		logger.debug("게시글 세부 정보 조회 서비스 함수 시작");

		HashMap<String, Object> resultMap = seaDAO.board_contents_detail(board_content_seq);

		logger.debug("게시글 세부 정보 조회 서비스 함수 종료");
		return resultMap;
	}

	/**
	 * @Method Name : selectPayInfo
	 * @Date : 2017. 12. 5.
	 * @User : 전상수
	 * @Param : 결제시퀀스
	 * @Return : 특정 결제정보를 담은 맵 객체
	 * @Method 설명 : 특정 결제정보를 조회하는 서비스함수
	 */
	public List<HashMap<String, Object>> selectPayInfo(String gisu_seq) {
		logger.debug("결제정보를 조회 서비스 함수 시작");

		List<HashMap<String, Object>> resultMap = seaDAO.selectPayInfo(gisu_seq);

		logger.debug("결제정보를 조회 서비스 함수 종료");
		return resultMap;
	}

	/**
	 * @Method Name : board_contents_insert
	 * @Date : 2017. 9. 28.
	 * @User : 이종호
	 * @Param : 게시글 세부내용
	 * @Return : -
	 * @Method 설명 : 게시글을 등록하는 서비스 함수
	 */
	public void board_contents_insert(BoardContent boardContent) {
		logger.debug("게시글 세부 내용 등록 서비스 함수 시작");

		seaDAO.board_contents_insert(boardContent);

		logger.debug("게시글 세부 내용 등록 서비스 함수 종료");
	}

	/**
	 * @Method Name : board_contents_update
	 * @Date : 2017. 9. 25.
	 * @User : 이종호
	 * @Param : 게시글 세부내용
	 * @Return : -
	 * @Method 설명 : 게시글을 수정하는 서비스 함수
	 */
	public void board_contents_update(BoardContent boardContent) {
		logger.debug("게시글 세부 내용 수정 서비스 함수 시작");

		seaDAO.board_contents_update(boardContent);

		logger.debug("게시글 세부 내용 수정 서비스 함수 종료");
	}

	/**
	 * @Method Name : board_contents_file_insert
	 * @Date : 2017. 9. 27.
	 * @User : 이종호
	 * @Param : 게시글 파일 저장 경로, 게시글 파일 정보, 게시글 세부정보 시퀀스
	 * @Return : -
	 * @Method 설명 : 해당 게시글 세부 내용 등록 서비스 함수
	 */
	@Transactional
	public void board_contents_file_insert(String path, BoardFile boardFile, int board_content_seq, String id) {
		logger.debug("해당 게시글 파일 정보 등록 서비스 함수 시작");
		logger.error("해당 게시글 파일 정보 등록 서비스 함수 시작");
		// 해당 게시글 파일 정보 체크
		ArrayList<Integer> removeArr = new ArrayList<>();
		for (BoardFile fileObj : boardFile.getBoardFileList()) {

			if ((fileObj.getBoard_file_origin() == null) && (fileObj.getBoard_file_saved() != null)) {
				FileService.deleteFile(fileObj.getBoard_file_saved(), path);
			}

			if (fileObj.getBoard_file() != null && !fileObj.getBoard_file().isEmpty()) {
				String boardOrigin = fileObj.getBoard_file().getOriginalFilename();
				try {
					String boardSaved = FileService.saveFile(fileObj.getBoard_file(), path);
					fileObj.setBoard_file_saved(boardSaved);
					fileObj.setBoard_file_origin(boardOrigin);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				}
			} else {
				if (fileObj.getBoard_file_origin() == null) {
					removeArr.add(boardFile.getBoardFileList().indexOf(fileObj));
				}
			}
		}

		boardFile.setBoardFileList(removeEmptyList(boardFile.getBoardFileList(), removeArr));
		removeArr.clear();
		if (boardFile.getBoardFileList().size() != 0) {

			seaDAO.board_contents_file_insert(boardFile, board_content_seq, id);
			logger.error("등록!  {}", boardFile);
		}

		logger.debug("해당 게시글 파일 정보 등록 서비스 함수 종료");
	}

	/**
	 * @Method Name : removeEmptyList
	 * @Date : 2017. 9. 27.
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
	 * @Method Name : board_contents_file_delete
	 * @Date : 2017. 9. 26.
	 * @User : 이종호
	 * @Param : 게시글 세부내용(시퀀스)
	 * @Return : -
	 * @Method 설명 : 해당 게시글의 파일정보를 삭제하는 서비스 함수
	 */
	public void board_contents_file_delete(BoardContent boardContent) {
		logger.debug("해당 게시글의 파일정보를 삭제하는 서비스 함수 시작");

		seaDAO.board_contents_file_delete(boardContent);

		logger.debug("해당 게시글의 파일정보를 삭제하는 서비스 함수 종료");
	}

	/**
	 * @param map
	 * @Method Name : basic_user_select_all_count
	 * @Date : 2018. 02. 12.
	 * @User : 박기호
	 * @Param : -
	 * @Return : 일반 회원(등급)의 모든 회원 정보 count
	 * @Method 설명 : 일반 회원(등급)의 모든 회원 정보 count를 조회하는 서비스 함수
	 */
	public int basic_user_select_all_count(HashMap<String, Object> map) {
		logger.debug("일반 회원(등급)의 모든 회원정보count를 조회하는 서비스 함수 시작");

		int result = seaDAO.basic_user_select_all_count(map);

		logger.debug("일반 회원(등급)의 모든 회원정보 count를 조회하는 서비스 함수 종료");
		return result;
	}

	/**
	 * @Method Name : basic_user_select_all
	 * @Date : 2017. 9. 29.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 일반 회원(등급)의 모든 회원 정보를 가진 리스트 객체
	 * @Method 설명 : 일반 회원(등급)의 모든 회원 정보를 조회하는 서비스 함수
	 */
	public ArrayList<User> basic_user_select_all(HashMap<String, Object> map) {
		logger.debug("일반 회원(등급)의 모든 회원정보를 조회하는 서비스 함수 시작");

		ArrayList<User> resultList = seaDAO.basic_user_select_all(map);

		logger.debug("일반 회원(등급)의 모든 회원정보를 조회하는 서비스 함수 종료");
		return resultList;
	}

	/**
	 * @Method Name : user_info_select
	 * @Date : 2017. 10. 2.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : 특정 회원 정보 객체
	 * @Method 설명 : 특정 회원 정보를 조회하는 서비스 함수
	 */
	public User user_info_select(User userinfo) {
		logger.debug("특정 회원 정보를 조회하는 서비스 함수 시작");

		User user = segDAO.selectUser(userinfo);

		logger.debug("특정 회원 정보를 조회하는 서비스 함수 종료");

		return user;
	}

	/**
	 * @Method Name : findPath
	 * @Date : 2017. 9. 20.
	 * @User : 이종호
	 * @Param : 공통 그룹코드(공지사항 그룹, 공지사항 타입)
	 * @Return : 해당 게시판의 파일 저장 경로
	 * @Method 설명 : 각각의 파일을 저장할 경로를 구하는 함수
	 */
	public String findPath(String gb, String tp) {
		String path = "";
		// FS
		if (gb.equals("A0300")) {

		}
		// 모집홍보
		else if (gb.equals("A0301")) {
			// 공지사항
			if (tp.equals("A0400")) {
				path = eduApplyBoardFile;
			}
			// 동영상
			else if (tp.equals("A0401")) {
				path = eduApplyBoardMovie;
			}
			// 사진
			else if (tp.equals("A0402")) {
				path = eduApplyBoardPhoto;
			}
			// 질문
			else if (tp.equals("A0403")) {
				path = eduApplyBoardQuestion;
			}
		}
		// 도서관리
		else if (gb.equals("A0302")) {
			// 공지사항
			if (tp.equals("A0400")) {
				path = eduBookBoardFile;
			}
			// 동영상
			else if (tp.equals("A0401")) {
				path = eduBookBoardMovie;
			}
			// 사진
			else if (tp.equals("A0402")) {
				path = eduBookBoardPhoto;
			}
			// 질문
			else if (tp.equals("A0403")) {
				path = eduBookBoardQuestion;
			}
		}
		// 공인시험센터
		else if (gb.equals("A0303")) {
		 
		//잡페어
		}else if(gb.equals("A0305")) {
			// 공지사항
			if (tp.equals("A0400")) {
				path = fapCompanyBoardFile;
			}
			// 동영상
			else if (tp.equals("A0401")) {
				path = fapCompanyBoardMovie;
			}
			// 사진
			else if (tp.equals("A0402")) {
				path = fapCompanyBoardPhoto;
			}
			// 질문
			else if (tp.equals("A0403")) {
				path = fapCompanyBoardQuestion;
			}
		}
		return path;
	}

	/**
	 * @Method Name : refund_status_update
	 * @Date : 2018. 2. 7.
	 * @User : SCITMaster
	 * @Param : 환불 정보
	 * @Return :
	 * @Method 설명 : 환불 상태를 변경하는 함수
	 */
	public int refund_status_update(RefundInfo pay_refund_seq) {
		logger.debug("환불 상태를 변경하는 함수 시작");
		int result = seaDAO.refund_status_update(pay_refund_seq);
		logger.debug("환불 상태를 변경하는 함수 종료");
		return result;
	}

	/**
	 * @Method Name : refund_memo_update
	 * @Date : 2018. 2. 7.
	 * @User : SCITMaster
	 * @Param : 환불 정보
	 * @Return :
	 * @Method 설명 : 환불 메모 내용을 변경하는 함수
	 */
	public int refund_memo_update(RefundInfo refundInfo) {
		logger.debug("환불 메모 내용을 변경하는 함수 시작");
		int result = seaDAO.refund_memo_update(refundInfo);
		logger.debug("환불 메모 내용을 변경하는 함수 종료");
		return result;
	}

	/**
	 * @Method Name : refund_manager_list
	 * @Date : 2018. 2. 8.
	 * @User : SCITMaster
	 * @Param :
	 * @Return :
	 * @Method 설명 :
	 */
	public List<HashMap<String, Object>> refund_manager_list(HashMap<String, Object> map) {
		logger.debug("환불 메모 내용을 변경하는 함수 시작");
		List<HashMap<String, Object>> result = seaDAO.refund_manager_list(map);
		logger.debug("환불 메모 내용을 변경하는 함수 종료");
		return result;
	}

	/**
	 * @Method Name : delete_pay_info
	 * @Date : 2018. 2. 8.
	 * @User : SCITMaster
	 * @Param :
	 * @Return :
	 * @Method 설명 : 환불처리 완료 후 해당 결제데이터를 제거한다
	 */
	public int delete_pay_info(int pay_user_seq) {
		logger.debug("delete_pay_info 시작");
		int result = seaDAO.delete_pay_info(pay_user_seq);
		logger.debug("delete_pay_info 종료");
		return result;
	}

	/**
	 * @Method Name : select_refund_user_id
	 * @Date : 2018. 8. 20.
	 * @User : 이종호
	 * @Param : 환불 시퀀스
	 * @Return : 환불 받을 유저 아이디
	 * @Method 설명 : 환불 시퀀스로 환불 받을 유저 아이디 검색 (유저 권한 변경 시 사용)
	 */
	public RefundInfo select_refund_user_id(int pay_refund_seq) {
		logger.debug("환불 시퀀스로 환불 받을 유저 아이디 검색 서비스 시작");
		
		RefundInfo result = seaDAO.select_refund_user_id(pay_refund_seq);
		
		logger.debug("환불 시퀀스로 환불 받을 유저 아이디 검색 서비스 종료");
		
		return result;
	}
	
	/**
	 * @Method Name : selectPayByGisu
	 * @Date : 2018. 2. 10.
	 * @User : SCITMaster
	 * @Param :
	 * @Return :
	 * @Method 설명 :
	 */
	public List<HashMap<String, Object>> selectPayByGisu(int gisu_seq) {
		logger.debug("selectPayByGisu 시작");
		List<HashMap<String, Object>> result = seaDAO.selectPayByGisu(gisu_seq);
		logger.debug("selectPayByGisu 종료");
		return result;
	}

	/**
	 * @Method Name : insert_refund_temp
	 * @Date : 2018. 2. 10.
	 * @User : SCITMaster
	 * @Param :
	 * @Return :
	 * @Method 설명 :
	 */
	public int insert_refund_temp(int pay_user_seq) {
		logger.debug("insert_refund_temp 시작");
		int result = seaDAO.insert_refund_temp(pay_user_seq);
		logger.debug("insert_refund_temp 종료");
		return result;
	}

	/**
	 * @Method Name : paid_manager_select_count
	 * @Date : 2018. 2. 13.
	 * @User : SCITMaster
	 * @Param :
	 * @Return :
	 * @Method 설명 :
	 */
	public int paid_manager_select_count(HashMap<String, Object> map) {
		return seaDAO.paid_manager_select_count(map);
	}

	/**
	 * @Method Name : refund_manager_list_count
	 * @Date : 2018. 2. 13.
	 * @User : SCITMaster
	 * @Param :
	 * @Return :
	 * @Method 설명 :
	 */
	public int refund_manager_list_count(HashMap<String, Object> map) {
		return seaDAO.refund_manager_list_count(map);
	}

	/**
	 * @Method Name : selectEduApplyform
	 * @Date : 2018. 2. 13.
	 * @User : SCITMaster
	 * @Param :
	 * @Return :
	 * @Method 설명 :
	 */
	public HashMap<String, Object> selectEduApplyForm(HashMap<String, Object> map) {
		logger.debug("selectEduApplyForm 시작");
		HashMap<String, Object> result = seaDAO.selectEduApplyUpdateForm(map);
		logger.debug("selectEduApplyForm 종료");
		return result;
	}

	/**
	 * @Method Name : user_info_update
	 * @Date : 2018. 2. 14.
	 * @User : SCITMaster
	 * @Param :
	 * @Return :
	 * @Method 설명 :
	 */
	public int user_info_update(User user) {
		return seaDAO.user_info_update(user);
	}
	
	/**
	 * @Method Name : faq_manager_select_count
	 * @Date : 2018. 7. 24.
	 * @User : 김도훈
	 * @Param : -
	 * @Return : FAQ 상담 항목 정보 count
	 * @Method 설명 : FAQ 상담 항목 서비스 함수
	 */
	public int faq_manager_select_count(HashMap<String, Object> map) {
		logger.debug("FAQ 상담 항목 count를 조회하는 서비스 함수 시작");

		int result = seaDAO.faq_manager_select_count(map);

		logger.debug("FAQ 상담 항목 count를 조회하는 서비스 함수 종료");
		return result;
	}
	
	/**
	 * @Method Name : faq_manager_select_all
	 * @Date : 2018. 7. 27.
	 * @User : 김도훈
	 * @Param :
	 * @Return : FAQ 정보를 가진 리스트 객체
	 * @Method 설명 : FAQ 정보를 조회하는 서비스 함수
	 */
	public ArrayList<FaqConsultingContents> faq_manager_select_all(HashMap<String, Object> map) {
		logger.debug("온라인 상담 신청 정보를 조회하는 서비스 함수 시작");

		ArrayList<FaqConsultingContents> resultList = seaDAO.faq_manager_select_all(map);

		logger.debug("온라인 상담 신청 정보를 조회하는 서비스 함수 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : faq_manager_detail
	 * @Date : 2018. 7. 20.
	 * @User : 김도훈
	 * @Param : FAQ 게시판 글 시퀀스
	 * @Return : 특정 FAQ 게시판 글의 세부 정보 및 파일 정보를 담은 맵 객체
	 * @Method 설명 : 특정 FAQ 게시판 글의 세부 정보 및 파일 정보를 조회하는 서비스함수
	 */
	public HashMap<String, Object> faq_manager_detail(int consulting_seq) {
		logger.debug("FAQ 게시판 글 세부 정보 조회 서비스 함수 시작");

		HashMap<String, Object> resultMap = seaDAO.faq_manager_detail(consulting_seq);

		logger.debug("FAQ 게시판 글 세부 정보 조회 서비스 함수 종료");
		return resultMap;
	}

	/**
	 * @Method Name : faq_manager_contents_insert
	 * @Date : 2018. 7. 20.
	 * @User : 김도훈
	 * @Param : FAQ 게시판 글 세부내용
	 * @Return : -
	 * @Method 설명 : FAQ 게시판 글을 등록하는 서비스 함수
	 */
	public void faq_manager_contents_insert(FaqConsultingContents consultingContent) {
		logger.debug("FAQ 게시판 글 세부 내용 등록 서비스 함수 시작");

		seaDAO.faq_manager_contents_insert(consultingContent);

		logger.debug("FAQ 게시판 글 세부 내용 등록 서비스 함수 종료");
	}

	/**
	 * @Method Name : faq_manager_contents_update
	 * @Date : 2018. 7. 20.
	 * @User : 김도훈
	 * @Param : FAQ 상담 게시판 글 세부내용
	 * @Return : -
	 * @Method 설명 : FAQ 상담 게시판 글을 수정하는 서비스 함수
	 */
	public void faq_manager_contents_update(FaqConsultingContents consultingContent) {
		logger.debug("FAQ 게시판 글 세부 내용 수정 서비스 함수 시작");

		seaDAO.faq_manager_contents_update(consultingContent);

		logger.debug("FAQ 게시판 글 세부 내용 수정 서비스 함수 종료");
	}
	
	/**
	 * @Method Name : online_manager_select_count
	 * @Date : 2018. 7. 27.
	 * @User : 김도훈
	 * @Param : -
	 * @Return : 온라인 상담 신청 정보 count
	 * @Method 설명 : 온라인 상담 신청 서비스 함수
	 */
	public int online_manager_select_count(HashMap<String, Object> map) {
		logger.debug("온라인 상담 신청 정보count를 조회하는 서비스 함수 시작");

		int result = seaDAO.online_manager_select_count(map);

		logger.debug("온라인 상담 신청 count를 조회하는 서비스 함수 종료");
		return result;
	}

	/**
	 * @Method Name : online_manager_select_all
	 * @Date : 2018. 7. 27.
	 * @User : 김도훈
	 * @Param :
	 * @Return : 온라인 상담 신청 정보를 가진 리스트 객체
	 * @Method 설명 : 온라인 상담 신청 정보를 조회하는 서비스 함수
	 */
	public ArrayList<OnlineConsultingContents> online_manager_select_all(HashMap<String, Object> map) {
		logger.debug("온라인 상담 신청 정보를 조회하는 서비스 함수 시작");

		ArrayList<OnlineConsultingContents> resultList = seaDAO.online_manager_select_all(map);

		logger.debug("온라인 상담 신청 정보를 조회하는 서비스 함수 종료");
		return resultList;
	}

	/**
	 * @Method Name : online_manager_select
	 * @Date : 2018. 7. 27.
	 * @User : 김도훈
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 온라인 상담 신청 중 하나의 상세내용를 조회하는 서비스
	 */
	public OnlineConsultingContents online_manager_select(int consulting_seq) {
		logger.debug("온라인 상담 신청 중 하나의 상세내용를 조회하는 서비스 함수 시작");

		OnlineConsultingContents result = seaDAO.online_manager_select(consulting_seq);

		logger.debug("온라인 상담 신청 중 하나의 상세내용를 조회하는 서비스 함수 종료");
		return result;
	}
	
	/**
	 * @Method Name : online_manager_hit_update
	 * @Date : 2018. 7. 23.
	 * @User : 김도훈
	 * @Param : 온라인 상담 게시판 글 조회수 올리기
	 * @Return : -
	 * @Method 설명 : 온라인 상담 게시판 글의 조회수를 올리는 서비스 함수
	 */
	public void online_manager_hit_update(OnlineConsultingContents consultingContent) {
		logger.debug("온라인 상담 게시판 글 조회수 올리기 서비스 함수 시작");
			seaDAO.online_manager_contents_update(consultingContent);
			logger.debug("온라인 상담 게시판 글 조회수 올리기 서비스 함수 종료");
	}	

	/**
	 * @Method Name : online_manager_contents_insert
	 * @Date : 2018. 7. 20.
	 * @User : 김도훈
	 * @Param : 온라인 상담 게시판 글 세부내용
	 * @Return : -
	 * @Method 설명 : 온라인 상담 게시판 글을 등록하는 서비스 함수
	 */
	public void online_manager_contents_insert(OnlineConsultingContents consultingContent) {
		logger.debug("온라인 상담 게시판 글 세부 내용 등록 서비스 함수 시작");

		seaDAO.online_manager_contents_insert(consultingContent);

		logger.debug("온라인 상담 게시판 글 세부 내용 등록 서비스 함수 종료");
	}

	/**
	 * @Method Name : online_manager_contents_update
	 * @Date : 2018. 7. 20.
	 * @User : 김도훈
	 * @Param : 온라인 상담 게시판 글 세부내용
	 * @Return : -
	 * @Method 설명 : 온라인 상담 게시판 글을 수정하는 서비스 함수
	 */
	public void online_manager_contents_update(OnlineConsultingContents consultingContent) {
		logger.debug("온라인 상담 게시판 글 세부 내용 수정 서비스 함수 시작");

		seaDAO.online_manager_contents_update(consultingContent);

		logger.debug("온라인 상담 게시판 글 세부 내용 수정 서비스 함수 종료");
	}
	
	/**
	 * @Method Name : online_manager_reply_insert
	 * @Date : 2018. 7. 23.
	 * @User : 김도훈
	 * @Param : 온라인 상담 게시판 답변글 세부내용
	 * @Return : -
	 * @Method 설명 : 온라인 상담 게시판 답변글을 등록하는 서비스 함수
	 */
	public void online_manager_reply_insert(OnlineConsultingContents consultingContent) {
		logger.debug("온라인 상담 게시판 답변글 세부 내용 등록 서비스 함수 시작");

		seaDAO.online_manager_reply_insert(consultingContent);

		logger.debug("온라인 상담 게시판 답변글 세부 내용 등록 서비스 함수 종료");
	}

	/**
	 * @Method Name : online_manager_reply_update
	 * @Date : 2018. 7. 23.
	 * @User : 김도훈
	 * @Param : 온라인 상담 게시판 답변글 세부내용
	 * @Return : -
	 * @Method 설명 : 온라인 상담 게시판 답변글을 수정하는 서비스 함수
	 */
	public void online_manager_reply_update(OnlineConsultingContents consultingContent) {
		logger.debug("온라인 상담 게시판 답변글 세부 내용 수정 서비스 함수 시작");

		seaDAO.online_manager_reply_update(consultingContent);

		logger.debug("온라인 상담 게시판 답변글 세부 내용 수정 서비스 함수 종료");
	}

	/**
	 * @Method Name : offline_manager_select_count
	 * @Date : 2018. 7. 16.
	 * @User : 김지훈
	 * @Param : -
	 * @Return : 오프라인 상담 신청 정보 count
	 * @Method 설명 : 오프라인 상담 신청 서비스 함수
	 */
	public int offline_manager_select_count(HashMap<String, Object> map) {
		logger.debug("오프라인 상담 신청 정보count를 조회하는 서비스 함수 시작");

		int result = seaDAO.offline_manager_select_count(map);

		logger.debug("오프라인 상담 신청 count를 조회하는 서비스 함수 종료");
		return result;
	}

	/**
	 * @Method Name : offline_manager_select_all
	 * @Date : 2018. 7. 16.
	 * @User : 김지훈
	 * @Param :
	 * @Return : 오프라인 상담 신청 정보를 가진 리스트 객체
	 * @Method 설명 : 오프라인 상담 신청 정보를 조회하는 서비스 함수
	 */
	public ArrayList<OfflineConsultingContents> offline_manager_select_all(HashMap<String, Object> map) {
		logger.debug("오프라인 상담 신청 정보를 조회하는 서비스 함수 시작");

		ArrayList<OfflineConsultingContents> resultList = seaDAO.offline_manager_select_all(map);

		logger.debug("오프라인 상담 신청 정보를 조회하는 서비스 함수 종료");
		return resultList;
	}

	/**
	 * @Method Name : offline_manager_select
	 * @Date : 2018. 7. 17.
	 * @User : 김지훈
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 오프라인 상담 신청 중 하나의 상세내용를 조회하는 서비스
	 */
	public OfflineConsultingContents offline_manager_select(String seq) {
		logger.debug("오프라인 상담 신청 중 하나의 상세내용를 조회하는 서비스 함수 시작");

		OfflineConsultingContents result = seaDAO.offline_manager_select(seq);

		logger.debug("오프라인 상담 신청 중 하나의 상세내용를 조회하는 서비스 함수 종료");
		return result;
	}

	/**
	 * @param occ, send_mail_address 
	 * @Method Name : offline_manager_mail_send
	 * @Date : 2018. 7. 18.
	 * @User : 김지훈
	 * @Param : occ 오프라인 상담 신청자의 정보를 담을 객체
	 * @Return : boolean 성공여부
	 * @Method 설명 : 오프라인 상담 신청의 확인메일(답장) 정보을 DB에 저장 후, 
	 * 신청자에게 정보를 email 발송으로 알려준다.
	 */
	public boolean offline_manager_mail_send(OfflineConsultingContents occ, String send_mail_address) throws Exception {
		logger.debug("오프라인 상담 상세내용에 대한 메일답신 및 DB에 저장 서비스 시작");
		try {
			if (seaDAO.offline_manager_mail_send(occ) != 1) {
				// update 실패 시,
				throw new Exception("DB 입력 오류");
			}

//			System.out.println("send_mail_address : "+send_mail_address);
//			if (send_mail_address == null) {
//				send_mail_address = "softengineersociety.offlineconsulting@gmail.com";
//			} 입력을 받더라도 의미가 없다. mail.properties에서 직접 고정메일주소를 지정하고 있다.
			final String FROM = send_mail_address;
			final String TO = occ.getUser_email();
			final String SUBJECT = occ.getSend_mail_title();
			final String TEXT = occ.getSend_mail_contents();
			
			mail.sendMail(FROM, TO, SUBJECT, TEXT);

			logger.debug("오프라인 상담 상세내용에 대한 메일답신 및 DB에 저장 서비스 종료");
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
	 * @param 이메일들, 공통제목, 공통내용 
	 * @Method Name : sendMailingService
	 * @Date : 2018. 8. 21.
	 * @User : 김지훈
	 * @Return : 메일을 발송한 건수를 리턴한다.
	 * @Method 설명 : 특정 기수 지원자들 대상 메일발송을 같은 내용으로 각각 발송한다.
	 */
	public String sendMailingService(String emails, String subject, String content, String fileName, String filePath, Date sendDate) throws Exception {
		logger.debug("특정 기수 지원자들 대상 메일발송 서비스 시작");
		try {
			List<String> emailList = new ArrayList<String>(Arrays.asList(emails.split(",")));
			int count = 0;
			for (String email : emailList) {
				String FROM = "sesoc2019@gamil.com";
				String TO = email;
				mail.mailSending(FROM, TO, subject, content, null, null, sendDate);
				count++;
			}
			logger.debug("특정 기수 지원자들 대상 메일발송 서비스 종료");
			return String.valueOf(count);
		} catch (MessagingException e) {
			logger.debug("이메일 전송 오류");
			return e.getMessage();
		} catch (Exception e) {
			logger.debug("서비스 오류");
			return e.getMessage();
		}
	}
	
	/**
	 * @param adminId
	 * @Method Name : selectAdmin
	 * @Date : 2018. 8. 17.
	 * @User : 이종호
	 * @Param : 관리자 아이디
	 * @Return : 관리자 정보
	 * @Method 설명 : 관리자 아이디로 관리자 정보를 획득 
	 */
	public Admin selectAdmin(String adminId) {
		logger.debug("관리자 아이디로 관리자 정보 검색 시작");
		Admin admin = segDAO.selectAdmin(adminId);
		logger.debug("관리자 아이디로 관리자 정보 검색 종료");
		return admin;
	}

	/**
	 * @Method Name : board_contents_delete
	 * @Date : 2018. 8. 23.
	 * @User : 김지훈
	 * @Param : 게시글 등록번호
	 * @Method 설명 : 게시글의 등록번호에 해당하는 DB Data 삭제
	 */
	public void board_contents_delete(int board_content_seq) {
		logger.debug("게시글 세부 내용 삭제 서비스 함수 시작");

		seaDAO.board_contents_delete(board_content_seq);

		logger.debug("게시글 세부 내용 삭제 서비스 함수 종료");
	}
	
	/**
	 * @Method Name : board_search_count
	 * @Date : 2018. 9. 13.
	 * @User : 정대영
	 * @Param : -
	 * @Return : 관리자 게시판의 모든 게시물 개수
	 * @Method 설명 : 관리자 게시판 진입 시 모든 게시물 개수 조회
	 */
	
	public int board_search_all_count(HashMap<String, Object> map){
		logger.debug("관리자 게시판 모든 게시물 개수 조회 함수 시작");
		
		int board_all_count = seaDAO.board_search_all_count(map);

		logger.debug("관리자 게시판 모든 게시물 개수 조회 함수 종료");
		return board_all_count;
	}
	
	/**
	 * @Method Name : board_search_all
	 * @Date : 2018. 9. 12.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 관리자 게시판의 모든 게시물
	 * @Method 설명 : 관리자 게시판 진입 시 모든 게시물 조회
	 */
	
	public ArrayList<BoardGroup> board_search_all(HashMap<String, Object> map){
		logger.debug("관리자 게시판 모든 게시물 조회 함수 시작");
		
		ArrayList<BoardGroup> resultList = seaDAO.board_search_all(map);

		logger.debug("관리자 게시판 모든 게시물 조회 함수 종료");
		return resultList;
	}
	
	/**
	 * 
	 * @Method Name : board_contents_count
	 * @Date : 2018. 9. 13.
	 * @User : 원병호
	 * @Param : 관리자 게시판 관리의 특정 게시판 정보 객체
	 * @Return : 관리자 게시판의 특정 게시판의 게시글 갯수
	 * @Method 설명 : 페이징을 위한 전체글 갯수 조회
	 */
	public int board_contents_count(HashMap<String, Object> map){
		logger.debug("관리자 게시판 특정 게시판 개시글 갯수 함수 시작");
		
		int result = seaDAO.board_contents_count(map);
		
		logger.debug("관리자 게시판 특정 게시판 개시글 갯수 함수 종료");
		return result;
	}
	
	/**
	 * @Method Name : curriculum_gisu_insert
	 * @Date : 2018. 9. 18.
	 * @User : 신동철
	 * @Param : 기수 정보 객체
	 * @Return : 기수 시퀀스
	 * @Method 설명 : 전달 받은 기수 정보를 등록하는 서비스 함수
	 */
	public void curriculum_gisu_insert(SocietyEduAdminCurriculumGisu seaCurGisu) {
		logger.debug("기수 정보 등록 서비스 시작");
				
		seaDAO.curriculum_gisu_insert(seaCurGisu);

		logger.debug("기수 정보 등록 서비스 종료");
	}
	
	/**
	 * @Method Name : curriculum_gisu_img_insert
	 * @Date : 2018. 9. 18.
	 * @User : 신동철
	 * @Param : 기수 정보 이미지 객체
	 * @Return : -
	 * @Method 설명 : 기수 정보 이미지를 등록하는 서비스 함수
	 */
		
	public void curriculum_gisu_img_insert(SocietyEduAdminCurriculumGisuImg seaCurGisuImg) {
		logger.debug("기수 정보 등록 서비스 시작");
	
		// 파일서버에 파일 업로드하고 이미지 리스트 정보를 반환받음
		HashMap<String, ArrayList<SocietyEduAdminCurriculumGisuImg>> seaCurGisuImgMap= UploadFileServer(seaCurGisuImg);
		ArrayList<SocietyEduAdminCurriculumGisuImg>seaCurGisuImgList = seaCurGisuImgMap.get("insertList");
		if(seaCurGisuImgList != null)
		seaDAO.curriculum_gisu_img_insert(seaCurGisuImgList);	
		
		logger.debug("기수 정보 등록 서비스 종료");
	}
	
	/**
	 * @Method Name : curriculum_gisu_img_update
	 * @Date : 2018. 10. 1.
	 * @User : 신동철
	 * @Param : 기수 정보 이미지 객체
	 * @Return : -
	 * @Method 설명 : 기수 정보 이미지를 수정하는 서비스 함수
	 */
		
	public void curriculum_gisu_img_update(SocietyEduAdminCurriculumGisuImg seaCurGisuImg) {
		logger.debug("기수 정보 등록 서비스 시작");		
		
		 HashMap<String, ArrayList<SocietyEduAdminCurriculumGisuImg>> seaCurGisuImgMap = UploadFileServer(seaCurGisuImg);
		 ArrayList<SocietyEduAdminCurriculumGisuImg>seaCurGisuImgUpdateList = seaCurGisuImgMap.get("updateList");
		 ArrayList<SocietyEduAdminCurriculumGisuImg>seaCurGisuImgInsertList = seaCurGisuImgMap.get("insertList");
		if(seaCurGisuImgUpdateList != null)
		 seaDAO.curriculum_gisu_img_update(seaCurGisuImgUpdateList);
		//기수 이미지 업데이트 폼에서 새로운 이미지를 추가
		if(seaCurGisuImgInsertList != null)
			seaDAO.curriculum_gisu_img_insert(seaCurGisuImgInsertList);
		logger.debug("기수 정보 등록 서비스 종료");
	}
		
	
	/**
	 * @Method Name : UploadFileServer
	 * @Date : 2018. 9. 27
	 * @User : 신동철
	 * @Param : 기수 이미지 정보 객체
	 * @Return : 새로운 이미지 객체를 담은 리스트
	 * @Method 설명 : 파일서버에 이미지파일을 업로드하고 경로를 돌려받아 기수 이미지 객체에 설정, 이미지 삽입, 수정을 위한 함수
	 */
	private HashMap<String, ArrayList<SocietyEduAdminCurriculumGisuImg>> UploadFileServer(SocietyEduAdminCurriculumGisuImg seaCurGisuImg) {
		HashMap<String, ArrayList<SocietyEduAdminCurriculumGisuImg>>seaGisuImgMap = new HashMap<>();
		ArrayList<SocietyEduAdminCurriculumGisuImg>seaCurGisuImgInsertList = new ArrayList<>();
		ArrayList<SocietyEduAdminCurriculumGisuImg>seaCurGisuImgUpdateList = new ArrayList<>();
		seaGisuImgMap.clear();seaCurGisuImgInsertList.clear();seaCurGisuImgUpdateList.clear();
		try {
			for(int i=0; i<seaCurGisuImg.getGisu_crc_img_list().size(); i++){
				//새로운 기수 이미지 객체 생성하여 필드값 설정
				SocietyEduAdminCurriculumGisuImg newSeaCurGisuImg = new SocietyEduAdminCurriculumGisuImg();
				
				newSeaCurGisuImg.setGisu_seq(seaCurGisuImg.getGisu_seq());
				newSeaCurGisuImg.setGisu_crc_img_udt_id(seaCurGisuImg.getGisu_crc_img_udt_id());
				newSeaCurGisuImg.setGisu_crc_img_saved_file_ins_id(seaCurGisuImg.getGisu_crc_img_saved_file_ins_id());
				//모든 이미지를 삭제 후 수정완료 한 경우는 파일이 없음
				if(seaCurGisuImg.getGisu_crc_img_list().get(i).getGisu_crc_img_file() != null)
				newSeaCurGisuImg.setGisu_crc_img_origin(seaCurGisuImg.getGisu_crc_img_list().get(i).getGisu_crc_img_file().getOriginalFilename());
				//모든 이미지를 삭제 후 수정완료 한 경우는 파일이 없음
				if(seaCurGisuImg.getGisu_crc_img_list().get(i).getGisu_crc_img_file() != null)
				newSeaCurGisuImg.setGisu_crc_img_saved(FileService.saveFile(seaCurGisuImg.getGisu_crc_img_list().get(i).getGisu_crc_img_file(), eduAdminCurriculumGisuInsertImage));			
				newSeaCurGisuImg.setGisu_crc_img_saved_file_od(i+1);				
				if(seaCurGisuImg.getGisu_crc_img_list().get(i).getGisu_crc_img_seq() == 0){		//insert					
					//이미지 객체를 InsertList에 넣음
					seaCurGisuImgInsertList.add(newSeaCurGisuImg);
					//insertList를 map에 넣음
					seaGisuImgMap.put("insertList", seaCurGisuImgInsertList);
				}else{		//update
					//이미지 객체를 UpdateList에 넣음
					newSeaCurGisuImg.setGisu_crc_img_seq(seaCurGisuImg.getGisu_crc_img_list().get(i).getGisu_crc_img_seq());
					seaCurGisuImgUpdateList.add(newSeaCurGisuImg);
					//updateList를 map에 넣음
					seaGisuImgMap.put("updateList", seaCurGisuImgUpdateList);
				}			
			}			
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		return seaGisuImgMap;
	}
		
	/**
	 * @Method Name : subbanner_list
	 * @Date : 2018. 9. 13.
	 * @User : 정대영
	 * @Param : -
	 * @Return : 관리자 게시판의 모든 게시물 개수
	 * @Method 설명 : 관리자 게시판 진입 시 모든 게시물 개수 조회
	 */	
	public ArrayList<SocietyEduAdminSubBanner> subbanner_list(){
		logger.debug("서브 배너를 출력하는 함수 시작");
		
		ArrayList<SocietyEduAdminSubBanner> resultList = seaDAO.subbanner_list();

		logger.debug("서브 배너를 출력하는 함수 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : subbanner_update_select
	 * @Date : 2018. 9. 27.
	 * @User : 정대영
	 * @Param : -
	 * @Return : 수정 할 서브 배너 정보 객체 
	 * @Method 설명 : 서브 배너 수정 시 해당 서브 배너 객체 정보 객체 출력
	 */
	public SocietyEduAdminSubBanner subbanner_update_select(SocietyEduAdminSubBanner seaSb){
		logger.debug("수정 할 서브 배너 정보를 출력하는 함수 시작");
		
		SocietyEduAdminSubBanner result = seaDAO.subbanner_update_select(seaSb);

		logger.debug("수정 할 서브 배너 정보를 출력하는 함수 종료");
		return result;
	}
	
	/**
	 * @Method Name : subbanner_select_gisu_crc_nm
	 * @Date : 2018. 10. 1.
	 * @User : 정대영
	 * @Param : -
	 * @Return : 서브배너에서 참조할 기수 정보 
	 * @Method 설명 : 서브배너에서 참조할 기수 정보 조회
	 */
	public ArrayList<String> subbanner_select_gisu_crc_nm(){
		logger.debug("서브배너에서 참조할 기수 정보 조회 함수 시작");
		
		ArrayList<String> resultList = seaDAO.subbanner_select_gisu_crc_nm();

		logger.debug("서브배너에서 참조할 기수 정보 조회 함수 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : subbanner_img_loading
	 * @Date : 2018. 9. 27.
	 * @User : 정대영
	 * @Param : -
	 * @Return : 하드디스크 이미지 경로
	 * @Method 설명 : 하드디스크 이미지 경로 접근
	 */
	public String subbanner_img_loading(String fileName){
		logger.debug("수정 할 서브 배너 정보를 출력하는 함수 시작");
		
		String filePath = eduAdminSubbanerSaveImage;
		String fullpath = filePath + "/" + fileName;

		logger.debug("수정 할 서브 배너 정보를 출력하는 함수 종료");
		return fullpath;
	}
	
	/**
	 * @Method Name : banner_img_loading
	 * @Date : 2018. 10. 1.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 하드디스크 이미지 경로
	 * @Method 설명 : 하드디스크 이미지 경로 접근
	 */
	public String banner_img_loading(String fileName){
		logger.debug("수정 할 메인 배너 정보를 출력하는 함수 시작");
		
		String filePath = eduAdminBannerSaveImage;
		String fullpath = filePath + "/" + fileName;

		logger.debug("수정 할 메인 배너 정보를 출력하는 함수 종료");
		return fullpath;
	}
	
	/**
	 * @Method Name : banner_insert
	 * @Date : 2018. 9. 27.
	 * @User : 김준영
	 * @Param : 메인 배너 정보 객체
	 * @Return : -
	 * @Method 설명 : 메인 배너 정보 저장
	 */	
	public void banner_insert(SocietyEduAdminBanner seaB){
		logger.debug("메인 배너 등록 서비스 시작");
		// 파일 서버에 이미지 파일 업로드
		UploadFileServer(seaB);
		seaDAO.banner_insert(seaB);
		logger.debug("메인 배너 등록 서비스 종료");
	}
	
	/**
	 * @Method Name : banner_shown_list
	 * @Date : 2018. 9. 28.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 메인 배너 정보 객체
	 * @Method 설명 : 메인 배너 중 노출 되는 배너 객체
	 */	
	public ArrayList<SocietyEduAdminBanner> banner_shown_list(){
		logger.debug("메인 배너 중 노출 되는 리스트 출력 서비스 시작");
		ArrayList<SocietyEduAdminBanner> banner_shown_list = seaDAO.banner_shown_list();
		logger.debug("메인 배너 중 노출 되는 리스트 출력 서비스 종료");
		return banner_shown_list;
	}
	
	/**
	 * @Method Name : banner_unshown_list
	 * @Date : 2018. 9. 28.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 메인 배너 정보 객체
	 * @Method 설명 : 메인 배너 중 노출 되지 않는 배너 객체
	 */	
	public ArrayList<SocietyEduAdminBanner> banner_unshown_list(){
		logger.debug("메인 배너 중 노출 되지 않는 리스트 출력 서비스 시작");
		ArrayList<SocietyEduAdminBanner> banner_unshown_list = seaDAO.banner_unshown_list();
		logger.debug("메인 배너 중 노출 되지 않는 리스트 출력 서비스 종료");
		return banner_unshown_list;
	}
	
	/**
	 * @Method Name : UploadFileServer
	 * @Date : 2018. 9. 27.
	 * @User : 김준영
	 * @Param : Society 메인 배너 정보 객체
	 * @Return : -
	 * @Method 설명 : 파일서버에 이미지파일을 업로드하고 경로를 돌려받아 메인 배너 객체에 설정
	 */
	private void UploadFileServer(SocietyEduAdminBanner seaB) {
		logger.debug("메인 배너 이미지 저장 서비스 시작");
		try {
			if (seaB.getEdu_ban_file() != null) {
				seaB.setEdu_ban_origin(seaB.getEdu_ban_file().getOriginalFilename());
				seaB.setEdu_ban_saved(FileService.saveFile(seaB.getEdu_ban_file(), eduAdminBannerSaveImage));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
		logger.debug("메인 배너 이미지 저장 서비스 종료");
	}
	
	/**
	 * @Method Name : curriculum_nm_list
	 * @Date : 2018. 9. 27.
	 * @User : 김준영
	 * @Param : -
	 * @Return : currculum_nm 리스트
	 * @Method 설명 : 메인 배너 등록시 기존 과정명 불러오기
	 */
	public ArrayList<String> curriculum_nm_list(){
		logger.debug("과정명 리스트 출력 서비스 시작");
		ArrayList<String> curriculum_nm_list = seaDAO.curriculum_nm_list();
		logger.debug("과정명 리스트 출력 서비스 종료");
		return curriculum_nm_list;
	}
	
	/**
	 * @Method Name : banner_od_list
	 * @Date : 2018. 9. 28.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 메인 배너 사진 순서 리스트
	 * @Method 설명 : 메인 배너의 사진 순서를 리스트로 불러오기
	 */
	public ArrayList<Integer> banner_od_list(){
		logger.debug("메인 배너 사진 순서 리스트 출력 서비스 시작");
		ArrayList<Integer> banner_od_list = seaDAO.banner_od_list();
		logger.debug("메인 배너 사진 순서 리스트 출력 서비스 종료");
		return banner_od_list;
	}
	
	/**
	 * @Method Name : banner_shown_update
	 * @Date : 2018. 9. 28.
	 * @User : 김준영
	 * @Param : 노출 여부와 순서 변경에 필요한 Map
	 * @Return : -
	 * @Method 설명 : 메인 배너 노출 변경 시 순서, 노출 여부 변경
	 */
	public void banner_shown_update(HashMap<String, Object> map){
		logger.debug("메인 배너 노출 변경 시 순서, 노출 여부 변경 서비스 시작");
		seaDAO.banner_shown_update(map);
		logger.debug("메인 배너 노출 변경 시 순서, 노출 여부 변경 서비스 종료");
	}
	
	/**
	 * @Method Name : banner_ini
	 * @Date : 2018. 9. 28.
	 * @User : 김준영
	 * @Param : 수정인
	 * @Return : -
	 * @Method 설명 : 메인 배너 노출여부, 순서 초기화
	 */
	public void banner_ini(String edu_ban_udt_id){
		logger.debug("메인 배너 노출여부, 순서 초기화 서비스 시작");
		seaDAO.banner_ini(edu_ban_udt_id);
		logger.debug("메인 배너 노출여부, 순서 초기화 서비스 종료");
	}
	

	/**
	 * @Method Name : subbanner_shown_list
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 서브 배너 정보 객체
	 * @Method 설명 : 서브 배너 중 노출 되는 배너 객체
	 */	
	public ArrayList<SocietyEduAdminSubBanner> subbanner_shown_list(){
		logger.debug("서브 배너 중 노출 되는 리스트 출력 서비스 시작");
		ArrayList<SocietyEduAdminSubBanner> subbanner_shown_list = seaDAO.subbanner_shown_list();
		logger.debug("서브 배너 중 노출 되는 리스트 출력 서비스 종료");
		return subbanner_shown_list;
	}
	
	/**
	 * @Method Name : subbanner_unshown_list
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 서브 배너 정보 객체
	 * @Method 설명 : 서브 배너 중 노출 되지 않는 서브 배너 객체
	 */	
	public ArrayList<SocietyEduAdminSubBanner> subbanner_unshown_list(){
		logger.debug("서브 배너 중 노출 되지 않는 리스트 출력 서비스 시작");
		ArrayList<SocietyEduAdminSubBanner> subbanner_unshown_list = seaDAO.subbanner_unshown_list();
		logger.debug("서브 배너 중 노출 되지 않는 리스트 출력 서비스 종료");
		return subbanner_unshown_list;
	}
	
	/**
	 * @Method Name : subbanner_od_list
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 서브 배너 사진 순서 리스트
	 * @Method 설명 : 서브 배너의 사진 순서를 리스트로 불러오기
	 */
	public ArrayList<Integer> subbanner_od_list(){
		logger.debug("서브 배너 사진 순서 리스트 출력 서비스 시작");
		ArrayList<Integer> subbanner_od_list = seaDAO.subbanner_od_list();
		logger.debug("서브 배너 사진 순서 리스트 출력 서비스 종료");
		return subbanner_od_list;
	}
	
	/**
	 * @Method Name : subbanner_shown_update
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : 서브 배너 노출 여부와 순서 변경에 필요한 Map
	 * @Return : -
	 * @Method 설명 : 서브 배너 노출 변경 시 순서, 노출 여부 변경
	 */
	public void subbanner_shown_update(HashMap<String, Object> map){
		logger.debug("서브 배너 노출 변경 시 순서, 노출 여부 변경 서비스 시작");
		seaDAO.subbanner_shown_update(map);
		logger.debug("서브 배너 노출 변경 시 순서, 노출 여부 변경 서비스 종료");
	}
	
	/**
	 * @Method Name : subbanner_ini
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : 수정인
	 * @Return : -
	 * @Method 설명 : 서브 배너 노출여부, 순서 초기화
	 */
	public void subbanner_ini(String edu_sub_ban_udt_id){
		logger.debug("서브 배너 노출여부, 순서 초기화 서비스 시작");
		seaDAO.subbanner_ini(edu_sub_ban_udt_id);
		logger.debug("서브 배너 노출여부, 순서 초기화 서비스 종료");
	}
	
	/**
	 * @Method Name : banner_od_udt
	 * @Date : 2018. 10. 1.
	 * @User : 김준영
	 * @Param : 메인 배너의 seq, 순서
	 * @Return : -
	 * @Method 설명 : 메인 배너의 순서 수정
	 */
	public void banner_od_udt(HashMap<String, Object> map){
		logger.debug("메인 배너 순서 변경 서비스 시작");
		seaDAO.banner_od_udt(map);
		logger.debug("메인 배너 순서 변경 서비스 종료");
	}
	
	/**
	 * @Method Name : banner_od_udt
	 * @Date : 2018. 10. 1.
	 * @User : 김준영
	 * @Param : 서브 배너의 seq, 순서
	 * @Return : -
	 * @Method 설명 : 서브 배너의 순서 수정
	 */
	public void subbanner_od_udt(HashMap<String, Object> map){
		logger.debug("서브 배너 순서 변경 서비스 시작");
		seaDAO.subbanner_od_udt(map);
		logger.debug("서브 배너 순서 변경 서비스 종료");
	}
	
	/**
	 * @Method Name : banner_update
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : 배너 정보 객체
	 * @Return : -
	 * @Method 설명 : 전달 받은 배너 정보를 수정하는 서비스 함수
	 */
	public void banner_update(SocietyEduAdminBanner seaB) {
		boolean isMainBanner = true;
		//사진파일을 변경했을 때
		if(!seaB.getEdu_ban_file().isEmpty()){
			// 파일서버에서 파일 제거
			DeleteFileServer(seaB.getEdu_ban_saved(), isMainBanner);
			// 새로운파일 새로 저장하고 DB수정
			UploadFileServer(seaB);
		}		
		seaDAO.banner_update(seaB);

	}
	
	/**
	 * @Method Name : banner_update_select
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 수정 할 배너 정보 객체 
	 * @Method 설명 : 배너 수정 시 해당 배너 객체 정보 출력
	 */
	public SocietyEduAdminBanner banner_update_select(SocietyEduAdminBanner seaB){
		logger.debug("수정 할 배너 정보를 출력하는 함수 시작");
		
		SocietyEduAdminBanner result = seaDAO.banner_update_select(seaB);

		logger.debug("수정 할 배너 정보를 출력하는 함수 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_gisu_crc_nm
	 * @Date : 2018. 10. 5.
	 * @User :김준영
	 * @Param : -
	 * @Return : 링크 관리 시 보여 줄  리스트
	 * @Method 설명 : 링크 관리 시 보여 줄  리스트
	 */
	public ArrayList<SocietyEduAdminCurriculumGisu> select_gisu_crc_nm(){
		logger.debug("링크 관리 시 보여 줄  리스트 서비스 시작");
		
		ArrayList<SocietyEduAdminCurriculumGisu> resultList = seaDAO.select_gisu_crc_nm();

		logger.debug("링크 관리 시 보여 줄  리스트 서비스 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : curriculum_gisu_img_delete
	 * @Date : 2018. 10. 2.
	 * @User : 신동철
	 * @Param : 기수과정 이미지 정보 시퀀스, 파일의 저장 명
	 * @Return : -
	 * @Method 설명 : 전달 받은 기수 과정 이미지를 삭제하는 서비스 함수
	 */
	public void curriculum_gisu_img_delete(SocietyEduAdminCurriculumGisuImg seaCurGisuImg) {
		logger.debug("기수 정보 이미지 삭제 서비스 시작");
		
		//파일 삭제 후 데이터베이스 정보 삭제
		DeleteFileServer(seaCurGisuImg);
		seaDAO.curriculum_gisu_img_delete(seaCurGisuImg);

		logger.debug("기수 정보  이미지 삭제 서비스 종료");
	}
	
	/**
	 * @Method Name : DeleteFileServer
	 * @Date : 2018. 10. 2
	 * @User : 신동철
	 * @Param : Society 기수 정보 객체에 이미지 파일 저장명
	 * @Return : -
	 * @Method 설명 : 파일서버에서 중복 저장된 파일제거
	 */
	private void DeleteFileServer(SocietyEduAdminCurriculumGisuImg seaCurGisuImg) {
		try {			
				FileService.deleteFile(seaCurGisuImg.getGisu_crc_img_saved(), eduAdminCurriculumGisuInsertImage);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @Method Name : curriculum_gisu_delete
	 * @Date : 2018. 10. 3
	 * @User : 신동철
	 * @Param : 기수 시퀀스
	 * @Return : -
	 * @Method 설명 : 기수 정보를 삭제하는 서비스 함수
	 */
	public void curriculum_gisu_delete(int gisu_seq) {
		logger.debug("기수 정보 등록 서비스 시작");
				
		seaDAO.curriculum_gisu_delete(gisu_seq);

		logger.debug("기수 정보 등록 서비스 종료");
	}

	/**
	 * @Method Name : select_curriculum
	 * @Date : 2018. 10. 8.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 과정 객체
	 * @Method 설명 : 과정의 seq, class, nm 가져오기
	 */
	public ArrayList<SocietyEduAdminCurriculum> select_curriculum(){
		logger.info("과정 가져오기 서비스 시작");
		ArrayList<SocietyEduAdminCurriculum> select_curriculum = seaDAO.select_curriculum();
		logger.info("과정 가져오기 서비스 종료");
		return select_curriculum;
	}
	
	/**
	 * @Method Name : update_gisu_crc_division
	 * @Date : 2018. 10. 8.
	 * @User : 김준영
	 * @Param : 구분자, gisu_seq
	 * @Return : -
	 * @Method 설명 : 링크 등록과 삭제를 위한 함수
	 */
	public void update_gisu_crc_division(HashMap<String, Object> map){
		logger.info("링크 업데이트 서비스 시작");
		seaDAO.update_gisu_crc_division(map);
		logger.info("링크 업데이트 서비스 종료");
	}
	
	/**
	 * @Method Name : board_gb_search
	 * @Date : 2019. 1. 24.
	 * @User : 신동철
	 * @Param : 게시판 시퀀스
	 * @Return : 게시판 구분, 타입 검색
	 * @Method 설명 : 게시판 구분, 타입 검색 서비스함수
	 */
	public BoardGroup board_gb_search(BoardGroup boardGb){
	logger.debug("게시판 구분, 타입 검색  Service 함수 시작");
		
	BoardGroup boardGroup = seaDAO.board_gb_search(boardGb);
	
	logger.debug("게시판 구분, 타입 검색  Service 함수 종료");
	return boardGroup;
	}
	
	/**
	 * @Method Name : company_board_contents_list_search
	 * @Date : 2019. 1. 24.
	 * @User : 신동철
	 * @Param : 게시판 시퀀스
	 * @Return : 관리자 잡페어 공지사항 게시판 리스트
	 * @Method 설명 : 관리자 잡페어 공지사항 게시판 리스트 검색 함수
	 */
	public ArrayList<BoardContent> company_board_contents_list_search(HashMap<String, Object> map){
		logger.debug("잡페어 채용기업 메인 공지사항 리스트 검색 Service 함수 시작");
		
		ArrayList<BoardContent> resultList = seaDAO.company_board_contents_list_search(map);
		
		logger.debug("잡페어 채용기업 메인 공지사항 리스트 검색 Service 함수 종료");
		
		return resultList;
	}
	
}
