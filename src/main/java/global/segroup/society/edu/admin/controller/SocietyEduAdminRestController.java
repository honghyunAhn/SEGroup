/**
 * 
 */
package global.segroup.society.edu.admin.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.security.GeneralSecurityException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.HttpClients;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import global.segroup.domain.Admin;
import global.segroup.domain.AdminPager;
import global.segroup.domain.BoardGroup;
import global.segroup.service.SEGroupCommonService;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculum;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculumGisu;
import global.segroup.society.edu.admin.service.SocietyEduAdminService;
import global.segroup.society.edu.apply.domain.SocietyEduApplyForm;
import global.segroup.society.edu.apply.domain.SocietyEduApplyResult;
import global.segroup.society.edu.user.domain.RefundInfo;
import global.segroup.society.smp.admin.service.SocietySmpAdminService;
import global.segroup.util.AESEncryptor;
import global.segroup.util.PathConstants;

/**
 * 
 * @Author : 이종호
 * @Date : 2017. 8. 7.
 * @Class 설명 : Soft Engineer Society 모집홍보 관리자 Rest 컨트롤러
 * 
 */

@Controller
public class SocietyEduAdminRestController implements PathConstants {

	private static final Logger logger = LoggerFactory.getLogger(SocietyEduAdminRestController.class);

	@Autowired
	private SocietyEduAdminService seaService;

	@Autowired
	private SEGroupCommonService sgcService;
	
	@Autowired
	private SocietySmpAdminService ssaService;
	
	@Autowired
	private AESEncryptor aesEncryptor;

