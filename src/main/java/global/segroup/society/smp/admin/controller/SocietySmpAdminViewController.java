package global.segroup.society.smp.admin.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

import global.segroup.domain.AdminSecurity;
import global.segroup.domain.BoardContent;
import global.segroup.domain.BoardFile;
import global.segroup.domain.BoardGroup;
import global.segroup.domain.User;
import global.segroup.domain.UserSecurity;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculumGisu;
import global.segroup.society.edu.admin.service.SocietyEduAdminService;
import global.segroup.society.smp.admin.domain.SocietySmpApsDetailExam;
import global.segroup.society.smp.admin.domain.SocietySmpApsDetailSubexam;
import global.segroup.society.smp.admin.domain.SocietySmpApsGroup;
import global.segroup.society.smp.admin.domain.SocietySmpApsGroupConfirmation;
import global.segroup.society.smp.admin.domain.SocietySmpApsGroupExam;
import global.segroup.society.smp.admin.domain.SocietySmpApsGroupSubexam;
import global.segroup.society.smp.admin.domain.SocietySmpStudentCareer;
import global.segroup.society.smp.admin.domain.SocietySmpStudentEduHistory;
import global.segroup.society.smp.admin.domain.SocietySmpStudentFile;
import global.segroup.society.smp.admin.domain.SocietySmpStudentForm;
import global.segroup.society.smp.admin.domain.SocietySmpStudentLanguage;
import global.segroup.society.smp.admin.domain.SocietySmpStudentLicense;
import global.segroup.society.smp.admin.domain.SocietySmpStudentOverseas;
import global.segroup.society.smp.admin.domain.SocietySmpStudentStudy;
import global.segroup.society.smp.admin.service.SocietySmpAdminService;
import global.segroup.util.PageNavigator;
import global.segroup.util.PathConstants;

@Controller
public class SocietySmpAdminViewController implements PathConstants {

	private static final Logger logger = LoggerFactory.getLogger(SocietySmpAdminViewController.class);

	@Autowired
	private SocietyEduAdminService seaService;

	@Autowired
	private SocietySmpAdminService ssaService;

	// 전희배
	@Value("#{props['smp.board.notice_file']}")
	private String smpBoardNoticeFile;

