/**
 * 
 */
package global.segroup.school.book.util.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * @Author : 서민수
 * @Date : 2017. 7. 31.
 * @Class 설명 : Soft Engineer School 도서관리 유틸 DAO
 * 
 */
@Repository
public class SchoolBookUtilDAO {
	private static final Logger logger = LoggerFactory.getLogger(SchoolBookUtilDAO.class);
	
	@Autowired
	SqlSession sqlSession;

	
	/**
	 * @Method Name : getCategory
	 * @Date : 2017. 7. 31.
	 * @User : 서민수
	 * @Param : null
	 * @Return : 대분류 리스트
	 * @Method 설명 : DB에 등록된 대분류 리스트를 리턴한다.
	 */
	public ArrayList<String> getCategory(){
		logger.debug("대분류 가져오기 DAO 시작");
		
		SchoolBookUtilMapper mapper = sqlSession.getMapper(SchoolBookUtilMapper.class);
		ArrayList<String> categoryList = mapper.getCategory();
		
		logger.debug("대분류 가져오기DAO 종료");
		
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
		logger.debug("소분류 가져오기 DAO 시작");
		
		SchoolBookUtilMapper mapper = sqlSession.getMapper(SchoolBookUtilMapper.class);
		ArrayList<String> divisionList = mapper.getDivision();
		
		logger.debug("소분류 가져오기DAO 종료");
		
		return divisionList;
	}
}
