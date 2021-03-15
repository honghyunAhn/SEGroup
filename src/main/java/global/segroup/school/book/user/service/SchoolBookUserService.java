package global.segroup.school.book.user.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import global.segroup.school.book.domain.PurchaseReq;
import global.segroup.school.book.domain.RentalState;
import global.segroup.school.book.user.dao.SchoolBookUserDAO;
import global.segroup.school.book.user.domain.BookMark;
import global.segroup.school.book.user.domain.Review;
import global.segroup.school.book.user.domain.SchoolBookUser;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 17.
 * @Class 설명 : Soft Engineer School 도서관리 회원 서비스
 * 
 */
@Service
public class SchoolBookUserService{
	
	private static final Logger logger = LoggerFactory.getLogger(SchoolBookUserService.class);
	
	@Autowired
	private SchoolBookUserDAO sbuDao;
	
	/**
	 * @Method Name : selectUser
	 * @Date : 2017. 7. 17.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : 회원 정보 객체
	 * @Method 설명 : 컨트롤러로 부터 전달 받은 회원 아이디를 회원 검색 DAO에 전달해주고,
	 *                          DAO로 부터 전달 받은 회원 정보 객체를 컨트롤러에게 전달해준다.
	 */
	public SchoolBookUser selectUser(String id){
		logger.debug("도서관리 회원 검색 서비스 시작");
		
		SchoolBookUser sbu = sbuDao.selectUser(id);
		
		logger.debug("도서관리 회원 검색 서비스 종료");
		return sbu; 
	}
	
	/**
	 * @Method Name : search_result
	 * @Date : 2017. 8. 29.
	 * @User : 이종호
	 * @Param : 검색 정보 (BookInfo: 제목, 저자, 출판사, ISBN, 분류 / String: 발행일 range, RowBounds : 페이징)
	 * @Return : 책 정보 리스트
	 * @Method 설명 : 세부검색 결과 요청
	 */
	public List<HashMap<String, Object>> search_result(HashMap<String, Object> paramMap, int startRecord, int countPerPage){
		logger.debug("유저 세부검색 결과 요청 서비스 시작");
		
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		
		List<HashMap<String, Object>> resultList = sbuDao.search_result(paramMap,rb);
		
		logger.debug("유저 세부검색 결과 요청 서비스 종료");
		return resultList; 
	}
	
	/**
	 * @Method Name : getTotalBook
	 * @Date : 2017. 8. 29.
	 * @User : 이종호
	 * @Param : 검색 정보
	 * @Return : 검색 된 책 개수
	 * @Method 설명 : 책 개수를 검색하는 서비스 함수
	 */
	public int getTotalBook(HashMap<String, Object> paramMap){
		logger.debug("책 개수 검색하는 서비스 시작");
		
		int result = sbuDao.getTotalBook(paramMap);
		
		logger.debug("책 개수 검색하는 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : insertPurchaseReq
	 * @Date : 2017. 8. 2.
	 * @User : 이정식
	 * @Param :
	 * @Return :
	 * @Method 설명 :
	 */
	public int insertPurchaseReq(PurchaseReq request) {
		logger.debug("도서관리 회원 검색 서비스 시작");

		int result = sbuDao.insertPurchaseReq(request);

		logger.debug("도서관리 회원 검색 서비스 종료");
		return result;
	}

	/**
	 * @Method Name : selectReviewList
	 * @Date : 2017. 8. 2.
	 * @User : 이정식
	 * @Param :
	 * @Return :
	 * @Method 설명 :
	 */
	public ArrayList<Review> selectReviewList(String id) {
		logger.debug("도서관리 회원 검색 서비스 시작");

		ArrayList<Review> reviewList = sbuDao.selectReviewList(id);

		logger.debug("도서관리 회원 검색 서비스 종료");
		return reviewList;
	}

	/**
	 * @Method Name : selectRentalStateList
	 * @Date : 2017. 8. 2.
	 * @User : 이정식
	 * @Param :
	 * @Return :
	 * @Method 설명 :
	 */
	public ArrayList<RentalState> selectRentalStateList(String id) {
		logger.debug("도서관리 회원 검색 서비스 시작");

		ArrayList<RentalState> rentalStateList = sbuDao.selectRentalStateList(id);

		logger.debug("도서관리 회원 검색 서비스 종료");
		return rentalStateList;
	}

	/**
	 * @Method Name : selectBookMarkList
	 * @Date : 2017. 8. 2.
	 * @User : 이정식
	 * @Param :
	 * @Return :
	 * @Method 설명 :
	 */
	public ArrayList<BookMark> selectBookMarkList(String id) {
		logger.debug("도서관리 회원 검색 서비스 시작");

		ArrayList<BookMark> bookMarkList = sbuDao.selectBookMarkList(id);

		logger.debug("도서관리 회원 검색 서비스 종료");
		return bookMarkList;
	}
	
	
}
