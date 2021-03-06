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
	
	//?????? ???????????????
	@RequestMapping(value = "/smtp/course/schedule", method = RequestMethod.GET)
	public String rainbow_schedule() {
				
		logger.info("?????? ??????????????? ????????? ?????? ???????????? ??????");

		logger.info("?????? ??????????????? ????????? ?????? ???????????? ??????");
		
		return "/segroup/society/smtp/course/rainbow_schedule";
	}
	/* ----------------------------------smtp-SC ?????? ???????????? ?????? ---------------------------------------------*/
	
	@RequestMapping(value = "/smtp/course/scmaster/scmaster-info", method = {RequestMethod.POST, RequestMethod.GET})
	public String scInfo(String course_id, Model model,HttpServletRequest request) {
				
		logger.info("?????? - SC ???????????? ????????? ?????? ???????????? ??????");
		
		model.addAttribute("courseInfo", courseService.selectCourseDetail(course_id));
		model.addAttribute("chapterInfo", courseService.selectCourseChapterListAll(course_id));		
		
		String url = "segroup/society/smtp/course/scmaster/" + course_id;

		logger.info("?????? - SC ???????????? ????????? ?????? ???????????? ???");
		
		return url;
	}
		
	/* ----------------------------------smtp-SC ?????? ???????????? ?????? ---------------------------------------------*/
	
	/* ----------------------------------smpt-sort-term ?????? ???????????? ?????? ---------------------------------------------*/

	
	@RequestMapping(value = "/smtp/course/short-term/short-term-info", method = {RequestMethod.POST, RequestMethod.GET})
	public String shortTermInfo(String course_id, Model model,HttpServletRequest request) {
				
		logger.info("?????? - short-term ???????????? ????????? ?????? ???????????? ??????");

		model.addAttribute("courseInfo", courseService.selectCourseDetail(course_id));
		String url = "segroup/society/smtp/course/short-term/" + course_id;
		
		logger.info("?????? - short-term ???????????? ????????? ?????? ???????????? ???");
		
		return url;
	}
	