	/**
	 * @Method Name : student_manager
	 * @Date : 2018. 8. 21.
	 * @User : 여명환
	 * @Param : -
	 * @Return : 학생관리 페이지
	 * @Method 설명 : 학생관리 페이지 접속 메소드
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_STUDENT_MANAGER, method = RequestMethod.GET)
	public String student_manager(Model model) {

		logger.debug("모집홍보 관리자 학생 관리 폼 이동 컨트롤러 시작");

		model = searchGisuList(model);

		logger.debug("모집홍보 관리자 학생 관리 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_STUDENT_MANAGER;
	}

	/**
	 * @Method Name : student_final_pass
	 * @Date : 2018. 8. 21.
	 * @User : 여명환
	 * @Param : -
	 * @Return : 학사관리 학생 최종합격 페이지
	 * @Method 설명 : 학사관리 학생 최종합격 페이지 접속 메소드
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_FINAL_PASS, method = RequestMethod.GET)
	public String student_final_pass(Model model) {
		logger.debug("모집홍보 관리자 학생 관리 폼 이동 컨트롤러 시작");

		model = searchGisuList(model);

		logger.debug("모집홍보 관리자 학생 관리 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_FINAL_PASS;
	}

	/**
	 * @Method Name : student_info_update_form
	 * @Date : 2018. 08. 22.
	 * @User : 여명환
	 * @Param :
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 학생관리 페이지)
	 * @Method 설명 : 해당하는 학생의 정보 자료보기.
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_STUDENT_INFO_UPDATE_FORM, method = RequestMethod.GET)
	public String apply_form(Model model, @RequestParam(defaultValue = "") int gisu_seq,
			@RequestParam(defaultValue = "") String app_id, @RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "10") int pageCount, @RequestParam(defaultValue = "") String search_name,
			@RequestParam(defaultValue = "apply_date") String orderType,
			@RequestParam(defaultValue = "desc") String orderValue) {

		HashMap<String, Object> map = new HashMap<>();
		map.put("gisu_seq", gisu_seq);
		map.put("app_id", app_id);

		map.put("curPage", curPage);
		map.put("pageCount", pageCount);
		map.put("search_name", search_name);
		map.put("orderType", orderType);
		map.put("orderValue", orderValue);
		model.addAttribute("map", map);

		HashMap<String, Object> resultMap = ssaService.selectSmpStudentUpdateForm(map);
		System.out.println(resultMap);
		Gson gson = new Gson();
		model.addAttribute("smpApply", resultMap);
		model.addAttribute("smp_self_intro", resultMap.get("smp_self_intro"));
		resultMap.remove("smp_self_intro");

		/* 유저정보 검색 */
		User user = new User();
		user.setUser_id(app_id);
		User userInfo = seaService.user_info_select(user);
		System.out.println(userInfo);
		model.addAttribute("detail", userInfo);
		model.addAttribute("smpApplyJson", gson.toJson(resultMap));
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_STUDENT_INFO_UPDATE_FORM;

	}

	/**
	 * @Method Name : smp_update
	 * @Date : 2018. 8. 23.
	 * @User : 여명환
	 * @Param : SMART Cloud IT마스터 학생 정보(기본정보 , 학력, 경력, 교육이수, 언어능력, 자격증, 해외체류,
	 *        증빙자료)
	 * @Return : JSP 리턴페이지 (모집홍보 지원 리스트)
	 * @Method 설명 : 학생 정보를 수정하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_SMP_STUDENT_UPDATE, method = RequestMethod.POST)
	public String smp_update(SocietySmpStudentForm seaForm, SocietySmpStudentEduHistory seaEduHistory,
			SocietySmpStudentCareer seaCareer, SocietySmpStudentStudy seaStudy, SocietySmpStudentLanguage seaLanguage,
			SocietySmpStudentLicense seaLicense, SocietySmpStudentOverseas seaOverseas, SocietySmpStudentFile seaFile) {
		logger.debug("학생정보 수정 시작");
		ssaService.smp_delete(seaForm.getSmp_seq());
		if (seaForm.getSmp_kmove_gb().length() > 8) {
			seaForm.setSmp_kmove_gb("null");
		}
		if (seaForm.getSmp_app_lo_gb().length() > 8) {
			seaForm.setSmp_app_lo_gb("null");
		}
		if (seaForm.getSmp_cup_gb().length() > 8) {
			seaForm.setSmp_cup_gb("null");
		}
		if (seaForm.getSmp_applied_ck().length() > 8) {
			seaForm.setSmp_applied_ck("null");
		}
		ssaService.smp_insert(seaForm, seaEduHistory, seaCareer, seaStudy, seaLanguage, seaLicense, seaOverseas,
				seaFile);
		logger.debug("학생정보 수정 종료");
		return "redirect:" + PathConstants.SOCIETY_SMP_STUDENT_MANAGER;
	}

	/**
	 * @Method Name : ConfirmCourse
	 * @Date : 2018. 8. 24.
	 * @User : 여명환
	 * @Param : -
	 * @Return : 학생관리 페이지
	 * @Method 설명 : 학생관리 페이지 접속 메소드
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_USER_CONFIRMCOURSE, method = RequestMethod.GET)
	public String adminConfirmCourse(Model model) {
		logger.debug("수강확인서 폼 이동 컨트롤러 시작");
		model = searchGisuList(model);
		logger.debug("수강확인서 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_USER_CONFIRMCOURSE;
	}

	/**
	 * @Method Name : searchGisuList
	 * @Date : 2018. 8. 24.
	 * @User : 여명환
	 * @Param : -
	 * @Return : 기수 조회
	 * @Method 설명 : 학생관리에서 SCIT마스터 과정 기수 출력
	 */
	public Model searchGisuList(Model model) {
		model.addAttribute("seaCurList", seaService.searchCurGisuList(1));
		return model;
	}

	/**
	 * @Method Name : smp_schedule_start
	 * @Date : 2018. 8. 24.
	 * @User : 박찬주
	 * @Param : -
	 * @Return : JSP 학사관리 일정 페이지 요청
	 * @Method 설명 : JSP 학사관리 일정 페이지를 요청하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_SCHEDULE_START, method = RequestMethod.GET)
	public String smp_schedule_start() {

		return "redirect:" + PathConstants.SOCIETY_SMP_SCHEDULE_REQUEST;
	}

	/**
	 * @Method Name : searchUser
	 * @Date : 2018. 8. 31.
	 * @User : 박찬주
	 * @Param : Authentication
	 * @Return : User 객체
	 * @Method 설명 : Authentication에 따른 User객체 반환 함수
	 */
	public User searchUser(Authentication auth) {
		User user = new User();
		user.setUser_id(auth.getName());
		User userInfo = seaService.user_info_select(user);

		return userInfo;
	}

	/**
	 * @Method Name : smp_shedule
	 * @Date : 2018. 8. 24.
	 * @User : 박찬주
	 * @Param : -
	 * @Return : JSP 학사관리 일정 페이지
	 * @Method 설명 : JSP 학사관리 일정 페이지에 접속하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_SCHEDULE_REQUEST, method = RequestMethod.GET)
	public String smp_shedule(Model model, HttpSession session, Authentication auth) {
		if (auth.getDetails() instanceof AdminSecurity) {
			model.addAttribute("Admin", "Admin");
			List<SocietyEduAdminCurriculumGisu> SEACurGisuList = ssaService.selectGisuSeqNumList();
			model.addAttribute("gisu_list", SEACurGisuList);
			int gisu_seq = SEACurGisuList.get(0).getGisu_seq();
			model.addAttribute("gisu_seq", gisu_seq);
			int gisu_num = ssaService.selectGisuNum(gisu_seq);
			model.addAttribute("gisu_num", gisu_num);
			String gisu_crc_nm = SEACurGisuList.get(0).getGisu_crc_nm();
			model.addAttribute("gisu_crc_nm", gisu_crc_nm);
		}
		if (auth.getDetails() instanceof UserSecurity) {
			model.addAttribute("User", "User");
			SocietyEduAdminCurriculumGisu SEACurGisu = ssaService.selectSocietySmpUserGisuNum(auth.getName());
			model.addAttribute("gisu_seq", SEACurGisu.getGisu_seq());
			model.addAttribute("gisu_num", SEACurGisu.getGisu_num());
			model.addAttribute("gisu_crc_nm", SEACurGisu.getGisu_crc_nm());
		}
		session.setAttribute("userId", auth.getPrincipal());

		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_SCHEDULE;
	}

	/**
	 * @Method Name : gisuChange
	 * @Date : 2018. 8. 31.
	 * @User : 박찬주
	 * @Param : 기수 시퀀스
	 * @Return : JSP 학사관리 일정 페이지
	 * @Method 설명 : 기수를 바꿔 JSP 학사관리 일정 페이지에 접속하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_SCHEDULE_GISUCHANGE, method = RequestMethod.POST)
	public String gisuChange(int gisu_seq, Model model, HttpSession session, Authentication auth) {

		model.addAttribute("Admin", "Admin");
		List<SocietyEduAdminCurriculumGisu> SEACurGisuList = ssaService.selectGisuSeqNumList();
		model.addAttribute("gisu_list", SEACurGisuList);
		model.addAttribute("gisu_seq", gisu_seq);
		int gisu_num = ssaService.selectGisuNum(gisu_seq);
		model.addAttribute("gisu_num", gisu_num);
		String gisu_crc_nm = SEACurGisuList.get(0).getGisu_crc_nm();
		model.addAttribute("gisu_crc_nm", gisu_crc_nm);

		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_SCHEDULE;
	}

	/**
	 * @Method Name : smp_admin_board
	 * @Date : 2018. 08. 30. -> 2018. 12. 03.
	 * @User : 전희배, 원병호
	 * @Param : -
	 * @Return : JSP 리턴 페이지(모집홍보의 공지사항 페이지)
	 * @Method 설명 : 모집홍보 공지사항 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = SOCIETY_SMP_ADMIN_BOARD, method = RequestMethod.GET)
	public String smp_user_board(Model model, Authentication auth,
			@RequestParam(defaultValue = "contents") String searchOption,
			@RequestParam(defaultValue = "") String keyword, @RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "0") String gisu_seq, BoardGroup boardGroup) {

		logger.debug("전체공지 게시글 리스트 조회 컨트롤러 시작");

		String board_seq = "12"; // 기수별공지게시판 seq
		ArrayList<HashMap<String, Object>> gisuBoardList = ssaService.board_gisu_search();
		if (gisu_seq.equals("0")) {
			gisu_seq = (String.valueOf(gisuBoardList.get(0).get("gisu_seq")));
		}
		User user = new User();
		if (auth.getDetails() instanceof UserSecurity) {
			user.setUser_id(auth.getName());
			User userInfo = seaService.user_info_select(user);
			String id = userInfo.getUser_id();
			SocietyEduAdminCurriculumGisu gisu_info = ssaService.get_specific_user_gisu(id);
			gisu_seq = "" + gisu_info.getGisu_seq();
		}

		String gisu_num = "";
		for (int i = 0; i < gisuBoardList.size(); i++) {
			String result = (String.valueOf(gisuBoardList.get(i).get("gisu_seq")));
			if (result.equals(gisu_seq)) {
				gisu_num = "" + gisuBoardList.get(i).get("gisu_crc_nm");
				break;
			}
		}
		int totalRecordsCount = ssaService.gettotal(searchOption, keyword, board_seq, gisu_seq);
		PageNavigator navi = new PageNavigator(5, 5, curPage, totalRecordsCount);
		RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());

		// keyword, searchOption map에 넣고 쿼리+db까지의 흐름 수정하기
		ArrayList<HashMap<String, Object>> mainBoardList = (ArrayList<HashMap<String, Object>>) ssaService
				.smpMainBoardListAll(searchOption, keyword, board_seq, gisu_seq);
		ArrayList<HashMap<String, Object>> boardList = (ArrayList<HashMap<String, Object>>) ssaService
				.smpBoardListAll(rb, searchOption, keyword, board_seq, gisu_seq);
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("keyword", keyword); // 검색키워드
		map.put("navi", navi);

		model.addAttribute("mainBoardList", mainBoardList);
		// model.addAttribute("gisuBoardList", gisuBoardList);
		model.addAttribute("seaCurList", seaService.searchCurGisuList(1)); // 0917수정
		model.addAttribute("boardList", boardList);
		model.addAttribute("map", map);

		boardGroup.setBoard_seq(Integer.parseInt(board_seq));
		int board_icon_pd = ssaService.select_board_pd(Integer.parseInt(board_seq));
		boardGroup.setBoard_icon_pd(board_icon_pd);
		model.addAttribute("boardGroup", boardGroup);

		// logger.error("보드그룹 : {}", boardGroup);
		model.addAttribute("gisu_seq", gisu_seq);
		model.addAttribute("gisu_num", gisu_num);

		if (auth.getDetails() instanceof AdminSecurity)
			model.addAttribute("Admin", "Admin");
		if (auth.getDetails() instanceof UserSecurity)
			model.addAttribute("User", "User");

		logger.debug("전체공지 게시글 리스트 조회 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_SMP_ADMIN_BOARD;
	}

	/**
	 * @Method Name : smp_admin_board_detail
	 * @Date : 2018. 08. 30.
	 * @User : 전희배
	 * @Param : -
	 * @Return : JSP 리턴 페이지(이미지 게시판 내용보기 페이지)
	 * @Method 설명 : 이미지 내용보기 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = SOCIETY_SMP_ADMIN_BOARD_DETAIL, method = RequestMethod.GET)
	public String smp_admin_board_detail(BoardGroup boardGroup, Model model, Authentication auth, String seq,
			HttpServletRequest request) {

		logger.debug("공지사항 게시판을 내용을 호출하는 컨트롤러 시작!!!!!!!!!!!!!!!!1");
		int board_content_seq = Integer.parseInt(seq);

		HashMap<String, Object> resultMap = seaService.board_contents_detail(board_content_seq);

		String path = smpBoardNoticeFile;

		model.addAttribute("contentDetail", resultMap);
		model.addAttribute("boardGroup", boardGroup);
		model.addAttribute("path", path);

		HashMap<String, String> board_detail2_map = ssaService.select_board_detail2(board_content_seq);
		model.addAttribute("board_detail2_map", board_detail2_map);

		// board_content_seq로 gisu_seq를 구하는 함수 호출
		String gisu_seq = null;

		gisu_seq = Integer.toString(ssaService.selectBoardGisuSeq(board_content_seq));

		model.addAttribute("gisu_seq", gisu_seq);

		Gson gson = new Gson();
		model.addAttribute("fileList", gson.toJson(resultMap.get("fileList")));
		model.addAttribute("board_seq", boardGroup.getBoard_seq());

		if (auth.getDetails() instanceof AdminSecurity)
			model.addAttribute("Admin", "Admin");
		if (auth.getDetails() instanceof UserSecurity) {
			model.addAttribute("User", "User");
			seaService.board_contents_hit_update(board_content_seq);// 조회수 증가
		}
		logger.debug("전체공지 관리자 게시글 세부 내용 수정 폼 이동 컨트롤러 종료");

		// return PathConstants.SEGROUP_SOCIETY + "/smp/admin/board_detail";
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_SMP_ADMIN_BOARD_DETAIL;
	}

	/**
	 * @Method Name : smp_board_insert_form
	 * @Date : 2018. 08. 23.
	 * @User : 전희배
	 * @Param : 게시판 시퀀스
	 * @Return : JSP 리턴 페이지(게시판 세부내용 등록 페이지)
	 * @Method 설명 : 게시판 세부 내용 등록 페이지로 폼 이동 하는 컨트롤러 함수
	 */
	@RequestMapping(value = SOCIETY_SMP_ADMIN_BOARD_INSERT_FORM, method = RequestMethod.POST)
	public String smp_board_insert_form(BoardGroup boardGroup, Model model, Authentication auth,
			@RequestParam(defaultValue = "") String search_division,
			@RequestParam(defaultValue = "") String search_type, int board_seq, String gisu_seq) {
		logger.debug("모집홍보 관리자 게시글 세부 내용 등록 폼 이동 컨트롤러 시작");
		String path = smpBoardNoticeFile;

		model.addAttribute("path", path);
		model.addAttribute("boardGroup", boardGroup);
		model.addAttribute("board_content_nm", ssaService.smp_select_admin_nm(auth.getName()));
		model.addAttribute("search_division", search_division);
		model.addAttribute("search_type", search_type);
		model.addAttribute("gisu_seq", gisu_seq);
		logger.debug("모집홍보 관리자 게시글 세부 내용 등록 폼 이동 컨트롤러 종료");

		return PathConstants.SEGROUP_SOCIETY + SOCIETY_SMP_ADMIN_BOARD_INSERT_FORM;
	}

	/**
	 * @Method Name : smp_board_insert
	 * @Date : 2018. 08. 23. -> 2018. 12. 03.
	 * @User : 전희배, 원병호
	 * @Param : 게시글 세부내용, 게시판 첨부파일 저장 경로
	 * @Return : JSP 리턴페이지(게시판 메니저 폼)
	 * @Method 설명 : 게시글 등록하고 메니저 폼으로 이동하는 컨트롤러 함수, 리턴JSP페이지를 user에서 admin으로 변경
	 */
	@Transactional
	@RequestMapping(value = SOCIETY_SMP_ADMIN_BOARD_INSERT, method = RequestMethod.POST)
	public String smp_board_insert(Model model, BoardGroup boardGroup, BoardContent boardContent, BoardFile boardFile,
			Authentication auth, String gisu_seq) {

		ssaService.smp_board_contents_insert(boardContent);
		seaService.board_contents_file_insert(smpBoardNoticeFile, boardFile, boardContent.getBoard_content_seq(),
				ssaService.smp_select_admin_nm(auth.getName()));

		String board_content_seq = "" + boardContent.getBoard_content_seq();
		ssaService.insertBoardGisu(board_content_seq, gisu_seq);

		return "redirect:" + PathConstants.SOCIETY_SMP_ADMIN_BOARD + "?gisu_seq=" + gisu_seq;
	}

	/**
	 * @Method Name : smp_board_update_form
	 * 
	 * @Date : 2018. 08. 23.
	 * @User : 전희배
	 * @Param : 게시판 세부내용 시퀀스, 게시판 구분, 게시판 타입
	 * @Return : JSP 리턴페이지(게시판 세부내용 수정 페이지)
	 * @Method 설명 : 게시판 세부 내용 수정 페이지로 폼 이동 하는 컨트롤러 함수
	 */
	@RequestMapping(value = SOCIETY_SMP_ADMIN_BOARD_UPDATE_FORM, method = RequestMethod.POST)
	public String smp_board_update_form(int board_content_seq, Model model, BoardGroup boardGroup,
			@RequestParam(defaultValue = "") String search_division,
			@RequestParam(defaultValue = "") String search_type, String gisu_seq) {
		logger.debug("모집홍보 관리자 게시글 세부 내용 수정 폼 이동 컨트롤러 시작");

		HashMap<String, Object> resultMap = seaService.board_contents_detail(board_content_seq);

		HashMap<String, String> map = ssaService.select_board_detail2(board_content_seq);
		resultMap.put("board_content_imp", map.get("board_content_imp"));

		String path = smpBoardNoticeFile;

		model.addAttribute("contentDetail", resultMap);
		model.addAttribute("boardGroup", boardGroup);
		model.addAttribute("path", path);
		model.addAttribute("gisu_seq", gisu_seq);

		Gson gson = new Gson();
		model.addAttribute("fileList", gson.toJson(resultMap.get("fileList")));
		model.addAttribute("search_division", search_division);
		model.addAttribute("search_type", search_type);
		logger.debug("모집홍보 관리자 게시글 세부 내용 수정 폼 이동 컨트롤러 종료");

		return PathConstants.SEGROUP_SOCIETY + SOCIETY_SMP_ADMIN_BOARD_UPDATE_FORM;
	}

	/**
	 * @Method Name : smp_board_update
	 * @Date : 2018. 08. 23. -> 2018. 12. 03.
	 * @User : 전희배, 원병호
	 * @Param : 게시글 세부내용, 게시판 첨부파일 저장 경로
	 * @Return : JSP 리턴페이지(게시판 메니저 폼)
	 * @Method 설명 : 게시글 수정하고 메니저 폼으로 이동하는 컨트롤러 함수, 리턴JSP페이지를 user에서 admin으로 변경
	 */
	@Transactional
	@RequestMapping(value = SOCIETY_SMP_ADMIN_BOARD_UPDATE, method = RequestMethod.POST)
	public String smp_board_update(BoardContent boardContent, BoardFile boardFile, Model model, BoardGroup boardGroup,
			Authentication auth, String gisu_seq) {
		logger.debug("모집홍보 관리자 게시글 세부 내용 수정 컨트롤러 시작");
		ssaService.smp_board_contents_update(boardContent);
		seaService.board_contents_file_delete(boardContent);
		seaService.board_contents_file_insert(smpBoardNoticeFile, boardFile, boardContent.getBoard_content_seq(),
				ssaService.smp_select_admin_nm(auth.getName()));
		logger.debug("모집홍보 관리자 게시글 세부 내용 수정 컨트롤러 종료");

		return "redirect:" + PathConstants.SOCIETY_SMP_ADMIN_BOARD + "?gisu_seq=" + gisu_seq;
	}

	/**
	 * @Method Name : printStudentCourse
	 * @Date : 2018. 08. 22.
	 * @User : 여명환
	 * @Param :
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 학생 수강 확인서 페이지)
	 * @Method 설명 : 해당하는 학생의 정보 자료보기.
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_USER_PRINTCOURSE, method = RequestMethod.POST)
	public String printCourse(Model model, @RequestParam(defaultValue = "") String app_id,
			@RequestParam(defaultValue = "1") int curPage, @RequestParam(defaultValue = "10") int pageCount,
			@RequestParam(defaultValue = "") String search_name,
			@RequestParam(defaultValue = "apply_date") String orderType,
			@RequestParam(defaultValue = "desc") String orderValue) {

		Calendar calendar = new GregorianCalendar(Locale.KOREA);
		int nYear = calendar.get(Calendar.YEAR);
		int nMonth = calendar.get(Calendar.MONTH) + 1;
		int nDay = calendar.get(Calendar.DAY_OF_MONTH);
		HashMap<String, Object> resultMap = ssaService.smp_select_print_student(app_id);
		System.out.println(resultMap);
		Gson gson = new Gson();
		model.addAttribute("printStudentInfo", resultMap);
		model.addAttribute("nYear", nYear);
		model.addAttribute("nMonth", nMonth);
		model.addAttribute("nDay", nDay);
		model.addAttribute("smpApplyJson", gson.toJson(resultMap));
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_USER_PRINTCOURSE;
	}

	/**
	 * @Method Name : smp_board_delete_form
	 * @Date : 2018. 09. 05.
	 * @User : 여명환
	 * @Param : 게시판 세부내용 시퀀스, 게시판 구분, 게시판 타입
	 * @Return : JSP 리턴페이지(게시판 세부내용 수정 페이지)
	 * @Method 설명 : 게시판 세부 내용 수정 페이지로 폼 이동 하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value = SOCIETY_SMP_ADMIN_BOARD_DELETE_FORM, method = RequestMethod.POST)
	public String smp_board_delete_form(int board_content_seq, Model model) {
		logger.debug("모집홍보 관리자 게시글 세부 내용 수정 폼 이동 컨트롤러 시작");
		ssaService.smp_board_delete(board_content_seq);
		return "redirect:" + PathConstants.SOCIETY_SMP_USER_BOARD;
	}

	/**
	 * @Method Name : smp_aps_total_inert_form
	 * @Date : 2018. 09. 10.
	 * @User : 전희배
	 * @Param :
	 * @Return : JSP 리턴페이지(평가항목종합 등록페이지)
	 * @Method 설명 : 평가항목종합 등록 폼 이동 하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_TOTAL_INSERT_FORM, method = RequestMethod.GET)
	public String smp_aps_total_inert_form(Model model) {
		logger.debug("평가항목종합 등록 폼 이동 컨트롤러 시작");
		model = searchGisuList(model);
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_ADMIN_APS_TOTAL_INSERT_FORM;
	}

	/**
	 * @Method Name : smp_aps_total_inert
	 * @Date : 2018. 09. 11.
	 * @User : 전희배
	 * @Param :
	 * @Return : JSP 리턴페이지(평가항목종합 조회페이지)
	 * @Method 설명 : 평가항목종합 등록 하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_TOTAL_INSERT, method = RequestMethod.POST)
	public String smp_aps_total_inert(Model model, Authentication auth, int gisu_seq, String smp_aps_total_nm,
			int smp_aps_total_ratio, String smp_aps_total_ct) {
		logger.info("평가항목종합 등록 컨트롤러 시작");
		ssaService.insertSmpApsTotal(gisu_seq, smp_aps_total_nm, smp_aps_total_ratio, auth.getName(), auth.getName(),
				smp_aps_total_ct);
		return "redirect:" + PathConstants.SOCIETY_SMP_ADMIN_APS_TOTAL;
	}

	/**
	 * @Method Name : smp_aps_group_insert_form
	 * @Date : 2018. 09. 10.
	 * @User : 전희배
	 * @Param :
	 * @Return : JSP 리턴페이지(평가항목종합 등록페이지)
	 * @Method 설명 : 평가항목종합 등록 폼 이동 하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_GROUP_INSERT_FORM, method = RequestMethod.GET)
	public String smp_aps_group_inert_form(Model model) {
		logger.debug("평가항목그룹 등록 폼 이동 컨트롤러 시작");
		model = searchGisuList(model);
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_ADMIN_APS_GROUP_INSERT_FORM;
	}

	/**
	 * @Method Name : smp_aps_group_insert
	 * @Date : 2019. 01. 17.
	 * @User : 김홍일
	 * @Param :
	 * @Return : JSP 리턴페이지(평가항목그룹 조회페이지)
	 * @Method 설명 : SMP_APS_GROUP_TB에 그룹 타입을 하나 정해서 입력하고, 해당 타입에 맞는 다중 상속 테이블 중
	 *         하나에 값을 입력
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_GROUP_INSERT, method = RequestMethod.POST)
	public String smp_aps_group_inert(Model model, Authentication auth, SocietySmpApsGroup societySmpApsGroup, SocietySmpApsGroupExam societySmpApsGroupExam, SocietySmpApsGroupSubexam societySmpApsGroupSubexam, SocietySmpApsGroupConfirmation societySmpApsGroupConfirmation) {
		logger.debug("평가항목그룹 등록 컨트롤러 시작");
		System.out.println(societySmpApsGroup);
		
		societySmpApsGroup.setSmp_aps_group_ins_id(auth.getName());
		societySmpApsGroup.setSmp_aps_group_udt_id(auth.getName());
		ssaService.insertSmpApsGroup(societySmpApsGroup);
		
		if (societySmpApsGroup.getSmp_aps_group_tp().equals("A0900")) {
			societySmpApsGroupExam.setSmp_aps_group_seq(societySmpApsGroup.getSmp_aps_group_seq());
			societySmpApsGroupExam.setSmp_aps_group_exam_ins_id(auth.getName());
			societySmpApsGroupExam.setSmp_aps_group_exam_udt_id(auth.getName());
			ssaService.insertSmpApsGroupExam(societySmpApsGroupExam);
		} else if (societySmpApsGroup.getSmp_aps_group_tp().equals("A0901")) {
			societySmpApsGroupSubexam.setSmp_aps_group_seq(societySmpApsGroup.getSmp_aps_group_seq());
			societySmpApsGroupSubexam.setSmp_aps_group_subexam_ins_id(auth.getName());
			societySmpApsGroupSubexam.setSmp_aps_group_subexam_udt_id(auth.getName());
			ssaService.insertSmpApsGroupSubexam(societySmpApsGroupSubexam);
		} else if (societySmpApsGroup.getSmp_aps_group_tp().equals("A0902")) {
			societySmpApsGroupConfirmation.setSmp_aps_group_seq(societySmpApsGroup.getSmp_aps_group_seq());
			societySmpApsGroupConfirmation.setSmp_aps_group_confirm_ins_id(auth.getName());
			societySmpApsGroupConfirmation.setSmp_aps_group_confirm_udt_id(auth.getName());
			ssaService.insertSmpApsGroupConfirmation(societySmpApsGroupConfirmation);
		}
		
		return "redirect:" + PathConstants.SOCIETY_SMP_ADMIN_APS_GROUP;
	}

	/**
	 * @Method Name : smp_aps_detail_insert_form
	 * @Date : 2018. 09. 10.
	 * @User : 전희배
	 * @Param :
	 * @Return : JSP 리턴페이지(평가항목종합 등록페이지)
	 * @Method 설명 : 평가항목종합 등록 폼 이동 하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_DETAIL_INSERT_FORM, method = RequestMethod.GET)
	public String smp_aps_detail_insert_form(Model model) {
		logger.debug("평가항목상세 등록 폼 이동 컨트롤러 시작");
		model = searchGisuList(model);
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_ADMIN_APS_DETAIL_INSERT_FORM;
	}

	/**
	 * @Method Name : smp_aps_detail_insert
	 * @Date : 2019. 02. 27.
	 * @User : 김홍일
	 * @Param :
	 * @Return : JSP 리턴페이지(평가항목상세 조회페이지)
	 * @Method 설명 : 평가항목상세 등록 하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_DETAIL_INSERT, method = RequestMethod.POST)
	public String smp_aps_detail_inert(Model model, Authentication auth,
			SocietySmpApsDetailExam societySmpApsDetailExam, SocietySmpApsDetailSubexam societySmpApsDetailSubexam
			,String smp_aps_detail_nm, int smp_aps_detail_ratio, int smp_aps_detail_pp, String smp_aps_detail_ct
			,String smp_aps_detail_type_radio) {
		logger.debug("평가항목상세 등록 컨트롤러 시작");
		System.out.println(societySmpApsDetailExam);
		System.out.println(societySmpApsDetailSubexam);
		
		if(smp_aps_detail_type_radio.equals("A0900")){
			societySmpApsDetailExam.setSmp_aps_detail_exam_nm(smp_aps_detail_nm);
			societySmpApsDetailExam.setSmp_aps_detail_exam_ratio(smp_aps_detail_ratio);
			societySmpApsDetailExam.setSmp_aps_detail_exam_pp(smp_aps_detail_pp);
			societySmpApsDetailExam.setSmp_aps_detail_exam_ct(smp_aps_detail_ct);
			societySmpApsDetailExam.setSmp_aps_detail_exam_ins_id(auth.getName());
			societySmpApsDetailExam.setSmp_aps_detail_exam_udt_id(auth.getName());
			ssaService.insertSmpApsDetailExam(societySmpApsDetailExam);
		}else if(smp_aps_detail_type_radio.equals("A0901")){
			societySmpApsDetailSubexam.setSmp_aps_detail_subexam_nm(smp_aps_detail_nm);
			societySmpApsDetailSubexam.setSmp_aps_detail_subexam_pp(smp_aps_detail_pp);
			societySmpApsDetailSubexam.setSmp_aps_detail_subexam_ct(smp_aps_detail_ct);
			societySmpApsDetailSubexam.setSmp_aps_detail_subexam_ins_id(auth.getName());
			societySmpApsDetailSubexam.setSmp_aps_detail_subexam_udt_id(auth.getName());
			ssaService.insertSmpApsDetailSubexam(societySmpApsDetailSubexam);
		}
		
		return "redirect:" + PathConstants.SOCIETY_SMP_ADMIN_APS_DETAIL;
	}

	/**
	 * @Method Name : SOCIETY_SMP_ADMIN_APS_TOTAL
	 * @Date : 2018. 09. 10.
	 * @User : 여명환
	 * @Param :
	 * @Return : JSP 리턴페이지(종합평가페이지)
	 * @Method 설명 : 종합평가 페이지 리턴
	 */
	@RequestMapping(value = SOCIETY_SMP_ADMIN_APS_TOTAL, method = RequestMethod.GET)
	public String smp_admin_aps_total(Model model) {
		model = searchGisuList(model);
		model.addAttribute("apsTotal", ssaService.getApsTotal());
		logger.debug("SMP 성적관리 페이지 이동 컨트롤러 시작");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_ADMIN_APS_TOTAL;
	}

	/**
	 * @Method Name : SOCIETY_SMP_ADMIN_APS_GROUP
	 * @Date : 2018. 09. 10.
	 * @User : 여명환
	 * @Param :
	 * @Return : JSP 리턴페이지(그룹평가페이지)
	 * @Method 설명 : 그룹평가 페이지 리턴
	 */
	@RequestMapping(value = SOCIETY_SMP_ADMIN_APS_GROUP, method = RequestMethod.GET)
	public String smp_admin_aps_group(Model model) {
		model = searchGisuList(model);
		
		// model.addAttribute("apsTotal", ssaService.getApsTotal());
		// model.addAttribute("apsGroup", ssaService.getApsGroup());
		 
		logger.debug("SMP 성적관리 페이지 이동 컨트롤러 시작");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_ADMIN_APS_GROUP;
	}

	/**
	 * @Method Name : SOCIETY_SMP_ADMIN_APS_DETAIL
	 * @Date : 2018. 09. 10.
	 * @User : 여명환
	 * @Param :
	 * @Return : JSP 리턴페이지(개별평가페이지)
	 * @Method 설명 : 상세평가 페이지 리턴
	 */
	@RequestMapping(value = SOCIETY_SMP_ADMIN_APS_DETAIL, method = RequestMethod.GET)
	public String smp_admin_aps_detail(Model model) {
		model = searchGisuList(model);
		System.out.println("상세평가 모델 : " + model);
		/*model.addAttribute("apsTotal", ssaService.getApsTotal());
		model.addAttribute("apsGroup", ssaService.getApsGroup());
		model.addAttribute("apsDetail", ssaService.getApsDetail());*/
		logger.debug("SMP 성적관리 페이지 이동 컨트롤러 시작");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_ADMIN_APS_DETAIL;
	}

	/**
	 * @Method Name : SOCIETY_SMP_SEARCH_TOTAL
	 * @Date : 2018. 09. 10.
	 * @User : 여명환
	 * @Param :
	 * @Return : JSP 리턴페이지(개별평가페이지)
	 * @Method 설명 : 개별평가 페이지 리턴
	 */
	/*@RequestMapping(value = SOCIETY_SMP_SEARCH_TOTAL, method = RequestMethod.POST)
	public String search_subject(Model model) {
		model = searchGisuList(model);
		model.addAttribute("apsTotal", ssaService.getApsTotal());
		model.addAttribute("apsGroup", ssaService.getApsGroup());
		model.addAttribute("apsDetail", ssaService.getApsDetail());
		logger.debug("SMP 성적관리 페이지 이동 컨트롤러 시작");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_ADMIN_APS_DETAIL;
	}*/

	/**
	 * @Method Name : SOCIETY_SMP_ADMIN_APS_SETEVAL
	 * @Date : 2019. 01. 14.
	 * @User : 김홍일
	 * @Param :
	 * @Return : JSP 리턴페이지(빠른 상세설정 페이지)
	 * @Method 설명 : 빠른 상세설정 페이지 리턴
	 */
	@RequestMapping(value = SOCIETY_SMP_ADMIN_APS_SETEVAL, method = RequestMethod.GET)
	public String smp_admin_aps_seteval(Model model) {
		logger.debug("SMP 성적관리 페이지 이동 컨트롤러 시작");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_ADMIN_APS_SETEVAL;
	}

	/**
	 * @Method Name : smp_aps_total_update_form
	 * @Date : 2018. 09. 13.
	 * @User : 전희배
	 * @Param :
	 * @Return : JSP 리턴페이지(평가항목종합 수정페이지)
	 * @Method 설명 : 평가항목종합 등록 폼 이동 하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_TOTAL_UPDATE_FORM, method = RequestMethod.GET)
	public String smp_aps_total_update_form(Model model, int smp_aps_total_seq) {
		logger.debug("평가항목종합 등록 폼 이동 컨트롤러 시작");
		model = searchGisuList(model);
		HashMap<String, Object> totalDetail = ssaService.selectApsTotalDetail(smp_aps_total_seq);
		model.addAttribute("totalDetail", totalDetail);
		model.addAttribute("smp_aps_total_seq", smp_aps_total_seq);
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_ADMIN_APS_TOTAL_UPDATE_FORM;
	}

	/**
	 * @Method Name : smp_aps_total_update
	 * @Date : 2018. 09. 13.
	 * @User : 전희배
	 * @Param :
	 * @Return : JSP 리턴페이지(평가항목종합 수정페이지)
	 * @Method 설명 : 평가항목종합 등록 하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_TOTAL_UPDATE, method = RequestMethod.POST)
	public String smp_aps_total_update(Model model, Authentication auth, int gisu_seq, int smp_aps_total_seq,
			String smp_aps_total_nm, int smp_aps_total_ratio, String smp_aps_total_ct) {
		logger.debug("평가항목종합 등록 컨트롤러 시작");
		ssaService.updateApsTotal(gisu_seq, smp_aps_total_seq, smp_aps_total_nm, smp_aps_total_ratio, auth.getName(),
				smp_aps_total_ct);
		return "redirect:" + PathConstants.SOCIETY_SMP_ADMIN_APS_TOTAL;
	}

	/**
	 * @Method Name : smp_aps_group_update_form
	 * @Date : 2018. 09. 13.
	 * @User : 전희배
	 * @Param :
	 * @Return : JSP 리턴페이지(평가항목그룹 수정페이지)
	 * @Method 설명 : 평가항목종합 등록 폼 이동 하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_GROUP_UPDATE_FORM, method = RequestMethod.GET)
	public String smp_aps_group_update_form(Model model, int smp_aps_group_seq) {
		logger.debug("평가항목그룹 등록 폼 이동 컨트롤러 시작");
		model = searchGisuList(model);
		HashMap<String, Object> groupDetail = ssaService.selectApsGroupDetail(smp_aps_group_seq);
		model.addAttribute("groupDetail", groupDetail);
		String smp_aps_group_tp_code = (String) groupDetail.get("smp_aps_group_tp");
		String smp_aps_group_tp = "";
		if (smp_aps_group_tp_code.equals("A0900")) {
			smp_aps_group_tp = "test";
		} // 시험
		else if (smp_aps_group_tp_code.equals("A0901")) {
			smp_aps_group_tp = "confirmation";
		} // 확인서
		else if (smp_aps_group_tp_code.equals("A0902")) {
			smp_aps_group_tp = "individualScore";
		} // 개별점수

		model.addAttribute("smp_aps_group_tp", smp_aps_group_tp);
		model.addAttribute("smp_aps_group_seq", smp_aps_group_seq);
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_ADMIN_APS_GROUP_UPDATE_FORM;
	}

	/**
	 * @Method Name : smp_aps_group_update
	 * @Date : 2018. 09. 13.
	 * @User : 전희배
	 * @Param :
	 * @Return : JSP 리턴페이지(평가항목그룹 수정페이지)
	 * @Method 설명 : 평가항목그룹 등록 하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_GROUP_UPDATE, method = RequestMethod.GET)
	public String smp_aps_group_update(Model model, Authentication auth, int smp_aps_group_seq, int smp_aps_total_seq,
			String smp_aps_group_nm, int smp_aps_group_ratio, String smp_aps_group_tp, String smp_aps_group_ct) {
		logger.debug("평가항목그룹 등록 컨트롤러 시작");
		String smp_aps_group_tp_code = "";
		if (smp_aps_group_tp.equals("test")) {
			smp_aps_group_tp_code = "A0900";
		} // 시험
		else if (smp_aps_group_tp.equals("confirmation")) {
			smp_aps_group_tp_code = "A0901";
		} // 확인서
		else if (smp_aps_group_tp.equals("individualScore")) {
			smp_aps_group_tp_code = "A0902";
		} // 개별점수
		ssaService.updateApsGroup(smp_aps_group_seq, smp_aps_group_nm, smp_aps_group_tp_code, smp_aps_group_ratio,
				auth.getName(), smp_aps_group_ct);
		return "redirect:" + PathConstants.SOCIETY_SMP_ADMIN_APS_GROUP;
	}

	/**
	 * @Method Name : smp_aps_detail_update_form
	 * @Date : 2018. 09. 13.
	 * @User : 전희배
	 * @Param :
	 * @Return : JSP 리턴페이지(평가항목상세 수정페이지)
	 * @Method 설명 : 평가항목종합 등록 폼 이동 하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_DETAIL_UPDATE_FORM, method = RequestMethod.GET)
	public String smp_aps_detail_update_form(Model model, int smp_aps_detail_seq) {
		logger.debug("평가항목상세 등록 폼 이동 컨트롤러 시작");
		model = searchGisuList(model);
		HashMap<String, Object> detailDetail = ssaService.selectApsDetailDetail(smp_aps_detail_seq);
		model.addAttribute("detailDetail", detailDetail);
		model.addAttribute("smp_aps_detail_seq", smp_aps_detail_seq);
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_ADMIN_APS_DETAIL_UPDATE_FORM;
	}

	/**
	 * @Method Name : smp_aps_detail_update
	 * @Date : 2018. 09. 13.
	 * @User : 전희배
	 * @Param :
	 * @Return : JSP 리턴페이지(평가항목상세 수정페이지)
	 * @Method 설명 : 평가항목상세 등록 하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_DETAIL_UPDATE, method = RequestMethod.GET)
	public String smp_aps_detail_update(Model model, Authentication auth, int smp_aps_detail_seq, int smp_aps_group_seq,
			String smp_aps_detail_nm, int smp_aps_detail_ratio, String smp_aps_detail_ct) {
		logger.debug("평가항목상세 등록 컨트롤러 시작");
		ssaService.updateApsDetail(smp_aps_detail_seq, smp_aps_detail_nm, smp_aps_detail_ratio, auth.getName(),
				smp_aps_detail_ct);
		return "redirect:" + PathConstants.SOCIETY_SMP_ADMIN_APS_DETAIL;
	}

	/**
	 * @Method Name : smp_admin_aps_setlist
	 * @Date : 2018. 09. 11.
	 * @User : 박찬주
	 * @Param :
	 * @Return : JSP 리턴페이지(평가설정페이지)
	 * @Method 설명 : 평가설정 페이지 리턴
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_SETLIST, method = RequestMethod.GET)
	public String smp_admin_aps_setlist(Model model) {
		List<SocietyEduAdminCurriculumGisu> SEACurGisuList = ssaService.selectGisuSeqNumList();
		model.addAttribute("gisu_list", SEACurGisuList);
		model.addAttribute("apsSetList", ssaService.selectSmpApsSetList());
		logger.debug("SMP 평가설정 페이지 이동 컨트롤러 시작");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_ADMIN_APS_SETLIST;
	}

	/**
	 * @Method Name : addSetList
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param :
	 * @Return :
	 * @Method 설명 : selectApsGroupList의 쿼리가 변경되어 사용이 불가해진 메소드
	 */
	/*@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_ADDSETLIST, method = RequestMethod.POST)
	public String addSetList(int gisu_seq, String setlist_nm, Authentication auth) {
		SocietySmpApsSetList setList = new SocietySmpApsSetList();
		setList.setSmp_aps_setlist_nm(setlist_nm);
		setList.setSmp_aps_setlist_ins_id(auth.getName());
		ssaService.insertApsSetList(setList);
		int aps_setlist_seq = setList.getSmp_aps_setlist_seq();

		List<SocietySmpApsTotal> smpApsTotalList = ssaService.selectApsTotalListByGisuSeq(gisu_seq);
		for (int i = 0; i < smpApsTotalList.size(); i++) {
			SocietySmpApsSetTotal setTotal = new SocietySmpApsSetTotal();
			setTotal.setSmp_aps_setlist_seq(aps_setlist_seq);
			setTotal.setSmp_aps_settotal_nm(smpApsTotalList.get(i).getSmp_aps_total_nm());
			setTotal.setSmp_aps_settotal_ratio(smpApsTotalList.get(i).getSmp_aps_total_ratio());
			setTotal.setSmp_aps_settotal_ins_id(auth.getName());
			ssaService.insertApsSetTotal(setTotal);
			int aps_settotal_seq = setTotal.getSmp_aps_settotal_seq();

			List<SocietySmpApsGroup> smpApsGroupList = ssaService.selectApsGroupList(smpApsTotalList.get(i).getSmp_aps_total_seq());
			for (int j = 0; j < smpApsGroupList.size(); j++) {
				SocietySmpApsSetGroup setGroup = new SocietySmpApsSetGroup();
				setGroup.setSmp_aps_settotal_seq(aps_settotal_seq);
				setGroup.setSmp_aps_setgroup_tp(smpApsGroupList.get(j).getSmp_aps_group_tp());
				setGroup.setSmp_aps_setgroup_ins_id(auth.getName());
				ssaService.insertApsSetGroup(setGroup);
				int aps_setgroup_seq = setGroup.getSmp_aps_setgroup_seq();

				List<SocietySmpApsDetail> smpApsDetailList = ssaService
						.selectApsDetailList(smpApsGroupList.get(j).getSmp_aps_group_seq());
				for (int k = 0; k < smpApsDetailList.size(); k++) {
					SocietySmpApsSetDetail setDetail = new SocietySmpApsSetDetail();
					setDetail.setSmp_aps_setgroup_seq(aps_setgroup_seq);
					setDetail.setSmp_aps_setdetail_nm(smpApsDetailList.get(k).getSmp_aps_detail_nm());
					setDetail.setSmp_aps_setdetail_ratio(smpApsDetailList.get(k).getSmp_aps_detail_ratio());
					setDetail.setSmp_aps_setdetail_ins_id(auth.getName());
					ssaService.insertApsSetDetail(setDetail);
				}
			}
		}

		return "redirect:" + PathConstants.SOCIETY_SMP_ADMIN_ADDSETLIST;
	}*/

	/**
	 * @Method Name : loginadmin
	 * @Date : 2018. 09. 04.
	 * @User : 여명환
	 * @Param : -
	 * @Return : 학사관리 메인 페이지
	 * @Method 설명 : 메인 페이지 접속 메소드
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_ADMINLOGIN, method = RequestMethod.GET)
	public String adminlogin() {
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_ADMIN_ADMINLOGIN;
	}

}
