package global.segroup.society.smtp.course.web;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.changbi.learn.web.PayController;
import com.aracomm.changbi.mypage.service.PointService;
import com.inicis.std.util.HttpUtil;
import com.inicis.std.util.ParseUtil;
import com.inicis.std.util.SignatureUtil;

import global.segroup.society.edu.user.service.SocietyEduUserService;
import global.segroup.society.smtp.apply.dao.SocietyStudentApplyDAO;
import global.segroup.society.smtp.course.service.SmtpCourseService;

@Controller
public class SmtpCourseController {
	
	private static final Logger logger = LoggerFactory.getLogger(SmtpCourseController.class);
	
	@Autowired
	SmtpCourseService courseService;
	
	@Autowired
	private PointService pointService;
	
	@Autowired
	SocietyStudentApplyDAO dao;
	
	@Autowired
	private SocietyEduUserService seuService;
	
	@Value("#{config['boardPages']}")
	String boardPages;
	
	@RequestMapping(value="/smtp/course/availableCourse", method = RequestMethod.POST)
	public @ResponseBody Object availableCourse() {
		List<HashMap<String, Object>> result = courseService.selectAvailableCourse();
		return result;
	}
	
	//연간 교육스케줄
	@RequestMapping(value = "/smtp/course/schedule", method = RequestMethod.GET)
	public String rainbow_schedule() {
				
		logger.info("연간 교육스케줄 페이지 이동 컨트롤러 시작");

		logger.info("연간 교육스케줄 페이지 이동 컨트롤러 종료");
		
		return "/segroup/society/smtp/course/rainbow_schedule";
	}
	/* ----------------------------------smtp-SC 관련 컨트롤러 모음 ---------------------------------------------*/
	
	@RequestMapping(value = "/smtp/course/scmaster/scmaster-info", method = {RequestMethod.POST, RequestMethod.GET})
	public String scInfo(String course_id, Model model,HttpServletRequest request) {
				
		logger.info("과정 - SC 과정상세 페이지 이동 컨트롤러 시작");
		
		model.addAttribute("courseInfo", courseService.selectCourseDetail(course_id));
		model.addAttribute("chapterInfo", courseService.selectCourseChapterListAll(course_id));	
		String url = "segroup/society/smtp/course/scmaster/" + course_id;

		logger.info("과정 - SC 과정상세 페이지 이동 컨트롤러 끝");
		
		return url;
	}
		
	/* ----------------------------------smtp-SC 관련 컨트롤러 모음 ---------------------------------------------*/
	
	/* ----------------------------------smpt-sort-term 관련 컨트롤러 모음 ---------------------------------------------*/

	
	@RequestMapping(value = "/smtp/course/short-term/short-term-info", method = {RequestMethod.POST, RequestMethod.GET})
	public String shortTermInfo(String course_id, Model model,HttpServletRequest request) {
				
		logger.info("과정 - short-term 과정상세 페이지 이동 컨트롤러 시작");

		model.addAttribute("courseInfo", courseService.selectCourseDetail(course_id));
		String url = "segroup/society/smtp/course/short-term/" + course_id;
		
		logger.info("과정 - short-term 과정상세 페이지 이동 컨트롤러 끝");
		
		return url;
	}
	
/* ----------------------------------smpt-new-rainbow 관련 컨트롤러 모음 ---------------------------------------------*/

	
	@RequestMapping(value = "/smtp/course/new-rainbow/new-rainbow-info", method = {RequestMethod.POST, RequestMethod.GET})
	public String newRainbowInfo(String course_id, Model model,HttpServletRequest request) {
				
		logger.info("2021 Rainbow 페이지 이동 컨트롤러 시작");
		
		String url = "segroup/society/smtp/course/new-rainbow/" + course_id;
		
		logger.info("2021 Rainbow 페이지 이동 컨트롤러 종료");
		
		return url;
	}
	
	@RequestMapping(value = "/smtp/course/new-rainbow/course", method = {RequestMethod.POST, RequestMethod.GET})
	public String newRainbowCourseInfo(String course_id, Model model,HttpServletRequest request) {
		logger.info("2021 Rainbow Course페이지 이동 컨트롤러 시작");
		HashMap<String, String> course_info= courseService.rainbowCourseInfo(course_id);
		
		//납부 금액
		if(course_info != null) {
			String cardinal_id= course_info.get("CARDINAL_ID");
			HashMap<String, String> edu_curriculum_pay = courseService.eduCurriculumPay(cardinal_id);
			model.addAttribute("edu_curriculum_pay", edu_curriculum_pay);
		}
		
		model.addAttribute("courseInfo", course_info);
		String url = "segroup/society/smtp/course/new-rainbow/course/" + course_id;
		logger.info("2021 Rainbow Course페이지 이동 컨트롤러 종료");
		
		return url;
	}
	
