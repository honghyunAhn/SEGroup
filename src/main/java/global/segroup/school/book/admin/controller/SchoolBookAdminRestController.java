package global.segroup.school.book.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.segroup.school.book.admin.domain.Book;
import global.segroup.school.book.admin.domain.BookInfo;
import global.segroup.school.book.admin.domain.RecordReturn;
import global.segroup.school.book.admin.service.SchoolBookAdminService;
import global.segroup.school.book.domain.PurchaseReq;
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
public class SchoolBookAdminRestController implements PathConstants {

	private static final Logger logger = LoggerFactory.getLogger(SchoolBookAdminRestController.class);

	@Autowired
	private SchoolBookAdminService sbaService;

	/**
	 * @Method Name : getstdInfo
	 * @Date : 2017. 7. 27.
	 * @User : 선희경
	 * @Param : null
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 : 관리자 - 회원 정보 출력 메소드
	 */
	@ResponseBody
	@RequestMapping(value = "getStdInfo", method = RequestMethod.GET)
	public HashMap<String, Object> getStdInfo(String this_id) {
		logger.debug(">> 회원 정보 출력");
		System.out.println(this_id);

		SchoolBookUser stdInfo = sbaService.getStudentInfo(this_id);
		ArrayList<RentalState> myList = sbaService.myList(this_id);

		HashMap<String, Object> stdInfoMap = new HashMap<>();
		stdInfoMap.put("std_id", stdInfo.getUser_id());
		stdInfoMap.put("std_nm", stdInfo.getUser_nm());
		stdInfoMap.put("std_gisu", stdInfo.getGisu_num());
		stdInfoMap.put("std_phone", stdInfo.getUser_phone());
		stdInfoMap.put("std_email", stdInfo.getUser_email());
		stdInfoMap.put("std_sex", stdInfo.getUser_sex());
		stdInfoMap.put("std_flag", stdInfo.getUser_flag());

		stdInfoMap.put("myList", myList);
		return stdInfoMap;
	}
	
	/**
	 * @Method Name : getBookInfoByISBNOnSESBook
	 * @Date : 2017. 08. 01.
	 * @User : 서민수	
	 * @Param : null
	 * @Return : 책 검색 결과(BookInfo)
	 * @Method 설명 : ses book DB 에서 isbn 으로 도서 검색
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_ADMIN_SEARCH_BY_ISBN_ON_SESBOOK, method = RequestMethod.GET)
	public BookInfo getBookInfoByISBNOnSESBook(Locale locale, String isbn) {
		logger.debug(">>book_bookinfo_tb에서 isbn 으로 책 검색 ", locale);
		
		BookInfo rst = sbaService.searchBookByIsbnOnSESBook(isbn);
		return rst;
	}



	/**
	 * @Method Name : getStdMngInfo
	 * @Date : 2017. 7. 28.
	 * @User : 선희경
	 * @Param : null
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 : 관리자 - 회원관리 - 정보 출력 메소드
	 */
	@ResponseBody
	@RequestMapping(value = "getStdMngInfo", method = RequestMethod.GET)
	public HashMap<String, Object> getStdMngInfo(String this_id) {
		logger.debug(">> 회원관리 정보 출력");

		ArrayList<RentalState> myList = sbaService.myList(this_id);
		ArrayList<RecordReturn> myRecordReturn = sbaService.myRecordReturn(this_id);
		ArrayList<String> myRecordOverdue = sbaService.myRecordOverdue(this_id);

		HashMap<String, Object> myRecordMap = new HashMap<>();

		int state[] = new int[7];

		for (RecordReturn rr : myRecordReturn) {
			if (rr.getRental_rtn_state().equals("B0000")) {
				myRecordMap.put("state0", rr.getRental_rtn_state_cnt());
				state[0] = 1;
			}
			if (rr.getRental_rtn_state().equals("B0001")) {
				myRecordMap.put("state1", rr.getRental_rtn_state_cnt());
				state[1] = 1;
			}
			if (rr.getRental_rtn_state().equals("B0002")) {
				myRecordMap.put("state2", rr.getRental_rtn_state_cnt());
				state[2] = 1;
			}
			if (rr.getRental_rtn_state().equals("B0003")) {
				myRecordMap.put("state3", rr.getRental_rtn_state_cnt());
				state[3] = 1;
			}
			if (rr.getRental_rtn_state().equals("B0004")) {
				myRecordMap.put("state4", rr.getRental_rtn_state_cnt());
				state[4] = 1;
			}
			if (rr.getRental_rtn_state().equals("B0005")) {
				myRecordMap.put("state5", rr.getRental_rtn_state_cnt());
				state[5] = 1;
			}
			if (rr.getRental_rtn_state().equals("B0006")) {
				myRecordMap.put("state6", rr.getRental_rtn_state_cnt());
				state[6] = 1;
			}
		}

		for (int i = 0; i < state.length; i++) {
			if (state[i] == 0) {
				String key = "state" + i;
				myRecordMap.put(key, 0);
			}
		}

		int total = 0;
		int overdue = 0;
		for (String ovd : myRecordOverdue) {
			total++;
			if (ovd.equals("B0304"))
				overdue++;
		}

		myRecordMap.put("stu_nm", sbaService.getStudentInfo(this_id).getUser_nm());
		myRecordMap.put("myList", myList);
		myRecordMap.put("total", total);
		myRecordMap.put("overdue", overdue);

		return myRecordMap;
	}

