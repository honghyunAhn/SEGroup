package com.aracomm.changbi.support.web;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.serviceCenter.service.BbsService;
import com.aracomm.changbi.support.service.SupportService;

@Controller
public class SupportController {
	
	private final static int BBS_VIEW_TYPE_NOTICE = 0;
	private final static int BBS_VIEW_TYPE_QNA = 1;
	private final static int BBS_VIEW_TYPE_FAQ = 2;	
	private static final Logger logger = LoggerFactory.getLogger(SupportController.class);

	@Autowired
	private BbsService service;

	@Autowired
	private SupportService supportService;

	
	
	@Value("#{config['boardPages']}")
	String boardPages;
	
	
	@RequestMapping(value="lms/support/sub06-01-01", method=RequestMethod.GET)
	public String sub06_01_01() {

		logger.info("고객지원 - 학습자 PC 환경설정 페이지 이동 컨트롤러 시작");

		
		

		logger.info("고객지원 - 학습자 PC 환경설정 페이지 이동 컨트롤러 끝");

		
		
		return "/lms/support/sub06-01-01";
	}
	
	
	@RequestMapping(value="lms/support/sub06-01-02", method=RequestMethod.GET)
	public String sub06_01_02() {
		
		logger.info("고객지원 - PC 원격지원 페이지 이동 컨트롤러 시작");

		
		

		logger.info("고객지원 - PC 원격지원 페이지 이동 컨트롤러 끝");

		return"lms/support/sub06-01-02";
	}
	
	@RequestMapping(value="lms/support/sub06-02", method=RequestMethod.GET)
	public String sub06_02(Model model, @RequestParam HashMap<String,String> param) {
		logger.info("FAQ 페이지 이동 컨트롤러 시작");
		//시작 페이지 객체
		String startPage = StringUtils.isBlank((String)param.get("startPage")) ? "1":(String)param.get("startPage");
		//시작 페이지 설정
		param.put("startPage",  CommonUtil.getStart(startPage, boardPages));
		param.put("visiblePages", boardPages);
		param.put("board_type", "3");

		//전체 게시물 갯수
		int totalCnt = service.selectFaqListTotCnt(param);
		//전체 게시물 갯수 설정
		param.put("totalCnt", String.valueOf(totalCnt));

		
		//모델에 값 대입		
        model.addAttribute("board_type", "3");
        model.addAttribute("startPage", startPage);
        model.addAttribute("visiblePages", boardPages);
        model.addAttribute("totalCnt", totalCnt);
        model.addAttribute("totalPages", String.valueOf(CommonUtil.getTotalPage(totalCnt,Integer.parseInt(boardPages))));	
		
		//해야할 일
		//default는 제일 왼쪽에 있는 아이로 하자.
		//먼저 faq에 해당하는 ff_code들의 리스트를 뽑아서 상단의 탭에 뿌린다.
		//해당 탭을 클릭하면 해당 탭에 해당하는 faq 리스트를 뽑아야 한다.
		//board_type = 3이 faq
		
        //모델에 faq 코드이름 대입
		model.addAttribute("bbscode", service.selectBbsCodeList(GlobalConst.CODE_GROUP_FQA));	// faq분류

		//모델에 리스트 객체 대입
		model.addAttribute("bbslist", supportService.selectFaqListLms(param));
		model.addAttribute("faq_code", param.get("faqCode"));
		model.addAttribute("id", param.get("id"));

		logger.info("FAQ 페이지 이동 컨트롤러 끝");		

		
		return"lms/support/sub06-02";
	}
	
	@RequestMapping(value="lms/support/sub06-03", method=RequestMethod.GET)
	public String sub06_03() {

		logger.info("단체, 제휴 문의 페이지 이동 컨트롤러 시작");

		logger.info("FAQ 페이지 이동 컨트롤러 끝");

		
		return"lms/support/sub06-03";
	}
	@RequestMapping(value="lms/support/sub06-04", method=RequestMethod.GET)
	public String sub06_04() {
		
		logger.info("오시는 길 페이지 이동 컨트롤러 시작");

		logger.info("오시는 길 페이지 이동 컨트롤러 끝");

		return"lms/support/sub06-04";
	}
	
	/**
	 * 게시판리스트 공통처리
	 * @param model
	 * @param param
	 * @param viewType
	 */
	private void processCommonBbsList(String visiblePages, int viewType, HashMap<String,String> param, Model model) {
		String startPage = StringUtils.isBlank(param.get("startPage")) ? "1":param.get("startPage");
		param.put("startPage", CommonUtil.getStart(startPage, visiblePages));
        param.put("visiblePages", visiblePages);
      /*  param.put("notice_type", param.get("notice_type"));*/
        int totalCnt = 0;
        switch(viewType) {
        case BBS_VIEW_TYPE_QNA:
        	totalCnt = service.selectQnaListTotCnt(param);
        	break;
        case BBS_VIEW_TYPE_FAQ:
        	totalCnt = service.selectFaqListTotCnt(param);
        	break;
        default:
        	totalCnt = service.selectBbsListTotCnt(param);
        }
        param.put("totalCnt", String.valueOf(totalCnt));

        List<HashMap<String, String>> bbslist = null;
        switch(viewType) {
        case BBS_VIEW_TYPE_QNA:
        	bbslist = service.selectQnaList(param);
        	break;
        case BBS_VIEW_TYPE_FAQ:
        	bbslist = service.selectFaqList(param);
        	break;
        default:
        	bbslist = service.selectBbsList(param);
        	model.addAttribute("fixedNoticeList", service.selectBbsFixedNoticeListAll(param));
        }
 
        model.addAttribute("bbslist", bbslist);
        model.addAttribute("param", param);
        model.addAttribute("board_type", param.get("board_type"));
        model.addAttribute("notice_type", param.get("notice_type"));
        model.addAttribute("startPage", startPage);
        model.addAttribute("visiblePages", visiblePages);
        model.addAttribute("totalCnt", String.valueOf(totalCnt));
        model.addAttribute("totalPages", String.valueOf(CommonUtil.getTotalPage(totalCnt,Integer.parseInt(visiblePages))));

	}	
}