	/**
	 * @Method Name : searchCurriculum
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 과정 시퀀스 정보
	 * @Return : 과정 정보 및 해당 과정의 기수 정보들을 가진 맵 객체
	 * @Method 설명 : 과정 시퀀스로 과정 정보와 기수정보들을 조회 하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SEARCH_CURRICULUM_AND_GISU, method = RequestMethod.POST)
	public HashMap<String, Object> searchCurriculumAndGisu(int crc_seq) {
		logger.debug("과정&기수 검색 컨트롤러 시작");

		HashMap<String, Object> resultMap = seaService.searchCurriculumAndGisu(crc_seq);

		logger.debug("과정&기수 검색 컨트롤러 종료");
		return resultMap;
	}

	/**
	 * @Method Name : searchCurriculum
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 과정 시퀀스 정보
	 * @Return : 과정 정보 객체
	 * @Method 설명 : 해당 과정 시퀀스의 과정 정보를 조회 하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SEARCH_CURRICULUM, method = RequestMethod.POST)
	public SocietyEduAdminCurriculum searchCurriculum(int crc_seq) {
		logger.debug("특정 과정 검색 컨트롤러 시작");

		SocietyEduAdminCurriculum seaCurriculum = seaService.searchCurriculum(crc_seq);

		logger.debug("특정 과정 검색 컨트롤러 종료");
		return seaCurriculum;
	}

	/**
	 * @Method Name : searchGisu
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 과정 시퀀스 정보
	 * @Return : 해당 과정 정보의 기수 정보들을 가진 리스트 객체
	 * @Method 설명 : 과정 시퀀스로 기수 정보들을 조회 하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SEARCH_CUR_GISU, method = RequestMethod.POST)
	public ArrayList<SocietyEduAdminCurriculumGisu> searchCurGisu(int crc_seq) {
		logger.debug("기수 검색 컨트롤러 시작");

		ArrayList<SocietyEduAdminCurriculumGisu> resultMap = seaService.searchCurGisuList(crc_seq);

		logger.debug("기수 검색 컨트롤러 종료");

		return resultMap;
	}

	/**
	 * @Method Name : searchCurOrder
	 * @Date : 2017. 12. 19.
	 * @User : 전상수
	 * @Param : 기수 시퀀스 정보
	 * @Return : 해당 기수의 결제 정보들을 가진 리스트 객체
	 * @Method 설명 : 기수 시퀀스로 결제 정보들을 조회 하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SEARCH_CUR_ORDER, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> searchCurOrder(int gisu_seq) {
		logger.debug("기수 검색 컨트롤러 시작");

		ArrayList<HashMap<String, Object>> resultList = seaService.searchCurriculumGisuOrder(gisu_seq);

		logger.debug("기수 검색 컨트롤러 종료");

		return resultList;
	}

	/**
	 * @Method Name : curriculum_permission_update
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 과정 정보 객체(과정 시퀀스, 승인 코드)
	 * @Return : -
	 * @Method 설명 : 전달 받은 과정 승인 정보를 수정하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_PERMISSION_UPDATE, method = RequestMethod.POST)
	public HashMap<String, Object> curriculum_permission_update(SocietyEduAdminCurriculum seaCur, Authentication auth) {
		logger.debug("과정 승인 정보 수정 컨트롤러 시작");

		seaCur.setCrc_udt_id(auth.getName());
		HashMap<String, Object> resultMap = seaService.curriculum_permission_update(seaCur);

		logger.debug("과정 승인 정보 수정 컨트롤러 종료");
		return resultMap;
	}

	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_GISU_PERMISSION_UPDATE, method = RequestMethod.POST)
	public HashMap<String, Object> curriculum_gisu_permission_update(SocietyEduAdminCurriculumGisu seaCurGisu,
			Authentication auth) {
		logger.debug("기수 노출 승인 정보 수정 컨트롤러 시작");

		seaCurGisu.setGisu_udt_id(auth.getName());
		HashMap<String, Object> resultMap = seaService.curriculum_gisu_permission_update(seaCurGisu);

		logger.debug("기수 노출 승인 정보 수정 컨트롤러 종료");
		return resultMap;
	}

	/**
	 * @Method Name : searchApplyList
	 * @Date : 2018. 02. 13. -> 2018. 09. 12
	 * @User : 이종호 , 박기호 수정, 원병호 수정
	 * @Param : 기수 시퀀스, 현재페이지, 한페이지당 목록 수, 검색어, 정렬컬럼명, 정렬 방식, 검색 정보(면접, 서류전형)
	 * @Return : 해당 기수의 신청자 정보들 리스트 객체
	 * @Method 설명 : 특정 기수의 신청자 정보들을 조회하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SEARCH_APPLY_LIST, method = RequestMethod.POST)
	public HashMap<String, Object> searchApplyList(String gisu_seq, @RequestParam(defaultValue = "1") String curPage,
			@RequestParam(defaultValue = "10") String pageCount, @RequestParam(defaultValue = "") String search_name,
			@RequestParam(defaultValue = "") String orderType, @RequestParam(defaultValue = "") String orderValue,
			@RequestParam(defaultValue = "") String search_doc_rt, @RequestParam(defaultValue = "") String search_itv_rt) {
		logger.debug("특정 기수 지원자들 정보 조회 컨트롤러 시작");

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search_name", search_name); 	// 검색키워드
		map.put("app_rt_doc", search_doc_rt);	// 검색(서류결과)
		map.put("app_rt_itv", search_itv_rt);	// 검색(면접결과)
		map.put("gisu_seq", gisu_seq);
		map.put("orderType", orderType);
		map.put("orderValue", orderValue);
		int count = seaService.apply_manager_select_count(map);
		map.put("count", count); // 레코드의 갯수
		AdminPager.setPAGE_SCALE(Integer.parseInt(pageCount));
		AdminPager adminPager = new AdminPager(count, Integer.parseInt(curPage));
		map.put("adminPager", adminPager); // 페이징 객체
		ArrayList<HashMap<String, Object>> resultList = seaService.apply_manager_select(map);
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("pageCount", pageCount);
		resultMap.put("resultList", resultList);
		resultMap.put("adminPager", adminPager);
		resultMap.put("totalCount", count); // 총 레코드 갯수 모델에 담기 위함

		logger.debug("특정 기수 지원자들 정보 조회 컨트롤러 종료");
		return resultMap;
	}

	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SEND_MAIL, method = RequestMethod.POST)
	public String send_mail(@RequestParam(defaultValue = "") String info_email,
			@RequestParam(defaultValue = "") String modal_title,
			@RequestParam(defaultValue = "") String modal_textarea,
			@RequestParam(defaultValue = "") String modal_file,
			@RequestParam(defaultValue = "") String modal_sendDate) {
		logger.debug("특정 기수 지원자들 대상 메일발송 컨트롤러 시작");
		String result = "";
		
		Date sendDate = null;
		if (modal_sendDate != "") {
			try {
				sendDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(modal_sendDate);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		try {
			result = seaService.sendMailingService(info_email, modal_title, modal_textarea, null, null, sendDate);
		} catch (Exception e) {
			result = e.getMessage();
		}

		logger.debug("특정 기수 지원자들 대상 메일발송 컨트롤러 종료");
		return result;
	}

	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SEND_SMS, method = RequestMethod.POST)
	public Object send_sms(
			@RequestParam(defaultValue = "") String receiver,
			@RequestParam(defaultValue = "") String destination,
			@RequestParam(defaultValue = "") String msg,
			@RequestParam(defaultValue = "") String title,
			@RequestParam(defaultValue = "") String rdate,
			@RequestParam(defaultValue = "") String rtime) {
		logger.debug("특정 기수 지원자들 대상 문자발송 컨트롤러 시작");
		
		String responseStr = "";
		
		try{

			final String encodingType = "utf-8";
			final String boundary = "____boundary____";
		
			/******************** 인증정보 ********************/
			String sms_url = "https://apis.aligo.in/send/"; // 전송요청 URL
			
			Map<String, String> sms = new HashMap<String, String>();
			
			sms.put("user_id", "sesoc"); // SMS 아이디
			sms.put("key", "t7s6tjxaeq5ylbznoe0pp6vxaycnfpwy"); //인증키
			/******************** 인증정보 ********************/
			
			/******************** 전송정보 ********************/
			sms.put("msg", msg); // 메세지 내용
			sms.put("receiver", receiver); // 수신번호
			sms.put("destination", destination); // 수신인 %고객명% 치환
			sms.put("sender", "0260005394"); // 발신번호

			if (!rdate.isEmpty() && !rtime.isEmpty()) {
				sms.put("rdate", rdate); // 예약일자 - 20161004 : 2016-10-04일기준
				sms.put("rtime", rtime); // 예약시간 - 1930 : 오후 7시30분
			}
			