	/**
	 * @Method Name : rtnBookProc
	 * @Date : 2017. 7. 31.
	 * @User : 선희경
	 * @Param : null
	 * @Return : true/false
	 * @Method 설명 : 관리자 - 반납처리 - 메소드
	 */
	@ResponseBody
	@RequestMapping(value = "/book/admin/rtnBookProc", method = RequestMethod.POST)
	public boolean rtnBookProc(String rtn_seq, String rtn_code) {
		logger.debug(">> 반납처리 출력");

		String admin = "seominsu";
		boolean result = sbaService.rtnBookProc(rtn_seq, rtn_code, admin);

		return result;
	}
	
	/**
	 * @Method Name : getApplyInfo
	 * @Date : 2017. 8. 1 
	 * @User : 선희경
	 * @Param : isbn
	 * @Return : 신청 도서의 신청자들 정보
	 * @Method 설명 : 관리자 - 신청도서 상세 - 메소드
	 */
	@ResponseBody
	@RequestMapping(value = "getApplyInfo", method = RequestMethod.GET)
	public ArrayList<PurchaseReq> getApplyInfo(String isbn) {
		logger.debug(">> 신청도서 상세 출력");

		ArrayList<PurchaseReq> result = sbaService.getApplyInfo(isbn);

		return result;
	}
	
	/**
	 * @Method Name : stdList
	 * @Date : 2017. 8. 1 
	 * @User : 선희경
	 * @Param : 기수, 이름
	 * @Return : 학생 검색결과
	 * @Method 설명 : 관리자 - 학생 검색결과 - 메소드
	 */
	@ResponseBody
	@RequestMapping(value = "stdList", method = RequestMethod.GET)
	public ArrayList<SchoolBookUser> stdList(String gisu, String name) {
		logger.debug(">> 학생 검색결과 출력");

		ArrayList<SchoolBookUser> result = sbaService.stdList(gisu, name);
		System.out.println("성길상의 포인트 : " + result.toString());

		return result;
	}
	
	/**
	 * @Method Name : getBookInfo
	 * @Date : 2017. 8. 2 
	 * @User : 선희경
	 * @Param : isbn
	 * @Return : 도서 정보
	 * @Method 설명 : 관리자 - 도서 정보 - 메소드
	 */
	@ResponseBody
	@RequestMapping(value = "bookManage", method = RequestMethod.GET)
	public HashMap<String, Object> bookManage(String isbn) {
		logger.debug(">> 도서 정보 출력");

		HashMap<String, Object> result = new HashMap<>();
		BookInfo bookInfo = sbaService.getBookInfo(isbn);
		ArrayList<Book> detailList = sbaService.getDetailList(isbn);
		
		result.put("bookInfo", bookInfo);
		result.put("detailList", detailList);
		
		return result;
	}
	

	/**
	 * @Method Name : rentalApproval
	 * @Date : 2017. 8. 2 
	 * @User : 선희경
	 * @Param : answer(수락/거절), rental_req
	 * @Return : 도서 정보
	 * @Method 설명 : 관리자 - 도서 대여처리 - 메소드
	 */
	@ResponseBody
	@RequestMapping(value = "rentalApproval", method = RequestMethod.GET)
	public Map<String, Object> rentalApproval(String answer, String rental_seq) {
		logger.debug(">> 도서 대여처리 출력");

		Map<String, Object> result = sbaService.rentalApproval(answer, rental_seq);
		
		return result;
	}
	

	/**
	 * @Method Name : statusList
	 * @Date : 2017. 8. 2 
	 * @User : 선희경
	 * @Param : sort 정렬기준
	 * @Return : 현재 대여 현황
	 * @Method 설명 : 관리자 - 도서 대여현황 - 메소드
	 */
	@ResponseBody
	@RequestMapping(value = "statusList", method = RequestMethod.GET)
	public ArrayList<RentalState> statusList(String sort) {
		logger.debug(">> 도서 대여현황 출력");

		ArrayList<RentalState> result = sbaService.statusList(sort);
		
		return result;
	}
}
