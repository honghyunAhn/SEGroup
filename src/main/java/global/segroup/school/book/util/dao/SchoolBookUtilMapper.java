/**
 * 
 */
package global.segroup.school.book.util.dao;

import java.util.ArrayList;

/**
 * @Author : 서민수
 * @Date : 2017. 7. 31.
 * @Class 설명 : Soft Engineer School 도서관리 유틸 Mapper
 * 
 */
public interface SchoolBookUtilMapper {
	
	/**
	 * @Method Name : getCategory
	 * @Date : 2017. 7. 31.
	 * @User : 서민수 
	 * @Param :
	 * @Return : 대분류 리스트
	 * @Method 설명 : DB에 등록된 대분류 리스트를 가져 온다.
	 */
	public ArrayList<String> getCategory();
	
	/**
	 * @Method Name : getDivision
	 * @Date : 2017. 7. 31.
	 * @User : 서민수
	 * @Param : 
	 * @Return : 소분류 리스트
	 * @Method 설명 : DB에 등록된 소분류 리스트를 가져 온다.
	 */
	public ArrayList<String> getDivision();
}
