package com.aracomm.changbi.mypage.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aracomm.base.common.AraCommConst;
import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.common.service.CommonService;
import com.aracomm.changbi.mypage.service.PrivateService;
import com.aracomm.changbi.user.vo.UserVo;

@Controller
@RequestMapping(value = "/mypage/private")
public class PrivateController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(PrivateController.class);

	@Value("#{servletContext.contextPath}")
	private String servletContextPath;

	@Resource(name="messageSource")
	private MessageSource messageSource;

	@Autowired
	private CommonService commonService;

	@Autowired
	private PrivateService service;

	@Autowired
	private BCryptPasswordEncoder bcpasswordEncoder;

	/**
	 * 회원정보 수정 화면
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/privateedit")
	public String privateedit(HttpSession session, Model model) {
		String user_id = getLoginUserIdWithException();

		// 회원정보 조회
		Map<String, Object> myinfo = service.selectMyInfo(user_id);
		String my_iden_di = (String)myinfo.get("IDEN_DI");
		if (StringUtils.isEmpty(my_iden_di)) {
			model.addAttribute("script", getMessageAndBackScript(getMessage(messageSource, "msg.mypage.notfoundiden")));
			return forward();
		}

		// 앞단계에서 본인인증을 거쳤는지 체크
		/*String ss_iden_di = (String)session.getAttribute(GlobalConst.SESSION_KEY_IDEN_DI);
		if (ss_iden_di == null || !ss_iden_di.equals((String)myinfo.get("IDEN_DI"))) {
			return "redirect:/mypage/private/privatecertification";
		}

		session.removeAttribute(GlobalConst.SESSION_KEY_IDEN_DI);*/

		// 기본코드
		model.addAttribute("emailList", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_EMAIL));
		model.addAttribute("phone1List", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_PHONE1));
		model.addAttribute("tel1List", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_TEL1));
		model.addAttribute("positionList", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_POSITION));
		model.addAttribute("regionList", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_REGION));
		model.addAttribute("localEduofficeList", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_LOCAL_EDUOFFICE));


		// 연락처
		String tel = (String)myinfo.get("TEL");
		if (!StringUtils.isEmpty(tel)) {
			String [] p = CommonUtil.splitTel(tel);
			myinfo.put("TEL1", p[0]);
			myinfo.put("TEL2", p[1]);
			myinfo.put("TEL3", p[2]);
		}
		String phone = (String)myinfo.get("PHONE");
		if (!StringUtils.isEmpty(phone)) {
			String [] p = CommonUtil.splitTel(phone);
			myinfo.put("PHONE1", p[0]);
			myinfo.put("PHONE2", p[1]);
			myinfo.put("PHONE3", p[2]);
		}

		// 이메일주소
		String email = (String)myinfo.get("EMAIL");
		if (!StringUtils.isEmpty(email)) {
			String [] e = CommonUtil.splitEmail(email);
			myinfo.put("EMAIL1", e[0]);
			myinfo.put("EMAIL2", e[1]);
		}

		model.addAttribute("myinfo", myinfo);

		return "mypage/private/privateedit";
	}

	/**
	 * 회원정보수정
	 * @param param
	 * @param attributes
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/doSave", method=RequestMethod.POST)
	public String doSave(@RequestParam Map<String, String> param, HttpSession session, RedirectAttributes attributes, Model model) {
		String user_id = getLoginUserIdWithException();
		param.put("user_id", user_id);

		// 비밀번호 암호화
		if (!StringUtils.isBlank(param.get("pw"))) {
			param.put("enc_pw", bcpasswordEncoder.encode(param.get("pw")));
		} else {
			param.put("enc_pw", "");
		}

		// 수신동의(이메일,SMS)
		if("Y".equals(param.get("recv_agree"))) {
			param.put("accept_email", "Y");
			param.put("accept_sms", "Y");
		} else {
			param.put("accept_email", "N");
			param.put("accept_sms", "N");
		}

		service.updateMember(param);

		UserVo userVo = getLoginUserInfo();
		userVo.setSchool_name(param.get("school_name"));

		session.removeAttribute(GlobalConst.SESSION_KEY_IDEN_DI);

		attributes.addFlashAttribute(AraCommConst.ACTION_MESSAGE_NAME, getMessage(messageSource, "msg.common.updated"));

		return "redirect:/mypage/lecture/lecture1";
	}

	/**
	 * 탈퇴 화면
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/secessionedit")
	public String secessionedit(HttpSession session, Model model) {
		String user_id = getLoginUserIdWithException();
		Map<String, String> myinfo = service.selectMyInfoForWithdraw(user_id);

		// 앞단계에서 본인인증을 거쳤는지 체크
		String ss_iden_di = (String)session.getAttribute(GlobalConst.SESSION_KEY_IDEN_DI);
		if (ss_iden_di == null || !ss_iden_di.equals(myinfo.get("IDEN_DI"))) {
			return "redirect:/mypage/private/secessioncertification";
		}

		session.removeAttribute(GlobalConst.SESSION_KEY_IDEN_DI);

		return "mypage/private/secessionedit";
	}

	/**
	 * 탈퇴처리
	 * @param param
	 * @param attributes
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/doWithdraw", method=RequestMethod.POST)
	public String doWithdraw(@RequestParam Map<String, String> param, HttpSession session, RedirectAttributes attributes, Model model) {
		String user_id = getLoginUserIdWithException();

		/* TOOD 고객요청사항으로 삭제예정
		// 필수 파라메터 체크
		checkNullParameterWithException(new String [] {"pw", "birth_day"}, param);

		Map<String, String> myinfo = service.selectMyInfoForWithdraw(user_id);

		// 생년월일과 비밀번호 일치 체크
		String enc_pw = encoder.saltEncoding(param.get("pw"), user_id);
		String birth_day = param.get("birth_day");

		if (myinfo == null || !enc_pw.equals(myinfo.get("PW")) || !birth_day.equals(myinfo.get("BIRTH_DAY"))) {
			model.addAttribute("script", getMessageAndBackScript(getMessage(messageSource, "msg.mypage.withrawfailed_notfound")));
			return forward();
		}
		*/

		param.put("user_id", user_id);
		service.saveWithdraw(param);

		model.addAttribute("script", getMessageAndMoveUrlScript(getMessage(messageSource, "msg.mypage.withdrawn"), AraCommConst.URL_LOGOUOT));

		session.removeAttribute(GlobalConst.SESSION_KEY_IDEN_DI);

		return forward();
	}

	@RequestMapping(value = "/{page}")
	public String page(Model model, @PathVariable("page") String page) {

		return "mypage/private/"+page;
	}
}
