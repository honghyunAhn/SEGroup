/**
 * 
 */
package global.segroup.school.book.util.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import global.segroup.school.book.util.dao.SchoolBookUtilDAO;

/**
 * @Author : 서민수
 * @Date : 2017. 7. 31.
 * @Class 설명 : Soft Engineer School 도서관리 유틸 서비스
 * 
 */

@Service
public class SchoolBookUtilService {
	private static final Logger logger = LoggerFactory.getLogger(SchoolBookUtilService.class);
	
	@Autowired
	private SchoolBookUtilDAO sbutDao;
	
	/**
	 * @Method Name : getCategory
	 * @Date : 2017. 7. 31.
	 * @User : 서민수
	 * @Param : null
	 * @Return : 대분류 리스트
	 * @Method 설명 : DB에 등록된 대분류 리스트를 리턴한다.
	 */
	public ArrayList<String> getCategory(){
		logger.debug("대분류 가져오기 서비스 시작");
		
		ArrayList<String> categoryList = sbutDao.getCategory();
		
		logger.debug("대분류 가져오기 서비스 종료");
		return categoryList; 
	}
	
	/**
	 * @Method Name : getDivision
	 * @Date : 2017. 7. 31.
	 * @User : 서민수
	 * @Param : null
	 * @Return : 소분류 리스트
	 * @Method 설명 : DB에 등록된 소분류 리스트를 리턴한다.
	 */
	public ArrayList<String> getDivision(){
		logger.debug("소분류 가져오기 서비스 시작");
		
		ArrayList<String> divisionList = sbutDao.getDivision();
		
		logger.debug("소분류 가져오기 서비스 종료");
		return divisionList; 
	}
	
}
