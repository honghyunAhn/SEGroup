package global.segroup.school.book.admin.service;

import java.util.ArrayList;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import global.segroup.school.book.admin.dao.SchoolBookAdminDAO;
import global.segroup.school.book.admin.domain.Book;
import global.segroup.school.book.admin.domain.BookInfo;
import global.segroup.school.book.admin.domain.RecordReturn;
import global.segroup.school.book.admin.domain.SchoolBookAdmin;
import global.segroup.school.book.domain.PurchaseReq;
import global.segroup.school.book.domain.PurchaseReqRank;
import global.segroup.school.book.domain.RentalState;
import global.segroup.school.book.user.domain.Reservation;
import global.segroup.school.book.user.domain.SchoolBookUser;
import global.segroup.util.FileService;

/**
 * @Author : 선희경
 * @Date : 2017. 7. 24.
 * @Class 설명 : Soft Engineer School 도서관리 관리자 서비스
 * 
 */
@Service
public class SchoolBookAdminService {

	private static final Logger logger = LoggerFactory.getLogger(SchoolBookAdminService.class);

	@Autowired
	private SchoolBookAdminDAO sbaDao;

	@Value("#{props['edu.book.board_photo']}")
	private String bookInfoImgPath;
	
	/**
	 * @Method Name : selectUser
	 * @Date : 2017. 7. 17.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : 회원 정보 객체
	 * @Method 설명 : 컨트롤러로 부터 전달 받은 회원 아이디를 회원 검색 DAO에 전달해주고, DAO로 부터 전달 받은 회원 정보
	 *         객체를 컨트롤러에게 전달해준다.
	 */
	public SchoolBookAdmin selectUser(String id) {
		logger.debug("도서관리 관리자 : 검색 서비스 시작");

		SchoolBookAdmin sba = sbaDao.selectUser(id);

		logger.debug("도서관리 관리자 : 검색 서비스 종료");
		return sba;
	}

	/**
	 * @Method Name : overdueList
	 * @Date : 2017. 7. 26.
	 * @User : 선희경
	 * @Param : null
	 * @Return : 대여 상태 리스트
	 * @Method 설명 : 대여 요청에 대한 상태 (공통 코드) 기준으로 연체 내역을 리스트로 리턴한다
	 */
	public ArrayList<RentalState> overdueList() {
		logger.debug("도서관리 관리자 : 연체자 리스트 시작");

		ArrayList<RentalState> result = sbaDao.overdueList();

		logger.debug("도서관리 관리자 : 연체자 리스트 종료");
		return result;
	}

	/**
	 * @Method Name : returnList
	 * @Date : 2017. 7. 26.
	 * @User : 선희경
	 * @Param : null
	 * @Return : 대여 상태 리스트
	 * @Method 설명 : 현재 날짜 기준으로 반납 예정일이 당일이나 하루 전인 내역을 리스트로 리턴한다
	 */
	public ArrayList<RentalState> returnList() {
		logger.debug("도서관리 관리자 : 반납예정 리스트 시작");

		ArrayList<RentalState> result = sbaDao.returnList();

		logger.debug("도서관리 관리자 : 반납예정 리스트 종료");
		return result;
	}

	/**
	 * @Method Name : getStudentInfo
	 * @Date : 2017. 7. 27.
	 * @User : 선희경
	 * @Param : std_id 학생 아이디
	 * @Return : 해당 학생 회원 정보
	 * @Method 설명 :
	 */
	public SchoolBookUser getStudentInfo(String user_id) {
		logger.debug("도서관리 관리자 : 회원 정보 출력 시작");

		SchoolBookUser result = sbaDao.getStudentInfo(user_id);

		logger.debug("도서관리 관리자 : 회원 정보 출력 종료");
		return result;
	}

	/**
	 * @Method Name : myList
	 * @Date : 2017. 7. 27.
	 * @User : 선희경
	 * @Param : std_id 학생 아이디
	 * @Return : 해당 학생 대여 정보
	 * @Method 설명 :
	 */
	public ArrayList<RentalState> myList(String user_id) {
		logger.debug("도서관리 관리자 : 회원 대여정보 출력 시작");

		ArrayList<RentalState> result = sbaDao.myList(user_id);

		logger.debug("도서관리 관리자 : 회원 대여정보 출력 종료");
		return result;
	}

