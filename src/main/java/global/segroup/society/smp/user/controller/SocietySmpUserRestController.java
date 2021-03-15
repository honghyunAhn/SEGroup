package global.segroup.society.smp.user.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import global.segroup.society.edu.apply.service.SocietyEduApplyService;
import global.segroup.util.FileService;
import global.segroup.util.PathConstants;
@RestController
public class SocietySmpUserRestController implements PathConstants{

	private static final Logger logger = LoggerFactory.getLogger(SocietySmpUserRestController.class);
	

	@Autowired
	private SocietyEduApplyService seaService;
	
	// 전희배
	@Value("#{props['smp.board.notice_file']}")
	private String smpBoardNoticeFile;

	
	/**
	 * @Method Name : smp_user_board_fileDownload
	 * @Date : 2018. 08. 30.
	 * @User : 전희배
	 * @Param : -
	 * @Return : JSP 리턴 페이지(이미지 게시판 내용보기 페이지)
	 * @Method 설명 : 이미지 내용보기 페이지를 호출하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = SOCIETY_SMP_USER_BOARD_FILEDOWNLOAD, method = RequestMethod.POST)
	public void smp_user_board_fileDownload(Model model, Authentication auth, String seq, HttpServletRequest request,HttpServletResponse response){

		logger.debug("공지사항 첨부파일 호출하는 컨트롤러 시작");

		HashMap<String, Object> files = null;
		files = seaService.boardFileDetail(seq);
		FileService.fileDownload(response, (String)files.get("board_file_origin"), (String)files.get("board_file_saved"),  (String)files.get("board_file_saved"));
		
		logger.debug("공지사항 첨부파일 호출하는 컨트롤러 종료");
	}
	
}
