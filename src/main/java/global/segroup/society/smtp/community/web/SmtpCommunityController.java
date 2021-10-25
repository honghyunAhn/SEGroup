package global.segroup.society.smtp.community.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.changbi.common.GlobalConst;

import global.segroup.domain.BoardPager;
import global.segroup.society.edu.apply.service.SocietyEduApplyService;
import global.segroup.society.smtp.community.service.SmtpCommunityService;
import global.segroup.util.FileService;
import global.segroup.util.PathConstants;

@Controller
public class SmtpCommunityController {
	
	@Value("#{config['boardPages']}")
	String boardPages;

	private static final Logger logger = LoggerFactory.getLogger(SmtpCommunityController.class);
	
	@Autowired
	private SmtpCommunityService communityService;
	
	@Autowired
	private SocietyEduApplyService eduApplyService;
	
	@Value("#{props['edu.apply.board_file']}")
	private String eduApplyBoardFile;
	
	@RequestMapping(value="/smtp/community/noticeList")
	public @ResponseBody Object smtp_noticeList(@RequestParam HashMap<String,Object> params, HttpSession session) {
		logger.info("공지사항 리스트 가져오기 컨트롤러 시작");
		
		List<HashMap<String, Object>> result = null;
		try {
			result = communityService.selectNotice(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("공지사항 리스트 가져오기 컨트롤러 종료");
		
		return result;
	}
	
	@RequestMapping(value = "/smtp/community/sub04-01", method = RequestMethod.GET)
	public String sub04_01(Model model, Authentication auth,@RequestParam(defaultValue="contents") String searchOption,
            @RequestParam(defaultValue="") String keyword,
            @RequestParam(defaultValue="1") int curPage){
		logger.info("공지사항 페이지 이동 컨트롤러 시작");
		BoardPager.setBLOCK_SCALE(25);
		BoardPager.setPAGE_SCALE(10);
		String boardSeq="8";
		int count= eduApplyService.countBoard(searchOption,keyword,boardSeq);
		BoardPager boardPager = new BoardPager(count, curPage);
		
		int start = boardPager.getPageBegin();
		int end = boardPager.getPageEnd();
		
		ArrayList<HashMap<String, Object>> boardList = (ArrayList<HashMap<String, Object>>) eduApplyService.boardListAll(start, end, searchOption, keyword, boardSeq);

		 Map<String, Object> map = new HashMap<String, Object>();
		    map.put("count", count); // 레코드의 갯수
		    map.put("searchOption", searchOption); // 검색옵션
		    map.put("keyword", keyword); // 검색키워드
		    map.put("boardPager", boardPager);
		    
		    for(int i=0;i<boardList.size();i++){
				
		    	String contents=  (((String) (boardList.get(i).get("board_content_title"))).replaceAll("\\<.*?>", "").substring(0,
						Math.min(((String) boardList.get(i).get("board_content_title")).replaceAll("\\<.*?>", "").length(), 150)));
		    	  if(contents.length()>61){
				    	contents=contents.substring(0,Math.min(contents.length(), 60));
				    	contents+="....";
				    }
		    	  boardList.get(i).put("board_content_title", contents);        
			}
		    
		    model.addAttribute("boardList", boardList);
			model.addAttribute("map", map);
			logger.info("공지사항 페이지 이동 컨트롤러 종료");
		return "/segroup/society/smtp/community/sub04-01";
	}
	
	@RequestMapping(value = "/smtp/community/rainbow-community01-01", method = RequestMethod.GET)
	public String rainbow_community01_01(Model model, Authentication auth,@RequestParam(defaultValue="contents") String searchOption,
            @RequestParam(defaultValue="") String keyword,
            @RequestParam(defaultValue="1") int curPage){
		logger.info("공지사항 페이지 이동 컨트롤러 시작");
		BoardPager.setBLOCK_SCALE(25);
		BoardPager.setPAGE_SCALE(10);
		String boardSeq="8";
		int count= eduApplyService.countBoard(searchOption,keyword,boardSeq);
		BoardPager boardPager = new BoardPager(count, curPage);
		
		int start = boardPager.getPageBegin();
		int end = boardPager.getPageEnd();
		
		ArrayList<HashMap<String, Object>> boardList = (ArrayList<HashMap<String, Object>>) eduApplyService.boardListAll(start, end, searchOption, keyword, boardSeq);

		 Map<String, Object> map = new HashMap<String, Object>();
		    map.put("count", count); // 레코드의 갯수
		    map.put("searchOption", searchOption); // 검색옵션
		    map.put("keyword", keyword); // 검색키워드
		    map.put("boardPager", boardPager);
		    
		    for(int i=0;i<boardList.size();i++){
				
		    	String contents=  (((String) (boardList.get(i).get("board_content_title"))).replaceAll("\\<.*?>", "").substring(0,
						Math.min(((String) boardList.get(i).get("board_content_title")).replaceAll("\\<.*?>", "").length(), 150)));
		    	  if(contents.length()>61){
				    	contents=contents.substring(0,Math.min(contents.length(), 60));
				    	contents+="....";
				    }
		    	  boardList.get(i).put("board_content_title", contents);        
			}
		    
		    model.addAttribute("boardList", boardList);
			model.addAttribute("map", map);
			logger.info("공지사항 페이지 이동 컨트롤러 종료");
		return "/segroup/society/smtp/community/rainbow-community01-01";
	}
	
	@RequestMapping(value = "/smtp/community/rainbow-community01-02", method = RequestMethod.GET)
	public String rainbow_community01_02(Model model, Authentication auth, String seq, String searchOption,HttpServletRequest request){
		logger.debug("공지사항 게시판을 내용을 호출하는 컨트롤러 시작");
		try{
			eduApplyService.boardHit(Integer.parseInt(seq));
		}catch(Exception e){
			e.printStackTrace();
		}
		HashMap<String, Object> detail = null;
		if(searchOption==null){
			detail= eduApplyService.boardDetail(seq,"8");
		} else if(searchOption.equals("next")
				|| searchOption.equals("previous")){
			detail= eduApplyService.boardDetail(seq, searchOption, "8");	
		}
		if(detail==null){
			String referer = request.getHeader("Referer");
		    return "redirect:"+ referer;
		}
		
		ArrayList<HashMap<String, Object>> files = null;
		files=eduApplyService.boardFiles(detail.get("board_content_seq").toString());
		
		model.addAttribute("boardDetail", detail);
		model.addAttribute("files", files);
		model.addAttribute("path", eduApplyBoardFile);
		logger.debug("공지사항 게시판을 내용을 호출하는 컨트롤러 종료");
		return "/segroup/society/smtp/community/rainbow-community01-02";
	}
	
	@RequestMapping(value="/smtp/community/rainbow-community02-01", method=RequestMethod.GET)
	public String rainbow_community02_01(Model model, @RequestParam HashMap<String,Object> params) {
		
		logger.info("FAQ 페이지 이동 컨트롤러 시작");
		
		model.addAttribute("search", params);
		
		logger.info("FAQ 페이지 이동 컨트롤러 끝");		
		
		return"/segroup/society/smtp/community/rainbow-community02-01";
	}
	
	@RequestMapping(value = "/smtp/community/sub04-01-01", method = RequestMethod.GET)
	public String sub04_01_view(Model model, Authentication auth, String seq, String searchOption,HttpServletRequest request){

		logger.debug("공지사항 게시판을 내용을 호출하는 컨트롤러 시작");
		try{
			eduApplyService.boardHit(Integer.parseInt(seq));
		}catch(Exception e){
			e.printStackTrace();
		}
		HashMap<String, Object> detail = null;
		if(searchOption==null){
			detail= eduApplyService.boardDetail(seq,"8");
		} else if(searchOption.equals("next")
				|| searchOption.equals("previous")){
			detail= eduApplyService.boardDetail(seq, searchOption, "8");	
		}
		if(detail==null){
			String referer = request.getHeader("Referer");
		    return "redirect:"+ referer;
		}
		
		ArrayList<HashMap<String, Object>> files = null;
		files=eduApplyService.boardFiles(detail.get("board_content_seq").toString());
		
		model.addAttribute("boardDetail", detail);
		model.addAttribute("files", files);
		model.addAttribute("path", eduApplyBoardFile);
		logger.debug("공지사항 게시판을 내용을 호출하는 컨트롤러 종료");
		return "/segroup/society/smtp/community/sub04-01-01";
	}
	
	@RequestMapping(value="/smtp/community/rainbow-community05-01", method=RequestMethod.GET)
	public String rainbow_community05_01() {
		
		logger.info("오시는길 페이지 이동 컨트롤러 시작");
		logger.info("오시는길 페이지 이동 컨트롤러 끝");		
		
		return"/segroup/society/smtp/community/rainbow-community05-01";
	}
	
	@RequestMapping(value="/smtp/community/courseNoticeList")
	public @ResponseBody Object smtp_courseNoticeList(@RequestParam HashMap<String,Object> params, Model model) {
		logger.info("공지사항 리스트 가져오기 컨트롤러 시작");
		
		List<HashMap<String, Object>> result = null;
		try {
			if(params.get("startPage") != null && params.get("visiblePages") != null) {
				params.put("startPage", Integer.parseInt((String)params.get("startPage")));
				params.put("visiblePages", Integer.parseInt((String)params.get("visiblePages")));
			}
			result = communityService.selectCourseNotice(params);
			if(params.get("id") != null) communityService.updateCourseNoticeHit(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("공지사항 리스트 가져오기 컨트롤러 종료");
		model.addAttribute("search", params);
		return result;
	}
	@RequestMapping(value="/smtp/community/courseQnaList")
	public @ResponseBody Object smtp_courseQnaList(@RequestParam HashMap<String,Object> params, Model model) {
		logger.info("과정 Qna 리스트 가져오기 컨트롤러 시작");
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		List<HashMap<String, Object>> qnaList = null;
		List<HashMap<String, Object>> qnaReplyList = null;
		
		try {
			params.put("startPage", Integer.parseInt((String)params.get("startPage")));
			params.put("replyStartPage", Integer.parseInt((String)params.get("replyStartPage")));
			params.put("visiblePages", Integer.parseInt((String)params.get("visiblePages")));
			params.put("replyVisiblePages", Integer.parseInt((String)params.get("replyVisiblePages")));
			
			model.addAttribute("search", params);
			
			if(params.get("id") != null) {
				params.put("startPage", 0);
			}
			qnaList = communityService.selectCourseNotice(params);
			result.put("qnaList", qnaList);
			
			int qnaListTotalCnt = communityService.selectCourseNoticeTotalCnt(params);
			result.put("qnaListTotalCnt", qnaListTotalCnt);
			
			int qnaReplyTotalCnt = communityService.selectQnaReplyListTotalCnt(params);
			result.put("qnaReplyTotalCnt", qnaReplyTotalCnt);
			
			if(params.get("id") != null) {
				model.addAttribute("qnaDetail", qnaList.get(0));
				communityService.updateCourseNoticeHit(params);
				//댓글가져오기
				qnaReplyList = communityService.selectQnaReplyList(params);
				result.put("qnaReplyList", qnaReplyList);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		logger.info("과정 Qna 리스트 가져오기 컨트롤러 종료");
		
		return result;
	}
	@RequestMapping(value="/smtp/community/insertQna")
	public @ResponseBody Object smtp_insertQna(@RequestParam HashMap<String,Object> params, Authentication auth, MultipartFile file) {
		logger.info("과정 qna 작성 컨트롤러 시작");
		
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id",user_id);
		
		int result = 0;
		try {
			result = communityService.insertQna(params, file);
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("과정 qna 작성 컨트롤러 종료");
		
		if(result > 0) return true;
		else return false;
	}
	
	@RequestMapping(value="/smtp/community/deleteQna")
	public @ResponseBody Object smtp_deleteQna(@RequestParam HashMap<String,Object> params, Authentication auth) {
		logger.info("과정 qna 삭제 컨트롤러 시작");
		int result = 0;
		
		try {
			result = communityService.deleteQna(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("과정 qna 삭제 컨트롤러 종료");
		
		if(result > 0) return true;
		else return false;
	}
	@RequestMapping(value="/smtp/community/deleteQnaAttachFile")
	public @ResponseBody Object smtp_deleteQnaAttachFile(@RequestParam HashMap<String,Object> params) {
		logger.info("과정 qna 첨부파일 삭제 컨트롤러 시작");
		int result = 0;
		
		try {
			result = communityService.deleteQnaAttachFile(params);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		logger.info("과정 qna 첨부파일 삭제 컨트롤러 종료");
		
		if(result > 0) return true;
		else return false;
	}
	@RequestMapping(value="/smtp/community/insertQnaReply")
	public @ResponseBody Object smtp_insertQnaReply(@RequestParam HashMap<String,Object> params, Authentication auth) {
		logger.info("과정 qna 댓글 작성 컨트롤러 시작");
		
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id",user_id);
		
		int result = 0;
		
		try {
			result = communityService.insertQnaReply(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("과정 qna 댓글 작성 컨트롤러 종료");
		
		if(result > 0) return true;
		else return false;
	}
	@RequestMapping(value="/smtp/community/deleteQnaReply")
	public @ResponseBody Object smtp_deleteQnaReply(@RequestParam HashMap<String,Object> params, Authentication auth) {
		logger.info("과정 qna 댓글 삭제 컨트롤러 시작");
		
		int result = 0;
		
		try {
			result = communityService.deleteQnaReply(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("과정 qna 댓글 삭제 컨트롤러 종료");
		
		if(result > 0) return true;
		else return false;
	}
	@RequestMapping(value="/smtp/community/updateQnaReplyRecommend")
	public @ResponseBody Object smtp_updateQnaReplyRecommend(@RequestParam HashMap<String,Object> params, Authentication auth) {
		logger.info("과정 qna 댓글 추천비추천 컨트롤러 시작");
		
		int result = 0;
		
		try {
			result = communityService.updateQnaReplyRecommend(params);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		logger.info("과정 qna 댓글 추천비추천 컨트롤러 종료");
		
		if(result > 0) return true;
		else return false;
	}
	@RequestMapping(value="/smtp/community/sub04-view-notice", method = RequestMethod.GET)
	public String sub04_view_notice(@RequestParam HashMap<String, Object> params, Model model) {
		
		logger.info("공지사항 상세보기 페이지 이동 컨트롤러 종료");
		
		//공지사항
		if(params.get("board_content_seq") != null) communityService.updateNoticeHit(params);
		//과정공지사항
		else if(params.get("id") != null) communityService.updateCourseNoticeHit(params);
		
		model.addAttribute("search", params);
		
		logger.info("공지사항 상세보기 페이지 이동 컨트롤러 종료");
		
		return "/segroup/society/smtp/community/popup/sub04-view-notice";
	}
	
	//lms식 pagination을 사용하는 곳이면 공통으로 활용가능함
	@RequestMapping(value = "smtp/community/pageInfo", method = RequestMethod.GET)
	public @ResponseBody Object smtp_pageInfo(@RequestParam HashMap<String, String> param, HttpSession session) {
		logger.info("Ajax 페이징 정보처리 시작");
		
		HashMap<String, Object> returnParam = new HashMap<String, Object>();
		
		//시작 페이지 객체
		String startPage = StringUtils.isBlank((String)param.get("startPage")) ? "1" : (String)param.get("startPage");
		param.put("startPage", CommonUtil.getStart(startPage, boardPages));
		// 볼 수 있는 페이지 설정
		param.put("visiblePages", boardPages);
		//board_type==1 (select 조건)
		param.put("board_type", GlobalConst.BBS_TYPE_NOTICE);
		//notice_type == 1(select 조건)
		param.put("notice_type", GlobalConst.BBS_TYPE_NOTICE);
		
		int listNum = Integer.parseInt((String) param.get("listNum"));
		try {
			int totalCnt = 0;
			if (listNum == 1) {
				totalCnt = communityService.selectBbsListTotCnt(param);
			} 
			returnParam.put("totalCnt", String.valueOf(totalCnt));
			returnParam.put("totalPages",
					String.valueOf(CommonUtil.getTotalPage(totalCnt, Integer.parseInt(boardPages))));
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 전체 게시물 갯수 설정
		returnParam.put("startPage", CommonUtil.getStart(startPage, boardPages));
		returnParam.put("visiblePages", String.valueOf(boardPages));
	
		logger.info("Ajax 페이징 정보처리 종료");
		
		return returnParam;
	}
	
	@RequestMapping(value = "/smtp/community/sub04-05", method = RequestMethod.GET)
	public String sub04_05(Model model, Authentication auth,@RequestParam(defaultValue="contents") String searchOption,
            @RequestParam(defaultValue="") String keyword,
            @RequestParam(defaultValue="1") int curPage){
		BoardPager.setBLOCK_SCALE(25);
		BoardPager.setPAGE_SCALE(10);
		String boardSeq="9";
		int count=eduApplyService.countBoard(searchOption,keyword,boardSeq);
		BoardPager boardPager = new BoardPager(count, curPage);
		
		int start = boardPager.getPageBegin();
		int end = boardPager.getPageEnd();
		
		ArrayList<HashMap<String, Object>> boardList = (ArrayList<HashMap<String, Object>>) eduApplyService.boardListAll(start, end, searchOption, keyword, boardSeq);

		 Map<String, Object> map = new HashMap<String, Object>();
		    map.put("count", count); // 레코드의 갯수
		    map.put("searchOption", searchOption); // 검색옵션
		    map.put("keyword", keyword); // 검색키워드
		    map.put("boardPager", boardPager);
		    
		    for(int i=0;i<boardList.size();i++){
				
		    	String contents=  (((String) (boardList.get(i).get("board_content_title"))).replaceAll("\\<.*?>", "").substring(0,
						Math.min(((String) boardList.get(i).get("board_content_title")).replaceAll("\\<.*?>", "").length(), 150)));
		    	  if(contents.length()>61){
				    	contents=contents.substring(0,Math.min(contents.length(), 60));
				    	contents+="....";
				    }
		    	  boardList.get(i).put("board_content_title", contents);        
			}
		    
		    
		    
		    model.addAttribute("boardList", boardList);
			model.addAttribute("map", map);
		return PathConstants.SEGROUP_SOCIETY + "/smtp/community/sub04-05";
	}
	
	@RequestMapping(value = "/smtp/community/rainbow-community04-01", method = RequestMethod.GET)
	public String rainbow_community04_01(Model model, Authentication auth,@RequestParam(defaultValue="contents") String searchOption,
            @RequestParam(defaultValue="") String keyword,
            @RequestParam(defaultValue="1") int curPage){
		BoardPager.setBLOCK_SCALE(25);
		BoardPager.setPAGE_SCALE(10);
		String boardSeq="9";
		int count=eduApplyService.countBoard(searchOption,keyword,boardSeq);
		BoardPager boardPager = new BoardPager(count, curPage);
		
		int start = boardPager.getPageBegin();
		int end = boardPager.getPageEnd();
		
		ArrayList<HashMap<String, Object>> boardList = (ArrayList<HashMap<String, Object>>) eduApplyService.boardListAll(start, end, searchOption, keyword, boardSeq);

		 Map<String, Object> map = new HashMap<String, Object>();
		    map.put("count", count); // 레코드의 갯수
		    map.put("searchOption", searchOption); // 검색옵션
		    map.put("keyword", keyword); // 검색키워드
		    map.put("boardPager", boardPager);
		    
		    for(int i=0;i<boardList.size();i++){
				
		    	String contents=  (((String) (boardList.get(i).get("board_content_title"))).replaceAll("\\<.*?>", "").substring(0,
						Math.min(((String) boardList.get(i).get("board_content_title")).replaceAll("\\<.*?>", "").length(), 150)));
		    	  if(contents.length()>61){
				    	contents=contents.substring(0,Math.min(contents.length(), 60));
				    	contents+="....";
				    }
		    	  boardList.get(i).put("board_content_title", contents);        
			}
		    
		    
		    
		    model.addAttribute("boardList", boardList);
			model.addAttribute("map", map);
		return PathConstants.SEGROUP_SOCIETY + "/smtp/community/rainbow-community04-01";
	}
	
	@RequestMapping(value = "/smtp/community/sub04-05-01", method = RequestMethod.GET)
	public String sub04_05_01(Model model, Authentication auth, String seq, String searchOption,HttpServletRequest request){

		logger.debug("졸업생마당 게시판을 내용을 호출하는 컨트롤러 시작");
		
		if(seq == null || seq.equals("")) {
			return "redirect:/smtp/community/sub04-05";
		}
		
		eduApplyService.boardHit(Integer.parseInt(seq));
		HashMap<String, Object> detail = null;
		if(searchOption==null){
			detail= eduApplyService.boardDetail(seq,"9");
		} else if(searchOption.equals("next")){
			detail= eduApplyService.boardDetail(seq,searchOption,"9");	
		} else if(searchOption.equals("previous")){
			detail= eduApplyService.boardDetail(seq,searchOption,"9");	
		}
		if(detail==null){
			String referer = request.getHeader("Referer");
		    return "redirect:"+ referer;
		}
		
		ArrayList<HashMap<String, Object>> files = null;
		files=eduApplyService.boardFiles(detail.get("board_content_seq").toString());
		
		model.addAttribute("boardDetail", detail);
		model.addAttribute("files", files);
		model.addAttribute("path", eduApplyBoardFile);
		logger.debug("졸업생마당 게시판을 내용을 호출하는 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + "/smtp/community/sub04-05-01";
	}
	
	@RequestMapping(value = "/smtp/community/rainbow-community04-02", method = RequestMethod.GET)
	public String rainbow_community04_02(Model model, Authentication auth, String seq, String searchOption,HttpServletRequest request){

		logger.debug("졸업생마당 게시판을 내용을 호출하는 컨트롤러 시작");
		
		if(seq == null || seq.equals("")) {
			return "redirect:/smtp/community/rainbow-community04-01";
		}
		
		eduApplyService.boardHit(Integer.parseInt(seq));
		HashMap<String, Object> detail = null;
		if(searchOption==null){
			detail= eduApplyService.boardDetail(seq,"9");
		} else if(searchOption.equals("next")){
			detail= eduApplyService.boardDetail(seq,searchOption,"9");	
		} else if(searchOption.equals("previous")){
			detail= eduApplyService.boardDetail(seq,searchOption,"9");	
		}
		if(detail==null){
			String referer = request.getHeader("Referer");
		    return "redirect:"+ referer;
		}
		
		ArrayList<HashMap<String, Object>> files = null;
		files=eduApplyService.boardFiles(detail.get("board_content_seq").toString());
		
		model.addAttribute("boardDetail", detail);
		model.addAttribute("files", files);
		model.addAttribute("path", eduApplyBoardFile);
		logger.debug("졸업생마당 게시판을 내용을 호출하는 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + "/smtp/community/rainbow-community04-02";
	}
	
	@RequestMapping(value = "/smtp/community/rainbow-community03-01", method = RequestMethod.GET)
	public String rainbow_community03_01(Model model, Authentication auth,@RequestParam(defaultValue="contents") String searchOption,
            @RequestParam(defaultValue="") String keyword,
            @RequestParam(defaultValue="1") int curPage){
		BoardPager.setBLOCK_SCALE(25);
		BoardPager.setPAGE_SCALE(10);
		int consulting_tp=1000; // 온라인상담 부분 검색
		int count=eduApplyService.online_consulting_countBoard(searchOption,keyword,consulting_tp);
		BoardPager boardPager = new BoardPager(count, curPage);
		
		int start = boardPager.getPageBegin();
		int end = boardPager.getPageEnd();
		
		ArrayList<HashMap<String, Object>> boardList = (ArrayList<HashMap<String, Object>>) eduApplyService.online_consulting_boardListAll(start, end, searchOption, keyword, consulting_tp);
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("count", count); // 레코드의 갯수
	    map.put("searchOption", searchOption); // 검색옵션
	    map.put("keyword", keyword); // 검색키워드
	    map.put("boardPager", boardPager);
		    
		    for(int i=0;i<boardList.size();i++){
		    	String contents=  (((String) (boardList.get(i).get("consulting_title"))).replaceAll("\\<.*?>", "").substring(0,
						Math.min(((String) boardList.get(i).get("consulting_title")).replaceAll("\\<.*?>", "").length(), 150)));
		    	  if(contents.length()>51){
				    	contents=contents.substring(0,Math.min(contents.length(), 50));
				    	contents+="....";
				    }
		    	  boardList.get(i).put("consulting_title", contents);        
			}
		    
		    if (auth != null) {
		    	model.addAttribute("consulting_ins_id", auth.getName());
			}
		    
		    model.addAttribute("boardList", boardList);
			model.addAttribute("map", map);
		return PathConstants.SEGROUP_SOCIETY + "/smtp/community/rainbow-community03-01";
	}
	
	@RequestMapping(value = "/smtp/community/rainbow-community03-02", method = RequestMethod.GET)
	public String rainbow_community03_02(Model model, Authentication auth, int consulting_seq, String searchOption, HttpServletRequest request){
		
		logger.debug("온라인상담 게시판을 내용을 호출하는 컨트롤러 시작");
		
		eduApplyService.online_consulting_hit_update(consulting_seq);
		HashMap<String, Object> detail = null;
		if(searchOption==null){
			detail= eduApplyService.online_consulting_boardDetail(consulting_seq);
		} else if(searchOption.equals("next")){
			detail= eduApplyService.online_consulting_boardDetail(consulting_seq,searchOption);	
		} else if(searchOption.equals("previous")){
			detail= eduApplyService.online_consulting_boardDetail(consulting_seq,searchOption);	
		}
		if(detail==null){
			String referer = request.getHeader("Referer");
			return "redirect:"+ referer;
		}
		
		if (auth != null) {
	    	model.addAttribute("consulting_ins_id", auth.getName());
		}
		
		model.addAttribute("boardDetail", detail);
		
		logger.debug("온라인상담 게시판을 내용을 호출하는 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + "/smtp/community/rainbow-community03-02";
	}
	

	@RequestMapping(value = "/smtp/community/rainbow-community03-03" , method = RequestMethod.GET)
	public String rainbow_community03_03(Model model, Authentication auth){
		
		model.addAttribute("consulting_ins_id", auth.getName());
		
		return PathConstants.SEGROUP_SOCIETY + "/smtp/community/rainbow-community03-03";
	}

	@RequestMapping(value = "/smtp/community/rainbow-community03-04", method = RequestMethod.GET)
	public String rainbow_community03_04(int consulting_seq, Model model, Authentication auth){
		logger.debug("온라인상담 게시글 세부 내용 수정 폼 이동 컨트롤러 시작");
		
		HashMap<String, Object> resultMap = eduApplyService.online_consulting_boardDetail(consulting_seq);

		model.addAttribute("consulting_ins_id", auth.getName());
		model.addAttribute("contentDetail", resultMap);
		
		logger.debug("온라인상담 게시글 세부 내용 수정 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + "/smtp/community/rainbow-community03-04";
	}
//	@RequestMapping(value = PathConstants.SOCIETY_EDU_COMMUNITY_MEDIA_IN_IT, method = RequestMethod.GET)
//	public String apply_media_in_it(Model model, Authentication auth,@RequestParam(defaultValue="contents") String searchOption,
//            @RequestParam(defaultValue="") String keyword,
//            @RequestParam(defaultValue="1") int curPage){
//		BoardPager.setBLOCK_SCALE(25);
//		BoardPager.setPAGE_SCALE(10);
//		String boardSeq="10";
//		int count= eduApplyService.countBoard(searchOption,keyword,boardSeq);
//		BoardPager boardPager = new BoardPager(count, curPage);
//		
//		int start = boardPager.getPageBegin();
//		int end = boardPager.getPageEnd();
//		
//		ArrayList<HashMap<String, Object>> boardList = (ArrayList<HashMap<String, Object>>) eduApplyService.boardListAll(start, end, searchOption, keyword, boardSeq);
//
//		 Map<String, Object> map = new HashMap<String, Object>();
//		    map.put("count", count); // 레코드의 갯수
//		    map.put("searchOption", searchOption); // 검색옵션
//		    map.put("keyword", keyword); // 검색키워드
//		    map.put("boardPager", boardPager);
//		    
//		    for(int i=0;i<boardList.size();i++){
//				
//		    	String contents=  (((String) (boardList.get(i).get("board_content_title"))).replaceAll("\\<.*?>", "").substring(0,
//						Math.min(((String) boardList.get(i).get("board_content_title")).replaceAll("\\<.*?>", "").length(), 150)));
//		    	  if(contents.length()>61){
//				    	contents=contents.substring(0,Math.min(contents.length(), 60));
//				    	contents+="....";
//				    }
//		    	  boardList.get(i).put("board_content_title", contents);        
//			}
//		    
//		    
//		    
//		    model.addAttribute("boardList", boardList);
//			model.addAttribute("map", map);
//		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_COMMUNITY_MEDIA_IN_IT;
//	}
//	@RequestMapping(value = PathConstants.SOCIETY_EDU_COMMUNITY_MEDIA_IN_IT_DETAIL, method = RequestMethod.GET)
//	public String apply_media_in_it_detail(Model model, Authentication auth, String seq, String searchOption,HttpServletRequest request){
//
//		logger.debug("미디어속 SC IT마스터 게시판을 내용을 호출하는 컨트롤러 시작");
//		
//		eduApplyService.boardHit(Integer.parseInt(seq));
//		HashMap<String, Object> detail = null;
//		if(searchOption==null){
//			detail= eduApplyService.boardDetail(seq,"10");
//		} else if(searchOption.equals("next")){
//			detail= eduApplyService.boardDetail(seq,searchOption,"10");	
//		} else if(searchOption.equals("previous")){
//			detail= eduApplyService.boardDetail(seq,searchOption,"10");	
//		}
//		if(detail==null){
//			String referer = request.getHeader("Referer");
//		    return "redirect:"+ referer;
//		}
//		
//		ArrayList<HashMap<String, Object>> files = null;
//		files=eduApplyService.boardFiles(detail.get("board_content_seq").toString());
//		
//		model.addAttribute("boardDetail", detail);
//		model.addAttribute("files", files);
//		model.addAttribute("path", eduApplyBoardFile);
//		logger.debug("미디어속 SC IT마스터 게시판을 내용을 호출하는 컨트롤러 종료");
//		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_EDU_COMMUNITY_MEDIA_IN_IT_DETAIL;
//	}
}
