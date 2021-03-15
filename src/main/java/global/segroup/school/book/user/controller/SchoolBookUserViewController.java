package global.segroup.school.book.user.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

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

import global.segroup.school.book.admin.domain.BookInfo;
import global.segroup.school.book.domain.PurchaseReq;
import global.segroup.school.book.domain.RentalState;
import global.segroup.school.book.user.domain.BookMark;
import global.segroup.school.book.user.domain.Review;
import global.segroup.school.book.user.domain.SchoolBookUser;
import global.segroup.school.book.user.service.SchoolBookUserService;
import global.segroup.school.book.util.SortBookInfoByDate;
import global.segroup.school.book.util.SortBookInfoByDate.Ascending;
import global.segroup.school.book.util.SortBookInfoByDate.Descending;
import global.segroup.util.PageNavigator;
import global.segroup.util.PathConstants;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 17.
 * @Class 설명 : Soft Engineer School 도서관리 회원 View 컨트롤러
 * 
 */
@Controller
public class SchoolBookUserViewController implements PathConstants {

	private static final Logger logger = LoggerFactory.getLogger(SchoolBookUserViewController.class);

	@Autowired
	private SchoolBookUserService sbuService;

	@Value("#{board['board.countperpage']}")
	int countPerPage;
	@Value("#{board['board.pagepergroup']}")
	int pagePerGroup;
	
	private SortBookInfoByDate sortByDate = new SortBookInfoByDate();
	private Ascending ascending = sortByDate.new Ascending();
	private Descending descending = sortByDate.new Descending();

