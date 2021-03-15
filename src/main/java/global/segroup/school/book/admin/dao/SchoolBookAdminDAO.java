package global.segroup.school.book.admin.dao;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.segroup.domain.BoardContent;
import global.segroup.domain.BoardFile;
import global.segroup.school.book.admin.domain.Book;
import global.segroup.school.book.admin.domain.BookInfo;
import global.segroup.school.book.admin.domain.RecordReturn;
import global.segroup.school.book.admin.domain.SchoolBookAdmin;
import global.segroup.school.book.domain.PurchaseReq;
import global.segroup.school.book.domain.PurchaseReqRank;
import global.segroup.school.book.domain.RentalState;
import global.segroup.school.book.user.domain.Reservation;
import global.segroup.school.book.user.domain.SchoolBookUser;
import global.segroup.school.book.util.BookBoardGroupCode;

/**
 * @Author : 선희경
 * @Date : 2017. 7. 24.
 * @Class 설명 : Soft Engineer School 도서관리 관리자 DAO
 * 
 */
@Repository
public class SchoolBookAdminDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(SchoolBookAdminDAO.class);
	
	@Autowired
	SqlSession sqlSession;
	
	/**
	 * @Method Name : selectUser
	 * @Date : 2017. 7. 17.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : 회원 정보 객체
	 * @Method 설명 : 서비스로 부터 전달 받은 회원 아이디를 회원 검색 매퍼에 전달하고,
	 *                          매퍼로 부터 전달 받은 회원 정복 객체를 서비스에 전달해준다.
	 */
	public SchoolBookAdmin selectUser(String id){
		logger.debug("도서관리 관리자 검색 DAO 시작");
		
		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		SchoolBookAdmin sba = mapper.selectUser(id);
		
		logger.debug("도서관리 관리자 검색 DAO 종료");
		
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
	public ArrayList<RentalState> overdueList(){
		logger.debug("도서관리 관리자 연체리스트 DAO 시작");
		
		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		ArrayList<RentalState> result = mapper.overdueList();

		logger.debug("도서관리 관리자 연체리스트 DAO 종료");
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
	public ArrayList<RentalState> returnList(){
		logger.debug("도서관리 관리자 반납예정리스트 DAO 시작");

		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		ArrayList<RentalState> result = mapper.returnList();
		
		logger.debug("도서관리 관리자 반납예정리스트 DAO 종료");
		return result; 
	}
	
	/**
	 * @Method Name : getStudentInfo
	 * @Date : 2017. 7. 27.
	 * @User : 선희경
	 * @Param : user_id 학생 아이디
	 * @Return : 해당 학생 회원 정보
	 * @Method 설명 :
	 */
	public SchoolBookUser getStudentInfo(String user_id) {
		logger.debug("도서관리 관리자 회원 정보 출력 DAO 시작");

		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		SchoolBookUser result = mapper.getStudentInfo(user_id);

		logger.debug("도서관리 관리자 회원 정보 출력 DAO 종료");
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
		logger.debug("도서관리 관리자 회원 대여정보 출력 DAO 시작");

		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		ArrayList<RentalState> result = mapper.myList(user_id);
		
		logger.debug("도서관리 관리자 회원 대여정보 출력 DAO 종료");
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
		logger.debug("도서관리 관리자 회원 예약정보 출력 DAO 시작");

		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		ArrayList<Reservation> result = mapper.reservList();

		logger.debug("도서관리 관리자 회원 예약정보 출력 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : reservList
	 * @Date : 2017. 7. 27.
	 * @User : t
	 * @Param : 없음
	 * @Return : 예약 정보
	 * @Method 설명 :
	 */
	public void registBookInfo(BookInfo bookInfo, String admin) {
		logger.debug("도서 정보 등록 DAO 시작");

		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);

		//BOARD_CONTENT_SEQ 에 먼저 넣기
		BoardContent bc = new BoardContent();	
		bc.setBoard_seq(BookBoardGroupCode.BOOK_BOOKINFO);
		bc.setBoard_content_nm(admin);
		bc.setBoard_content_title("도서 정보 등록");
		bc.setBoard_content_ct(bookInfo.getBookinfo_book_nm());
		bc.setBoard_content_ins_id(bookInfo.getBookinfo_ins_id());
		bc.setBoard_content_udt_id(bookInfo.getBookinfo_udt_id());
		
		mapper.insertBoardContent(bc);
		
		//BOARD_FILE_SEQ 에 넣기
		BoardFile bf = new BoardFile();
		bf.setBoard_content_seq(bc.getBoard_content_seq());
		bf.setBoard_file_origin(bookInfo.getBoard_file_origin());
		bf.setBoard_file_saved(bookInfo.getBoard_file_saved());
		bf.setBoard_ins_id(bookInfo.getBookinfo_ins_id());
		bf.setBoard_udt_id(bookInfo.getBookinfo_udt_id());
		
		mapper.insertBoardFile(bf);
		
		//BOOK_BOOKINFO_TB 에 넣기
		bookInfo.setBoard_content_seq(bc.getBoard_content_seq());
		bookInfo.setBoard_file_seq(bf.getBoard_file_seq());
		
		mapper.insertBookInfo(bookInfo);
		
		logger.debug("도서 정보 등록 DAO 종료");
	}
	
	
	public BookInfo searchBookByIsbn(String isbn) {
		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);

		return mapper.searchBookByIsbn(isbn);
	}
	
	public void registBook(Book book, String admin){
		logger.debug("도서 추가 DAO 시작");

		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		//BOARD_CONTENT_SEQ 에 먼저 넣기
		BoardContent bc = new BoardContent();	
		bc.setBoard_seq(BookBoardGroupCode.BOOK_BOOK);
		bc.setBoard_content_nm(admin);
		bc.setBoard_content_title("도서 추가");
		bc.setBoard_content_ct( book.getBookinfo_isbn()+ " : " +book.getBook_label() );
		bc.setBoard_content_ins_id(book.getBook_ins_id());
		bc.setBoard_content_udt_id(book.getBook_udt_id());
		
		mapper.insertBoardContent(bc);
		
		//BOOK_BOOK_TB 에 넣기
		book.setBoard_content_seq(bc.getBoard_content_seq());
		
		mapper.insertBook(book);
		
		//BOOK_BOOKINFO_TB 업데이트
		BookInfo bi = mapper.getQuantityOfBookInfo(book.getBookinfo_isbn());
		mapper.updateQuantityOfBookInfo(book.getBookinfo_isbn(), bi.getBookinfo_quantity()+1, book.getBook_udt_id());
		
		logger.debug("도서 추가 DAO 종료");
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
		logger.debug("도서관리 관리자 : 회원 리스트 출력 DAO 시작");
		Map<String, String> param = new HashMap();
		param.put("gisu", gisu);
		param.put("name", name);
		
		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		ArrayList<SchoolBookUser> result = mapper.stdList(param);
		System.out.println("요기야 요기!! " + result.toString());
		
		logger.debug("도서관리 관리자 : 회원 리스트 출력 DAO 종료");
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
		logger.debug("도서관리 관리자 : 회원 누적 대여정보 - 반납상태 출력 DAO 시작");

		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		ArrayList<RecordReturn> result = mapper.myRecordReturn(user_id);
		System.out.println(">@>" + result);
		
		logger.debug("도서관리 관리자 : 회원 누적 대여정보- 반납상태 출력 DAO 종료");
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
		logger.debug("도서관리 관리자 : 회원 누적 대여정보 - 대여상태 출력 DAO 시작");

		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		ArrayList<String> result = mapper.myRecordOverdue(user_id);
		
		logger.debug("도서관리 관리자 : 회원 누적 대여정보- 대여상태 출력 DAO 종료");
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
		logger.debug("도서관리 관리자 : 반납할 대여정보 출력 DAO 시작");

		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		RentalState result = mapper.rtnBookInfo(rtn_seq);
		
		logger.debug("도서관리 관리자 : 반납할 대여정보 출력 DAO 종료");
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

		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		boolean result = mapper.rtnBookProc(rtn_seq, rtn_code, admin);

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
		logger.debug("도서관리 관리자 : 도서신청 출력 시작");

		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		ArrayList<PurchaseReqRank> result = mapper.applyList();
		
		logger.debug("도서관리 관리자 : 도서신청 출력 종료");
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
		logger.debug("도서관리 관리자 : 도서신청 - 상세 출력 시작");

		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		ArrayList<PurchaseReq> result = mapper.getApplyInfo(isbn);
		
		logger.debug("도서관리 관리자 : 도서신청 - 상세 출력 종료");
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

		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		ArrayList<RentalState> result = mapper.rentalList();
		System.out.println(">  " + result.toString());
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

		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		ArrayList<BookInfo> result = mapper.bookList();
		System.out.println(">  " + result.toString());
		
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

		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		BookInfo result = mapper.getBookInfo(isbn);
		
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

		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		ArrayList<Book> result = mapper.getDetailList(isbn);
		
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

		Map<String, String> param = new HashMap();
		if(answer.equals("ok"))
			param.put("state", "B0302");
		else if(answer.equals("no"))
			param.put("state", "B0303");
		
		param.put("rental_seq", rental_seq);
		
		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		boolean done = mapper.rentalApproval(param);
		ArrayList<RentalState> rentalList =  mapper.rentalList();
		
		Map<String, Object> result = new HashMap();
		result.put("done", done);
		result.put("rentalList", rentalList);
		
		
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

		Map<String, String> param = new HashMap<>();
		param.put("sort", sort);
		
		SchoolBookAdminMapper mapper = sqlSession.getMapper(SchoolBookAdminMapper.class);
		ArrayList<RentalState> result = mapper.statusList(param);
		
		logger.debug("도서관리 관리자 : 도서 대여현황 출력 종료");
		return result;
	}
}
