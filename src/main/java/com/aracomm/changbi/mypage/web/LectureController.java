package com.aracomm.changbi.mypage.web;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aracomm.base.common.AraCommConst;
import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.base.common.util.FileUploadUtil;
import com.aracomm.base.common.vo.FileVo;
import com.aracomm.base.exceptions.InvalidAccessException;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.common.service.CommonService;
import com.aracomm.changbi.mypage.service.LectureService;
import com.aracomm.changbi.mypage.vo.SurveyResVo;
import com.aracomm.changbi.payment.KCPConfig;
import com.aracomm.changbi.payment.KcpPaymentParam;
import com.aracomm.changbi.payment.service.KcpPaymentService;
import com.aracomm.changbi.serviceCenter.service.BbsService;
import com.aracomm.changbi.user.dao.UserDao;

@Controller
@RequestMapping(value = "/mypage/lecture")
public class LectureController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(LectureController.class);

	private static final Object SURVEY_CODE_SATISFACTION = "survey999";	// ????????? ??????
	private static final Object SURVEY_CODE_EVALUATION = "survey001";	// ???????????? ??????

	@Autowired
	private LectureService service;

	@Autowired
	private BbsService bservice;

	@Autowired
	private CommonService commonService;

	@Autowired
	private KcpPaymentService paymentService;

	@Autowired
	private UserDao userDao;

	@Resource(name="messageSource")
	private MessageSource messageSource;

	@Autowired
	private FileUploadUtil fileUtil;

	@Value("#{config['chapter.open']}")
	private String chapter_open;

	@Value("#{config['chapter.begin']}")
	private String chapter_begin;

	@Value("#{config['upload.subdir.report']}")
	private String report_upload_sub_dir;

	@Value("#{config['boardPages']}")
	private int boardPages;

	@Value("#{config['upload.subdir.boardfile']}")
	private String boardfile_upload_sub_dir;

	@Autowired
	KCPConfig kcpConfig;

	@RequestMapping(value = "/{page}")
	public String page(Model model, @PathVariable("page") String page, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		model.addAttribute("classParam", params);
		model.addAttribute("pointInfo", service.selectPointInfo(params));
		model.addAttribute("couponInfo", service.selectCouponInfo(params));
		model.addAttribute("userInfo", service.selectUserInfo(params));
		model.addAttribute("progressList", service.selectProgressList(params));
		model.addAttribute("waitingList", service.selectWaitingList(params));
		model.addAttribute("completeList", service.selectCompleteList(params));
		model.addAttribute("bookInfo", service.selectBookInfo(params));
		model.addAttribute("phone1List", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_PHONE1));
		model.addAttribute("tel1List", commonService.selectGroupCodeList(GlobalConst.CODE_GROUP_TEL1));

		//????????????
		model.addAttribute("kcpConfig", kcpConfig);	// kcp ????????????

		return "mypage/lecture/"+page;
	}

	@RequestMapping(value="/classroom")
	public String classroom(Model model, @RequestParam HashMap<String,Object> params, Principal principal ) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,Object> classInfo = service.selectClassInfo(params);

		//????????? ?????? ????????? ????????? ???????????? ??????
		if (classInfo == null) throw new InvalidAccessException(getMessage(messageSource, "msg.mypage.invalidaccess"));

		long reviewDays = (long) classInfo.get("REVIEW_DAYS");
		//??????????????? ????????? ?????????????????? ????????? ??????
		if (reviewDays < 0) throw new InvalidAccessException(getMessage(messageSource, "msg.mypage.invalidaccess"));

		model.addAttribute("classParam", params);
		model.addAttribute("classInfo", classInfo);
		model.addAttribute("timeInfo", service.selectTimeInfo(params));
		model.addAttribute("jindoInfo", service.selectJinfoInfo(params));
		model.addAttribute("jindoList", service.selectJindoList(params));
		model.addAttribute("studyHist", service.selectClassStudyHist(params));

		return "mypage/lecture/classroom";
	}

	@RequestMapping(value="/notice")
	public String notice(Model model, @RequestParam HashMap<String,Object> params, Principal principal ) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,String> bbsParam = new HashMap<>();
		bbsParam.put("board_type", GlobalConst.BBS_TYPE_NOTICE);
		//bbsParam.put("cardinal_id", (String) params.get("cardinal")); // ???????????? ??? (????????????????????? ???????????? ??????)
		bbsParam.put("course_id", (String) params.get("course"));
		bbsParam.put("id", (String) params.get("bbsid"));
		bbsParam.put("search", (String) params.get("search"));
		bbsParam.put("searchbox", (String) params.get("searchbox"));

		String startPage = StringUtils.isBlank((String)params.get("startPage")) ? "1":(String)params.get("startPage");
		bbsParam.put("startPage",  CommonUtil.getStart(startPage, String.valueOf(boardPages)));
		bbsParam.put("visiblePages", String.valueOf(boardPages));

		int totalCnt = bservice.selectBbsListTotCnt(bbsParam);

		bbsParam.put("totalCnt", String.valueOf(totalCnt));
		bbsParam.put("totalPages", String.valueOf(CommonUtil.getTotalPage(totalCnt,boardPages)));

		model.addAttribute("classInfo", service.selectClassInfo(params));
		model.addAttribute("classParam", params);

		model.addAttribute("bbsList", bservice.selectBbsList(bbsParam));
		bbsParam.replace("startPage", startPage);
		model.addAttribute("bbsParam", bbsParam);

		return "mypage/lecture/notice";
	}

	@RequestMapping(value="/noticedetail")
	public String noticedetail(Model model, @RequestParam HashMap<String,Object> params, Principal principal ) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,String> bbsParam = new HashMap<>();
		bbsParam.put("board_type", GlobalConst.BBS_TYPE_NOTICE);
		bbsParam.put("cardinal_id", (String) params.get("cardinal"));
		bbsParam.put("course_id", (String) params.get("course"));
		bbsParam.put("id", (String) params.get("bbsid"));

		// ???????????? ?????????
		List<String> file_ids = new ArrayList<String>();

		HashMap<String, String> detail = bservice.selectBbsDetail(bbsParam);
		String fileId = detail.get("attach1_file");
        if (!StringUtils.isEmpty(fileId)) file_ids.add(fileId);
        fileId = detail.get("attach2_file");
        if (!StringUtils.isEmpty(fileId)) file_ids.add(fileId);
        List<FileVo> fileList = null;
        if (file_ids.size() > 0) {
        	fileList = commonService.selectAttachFileListByIds(file_ids.toArray(new String[0]));
        }

        model.addAttribute("detail", detail);
		model.addAttribute("fileList", fileList);

		model.addAttribute("classParam", params);
		model.addAttribute("bbsParam", bbsParam);

		return "mypage/lecture/noticedetail";
	}

	@RequestMapping(value="/lesson")
	public String lesson(Model model, @RequestParam HashMap<String,Object> params, Principal principal ) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,Object> classInfo = service.selectClassInfo(params);

		//????????? ?????? ????????? ????????? ???????????? ??????
		if (classInfo == null) throw new InvalidAccessException(getMessage(messageSource, "msg.mypage.invalidaccess"));

		long reviewDays = (long) classInfo.get("REVIEW_DAYS");
		//??????????????? ????????? ?????????????????? ????????? ??????
		if (reviewDays < 0) throw new InvalidAccessException(getMessage(messageSource, "msg.mypage.invalidaccess"));

		// ?????????, ???????????? ?????? ??????
		params.put("survey_code", SURVEY_CODE_SATISFACTION);// ????????? ??????
		Map<String, Object> poll_satisfaction = service.selectClassPollInfo(params);
		params.put("survey_code", SURVEY_CODE_EVALUATION);	// ???????????? ??????
		Map<String, Object> poll_evaluation = service.selectClassPollInfo(params);

		model.addAttribute("classParam", params);
		model.addAttribute("classInfo", classInfo);
		model.addAttribute("chapterList", service.selectChapterList(params));
		model.addAttribute("chapter_open", chapter_open);
		model.addAttribute("poll_satisfaction", poll_satisfaction);
		model.addAttribute("poll_evaluation", poll_evaluation);

		return "mypage/lecture/lesson";
	}

	@RequestMapping(value="/checkLessonReviewAjax")
	public @ResponseBody Object checkLessonReviewAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		params.put("board_type", GlobalConst.BBS_TYPE_REVIEW);

		HashMap<String, Object> result = new HashMap<>();

		int cnt = service.selectLessonReviewCnt(params);
		result.put("result", cnt>0?AraCommConst.TEXT_FAIL:AraCommConst.TEXT_SUCCESS);

		return result;
	}

	@RequestMapping(value="/saveLessonReview")
	public @ResponseBody Object saveLessonReview(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		params.put("board_type", GlobalConst.BBS_TYPE_REVIEW);

		HashMap<String, Object> result = new HashMap<>();

		int cnt = service.insertLessonReview(params);
		result.put("result", cnt>0?AraCommConst.TEXT_SUCCESS:AraCommConst.TEXT_FAIL);

		return result;
	}

	@RequestMapping(value="/report")
	public String report(Model model, @RequestParam HashMap<String,Object> params, Principal principal ) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		params.put("quiz_type", GlobalConst.QUIZ_REPORT);
		logger.info("?????? ?????? = " + params.toString());
		HashMap<String,Object> classInfo = service.selectClassInfo(params);

		//????????? ?????? ????????? ????????? ???????????? ??????
		if (classInfo == null) throw new InvalidAccessException(getMessage(messageSource, "msg.mypage.invalidaccess"));

		long reviewDays = (long) classInfo.get("REVIEW_DAYS");
		//??????????????? ????????? ?????????????????? ????????? ??????
		if (reviewDays < 0) throw new InvalidAccessException(getMessage(messageSource, "msg.mypage.invalidaccess"));


		model.addAttribute("classParam", params);
		model.addAttribute("classInfo", classInfo);
		model.addAttribute("examList", service.selectExamList(params));

		return "mypage/lecture/report";
	}

	@RequestMapping(value="/exam")
	public String exam(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		params.put("quiz_type", GlobalConst.QUIZ_EXAM);

		HashMap<String,Object> classInfo = service.selectClassInfo(params);

		//????????? ?????? ????????? ????????? ???????????? ??????
		if (classInfo == null) throw new InvalidAccessException(getMessage(messageSource, "msg.mypage.invalidaccess"));

		long reviewDays = (long) classInfo.get("REVIEW_DAYS");
		//??????????????? ????????? ?????????????????? ????????? ??????
		if (reviewDays < 0) throw new InvalidAccessException(getMessage(messageSource, "msg.mypage.invalidaccess"));


		model.addAttribute("classParam", params);
		model.addAttribute("classInfo", classInfo);
		model.addAttribute("examList", service.selectExamList(params));

		return "mypage/lecture/exam";
	}

	@RequestMapping(value="/examListAjax")
	public @ResponseBody Object examList(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,Object> result = new HashMap<>();

		HashMap<String, Object> examInfo = service.selectExamInfo(params);
		String limits = (String)examInfo.get("LIMITS");
		if (limits.contains("3")) {//???PC ??????????????? ??????, ??????PC????????? ?????? PASS, ??????PC????????? ???????????? ?????????????????? ????????????
			List<HashMap<String, String>> pcList = userDao.selectIpList(user_id);
			examInfo.put("REGIST_PC_COUNT", pcList!=null?pcList.size():0);
		}

		List<HashMap<String, Object>> list = service.selectExamItemList(params);

		// ???????????? ?????? ??? ???????????? ??????
		if (list != null && list.size() > 0) {
			examInfo.put("TAKE_COUNT", service.selectExamTakeCount(params));
		} else {
			examInfo.put("TAKE_COUNT", 0);
		}

		result.put("examInfo", examInfo);
		result.put("list", list );
		return result;
	}

	// ?????? ?????? ??????
	@RequestMapping(value="/examTakeHistAjax")
	public @ResponseBody Object examTakeHistAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,Object> result = new HashMap<>();
		try {
			result.put("result", service.insertExamTakeHistory(params));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", "FAILURE");
		}

		return result;
	}

	@RequestMapping(value="/examTakeAjax")
	public @ResponseBody Object examTake(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,Object> result = new HashMap<>();
		try {
			result.put("result", service.insertExamItemReply(params, null));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", "FAILURE");
		}

		return result;
	}

	@RequestMapping(value="/reportTakeAjax", method=RequestMethod.POST)
	public @ResponseBody Object reportTake(Model model, @RequestParam HashMap<String,Object> params , List<MultipartFile> reportfile, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,Object> result = new HashMap<>();

		// ???????????? ?????? (?????????????????? 2?????? ???????????? ?????? ???????????? ?????? ???????????? ??????)
		List<FileVo> fileList = fileUtil.fileUpload(reportfile, report_upload_sub_dir);
		for(int i=0; i<fileList.size(); i++) {
			FileVo fileVo = fileList.get(i);
			fileVo.setUser(user_id);
			params.put("fileid", fileVo.getFile_id());
		}

		try {
			result.put("result", service.insertExamItemReply(params, /*fileList*/reportfile));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", AraCommConst.TEXT_FAIL);
		}

		return result;
	}

	@RequestMapping(value="/editLocaleCodeAjax")
	public @ResponseBody Object editLocaleCodeAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,Object> result = new HashMap<>();
		try {
			result.put("result", service.editLocaleCode(params));
		} catch (Exception e) {
			result.put("result", AraCommConst.TEXT_FAIL);
		}

		return result;
	}

	@RequestMapping(value="/dataroom")
	public String dataroom(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,String> bbsParam = new HashMap<>();
		bbsParam.put("board_type", GlobalConst.BBS_TYPE_DATAROOM);
		//bbsParam.put("cardinal_id", (String) params.get("cardinal"));	// ???????????? ??? (????????????????????? ???????????? ??????)
		bbsParam.put("course_id", (String) params.get("course"));
		bbsParam.put("id", (String) params.get("bbsid"));
		bbsParam.put("search", (String) params.get("search"));
		bbsParam.put("searchbox", (String) params.get("searchbox"));
		String startPage = StringUtils.isBlank((String)params.get("startPage")) ? "1":(String)params.get("startPage");
		bbsParam.put("startPage",  CommonUtil.getStart(startPage, String.valueOf(boardPages)));
		bbsParam.put("visiblePages", String.valueOf(boardPages));

		int totalCnt = bservice.selectBbsListTotCnt(bbsParam);

		bbsParam.put("totalCnt", String.valueOf(totalCnt));
		bbsParam.put("totalPages", String.valueOf(CommonUtil.getTotalPage(totalCnt,boardPages)));

		model.addAttribute("classInfo", service.selectClassInfo(params));
		model.addAttribute("classParam", params);

		model.addAttribute("bbsList", bservice.selectBbsList(bbsParam));
		bbsParam.replace("startPage", startPage);
		model.addAttribute("bbsParam", bbsParam);

		return "mypage/lecture/dataroom";
	}

	@RequestMapping(value="datadetail")
	public String datadetail(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,String> bbsParam = new HashMap<>();
		bbsParam.put("board_type", GlobalConst.BBS_TYPE_DATAROOM);
		bbsParam.put("board_type", GlobalConst.BBS_TYPE_CONSULT);
		bbsParam.put("cardinal_id", (String) params.get("cardinal"));
		bbsParam.put("course_id", (String) params.get("course"));
		bbsParam.put("id", (String) params.get("bbsid"));

		// ???????????? ?????????
		List<String> file_ids = new ArrayList<String>();

		HashMap<String, String> detail = bservice.selectBbsDetail(bbsParam);
		String fileId = detail.get("attach1_file");
        if (!StringUtils.isEmpty(fileId)) file_ids.add(fileId);
        fileId = detail.get("attach2_file");
        if (!StringUtils.isEmpty(fileId)) file_ids.add(fileId);
        List<FileVo> fileList = null;
        if (file_ids.size() > 0) {
        	fileList = commonService.selectAttachFileListByIds(file_ids.toArray(new String[0]));
        }

        model.addAttribute("detail", detail);
		model.addAttribute("fileList", fileList);
		model.addAttribute("classParam", params);
		model.addAttribute("bbsParam", bbsParam);

		return "mypage/lecture/datadetail";
	}

	@RequestMapping(value="/qna")
	public String qna(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,String> bbsParam = new HashMap<>();
		bbsParam.put("board_type", GlobalConst.BBS_TYPE_QNA);
		bbsParam.put("cardinal_id", (String) params.get("cardinal"));
		bbsParam.put("course_id", (String) params.get("course"));
		bbsParam.put("id", (String) params.get("bbsid"));
		bbsParam.put("search", (String) params.get("search"));
		bbsParam.put("searchbox", (String) params.get("searchbox"));

		String startPage = StringUtils.isBlank((String)params.get("startPage")) ? "1":(String)params.get("startPage");
		bbsParam.put("startPage",  CommonUtil.getStart(startPage, String.valueOf(boardPages)));
		bbsParam.put("visiblePages", String.valueOf(boardPages));

		int totalCnt = bservice.selectQnaListTotCnt(bbsParam);

		bbsParam.put("totalCnt", String.valueOf(totalCnt));
		bbsParam.put("totalPages", String.valueOf(CommonUtil.getTotalPage(totalCnt,boardPages)));

		model.addAttribute("classInfo", service.selectClassInfo(params));
		model.addAttribute("classParam", params);

		model.addAttribute("bbsList", bservice.selectQnaList(bbsParam));
		bbsParam.replace("startPage", startPage);
		model.addAttribute("bbsParam", bbsParam);

		return "mypage/lecture/qna";
	}

	@RequestMapping(value="qnadetail")
	public String qnadetail(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,String> bbsParam = new HashMap<>();
		bbsParam.put("board_type", GlobalConst.BBS_TYPE_QNA);
		bbsParam.put("cardinal_id", (String) params.get("cardinal"));
		bbsParam.put("course_id", (String) params.get("course"));
		bbsParam.put("id", (String) params.get("bbsid"));

		// ???????????? ?????????
		List<String> file_ids = new ArrayList<String>();

		HashMap<String, String> detail = bservice.selectBbsDetail(bbsParam);
		String owner = detail.get("user_id");

		String fileId = detail.get("attach1_file");
        if (!StringUtils.isEmpty(fileId)) file_ids.add(fileId);
        fileId = detail.get("attach2_file");
        if (!StringUtils.isEmpty(fileId)) file_ids.add(fileId);
        List<FileVo> fileList = null;
        if (file_ids.size() > 0) {
        	fileList = commonService.selectAttachFileListByIds(file_ids.toArray(new String[0]));
        }

        bservice.updateHits((String) params.get("bbsid"));

        model.addAttribute("detail", detail);
		model.addAttribute("fileList", fileList);

		model.addAttribute("classParam", params);
		model.addAttribute("bbsParam", bbsParam);

		// ????????? ????????? ?????? ??????
		Map<String, Boolean> bbsAuth = new HashMap<String, Boolean>();
		bbsAuth.put("modifyable", user_id.equals(owner));
		bbsAuth.put("deletable", user_id.equals(owner));
		model.addAttribute("bbsAuth", bbsAuth);

		return "mypage/lecture/qnadetail";
	}

	@RequestMapping(value="replydetail")
	public String replydetail(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,String> bbsParam = new HashMap<>();
		bbsParam.put("board_type", GlobalConst.BBS_TYPE_QNA);
		bbsParam.put("cardinal_id", (String) params.get("cardinal"));
		bbsParam.put("course_id", (String) params.get("course"));
		bbsParam.put("id", (String) params.get("bbsid"));

		// ???????????? ?????????
		List<String> file_ids = new ArrayList<String>();

		HashMap<String, String> detail = bservice.selectReplayDetail((String) params.get("bbsid"));
		String fileId = detail.get("attach1_file");
        if (!StringUtils.isEmpty(fileId)) file_ids.add(fileId);
        fileId = detail.get("attach2_file");
        if (!StringUtils.isEmpty(fileId)) file_ids.add(fileId);
        List<FileVo> fileList = null;
        if (file_ids.size() > 0) {
        	fileList = commonService.selectAttachFileListByIds(file_ids.toArray(new String[0]));
        }

        model.addAttribute("detail", detail);
		model.addAttribute("fileList", fileList);

		model.addAttribute("classParam", params);
		model.addAttribute("bbsParam", bbsParam);

		return "mypage/lecture/qnadetail";
	}

	@RequestMapping(value="/qnawrite")
	public String qnawrite(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,String> bbsParam = new HashMap<>();
		bbsParam.put("board_type", GlobalConst.BBS_TYPE_QNA);
		bbsParam.put("cardinal_id", (String) params.get("cardinal"));
		bbsParam.put("course_id", (String) params.get("course"));
		bbsParam.put("id", (String) params.get("bbsid"));

		if(!StringUtils.isBlank(bbsParam.get("id"))){
			HashMap<String, String> detail =  bservice.selectBbsDetail(bbsParam);
			String owner = detail.get("user_id");

			// ????????? ????????? ?????? ??????
			Map<String, Boolean> bbsAuth = new HashMap<String, Boolean>();
			bbsAuth.put("modifyable", user_id.equals(owner));
			bbsAuth.put("deletable", user_id.equals(owner));
			model.addAttribute("bbsAuth", bbsAuth);

			// ???????????? ?????????
			List<String> file_ids = new ArrayList<String>();
			String fileId = detail.get("attach1_file");
	        if (!StringUtils.isEmpty(fileId)) file_ids.add(fileId);
	        fileId = detail.get("attach2_file");
	        if (!StringUtils.isEmpty(fileId)) file_ids.add(fileId);
	        List<FileVo> fileList = null;
	        if (file_ids.size() > 0) {
	        	fileList = commonService.selectAttachFileListByIds(file_ids.toArray(new String[0]));
	        }

	        model.addAttribute("detail", detail);
			model.addAttribute("fileList", fileList);
		}

		model.addAttribute("classParam", params);
		model.addAttribute("bbsParam", bbsParam);

		return "mypage/lecture/qnawrite";
	}

	@RequestMapping(value="/writeSave")
	public String writeSave(HttpServletResponse response, @RequestParam HashMap<String, String> params, List<MultipartFile> filedatas, RedirectAttributes attributes, Model model, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user", user_id);

		params.put("board_type", GlobalConst.BBS_TYPE_QNA);
		params.put("cardinal_id", params.get("cardinal"));
		params.put("course_id", params.get("course"));
		params.replace("id", params.get("bbsid"));

		// ???????????? ?????? (2?????? ??????)
		List<FileVo> fileList = fileUtil.fileUpload(filedatas, boardfile_upload_sub_dir);
		if (fileList.size() > 0) {
			String attach1_file = params.get("attach1_file");
			String attach2_file = params.get("attach2_file");

			int fileCnt = fileList.size();
			int remainFileCnt = fileCnt;

			if (StringUtils.isEmpty(attach1_file) && remainFileCnt > 0) {
				FileVo fileVo = fileList.get(fileCnt-remainFileCnt);
				fileVo.setUser(user_id);
				params.put("attach1_file", fileVo.getFile_id());
				--remainFileCnt;
			}

			if (StringUtils.isEmpty(attach2_file) && remainFileCnt > 0) {
				FileVo fileVo = fileList.get(fileCnt-remainFileCnt);
				fileVo.setUser(user_id);
				params.put("attach2_file", fileVo.getFile_id());
				--remainFileCnt;
			}
		}

		HashMap<String, String> classParam = new HashMap<>();
		classParam.put("cardinal", params.get("cardinal"));
		classParam.put("course", params.get("course"));
		classParam.put("id", params.get("id"));
		model.addAttribute("classParam", classParam);

		String listQuery = params.get("listQuery");	// URL ????????????

		int affected = 0;
		String bbsid = params.get("bbsid");	// ????????? ID
		if (StringUtils.isBlank(bbsid)) {//????????????
			affected = bservice.insertBbs(params, fileList);
			if (affected > 0) {	// ??????
				attributes.addFlashAttribute(AraCommConst.ACTION_MESSAGE_NAME, getMessage(messageSource, "msg.common.registered"));
				return "redirect:qna?" + listQuery;
			} else { // ??????
				model.addAttribute("script", getMessageAndBackScript(getMessage(messageSource, "msg.common.processFailed")));
				return "redirect:qna?" + listQuery;
			}
		} else {//??????
			// ???????????? (???????????? ?????? ??????)
			Map<String, String> bbs = bservice.selectBbsForAuth(bbsid);
			if (bbs == null) throw new InvalidAccessException();
			String owner_id = bbs.get("user_id");
			if (!user_id.equals(owner_id)) throw new InvalidAccessException();

			affected = bservice.updateBbs(params, fileList);
			if (affected > 0) {	// ??????
				attributes.addFlashAttribute(AraCommConst.ACTION_MESSAGE_NAME, getMessage(messageSource, "msg.common.updated"));
				return "redirect:qna?" + listQuery;
			} else { // ??????
				model.addAttribute("script", getMessageAndBackScript(getMessage(messageSource, "msg.common.processFailed")));
				return "redirect:qna?" + listQuery;
			}
		}
	}

	@RequestMapping(value="/writedelete")
	public String writeDelete(HttpServletResponse response, @RequestParam HashMap<String, String> params, RedirectAttributes attributes, Model model, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user", user_id);
		params.replace("id", params.get("bbsid"));

		String bbsid = params.get("bbsid");

		// ???????????? (???????????? ?????? ??????)
		Map<String, String> bbs = bservice.selectBbsForAuth(bbsid);
		if (bbs == null) throw new InvalidAccessException();
		String owner_id = bbs.get("user_id");
		if (!user_id.equals(owner_id)) throw new InvalidAccessException();

		bservice.deleteBbs(bbsid);

		String listQuery = params.get("listQuery");	// URL ????????????

		HashMap<String, String> classParam = new HashMap<>();
		classParam.put("cardinal", params.get("cardinal"));
		classParam.put("course", params.get("course"));
		classParam.put("id", params.get("id"));
		model.addAttribute("classParam", classParam);

		attributes.addFlashAttribute(AraCommConst.ACTION_MESSAGE_NAME, getMessage(messageSource, "msg.common.deleted"));
		return "redirect:qna?" + listQuery;
	}

	@RequestMapping(value = "/deleteAttachFile")
	public String deleteAttachFile(@RequestParam String board_id, String file_id, Model model) {
		String loginId = getLoginUserIdWithException();	// ????????? ????????? ?????? exception

		// ???????????? (???????????? ?????? ??????)
		Map<String, String> bbs = bservice.selectBbsForAuth(board_id);
		if (bbs == null) throw new InvalidAccessException();
		String owner_id = bbs.get("user_id");
		if (!loginId.equals(owner_id)) throw new InvalidAccessException();

		bservice.deleteBbsAttachFile(board_id, file_id);

		model.addAttribute("script", getMessageAndBackScript(getMessage(messageSource, "msg.common.deleted")));
		return forward();
	}

	@RequestMapping(value="/orderBookAjax")
	public @ResponseBody Object orderBookAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,Object> result = new HashMap<>();
		try {
			result.put("result", service.selectOrderBookList(params));
			result.put("userInfo", service.selectUserInfo(params));
			result.put("order_idx", CommonUtil.getOrderNumber(commonService.getDailySequence(GlobalConst.SEQ_NAME_ORDERNUMBER)));
		} catch (Exception e) {
			result.put("result", AraCommConst.TEXT_FAIL);
		}

		return result;
	}

	@RequestMapping(value="/payBookAjax")
	public @ResponseBody Object payBookAjax(Model model, @RequestParam HashMap<String,String> params, KcpPaymentParam kcpPaymentParam , List<MultipartFile> reportfile, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);

		// ????????? ??????
		params.put("user_id", user_id);
		kcpPaymentParam.setReg_user(user_id);

		int rst = 0;
		String message = getMessage(messageSource, "msg.mypage.book.sucess");

		String payment_type = params.get("payment_type");

		// PG ????????? ????????? ????????????
		if (GlobalConst.PAYMENT_TYPE_BANK.equals(payment_type) ||
				GlobalConst.PAYMENT_TYPE_VBANK.equals(payment_type) ||
				GlobalConst.PAYMENT_TYPE_CARD.equals(payment_type)) {

			logger.info("request approval");
			KcpPaymentParam paymentResult = paymentService.requestApproval(kcpPaymentParam);
			logger.debug("approval: {}", paymentResult);

			if(KcpPaymentParam.RESULT_SUCCESS.equals(paymentResult.getRes_cd())) {	// ????????????
				// DB??????(???????????? ??????, ???????????? ?????? ??????)
				try {
					// ??????????????? ?????? ????????? ??????
					if (GlobalConst.PAYMENT_TYPE_VBANK.equals(payment_type)) {
						params.put("payment_date", null);
						params.put("payment_yn", "N");

						params.put("payment_state", GlobalConst.PAYMENT_STATE_READY);	// ????????????: ?????????

						// ?????? ???????????? ?????? ?????????
						message = getMessage(messageSource
								, new String [] {
										paymentResult.getBankname()
										, paymentResult.getDepositor()
										, paymentResult.getAccount()
										, CommonUtil.getFormatDate(paymentResult.getVa_date(), "yyyyMMddHHmmss", "yyyy-MM-dd HH:mm")
								  }
								, "msg.mypage.book.success_vank");
					} else {
						params.put("payment_date", kcpPaymentParam.getApp_time());
						params.put("payment_yn", "Y");

						params.put("payment_state", GlobalConst.PAYMENT_STATE_DONE);	// ????????????: ????????????
					}

					rst = service.saveBookApp(params, kcpPaymentParam);

					logger.info("apply saved: "+rst);
				} catch (Exception ex) {
					logger.error("?????? ??? DB?????? ??????", ex);
				}

				// DB?????? ????????? ????????????
				if (rst == 0) {
					paymentResult = paymentService.requestCancelApproval(kcpPaymentParam);
					message = getMessage(messageSource, "msg.apply.failed");
					logger.info("cancel approval: {} - {}", paymentResult.getRes_cd(), paymentResult.getRes_msg());

					// ????????????
					if(!KcpPaymentParam.RESULT_SUCCESS.equals(paymentResult.getRes_cd())) {
						message = getMessage(messageSource, "msg.apply.approvalcancelfailed") + "\n" + "["+paymentResult.getRes_cd() + "]\n" + paymentResult.getRes_msg();
					}
				}

			} else {	// ????????????
				rst = 0;
				paymentService.insertKcpPayment(paymentResult);	// ?????????????????? ??????
				message = getMessage(messageSource,new String [] {paymentResult.getRes_cd(), paymentResult.getRes_msg()}, "msg.apply.approvalfailed");
				logger.info("apply saved: "+rst);
			}
		} else {
			params.put("payment_yn", "N");
			// real_payment ??? ????????? null ??? ????????? ???????????????.
			if (params.get("real_payment") != null && Integer.valueOf(params.get("real_payment")) > 0) {
				params.put("payment_state", GlobalConst.PAYMENT_STATE_READY);	// ????????????: ?????????
			} else {
				params.put("payment_state", GlobalConst.PAYMENT_STATE_DONE);	// ????????????: ??????
			}
			rst = service.insertBookApp(params);
		}

		HashMap<String, Object> result = null;
		if (rst < 1) {	// ????????????
			result = getAjaxFailResult(message);
		} else {
			result = getAjaxSuccessResult(message);
		}
		result.put("payment_type", payment_type);

		return result;
	}

	@RequestMapping(value="/classPollAjax")
	public @ResponseBody Object classPollAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		String type = (String)params.get("type");
		if ("2".equals(type)) {
			params.put("survey_code", SURVEY_CODE_SATISFACTION);// ????????? ??????
		} else {
			params.put("survey_code", SURVEY_CODE_EVALUATION);	// ???????????? ??????
		}

		HashMap<String,Object> result = new HashMap<>();
		try {
			result.put("result", AraCommConst.TEXT_SUCCESS);
			result.put("info", service.selectClassPollInfo(params));
			result.put("list", service.selectClassPollList(params));
		} catch (Exception e) {
			result.put("result", AraCommConst.TEXT_FAIL);
		}

		return result;
	}

	@RequestMapping(value="/saveClassPollAjax")
	public @ResponseBody Object saveClassPollAjax(Model model, SurveyResVo resVO, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		resVO.setUser_id(user_id);
		resVO.operate();

		HashMap<String,Object> result = new HashMap<>();
		try {
			int id = service.insertSurveyResponse(resVO);
			result.put("result", id>0?AraCommConst.TEXT_SUCCESS:AraCommConst.TEXT_FAIL);
		} catch (Exception e) {
			result.put("result", AraCommConst.TEXT_FAIL);
		}

		return result;
	}

	@RequestMapping(value="/selectMyOnlineExamAnswerAjax")
	public @ResponseBody Object selectMyOnlineExamAnswer(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		params.put("quiz_type", GlobalConst.QUIZ_EXAM);
		params.put("answeryn", "Y");

		HashMap<String,Object> result = new HashMap<>();
		try {
			HashMap<String, Object> examInfo = service.selectExamInfo(params);
			if (examInfo == null) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "?????? ????????? ?????????????????? ????????????.");
				return result;
			}

			HashMap<String, Object> reportInfo = service.selectReportInfo(params);
			if (reportInfo == null || reportInfo.get("MARK_YN").equals("N")) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "??????????????? ?????? ?????? ??? ?????????.");
				return result;
			}

			HashMap<String, Object> classInfo = service.selectClassInfo(params);
			List<HashMap<String, Object>> quizList = service.selectExamItemList(params);

			params.put("report_id", reportInfo.get("ID"));
			List<HashMap<String, Object>> replyList = service.selectExamReplyList(params);

			result.put("result", AraCommConst.TEXT_SUCCESS);
			result.put("classInfo", classInfo);
			result.put("examInfo", examInfo);
			result.put("reportInfo", reportInfo);
			result.put("quizList", quizList);
			result.put("replyList", replyList);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", AraCommConst.TEXT_FAIL);
			result.put("message", e.getMessage());
		}

		return result;
	}

	/**
	 * [?????? ?????? ????????? ??????]
	 * - ?????? ????????? ??????????????? ???.(CB_QUIZ)
	 * - ?????? ????????? ????????? ???????????? ????????????.(CB_EXAM_SPOT)
	 * - ???????????? 1???????????? ????????????.(CB_CARDINAL.ATT_EVAL_DATE - ??????????????????)
	 **/
	@RequestMapping(value="/selectExamSpotAjax")
	public @ResponseBody Object selectExamSpot(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		params.put("quiz_type", GlobalConst.QUIZ_OFFLINE);

		HashMap<String,Object> result = new HashMap<>();
		try {
			HashMap<String, Object> examInfo = service.selectExamInfo(params);
			if (examInfo == null) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "?????? ????????? ??????????????? ????????????.");
				return result;
			}

			String editable = (String) examInfo.get("EDITABLE");
			if (!"Y".equals(editable)) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "??????????????? ?????? ????????? ????????????.");
				return result;
			}

			List<HashMap<String, Object>> spotList = service.selectExamSpotList(params);
			if (spotList == null || spotList.size() == 0) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "?????? ???????????? ?????????????????? ????????????.");
				return result;
			}

			HashMap<String, Object> reportInfo = service.selectReportInfo(params);
			/*if (reportInfo != null) {
				result.put("result", GlobalConst.TEXT_FAIL);
				result.put("message", "?????? ???????????? ???????????? ?????????????????????.");
				return result;
			}*/

			result.put("result", AraCommConst.TEXT_SUCCESS);
			result.put("examInfo", examInfo);
			result.put("spotList", spotList);
			result.put("reportInfo", reportInfo);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", AraCommConst.TEXT_FAIL);

		}

		return result;
	}

	@RequestMapping(value="/saveExamSpotAjax")
	public @ResponseBody Object saveExamSpot(HttpServletRequest request, Model model, @RequestParam HashMap<String,Object> params /*,List<MultipartFile> userfile*/, RedirectAttributes attributes, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		params.put("quiz_type", GlobalConst.QUIZ_OFFLINE);

		HashMap<String,Object> result = new HashMap<>();

		List<FileVo> fileList = null;
		/*List<FileVo> fileList = fileUtil.fileUpload(userfile, report_upload_sub_dir);
		for(int i=0; i<fileList.size(); i++) {
			FileVo fileVo = fileList.get(i);
			fileVo.setUser(user_id);
			params.put("fileid", fileVo.getFile_id());
		}*/

		try {
			result.put("result", service.saveExamSpot(params, fileList));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", AraCommConst.TEXT_FAIL);
		}

		return result;
	}

	/**
	 * [?????? ?????? ?????? ??????]
	 * - ?????? ????????? ??????????????? ???.(CB_QUIZ)
	 * - ?????? ?????? ????????????????????? 'Y'?????? ???.(CB_QUIZ.OPEN_YN)
	 **/
	@RequestMapping(value="/selectExamAnswerAjax")
	public @ResponseBody Object selectExamAnswer(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		params.put("quiz_type", GlobalConst.QUIZ_OFFLINE);
		params.put("answeryn", "Y");

		HashMap<String,Object> result = new HashMap<>();
		try {
			HashMap<String, Object> examInfo = service.selectExamInfo(params);
			if (examInfo == null) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "?????? ????????? ??????????????? ????????????.");
				return result;
			}

			HashMap<String, Object> reportInfo = service.selectReportInfo(params);
			if (reportInfo == null || examInfo.get("OPEN_YN").equals("N")) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "?????? ?????? ?????? ?????? ??? ?????????.");
				return result;
			}

			HashMap<String, Object> classInfo = service.selectClassInfo(params);
			List<HashMap<String, Object>> quizList = service.selectExamItemList(params);

			result.put("result", AraCommConst.TEXT_SUCCESS);
			result.put("classInfo", classInfo);
			result.put("examInfo", examInfo);
			result.put("reportInfo", reportInfo);
			result.put("quizList", quizList);
		} catch (Exception e) {
			result.put("result", AraCommConst.TEXT_FAIL);
		}

		return result;
	}

	/**
	 * [?????? ?????? ?????? ??????]
	 * - ?????? ????????? ??????????????? ???.(CB_QUIZ)
	 * - ?????? ?????? ????????????????????? 'Y'?????? ???.(CB_QUIZ.OPEN_YN)
	 * - ?????? ?????? ??????????????? 'Y'?????? ???.(CB_REPORT.MARK_YN)
	 **/
	@RequestMapping(value="/selectMyOfflineExamAnswerAjax")
	public @ResponseBody Object selectMyOfflineExamAnswer(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		params.put("quiz_type", GlobalConst.QUIZ_OFFLINE);
		params.put("answeryn", "Y");

		HashMap<String,Object> result = new HashMap<>();
		try {
			HashMap<String, Object> examInfo = service.selectExamInfo(params);
			if (examInfo == null) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "?????? ????????? ??????????????? ????????????.");
				return result;
			}

			HashMap<String, Object> reportInfo = service.selectReportInfo(params);
			if (reportInfo == null || reportInfo.get("MARK_YN").equals("N") || examInfo.get("OPEN_YN").equals("N")) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "?????? ?????? ?????? ?????? ??? ?????????.");
				return result;
			}

			HashMap<String, Object> classInfo = service.selectClassInfo(params);
			List<HashMap<String, Object>> quizList = service.selectExamItemList(params);

			result.put("result", AraCommConst.TEXT_SUCCESS);
			result.put("classInfo", classInfo);
			result.put("examInfo", examInfo);
			result.put("reportInfo", reportInfo);
			result.put("quizList", quizList);
		} catch (Exception e) {
			result.put("result", AraCommConst.TEXT_FAIL);
		}

		return result;
	}

	/**
	 * [?????? ?????? ????????? ??????]
	 * - ?????? ????????? ??????????????? ???.(CB_QUIZ)
	 * - ?????? ????????? ????????? ???????????? ????????????.(CB_EXAM_SPOT)
	 **/
	@RequestMapping(value="/selectExamPrintAjax")
	public @ResponseBody Object selectExamPrint(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		params.put("quiz_type", GlobalConst.QUIZ_OFFLINE);

		HashMap<String,Object> result = new HashMap<>();
		try {
			HashMap<String, Object> examInfo = service.selectExamInfo(params);
			if (examInfo == null) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "?????? ????????? ??????????????? ????????????.");
				return result;
			}

			HashMap<String, Object> reportInfo = service.selectReportInfo(params);
			if (reportInfo == null) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "?????? ?????? ???????????? ??????????????? ?????????.");
				return result;
			}

			HashMap<String, Object> classInfo = service.selectClassInfo(params);
			result.put("result", AraCommConst.TEXT_SUCCESS);
			result.put("examInfo", examInfo);
			result.put("reportInfo", reportInfo);
			result.put("classInfo", classInfo);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", AraCommConst.TEXT_FAIL);
		}

		return result;
	}

	@RequestMapping(value="/cancelWaitingAppAjax", method=RequestMethod.POST)
	public @ResponseBody Object cancelWaitingAppAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,Object> result = new HashMap<>();

		HashMap<String, Object> classInfo = service.selectClassInfo(params);
		if (classInfo == null) {
			//?????? ?????? ????????? ?????? ?????? ??????. ?????? ???????????? ?????? ????????? ??????
			result.put("result", AraCommConst.TEXT_FAIL);
			result.put("message", getMessage(messageSource, "msg.mypage.invalidaccess"));
			return result;
		}

		int rst = service.updateCancelWaitingApp(params);
		if (rst > 0) {
			result.put("result", AraCommConst.TEXT_SUCCESS);
		} else {
			result.put("result", AraCommConst.TEXT_FAIL);
		}

		return result;
	}
}
