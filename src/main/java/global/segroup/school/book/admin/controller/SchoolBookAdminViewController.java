package global.segroup.school.book.admin.controller;

import java.util.ArrayList;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import global.segroup.school.book.admin.domain.BookInfo;
import global.segroup.school.book.admin.service.SchoolBookAdminService;
import global.segroup.school.book.domain.RentalState;
import global.segroup.school.book.user.domain.SchoolBookUser;
import global.segroup.util.PathConstants;

/**
 * @Author : 선희경
 * @Date : 2017. 7. 24.
 * @Class 설명 : Soft Engineer School 도서관리 관리자 View 컨트롤러
 * 
 */
@Controller
public class SchoolBookAdminViewController implements PathConstants {

	private static final Logger logger = LoggerFactory.getLogger(SchoolBookAdminViewController.class);

	@Autowired
	private SchoolBookAdminService sbaService;

	
	/**
	 * @Method Name : admin_main
	 * @Date : 2017. 7. 26.
	 * @User : 선희경
	 * @Param : null
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 : 관리자 - 메인 - 페이지 접속 메소드
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_ADMIN_MAIN, method = RequestMethod.GET)
	public String admin_main(Locale locale, Model model) {
		logger.debug(">> 관리자 홈", locale);
		
		model.addAttribute("overdueList", sbaService.overdueList());
		model.addAttribute("returnList", sbaService.returnList());
		
		return PathConstants.SEGROUP_SCHOOL+PathConstants.SCHOOL_BOOK_ADMIN_MAIN;
	}
	
	
	/**
	 * @Method Name : st_manage
	 * @Date : 2017. 7. 24.
	 * @User : 선희경
	 * @Param : null
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 : 관리자 - 대여현황 - 페이지 접속 메소드
	 */
	@RequestMapping(value =  PathConstants.SCHOOL_BOOK_ADMIN_STATUS_MANAGE, method = RequestMethod.GET)
	public String st_manage(Locale locale, Model model) {
		logger.debug(">> 대여 현황", locale);

		model.addAttribute("statusList", sbaService.statusList("0"));
		
		return PathConstants.SEGROUP_SCHOOL+PathConstants.SCHOOL_BOOK_ADMIN_STATUS_MANAGE;
	}


