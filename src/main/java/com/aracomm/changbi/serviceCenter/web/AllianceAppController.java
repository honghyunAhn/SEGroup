package com.aracomm.changbi.serviceCenter.web;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
//import org.apache.velocity.app.VelocityEngine;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
//import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aracomm.base.common.AraCommConst;
import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.common.service.CommonService;
import com.aracomm.changbi.ext.email.EmailSender;
import com.aracomm.changbi.ext.email.EmailVo;
import com.aracomm.changbi.member.service.MemberService;
import com.aracomm.changbi.serviceCenter.service.AllianceAppService;

@Controller
@RequestMapping(value="/serviceCenter/alliance")
public class AllianceAppController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(AllianceAppController.class);

	@Resource(name="messageSource")
	private MessageSource messageSource;

	@Autowired
	private AllianceAppService service;

	@Autowired
	private MemberService memberService;

	@Autowired
	private CommonService commonService;

	/*@Autowired
	private VelocityEngine velocityEngine;*/

	@Autowired
	EmailSender emailSender;

	@Value("#{config['Globals.Mail.NotiRecvMail']}")
	String notiRecvEmailAddr;

	/**
	 * 제휴문의 폼
	 * @param param
	 * @param model
	 * @param principal
	 * @return
	 */
	@RequestMapping(value = "/alliance")
	public String form(@RequestParam Map<String, String> param, Model model, Principal principal) {
		Map<String, Object> member = null;
		String user_id = (principal != null ? principal.getName() : null);
		if (!StringUtils.isEmpty(user_id)) {
			member = memberService.selectMember1(user_id);

			String phone = (String)member.get("PHONE");
			String email = (String)member.get("EMAIL");

			String [] phones = CommonUtil.splitTel(phone);
			member.put("PHONE1", phones[0]);
			member.put("PHONE2", phones[1]);
			member.put("PHONE3", phones[2]);

			String [] emails = CommonUtil.splitEmail(email);
			member.put("EMAIL1", emails[0]);
			member.put("EMAIL2", emails[1]);
		}

		model.addAttribute("emailList", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_EMAIL));
		model.addAttribute("phone1List", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_PHONE1));
		model.addAttribute("allianceTypeList", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_ALLIANCE_TYPE));

		model.addAttribute("member", member);

		return "serviceCenter/alliance";
	}

	/**
	 * 제휴문의 등록
	 * @param param
	 * @param model
	 * @param principal
	 * @param attributes
	 * @return
	 */
	@RequestMapping(value = "/apply", method=RequestMethod.POST)
	public String apply(@RequestParam Map<String, String> param, Model model, Principal principal, RedirectAttributes attributes) {

		// 필수 입력 체크
		checkNullParameterWithException(new String [] {"name", "phone"}, param);

		if (principal != null) param.put("user_id", principal.getName());	// 로그인 아이디

		String name = StringUtils.defaultString(param.get("name"), "noname") ;

		// 제휴신청등록
		service.insertAllianceApp(param);

		// 창비메일발송
		Map<String, Object> mailParam = new HashMap<String, Object>();
		mailParam.put("alliance", param);
		String mailContent="";// = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "email/alliance.vm", "UTF-8", mailParam);
		EmailVo emailVo = new EmailVo();
		emailVo.setReceiver(notiRecvEmailAddr);
		emailVo.setSubject(getMessage(messageSource, new String[] {name}, "email.subject.alliance"));
		emailVo.setContent(mailContent);
		try {
			emailSender.sendHtmlEmail(emailVo);
			logger.debug("alliance noti email sent");
		} catch (Exception e) {
			logger.error("email send error: ", e);
		}

		attributes.addFlashAttribute(AraCommConst.ACTION_MESSAGE_NAME, getMessage(messageSource, "msg.common.applied"));

		return "redirect:/serviceCenter/alliance/alliance";
	}
}
