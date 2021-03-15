package global.segroup.school.book.user.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import global.segroup.school.book.domain.PurchaseReq;
import global.segroup.school.book.domain.RentalState;
import global.segroup.school.book.user.domain.BookMark;
import global.segroup.school.book.user.domain.Review;
import global.segroup.school.book.user.domain.SchoolBookUser;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 17.
 * @Class 설명 : Soft Engineer School 도서관리 회원 매퍼
 * 
 */
public interface SchoolBookUserMapper {
	/**
	 * @Method Name : selectUser
	 * @Date : 2017. 7. 17.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : 회원 정보 객체
	 * @Method 설명 : DAO로 부터 전달 받은 회원 아이디로 매핑된 sql 구문을 실행하여 회원 정보 객체를 리턴한다.
	 */
	public SchoolBookUser selectUser(String id);
	
	/**
	 * @Method Name : search_result
	 * @Date : 2017. 8. 02.
	 * @User : 이종호
	 * @Param : 검색 정보 (BookInfo: 제목, 저자, 출판사, ISBN, 분류 / String: 발행일 range , RowBounds : 페이징)
	 * @Return : 책 정보 리스트
	 * @Method 설명 : 세부검색 결과 요청
	 */
	public List<HashMap<String, Object>> search_result(HashMap<String, Object> paramMap, RowBounds rb);
	
	/**
	 * @Method Name : getTotalBook
	 * @Date : 2017. 8. 29.
	 * @User : 이종호
	 * @Param : 검색 정보
	 * @Return : 검색 된 책 개수
	 * @Method 설명 : 책 개수를 리턴하는 매퍼 함수
	 */
	public int getTotalBook(HashMap<String, Object> paramMap);

	/**
	 * @Method Name : insertPurchaseReq
	 * @Date : 2017. 8. 2.
	 * @User : 이정식
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int insertPurchaseReq(PurchaseReq request);
	
	/**
	 * @Method Name : selectReviewList
	 * @Date : 2017. 8. 2.
	 * @User : 이정식
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public ArrayList<Review> selectReviewList(String id);
	
	/**
	 * @Method Name : selectRentalStateList
	 * @Date : 2017. 8. 2.
	 * @User : 이정식
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public ArrayList<RentalState> selectRentalStateList(String id);
	
	/**
	 * @Method Name : selectBookMarkList
	 * @Date : 2017. 8. 2.
	 * @User : 이정식
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public ArrayList<BookMark> selectBookMarkList(String id);

}
