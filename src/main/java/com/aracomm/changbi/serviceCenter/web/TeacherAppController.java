package com.aracomm.changbi.serviceCenter.web;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
/*import org.apache.velocity.app.VelocityEngine;*/
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
/*import org.springframework.ui.velocity.VelocityEngineUtils;*/
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aracomm.base.common.AraCommConst;
import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.base.common.util.FileUploadUtil;
import com.aracomm.base.common.vo.FileVo;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.common.service.CommonService;
import com.aracomm.changbi.ext.email.EmailSender;
import com.aracomm.changbi.ext.email.EmailVo;
import com.aracomm.changbi.member.service.MemberService;
import com.aracomm.changbi.serviceCenter.service.TeacherAppService;

@Controller
@RequestMapping(value="/serviceCenter/teacher")
public class TeacherAppController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(TeacherAppController.class);

	@Resource(name="messageSource")
	private MessageSource messageSource;

	@Autowired
	private TeacherAppService service;

	@Autowired
	private CommonService commonService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private FileUploadUtil fileUtil;

	@Value("#{config['upload.subdir.teacherapp']}")
	String teacher_app_upload_sub_dir;

	/*@Autowired
	private VelocityEngine velocityEngine;*/

	@Autowired
	EmailSender emailSender;

	@Value("#{config['Globals.Mail.NotiRecvMail']}")
	String notiRecvEmailAddr;

	/**
	 * 강사지원 폼
	 * @param param
	 * @param model
	 * @param principal
	 * @return
	 */
	@RequestMapping(value = "/teacher")
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
		model.addAttribute("courseList", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_COURSE));

		model.addAttribute("member", member);

		return "serviceCenter/teacher";
	}

	/**
	 * 강사지원 등록
	 * @param courses
	 * @param param
	 * @param filedatas
	 * @param principal
	 * @param attributes
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/apply", method=RequestMethod.POST)
	public String apply(@RequestParam String [] courses, @RequestParam Map<String, String> param, List<MultipartFile> filedatas, Principal principal, RedirectAttributes attributes, Model model) {

		// 필수 입력 체크
		checkNullParameterWithException(new String [] {"name", "phone"}, param);

		// 로그인 아이디
		String user_id = (principal != null ? principal.getName() : null);
		param.put("user_id", user_id);

		// 지원영수영역
		param.put("courses", StringUtils.join(courses, ","));

		// 첨부파일 처리 (화면단에서만 2개로 제한하고 실제 처리하는 곳은 제한하지 않음)
		List<FileVo> fileList = fileUtil.fileUpload(filedatas, teacher_app_upload_sub_dir);
		for(int i=0; i<fileList.size(); i++) {
			FileVo fileVo = fileList.get(i);
			fileVo.setUser(user_id);
			param.put("attach"+(i+1)+"_file", fileVo.getFile_id());
		}

		service.insertTeacherApp(param, fileList);

		// 창비메일발송
		String name = StringUtils.defaultString(param.get("name"), "noname") ;
		param.put("fileCnt", String.valueOf(fileList.size()));
		Map<String, Object> mailParam = new HashMap<String, Object>();
		mailParam.put("teacher", param);
		String mailContent ="";
		//VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "email/teacherapp.vm", "UTF-8", mailParam);
		EmailVo emailVo = new EmailVo();
		emailVo.setReceiver(notiRecvEmailAddr);
		emailVo.setSubject(getMessage(messageSource, new String[] {name}, "email.subject.teacherapp"));
		emailVo.setContent(mailContent);
		try {
			emailSender.sendHtmlEmail(emailVo);
			logger.debug("teacher apply noti email sent");
		} catch (Exception e) {
			logger.error("email send error: ", e);
		}

		attributes.addFlashAttribute(AraCommConst.ACTION_MESSAGE_NAME, getMessage(messageSource, "msg.common.applied"));

		return "redirect:/serviceCenter/teacher/teacher";
	}
}