	/**
	 * @Method Name : selectUser
	 * @Date : 2017. 7. 17.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 : 회원 아이디를 회원 검색 서비스로 전달하고, 전달받은 회원 정보 객체를 화면으로 전달해준다.
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_USER_SELECT, method = RequestMethod.POST)
	public String selectUser(String id, Model model, HttpSession session) {
		logger.debug("도서관리 회원 검색 View 컨트롤러 시작");

		SchoolBookUser sbu = sbuService.selectUser(id);
		model.addAttribute(sbu);
		session.setAttribute("loginId","test");

		logger.debug("도서관리 회원 검색 View 컨트롤러 종료");
		return "home";
	}
	
	/**
	 * @Method Name : userStatus
	 * @Date : 2017. 7. 27.
	 * @User : 이정식
	 * @Param :
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 :
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_USER_STATUS, method = RequestMethod.GET)
	public String userStatus(Model model, HttpSession session) {

		logger.debug("도서관리 회원 검색 View 컨트롤러 시작");

		String loginId = "sunhk434";
		// String loginId = (String) session.getAttribute("loginId");

		ArrayList<RentalState> rentalStateList = sbuService.selectRentalStateList(loginId);
		model.addAttribute("rentalStateList", rentalStateList);

		logger.debug("도서관리 회원 검색 View 컨트롤러 종료");

		
		ArrayList<BookInfo> delayList = new ArrayList<>(); 
		delayList.add(new BookInfo("isbn4", 1, 1, null, null, "category4", "division4", "title4", "publisher4", "author4", null, 4, true, true, false, null, null, "20170504", null)); 
		Collections.sort(delayList, ascending);
		
		ArrayList<BookInfo> rentList = new ArrayList<>();
		Collections.sort(rentList, ascending);
		
		ArrayList<BookInfo> reserveList = new ArrayList<>();
		Collections.sort(reserveList, ascending);
		
		model.addAttribute("delayList", delayList);
		model.addAttribute("rentList", rentList);
		model.addAttribute("reserveList", reserveList);
		
		return PathConstants.SEGROUP_SCHOOL + PathConstants.SCHOOL_BOOK_USER_STATUS;
	}

	/**
	 * @Method Name : userBookmark
	 * @Date : 2017. 7. 27.
	 * @User : 이정식
	 * @Param :
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 :
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_USER_BOOKMARK, method = RequestMethod.GET)
	public String userBookmark(Model model, HttpSession session) {
		logger.debug("도서관리 회원 검색 View 컨트롤러 시작");

		String loginId = "jsl";
		// String loginId = (String) session.getAttribute("loginId");

		ArrayList<BookMark> bookmarkList = sbuService.selectBookMarkList(loginId);
		// sorting
		model.addAttribute("bookmarkList", bookmarkList);

		logger.debug("도서관리 회원 검색 View 컨트롤러 종료");

		return PathConstants.SEGROUP_SCHOOL + PathConstants.SCHOOL_BOOK_USER_BOOKMARK;
	}

	/**
	 * @Method Name : userRequest
	 * @Date : 2017. 7. 27.
	 * @User : 이정식
	 * @Param :
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 :
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_USER_REQUEST, method = RequestMethod.GET)
	public String userRequest(Model model, HttpSession session) {
		logger.debug("도서관리 회원 검색 View 컨트롤러 시작");

		String loginId = "jsl";
		// String loginId = (String) session.getAttribute("loginId");
		model.addAttribute("purchase_req_id", loginId);

		logger.debug("도서관리 회원 검색 View 컨트롤러 종료");

		return PathConstants.SEGROUP_SCHOOL + PathConstants.SCHOOL_BOOK_USER_REQUEST;
	}

	/**
	 * @Method Name : userRequest
	 * @Date : 2017. 7. 27.
	 * @User : 이정식
	 * @Param :
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 :
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_USER_REQUEST, method = RequestMethod.POST)
	public String userRequest(PurchaseReq request, Model model, HttpSession session) {
		logger.debug("도서관리 회원 검색 View 컨트롤러 시작");

		String loginId = "jsl"; 
		// String loginId = (String) session.getAttribute("loginId");
		model.addAttribute("purchase_req_id", loginId);
		String result = announcement(sbuService.insertPurchaseReq(request));
		model.addAttribute("result", result);
 
		logger.debug("도서관리 회원 검색 View 컨트롤러 종료");

		return PathConstants.SEGROUP_SCHOOL + PathConstants.SCHOOL_BOOK_USER_REQUEST;
	}

	/**
	 * @Method Name : userRentRecord
	 * @Date : 2017. 7. 27.
	 * @User : 이정식
	 * @Param :
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 :
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_USER_RENT_RECORD, method = RequestMethod.GET)
	public String userRentRecord(Model model, HttpSession session) {
		logger.debug("도서관리 회원 검색 View 컨트롤러 시작");

		String loginId = "jsl";
		// String loginId = (String) session.getAttribute("loginId");
		ArrayList<RentalState> rentalStateList = sbuService.selectRentalStateList(loginId);
		model.addAttribute("rentalStateList", rentalStateList);

		logger.debug("도서관리 회원 검색 View 컨트롤러 종료");

		return PathConstants.SEGROUP_SCHOOL + PathConstants.SCHOOL_BOOK_USER_RENT_RECORD;
	}

	/**
	 * @Method Name : userReview
	 * @Date : 2017. 7. 27.
	 * @User : 이정식
	 * @Param :
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 :
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_USER_REVIEW, method = RequestMethod.GET)
	public String userReview(Model model, HttpSession session) {
		logger.debug("도서관리 회원 검색 View 컨트롤러 시작");

		String loginId = "jsl";
		// String loginId = (String) session.getAttribute("loginId");
		ArrayList<Review> reviewList = sbuService.selectReviewList(loginId);
		model.addAttribute("reviewList", reviewList);

		logger.debug("도서관리 회원 검색 View 컨트롤러 종료");

		return PathConstants.SEGROUP_SCHOOL + PathConstants.SCHOOL_BOOK_USER_REVIEW;
	}

	/**
	 * @Method Name : announcement
	 * @Date : 2017. 8. 2.
	 * @User : 이정식
	 * @Param :
	 * @Return :
	 * @Method 설명 :
	 */
	public String announcement(int result) {
		String announcement = "fail";
		if (result > 0) {
			announcement = "success";
		}
		return announcement;
	}
	
