package global.segroup.school.book.admin.dao;


import java.util.ArrayList;
import java.util.Map;

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

/**
 * @Author : 선희경
 * @Date : 2017. 7. 24.
 * @Class 설명 : Soft Engineer School 도서관리 관리자 매퍼
 * 
 */
public interface SchoolBookAdminMapper {
	/**
	 * @Method Name : selectUser
	 * @Date : 2017. 7. 17.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : 회원 정보 객체
	 * @Method 설명 : DAO로 부터 전달 받은 회원 아이디로 매핑된 sql 구문을 실행하여 회원 정보 객체를 리턴한다.
	 */
	public SchoolBookAdmin selectUser(String id);
	
	/**
	 * @Method Name : overdueList
	 * @Date : 2017. 7. 26.
	 * @User : 선희경
	 * @Param : null
	 * @Return : 대여 상태 리스트
	 * @Method 설명 : 대여 요청에 대한 상태 (공통 코드) 기준으로 연체 내역을 리스트로 리턴한다
	 */
	public ArrayList<RentalState> overdueList();
	
	/**
	 * @Method Name : returnList
	 * @Date : 2017. 7. 26.
	 * @User : 선희경
	 * @Param : null
	 * @Return : 대여 상태 리스트
	 * @Method 설명 : 현재 날짜 기준으로 반납 예정일이 당일이나 하루 전인 내역을 리스트로 리턴한다
	 */
	public ArrayList<RentalState> returnList();
	
	/**
	 * @Method Name : getStudentInfo
	 * @Date : 2017. 7. 27.
	 * @User : 선희경
	 * @Param : std_id 학생 아이디
	 * @Return : 해당 학생 회원 정보
	 * @Method 설명 : 
	 */
	public SchoolBookUser getStudentInfo(String user_id);
	
	/**
	 * @Method Name : myList
	 * @Date : 2017. 7. 27.
	 * @User : 선희경
	 * @Param : std_id 학생 아이디
	 * @Return : 해당 학생 대여 정보
	 * @Method 설명 : 
	 */
	public ArrayList<RentalState> myList(String user_id);
	
	/**
	 * @Method Name : reservList
	 * @Date : 2017. 7. 27.
	 * @User : 선희경
	 * @Param : 없음
	 * @Return : 예약 정보
	 * @Method 설명 :
	 */
	public ArrayList<Reservation> reservList();
	
	public int insertBoardContent(BoardContent boardContent);
	public int insertBoardFile(BoardFile boardFile);
	public int insertBookInfo(BookInfo bookInfo);
	public BookInfo searchBookByIsbn(String isbn);
	public int insertBook(Book book);
	public BookInfo getQuantityOfBookInfo(String isbn);
	
	public int updateQuantityOfBookInfo(String isbn, int quantity, String udtId);
	
	/**
	 * @Method Name : stdList
	 * @Date : 2017. 7. 28.
	 * @User : 선희경
	 * @Param : 없음
	 * @Return : 회원 리스트
	 * @Method 설명 :
	 */
	public ArrayList<SchoolBookUser> stdList(Map<String, String> param);
	
	/**
	 * @Method Name : myRecordReturn
	 * @Date : 2017. 7. 28.
	 * @User : 선희경
	 * @Param : user_id 학생 아이디
	 * @Return : 해당 학생 지난 대여 정보 - 반납상태
	 * @Method 설명 :
	 */
	public ArrayList<RecordReturn> myRecordReturn(String user_id);
	
	/**
	 * @Method Name : myRecordOverdue
	 * @Date : 2017. 7. 28.
	 * @User : 선희경
	 * @Param : user_id 학생 아이디
	 * @Return : 해당 학생 지난 대여 정보 - 대여상태
	 * @Method 설명 :
	 */
	public ArrayList<String> myRecordOverdue(String user_id);

	/**
	 * @Method Name : rtnBookInfo
	 * @Date : 2017. 7. 31.
	 * @User : 선희경
	 * @Param : rtn_seq 반납할 대여 정보 시퀀스 아이디
	 * @Return : 반납할 대여 정보 - 대여상태
	 * @Method 설명 :
	 */
	public RentalState rtnBookInfo(String rtn_seq);

	/**
	 * @Method Name : rtnBookProc
	 * @Date : 2017. 7. 31.
	 * @User : 선희경
	 * @Param : null
	 * @Return : true/false
	 * @Method 설명 : 관리자 - 반납처리 - 메소드
	 */
	public boolean rtnBookProc(String rtn_seq, String rtn_code, String admin);

	/**
	 * @Method Name : applyList
	 * @Date : 2017. 8. 1.
	 * @User : 선희경
	 * @Param : null
	 * @Return : 신청 리스트
	 * @Method 설명 : 
	 */
	public ArrayList<PurchaseReqRank> applyList();

	/**
	 * @Method Name : getApplyInfo
	 * @Date : 2017. 8. 1 
	 * @User : 선희경
	 * @Param : isbn
	 * @Return : 신청 도서의 신청자들 정보
	 * @Method 설명 : 관리자 - 신청도서 상세 - 메소드
	 */
	public ArrayList<PurchaseReq> getApplyInfo(String isbn);

	/**
	 * @Method Name : rentalList
	 * @Date : 2017. 8. 2.
	 * @User : 선희경
	 * @Param : null
	 * @Return : 도서 대여 신청 리스트
	 * @Method 설명 : 
	 */
	public ArrayList<RentalState> rentalList();

	/**
	 * @Method Name : bookList
	 * @Date : 2017. 8. 2.
	 * @User : 선희경
	 * @Param : null
	 * @Return : 책 정보 리스트
	 * @Method 설명 : 
	 */
	public ArrayList<BookInfo> bookList();

	/**
	 * @Method Name : getBookInfo
	 * @Date : 2017. 8. 2 
	 * @User : 선희경
	 * @Param : isbn
	 * @Return : 도서 정보
	 * @Method 설명 : 관리자 - 도서 정보 - 메소드
	 */
	public BookInfo getBookInfo(String isbn);

	/**
	 * @Method Name : getDetailList
	 * @Date : 2017. 8. 2.
	 * @User : 선희경
	 * @Param : isbn
	 * @Return : 도서정보에 해당하는 각각의 도서 정보 리스트
	 * @Method 설명 :
	 */
	public ArrayList<Book> getDetailList(String isbn);

	/**
	 * @Method Name : rentalApproval
	 * @Date : 2017. 8. 2 
	 * @User : 선희경
	 * @Param : answer(수락/거절), rental_req
	 * @Return : 도서 정보
	 * @Method 설명 : 관리자 - 도서 대여처리 - 메소드
	 */
	public boolean rentalApproval(Map<String, String> param);
	
	public ArrayList<BookInfo> getBookInfoList();

	/**
	 * @Method Name : statusList
	 * @Date : 2017. 8. 2.
	 * @User : 선희경
	 * @Param : 정렬기준
	 * @Return : 현재 대여중인 도서 현황
	 * @Method 설명 : 
	 */
	public ArrayList<RentalState> statusList(Map<String, String> param);
	
}
