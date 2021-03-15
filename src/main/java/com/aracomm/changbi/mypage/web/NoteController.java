package com.aracomm.changbi.mypage.web;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.base.common.AraCommConst;
import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.common.service.CommonService;
import com.aracomm.changbi.mypage.service.NoteService;
import com.aracomm.changbi.mypage.vo.NoteSearchVo;

@Controller
@RequestMapping(value = "/mypage/note")
public class NoteController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(NoteController.class);
	private static final String NOTE_VIEW_GUBUN_RECEIVED = "R";	// 받은쪽지함 보기
	private static final String NOTE_VIEW_GUBUN_SENT = "S";		// 보낸편지함 보기

	@Autowired
	private NoteService service;

	@Resource(name="messageSource")
	private MessageSource messageSource;

	@Value("#{config['boardPages']}")
	int boardPages;

	@RequestMapping(value = "/received")
	public String received(NoteSearchVo searchVo, Model model) {
		searchVo.setVisiblePages(boardPages);
		searchVo.setUser_id(getLoginUserId());
		searchVo.setGubun(NOTE_VIEW_GUBUN_RECEIVED);

		List<Map<String, Object>> noteList = service.selectNoteList(searchVo);

		model.addAttribute("searchVo", searchVo);
		model.addAttribute("noteList", noteList);

		return "mypage/note/list";
	}

	@RequestMapping(value = "/sent")
	public String sent(NoteSearchVo searchVo, Model model) {

		searchVo.setUser_id(getLoginUserId());
		searchVo.setVisiblePages(boardPages);
		searchVo.setGubun(NOTE_VIEW_GUBUN_SENT);
		List<Map<String, Object>> noteList = service.selectNoteList(searchVo);

		model.addAttribute("searchVo", searchVo);
		model.addAttribute("noteList", noteList);

		return "mypage/note/list";
	}

	@RequestMapping(value = "/view")
	public String noteDetail(NoteSearchVo searchVo, Model model) {
		searchVo.setUser_id(getLoginUserId());
		Map<String, Object> note = service.selectNoteWithView(searchVo);	// 읽음 업데이트 및 조회

		model.addAttribute("searchVo", searchVo);
		model.addAttribute("note", note);

		return "mypage/note/view";
	}

	@RequestMapping(value = "/form")
	public String form(NoteSearchVo searchVo, Model model) {

		String note_id = searchVo.getId();
		if(!StringUtils.isBlank(note_id)) {
			searchVo.setUser_id(getLoginUserId());
			model.addAttribute("note", service.selectNote(searchVo));
		}

		return "mypage/note/form";
	}

	@RequestMapping(value = "/send", method=RequestMethod.POST)
	public String send(@RequestParam Map<String, Object> param, RedirectAttributes attributes, Model model) {

		param.put("from_user_id", getLoginUserId());
		service.insertNote(param);

		attributes.addFlashAttribute(AraCommConst.ACTION_MESSAGE_NAME, getMessage(messageSource, "msg.note.sent"));

		return "redirect:/mypage/note/sent";
	}

	@RequestMapping(value = "/delete", method=RequestMethod.POST)
	public String delete(NoteSearchVo searchVo, RedirectAttributes attributes, Model model) {

		searchVo.setUser_id(getLoginUserId());
		int affected = service.deleteNote(searchVo);

		attributes.addFlashAttribute(AraCommConst.ACTION_MESSAGE_NAME, getMessage(messageSource, "msg.common.deleted"));

		String redirectUrl = "redirect:/mypage/note/received";
		if (NOTE_VIEW_GUBUN_SENT.equals(searchVo.getGubun())) {
			redirectUrl = "redirect:/mypage/note/sent";
		}

		return redirectUrl;
	}

}