	/**
	 * @Method Name : reservList
	 * @Date : 2017. 7. 27.
	 * @User : 선희경
	 * @Param : 없음
	 * @Return : 예약 정보
	 * @Method 설명 :
	 */
	public ArrayList<Reservation> reservList() {
		logger.debug("도서관리 관리자 : 회원 예약정보 출력 시작");

		ArrayList<Reservation> result = sbaDao.reservList();

		logger.debug("도서관리 관리자 : 회원 예약정보 출력 종료");
		return result;
	}
	/**
	 * @Method Name : registBookInfo
	 * @Date : 2017. 8. 01.
	 * @User : 서민수
	 * @Param : 없음
	 * @Return : 예약 정보
	 * @Method 설명 :
	 */
	public void registBookInfo( BookInfo bookInfo, MultipartFile bookInfoimg, String admin){
		

		String savedPath = FileService.saveFile(bookInfoimg, bookInfoImgPath);
		String originFname = bookInfoimg.getOriginalFilename();
		
		bookInfo.setBoard_file_origin(originFname);
		bookInfo.setBoard_file_saved(savedPath);
		
		sbaDao.registBookInfo(bookInfo, admin);

	}
	
	/**
	 * @Method Name : registBookInfo
	 * @Date : 2017. 8. 01.
	 * @User : 서민수
	 * @Param : 없음
	 * @Return : 예약 정보
	 * @Method 설명 :
	 */
	public BookInfo searchBookByIsbnOnSESBook(String isbn){
		return sbaDao.searchBookByIsbn(isbn);
	}
	
	public void registBook(String isbn, Integer bookCnt, String [] bookLabels, String id, String admin){
		for(int i = 0; i < bookLabels.length; i++){
			Book newBook = new Book();
			
			newBook.setBookinfo_isbn(isbn);
			newBook.setBook_label(bookLabels[i]);
			newBook.setBook_udt_id(id);
			newBook.setBook_ins_id(id);
			sbaDao.registBook(newBook, admin);
		}
	}
	

	/**
	 * @Method Name : stdList
	 * @Date : 2017. 7. 28.
	 * @User : 선희경
	 * @Param : 없음
	 * @Return : 회원 리스트
	 * @Method 설명 :
	 */
	public ArrayList<SchoolBookUser> stdList(String gisu, String name) {
		logger.debug("도서관리 관리자 : 회원 리스트 출력 시작");

		ArrayList<SchoolBookUser> result = sbaDao.stdList(gisu, name);

		logger.debug("도서관리 관리자 : 회원 리스트 출력 종료");
		return result;
	}

	/**
	 * @Method Name : myRecordReturn
	 * @Date : 2017. 7. 28.
	 * @User : 선희경
	 * @Param : user_id 학생 아이디
	 * @Return : 해당 학생 지난 대여 정보
	 * @Method 설명 :
	 */
	public ArrayList<RecordReturn> myRecordReturn(String user_id) {
		logger.debug("도서관리 관리자 : 회원 누적 대여정보 - 반납상태 출력 시작");

		ArrayList<RecordReturn> result = sbaDao.myRecordReturn(user_id);
		System.out.println(">@>" + result);

		logger.debug("도서관리 관리자 : 회원 누적 대여정보 - 반납상태 출력 종료");
		return result;
	}

	/**
	 * @Method Name : myRecordOverdue
	 * @Date : 2017. 7. 28.
	 * @User : 선희경
	 * @Param : user_id 학생 아이디
	 * @Return : 해당 학생 지난 대여 정보 - 대여상태
	 * @Method 설명 :
	 */
	public ArrayList<String> myRecordOverdue(String user_id) {
		logger.debug("도서관리 관리자 : 회원 누적 대여정보 - 대여상태 출력 시작");

		ArrayList<String> result = sbaDao.myRecordOverdue(user_id);

		logger.debug("도서관리 관리자 : 회원 누적 대여정보 - 대여상태 출력 종료");
		return result;
	}

	/**
	 * @Method Name : rtnBookInfo
	 * @Date : 2017. 7. 31.
	 * @User : 선희경
	 * @Param : rtn_seq 반납할 대여 정보 시퀀스 아이디
	 * @Return : 반납할 대여 정보 - 대여상태
	 * @Method 설명 :
	 */
	public RentalState rtnBookInfo(String rtn_seq) {
		logger.debug("도서관리 관리자 : 반납할 대여정보 출력 시작");

		RentalState result = sbaDao.rtnBookInfo(rtn_seq);

		logger.debug("도서관리 관리자 : 반납할 대여정보 출력 종료");
		return result;
	}

