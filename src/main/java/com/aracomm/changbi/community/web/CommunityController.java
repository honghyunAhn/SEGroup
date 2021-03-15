package com.aracomm.changbi.community.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONArray;
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

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.base.common.vo.FileVo;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.community.service.ChangbiCommunityService;
import com.aracomm.changbi.serviceCenter.service.BbsService;
import com.google.gson.Gson;

import global.segroup.society.smtp.community.service.SmtpCommunityService;

@Controller
public class CommunityController {
	
	@Value("#{config['boardPages']}")
	String boardPages;
	
	@Autowired
	private BbsService service;
	
	@Autowired
	private ChangbiCommunityService communityService;
	
	private static final Logger logger = LoggerFactory.getLogger(CommunityController.class);
	
	@RequestMapping(value = "lms/community/sub05-01-01", method = RequestMethod.GET)
	public String sub05_01_01(@RequestParam HashMap<String,Object> param, Model model) {
		logger.info("공지사항 페이지 이동 컨트롤러 시작");

		//시작 페이지 객체
		String startPage = StringUtils.isBlank((String)param.get("startPage")) ? "1":(String)param.get("startPage");
		//시작 페이지 설정
		param.put("startPage",  CommonUtil.getStart(startPage, boardPages));
		//볼 수 있는 페이지 설정?
		param.put("visiblePages", boardPages);
		//board_type = 1로 설정
		param.put("board_type", GlobalConst.BBS_TYPE_NOTICE);
		//board_type = 1로 설정
		param.put("notice_type", GlobalConst.BBS_TYPE_NOTICE);
						
		//전체 게시물 갯수
		int totalCnt = communityService.selectNoticeTotalCnt(param);
		//전체 게시물 갯수 설정
		param.put("totalCnt", String.valueOf(totalCnt));

		//모델에 값 대입		
	    model.addAttribute("board_type", GlobalConst.BBS_TYPE_NOTICE);
	    model.addAttribute("notice_type", "1"); // board_type = 1, notice_type = 1 -> 공지사항
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("visiblePages", boardPages);
	    model.addAttribute("totalCnt", totalCnt);
	    model.addAttribute("totalPages", String.valueOf(CommonUtil.getTotalPage(totalCnt,Integer.parseInt(boardPages))));	
	       
	    //모델에 리스트 객체 대입
	    Gson g = new Gson();
		model.addAttribute("bbslist", g.toJson(communityService.selectNotice(param)));
		
		logger.info("공지사항 페이지 이동 컨트롤러 종료");
		return "/lms/community/sub05-01-01";
	}
	@RequestMapping(value="/lms/community/noticeList")
	public @ResponseBody Object smtp_noticeList(@RequestParam HashMap<String,Object> params, Model model, HttpSession session) {
		logger.info("공지사항 리스트 가져오기 컨트롤러 시작");
		
		List<HashMap<String, Object>> result = null;
		try {
			result = communityService.selectNotice(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("공지사항 리스트 가져오기 컨트롤러 종료");
		model.addAttribute("search", params);
		return result;
	}
	@RequestMapping(value="/lms/community/sub05-view-notice", method = RequestMethod.GET)
	public String sub04_view_notice(@RequestParam HashMap<String, Object> params, Model model) {
		
		logger.info("공지사항 상세보기 페이지 이동 컨트롤러 종료");
		
		//공지사항
		if(params.get("board_content_seq") != null) communityService.updateNoticeHit(params);
		//과정공지사항
		else if(params.get("id") != null) communityService.updateCourseNoticeHit(params);
		
		model.addAttribute("search", params);
		
		logger.info("공지사항 상세보기 페이지 이동 컨트롤러 종료");
		
		return "/lms/community/sub05-view-notice";
	}
	@RequestMapping(value = "lms/community/sub05-01-02", method = RequestMethod.GET)
	public String sub05_01_02(@RequestParam HashMap<String,String> param, Model model) {
		logger.info("이벤트 페이지 이동 컨트롤러 시작");

		//시작 페이지 객체
		String startPage = StringUtils.isBlank((String)param.get("startPage")) ? "1":(String)param.get("startPage");
		//시작 페이지 설정
		param.put("startPage",  CommonUtil.getStart(startPage, boardPages));
		//한 페이지 게시글 수
		param.put("visiblePages", boardPages);
		//board_type = 1로 설정
		param.put("board_type", GlobalConst.BBS_TYPE_NOTICE);
		//notice_type = 2로 설정
		param.put("notice_type", "2");
		
		//전체 게시물 갯수
		int totalCnt = communityService.selectBbsListTotCnt(param);
		//전체 게시물 갯수 설정
		param.put("totalCnt", String.valueOf(totalCnt));

		//모델에 값 대입		
        model.addAttribute("board_type", GlobalConst.BBS_TYPE_NOTICE);
        model.addAttribute("notice_type", "2"); // board_type = 1, notice_type = 2 -> 이벤트
        model.addAttribute("startPage", startPage);
        model.addAttribute("visiblePages", boardPages);
        model.addAttribute("totalCnt", totalCnt);
        model.addAttribute("totalPages", String.valueOf(CommonUtil.getTotalPage(totalCnt,Integer.parseInt(boardPages))));	
        
        //모델에 리스트 객체 대입
		model.addAttribute("bbslist", communityService.selectBbsList(param));		
		
		
		logger.info("이벤트 페이지 이동 컨트롤러 종료");
		return "/lms/community/sub05-01-02";
	}
	
	@RequestMapping(value = "lms/community/sub05-02", method = RequestMethod.GET)
	public String sub05_02(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.info("수강후기/인터뷰 페이지 이동 컨트롤러 시작");

		logger.info("수강후기/인터뷰 페이지 이동 컨트롤러 종료");
		return "/lms/community/sub05-02";
	}
	
	@RequestMapping(value = "lms/community/sub05-03", method = RequestMethod.GET)
	public String sub05_03(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.info("설명회 페이지 이동 컨트롤러 시작");

		logger.info("설명회 페이지 이동 컨트롤러 종료");
		return "/lms/community/sub05-03";
	}
	
	@RequestMapping(value = "lms/community/sub05-04", method = RequestMethod.GET)
	public String sub05_04(@RequestParam HashMap<String,String> param, Model model) {
		logger.info("자유게시판 페이지 이동 컨트롤러 시작");

		String pageCount = boardPages;
		if (param.get("visiblePages") != null) {
			pageCount = param.get("visiblePages");
		}

		//시작 페이지 객체
		String startPage = StringUtils.isBlank((String)param.get("startPage")) ? "1":(String)param.get("startPage");
		//시작 페이지 설정
		param.put("startPage",  CommonUtil.getStart(startPage, pageCount));
		//볼 수 있는 페이지 설정?
		param.put("visiblePages", pageCount);
		//board_type = 8로 설정
		param.put("board_type", "8");
		
		//전체 게시물 갯수
		int totalCnt = service.selectBbsListTotCnt(param);
		//전체 게시물 갯수 설정
		param.put("totalCnt", String.valueOf(totalCnt));		

		//모델에 값 대입		
        model.addAttribute("board_type", "8");
        model.addAttribute("startPage", startPage);
        model.addAttribute("visiblePages", pageCount);
        model.addAttribute("totalCnt", totalCnt);
        model.addAttribute("totalPages", String.valueOf(CommonUtil.getTotalPage(totalCnt,Integer.parseInt(pageCount))));	
        
        //모델에 리스트 객체 대입
		model.addAttribute("bbslist", service.selectBbsList(param));
		
		logger.info("자유게시판 페이지 이동 컨트롤러 종료");
		return "/lms/community/sub05-04";
	}
	
	@RequestMapping(value = "lms/community/sub05-04-write", method = RequestMethod.GET)
	public String sub05_04_01(Authentication auth, Model model) {
		logger.info("자유게시판 등록 페이지 이동 컨트롤러 시작");
		// 로그인 정보
		String userId = auth.getName();
		model.addAttribute("userId", userId);

		logger.info("자유게시판 등록 페이지 이동 컨트롤러 종료");
		return "/lms/community/sub05-04-write";
	}
	
	@RequestMapping(value = "lms/community/writeSave")
	public String writeSave(Authentication auth, @RequestParam HashMap<String, String> param, Model model) {
		logger.info("자유게시판 등록 컨트롤러 시작");
		
		// 작성자 아이디
		String userId = auth.getName();
		param.put("user", userId);
		
		// 첨부파일 - 없어서 빈 객체 보냄
		List<FileVo> fileList = new ArrayList<>();
		service.insertBbs(param, fileList);
		
		model.addAttribute("startPage", param.get("startPage"));
		model.addAttribute("visiblePages", param.get("visiblePages"));
		model.addAttribute("board_type", param.get("board_type"));
		
		logger.info("자유게시판 등록 컨트롤러 종료");
		return "redirect:/lms/community/sub05-04";
	}
	
	@RequestMapping(value = "lms/community/sub05-04-view", method = RequestMethod.GET)
	public String sub05_04_02(Authentication auth, @RequestParam HashMap<String, String> param, Model model) {
		logger.info("자유게시판 상세 페이지 이동 컨트롤러 시작");
		// 첨부파일 없음
		HashMap<String, String> detail = service.selectBbsDetail(param);
		// 조회수 증가
		service.updateHits(param.get("id"));
		
		// 게시판 정보
		model.addAttribute("startPage", param.get("startPage"));
		model.addAttribute("visiblePages", param.get("visiblePages"));
		model.addAttribute("board_type", param.get("board_type"));
		model.addAttribute("detail", detail);
		
		// 이전, 다음글 id
		try {
			List<HashMap<String, String>> a = communityService.selectBbsDetailPrevNext(param);
			for (HashMap<String, String> map : a) {
				if (map.get("gubun").equals("PREV")) {
					model.addAttribute("prevId", map.get("id"));
				} else {
					model.addAttribute("nextId", map.get("id"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		logger.info("자유게시판 상세 페이지 이동 컨트롤러 종료");
		return "/lms/community/sub05-04-view";
	}


	@RequestMapping(value = "lms/community/sub05-01-view", method = RequestMethod.GET)
	public String sub05_01_view(@RequestParam HashMap<String, Object> params, Model model) {

		logger.info("게시판 상세 페이지 이동 컨트롤러 시작");

		communityService.updateNoticeHit(params);

		HashMap<String, Object> bbsDetail = communityService.selectNotice(params).get(0);
		
		model.addAttribute("bbsDetail", bbsDetail);
//		model.addAttribute("prevNext", communityService.selectBbsDetailPrevNext(param));
//		model.addAttribute("board_type", param.get("board_type"));
//		model.addAttribute("notice_type", param.get("notice_type"));
		
		logger.info("게시판 상세 페이지 이동 컨트롤러 종료");

		return "/lms/community/sub05-01-view";
	}
	
}
