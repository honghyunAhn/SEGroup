package global.segroup.school.book.util.controller;

import java.util.ArrayList;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.segroup.school.book.admin.controller.SchoolBookAdminRestController;
import global.segroup.school.book.admin.domain.BookInfo;
import global.segroup.school.book.util.AccessBookApi;
import global.segroup.school.book.util.service.SchoolBookUtilService;
import global.segroup.util.PathConstants;

/**
 * @Author : 이정식
 * @Date : 2017. 7. 27.
 * @Class 설명 :
 * 
 */
@Controller
public class SchoolBookUtilityRestController implements PathConstants {

	private static final Logger logger = LoggerFactory.getLogger(SchoolBookAdminRestController.class);

	@Autowired
	private SchoolBookUtilService sbutService;
	
	/**
	 * @Method Name : getCategory
	 * @Date : 2017. 7. 31.
	 * @User : 서민수	
	 * @Param : null
	 * @Return : 대분류 리스트
	 * @Method 설명 : 등록 되어 있는 대분류 리스트를 리턴
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_UTILITY_GET_CATEGORY, method = RequestMethod.GET)
	public ArrayList<String> getCategory(Locale locale, Model model) {
		logger.debug(">> 대분류 가져오기  ", locale);
		
		ArrayList<String> categoryList = sbutService.getCategory();
		
		return categoryList;
	}
	
	/**
	 * @Method Name : getDivision
	 * @Date : 2017. 7. 31.
	 * @User : 서민수	
	 * @Param : null
	 * @Return : 소분류  리스트
	 * @Method 설명 : 등록 되어 있는 소분류 리스트를 리턴
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_UTILITY_GET_DIVISION, method = RequestMethod.GET)
	public ArrayList<String> getDivision(Locale locale, Model model) {
		logger.debug(">> 소분류 가져오기 ", locale);
		
		ArrayList<String> divisionList = sbutService.getDivision();
		
		return divisionList;
	}
	

	private AccessBookApi bookapi = new AccessBookApi();

	/**
	 * @Method Name : searchByTitle
	 * @Date : 2017. 8. 1.
	 * @User : 이정식
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_UTILITY_SEARCH_BY_TITLE, method = RequestMethod.GET)
	public @ResponseBody ArrayList<BookInfo> searchByTitle(String keyword) {
		ArrayList<BookInfo> result = bookapi.searchByTitle(keyword);
		logger.debug("SchoolBookUtilityRestController: searchByTitle");
		return result;
	}

	/**
	 * @Method Name : searchByAuthor
	 * @Date : 2017. 8. 1.
	 * @User : 이정식
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_UTILITY_SEARCH_BY_AUTHOR, method = RequestMethod.GET)
	public @ResponseBody ArrayList<BookInfo> searchByAuthor(String keyword) {
		ArrayList<BookInfo> result = bookapi.searchByAuthor(keyword);
		logger.debug("SchoolBookUtilityRestController: searchByAuthor");
		return result;
	}

	/**
	 * @Method Name : searchByContents
	 * @Date : 2017. 8. 1.
	 * @User : 이정식
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_UTILITY_SEARCH_BY_CONTENTS, method = RequestMethod.GET)
	public @ResponseBody ArrayList<BookInfo> searchByContents(String keyword) {
		ArrayList<BookInfo> result = bookapi.searchByContents(keyword);
		logger.debug("SchoolBookUtilityRestController: searchByContents");
		return result;
	}

	/**
	 * @Method Name : searchByIsbn
	 * @Date : 2017. 8. 1.
	 * @User : 이정식
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_UTILITY_SEARCH_BY_ISBN, method = RequestMethod.GET)
	public @ResponseBody ArrayList<BookInfo> searchByIsbn(String keyword) {
		ArrayList<BookInfo> result = bookapi.searchByIsbn(keyword);
		logger.debug("SchoolBookUtilityRestController: searchByIsbn");
		return result;
	}

}