			if (!title.isEmpty()) {
				sms.put("title", title); // LMS, MMS 제목 (미입력시 본문중 44Byte 또는 엔터 구분자 첫라인)
			}
			
			// TEST할 때 사용하는 코드
//			sms.put("testmode_yn", "Y"); // Y 인경우 실제문자 전송X , 자동취소(환불) 처리
//			System.out.println("sms.toString() : " + sms.toString());
			/******************** 전송정보 ********************/

			/******************** 전송처리 ********************/
			MultipartEntityBuilder builder = MultipartEntityBuilder.create();
			
			builder.setBoundary(boundary);
			builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
			builder.setCharset(Charset.forName(encodingType));
			
			for(Iterator<String> i = sms.keySet().iterator(); i.hasNext();){
				String key = i.next();
				builder.addTextBody(key, sms.get(key)
						, ContentType.create("Multipart/related", encodingType));
			}
			
			HttpEntity entity = builder.build();
			
			HttpClient client = HttpClients.createDefault();
			HttpPost post = new HttpPost(sms_url);
			post.setEntity(entity);
			
			HttpResponse res = client.execute(post);
//			System.out.println("res.toString() : " + res.toString());
			/******************** 전송처리 ********************/

			/**************** 문자전송결과 예제 ******************/
			/* "result_code":결과코드,"message":결과문구, */
			/* "msg_id":메세지ID,"error_cnt":에러갯수,"success_cnt":성공갯수 */
			if(res != null){
				BufferedReader in = new BufferedReader(new InputStreamReader(res.getEntity().getContent(), encodingType));
				String buffer = null;
				while((buffer = in.readLine())!=null){
					responseStr += buffer;
				}
				in.close();
			}
//			System.out.println("responseStr : " + responseStr);
			
