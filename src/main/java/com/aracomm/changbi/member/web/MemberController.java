package com.aracomm.changbi.member.web;

import java.security.Principal;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.base.exceptions.InvalidAccessException;
import com.aracomm.base.exceptions.UserMustLoginException;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.common.service.CommonService;
import com.aracomm.changbi.common.util.SmsUtil;
import com.aracomm.changbi.member.service.MemberService;
import com.aracomm.changbi.member.vo.IdenForm;
import com.aracomm.changbi.member.vo.MemberForm;
import com.aracomm.changbi.member.vo.SchoolForm;


@Controller
@RequestMapping(value = "/member")
@SessionAttributes("memberForm")
public class MemberController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	private static final String NEIS_LOCALCODE_TEMP = "Z99";	// 임시발급지역번호
	
	private static final String MEMBER_GRADE = "1"; // 일반회원

	@Value("#{config['sms.send.phone']}")
	private String smsSendPhone;

	@Resource(name="messageSource")
	private MessageSource messageSource;

	@Autowired
	private BCryptPasswordEncoder bcpasswordEncoder;

	@Autowired
	private CommonService commonService;

	@Autowired
	private MemberService service;

	@Autowired
	private SmsUtil smsUtil;

	@ModelAttribute("memberForm")
   public MemberForm setUpMemberForm() {
		return new MemberForm();
   }

	/**
	 * 회원정보입력폼
	 * @param model
	 * @param identForm
	 * @return
	 */
	@RequestMapping(value = "/join2")
	public String join2(@ModelAttribute("memberForm") MemberForm memberForm, IdenForm identForm, Model model) {
		logger.debug("identForm: {}", identForm);

		/*if (StringUtils.isBlank(memberForm.getIden_di())) {	// 본인인증 없이 접근
			throw new InvalidAccessException();
		}*/

		/*model.addAttribute("emailList", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_EMAIL));
		model.addAttribute("phone1List", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_PHONE1));
		model.addAttribute("tel1List", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_TEL1));*/

		/*
		// 추천인 포인트 정책
		Map<String, Object> pointPolicy = pointService.selectPolicyPoint();
		String useYn = (String)pointPolicy.get("SAVE_RECOMM_USE");
		int recommPoint = 0;
		if("Y".equals(useYn)) {
			recommPoint = (Integer)pointPolicy.get("SAVE_RECOMM_POINT");
		}
		model.addAttribute("recommPoint", recommPoint);
		*/

		/*if (StringUtils.isEmpty(memberForm.getId())) {	// 등록폼에서 취소를 통해서 접근한 경우가 아닌 경우
			// 본인인증데이터를 통해 입력 기본값 설정
			memberForm.setName(identForm.getName());
			memberForm.setBirth_day(identForm.getBirth_day());
			memberForm.setGender(identForm.getGender());
			String [] p = CommonUtil.splitTel(identForm.getPhone());
			memberForm.setPhone1(p[0]);
			memberForm.setPhone2(p[1]);
			memberForm.setPhone3(p[2]);
			memberForm.setPhone(p[0]+p[1]+p[2]);
		}

		model.addAttribute("identForm", identForm);*/

		return "member/join2";
	}

	/**
	 * 교육기관정보입력폼
	 * @param model
	 * @param identInfo
	 * @return
	 */
	@RequestMapping(value = "/join3")
	public String join3(MemberForm memberForm, Model model) {
		if (StringUtils.isBlank(memberForm.getIden_di())) {	// 앞단계 입력 없이 접근
			throw new InvalidAccessException();
		}

		model.addAttribute("memberForm", memberForm);
		model.addAttribute("positionList", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_POSITION));
		model.addAttribute("regionList", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_REGION));
		model.addAttribute("localEduofficeList", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_LOCAL_EDUOFFICE));

		return "member/join3";
	}

	/**
	 * 본인인증ci로 회원정보 조회
	 * @param model
	 * @param iden_di
	 * @return
	 */
	@RequestMapping(value = "/ajaxCheckAlreadyExist")
	public @ResponseBody HashMap<String, Object> ajaxCheckAlreadyExist(Model model, @RequestParam String iden_di) {
		HashMap<String, Object> result = getDefaultAjaxSuccessResult();

		result.put("INFO", service.selectValidMemberByDi(iden_di));

		return result;
	}

	/**
	 * 아이디 중복 체크 (LMS 동시 사용)
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/ajaxCheckDuplId")
	public @ResponseBody HashMap<String, Object> ajaxCheckDuplId(Model model, @RequestParam String id) {
		HashMap<String, Object> result = getDefaultAjaxSuccessResult();

		result.put("DUPL_YN", service.selectMemberCountById(id) > 0 ? "Y" : "N");

		return result;
	}

	/**
	 * 아이디 존재 여부 체크
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/ajaxCheckExistId")
	public @ResponseBody HashMap<String, Object> ajaxCheckExistId(Model model, @RequestParam String id) {
		HashMap<String, Object> result = getDefaultAjaxSuccessResult();

		result.put("EXIST_YN", service.selectValidMemberCountById(id) > 0 ? "Y" : "N");

		return result;
	}

	/**
	 * NEIS개인번호 중복 체크
	 * @param model
	 * @param neis_num
	 * @return
	 */
	@RequestMapping(value = "/ajaxCheckDuplNeis")
	public @ResponseBody HashMap<String, Object> ajaxCheckDuplNeis(Model model, @RequestParam String neis_num) {
		HashMap<String, Object> result = getDefaultAjaxSuccessResult();

		// 임시발급의 경우 중복체크 x (수정범위 최소화 기준으로 수정)
		int cnt = 0;
		if (neis_num.indexOf(NEIS_LOCALCODE_TEMP) != 0) cnt = service.selectMemberCountByNeis(neis_num);

		result.put("DUPL_YN", cnt > 0 ? "Y" : "N");
		return result;
	}

	/**
	 * NEIS개인번호 중복 체크 (로그인 사용자 대상)
	 *
	 * @param model
	 * @param neis_num
	 * @return
	 */
	@RequestMapping(value = "/ajaxUserCheckDuplNeis")
	public @ResponseBody HashMap<String, Object> ajaxUserCheckDuplNeis(Model model, @RequestParam String neis_num) {
		String user_id = getLoginUserIdWithException();
		HashMap<String, Object> result = getDefaultAjaxSuccessResult();

		// 임시발급의 경우 중복체크 x (수정범위 최소화 기준으로 수정)
		int cnt = 0;
		if (neis_num.indexOf(NEIS_LOCALCODE_TEMP) != 0) cnt = service.selectMemberCountByNeis(neis_num, user_id);

		result.put("DUPL_YN", cnt > 0 ? "Y" : "N");
		return result;
	}

	/**
	 * 회원 등록
	 * @param memberForm
	 * @param schoolForm
	 * @param sessionStatus
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/ajaxDoJoin", method=RequestMethod.POST)
	public @ResponseBody Object ajaxDoJoin(@ModelAttribute("memberForm") MemberForm memberForm, SchoolForm schoolForm, SessionStatus sessionStatus, Model model){
		HashMap<String, Object> result = getDefaultAjaxSuccessResult();
		
		// 비밀번호 암호화
		memberForm.setEnc_pw(bcpasswordEncoder.encode(memberForm.getPw()));
		memberForm.setGrade(MEMBER_GRADE);
		memberForm.setSchoolForm(schoolForm);

		// 사용자 등록 및 포인트 등록
		service.saveMember(memberForm);

		sessionStatus.setComplete();

		result.put("ID", memberForm.getId());

		return result;
	}
	

	/**
	 * 아이디 찾기
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/findId")
	public String findId(Model model) {
		model.addAttribute("phone1List", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_PHONE1));
		return "member/findId";
	}

	/**
	 * 아이디 조회
	 * @param name
	 * @param phone
	 * @return
	 */
	@RequestMapping(value = "/ajaxFindId", method=RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> ajaxFindId(String name, String phone){
		HashMap<String, Object> result = null;

		// 회원찾기
		Map<String, String> member = service.selectMemberForFindId(name, phone);

		if (member != null) {
			result = getDefaultAjaxSuccessResult();
			result.put("ID", member.get("ID"));
		} else {
			result = getAjaxFailResult(getMessage(messageSource, "msg.findid.notfound"));
		}

		return result;
	}

	@RequestMapping(value = "/findPw")
	public String findPw(Model model) {
		model.addAttribute("phone1List", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_PHONE1));
		return "member/findPw";
	}

	/**
	 * 비밀번호 문자발송
	 * @param id
	 * @param phone
	 * @return
	 */
	@RequestMapping(value = "/ajaxFindPw", method=RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> ajaxFindPw(String id, String phone){
		HashMap<String, Object> result = null;

		// 회원찾기
		Map<String, String> member = service.selectMemberForFindPw(id, phone);

		if (member == null) {
			result = getAjaxFailResult(getMessage(messageSource, "msg.findpw.notfound"));
			return result;
		}

		// 사용자 비밀번호를 6자리 임시비밀번호로 초기화
		String pw = CommonUtil.generateRandomString(6);
		String enc_pw = bcpasswordEncoder.encode(pw);
		service.updateTempPassword(id, phone, enc_pw);

		logger.debug("init: {}", pw);		// TODO SMS 연동 후 삭제할 것
		
		String title = "비밀번호 찾기";
		String message = messageSource.getMessage("sms.resetPassword", new String [] {pw}, Locale.getDefault());
		
		boolean result_flag = smsUtil.send_sms(id, phone, message, title, null, null);
		
		if (!result_flag) {
			result = getAjaxFailResult(getMessage(messageSource, "msg.findpw.smsfail"));
		} else {
			result = getDefaultAjaxSuccessResult();
		}

		return result;
	}

	/**
	 * 비밀번호변경
	 * @param cpw
	 * @param pw
	 * @param principal
	 * @return
	 */
	@RequestMapping(value = "/ajaxChangePw", method=RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> ajaxChangePw(String cpw, String pw, Principal principal){
		HashMap<String, Object> result = null;

		String id = null;

		if (principal == null || StringUtils.isBlank(id = principal.getName())) {
			throw new UserMustLoginException();
		}

		// 기존 비밀번호 확인
		int cnt = service.selectMemberCountByIdPasswd(id, bcpasswordEncoder.encode(cpw));

		if(cnt < 1) {
			result = getAjaxFailResult(getMessage(messageSource, "msg.changepw.notfound"));
			return result;
		}

		// 비밀번호 갱신
		int affected = service.updatePassword(id, bcpasswordEncoder.encode(pw));

		if (affected < 1) {
			result = getAjaxFailResult(getMessage(messageSource, "msg.changepw.failed"));
		} else {
			result = getDefaultAjaxSuccessResult();
		}

		return result;
	}
	
   //이메일 중복확인
	@RequestMapping(value="/ajaxCheckEmailDuplicated", method=RequestMethod.GET)
	public @ResponseBody boolean ajaxCheckEmailDuplicated(String email){
		 
		boolean isDuplicated =false;
		int affected = service.checkEmailDuplicated(email);
		 if(affected>0){
			 isDuplicated = true;		 
		 }
		 return isDuplicated;
	}


	@RequestMapping(value = "/{page}")
	public String page(Model model, @PathVariable("page") String page) {
		return "member/"+page;
	}
	



}