	/**
	 * @Method Name : rtnBookProc
	 * @Date : 2017. 7. 31.
	 * @User : 선희경
	 * @Param : null
	 * @Return : true/false
	 * @Method 설명 : 관리자 - 반납처리 - 메소드
	 */
	public boolean rtnBookProc(String rtn_seq, String rtn_code, String admin) {
		logger.debug("도서관리 관리자 : 반납처리 출력 시작");

		boolean result = sbaDao.rtnBookProc(rtn_seq, rtn_code, admin);

		logger.debug("도서관리 관리자 : 반납처리 출력 종료");
		return result;
	}

	/**
	 * @Method Name : applyList
	 * @Date : 2017. 8. 1.
	 * @User : 선희경
	 * @Param : null
	 * @Return : 신청 리스트
	 * @Method 설명 :
	 */
	public ArrayList<PurchaseReqRank> applyList() {
		logger.debug("도서관리 관리자 : 도서신청리스트 출력 시작");

		ArrayList<PurchaseReqRank> result = sbaDao.applyList();

		logger.debug("도서관리 관리자 : 도서신청리스트 출력 종료");
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
	public ArrayList<PurchaseReq> getApplyInfo(String isbn) {
		logger.debug("도서관리 관리자 : 도서신청 - 상세 리스트 출력 시작");

		ArrayList<PurchaseReq> result = sbaDao.getApplyInfo(isbn);

		logger.debug("도서관리 관리자 : 도서신청 - 상세 리스트 출력 종료");
		return result;
	}
	

	/**
	 * @Method Name : rentalList
	 * @Date : 2017. 8. 2.
	 * @User : 선희경
	 * @Param : null
	 * @Return : 도서 대여 신청 리스트
	 * @Method 설명 :
	 */
	public ArrayList<RentalState> rentalList() {
		logger.debug("도서관리 관리자 : 도서 대여신청 리스트 출력 시작");

		ArrayList<RentalState> result = sbaDao.rentalList();

		logger.debug("도서관리 관리자 : 도서 대여신청 리스트 출력 종료");
		return result;
	}

	/**
	 * @Method Name : bookList
	 * @Date : 2017. 8. 2.
	 * @User : 선희경
	 * @Param : null
	 * @Return : 책 정보 리스트
	 * @Method 설명 :
	 */
	public ArrayList<BookInfo> bookList() {
		logger.debug("도서관리 관리자 : 도서 관리 리스트 출력 시작");

		ArrayList<BookInfo> result = sbaDao.bookList();

		logger.debug("도서관리 관리자 : 도서 관리 리스트 출력 종료");
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
	public BookInfo getBookInfo(String isbn) {
		logger.debug("도서관리 관리자 : 도서 정보 출력 시작");

		BookInfo result = sbaDao.getBookInfo(isbn);

		logger.debug("도서관리 관리자 : 도서 정보 출력 종료");
		return result;
	}

	/**
	 * @Method Name : getDetailList
	 * @Date : 2017. 8. 2.
	 * @User : 선희경
	 * @Param : isbn
	 * @Return : 도서정보에 해당하는 각각의 도서 정보 리스트
	 * @Method 설명 :
	 */
	public ArrayList<Book> getDetailList(String isbn) {
		logger.debug("도서관리 관리자 : 도서 상세정보 리스트 출력 시작");

		ArrayList<Book> result = sbaDao.getDetailList(isbn);

		logger.debug("도서관리 관리자 : 도서 상세정보 리스트 출력 종료");
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
	public Map<String, Object> rentalApproval(String answer, String rental_seq) {
		logger.debug("도서관리 관리자 : 도서 대여처리 출력 시작");

		Map<String, Object> result = sbaDao.rentalApproval(answer, rental_seq);

		logger.debug("도서관리 관리자 : 도서 대여처리 출력 종료");
		return result;
	}

	/**
	 * @Method Name : statusList
	 * @Date : 2017. 8. 2.
	 * @User : 선희경
	 * @Param : 정렬기준
	 * @Return : 현재 대여중인 도서 현황
	 * @Method 설명 : 
	 */
	public ArrayList<RentalState> statusList(String sort) {
		logger.debug("도서관리 관리자 : 도서 대여현황 출력 시작");

		ArrayList<RentalState> result = sbaDao.statusList(sort);

		logger.debug("도서관리 관리자 : 도서 대여현황 출력 종료");
		return result;
	}
}