			// TODO: 차후 DB에 SMS Data 저장하기 위한 예비소스
//			JSONParser parser = new JSONParser();
//			Object obj = parser.parse(responseStr);
//			JSONObject jsonObj = (JSONObject)obj;
//
//			String result_code = (String) jsonObj.get("result_code");
//			String message = (String) jsonObj.get("message");
//			System.out.println("result_code" + result_code);
//			System.out.println("success_cnt" + (String) jsonObj.get("success_cnt"));
//			System.out.println("error_cnt" + (String) jsonObj.get("error_cnt"));
//			System.out.println("message" + message);
		}catch(Exception e){
			responseStr = e.getMessage();
		}
		
		logger.debug("특정 기수 지원자들 대상 문자발송 컨트롤러 종료");
		return responseStr;
	}

	/**
	 * @Method Name : search_paid_list
	 * @Date : 2017. 12. 19.
	 * @User : 전상수
	 * @Param : 기수 시퀀스
	 * @Return : 해당 기수의 신청자 정보들 리스트 객체
	 * @Method 설명 : 특정 기수의 신청자 정보들을 조회하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SEARCH_PAID_LIST, method = RequestMethod.POST)
	public HashMap<String, Object> search_paid_list(String gisu_seq, String gisu_order, String name,
			@RequestParam(defaultValue = "1") int curPage, @RequestParam(defaultValue = "1") int pageCount,
			@RequestParam(defaultValue = "gisu_num") String sort_param,
			@RequestParam(defaultValue = "asc") String sort_order) {
		logger.debug("특정 기수 결제자들 정보 조회 컨트롤러 시작");
		System.out.println(gisu_seq + " " + gisu_order + " " + name);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("gisu_seq", gisu_seq);
		map.put("gisu_order", gisu_order);
		map.put("name", name);
		map.put("sort_param", sort_param);
		map.put("sort_order", sort_order);
		int count = seaService.paid_manager_select_count(map);

		map.put("count", count); // 레코드의 갯수
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count, curPage);
		map.put("adminPager", adminPager); // 페이징 객체
		ArrayList<HashMap<String, Object>> resultList = seaService.paid_manager_select(map);
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("pageCount", pageCount);
		resultMap.put("resultList", resultList);
		resultMap.put("adminPager", adminPager);

		logger.debug("특정 기수 결제자들 정보 조회 컨트롤러 종료");

		return resultMap;
	}

	/**
	 * @Method Name : search_refund_list
	 * @Date : 2017. 12. 27.
	 * @User : 전상수
	 * @Param : 기수 시퀀스
	 * @Return : 해당 기수의 환불 신청자 정보들 리스트 객체
	 * @Method 설명 : 특정 기수의 환불 신청자 정보들을 조회하는 컨트롤러 함수
	 */
	// @ResponseBody
	// @RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_SEARCH_REFUND_LIST,
	// method = RequestMethod.POST)
	// public ArrayList<HashMap<String, Object>> search_refund_list(String
	// gisu_seq,String gisu_order){
	// logger.debug("특정 기수 환불 요청자들 정보 조회 컨트롤러 시작");
	// HashMap<String, Object> map=new HashMap<String, Object>();
	// map.put("gisu_seq", gisu_seq);
	// map.put("gisu_order", gisu_order);
	// ArrayList<HashMap<String, Object>> resultList =
	// seaService.refund_manager_select(map);
	// logger.debug("특정 기수 환불 요청자들 정보 조회 컨트롤러 종료");
	// return resultList;
	// }

	/**
	 * @Method Name : search_paid_name
	 * @Date : 2017. 12. 19.
	 * @User : 전상수
	 * @Param : 기수 시퀀스
	 * @Return : 해당 기수의 신청자 정보들 리스트 객체
	 * @Method 설명 : 특정 기수의 신청자 정보들을 조회하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SEARCH_PAID_NAME, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> search_paid_name(String name) {
		logger.debug("특정 기수 결제자들 정보 조회 컨트롤러 시작");
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("name", name);
		ArrayList<HashMap<String, Object>> resultList = seaService.paid_name_select(map);
		logger.debug("특정 기수 결제자들 정보 조회 컨트롤러 종료");
		return resultList;
	}

	/**
	 * @Method Name : search_refund_name
	 * @Date : 2017. 12. 19.
	 * @User : 전상수
	 * @Param : 기수 시퀀스
	 * @Return : 해당 기수의 환불신청자 정보들 리스트 객체
	 * @Method 설명 : 특정 기수의 환불신청자 정보들을 조회하는 컨트롤러 함수
	 */
	// @ResponseBody
	// @RequestMapping(value=PathConstants.SOCIETY_EDU_ADMIN_SEARCH_REFUND_NAME,
	// method = RequestMethod.POST)
	// public ArrayList<HashMap<String, Object>> search_refund_name(String
	// name){
	// logger.debug("특정 기수 환불신청자 정보 조회 컨트롤러 시작");
	// HashMap<String, Object> map=new HashMap<String, Object>();
	// map.put("name", name);
	// ArrayList<HashMap<String, Object>> resultList =
	// seaService.refund_name_select(map);
	// logger.debug("특정 기수 환불신청자 정보 조회 컨트롤러 종료");
	// return resultList;
	// }

	/**
	 * @Method Name : eduApply_result_update
	 * @Date : 2017. 8. 24. -> 2018. 09. 12
	 * @User : 이종호, 원병호
	 * @Param : 특정 지원자의 결과 정보 객체, 검색 정보(면접, 서류전형) 추가
	 * @Return : -
	 * @Method 설명 : 특정 지원자의 결과 정보 수정하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_APPLY_RESULT_UPDATE, method = RequestMethod.POST)
	public HashMap<String, Object> eduApply_result_update(SocietyEduApplyResult seaResult, Authentication auth,
			String gisu_seq, @RequestParam(defaultValue = "1") String curPage,
			@RequestParam(defaultValue = "10") String pageCount, @RequestParam(defaultValue = "") String search_name,
			@RequestParam(defaultValue = "") String orderType, @RequestParam(defaultValue = "") String orderValue,
			@RequestParam(defaultValue = "") String search_doc_rt, @RequestParam(defaultValue = "") String search_itv_rt) {
		logger.debug("특정 지원자의 결과 정보 수정 컨트롤러 시작");

		seaResult.setApp_rt_doc_id(auth.getName());
		seaResult.setApp_rt_itv_id(auth.getName());
		System.out.println("합불변경 테스트: " + seaResult);
		seaService.eduApply_result_update(seaResult);

		logger.debug("특정 지원자의 결과 정보 수정 컨트롤러 종료");
		return searchApplyList(gisu_seq, curPage, pageCount, search_name, orderType, orderValue, search_doc_rt, search_itv_rt);
	}

	/**
	 * @Method Name : board_name_search
	 * @Date : 2017. 8. 25.
	 * @User : 이종호
	 * @Param : 게시판 구분, 게시판 타입을 가진 게시판 그룹 객체
	 * @Return : 게시판 시퀀스, 게시판 이름을 가진 게시판 그룹 리스트 객체
	 * @Method 설명 : 특정 구분, 타입 값을 가진 게시판 그룹 리스트를 조회하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_BOARD_NAME_SEARCH, method = RequestMethod.POST)
	public ArrayList<BoardGroup> board_name_search(BoardGroup boardGb) {
		logger.debug("게시판 그룹 리스트 조회 컨트롤러 함수 시작");

		ArrayList<BoardGroup> resultList = seaService.board_name_search(boardGb);
		System.out.println(resultList);
		logger.debug("게시판 그룹 리스트 조회 컨트롤러 함수 종료");
		return resultList;
	}

	/**
	 * @Method Name : search_refund_list
	 * @Date : 2017. 12. 27.
	 * @User : 전상수
	 * @Param : 검색파라미터
	 * @Return : 환불 신청자 정보 리스트
	 * @Method 설명 : 동적처리 후 환불정보 리스트 데이터를 반환하는 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SEARCH_REFUND_LIST, method = RequestMethod.POST)
	public HashMap<String, Object> search_refund_list(
			@RequestParam(defaultValue = "pay_refund_status") String sort_param,
			@RequestParam(defaultValue = "asc") String sort_order, String gisu_seq, String gisu_order,
			String search_name, @RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "1") int pageCount) {
		logger.debug("환불 요청자들 정보 조회 컨트롤러 시작");
		System.out.println(" 환불 요청자들 정보");
		System.out.println(gisu_seq + gisu_order + search_name + " " + curPage + " " + pageCount);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("gisu_seq", gisu_seq);
		map.put("gisu_order", gisu_order);
		map.put("search_name", search_name);
		map.put("sort_param", sort_param);
		map.put("sort_order", sort_order);
		System.out.println(map);

		int count = seaService.refund_manager_list_count(map);
		map.put("count", count); // 레코드의 갯수
		// AdminPager.setBLOCK_SCALE(10);
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count, curPage);
		map.put("adminPager", adminPager); // 페이징 객체
		List<HashMap<String, Object>> resultList = seaService.refund_manager_list(map);
		for(HashMap<String, Object> r : resultList) {
			if(r.get("pay_refund_accnum") != null) {
				try {
					r.put("pay_refund_accnum", aesEncryptor.decrypt((String)r.get("pay_refund_accnum")));
				} catch (UnsupportedEncodingException | GeneralSecurityException e) {
					e.printStackTrace();
				}
			}
		}
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("pageCount", pageCount);
		resultMap.put("resultList", resultList);
		resultMap.put("adminPager", adminPager);

		logger.debug("환불 요청자들 정보 조회 컨트롤러 종료");
		return resultMap;
	}

	/**
	 * @Method Name : refund_memo_update
	 * @Date : 2018. 02. 07.
	 * @User : 윤상혁
	 * @Param : 변경할 메모 내용, 대상 seq, 검색파라미터
	 * @Return : 환불관리 페이지로 리다이렉트
	 * @Method 설명 : 환불 메모 내용을 변경하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_REFUND_MEMO_UPDATE, method = RequestMethod.POST)
	public HashMap<String, Object> refund_memo_update(RefundInfo refundInfo, String gisu_seq, String gisu_order,
			String search_name, @RequestParam(defaultValue = "1") int pageIndex, RedirectAttributes redirectAttributes,
			@RequestParam(defaultValue = "1") int curPage, @RequestParam(defaultValue = "1") int pageCount,
			@RequestParam(defaultValue = "pay_refund_status") String sort_param,
			@RequestParam(defaultValue = "asc") String sort_order) {
		System.out.println("환불 메모 내용 변경 컨트롤러 시작");
		System.out.println(refundInfo);
		logger.debug("환불 메모 내용 변경 컨트롤러 시작");
		int result = seaService.refund_memo_update(refundInfo);
		logger.debug("환불 메모 내용 변경 컨트롤러  종료");
		return search_refund_list(sort_param, sort_order, gisu_seq, gisu_order, search_name, curPage, pageCount);
	}

	/**
	 * @Method Name : proceed_refund
	 * @Date : 2017. 02. 08.
	 * @User : 윤상혁
	 * @Param : 환불seq, 결제seq, 검색파라미터
	 * @Return : 동적 태그
	 * @Method 설명 : 환불 처리를 완료하고 관련 결제 데이터를 삭제하는 메소드
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_PROCEED_REFUND, method = RequestMethod.POST)
	public HashMap<String, Object> proceed_refund(int pay_user_seq, int pay_refund_seq, String gisu_seq,
			String gisu_order, String search_name, RedirectAttributes redirectAttributes, Model model,
			String pay_user_refund_reason, String pay_user_cancelreason, @RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "1") int pageCount,
			@RequestParam(defaultValue = "pay_refund_status") String sort_param,
			@RequestParam(defaultValue = "asc") String sort_order) {

		// 환불 seq로 환불받을 유저 아이디 검색
		/*RefundInfo user_info = seaService.select_refund_user_id(pay_refund_seq);
		String iniresult = "";
		INIpay inipay = new INIpay();

		*//*********************
		 * 3. 취소 정보 설정 *
		 *********************//*
		inipay.SetField("inipayhome", "D:////inipayhome"); // 이니페이 홈디렉터리(상점수정 필요) 로그정보
		inipay.SetField("type", "cancel"); // 고정 (절대 수정 불가)
		inipay.SetField("debug", "true"); // 로그모드("true"로 설정하면 상세로그가 생성됨.)
		inipay.SetField("mid", "softenjin0"); // 상점아이디
		inipay.SetField("admin", "1111"); // 상점 키패스워드 (비대칭키)
		inipay.SetField("cancelreason", pay_user_cancelreason); // 현금영수증
																// 취소코드
		// ***********************************************************************************************************
		// * admin 은 키패스워드 변수명입니다. 수정하시면 안됩니다. 1111의 부분만 수정해서 사용하시기 바랍니다. *
		// * 키패스워드는 상점관리자 페이지(https://iniweb.inicis.com)의 비밀번호가 아닙니다. 주의해
		// 주시기 바랍니다.*
		// * 키패스워드는 숫자 4자리로만 구성됩니다. 이 값은 키파일 발급시 결정됩니다. *
		// * 키패스워드 값을 확인하시려면 상점측에 발급된 키파일 안의 readme.txt 파일을 참조해 주십시오. *
		// ***********************************************************************************************************
		inipay.SetField("tid", user_info.getPay_tid()); // 취소할 거래의 거래아이디
		inipay.SetField("cancelmsg", pay_user_refund_reason); // 취소사유
		inipay.SetField("crypto", "execure"); // Extrus 암호화모듈 사용(고정)

		*//****************
		 * 4. 취소 요청 *
		 ****************//*
		inipay.startAction();
		iniresult = inipay.GetResult("ResultCode");
		String cshr_cancelnum = inipay.GetResult("CSHR_CancelNum");

		user_info.setCshr_cancelnum(cshr_cancelnum);
		user_info.setPay_refund_seq(pay_refund_seq);

		if (iniresult.equals("01")) {

			
		}*/
		int result = 0;
		RefundInfo user_info = seaService.select_refund_user_id(pay_refund_seq);
			logger.debug("환불 상태 변경 컨트롤러 시작");
			int refundResult = seaService.refund_status_update(user_info);
			// 환불이 성공적으로 이루어진 경우에만 결제데이터 삭제
			if (refundResult > 0) {
				result = seaService.delete_pay_info(pay_user_seq);
			}
			// redirectAttributes.addAttribute("gisu_order", gisu_order);
			// redirectAttributes.addAttribute("search_name", search_name);
			// redirectAttributes.addAttribute("refund_result", result);

			// 환불받은 유저 권한 변경
			HashMap<String, String> params = new HashMap<String, String>();
			params.put("user_id", user_info.getPay_user_id());
			params.put("user_flag", "A0100");

			sgcService.updateUserFlag(params);
		
		logger.debug("환불 상태 변경 컨트롤러 종료");
		// return
		// "redirect:"+PathConstants.SOCIETY_EDU_ADMIN_SEARCH_REFUND_LIST;
		return search_refund_list(sort_param, sort_order, gisu_seq, gisu_order, search_name, curPage, pageCount);
	}

	/**
	 * @Method Name : delete_pay_info
	 * @Date : 2018. 2. 10.
	 * @User : 윤상혁
	 * @Param : 검색파라미터, 삭제할 결제 시퀀스
	 * @Return : 유저결제관리 리스트 데이터
	 * @Method 설명 : 관리자가 결제대기중인 수강생의 결제정보를 강제로 삭제하는 메소드. 결제내역이 존재하는 기수의 결제정보를
	 *         변경해야할 경우에 사용한다.
	 */
	@ResponseBody
	@RequestMapping(value = "/edu/admin/delete_pay_info", method = RequestMethod.POST)
	public HashMap<String, Object> delete_pay_info(@RequestParam(defaultValue = "pay_refund_status") String sort_param,
			@RequestParam(defaultValue = "asc") String sort_order, int pay_user_seq,
			@RequestParam(defaultValue = "") String gisu_seq, @RequestParam(defaultValue = "") String gisu_order,
			@RequestParam(defaultValue = "") String name, @RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "1") int pageCount) {
		logger.debug("delete_pay_info 컨트롤러 시작");
		System.out.println(pay_user_seq + " " + gisu_seq + " " + gisu_order + " " + name);
		seaService.delete_pay_info(pay_user_seq);
		logger.debug("delete_pay_info 컨트롤러 종료");
		return search_paid_list(gisu_seq, gisu_order, name, curPage, pageCount, sort_param, sort_order);
	}

	/**
	 * @Method Name : insert_temp_refund
	 * @Date : 2018. 2. 10.
	 * @User : 윤상혁
	 * @Param : 검색파라미터, 환불로 이동시킬 결제 시퀀스
	 * @Return : 유저결제관리 리스트 데이터
	 * @Method 설명 : 관리자가 결제완료된 수강생의 결제정보를 강제로 환불처리하는 메소드. 결제내역이 존재하는 기수의 결제정보를
	 *         변경해야할 경우에 사용한다.
	 */
	@ResponseBody
	@RequestMapping(value = "/edu/admin/insert_temp_refund", method = RequestMethod.POST)
	public HashMap<String, Object> insert_temp_refund(
			@RequestParam(defaultValue = "pay_refund_status") String sort_param,
			@RequestParam(defaultValue = "asc") String sort_order, int pay_user_seq,
			@RequestParam(defaultValue = "") String gisu_seq, @RequestParam(defaultValue = "") String gisu_order,
			@RequestParam(defaultValue = "") String name, @RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "1") int pageCount) {
		logger.debug("insert_temp_refund 컨트롤러 시작");

		System.out.println(pay_user_seq + " " + gisu_seq + " " + gisu_order + " " + name);
		int result = seaService.insert_refund_temp(pay_user_seq);
		if (result > 0)
			seaService.delete_pay_info(pay_user_seq);

		logger.debug("insert_temp_refund 컨트롤러 종료");
		return search_paid_list(gisu_seq, gisu_order, name, curPage, pageCount, sort_param, sort_order);
	}
	
	/**
	 * @Method Name : board_search_all
	 * @Date : 2018. 9. 12.
	 * @User : 김준영, 정대영
	 * @Param : -
	 * @Return : 관리자 게시판의 모든 게시물
	 * @Method 설명 : 관리자 게시판 진입 시 모든 게시물 조회
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_BOARD_MANAGER_FORM, method = RequestMethod.POST)
	public ArrayList<BoardGroup> board_manager_form(Model model,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int pageCount,
			@RequestParam(defaultValue="") String search_division,
			@RequestParam(defaultValue="") String search_type
			){
		logger.debug("모집홍보 관리자 게시판 관리 폼 이동 컨트롤러 시작");
		logger.debug("모집홍보 관리자 게시판 관리 폼 이동 컨트롤러 종료");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("pageCount", pageCount);
		map.put("search_division", search_division);
		map.put("search_type", search_type);
		
		int count = seaService.board_search_all_count(map);
		
		AdminPager adminPager = new AdminPager(count,curPage);
		map.put("count", count); // 레코드의 갯수
		map.put("adminPager", adminPager);
		
		ArrayList<BoardGroup> resultList = seaService.board_search_all(map);	
		model.addAttribute("map", map);
		model.addAttribute("curPage", curPage);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("search_division", search_division);
		model.addAttribute("search_type", search_type);
		
		return resultList;
	}
	
	/**
	 * @Method Name : admin_info_update
	 * @Date : 2018. 9. 17.
	 * @User : 이종호
	 * @Param : 관리자 정보 공통코드 (권한 , 상태 , 프로젝트) , 권한기간 객체
	 * @Return : -
	 * @Method 설명 : 전달 받은 관리자 정보를 수정하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_INFO_UPDATE, method = RequestMethod.POST)
	public void admin_info_update(Admin admin, Authentication auth) {
		logger.debug("관리자 정보 수정 컨트롤러 시작");
		
		admin.setAdmin_udt_id(auth.getName());
		
		seaService.admin_info_update(admin);
		
		logger.debug("관리자 정보 수정 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : banner_od_list
	 * @Date : 2018. 9. 28.
	 * @User : 김준영
	 * @Param : 배너 시퀀스, 배너 노출여부
	 * @Return : -
	 * @Method 설명 : 메인 배너의 사진 순서를 리스트로 불러오기
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_BANNER_OD, method = RequestMethod.POST)
	public void banner_od_list(int edu_ban_seq, String edu_ban_eps, Authentication auth){
		logger.debug("메인 배너 사진 순서 리스트 출력 컨트롤러 시작");
		ArrayList<Integer> banner_od_list = seaService.banner_od_list();
		// 현재 저장 되어 있는 순서중 가장 큰 수
		int max_od = 0;
		if(banner_od_list.size() != 0){
			max_od = banner_od_list.get(banner_od_list.size()-1);			
		}else{
			max_od = 0;
		}
		// 메인 배너 등록 시 가장 마지막 순서로 등록 해 줄 수
		int od_update = max_od + 1;
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("edu_ban_seq", edu_ban_seq);
		map.put("od_update", od_update);
		map.put("edu_ban_eps", edu_ban_eps);
		map.put("edu_ban_udt_id", auth.getName());
		seaService.banner_shown_update(map);
		logger.debug("메인 배너 사진 순서 리스트 출력 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : banner_ini
	 * @Date : 2018. 9. 28.
	 * @User : 김준영
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : 초기화 버튼을 눌렀을 때 노출 : 노출x, 순서 : 0 으로 변경
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_BANNER_INI, method = RequestMethod.POST)
	public void banner_ini(Authentication auth){
		logger.debug("메인 배너 노출여부, 순서 초기화 컨트롤러 시작");
		String edu_ban_udt_id = auth.getName();
		seaService.banner_ini(edu_ban_udt_id);
		logger.debug("메인 배너 노출여부, 순서 초기화 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : subbanner_od_list
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : 서브 배너 시퀀스, 서브 배너 노출여부
	 * @Return : -
	 * @Method 설명 : 서브 배너의 사진 순서를 리스트로 불러오기
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SUBBANNER_OD, method = RequestMethod.POST)
	public void subbanner_od_list(int edu_sub_ban_seq, String edu_sub_ban_eps, Authentication auth){
		logger.debug("서브 배너 사진 순서 리스트 출력 컨트롤러 시작");
		ArrayList<Integer> subbanner_od_list = seaService.subbanner_od_list();
		// 현재 저장 되어 있는 순서중 가장 큰 수
		int max_od = 0;
		if(subbanner_od_list.size() != 0){
			max_od = subbanner_od_list.get(subbanner_od_list.size()-1);			
		}else{
			max_od = 0;
		}
		// 서브 배너 등록 시 가장 마지막 순서로 등록 해 줄 수
		int sub_od_update = max_od + 1;
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("edu_sub_ban_seq", edu_sub_ban_seq);
		map.put("sub_od_update", sub_od_update);
		map.put("edu_sub_ban_eps", edu_sub_ban_eps);
		map.put("edu_sub_ban_udt_id", auth.getName());
		seaService.subbanner_shown_update(map);
		logger.debug("서브 배너 사진 순서 리스트 출력 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : subbanner_ini
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : 초기화 버튼을 눌렀을 때 노출 : 노출x, 순서 : 0 으로 변경
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SUBBANNER_INI, method = RequestMethod.POST)
	public void subbanner_ini(Authentication auth){
		logger.debug("서브 배너 노출여부, 순서 초기화 컨트롤러 시작");
		String edu_sub_ban_udt_id = auth.getName();
		seaService.subbanner_ini(edu_sub_ban_udt_id);
		logger.debug("서브 배너 노출여부, 순서 초기화 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : banner_od_udt
	 * @Date : 2018. 10. 1.
	 * @User : 김준영
	 * @Param : 메인 배너의 seq, 순서
	 * @Return : -
	 * @Method 설명 : 메인 배너의 순서 수정
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_BANNER_ORDER_UPDATE, method = RequestMethod.POST)
	public void banner_od_udt(@RequestParam(defaultValue="") ArrayList<String> banner_seq_array){
		HashMap<String, Object> map = new HashMap<>();
		if(banner_seq_array.size() != 0){
			for(int i = 0; i < banner_seq_array.size(); i++){
				map.put("edu_ban_seq", banner_seq_array.get(i));
				map.put("edu_ban_od", i+1);
				seaService.banner_od_udt(map);
			}
		}
	}
	
	/**
	 * @Method Name : subbanner_od_udt
	 * @Date : 2018. 10. 1.
	 * @User : 김준영
	 * @Param : 서브 배너의 seq, 순서
	 * @Return : -
	 * @Method 설명 : 서브 배너의 순서 수정
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_SUBBANNER_ORDER_UPDATE, method = RequestMethod.POST)
	public void subbanner_od_udt(@RequestParam(defaultValue="") ArrayList<String> subbanner_seq_array){
		HashMap<String, Object> map = new HashMap<>();
		
		if(subbanner_seq_array.size() != 0){
			for(int i = 0; i < subbanner_seq_array.size(); i++){
				map.put("edu_sub_ban_seq", subbanner_seq_array.get(i));
				map.put("edu_sub_ban_od", i+1);
				seaService.subbanner_od_udt(map);
			}
		}
	}
	
	/**
	 * @Method Name : class_check
	 * @Date : 2018. 10. 8.
	 * @User : 김준영
	 * @Param : crc_class
	 * @Return : 중복 체크
	 * @Method 설명 : 과정이 등록되어있는지 확인해서 리턴
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_CLASS, method = RequestMethod.POST)
	public String class_check(String crc_class){
		ArrayList<SocietyEduAdminCurriculum> select_curriculum = seaService.select_curriculum();
		for(int i = 0; i < select_curriculum.size(); i++){
			if(select_curriculum.get(i).getCrc_class().equals(crc_class)){
				return "false";
			}
		}
		return "true";
	}
	
	
	/**
	 * @Method Name : update_gisu_crc_division
	 * @Date : 2018. 10. 8.
	 * @User : 김준영
	 * @Param : 구분자, gisu_seq
	 * @Return : 등록 메세지
	 * @Method 설명 : 링크 등록과 삭제를 위한 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_CURRICULUM_GISU_DIVISION_UPDATE, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String division_update(int division, int gisu_seq){
		
		ArrayList<SocietyEduAdminCurriculumGisu> select_gisu_crc_list = seaService.select_gisu_crc_nm();
		String check_msg = "";
		boolean check_division = true;
		
		if(division == 1){
			for (SocietyEduAdminCurriculumGisu list : select_gisu_crc_list) {
				if(list.getGisu_crc_division().equals("B2501")){
					check_msg = "서울 링크는 이미 등록되었습니다. 링크를 제거 하고 다시 등록해 주세요.";
					check_division = false;
					break;
				}
			}
			// 링크 구분 업데이트
			if(check_division){
				HashMap<String, Object> map = new HashMap<>();
				map.put("division", division);
				map.put("gisu_seq", gisu_seq);
				seaService.update_gisu_crc_division(map);
				check_msg = "링크 등록 완료";
			}
			
		} 
		if(division == 2){
			for (SocietyEduAdminCurriculumGisu list : select_gisu_crc_list) {
				if(list.getGisu_crc_division().equals("B2502")){
					check_msg = "광주 링크는 이미 등록되었습니다. 링크를 제거 하고 다시 등록해 주세요.";
					check_division = false;
					break;
				}
			}
			// 링크 구분 업데이트
			if(check_division){
				HashMap<String, Object> map = new HashMap<>();
				map.put("division", division);
				map.put("gisu_seq", gisu_seq);
				seaService.update_gisu_crc_division(map);
				check_msg = "링크 등록 완료";				
			}
		} 
		if(division == 0){
			// 링크 구분 업데이트
			HashMap<String, Object> map = new HashMap<>();
			map.put("division", division);
			map.put("gisu_seq", gisu_seq);
			seaService.update_gisu_crc_division(map);
			check_msg = "링크는 꼭 등록해야합니다.";
		}
		
		return check_msg;
	}
	
	/**
	 * @Method Name : copy_to_smp
	 * @Date : 2018. 12. 13.
	 * @User : 이종호
	 * @Param : 지원정보 리스트
	 * @Return : -
	 * @Method 설명 : 선택된 대상의 지원자 정보를 학사 정보로 복사
	 */
	
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_EDU_ADMIN_COPY_TO_SMP, method = RequestMethod.POST)
	public boolean copy_to_smp(@RequestBody ArrayList<SocietyEduApplyForm> app_array) {
		
		boolean result = false;
		
		for(SocietyEduApplyForm sf : app_array) {
			if(ssaService.smp_check_student(sf) == 0) {
				ssaService.smp_copy_studentinfo(sf.getApp_seq());
				result = true;
			}
		}
		
		return result;
	}
	
}
