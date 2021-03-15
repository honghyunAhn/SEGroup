package com.aracomm.changbi.serviceCenter.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
//import org.apache.velocity.app.VelocityEngine;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
//import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aracomm.base.common.AraCommConst;
import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.base.common.util.FileUploadUtil;
import com.aracomm.base.common.vo.FileVo;
import com.aracomm.base.exceptions.InvalidAccessException;
import com.aracomm.base.exceptions.InvalidRightException;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.common.service.CommonService;
import com.aracomm.changbi.ext.email.EmailSender;
import com.aracomm.changbi.ext.email.EmailVo;
import com.aracomm.changbi.ext.sms.SmsSendService;
import com.aracomm.changbi.serviceCenter.service.BbsService;
import com.aracomm.changbi.user.vo.UserVo;

@Controller
@RequestMapping(value = "/serviceCenter/bbs")
public class BbsController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(BbsController.class);
	private final static int BBS_VIEW_TYPE_NOTICE = 0;
	private final static int BBS_VIEW_TYPE_QNA = 1;
	private final static int BBS_VIEW_TYPE_FAQ = 2;

	@Autowired
	private BbsService service;

	@Autowired
	private CommonService commonService;

	@Autowired
	private FileUploadUtil fileUtil;

	@Resource(name="messageSource")
	private MessageSource messageSource;

	@Value("#{config['boardPages']}")
	String boardPages;

	@Value("#{config['upload.subdir.boardfile']}")
	String boardfile_upload_sub_dir;

	@Value("#{config['Globals.Mail.NotiRecvMail']}")
	String notiRecvEmailAddr;

	@Value("#{config['sms.send.phone']}")
	private String smsSendPhone;

	@Value("#{config['sms.noti.phone']}")
	private String smsNotiPhone;

	/*@Autowired
	private VelocityEngine velocityEngine;*/

	@Autowired
	EmailSender emailSender;

	@Autowired
	private SmsSendService smsSendService;

	@RequestMapping(value = "/notice")
	public String notice(Model model, @RequestParam HashMap<String,String> param) {
		// bbs 리스트 공통 처리
		processCommonBbsList(boardPages, BBS_VIEW_TYPE_NOTICE, param, model);

		return "serviceCenter/bbs/notice";
	}

	@RequestMapping(value = "/noticeDetail")
	public String detail(Model model, @RequestParam HashMap<String,String> param) {
		processCommonBbsDetail(param, model);
		return "serviceCenter/bbs/noticedetail";
	}

	@RequestMapping(value = "/faq")
	public String faq(Model model, @RequestParam HashMap<String,String> param) {
		// bbs 리스트 공통 처리
		processCommonBbsList(boardPages, BBS_VIEW_TYPE_FAQ, param, model);
		model.addAttribute("bbscode", service.selectBbsCodeList(GlobalConst.CODE_GROUP_FQA));	// faq분류

		return "serviceCenter/bbs/faq";
	}

	@RequestMapping(value = "/qna")
	public String qna(Model model, @RequestParam HashMap<String,String> param) {

		Authentication auth = getAuthenticationWithException();	// 로그인 안됐으면 exception

		UserVo user = (UserVo) auth.getPrincipal();
		param.put("user_id", user.getUsername());

		// bbs 리스트 공통 처리
		processCommonBbsList(boardPages, BBS_VIEW_TYPE_QNA, param, model);

		return "serviceCenter/bbs/qna";
	}

	@RequestMapping(value = "/replyDetail")
	public String replyDetail(Model model, @RequestParam HashMap<String,String> param) {

		String loginId = getLoginUserIdWithException();	// 로그인 안됐으면 exception

		String boardType = param.get("board_type");
		model.addAttribute("board_type", boardType);

		HashMap<String, String> detail = service.selectReplayDetail(param.get("id"));

		String owner = detail.get("owner_user_id");

		// 보기 권한체크
		checkBbsOwnerWithException(loginId, owner, boardType, null);

		model.addAttribute("detail", detail);
		return "serviceCenter/bbs/replydetail";
	}


	@RequestMapping(value = "/program")
	public String program(Model model, @RequestParam HashMap<String,String> param) {
		// bbs 리스트 공통 처리
		processCommonBbsList(boardPages, BBS_VIEW_TYPE_NOTICE, param, model);

		return "serviceCenter/bbs/program";
	}


	@RequestMapping(value = "/programDetail")
	public String programDetail(Model model, @RequestParam HashMap<String,String> param) {
		processCommonBbsDetail(param, model);
		return "serviceCenter/bbs/programdetail";
	}

	@RequestMapping(value = "/write")
	public String write(Model model, @RequestParam HashMap<String, String> param) {
		Authentication auth = getAuthenticationWithException();	// 로그인 안됐으면 exception
		String loginId = auth.getName();

		if(!StringUtils.isBlank(param.get("id"))){
			HashMap<String, String> detail = service.selectBbsDetail(param);
			String owner = detail.get("user_id");
			String boardType = detail.get("board_type");
			String secretYn = detail.get("secret_yn");

			// 읽기 권한 체크 (1:1상담이나 비밀글은 자신만 볼 수 있음)
			if(GlobalConst.BBS_TYPE_QNA.equals(boardType) || "Y".equals(secretYn)) {
				if (!loginId.equals(owner)) {
					throw new InvalidAccessException();	// 잘못된 접근으로 보고 exception
				}
			}

			// 게시물 변경에 관한 권한
			Map<String, Boolean> bbsAuth = new HashMap<String, Boolean>();
			bbsAuth.put("modifyable", loginId.equals(owner));
			bbsAuth.put("deletable", loginId.equals(owner));
			model.addAttribute("bbsAuth", bbsAuth);

			processCommonBbsDetail(param, false, model);
		}
		return "serviceCenter/bbs/write";
	}

	@RequestMapping(value = "/writeDetail")
	public String writeDetail(Model model, @RequestParam HashMap<String,String> param) {
		Authentication auth = getAuthenticationWithException();	// 로그인 안됐으면 exception
		String loginId = auth.getName();

		HashMap<String, String> detail = service.selectBbsDetail(param);
		String owner = detail.get("user_id");
		String boardType = detail.get("board_type");
		String secretYn = detail.get("secret_yn");
		int replyCnt = CommonUtil.getIntValue(detail.get("reply_cnt"));

		checkBbsOwnerWithException(loginId, owner, boardType, secretYn);

		// 게시물 변경에 관한 권한
		Map<String, Boolean> bbsAuth = new HashMap<String, Boolean>();
		bbsAuth.put("modifyable", loginId.equals(owner) && (!GlobalConst.BBS_TYPE_CONSULT.equals(boardType) || replyCnt < 1));
		bbsAuth.put("deletable", loginId.equals(owner) && (!GlobalConst.BBS_TYPE_CONSULT.equals(boardType) || replyCnt < 1));
		model.addAttribute("bbsAuth", bbsAuth);

		processCommonBbsDetail(param, false, model);

		return "serviceCenter/bbs/writedetail";
	}

	@RequestMapping(value = "/writeDelete")
	public String writeDelete(@RequestParam HashMap<String,String> param, RedirectAttributes attributes, Model model) {
		String loginId = getLoginUserIdWithException();	// 로그인 안됐을 경우 exception

		// 권한체크 (작성자만 삭제 가능)
		Map<String, String> bbs = service.selectBbsForAuth(param.get("id"));
		if (bbs == null) throw new InvalidAccessException();
		String owner_id = bbs.get("user_id");
		if (!loginId.equals(owner_id)) throw new InvalidAccessException();

		String afterUrl = param.get("afterUrl");	// 처리후 이동 URL
		String listQuery = param.get("listQuery");	// URL 파라메터
		if (StringUtils.isEmpty(afterUrl)) afterUrl = "/serviceCenter/bbs/qna";

		String id = param.get("id");
		service.deleteBbs(id);

		attributes.addFlashAttribute(AraCommConst.ACTION_MESSAGE_NAME, getMessage(messageSource, "msg.common.deleted"));
		return "redirect:"+afterUrl + (afterUrl.indexOf("?")<0?"?":"") + listQuery;
	}

	@RequestMapping(value = "/writeSave")
	public String writeSave(HttpServletResponse response, @RequestParam HashMap<String, String> param, List<MultipartFile> filedatas, RedirectAttributes attributes, Model model) throws IOException {
		String loginId = getLoginUserIdWithException();	// 로그인 안됐을 경우 exception

		param.put("user", loginId);

		// 첨부파일 처리 (2개로 제한)
		List<FileVo> fileList = fileUtil.fileUpload(filedatas, boardfile_upload_sub_dir);
		if (fileList.size() > 0) {
			String attach1_file = param.get("attach1_file");
			String attach2_file = param.get("attach2_file");

			int fileCnt = fileList.size();
			int remainFileCnt = fileCnt;

			if (StringUtils.isEmpty(attach1_file) && remainFileCnt > 0) {
				FileVo fileVo = fileList.get(fileCnt-remainFileCnt);
				fileVo.setUser(loginId);
				param.put("attach1_file", fileVo.getFile_id());
				--remainFileCnt;
			}

			if (StringUtils.isEmpty(attach2_file) && remainFileCnt > 0) {
				FileVo fileVo = fileList.get(fileCnt-remainFileCnt);
				fileVo.setUser(loginId);
				param.put("attach2_file", fileVo.getFile_id());
				--remainFileCnt;
			}
		}

		String afterUrl = param.get("afterUrl");	// 처리후 이동 URL
		String listQuery = param.get("listQuery");	// URL 파라메터
		if (StringUtils.isEmpty(afterUrl)) afterUrl = "/serviceCenter/bbs/qna";

		int affected = 0;
		String id = param.get("id");	// 게시물 ID
		if (StringUtils.isBlank(id)) {	// 신규등록
			affected = service.insertBbs(param, fileList);
			if (affected > 0) {	// 성공
				String name = getLoginUserName();

				// 관리자 SMS 발송
				smsSendService.sendSms(smsNotiPhone, smsSendPhone, messageSource.getMessage("sms.1to1", new String [] {name}, Locale.getDefault()));
				logger.debug("1:1 cousel noti sms sent");


				// 관리자 EMAIL 발송
				Map<String, Object> mailParam = new HashMap<String, Object>();
				mailParam.put("data", param);
				mailParam.put("name", name);
				String mailContent="";// = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "email/one2one.vm", "UTF-8", mailParam);
				//String mailContent="";
				EmailVo emailVo = new EmailVo();
				emailVo.setReceiver(notiRecvEmailAddr);
				emailVo.setSubject(getMessage(messageSource, new String[] {name}, "email.subject.1to1"));
				emailVo.setContent(mailContent);
				try {
					emailSender.sendHtmlEmail(emailVo);
					logger.debug("1:1 counsel noti email sent");
				} catch (Exception e) {
					logger.error("email send error: ", e);
				}


				attributes.addFlashAttribute(AraCommConst.ACTION_MESSAGE_NAME, getMessage(messageSource, "msg.common.registered"));
				return "redirect:"+afterUrl + (afterUrl.indexOf("?")<0?"?":"") + listQuery;
			} else { // 실패
				model.addAttribute("script", getMessageAndBackScript(getMessage(messageSource, "msg.common.processFailed")));
				return forward();
			}

		} else {	// 수정
			// 권한체크 (작성자만 수정 가능)
			Map<String, String> bbs = service.selectBbsForAuth(id);
			if (bbs == null) throw new InvalidAccessException();
			String owner_id = bbs.get("user_id");
			if (!loginId.equals(owner_id)) throw new InvalidAccessException();

			affected = service.updateBbs(param, fileList);
			if (affected > 0) { // 성공
				attributes.addFlashAttribute(AraCommConst.ACTION_MESSAGE_NAME, getMessage(messageSource, "msg.common.updated"));
				return "redirect:"+afterUrl + (afterUrl.indexOf("?")<0?"?":"") + "id=" + id + "&" + listQuery;
			} else { // 실패
				model.addAttribute("script", getMessageAndBackScript(getMessage(messageSource, "msg.common.processFailed")));
				return forward();
			}
		}
	}

	@RequestMapping(value = "/deleteAttachFile")
	public String deleteAttachFile(@RequestParam String board_id, String file_id, Model model) {
		String loginId = getLoginUserIdWithException();	// 로그인 안됐을 경우 exception

		// 권한체크 (작성자만 삭제 가능)
		Map<String, String> bbs = service.selectBbsForAuth(board_id);
		if (bbs == null) throw new InvalidAccessException();
		String owner_id = bbs.get("user_id");
		if (!loginId.equals(owner_id)) throw new InvalidAccessException();

		service.deleteBbsAttachFile(board_id, file_id);

		model.addAttribute("script", getMessageAndBackScript(getMessage(messageSource, "msg.common.deleted")));
		return forward();
	}


	@RequestMapping(value = "/{page}")
	public String page(Model model, @PathVariable("page") String page) {
		return "serviceCenter/bbs/"+page;
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

	/**
	 * 게시물 접근 권한 체크
	 * @param loginId
	 * @param owner
	 * @param boardType
	 * @param secretYn
	 */
	private void checkBbsOwnerWithException(String loginId, String owner, String boardType, String secretYn) {
		// 1:1상담이나 비밀글은 자신만 볼 수 있고 수정할 수 있음
		if(GlobalConst.BBS_TYPE_CONSULT.equals(boardType) || "Y".equals(secretYn)) {
			if (StringUtils.isEmpty(loginId) || !loginId.equals(owner)) {
				throw new InvalidRightException();	// 권한없음 exception
			}
		}
	}

	/**
	 * 게시물 상세 공통 처리
	 * @param param
	 * @param model
	 */
	private void processCommonBbsDetail(HashMap<String,String> param, Model model) {
		processCommonBbsDetail(param, true, model);
	}
	private void processCommonBbsDetail(HashMap<String,String> param, boolean prevNext, Model model) {
		// 첨부파일 리스트
		List<String> file_ids = new ArrayList<String>();
        HashMap<String, String> detail = service.selectBbsDetail(param);
        String fileId = detail.get("attach1_file");
        if (!StringUtils.isEmpty(fileId)) file_ids.add(fileId);
        fileId = detail.get("attach2_file");
        if (!StringUtils.isEmpty(fileId)) file_ids.add(fileId);
        List<FileVo> fileList = null;
        if (file_ids.size() > 0) {
        	fileList = commonService.selectAttachFileListByIds(file_ids.toArray(new String[0]));
        }

        // 조회수 증가
        service.updateHits(param.get("id"));

		model.addAttribute("board_type", param.get("board_type"));
		model.addAttribute("detail", detail);
		model.addAttribute("fileList", fileList);

		if (prevNext) model.addAttribute("preNext", service.selectBbsDetailPrevNext(param));
	}
}
