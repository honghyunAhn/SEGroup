package global.segroup.society.smp.user.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import global.segroup.domain.AdminSecurity;
import global.segroup.domain.BoardContent;
import global.segroup.domain.BoardGroup;
import global.segroup.domain.User;
import global.segroup.domain.UserSecurity;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculumGisu;
import global.segroup.society.edu.admin.service.SocietyEduAdminService;
import global.segroup.society.smp.admin.service.SocietySmpAdminService;
import global.segroup.util.PageNavigator;
import global.segroup.util.PathConstants;
@Controller
public class SocietySmpUserViewController implements PathConstants{

	private static final Logger logger = LoggerFactory.getLogger(SocietySmpUserViewController.class);
	

	@Autowired
	private SocietySmpAdminService ssaService;
	@Autowired
	private SocietyEduAdminService seadminService;
	
	// 전희배
	@Value("#{props['smp.board.notice_file']}")
	private String smpBoardNoticeFile;

	
	/**
	 * @Method Name : loginmain
	 * @Date : 2018. 8. 20.
	 * @User : 여명환
	 * @Param : -
	 * @Return : 학사관리 메인 페이지
	 * @Method 설명 :  메인 페이지 접속 메소드
	 */
	@RequestMapping(value=PathConstants.SOCIETY_SMP_USERMAIN, method = RequestMethod.GET)
	public String usermain(){
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_SMP_USERMAIN;
	}
	
	

