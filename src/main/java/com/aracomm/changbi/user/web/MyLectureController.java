package com.aracomm.changbi.user.web;

import java.util.HashMap;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aracomm.base.common.FileDownloadView;
import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.base.common.vo.FileVo;
import com.aracomm.changbi.mypage.service.LectureService;
import com.aracomm.changbi.user.service.MyLectureService;
import com.aracomm.changbi.user.service.UserService;
import com.aracomm.changbi.user.vo.SurveyAnswerVO;
import com.google.gson.Gson;

@Controller
public class MyLectureController {
	
	private static final Logger logger = LoggerFactory.getLogger(MyLectureController.class);
	
	@Autowired
	private MyLectureService service;
	@Autowired
	private LectureService lecService;
	@Autowired
	private UserService userService;
	
	@Value("#{config['boardPages']}")
	String boardPages;
	
	@RequestMapping(value = "lms/user/sub07-01{page}", method = RequestMethod.GET)
	public String sub07_01_01(Authentication auth, @PathVariable("page") String page, @RequestParam HashMap<String,Object> params, HttpSession session, Model model ) {
		logger.info("학습현황-학습중 페이지 이동 컨트롤러 시작");
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id",user_id);
		
		String startPage = StringUtils.isBlank((String) params.get("startPage")) ? "1" : (String) params.get("startPage");
		model.addAttribute("startPage",  CommonUtil.getStart(startPage, boardPages));
		model.addAttribute("search", params.get("search"));
		logger.info("학습현황-학습중 페이지 이동 컨트롤러 종료");
		return "/lms/user/sub07-01"+page;
	}
	@RequestMapping(value="lms/user/sub07-01-01-list", method = RequestMethod.GET)
	public @ResponseBody Object sub07_01_01_list (Authentication auth,@RequestParam HashMap<String,Object> params, HttpSession session) {
		
		logger.info("학습현황 리스트 가져오는 컨트롤러 시작");
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id",user_id);
		
		//시작 페이지 객체
		String startPage = StringUtils.isBlank((String) params.get("startPage")) ? "1" : (String) params.get("startPage");
		// 시작 페이지 설정
		params.put("startPage", CommonUtil.getStart(startPage, boardPages));
		// 볼 수 있는 페이지 설정
		params.put("visiblePages", boardPages);
		
		int listNum = Integer.parseInt((String) params.get("listNum"));
		
		HashMap<String, List<HashMap<String,Object>>> result = new HashMap<String, List<HashMap<String,Object>>>();
		
		if(listNum == 0) {
			List<HashMap<String,Object>> progressList = service.selectProgressList(params);
			result.put("progressList", progressList);
		} else if (listNum == 1) {
			List<HashMap<String,Object>> waitingList = service.selectWaitingList(params);
			result.put("waitingList", waitingList);
		} else if (listNum == 2) {
			List<HashMap<String,Object>> completeList = service.selectCompleteList(params);
			result.put("completeList", completeList);
		}
		
		return result;
	}
	@RequestMapping(value = "lms/lecture/pageInfo", method = RequestMethod.GET)
	public @ResponseBody Object getPagingInfo(@RequestParam HashMap<String, Object> param, HttpSession session) {
		logger.info("Ajax 페이징 정보처리 시작");
		
		HashMap<String, Object> returnParam = new HashMap<String, Object>();
		
		//시작 페이지 객체
		String startPage = StringUtils.isBlank((String)param.get("startPage")) ? "1" : (String)param.get("startPage");
		param.put("startPage", CommonUtil.getStart(startPage, boardPages));
		// 볼 수 있는 페이지 설정
		param.put("visiblePages", boardPages);
		String user_id = (String) session.getAttribute("user_id");
		param.put("user_id", user_id);
		
		int listNum = Integer.parseInt((String) param.get("listNum"));
		try {
			int totalCnt = 0;
			if(listNum == 0) {
				totalCnt = service.selectProgressListTotalCnt(param);
			} else if (listNum == 1) {
				totalCnt = service.selectWaitingListTotalCnt(param);
			} else if (listNum == 2) {
				totalCnt = service.selectCompleteListTotalCnt(param);
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
	
	@RequestMapping(value="lms/user/getLessonInfo", method = RequestMethod.GET)
	public @ResponseBody Object AjaxGetLessonInfo(Authentication auth, @RequestParam HashMap<String, String> param) {
		logger.info("모달 창 차시 정보 탭 이동 컨트롤러 시작");
		String user_id = (auth!=null ? auth.getName() : null);
		param.put("user_id",user_id);

			List<HashMap<String,Object>> result = service.selectChapterList(param);
		// 테스트용
		/*
		 * for (int i = 0; i < result.size(); i++) { for (Entry<String, Object> map :
		 * result.get(i).entrySet()) { System.out.println(String.format("키: %s, 값 : %s",
		 * map.getKey(),map.getValue()));
		 * 
		 * } }
		 */
		 
		logger.info("모달 창 차시 정보 탭 이동 컨트롤러 종료");
		return result;
	}
	
	@RequestMapping(value="lms/user/getLessonInfo2", method = RequestMethod.GET)
	public @ResponseBody Object AjaxGetLessonInfo2(Authentication auth, @RequestParam HashMap<String, String> param) {
		logger.info("모달 창 차시 정보 탭 이동 컨트롤러 시작");
		String user_id = (auth!=null ? auth.getName() : null);
		param.put("user_id",user_id);

		List<HashMap<String,Object>> result = service.selectChapPageList(param);
		
		logger.info("모달 창 차시 정보 탭 이동 컨트롤러 종료");
		return result;
	}
	
	@RequestMapping(value="lms/user/courseBoardList", method = RequestMethod.GET)
	public @ResponseBody Object AjaxcourseBoardList(Authentication auth, @RequestParam HashMap<String,Object> params) {
		logger.info("모달 창 과정 공지사항 탭 이동 컨트롤러 시작");
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id",user_id);
		List<HashMap<String,Object>> bList = service.courseBoardList(params);
		logger.info("모달 창 과정 공지사항 탭 이동 컨트롤러 종료");
		logger.info("size:: "+bList.size());
		return bList;
	}
	
	@RequestMapping(value="lms/user/surveyList", method = RequestMethod.GET)
	public @ResponseBody Object AjaxSurveyList(Authentication auth, @RequestParam HashMap<String,Object> params) {
		logger.info("모달 창 과정 설문조사 탭 이동 컨트롤러 시작");
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id",user_id);
		List<HashMap<String,Object>> sList = service.surveyList(params);
		logger.info("모달 창 과정 설문조사 탭 이동 컨트롤러 종료");
		return sList;
	}
	
	@RequestMapping(value="lms/user/attendanceList", method = RequestMethod.GET)
	public @ResponseBody Object AjaxAttendanceList(Authentication auth, @RequestParam HashMap<String,Object> params) {
		logger.info("모달 창 과정 출결 탭 이동 컨트롤러 시작");
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id",user_id);
		List<HashMap<String,Object>> aList=service.attendanceList(params);
		logger.info("모달 창 과정 출결 탭 이동 컨트롤러 종료");
		return aList;
	}
	
	@RequestMapping(value="lms/user/downloadFile", method = RequestMethod.GET)
	public FileDownloadView downloadFile(HttpServletRequest Request, String file_1, String file_2, Model model) {
		logger.info("파일 다운로드를 위한 정보 가져오기 시작");
		System.out.println(file_1);
		FileVo vo = service.attachFileInfo(file_1);
		model.addAttribute("fv", vo);
		return new FileDownloadView();
	}
	
	@RequestMapping(value="lms/user/selectExamList", method=RequestMethod.GET)
	public @ResponseBody Object AjaxSelectExamList(@RequestParam HashMap<String, Object> param, Authentication auth) {
		logger.info("모달 창 과정기수 과제/시험 정보 컨트롤러 시작");
		String user_id = (auth!=null ? auth.getName() : null);
		param.put("user_id", user_id);
		List<HashMap<String,Object>> list = lecService.selectExamList(param);
		logger.info("모달 창 과정기수 과제/시험 정보 컨트롤러 종료");
		return list;
	}
	
	
	@RequestMapping(value="lms/user/insertAttLec", method = RequestMethod.GET)
	public @ResponseBody int insertAttLec(Authentication auth, @RequestParam HashMap<String, Object> param) {
		logger.info("수강이력 등록 컨트롤러 시작");
		String user_id = (auth!=null ? auth.getName() : null);
		param.put("user_id", user_id);

		service.insertStudyHistory(param);
		 
		logger.info("수강이력 등록 컨트롤러 종료");
		
		return 1;
	}
	
	@RequestMapping(value="lms/user/player")
	public String report(Authentication auth, Model model,HttpServletRequest request, @RequestParam HashMap<String,Object> params ) {
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id", user_id);
		String user_ip = userService.getClintIp(request);

		HashMap<String,Object> result = service.selectChapterInfo(params);
		result.put("user_id", user_id);
		result.put("user_ip", user_ip);
		
		service.insertAttLecHistory(result);
//		if (result.get("PROG_YN").equals("N")) {
//			System.out.println("수강기록 등록");
//			params.put("study", result.get("study"));
//			params.put("chk", result.get("chk"));
//			params.put("progYn", "Y");
//			params.put("chasi", result.get("order_num"));
//			
//			service.insertStudyHistory(params);
//		}
		
		String course_id = (String)result.get("COURSE_ID");
		String cardinal_id = (String)result.get("CARDINAL_ID");
		
		//운영서버 : http://www.softsociety.net/lms/lmsmedia/ + course_id + filepath
		String main_domain = "http://www.softsociety.net/lms/lmsmedia/";
		
		String main_url = "";
		String mobile_url = "";
		
		//컨텐츠 url 세팅
		if(result.get("MAIN_URL") == null) { //포팅방식일 경우
			main_url = main_domain + course_id + (String)result.get("FILEPATH");
//			mobile_url = (String)result.get("MO_FILEPATH");
		} else { //링크방식일 경우
			main_url = (String)result.get("MAIN_URL");
			mobile_url = (String)result.get("MOBILE_URL");
		}
		result.put("MAIN_URL", main_url);
		result.put("MOBILE_URL", mobile_url);
		
		// 다락원 	링크과정일 경우 추가 파라미터를 세팅해준다.
		// 아이디, 과정코드, 기수코드
		if (main_url.contains("{user_id}")) {
			main_url = main_url.replaceAll("\\{user_id\\}", user_id);
			mobile_url = mobile_url.replaceAll("\\{user_id\\}", user_id);
			result.put("MAIN_URL", main_url + "&course_id=" + course_id + "&cardinal_id=" + cardinal_id);
			result.put("MOBILE_URL", mobile_url + "&course_id=" + course_id + "&cardinal_id=" + cardinal_id);
			result.put("DARAKWON", "Y");
		}
		params.put("att_id", result.get("ID"));
		model.addAttribute("classParam", params);
		model.addAttribute("chapterInfo", result);

		return "/lms/user/player";
	}
	
	//수강처리(포팅)
	@ResponseBody
	@RequestMapping(value="/lms/user/setProgYn", method = RequestMethod.POST)
	public void setProgYn(Authentication auth, @RequestParam HashMap<String,Object> params) {
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,Object> result = service.selectChapterInfo(params);

		if (result.get("PROG_YN").equals("N")) {
			System.out.println("수강기록 등록");
//			params.put("study", result.get("study"));
//			params.put("chk", result.get("chk"));
//			params.put("progYn", "Y");
//			params.put("chasi", result.get("order_num"));
			params.put("subchap", result.get("SEQ"));
			service.setProgYn(params);
		}
	}
	//수강처리(링크)
	@ResponseBody
	@RequestMapping(value="/lms/user/setProgYnLink", method = RequestMethod.POST)
	public void setProgYnLink(Authentication auth, @RequestParam HashMap<String,Object> params) {
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id", user_id);
		HashMap<String,Object> result = service.selectChapterInfo(params);
		service.setProgYnLink(result);
	}
	
	@RequestMapping(value="lms/user/oneplayer", method = RequestMethod.POST)
	public String reportPlayer(Authentication auth, Model model, @RequestParam String url ) {
		
		System.out.println("플레이어로");
		
		model.addAttribute("url", url);

		return "/lms/user/oneplayer";
	}
	
	/*
	 * 다락원 링크과정 유효성 체크
	 */
	@RequestMapping(value="lms/user/darakwon", method = RequestMethod.GET)
	public @ResponseBody String darakwon(HttpServletRequest request, HttpServletResponse response) {
		// 다락원에서 넘어온 파라미터 값 받기
		String user_id = request.getParameter("mid");
		String course_id = request.getParameter("course_id");
		String cardinal_id = request.getParameter("cardinal_id");
		
		// 유효성 검증에 필요한 값을 가지고 입과확인
		// 아이디, 과정코드, 과정기수코드
		HashMap<String, String> hmap = new HashMap<String, String>();
		hmap.put("user_id", user_id);
		hmap.put("course_id", course_id);
		hmap.put("cardinal_id", cardinal_id);
		
		String result = "0000";
		
		HashMap<String, String> learn = service.learnCheck(hmap);
		if (learn != null) {
			result = "1111|" + learn.get("LEARN_START_DATE") + "|" + learn.get("LEARN_END_DATE");
		}
		
		return result;
	}
	
	@RequestMapping(value="popup/lmsReport")
	public void popupReport(Authentication auth, @RequestParam HashMap<String,Object> params, Model model) {
		logger.info("lms 과제 창 로드 시작");
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id",user_id);
		
		logger.info("tags = " + params.toString());
		
		HashMap<String,Object> result = new HashMap<>();
		
		HashMap<String, Object> examInfo = lecService.selectExamInfo(params);
		List<HashMap<String, Object>> list = lecService.selectExamItemList(params);
		
		logger.info("examInfo " + examInfo.toString());
		logger.info("list " + list.toString());
		
		result.put("examInfo", examInfo);
		result.put("list", list);	

		String takeYn =String.valueOf(params.get("takeYn"));
		
		logger.info("takeYn " + takeYn);
		
		if(takeYn.equalsIgnoreCase("1")) {
			HashMap<String, Object> reportInfo = lecService.selectReportInfo(params);
			params.put("report_id", reportInfo.get("ID"));
			List<HashMap<String, Object>> replyList = lecService.selectExamReplyList(params);
			result.put("reply", replyList);
			logger.info("list " + replyList.toString());
		}
		
		//lecService
		model.addAttribute("params", params);
		model.addAttribute("result", result);
		logger.info("lms 과제 창 로드 종료");
	}
	@RequestMapping(value="popup/lmsExam")
	public void popupExam(Authentication auth, @RequestParam HashMap<String,Object> params, Model model) {
		logger.info("lms 시험 창 로드 시작");
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id",user_id);
		
		logger.info("tags = " + params.toString());
		
		HashMap<String,Object> result = new HashMap<>();
		
		HashMap<String, Object> examInfo = lecService.selectExamInfo(params);
		List<HashMap<String, Object>> list = lecService.selectExamItemList(params);
		
		logger.info("examInfo = " + examInfo.toString());
		logger.info("list = " + list.toString());
		
		// 응시횟수 조회 및 응시내역 등록
		if (list != null && list.size() > 0) {
			examInfo.put("TAKE_COUNT", lecService.selectExamTakeCount(params));
		} else {
			examInfo.put("TAKE_COUNT", 0);
		}

		result.put("examInfo", examInfo);
		result.put("list", list);
		
		if(!String.valueOf(examInfo.get("TAKE_COUNT")).equalsIgnoreCase("0")) {
			HashMap<String, Object> reportInfo = lecService.selectReportInfo(params);
			params.put("report_id", reportInfo.get("ID"));
			List<HashMap<String, Object>> replyList = lecService.selectExamReplyList(params);
			
			result.put("replyList", replyList);
		}
		
		//lecService
		model.addAttribute("params", params);
		model.addAttribute("result", result);
		logger.info("lms 시험 창 로드 종료");
	}
	
	@RequestMapping(value="popup/lmsSurveyDetail")
	public void popupSurveyDetail(Authentication auth, @RequestParam HashMap<String,Object> params, Model model) {
		logger.info("lms 설문조사 내용 로드 시작");
		
		String user_id = (auth != null ? auth.getName() : null);
		params.put("user_id", user_id);
		
		List<HashMap<String, Object>> surveyDetail = lecService.selectSurveyDetail(params);
		Gson gson = new Gson();
		
		model.addAttribute("info", params);
		model.addAttribute("surveyDetail", gson.toJson(surveyDetail));
		logger.info("lms 설문조사 내용 로드 종료");
	}
	
	@ResponseBody
	@RequestMapping(value = "popup/lmsInsertSurveyAnswer", method = RequestMethod.POST)
	public boolean popupInsertSurveyAnswer(Authentication auth, @RequestBody List<SurveyAnswerVO> list) {
		logger.info("설문조사 답변 제출 컨트롤러 시작");
		boolean result = false;
		String user_id = (auth!=null ? auth.getName() : null);
		
		if(user_id != null) {
			for(SurveyAnswerVO vo : list) vo.setUser_id(user_id);
			
			if(lecService.insertSurveyAnswer(list) == list.size()) {
				if(lecService.insertSurveyComplete(list.get(0)) == 1)
					result = true;
			}
		}
		logger.info("설문조사 답변 제출 컨트롤러 종료");
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "popup/lmsUpdateSurveyAnswer", method = RequestMethod.POST)
	public boolean popupUpdateSurveyAnswer(Authentication auth, @RequestBody List<SurveyAnswerVO> list) {
		logger.info("설문조사 답변 수정 컨트롤러 시작");
		boolean result = false;
		String user_id = (auth!=null ? auth.getName() : null);
		
		if(user_id != null) {
			for(SurveyAnswerVO vo : list) vo.setUser_id(user_id);
			
			if(lecService.updateSurveyAnswer(list) == 1)
				result = true;
		}
		logger.info("설문조사 답변 수정 컨트롤러 종료");
		return result;
	}
}
