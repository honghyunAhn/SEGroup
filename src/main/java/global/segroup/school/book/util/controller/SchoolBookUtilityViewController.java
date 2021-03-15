package global.segroup.school.book.util.controller;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.segroup.school.book.user.service.SchoolBookUserService;
import global.segroup.util.FileService;
import global.segroup.util.PathConstants;


/**
 * @Author : 이정식
 * @Date : 2017. 7. 27.
 * @Class 설명 : 
 * 
 */
@Controller
public class SchoolBookUtilityViewController implements PathConstants {

	private static final Logger logger = LoggerFactory.getLogger(SchoolBookUtilityViewController.class);

	@Autowired
	private SchoolBookUserService sbuService;

	@Value("#{props['edu.book.board_photo']}")
	private String bookInfoImgPath;

	/**
	 * @Method Name : searchISBN
	 * @Date : 2017. 7. 27.
	 * @User : 이정식
	 * @Param :
	 * @Return : JSP 리턴 페이지
	 * @Method 설명 : 책 제목으로 isbn 검색하기
	 */
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_UTILITY_SEARCHISBN, method = RequestMethod.GET)
	public String searchISBN(Model model) {
		return PathConstants.SEGROUP_SCHOOL + PathConstants.SCHOOL_BOOK_UTILITY_SEARCHISBN;
	}
	
	@RequestMapping(value = PathConstants.SCHOOL_BOOK_UTILITY_IMAGE_DOWNLOAD, method = RequestMethod.GET)
	public void imgFileDownload(HttpServletResponse response, String origin , String saved){
		System.out.println("hahah " + origin);
		System.out.println("hahah " + saved);
		FileService.fileDownload(response, origin, saved, bookInfoImgPath);
	}

}