	/* ----------------------------------모든 페이지에서 사용 되는 메서드 정리---------------------------------------------*/
	
	@RequestMapping(value = "/smtp/course/makesignature", method = RequestMethod.GET)
	public @ResponseBody HashMap<String, String> makeSignature(@RequestParam HashMap<String, String> param) {

		/* 이니시스 정보 인코딩 시작*/
		PayController pc = new PayController();

		param=pc.makeSignature(param);
		
		return param;

	}
	
	@RequestMapping(value = "/smtp/course/getUserInfo", method = RequestMethod.GET)
	public @ResponseBody Object getUserInfo(@RequestParam HashMap<String, String> param) {

		logger.info("Ajax - 수강신청 Modal에 회원정보 표시 시작");
		HashMap<String, String> user = courseService.getUserInfo(param.get("user_id"));
		logger.info("Ajax - 수강신청 Modal에 회원정보 표시 종료");
		return user;
	}
	
	@RequestMapping(value = "/smtp/course/pageInfo", method = RequestMethod.GET)
	public @ResponseBody Object getPagingInfo(@RequestParam HashMap<String, String> param) {

		logger.info("Ajax 페이징 정보처리 시작");

		HashMap<String, String> returnParam = new HashMap<String, String>() {};

		
		if(param.get("display_list")!=null&&!param.get("display_list").equals("")) {
			String[] display_list_split = param.get("display_list").split(",");
			for(int i = 0; i < display_list_split.length; i++) {
				String key = "display_icons_" + display_list_split[i]; 
				param.put(key, display_list_split[i]);
			}
		} else {
			System.out.println("과정리스트 페이징 세팅시 아이콘관련 세팅 안함");

		}
		
		// 시작 페이지 객체
		String startPage = StringUtils.isBlank((String) param.get("startPage")) ? "1" : (String) param.get("startPage");
		// 시작 페이지 설정
		System.out.println("startpage 받은 값 : " + param.get("startPage"));
		System.out.println("startpage 세팅 값 : " + CommonUtil.getStart(startPage, boardPages));

		param.put("startPage", CommonUtil.getStart(startPage, boardPages));
		// 볼 수 있는 페이지 설정?
		param.put("visiblePages", boardPages);

		try {
			// 전체 게시물 갯수
			int totalCnt = courseService.selectCourseListTotCnt(param);
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
	
	@RequestMapping(value = "/smtp/course/getCardinalInfo", method = RequestMethod.GET)
	public @ResponseBody Object getCardinalInfo(@RequestParam HashMap<String, String> param, Model model) {

		logger.info("Ajax - 수강신청Modal에 기수정보 표시 시작");

		List<HashMap<String, String>> matchedCardinals = courseService.checkCardinalMatched(param.get("course_id"));

		// 오늘 날짜 기준 주의 월요일 세팅
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar calToday = Calendar.getInstance();
		String today = dateFormat.format(calToday.getTime());
		
		ArrayList<HashMap<String,String>> validCardinals = new ArrayList<HashMap<String,String>>();
		
		for (HashMap<String, String> matchedOne : matchedCardinals) {
			HashMap<String, String> tempCardinal = new HashMap<String, String>();
			tempCardinal.put("today", today);
			tempCardinal.put("cardinal_id", matchedOne.get("cardinal_id"));
			
			List<HashMap<String, String>>tempList = courseService.selectCardinalList(tempCardinal);
			if(tempList.size()!=0) {
				for (int i = 0; i < tempList.size(); i++) {
					validCardinals.add(tempList.get(i));
				}
			};
		}
		logger.info("Ajax - 수강신청 Modal에 기수정보 표시 종료");
		return validCardinals;
	}
	
	@RequestMapping(value = "/smtp/course/getCompleteCondition", method = RequestMethod.GET)
	public @ResponseBody Object getCompleteCondition(@RequestParam HashMap<String, String> param) {
		
		logger.info("수료조건 세팅을 위한 기수정보 조회 시작");
		
		HashMap<String, String> tempCardinal = new HashMap<String, String>();

		tempCardinal.put("cardinal_id", param.get("cardinal_id"));
		
		List<HashMap<String, String>>cardinalInfo = courseService.selectCardinalList(param);
		
		logger.info("수료조건 세팅을 위한 기수정보 조회 종료");

		return cardinalInfo;
	}
	
	@RequestMapping(value = "/smtp/course/getPointInfo", method = RequestMethod.GET)
	public @ResponseBody Object getPointInfo(@RequestParam HashMap<String, String> param) {

		logger.info("Ajax - 수강신청 Modal에 마일리지 표시 시작");
		HashMap<String, Object> userPoint = pointService.selectPointSummary(param.get("user_id"));
		logger.info("Ajax - 수강신청 Modal에 마일리지 표시 종료");
		return userPoint;
	}
	
	@ResponseBody
	@RequestMapping(value="/smtp/course/getCourse", method=RequestMethod.GET)
	public String getCourse(String gisuId){
		
		String course = courseService.getCourse(gisuId);
		
		return course;
	}
	
	@RequestMapping(value="/smtp/course/getCourseInfo", method=RequestMethod.GET)
	public @ResponseBody HashMap<String, Object> getCourseInfo(String courseId){
		
		HashMap<String, Object> map = courseService.selectCourseDetail(courseId);
		
		return map;
	}
	
	@RequestMapping(value = "/smtp/course/checkAlreadyEnrolled", method = RequestMethod.GET)
	public @ResponseBody boolean checkAlreadyEnrolled(HttpSession session, @RequestParam HashMap<String, String> param) {
		
		boolean existOrNot = false;
		
		param.put("user_id", (String)session.getAttribute("user_id"));
		
		int result = courseService.selectEnrolledListCnt(param);

		if(result!=0) {
			existOrNot = true;
		}
		
		return existOrNot;
	}
	
	@RequestMapping(value="/smtp/course/getCardinalDetail", method=RequestMethod.GET)
	public @ResponseBody HashMap<String, Object> getCardinalDetail (String cardinalId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map = courseService.getCardinalDetail(cardinalId);
		
		return map;
	}
	
	@RequestMapping(value = "/smtp/course/payInfo", method = RequestMethod.POST)
	public View user_pay_info(Model model, HttpServletRequest request, HttpServletResponse response,
			Authentication auth, HttpSession session,@RequestParam HashMap<String,String> param) {
		String retUrl = "lms/course/foreign/sub02-01";
		
//		System.out.println("PayInfo Param Test : " + param.toString() + " MerchantData Check : " + param.get("merchantData"));
		logger.info("smtp 결제 시작");
		String cardinalId = param.get("merchantData").split(",")[0];
		String courseId = param.get("merchantData").split(",")[1];
		String pointUse = param.get("merchantData").split(",")[2];
		String payCrcSeq = param.get("merchantData").split(",")[3];
		String merPhone = param.get("merchantData").split(",")[4];
		String merEmail = param.get("merchantData").split(",")[5];
		String merId = param.get("merchantData").split(",")[6];
		String merType = param.get("merchantData").split(",")[7];
		
		param.put("cardinal_id", cardinalId);
		param.put("course_id", courseId);
		param.put("dis_point", pointUse);
		param.put("phone", merPhone);
		param.put("email", merEmail);
		param.put("user_id", merId);
		
		System.out.println(cardinalId+"!!!"+courseId);	
		
		/**********************************************************************************************
		 * INIpay 모듈 세팅 시작
		 **********************************************************************************************/

		// #############################
		// 인증결과 파라미터 일괄 수신
		// #############################
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Map<String, String> paramMap = new Hashtable<String, String>();

		Enumeration<String> elems = request.getParameterNames();

		String temp = "";

		while (elems.hasMoreElements()) {
			temp = (String) elems.nextElement();
			paramMap.put(temp, request.getParameter(temp));

		}

		// #####################
		// 인증이 성공일 경우만
		// #####################
		if ("0000".equals(paramMap.get("resultCode"))) {

			// ############################################
			// 1.전문 필드 값 설정(***가맹점 개발수정***)
			// ############################################

			String mid = paramMap.get("mid"); // 가맹점 ID 수신 받은 데이터로 설정

			//String signKey = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS"; // 가맹점에 제공된
			// 키(이니라이트키)
			// (가맹점
			// 수정후
			// 고정)
			// !!!절대!!
			// 전문
			// 데이터로
			// 설정금지

			String timestamp = SignatureUtil.getTimestamp(); // util에 의해서
			// 자동생성

			String charset = "UTF-8"; // 리턴형식[UTF-8,EUC-KR](가맹점 수정후 고정)
			String format = "NVP"; // 리턴형식[XML,JSON,NVP](가맹점 수정후 고정)

			// 추가적 noti가 필요한 경우(필수아님, 공백일 경우 미발송, 승인은 성공시, 실패시 모두 Noti발송됨)
			// 미사용
			// String notiUrl = "";

			String authToken = paramMap.get("authToken"); // 취소 요청 tid에 따라서
															// 유동적(가맹점 수정후 고정)

			String authUrl = paramMap.get("authUrl"); // 승인요청 API url(수신 받은값으로
														// 설정, 임의 세팅 금지)

			//String netCancel = paramMap.get("netCancelUrl"); // 망취소 API url (수신
																// 받은값으로 설정, 임의
																// 세팅 금지)

			// #####################
			// 2.signature 생성
			// #####################
			Map<String, String> signParam = new HashMap<String, String>();

			signParam.put("authToken", authToken); // 필수
			signParam.put("timestamp", timestamp); // 필수

			// signature 데이터 생성 (모듈에서 자동으로 signParam을 알파벳 순으로 정렬후 NVP 방식으로
			// 나열해 hash)
			String signature = null;
			try {
				signature = SignatureUtil.makeSignature(signParam);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			String price = ""; // 가맹점에서 최종 결제 가격 표기 (필수입력)

			// 1. 가맹점에서 승인시 주문번호가 변경될 경우 (선택입력) 하위 연결.
			// String oid = "";

			// #####################
			// 3.API 요청 전문 생성
			// #####################
			Map<String, String> authMap = new Hashtable<String, String>();

			authMap.put("mid", mid); // 필수
			authMap.put("authToken", authToken); // 필수
			authMap.put("signature", signature); // 필수
			authMap.put("timestamp", timestamp); // 필수
			authMap.put("charset", charset); // default=UTF-8
			authMap.put("format", format); // default=XML
			authMap.put("price", price); // 필수 (가격위변조체크기능)
			// 이니시스 창에서 X(닫기)를 눌러 cancel(결제진행취소)를 했을 때 이전창으로 돌아가기위한 정보담기.
			model.addAttribute("authMap", authMap);
			
			// 2. 가맹점에서 승인시 주문번호가 변경될 경우 (선택입력) 하위 연결.
			// authMap.put("oid", oid);

			// if(null != notiUrl && notiUrl.length() > 0){
			// authMap.put("notiUrl" ,notiUrl);
			// }

			HttpUtil httpUtil = new HttpUtil();

			// #####################
			// 4.API 통신 시작
			// #####################

			String authResultString = "";

			try {
				authResultString = httpUtil.processHTTP(authMap, authUrl);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// ############################################################
			// 5.API 통신결과 처리(***가맹점 개발수정***)
			// ############################################################

			String test = authResultString.replace(",", "&").replace(":", "=").replace("\"", "").replace(" ", "")
					.replace("\n", "").replace("}", "").replace("{", "");

			Map<String, String> resultMap = new HashMap<String, String>();

			try {
				resultMap = ParseUtil.parseStringToMap(test);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} // 문자열을 MAP형식으로 파싱

			if ("0000".equals(resultMap.get("resultCode"))) {
				/*****************************************************************************
				 * 여기에 가맹점 내부 DB에 결제 결과를 반영하는 관련 프로그램 코드를 구현한다.
				 * 
				 * [중요!] 승인내용에 이상이 없음을 확인한 뒤 가맹점 DB에 해당건이 정상처리 되었음을 반영함 처리중 에러 발생시 망취소를 한다.
				 ******************************************************************************/
				model.addAttribute("tid", resultMap.get("tid"));
				model.addAttribute("payMethod", resultMap.get("payMethod"));
				model.addAttribute("TotPrice", resultMap.get("TotPrice"));
				model.addAttribute("MOID", resultMap.get("MOID"));
				model.addAttribute("applDate", resultMap.get("applDate"));
				model.addAttribute("applTime", resultMap.get("applTime"));
				model.addAttribute("VACT_Num", resultMap.get("VACT_Num"));
				model.addAttribute("resultCode", resultMap.get("resultCode"));
				model.addAttribute("VACT_Num", resultMap.get("VACT_Num"));

				System.out.println(test);
				
//				resultMap.put("seq", paramMap.get("merchantData"));
				resultMap.put("cardinal_id", cardinalId);
				resultMap.put("course_id", courseId);
				resultMap.put("seq", payCrcSeq); // 분납 정보 번호
				resultMap.put("pay_rtn_data", test);
				resultMap.put("id", merId);
				
//				resultMap.put("pay_gb", "F0101");  LMS결제인 경우 				 
				
				HashMap<String, String> copy = new HashMap<String, String>(resultMap);
				if (resultMap.get("payMethod").equals("VBank")) {
					if(merType.equalsIgnoreCase("short")) {	
						copy.put("seq", String.valueOf(seuService.select_pay_crc_seq(courseId, cardinalId)));
						copy.put("point", pointUse);
					}
					copy.put("status", "F0000");
					copy.put("real_pay_amount", resultMap.get("TotPrice"));
					param.put("real_payment", resultMap.get("TotPrice"));//실결제금액
					param.put("payment_type", "B");//가상계좌
					seuService.user_pay_info(copy);
					
					if(merType.equalsIgnoreCase("short")) {
						signUp(session,param);
					}
					
					//입금 전이므로 마일리지 적립 처리 X
					//결제 성공과 함께 사용한 포인트는 차감하기
					//필요 칼럼 - user_id, learn_app_id, give, withdraw, note
					
					HashMap<String, String> getLearnAppParam = new HashMap<String, String>();
					getLearnAppParam.put("user_id", merId);
					getLearnAppParam.put("course_id", courseId);
					getLearnAppParam.put("cardinal_id", cardinalId);
					
					int learnAppId = courseService.selectLearnAppId(getLearnAppParam);
	
					//사용한 포인트가 0이 아닐 때에만 마일리지 차감 내역을 기록한다.
					if(!pointUse.equals("0")) {
						Map<String, Object> pointWithdraw = new HashMap<String, Object>();
						pointWithdraw.put("user_id", merId);
						pointWithdraw.put("learn_app_id", learnAppId);
						pointWithdraw.put("give", 0);
						pointWithdraw.put("withdraw", pointUse);
						pointWithdraw.put("note", "수강신청 마일리지 사용");
						pointService.insertPoint(pointWithdraw);				
					}
				} else {
					if(merType.equalsIgnoreCase("short")) {	
						copy.put("seq", String.valueOf(seuService.select_pay_crc_seq(courseId, cardinalId)));
						copy.put("point", pointUse);
					}
					copy.put("status", "F0001");
					copy.put("real_pay_amount", resultMap.get("TotPrice"));
					param.put("real_payment", resultMap.get("TotPrice"));//실결제금액
					param.put("payment_type", "C");//신용카드
					seuService.user_pay_info(copy);
					
					if(merType.equalsIgnoreCase("short")) {
						signUp(session,param);
					}
					
					//결제 성공과 함께 사용한 포인트는 차감하기
					//필요 칼럼 - user_id, learn_app_id, give, withdraw, note
					
					HashMap<String, String> getLearnAppParam = new HashMap<String, String>();
					getLearnAppParam.put("user_id", merId);
					getLearnAppParam.put("course_id", courseId);
					getLearnAppParam.put("cardinal_id", cardinalId);
					
					int learnAppId = courseService.selectLearnAppId(getLearnAppParam);
					
					//사용한 포인트가 0이 아닐 때에만 마일리지 차감 내역을 기록한다.
					if(!pointUse.equals("0")) {
						Map<String, Object> pointWithdraw = new HashMap<String, Object>();
						pointWithdraw.put("user_id", merId);
						pointWithdraw.put("learn_app_id", learnAppId);
						pointWithdraw.put("give", 0);
						pointWithdraw.put("withdraw", pointUse);
						pointWithdraw.put("note", "수강신청 마일리지 사용");
						pointService.insertPoint(pointWithdraw);				
					}
					
					Map<String, Object> pointPolicy = pointService.selectPolicyPoint();
					int pointPercentage = (int)pointPolicy.get("SAVE_LECTURE_POINT");
					String pointLectureType = (String)pointPolicy.get("SAVE_LECTURE_TYPE");
					
					//마일리지 차감 후, 결제 금액에서의 마일리지 추가
					//마일리지에 관리자에서 설정한 
					if((Integer.parseInt(resultMap.get("TotPrice"))/100)!=0) {
					Map<String, Object> pointGive = new HashMap<String, Object>();
					pointGive.put("user_id", merId);
					pointGive.put("learn_app_id", learnAppId);
					
					if(pointLectureType.equals("1")){
						pointGive.put("give", pointPercentage);
					}else{
						pointGive.put("give", (Integer.parseInt(resultMap.get("TotPrice"))/100) * pointPercentage);
					}
					
					pointGive.put("withdraw", 0);
					pointGive.put("note", "수강신청 결제 마일리지 적립");
					pointService.insertPoint(pointGive);
					}
				}

//				//결제 성공과 함께 사용한 포인트는 차감하기
//				//필요 칼럼 - user_id, learn_app_id, give, withdraw, note
//
//				HashMap<String, String> getLearnAppParam = new HashMap<String, String>();
//				getLearnAppParam.put("user_id", (String)session.getAttribute("user_id"));
//				getLearnAppParam.put("course_id", courseId);
//				getLearnAppParam.put("cardinal_id", cardinalId);
//				
//				int learnAppId = courseService.selectLearnAppId(getLearnAppParam);				
//
//				
//				//사용한 포인트가 0이 아닐 때에만 마일리지 차감 내역을 기록한다.
//				if(!pointUse.equals("0")) {
//					Map<String, Object> pointWithdraw = new HashMap<String, Object>();
//					pointWithdraw.put("user_id", (String)session.getAttribute("user_id"));
//					pointWithdraw.put("learn_app_id", learnAppId);
//					pointWithdraw.put("give", 0);
//					pointWithdraw.put("withdraw", pointUse);
//					pointWithdraw.put("note", "수강신청 마일리지 사용");
//					pointService.insertPoint(pointWithdraw);				
//				}
//				Map<String, Object> pointPolicy = pointService.selectPolicyPoint();
//				int pointPercentage = (int)pointPolicy.get("SAVE_LECTURE_POINT");
//				
//				//마일리지 차감 후, 결제 금액에서의 마일리지 추가
//				//마일리지에 관리자에서 설정한 
//				Map<String, Object> pointGive = new HashMap<String, Object>();
//				pointGive.put("user_id", (String)session.getAttribute("user_id"));
//				pointGive.put("learn_app_id", learnAppId);
//				pointGive.put("give", (Integer.parseInt(resultMap.get("TotPrice"))/100) * pointPercentage);
//				pointGive.put("withdraw", 0);
//				pointGive.put("note", "수강신청 결제 마일리지 적립");
//				pointService.insertPoint(pointGive);
				
				if(session.getAttribute("user_id") == null) {
					RedirectView redirect = new RedirectView("/rainbow?urlParam=payComplete-sessionExpire");
				    redirect.setExposeModelAttributes(false);
				    return redirect;
				}
				
				RedirectView redirect = new RedirectView("/smtp/user/sub05-04?urlParam=payComplete");
			    redirect.setExposeModelAttributes(false);
			    return redirect;
			    

			} else {
				if(session.getAttribute("user_id") == null) {
					RedirectView redirect = new RedirectView("/rainbow?urlParam=payError-sessionExpire");
				    redirect.setExposeModelAttributes(false);
				    return redirect;
				}
				// 결제오류
				model.addAttribute("errorMsg", resultMap.get("resultMsg"));
				System.out.println("*********************************"+resultMap.get("resultMsg"));
				RedirectView redirect = new RedirectView("/smtp/user/sub05-04?urlParam=payError");
			    redirect.setExposeModelAttributes(false);
			    return redirect;

			}
		}
		
		if(session.getAttribute("user_id") == null) {
			RedirectView redirect = new RedirectView("/rainbow?urlParam=payError-sessionExpire");
		    redirect.setExposeModelAttributes(false);
		    return redirect;
		}
		
		RedirectView redirect = new RedirectView("/smtp/user/sub05-04?urlParam=payError");
	    redirect.setExposeModelAttributes(false);
	    return redirect;


	}
	
	public Boolean signUp(HttpSession session,HashMap<String, String> param) {
		
		logger.info("수강신청 등록 시작");

//		param.put("user_id", (String)session.getAttribute("user_id"));
		
		if(param.get("payment_type").equals("B")) {
			param.put("payment_state", "1"); //가상계좌
			
		}else if(param.get("payment_type").equals("C")) {
			param.put("payment_state", "2"); //신용카드
		}
		try {
			int result = courseService.insertApply(param);
			
			//입과처리
			List<HashMap<String, String>> chapList = courseService.getChapPage(param);
			if(chapList == null || chapList.size() == 0) {
				chapList = courseService.getChapPage2(param);
			}
			//수강정보 이력 생성
			courseService.insertAttLec(param, chapList);
			if(result!=0) {
				System.out.println("수강신청 성공");
			} else {
				System.out.println("수강신청 실패");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		logger.info("Ajax - 수강신청 등록 끝");
		return false;
	}
}