	/**
	 * @Method Name : client_main
	 * @Date : 2017. 8. 29.
	 * @User : 이종호
	 * @Param :
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 : 유저 랜딩페이지로 이동
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_USER_MAIN, method = RequestMethod.GET)
	public String client_main(
			@RequestParam(value="page", defaultValue="1") int page,
			Model model) {
		logger.debug("유저 랜딩페이지 시작");
		
		int total = sbuService.getTotalBook(null);
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		List<HashMap<String, Object>> resultList = sbuService.search_result(null, navi.getStartRecord(), navi.getCountPerPage());
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("navi", navi);
		
		logger.debug("유저 랜딩페이지 종료");
		return PathConstants.SEGROUP_SCHOOL + PathConstants.SCHOOL_BOOK_USER_MAIN;
	}
	
	/**
	 * @Method Name : search_result
	 * @Date : 2017. 8. 29.
	 * @User : 이종호
	 * @Param : 검색 정보 (BookInfo: 제목, 저자, 출판사, ISBN, 분류 / String: 발행일 range)
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 : 데이터베이스로부터 세부검색 결과를 가지고 검색결과를 보여주기 위한 페이지로 이동
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_USER_SEARCH_RESULT, method = RequestMethod.POST)
	public String search_result(
			@RequestParam(value="page", defaultValue="1") int page,
			BookInfo bookInfo,
			String advanced_start_date,
			String advanced_end_date,
			Model model) {
		logger.debug("유저 세부검색 결과 요청 컨트롤러 시작");
		
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("bookInfo", bookInfo);
		paramMap.put("advanced_start_date", advanced_start_date);
		paramMap.put("advanced_end_date", advanced_end_date);
		
		int total = sbuService.getTotalBook(paramMap);
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		List<HashMap<String, Object>> resultList = sbuService.search_result(paramMap,navi.getStartRecord(), navi.getCountPerPage());
		
		System.out.println(resultList);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("navi", navi);
		model.addAttribute("paramMap", paramMap);
		
		logger.debug("유저 세부검색 결과 요청 컨트롤러 종료");
		return PathConstants.SEGROUP_SCHOOL + PathConstants.SCHOOL_BOOK_USER_MAIN;
	}
	
	/**
	 * @Method Name : detailed_bookinfo
	 * @Date : 2017. 8. 07.
	 * @User : 이상철
	 * @Param : ISBN
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 : ISBN을 모델에 저장한 뒤 해당 ISBN으로 책의 세부정보를 불러옴
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_USER_DETAILED_BOOKINFO, method=RequestMethod.GET)
	public String detailed_bookinfo(String isbn, Model model){
		logger.debug("유저 책 세부정보 페이지");
		model.addAttribute("isbn", isbn);
		return PathConstants.SEGROUP_SCHOOL + PathConstants.SCHOOL_BOOK_USER_DETAILED_BOOKINFO;
	}
	
	/**
	 * @Method Name : login_success
	 * @Date : 2017. 8. 28.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴 페이지(도서관리 메인 페이지)
	 * @Method 설명 : 로그인 한 회원 정보를 가지고 도서관리 메인 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_USER_LOGIN_SUCCESS, method = RequestMethod.GET)
	public String login_success(Model model, Authentication auth){
		logger.debug("도서관리 회원 로그인 성공 컨트롤러 시작");
		
		SchoolBookUser sbUser = sbuService.selectUser(auth.getName());
		model.addAttribute("sbUser", sbUser);
		
		logger.debug("도서관리 회원 로그인 성공 컨트롤러 종료");
		return "forward:"+PathConstants.SCHOOL_BOOK_USER_MAIN;
	}
	
	/**
	 * @Method Name : login_access_denied
	 * @Date : 2017. 8. 28.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴 페이지(도서관리 회원 접근 권한 페이지)
	 * @Method 설명 : 접근 권한이 없는 유저가 도서 관리에 접근 했을 때 실행 되는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_USER_ACCESS_DENIED, method = RequestMethod.GET)
	public String login_access_denied(){
		logger.debug("도서관리 회원 접근 권한 없음 컨트롤러 시작");
		logger.debug("도서관리 회원 접근 권한 없음 컨트롤러 종료");
		return PathConstants.SEGROUP_SCHOOL+PathConstants.SCHOOL_BOOK_USER_ACCESS_DENIED;
	}
}
