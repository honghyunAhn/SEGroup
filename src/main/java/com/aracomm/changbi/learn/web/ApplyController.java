package com.aracomm.changbi.learn.web;

import java.io.UnsupportedEncodingException;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Base64.Encoder;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.base.exceptions.InvalidAccessException;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.common.service.CommonService;
import com.aracomm.changbi.learn.service.ApplyService;
import com.aracomm.changbi.learn.service.CourseService;
import com.aracomm.changbi.mypage.service.PointService;
import com.aracomm.changbi.mypage.vo.CouponSearchVo;
import com.aracomm.changbi.payment.KCPConfig;
import com.aracomm.changbi.payment.KcpPaymentParam;
import com.aracomm.changbi.payment.service.KcpPaymentService;
import com.aracomm.changbi.user.service.UserService;
import com.aracomm.changbi.user.vo.UserVo;
import com.inicis.std.util.HttpUtil;
import com.inicis.std.util.ParseUtil;
import com.inicis.std.util.SignatureUtil;

@Controller
@RequestMapping(value = "/learn/apply")
public class ApplyController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(ApplyController.class);

	@Resource(name="messageSource")
	private MessageSource messageSource;

	@Value("#{servletContext.contextPath}")
	private String servletContextPath;

	@Autowired
	private ApplyService service;

	@Autowired
	private CourseService courseService;

	@Autowired
	private KcpPaymentService paymentService;

	@Autowired
	private CommonService commonService;

	@Autowired
	private UserService userService;

	@Autowired
	private PointService pointService;


	@Autowired
	KCPConfig kcpConfig;

	
	
	@RequestMapping(value = "/test")
	public String user_pay_info(Model model, HttpServletRequest request, HttpServletResponse response,
			Authentication auth) {
		
		System.out.println("111111111111111");
		String retUrl = "segroup/society/edu/user/user_pay_cancel";
		response.setCharacterEncoding("UTF-8");


		HttpSession session = request.getSession();

		/**********************************************************************************************
		 * INIpay 모듈 세팅 시작
		 **********************************************************************************************/

		// #############################
		// 인증결과 파라미터 일괄 수신
		// #############################
		try {
			request.setCharacterEncoding("euc-kr");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Map<String, String> paramMap = new Hashtable<String, String>();

		Enumeration elems = request.getParameterNames();

		String temp = "";

		while (elems.hasMoreElements()) {
			temp = (String) elems.nextElement();
			paramMap.put(temp, request.getParameter(temp));

		}
		System.out.println(paramMap.get("resultCode"));
		ByteBuffer byteBuffer = StandardCharsets.UTF_8.encode(paramMap.get("resultMsg"));
		
		System.out.println(new String(byteBuffer.array()));
		// #####################
		// 인증이 성공일 경우만
		// #####################
		if ("0000".equals(paramMap.get("resultCode"))) {

			// ############################################
			// 1.전문 필드 값 설정(***가맹점 개발수정***)
			// ############################################

			String mid = paramMap.get("mid"); // 가맹점 ID 수신 받은 데이터로 설정

			String signKey = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS"; // 가맹점에 제공된
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

			String netCancel = paramMap.get("netCancelUrl"); // 망취소 API url (수신
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
			System.out.println("!!!!!!!!!!!!!!!!");
			try {
				resultMap = ParseUtil.parseStringToMap(test);

				System.out.println(resultMap.get("resultMsg"));
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
				/*model.addAttribute("payMethod", resultMap.get("payMethod"));*/
				model.addAttribute("TotPrice", resultMap.get("TotPrice"));
				model.addAttribute("MOID", resultMap.get("MOID"));
				model.addAttribute("applDate", resultMap.get("applDate"));
				model.addAttribute("applTime", resultMap.get("applTime"));
				model.addAttribute("VACT_Num", resultMap.get("VACT_Num"));
				model.addAttribute("resultCode", resultMap.get("resultCode"));
				model.addAttribute("VACT_Num", resultMap.get("VACT_Num"));

				System.out.println(test);

				resultMap.put("seq", paramMap.get("merchantData"));
				resultMap.put("pay_rtn_data", test);
				resultMap.put("id", auth.getName());

				HashMap<String, String> copy = new HashMap<String, String>(resultMap);
				if (resultMap.get("payMethod").equals("VBank")) {

					copy.put("status", "0");

				} else {

					copy.put("status", "1");
					
					//일반 회원을 재학생으로 변경
					HashMap<String, String> params = new HashMap<String, String>();
					params.put("user_id", auth.getName());
					params.put("user_flag", "A0101");
					
					
				}

				retUrl = "segroup/society/edu/user/user_pay_result";

			} else {

				// 결제오류
				System.out.println(resultMap.get("resultMsg"));
				model.addAttribute("errorMsg", resultMap.get("resultMsg"));
				retUrl = "segroup/society/edu/user/user_pay_failed";

			}
		}

		return retUrl;

	}
	
	
	/**
	 * 강의신청
	 * @param model
	 * @param param
	 * @param auth
	 * @return
	 */
	@RequestMapping(value = "/apply")
	public String apply(Model model, @RequestParam HashMap<String,String> param, HttpServletRequest request) {
		Map <String , Object> paramMap = courseService.selectCardinalCourseDetail(param); // 과정 테이블 
		String price2 = ""+paramMap.get("PRICE");
		String LEARN_START_DATE = ""+paramMap.get("LEARN_START_DATE");
		String LEARN_END_DATE = ""+paramMap.get("LEARN_END_DATE");
		
		String name = ""+paramMap.get("NAME");
		
		/* 폼 한글 깨짐 encoding*/
		Encoder encoder = Base64.getEncoder(); 
		byte[] encodedBytes = encoder.encode(name.getBytes());
		paramMap.put("NameEncode", new String(encodedBytes));
		
		
					
		/* 이니시스 결제 시작*/
		PayController pc = new PayController();
		try {
			model = pc.payInfo(model, request, price2, param.get("course_id"), "01", LEARN_START_DATE, LEARN_END_DATE);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/* 이니시스 결제 끝*/

		Authentication auth = getAuthenticationWithException();
		UserVo user = (UserVo) auth.getPrincipal();
		String user_id = user.getUsername();

		// 동일 과정 기수 중복 신청 체크
		String course_id = param.get("course_id");
		String cardinal_id = param.get("cardinal_id");
		int existCount = service.selectUserApplyCourseCount(user_id, course_id, cardinal_id);
		if (existCount > 0) {
			model.addAttribute("script", getMessageAndBackScript(getMessage(messageSource, "msg.apply.alreadyapplycourse")));
			return forward();
		}


		model.addAttribute("user", user);

		// 주문번호
		model.addAttribute("order_idx", CommonUtil.getOrderNumber(commonService.getDailySequence(GlobalConst.SEQ_NAME_ORDERNUMBER)));
		model.addAttribute("region", courseService.code(GlobalConst.CODE_GROUP_REGION));
		model.addAttribute("localEduofficeList", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_LOCAL_EDUOFFICE));
		model.addAttribute("neis_num", userService.selectUserNeisNum(user.getUsername()));	// 사용자 NEIS번호

		CouponSearchVo couponSearchVo = new CouponSearchVo();
		couponSearchVo.setUser_id(user_id);
		couponSearchVo.setCourse_id(param.get("course_id"));
		model.addAttribute("availCouponCount", pointService.selectUserCouponListTotCnt(couponSearchVo));	// 사용가능한 쿠폰수(사용자,과정)

		Map<String, Object> point = pointService.selectPointSummary(user_id);
		model.addAttribute("totalPoint", point.get("BALANCE"));	// 사용가능한 포인트
		model.addAttribute("pointPolicy", pointService.selectPolicyPoint());	// 포인트 사용 정책

		model.addAttribute("detail", paramMap);
		model.addAttribute("kcpConfig", kcpConfig);	// kcp 결제환경
		
		return "learn/apply/apply";
	}

	/**
	 * 수강 가능한 과정,기수인지 체크
	 * 이미 신청한 과정,기수이거나 연기된 과정이 존재하는지
	 * @param model
	 * @param course_id
	 * @param cardinal_id
	 * @return
	 */
	@RequestMapping(value = "/ajaxCheckApplyAvailable")
	public @ResponseBody HashMap<String, Object> ajaxCheckApplyAvailable(Model model, String course_id, String cardinal_id) {
		String user_id = getLoginUserIdWithException();

		HashMap<String, Object> result = getDefaultAjaxSuccessResult();

		result.put("AVAIL_YN", service.selectUserApplyCourseCount(user_id, course_id, cardinal_id) > 0 ? "N" : "Y");

		return result;
	}

	/**
	 * 수강신청등록
	 * @param param
	 * @param kcpPaymentParam
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/doApply", method=RequestMethod.POST)
	public String doApply(Model model, @RequestParam HashMap<String,String> param, KcpPaymentParam kcpPaymentParam, HttpServletRequest request, HttpServletResponse response) {
		String retUrl;
		
		// form 한글 깨짐 decoding
		String price2 = param.get("merchantData").split(",")[0];
		System.out.println("/doApply의 price2의 값");
		System.out.println(price2);

		String subject = param.get("merchantData").split(",")[1];

		String startDate = param.get("merchantData").split(",")[2]; //과정 startDate
		
		String endDate = param.get("merchantData").split(",")[3]; //과정 endDate
		
		String course_id = param.get("merchantData").split(",")[4];
		
		String cardinal_id = param.get("merchantData").split(",")[5];
		
		Decoder decoder = Base64.getDecoder(); 
		byte[] decodedBytes = decoder.decode(subject);

		System.out.println("디코딩 text *************************** **************************************");
		System.out.println("디코딩 text : " + new String(decodedBytes));

		response.setCharacterEncoding("UTF-8");
		
		/***************************이니시스 결제폼 이후 실제 반영위한 결과 Start*******************************/
		Map<String, String> paramMap = new Hashtable<String, String>();

		Enumeration elems = request.getParameterNames();

		String temp = "";

		while (elems.hasMoreElements()) {
			temp = (String) elems.nextElement();
			paramMap.put(temp, request.getParameter(temp));

		}
		
		Iterator<Map.Entry<String, String>> entries  = param.entrySet().iterator();
		 while(entries.hasNext()) {
			 Entry<String,String> entry = (Entry<String,String>)entries.next();
			 System.out.println("key : " + entry.getKey() + " , value : " + entry.getValue());
		 }
		 
		 			// ############################################
					// 1.전문 필드 값 설정(***가맹점 개발수정***)
					// ############################################

					String mid = paramMap.get("mid"); // 가맹점 ID 수신 받은 데이터로 설정

					String signKey = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS"; // 가맹점에 제공된
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
					
					System.out.println("******** authUrl **************************************************************");
					System.out.println(authUrl);

					String netCancel = paramMap.get("netCancelUrl"); // 망취소 API url (수신
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
					System.out.println("!!!!!!!!!!!!!!!!");
					try {
						resultMap = ParseUtil.parseStringToMap(test);

						System.out.println(resultMap.get("resultMsg"));
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} // 문자열을 MAP형식으로 파싱
					
					
					/*********************************과정신청 param 값 key,value 값 담기   Start**************************************************/
					String user_id = getLoginUserId();
					param.put("user_id", user_id);
					param.put("group_id", "0");
					param.put("cardinal_id", cardinal_id);
					param.put("course_id", course_id);
					param.put("neis_num", ""); // NEIS 개인번호
					param.put("des_num", "");	// 연수지명번호
					param.put("school_name","" );	// 학교/기관명
					param.put("tel", ""); // 연락처
					param.put("phone", resultMap.get("buyerTel"));	// 핸드폰
					param.put("email", resultMap.get("buyerEmail")); // 이메일
					param.put("region_code", ""); // 지역 시도 교육청 분류코드
					param.put("jurisdiction", ""); // 관할교육청
					param.put("s_type", "");	// 학교구분
					param.put("e_type", "");	// 설립구분
					param.put("post_type", "");	// 우편수령지
					String payment_type = resultMap.get("payMethod");
					if(resultMap.get("payMethod").equals("Card")) {
						payment_type = "4"; //  신용카드
					}else {
						payment_type = "3"; // 미결제 무통장 입금(가상계좌)
					}
					param.put("payment_type", payment_type); // 결제수단
					String payment_state = "1"; // 기본 1. 미결제 
					if(payment_type.equals("4")) { // 신용카드 일때 
						payment_state = "2"; // 1. 미결제 2 결제완료 \
					} else {
						payment_state = "1"; // 가상계좌의 경우 미결제 확인 이후 결제완료로 
					}
					param.put("payment_state", payment_state);	// 결제상태(1:미결제, 2:결제완료, 3:일부결제, 4:환불)',
					param.put("payment_date", "");	// 결제확인일시
					param.put("order_idx", resultMap.get("MOID"));	//  주문번호
					param.put("app_num", resultMap.get("applNum"));	// 승인번호(결제수단에 따라 미전송)
					param.put("coupon_num", "");	// 쿠폰번호
					param.put("dis_coupon", "0");	// 쿠폰할인금액
					param.put("dis_point", "0");	//포인트할인금액
					param.put("dis_group", "0");	// 단체할인금액 
					param.put("payment", resultMap.get("TotPrice"));	// 결제금액
					param.put("real_payment", resultMap.get("TotPrice"));	//  실납임금액
					param.put("reg_user", "");	// 등록일자
					/*********************************과정신청 param 값 key,value 값 담기  	End**************************************************/
					
					
					/**********************************결제테이블 VO *****************************************************************************/
					//*`ID` int(12) NOT NULL AUTO_INCREMENT COMMENT '결제 ID',
					kcpPaymentParam.setReq_tx("null"); 	// 요청구분 (고정값)  `REQ_TX` varchar(10) NOT NULL COMMENT '요청구분',
					kcpPaymentParam.setUse_pay_method(resultMap.get("payMethod"));  // `USE_PAY_METHOD` varchar(20) NOT NULL COMMENT '사용결제수단',
					kcpPaymentParam.setBsucc(""); 		//`BSUCC` varchar(20) DEFAULT NULL COMMENT '업체DB정상처리완료여부',
					kcpPaymentParam.setRes_cd(paramMap.get("resultCode")); // `RES_CD` varchar(10) DEFAULT NULL COMMENT '결과코드',
					kcpPaymentParam.setRes_msg(resultMap.get("resultMsg"));// `RES_MSG` varchar(200) DEFAULT NULL COMMENT '결과메시지',
					kcpPaymentParam.setAmount(resultMap.get("TotPrice"));// `AMOUNT` int(10) DEFAULT NULL COMMENT '금액',
					kcpPaymentParam.setOrdr_idxx(resultMap.get("MOID"));// `ORDR_IDXX` varchar(50) NOT NULL COMMENT '주문번호', 
					kcpPaymentParam.setTno(resultMap.get("tid"));// `TNO` varchar(20) DEFAULT NULL COMMENT '이니시스거래번호', // resultMap.get("tid")  
					kcpPaymentParam.setGood_mny(resultMap.get("TotPrice"));// `GOOD_MNY` int(10) NOT NULL COMMENT '결제금액',
					kcpPaymentParam.setGood_name(subject);// `GOOD_NAME` varchar(500) DEFAULT NULL COMMENT '상품명',
					kcpPaymentParam.setBuyr_name(resultMap.get("buyerName"));// `BUYR_NAME` varchar(50) NOT NULL COMMENT '구매자명',
					kcpPaymentParam.setBuyr_tel1("");// `BUYR_TEL1` varchar(30) DEFAULT NULL COMMENT '구매자전화번호',
					kcpPaymentParam.setBuyr_tel2(resultMap.get("buyerTel"));// `BUYR_TEL2` varchar(30) DEFAULT NULL COMMENT '구매자휴대폰번호',
					kcpPaymentParam.setBuyr_mail(resultMap.get("buyerEmail"));//BUYR_MAIL` varchar(100) DEFAULT NULL COMMENT '구매자EMAIL',
					kcpPaymentParam.setApp_time(resultMap.get("applTime "));//`APP_TIME` varchar(20) DEFAULT NULL COMMENT '승인시간',
					kcpPaymentParam.setCard_cd(resultMap.get("CARD_Code"));//`CARD_CD` varchar(10) DEFAULT NULL COMMENT '신용카드-카드코드',
					kcpPaymentParam.setCard_name(resultMap.get("CARD_BankC ode"));//`CARD_NAME` varchar(40) DEFAULT NULL COMMENT '신용카드-카드발급사',
					kcpPaymentParam.setApp_no(resultMap.get("applNum"));//`APP_NO` varchar(20) DEFAULT NULL COMMENT '신용카드-승인번호',
					kcpPaymentParam.setNoinf("");//`NOINF` varchar(10) DEFAULT NULL COMMENT '신용카드-무이자여부',
					kcpPaymentParam.setQuota("");//`QUOTA` varchar(10) DEFAULT NULL COMMENT '신용카드-할부개월',
					kcpPaymentParam.setPartcanc_yn("");//`PARTCANC_YN` varchar(10) DEFAULT NULL COMMENT '신용카드-부분취소가능여부',
					kcpPaymentParam.setBank_name("");//`BANK_NAME` varchar(30) DEFAULT NULL COMMENT '계좌이체-은행명',
					kcpPaymentParam.setBank_code("");//`BANK_CODE` varchar(30) DEFAULT NULL COMMENT '계좌이체-은행코드',
					kcpPaymentParam.setBk_mny("");//`BK_MNY` varchar(50) DEFAULT NULL COMMENT '계좌이체-결제금액',
					kcpPaymentParam.setBankname(resultMap.get("vactBankName"));//`BANKNAME` varchar(50) DEFAULT NULL COMMENT '가상계좌-입금할은행',
					kcpPaymentParam.setDepositor(resultMap.get("VACT_Name"));//`DEPOSITOR` varchar(50) DEFAULT NULL COMMENT '가상계좌-입금할계좌예금주',
					kcpPaymentParam.setAccount(resultMap.get("VACT_Num"));//`ACCOUNT` varchar(50) DEFAULT NULL COMMENT '가상계좌-입금할계좌번호',
					kcpPaymentParam.setVa_date("");//`VA_DATE` varchar(30) DEFAULT NULL COMMENT '가상계좌-가상계좌입금마감시간',
					kcpPaymentParam.setPnt_issue("");//`PNT_ISSUE` varchar(20) DEFAULT NULL COMMENT '공통-포인트서비스사',
					kcpPaymentParam.setPnt_amount("0");//`PNT_AMOUNT` int(10) DEFAULT NULL COMMENT '포인트-적립금액/사용금액',
					kcpPaymentParam.setPnt_app_time("");//`PNT_APP_TIME` varchar(20) DEFAULT NULL COMMENT '포인트-승인시간',
					kcpPaymentParam.setPnt_app_no("");//`PNT_APP_NO` varchar(20) DEFAULT NULL COMMENT '포인트-승인번호',
					kcpPaymentParam.setAdd_pnt("0");//`ADD_PNT` int(10) DEFAULT NULL COMMENT '포인트-발생포인트',
					kcpPaymentParam.setUse_pnt("0");//`USE_PNT` int(10) DEFAULT NULL COMMENT '포인트-사용가능포인트',
					kcpPaymentParam.setRsv_pnt("0");//`RSV_PNT` int(10) DEFAULT NULL COMMENT '포인트-적립포인트',
					kcpPaymentParam.setCommid("");//`COMMID` varchar(20) DEFAULT NULL COMMENT '휴대폰-통신사코드',
					kcpPaymentParam.setMobile_no("");//`MOBILE_NO` varchar(30) DEFAULT NULL COMMENT '휴대폰-휴대폰번호',
					kcpPaymentParam.setTk_van_code("");//`TK_VAN_CODE` varchar(20) DEFAULT NULL COMMENT '상품권-발급사코드',
					kcpPaymentParam.setTk_app_no("");//`TK_APP_NO` varchar(20) DEFAULT NULL COMMENT '상품권-승인번호',
					kcpPaymentParam.setCash_yn("");//`CASH_YN` varchar(10) DEFAULT NULL COMMENT '현금영수증-등록여부',
					kcpPaymentParam.setCash_authno("");//`CASH_AUTHNO` varchar(20) DEFAULT NULL COMMENT '현금영수증-승인번호',
					kcpPaymentParam.setCash_tr_code("");//`CASH_TR_CODE` varchar(10) DEFAULT NULL COMMENT '현금영수증-발행구분',
					kcpPaymentParam.setCash_id_info("");//`CASH_ID_INFO` varchar(20) DEFAULT NULL COMMENT '현금영수증-등록번호',
					kcpPaymentParam.setCash_no("");//`CASH_NO` varchar(20) DEFAULT NULL COMMENT '현금 영수증-거래 번호',
					kcpPaymentParam.setReg_user(user_id);//`REG_USER` varchar(100) DEFAULT NULL COMMENT '등록자 ID',
					//`IPGM_NAME` varchar(60) DEFAULT NULL COMMENT '가상계좌입금통보-주문자명',
					//`REMITTER` varchar(50) DEFAULT NULL COMMENT '가상계좌입금통보-실입금자명',
					//`IPGM_MNYX` varchar(20) DEFAULT NULL COMMENT '가상계좌입금통보-입금액',
					//`IPGM_TIME` varchar(20) DEFAULT NULL COMMENT '가상계좌입금통보-입금시간',
					//`OP_CD` varchar(50) DEFAULT NULL COMMENT '가상계좌입금통보-처리구분 코드',
					//`REG_DATE` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
					//`UPD_USER` varchar(100) DEFAULT NULL COMMENT '수정자 ID',
					//`UPD_DATE` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
					//
					/***************************KcpPaymentParam 값 set   End*************************************************/
					System.out.println("**************** 승인 정상 완료 시 resultCode와 비교  ******************************************");
					if("0000".equals(paramMap.get("resultCode"))) {
						int rst = 0 ;
						try{
							rst = service.saveApply(param, kcpPaymentParam);
							System.out.println("rst 2 222222222222222222222222222222:"+rst);
						// rst1 = service.saveApply1(kcpPaymentParam);  결제테이블  insert 테스트
						// rst2 = service.saveApply(param); 수강신청테이블 insert 테스트
						}catch(Exception e){
							e.printStackTrace();
						}
						System.out.println("*****************************수락한API(url(authUrl)승인 요청이후 **************************************");
						System.out.println(paramMap.get("resultCode"));  //0000
						System.out.println(resultMap.get("resultMsg"));
						System.out.println(resultMap.get("TotPrice"));
						System.out.println(resultMap.get("MOID"));
						System.out.println(resultMap.get("payMethod"));
						System.out.println(resultMap.get("applNum"));
						System.out.println(resultMap.get("applDate"));
						System.out.println(resultMap.get("applTime"));
						System.out.println("tid 값 : ");
						System.out.println(resultMap.get("tid"));
						
						System.out.println("******** 신용카드 **********************************************************");
						System.out.println(resultMap.get("CARD_Num"));
						System.out.println(resultMap.get("CARD_Interest"));
						System.out.println(resultMap.get("CARD_Quota"));
						System.out.println(resultMap.get("buyerEmail"));
						System.out.println(resultMap.get("CARD_Code"));
						
						System.out.println("********************************** 무통장 입금(가상계좌) *************************************");
						System.out.println(resultMap.get("VACT_Num"));
						System.out.println(resultMap.get("VACT_BankCode"));
						System.out.println(resultMap.get("VACT_Name"));
						System.out.println(resultMap.get("VACT_InputName"));
						System.out.println(resultMap.get("VACT_Date"));
						System.out.println(resultMap.get("VACT_Time"));
						System.out.println(resultMap.get("vactBankName"));
						
					} else {
						
						
						System.out.println(resultMap.get("resultMsg"));
						model.addAttribute("errorMsg", resultMap.get("resultMsg"));
						retUrl = "";
					}
					/**********************************이니시스 결제폼 이후 실제 반영위한 결과 End***************************/
	
		
		
		/*기존 창비 Start */ 
		// 동일 과정 기수 중복 신청 체크
		int existCount = service.selectUserApplyCourseCount(user_id, course_id, cardinal_id);
		if (existCount > 0) {
			throw new InvalidAccessException(getMessage(messageSource, "msg.apply.alreadyapplycourse"));
		}

		// 기본값 설정
	/*	param.put("user_id", user_id);
		kcpPaymentParam.setReg_user(user_id);*/

		int rst = 0;
		String message = getMessage(messageSource, "msg.apply.success");

		/*String payment_type = param.get("payment_type"); param 값 설정 위에서 해놓음 */

		// PG 승인이 필요한 결제수단
		/*if (GlobalConst.PAYMENT_TYPE_BANK.equals(payment_type) ||
				GlobalConst.PAYMENT_TYPE_VBANK.equals(payment_type) ||
				GlobalConst.PAYMENT_TYPE_CARD.equals(payment_type)) {

			logger.info("request approval");
			KcpPaymentParam paymentResult = paymentService.requestApproval(kcpPaymentParam);
			logger.debug("approval: {}", paymentResult);

			if(KcpPaymentParam.RESULT_SUCCESS.equals(paymentResult.getRes_cd())) {	// 승인성공
				// DB저장(결제성공 내역, 수강신청 내역 저장)
				try {

					// 가상계좌의 경우 미결제 상태
					if (GlobalConst.PAYMENT_TYPE_VBANK.equals(payment_type)) {
						param.put("payment_state", GlobalConst.PAYMENT_STATE_READY);	// 결제상태: 미결제

						// 입금 가상계좌 정보 메시지
						message = getMessage(messageSource
								, new String [] {
										paymentResult.getBankname()
										, paymentResult.getDepositor()
										, paymentResult.getAccount()
										, CommonUtil.getFormatDate(paymentResult.getVa_date(), "yyyyMMddHHmmss", "yyyy-MM-dd HH:mm")
								  }
								, "msg.apply.success_vank");
					} else {
						param.put("payment_state", GlobalConst.PAYMENT_STATE_DONE);	// 결제상태: 결제완료
					}

					rst = service.saveApply(param, kcpPaymentParam);
					logger.info("apply saved: "+rst);
				} catch (Exception ex) {
					logger.error("승인 후 DB저장 실패", ex);
				}

				// DB처리 실패시 승인취소
				if (rst == 0) {
					paymentResult = paymentService.requestCancelApproval(kcpPaymentParam);
					message = getMessage(messageSource, "msg.apply.failed");
					logger.info("cancel approval: {} - {}", paymentResult.getRes_cd(), paymentResult.getRes_msg());

					// 취소실패
					if(!KcpPaymentParam.RESULT_SUCCESS.equals(paymentResult.getRes_cd())) {
						message = getMessage(messageSource, "msg.apply.approvalcancelfailed") + "\n" + "["+paymentResult.getRes_cd() + "]\n" + paymentResult.getRes_msg();
					}
				}

			} else {	// 승인실패
				rst = 0;
				paymentService.insertKcpPayment(paymentResult);	// 결제실패내역 저장
				message = getMessage(messageSource,new String [] {paymentResult.getRes_cd(), paymentResult.getRes_msg()}, "msg.apply.approvalfailed");
				logger.info("apply saved: "+rst);
			}


		} else {	// no kcp
			// 결제금액이 0일 경우 결제완료 상태
			if (Integer.valueOf(param.get("real_payment")) > 0) {
				param.put("payment_state", GlobalConst.PAYMENT_STATE_READY);	// 결제상태: 미결제
			} else {
				param.put("payment_state", GlobalConst.PAYMENT_STATE_DONE);	// 결제상태: 결제
			}
			rst = service.saveApply(param);
		}*/



		/*if (rst < 1) {	// 신청실패
			model.addAttribute("script", getMessageAndBackScript(message));
		} else {

			// 판매순위갱신
			courseService.updateCourseSellOrderPlus(param.get("course_id"));

			model.addAttribute("script", getMessageAndMoveUrlScript(message, servletContextPath + "/mypage/lecture/lecture1"));
		}
		 */
		return forward();
	}
	
	// 가상계좌 채번 이후 입금시 입금에 대한 결과(성공시) - 이니시스 가맹점 관리자에서 가상계좌에   입금통보방식 선택쪽에서 URL 설정 
	
	
	/* 가상계좌 정상 결제 완료시 (결제 이후 구현할 부분)*/
	/*@RequestMapping(value = PathConstants.SOCIETY_EDU_USER_AFTERPAY, method = RequestMethod.POST)
	 public String user_pay_after( HttpServletRequest request, HttpServletResponse response) {
	  
	  PrintWriter out=null;
	  try {
	   out = response.getWriter();
	  } catch (IOException e1) {
	   // TODO Auto-generated catch block
	   e1.printStackTrace();
	  }
	  *//*******************************************************************************
	   * FILE NAME : doVaActProc.jsp
	   * DATE : 2009.07
	   * 이니시스 가상계좌 입금내역 처리demon으로 넘어오는 파라메터를 control 하는 부분 입니다.
	   * [수신정보] 자세한 내용은 메뉴얼 참조
	   * 변수명           한글명
	   * no_tid           거래번호
	   * no_oid           주문번호
	   * cd_bank          거래발생 기관코드
	   * cd_deal          취급기관코드
	   * dt_trans         거래일자
	   * tm_trans         거래시각
	   * no_vacct         계좌번호
	   * amt_input        입금금액
	   * amt_check        미결제타점권금액
	   * flg_close        마감구분
	   * type_msg         거래구분
	   * nm_inputbank     입금은행명
	   * nm_input         입금자명
	   * dt_inputstd      입금기준일자
	   * dt_calculstd     정산기준일자
	   * dt_transbase     거래기준일자
	   * cl_trans         거래구분코드 "1100"
	   * cl_close         마감전후 구분,  0:마감점, 1마감후
	   * cl_kor           한글구분코드, 2:KSC5601
	   *
	   * (가상계좌채번시 현금영수증 자동발급신청시에만 전달)
	   * dt_cshr          현금영수증 발급일자
	   * tm_cshr          현금영수증 발급시간
	   * no_cshr_appl     현금영수증 발급번호
	   * no_cshr_tid      현금영수증 발급TID
	   *******************************************************************************//*

	  *//***********************************************************************************
	   * 이니시스가 전달하는 가상계좌이체의 결과를 수신하여 DB 처리 하는 부분 입니다.
	   * 필요한 파라메터에 대한 DB 작업을 수행하십시오.
	   ***********************************************************************************//*

	  try {
	   request.setCharacterEncoding("EUC-KR");
	  } catch (UnsupportedEncodingException e1) {
	   // TODO Auto-generated catch block
	   e1.printStackTrace();
	  }


	//  String file_path = "C:/INIpay50/vaact";
	  String file_path = "/data1/workspace/common/INIpay50/vaact";



	  id_merchant = request.getParameter("id_merchant");
	  no_tid   = request.getParameter("no_tid");   // 거래번호
	  no_oid   = request.getParameter("no_oid");   // 주문번호
	  no_vacct  = request.getParameter("no_vacct");  // 계좌번호
	  amt_input  = request.getParameter("amt_input"); // 입금금액
	  nm_inputbank = request.getParameter("nm_inputbank");// 입금은행명
	  nm_input  = request.getParameter("nm_input");  // 입금자명
	
	  type_msg  = request.getParameter("nm_input");  // 
	  
	  System.out.println(new String(nm_inputbank.getBytes("EUC-KR"), "ISO-8859-1"));
	  System.out.println(new String(nm_inputbank.getBytes("ISO-8859-1"), "UTF-8"));
	  System.out.println(new String(nm_inputbank.getBytes("ISO-8859-1"), "EUC-KR"));
	  System.out.println(new String(nm_inputbank.getBytes("ISO-8859-1"), "ISO-8859-1"));

	  System.out.println(new String(nm_inputbank.getBytes("UTF-8"), "UTF-8"));
	  System.out.println(new String(nm_inputbank.getBytes("UTF-8"), "EUC-KR"));
	  System.out.println(new String(nm_inputbank.getBytes("UTF-8"), "ISO-8859-1"));

	  System.out.println(new String(nm_inputbank.getBytes("EUC-KR"), "UTF-8"));
	  System.out.println(new String(nm_inputbank.getBytes("EUC-KR"), "EUC-KR"));
	  System.out.println(new String(nm_inputbank.getBytes("EUC-KR"), "ISO-8859-1"));
	  

	  HashMap<String,String> hmParam = new HashMap<String,String>();
	  hmParam.put("id_merchant", id_merchant);
	  hmParam.put("p_no_tid", no_tid);
	  hmParam.put("p_moid", no_oid);
	  hmParam.put("p_cd_bank", request.getParameter("cd_bank"));
	  hmParam.put("p_cd_deal", request.getParameter("cd_deal"));
	  hmParam.put("p_dt_trans", request.getParameter("dt_trans"));
	  try {
	   hmParam.put("p_tm_trans", new String((request.getParameter("tm_trans")).getBytes("UTF-8"), "UTF-8"));
	   hmParam.put("p_nm_inputbank", new String(nm_inputbank.getBytes("UTF-8"), "UTF-8"));
	   hmParam.put("p_nm_input", new String(nm_input.getBytes("UTF-8"), "UTF-8"));
	  } catch (UnsupportedEncodingException e1) {
	   // TODO Auto-generated catch block
	   e1.printStackTrac
	  }*/

	/**
	 * 과정에 적용할 수 있는 쿠폰 리스트
	 * @param searchVo
	 * @return
	 */
	@RequestMapping(value = "/ajaxMyCourseCouponList")
	public @ResponseBody HashMap<String, Object> ajaxMyCourseCouponList(CouponSearchVo searchVo) {
		HashMap<String, Object> result = getSimpleAjaxResult();

		searchVo.setVisiblePages(5);
		searchVo.setUser_id(getLoginUserId());
		result.put("couponList", service.selectUserCourseCouponList(searchVo));
		result.put("searchVo", searchVo);

		return result;
	}

	/**
	 * 연수계획 팝업 레이어
	 * @param param
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/layer/learnplan")
	public String layerLearnplan(Model model, @RequestParam HashMap<String,String> param) {

		String course_id = param.get("course_id");
		model.addAttribute("detail", courseService.selectCardinalCourseDetail(param));
		model.addAttribute("chapterList", courseService.selectCourseChapterListAll(course_id));

		return "learn/apply/layer/learnplan";
	}

	@RequestMapping(value = "/ajaxUserCheckDuplDesNum")
	public @ResponseBody HashMap<String, Object> ajaxUserCheckDuplDesNum(Model model
			, @RequestParam String des_num
			, @RequestParam(required=false, defaultValue="") String learn_id) {
		String user_id = getLoginUserIdWithException();
		HashMap<String, Object> result = getDefaultAjaxSuccessResult();
		result.put("DUPL_YN", service.selectApplyCountByDesNum(des_num, user_id, learn_id) > 0 ? "Y" : "N");
		return result;
	}

	@RequestMapping(value = "/{page}")
	public String page(Model model, @PathVariable("page") String page) {
		return "learn/apply/"+page;
	}

}