	/**
	 * @Method Name : smp_login_success
	 * @Date : 2018. 8. 27.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 학사관리 메인 페이지
	 * @Method 설명 :  로그인 성공 시 메인페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_LOGIN_SUCCESS , method = RequestMethod.GET)
	public String smp_userlogin_success() {
		logger.debug("학사관리 로그인 성공 컨트롤러 시작");
		logger.debug("학사관리 로그인 성공 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_SMP_USERMAIN;
	}
	
	/**
	 * @Method Name : smp_login_success
	 * @Date : 2018. 8. 27.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 학사관리 메인 페이지
	 * @Method 설명 :  로그인 성공 시 메인페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMINLOGIN_SUCCESS , method = RequestMethod.GET)
	public String smp_adminlogin_success() {
		logger.debug("학사관리 로그인 성공 컨트롤러 시작");
		logger.debug("학사관리 로그인 성공 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_SMP_FINAL_PASS;
	}
	
	/**
	 * @Method Name : smp_access_denied
	 * @Date : 2018. 8. 27.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 학사관리 접근 권한 없음 페이지
	 * @Method 설명 :  접근 권한 없는 유저가 특정 페이지 접근 시 실행
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ACCESS_DENIED , method = RequestMethod.GET)
	public String smp_access_denied() {
		logger.debug("학사관리 접근 권한 없음 컨트롤러 시작");
		logger.debug("학사관리 접근 권한 없음 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_SMP_ACCESS_DENIED;
	}
	
	/**
	 * @Method Name : smp_user_board
	 * @Date : 2018. 08. 30.
	 * @User : 전희배
	 * @Param : -
	 * @Return : JSP 리턴 페이지(모집홍보의 공지사항 페이지)
	 * @Method 설명 : 모집홍보 공지사항 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = SOCIETY_SMP_USER_BOARD, method = RequestMethod.GET)
	public String smp_user_board(Model model, Authentication auth,@RequestParam(defaultValue="contents") String searchOption,
            @RequestParam(defaultValue="") String keyword,
            @RequestParam(defaultValue="1") int curPage,@RequestParam(defaultValue="0") String gisu_seq, BoardGroup boardGroup ){
		logger.debug("전체공지 게시글 리스트 조회 컨트롤러 시작");
		String  board_seq = "12"; //기수별공지게시판 seq
		ArrayList<HashMap<String, Object>> gisuBoardList = ssaService.board_gisu_search();
		if(gisu_seq.equals("0")) {
		gisu_seq = (String.valueOf(gisuBoardList.get(0).get("gisu_seq")));
		}
		User user = new User();
		if(auth.getDetails() instanceof UserSecurity) {
			user.setUser_id(auth.getName());
			User userInfo = seadminService.user_info_select(user);
			String id = userInfo.getUser_id();
			SocietyEduAdminCurriculumGisu gisu_info = ssaService.get_specific_user_gisu(id);
			gisu_seq=""+gisu_info.getGisu_seq();
		}
		
		String gisu_num ="";
		for(int i=0;i<gisuBoardList.size();i++) {
			String result = (String.valueOf(gisuBoardList.get(i).get("gisu_seq")));
			if(result.equals(gisu_seq)) {
				gisu_num=""+gisuBoardList.get(i).get("gisu_crc_nm");
				break;
			}
		}
		int totalRecordsCount = ssaService.gettotal(searchOption, keyword,board_seq,gisu_seq);
		PageNavigator navi = new PageNavigator(5, 5, curPage, totalRecordsCount);
		RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());
		
		ArrayList<HashMap<String, Object>> mainBoardList = (ArrayList<HashMap<String, Object>>) ssaService.smpMainBoardListAll(searchOption,keyword,board_seq,gisu_seq);
		ArrayList<HashMap<String, Object>> boardList = (ArrayList<HashMap<String, Object>>) ssaService.smpBoardListAll(rb,searchOption,keyword,board_seq,gisu_seq);
		Map<String, Object> map = new HashMap<String, Object>();
		    
		map.put("keyword", keyword); // 검색키워드
		map.put("navi", navi);
 
		model.addAttribute("mainBoardList", mainBoardList);
		//model.addAttribute("gisuBoardList", gisuBoardList); 
		model.addAttribute("seaCurList", seadminService.searchCurGisuList(1)); //0917수정
		model.addAttribute("boardList", boardList);
		model.addAttribute("map", map);
		
		boardGroup.setBoard_seq(Integer.parseInt(board_seq));
		model.addAttribute("boardGroup", boardGroup);
		model.addAttribute("gisu_seq", gisu_seq);
		model.addAttribute("gisu_num", gisu_num);
		
		
		if(auth.getDetails() instanceof AdminSecurity)
			model.addAttribute("Admin", "Admin");
		if(auth.getDetails() instanceof UserSecurity)
			model.addAttribute("User", "User");
		
		logger.debug("전체공지 게시글 리스트 조회 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+SOCIETY_SMP_USER_BOARD;
	}
	
	/**
	 * @Method Name : smp_user_board_detail
	 * @Date : 2018. 08. 30.
	 * @User : 전희배
	 * @Param : -
	 * @Return : JSP 리턴 페이지(이미지 게시판 내용보기 페이지)
	 * @Method 설명 : 이미지 내용보기 페이지를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = SOCIETY_SMP_USER_BOARD_DETAIL, method = RequestMethod.GET)
	public String smp_user_board_detail(BoardGroup boardGroup,Model model, Authentication auth, 
			String seq, String searchOption,HttpServletRequest request, String gisu_seq){

		logger.debug("공지사항 게시판을 내용을 호출하는 컨트롤러 시작");
		int board_content_seq = Integer.parseInt(seq);
		
		HashMap<String, Object> resultMap = seadminService.board_contents_detail(board_content_seq);

		String path = smpBoardNoticeFile;

		model.addAttribute("contentDetail", resultMap);
		model.addAttribute("boardGroup", boardGroup);
		model.addAttribute("path", path);
		model.addAttribute("gisu_seq",gisu_seq);
		
		
		Gson gson = new Gson();
		model.addAttribute("fileList", gson.toJson(resultMap.get("fileList")));
		model.addAttribute("board_seq", boardGroup.getBoard_seq());
		
		if(auth.getDetails() instanceof AdminSecurity)
			model.addAttribute("Admin", "Admin");
		if(auth.getDetails() instanceof UserSecurity) {
			model.addAttribute("User", "User");	
			seadminService.board_contents_hit_update(board_content_seq);//조회수 증가 
		}
			logger.debug("전체공지 관리자 게시글 세부 내용 수정 폼 이동 컨트롤러 종료");
		
		
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_SMP_USER_BOARD_DETAIL;
	}
	
	/**
	 * @Method Name : loginuser
	 * @Date : 2018. 09. 04.
	 * @User : 여명환
	 * @Param : -
	 * @Return : 학사관리 로그인 페이지
	 * @Method 설명 : 로그인 접속 메소드
	 */
	@RequestMapping(value=PathConstants.SOCIETY_SMP_USER_USERLOGIN, method = RequestMethod.GET)
	public String userlogin(){
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_SMP_USER_USERLOGIN;
	}
	
	/**
	 * @Method Name : get_mainpage_board
	 * @Date : 2018. 09. 05.
	 * @User : 여명환
	 * @Param : -
	 * @Return : 공지
	 * @Method 설명 : 메인 페이지에서 공지 조회
	 */		
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_SMP_USER_BOARD_MAINPAGE_FORM, method = RequestMethod.POST)
	public ArrayList<BoardContent> get_mainpage_board(int gisu_seq, Authentication auth, Model model){
		ArrayList<BoardContent> result = ssaService.selectMainPageBoard(gisu_seq);
		return result;
	}
}