	/**
	 * @Method Name : st_reserv
	 * @Date : 2017. 7. 24.
	 * @User : 선희경
	 * @Param : null
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 : 관리자 - 예약현황 - 페이지 접속 메소드
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_ADMIN_STATUS_RESERV, method = RequestMethod.GET)
	public String st_reserv(Locale locale, Model model) {
		logger.debug(">> 예약 현황", locale);
		
		model.addAttribute("reservList", sbaService.reservList());
		
		return PathConstants.SEGROUP_SCHOOL+PathConstants.SCHOOL_BOOK_ADMIN_STATUS_RESERV;
	}

	/**
	 * @Method Name : bk_lend
	 * @Date : 2017. 7. 25.
	 * @User : 선희경
	 * @Param : null
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 : 관리자 - 대여 신청 - 페이지 접속 메소드
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_ADMIN_BOOK_LENDING, method = RequestMethod.GET)
	public String bk_lend(Locale locale, Model model) {
		logger.debug(">> 대여 신청", locale);

		model.addAttribute("rentalList", sbaService.rentalList());

		return PathConstants.SEGROUP_SCHOOL+PathConstants.SCHOOL_BOOK_ADMIN_BOOK_LENDING;
	}

	
	/**
	 * @Method Name : admin_member
	 * @Date : 2017. 7. 25.
	 * @User : 선희경
	 * @Param : null
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 : 관리자 - 회원관리 - 페이지 접속 메소드
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_ADMIN_MANAGE_MEMBER, method = RequestMethod.GET)
	public String admin_member(Locale locale, Model model) {
		logger.debug(">> 회원관리", locale);

		ArrayList<SchoolBookUser> stdList = sbaService.stdList(null, null);
		model.addAttribute("stdList",stdList);

		return PathConstants.SEGROUP_SCHOOL+PathConstants.SCHOOL_BOOK_ADMIN_MANAGE_MEMBER;
	}

	
	/**
	 * @Method Name : admin_book
	 * @Date : 2017. 7. 25.
	 * @User : 선희경
	 * @Param : null
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 : 관리자 - 도서관리 - 페이지 접속 메소드
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_ADMIN_MANAGE_BOOK, method = RequestMethod.GET)
	public String admin_book(Locale locale, Model model) {
		logger.debug(">> 도서관리", locale);

		ArrayList<BookInfo> bookList = sbaService.bookList();
		model.addAttribute("bookList",bookList);

		return PathConstants.SEGROUP_SCHOOL+PathConstants.SCHOOL_BOOK_ADMIN_MANAGE_BOOK;
	}

	
	/**
	 * @Method Name : bk_apply
	 * @Date : 2017. 7. 25.
	 * @User : 선희경
	 * @Param : null
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 : 관리자 - 도서 신청 - 페이지 접속 메소드
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_ADMIN_BOOK_APPLY, method = RequestMethod.GET)
	public String bk_apply(Locale locale, Model model) {
		logger.debug(">> 도서 신청", locale);
		
		model.addAttribute("applyList", sbaService.applyList());
		
		return PathConstants.SEGROUP_SCHOOL+PathConstants.SCHOOL_BOOK_ADMIN_BOOK_APPLY;
	}


	/**
	 * @Method Name : admin_setting
	 * @Date : 2017. 7. 25.
	 * @User : 선희경
	 * @Param : null
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 : 관리자 - 환경 설정 - 페이지 접속 메소드
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_ADMIN_MANAGE_SETTING, method = RequestMethod.GET)
	public String admin_setting(Locale locale, Model model) {
		logger.debug(">> 환경 설정", locale);

		return PathConstants.SEGROUP_SCHOOL+PathConstants.SCHOOL_BOOK_ADMIN_MANAGE_SETTING;
	}

	/**
	 * @Method Name : admin_subadmin
	 * @Date : 2017. 7. 25.
	 * @User : 선희경
	 * @Param : null
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 : 관리자 - 부계정 관리 - 페이지 접속 메소드
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_ADMIN_MANAGE_SUBADMIN, method = RequestMethod.GET)
	public String admin_subadmin(Locale locale, Model model) {
		logger.debug(">> 부계정 관리", locale);

		return PathConstants.SEGROUP_SCHOOL+PathConstants.SCHOOL_BOOK_ADMIN_MANAGE_SUBADMIN;
	}
	
	/**
	 * @Method Name : adminRegistBookInfo
	 * @Date : 2017. 7. 27.
	 * @User : 서민수	
	 * @Param : null
	 * @Return : 도서 등록 페이지
	 * @Method 설명 : 도서 정보 추가 jsp로 이동
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_ADMIN_REGIST_BOOKINFO, method = RequestMethod.GET)
	public String adminRegistBookInfoView(Locale locale, Model model) {
		logger.debug(">> 도서 정보 추가 View", locale);

		return PathConstants.SEGROUP_SCHOOL+PathConstants.SCHOOL_BOOK_ADMIN_REGIST_BOOKINFO;
	}
	
	/**
	 * @Method Name : adminRegistBookInfo
	 * @Date : 2017. 7. 28.
	 * @User : 서민수	
	 * @Param : null
	 * @Return : 도서 등록 페이지
	 * @Method 설명 : 도서 정보 등록
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_ADMIN_REGIST_BOOKINFO, method = RequestMethod.POST)
	public String adminRegistBookInfo(Locale locale, BookInfo bookInfo, MultipartFile bookInfoimg) {
		logger.debug(">> 도서 정보 추가", locale);
		
		String id = "seominsu";//세션에서 아이디 가져와야됨
		String nm = "서민수"; // 세션에서 가져오기
		bookInfo.setBookinfo_ins_id(id);
		bookInfo.setBookinfo_udt_id(id);
		sbaService.registBookInfo(bookInfo, bookInfoimg, nm);
		
		return PathConstants.SEGROUP_SCHOOL+PathConstants.SCHOOL_BOOK_ADMIN_REGIST_BOOKINFO;
	}
	
	/**
	 * @Method Name : adminRegistBookInfo
	 * @Date : 2017. 7. 27.
	 * @User : 서민수	
	 * @Param : null
	 * @Return : 도서 등록 페이지
	 * @Method 설명 : 도서 정보 추가 jsp로 이동
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_ADMIN_REGIST_BOOK, method = RequestMethod.GET)
	public String adminRegistBookView(Locale locale, Model model) {
		logger.debug(">> 도서 추가 View", locale);

		return PathConstants.SEGROUP_SCHOOL+PathConstants.SCHOOL_BOOK_ADMIN_REGIST_BOOK;
	}
	
	/**
	 * @Method Name : adminRegistBook
	 * @Date : 2017. 7. 27.
	 * @User : 서민수	
	 * @Param : null
	 * @Return : 도서 등록 페이지
	 * @Method 설명 : 도서 정보 추가 jsp로 이동
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_ADMIN_REGIST_BOOK, method = RequestMethod.POST)
	public String adminRegistBook(Locale locale, String isbn, Integer bookCnt, String [] bookLabels) {
		logger.debug(">> 도서 추가", locale);
		System.out.println("isbn : " + isbn);
		String id = "seominsu";//세션에서 아이디 가져와야됨
		sbaService.registBook(isbn, bookCnt, bookLabels,id, id);
		
		return PathConstants.SEGROUP_SCHOOL+PathConstants.SCHOOL_BOOK_ADMIN_REGIST_BOOK;
	}
	
	
	/**
	 * @Method Name : adminRegistBookInfo
	 * @Date : 2017. 7. 31.
	 * @User : 선희경	
	 * @Param : null
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 : 도서 반납 처리 페이지
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_ADMIN_BOOK_RETURN, method = RequestMethod.GET)
	public String book_return(Locale locale, Model model, String rtn_seq) {
		logger.debug(">> 도서 반납 처리", locale);

		RentalState rtnBookInfo = sbaService.rtnBookInfo(rtn_seq);
		model.addAttribute("rtnBookInfo", rtnBookInfo);
		System.out.println(rtnBookInfo.toString());
		
		return PathConstants.SEGROUP_SCHOOL+PathConstants.SCHOOL_BOOK_ADMIN_BOOK_RETURN;
	}
}