/* ----------------------------------smpt-new-rainbow ?????? ???????????? ?????? ---------------------------------------------*/

	
	@RequestMapping(value = "/smtp/course/new-rainbow/new-rainbow-info", method = {RequestMethod.POST, RequestMethod.GET})
	public String newRainbowInfo(String course_id, Model model,HttpServletRequest request) {
				
		logger.info("2021 Rainbow ????????? ?????? ???????????? ??????");

		String url = "segroup/society/smtp/course/new-rainbow/" + course_id;
		
		logger.info("2021 Rainbow ????????? ?????? ???????????? ??????");
		
		return url;
	}
	
	/* ----------------------------------?????? ??????????????? ?????? ?????? ????????? ??????---------------------------------------------*/
	
	@RequestMapping(value = "/smtp/course/makesignature", method = RequestMethod.GET)
	public @ResponseBody HashMap<String, String> makeSignature(@RequestParam HashMap<String, String> param) {

		/* ???????????? ?????? ????????? ??????*/
		PayController pc = new PayController();

		param=pc.makeSignature(param);
		
		return param;

	}
	
	@RequestMapping(value = "/smtp/course/getUserInfo", method = RequestMethod.GET)
	public @ResponseBody Object getUserInfo(@RequestParam HashMap<String, String> param) {

		logger.info("Ajax - ???????????? Modal??? ???????????? ?????? ??????");
		HashMap<String, String> user = courseService.getUserInfo(param.get("user_id"));
		logger.info("Ajax - ???????????? Modal??? ???????????? ?????? ??????");
		return user;
	}
	
	@RequestMapping(value = "/smtp/course/pageInfo", method = RequestMethod.GET)
	public @ResponseBody Object getPagingInfo(@RequestParam HashMap<String, String> param) {

		logger.info("Ajax ????????? ???????????? ??????");

		HashMap<String, String> returnParam = new HashMap<String, String>() {};

		
		if(param.get("display_list")!=null&&!param.get("display_list").equals("")) {
			String[] display_list_split = param.get("display_list").split(",");
			for(int i = 0; i < display_list_split.length; i++) {
				String key = "display_icons_" + display_list_split[i]; 
				param.put(key, display_list_split[i]);
			}
		} else {
			System.out.println("??????????????? ????????? ????????? ??????????????? ?????? ??????");

		}
		
		// ?????? ????????? ??????
		String startPage = StringUtils.isBlank((String) param.get("startPage")) ? "1" : (String) param.get("startPage");
		// ?????? ????????? ??????
		System.out.println("startpage ?????? ??? : " + param.get("startPage"));
		System.out.println("startpage ?????? ??? : " + CommonUtil.getStart(startPage, boardPages));

		param.put("startPage", CommonUtil.getStart(startPage, boardPages));
		// ??? ??? ?????? ????????? ???????
		param.put("visiblePages", boardPages);

		try {
			// ?????? ????????? ??????
			int totalCnt = courseService.selectCourseListTotCnt(param);
			returnParam.put("totalCnt", String.valueOf(totalCnt));
			returnParam.put("totalPages",
					String.valueOf(CommonUtil.getTotalPage(totalCnt, Integer.parseInt(boardPages))));
		} catch (Exception e) {
			e.printStackTrace();
		}
		// ?????? ????????? ?????? ??????
		returnParam.put("startPage", CommonUtil.getStart(startPage, boardPages));
		returnParam.put("visiblePages", String.valueOf(boardPages));

		logger.info("Ajax ????????? ???????????? ??????");

		return returnParam;
	}
	
	@RequestMapping(value = "/smtp/course/getCardinalInfo", method = RequestMethod.GET)
	public @ResponseBody Object getCardinalInfo(@RequestParam HashMap<String, String> param, Model model) {

		logger.info("Ajax - ????????????Modal??? ???????????? ?????? ??????");

		List<HashMap<String, String>> matchedCardinals = courseService.checkCardinalMatched(param.get("course_id"));

		// ?????? ?????? ?????? ?????? ????????? ??????
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
		logger.info("Ajax - ???????????? Modal??? ???????????? ?????? ??????");
		return validCardinals;
	}
	
	@RequestMapping(value = "/smtp/course/getCompleteCondition", method = RequestMethod.GET)
	public @ResponseBody Object getCompleteCondition(@RequestParam HashMap<String, String> param) {
		
		logger.info("???????????? ????????? ?????? ???????????? ?????? ??????");
		
		HashMap<String, String> tempCardinal = new HashMap<String, String>();

		tempCardinal.put("cardinal_id", param.get("cardinal_id"));
		
		List<HashMap<String, String>>cardinalInfo = courseService.selectCardinalList(param);
		
		logger.info("???????????? ????????? ?????? ???????????? ?????? ??????");

		return cardinalInfo;
	}
	
	@RequestMapping(value = "/smtp/course/getPointInfo", method = RequestMethod.GET)
	public @ResponseBody Object getPointInfo(@RequestParam HashMap<String, String> param) {

		logger.info("Ajax - ???????????? Modal??? ???????????? ?????? ??????");
		HashMap<String, Object> userPoint = pointService.selectPointSummary(param.get("user_id"));
		logger.info("Ajax - ???????????? Modal??? ???????????? ?????? ??????");
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
		logger.info("smtp ?????? ??????");
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
		 * INIpay ?????? ?????? ??????
		 **********************************************************************************************/

		// #############################
		// ???????????? ???????????? ?????? ??????
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
		// ????????? ????????? ?????????
		// #####################
		if ("0000".equals(paramMap.get("resultCode"))) {

			// ############################################
			// 1.?????? ?????? ??? ??????(***????????? ????????????***)
			// ############################################

			String mid = paramMap.get("mid"); // ????????? ID ?????? ?????? ???????????? ??????

			//String signKey = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS"; // ???????????? ?????????
			// ???(??????????????????)
			// (?????????
			// ?????????
			// ??????)
			// !!!??????!!
			// ??????
			// ????????????
			// ????????????

			String timestamp = SignatureUtil.getTimestamp(); // util??? ?????????
			// ????????????

			String charset = "UTF-8"; // ????????????[UTF-8,EUC-KR](????????? ????????? ??????)
			String format = "NVP"; // ????????????[XML,JSON,NVP](????????? ????????? ??????)

			// ????????? noti??? ????????? ??????(????????????, ????????? ?????? ?????????, ????????? ?????????, ????????? ?????? Noti?????????)
			// ?????????
			// String notiUrl = "";

			String authToken = paramMap.get("authToken"); // ?????? ?????? tid??? ?????????
															// ?????????(????????? ????????? ??????)

			String authUrl = paramMap.get("authUrl"); // ???????????? API url(?????? ???????????????
														// ??????, ?????? ?????? ??????)

			//String netCancel = paramMap.get("netCancelUrl"); // ????????? API url (??????
																// ??????????????? ??????, ??????
																// ?????? ??????)

			// #####################
			// 2.signature ??????
			// #####################
			Map<String, String> signParam = new HashMap<String, String>();

			signParam.put("authToken", authToken); // ??????
			signParam.put("timestamp", timestamp); // ??????

			// signature ????????? ?????? (???????????? ???????????? signParam??? ????????? ????????? ????????? NVP ????????????
			// ????????? hash)
			String signature = null;
			try {
				signature = SignatureUtil.makeSignature(signParam);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			String price = ""; // ??????????????? ?????? ?????? ?????? ?????? (????????????)

			// 1. ??????????????? ????????? ??????????????? ????????? ?????? (????????????) ?????? ??????.
			// String oid = "";

			// #####################
			// 3.API ?????? ?????? ??????
			// #####################
			Map<String, String> authMap = new Hashtable<String, String>();

			authMap.put("mid", mid); // ??????
			authMap.put("authToken", authToken); // ??????
			authMap.put("signature", signature); // ??????
			authMap.put("timestamp", timestamp); // ??????
			authMap.put("charset", charset); // default=UTF-8
			authMap.put("format", format); // default=XML
			authMap.put("price", price); // ?????? (???????????????????????????)
			// ???????????? ????????? X(??????)??? ?????? cancel(??????????????????)??? ?????? ??? ??????????????? ?????????????????? ????????????.
			model.addAttribute("authMap", authMap);
			
			// 2. ??????????????? ????????? ??????????????? ????????? ?????? (????????????) ?????? ??????.
			// authMap.put("oid", oid);

			// if(null != notiUrl && notiUrl.length() > 0){
			// authMap.put("notiUrl" ,notiUrl);
			// }

			HttpUtil httpUtil = new HttpUtil();

			// #####################
			// 4.API ?????? ??????
			// #####################

			String authResultString = "";

			try {
				authResultString = httpUtil.processHTTP(authMap, authUrl);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// ############################################################
			// 5.API ???????????? ??????(***????????? ????????????***)
			// ############################################################

			String test = authResultString.replace(",", "&").replace(":", "=").replace("\"", "").replace(" ", "")
					.replace("\n", "").replace("}", "").replace("{", "");

			Map<String, String> resultMap = new HashMap<String, String>();

			try {
				resultMap = ParseUtil.parseStringToMap(test);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} // ???????????? MAP???????????? ??????

			if ("0000".equals(resultMap.get("resultCode"))) {
				/*****************************************************************************
				 * ????????? ????????? ?????? DB??? ?????? ????????? ???????????? ?????? ???????????? ????????? ????????????.
				 * 
				 * [??????!] ??????????????? ????????? ????????? ????????? ??? ????????? DB??? ???????????? ???????????? ???????????? ????????? ????????? ?????? ????????? ???????????? ??????.
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
				resultMap.put("seq", payCrcSeq); // ?????? ?????? ??????
				resultMap.put("pay_rtn_data", test);
				resultMap.put("id", merId);
				
//				resultMap.put("pay_gb", "F0101");  LMS????????? ?????? 				 
				
				HashMap<String, String> copy = new HashMap<String, String>(resultMap);
				if (resultMap.get("payMethod").equals("VBank")) {
					if(merType.equalsIgnoreCase("short")) {	
						copy.put("seq", String.valueOf(seuService.select_pay_crc_seq(courseId, cardinalId)));
						copy.put("point", pointUse);
					}
					copy.put("status", "F0000");
					copy.put("real_pay_amount", resultMap.get("TotPrice"));
					param.put("real_payment", resultMap.get("TotPrice"));//???????????????
					param.put("payment_type", "B");//????????????
					seuService.user_pay_info(copy);
					
					if(merType.equalsIgnoreCase("short")) {
						signUp(session,param);
					}
					
					//?????? ???????????? ???????????? ?????? ?????? X
					//?????? ????????? ?????? ????????? ???????????? ????????????
					//?????? ?????? - user_id, learn_app_id, give, withdraw, note
					
					HashMap<String, String> getLearnAppParam = new HashMap<String, String>();
					getLearnAppParam.put("user_id", merId);
					getLearnAppParam.put("course_id", courseId);
					getLearnAppParam.put("cardinal_id", cardinalId);
					
					int learnAppId = courseService.selectLearnAppId(getLearnAppParam);
	
					//????????? ???????????? 0??? ?????? ????????? ???????????? ?????? ????????? ????????????.
					if(!pointUse.equals("0")) {
						Map<String, Object> pointWithdraw = new HashMap<String, Object>();
						pointWithdraw.put("user_id", merId);
						pointWithdraw.put("learn_app_id", learnAppId);
						pointWithdraw.put("give", 0);
						pointWithdraw.put("withdraw", pointUse);
						pointWithdraw.put("note", "???????????? ???????????? ??????");
						pointService.insertPoint(pointWithdraw);				
					}
				} else {
					if(merType.equalsIgnoreCase("short")) {	
						copy.put("seq", String.valueOf(seuService.select_pay_crc_seq(courseId, cardinalId)));
						copy.put("point", pointUse);
					}
					copy.put("status", "F0001");
					copy.put("real_pay_amount", resultMap.get("TotPrice"));
					param.put("real_payment", resultMap.get("TotPrice"));//???????????????
					param.put("payment_type", "C");//????????????
					seuService.user_pay_info(copy);
					
					if(merType.equalsIgnoreCase("short")) {
						signUp(session,param);
					}
					
					//?????? ????????? ?????? ????????? ???????????? ????????????
					//?????? ?????? - user_id, learn_app_id, give, withdraw, note
					
					HashMap<String, String> getLearnAppParam = new HashMap<String, String>();
					getLearnAppParam.put("user_id", merId);
					getLearnAppParam.put("course_id", courseId);
					getLearnAppParam.put("cardinal_id", cardinalId);
					
					int learnAppId = courseService.selectLearnAppId(getLearnAppParam);
					
					//????????? ???????????? 0??? ?????? ????????? ???????????? ?????? ????????? ????????????.
					if(!pointUse.equals("0")) {
						Map<String, Object> pointWithdraw = new HashMap<String, Object>();
						pointWithdraw.put("user_id", merId);
						pointWithdraw.put("learn_app_id", learnAppId);
						pointWithdraw.put("give", 0);
						pointWithdraw.put("withdraw", pointUse);
						pointWithdraw.put("note", "???????????? ???????????? ??????");
						pointService.insertPoint(pointWithdraw);				
					}
					
					Map<String, Object> pointPolicy = pointService.selectPolicyPoint();
					int pointPercentage = (int)pointPolicy.get("SAVE_LECTURE_POINT");
					String pointLectureType = (String)pointPolicy.get("SAVE_LECTURE_TYPE");
					
					//???????????? ?????? ???, ?????? ??????????????? ???????????? ??????
					//??????????????? ??????????????? ????????? 
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
					pointGive.put("note", "???????????? ?????? ???????????? ??????");
					pointService.insertPoint(pointGive);
					}
				}

//				//?????? ????????? ?????? ????????? ???????????? ????????????
//				//?????? ?????? - user_id, learn_app_id, give, withdraw, note
//
//				HashMap<String, String> getLearnAppParam = new HashMap<String, String>();
//				getLearnAppParam.put("user_id", (String)session.getAttribute("user_id"));
//				getLearnAppParam.put("course_id", courseId);
//				getLearnAppParam.put("cardinal_id", cardinalId);
//				
//				int learnAppId = courseService.selectLearnAppId(getLearnAppParam);				
//
//				
//				//????????? ???????????? 0??? ?????? ????????? ???????????? ?????? ????????? ????????????.
//				if(!pointUse.equals("0")) {
//					Map<String, Object> pointWithdraw = new HashMap<String, Object>();
//					pointWithdraw.put("user_id", (String)session.getAttribute("user_id"));
//					pointWithdraw.put("learn_app_id", learnAppId);
//					pointWithdraw.put("give", 0);
//					pointWithdraw.put("withdraw", pointUse);
//					pointWithdraw.put("note", "???????????? ???????????? ??????");
//					pointService.insertPoint(pointWithdraw);				
//				}
//				Map<String, Object> pointPolicy = pointService.selectPolicyPoint();
//				int pointPercentage = (int)pointPolicy.get("SAVE_LECTURE_POINT");
//				
//				//???????????? ?????? ???, ?????? ??????????????? ???????????? ??????
//				//??????????????? ??????????????? ????????? 
//				Map<String, Object> pointGive = new HashMap<String, Object>();
//				pointGive.put("user_id", (String)session.getAttribute("user_id"));
//				pointGive.put("learn_app_id", learnAppId);
//				pointGive.put("give", (Integer.parseInt(resultMap.get("TotPrice"))/100) * pointPercentage);
//				pointGive.put("withdraw", 0);
//				pointGive.put("note", "???????????? ?????? ???????????? ??????");
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
				// ????????????
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
		
		logger.info("???????????? ?????? ??????");

//		param.put("user_id", (String)session.getAttribute("user_id"));
		
		if(param.get("payment_type").equals("B")) {
			param.put("payment_state", "1"); //????????????
			
		}else if(param.get("payment_type").equals("C")) {
			param.put("payment_state", "2"); //????????????
		}
		try {
			int result = courseService.insertApply(param);
			
			//????????????
			List<HashMap<String, String>> chapList = courseService.getChapPage(param);
			if(chapList == null || chapList.size() == 0) {
				chapList = courseService.getChapPage2(param);
			}
			//???????????? ?????? ??????
			courseService.insertAttLec(param, chapList);
			if(result!=0) {
				System.out.println("???????????? ??????");
			} else {
				System.out.println("???????????? ??????");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		logger.info("Ajax - ???????????? ?????? ???");
		return false;
	}
}
