package global.segroup.society.smtp.support.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.mypage.vo.PointSearchVo;
import com.aracomm.changbi.serviceCenter.service.BbsService;
import com.google.gson.Gson;

import global.segroup.domain.BoardPager;
import global.segroup.domain.OnlineConsultingContents;
import global.segroup.society.edu.apply.service.SocietyEduApplyService;
import global.segroup.society.smtp.support.service.SmtpSupportService;
import global.segroup.util.PathConstants;

@Controller
public class SmtpSupportController {
	
	private static final Logger logger = LoggerFactory.getLogger(SmtpSupportController.class);
	
	@Autowired
	private SmtpSupportService supportService;
	
	@Autowired
	private SocietyEduApplyService eduApplyService;
	
	@RequestMapping(value="/smtp/support/sub04-02", method=RequestMethod.GET)
	public String sub04_02(Model model, @RequestParam HashMap<String,Object> params) {
		
		logger.info("FAQ 페이지 이동 컨트롤러 시작");
		
		model.addAttribute("search", params);
		
		logger.info("FAQ 페이지 이동 컨트롤러 끝");		
		
		return"/segroup/society/smtp/support/sub04-02";
	}
	@RequestMapping(value="/smtp/support/faqList")
	public @ResponseBody Object bbslist(@RequestParam HashMap<String,Object> params, HttpSession session) {
		
		logger.info("faq 리스트 가져오기 컨트롤러 시작");
		
		List<HashMap<String, Object>> result = supportService.selectFaqList(params);
		
		logger.info("faq 리스트 가져오기 컨트롤러 종료");
		
		return result;
	}
	@RequestMapping(value="/smtp/support/sub04-03", method=RequestMethod.GET)
	public String sub04_03() {
		
		logger.info("오시는길 페이지 이동 컨트롤러 시작");
		logger.info("오시는길 페이지 이동 컨트롤러 끝");		
		
		return"/segroup/society/smtp/support/sub04-03";
	}
	
	@RequestMapping(value = "/smtp/support/sub04-04", method = RequestMethod.GET)
	public String sub04_04(Model model, Authentication auth,@RequestParam(defaultValue="contents") String searchOption,
            @RequestParam(defaultValue="") String keyword,
            @RequestParam(defaultValue="1") int curPage){
		BoardPager.setBLOCK_SCALE(25);
		BoardPager.setPAGE_SCALE(10);
		int consulting_tp=1000; // 온라인상담 부분 검색
		int count=eduApplyService.online_consulting_countBoard(searchOption,keyword,consulting_tp);
		BoardPager boardPager = new BoardPager(count, curPage);
		
		int start = boardPager.getPageBegin();
		int end = boardPager.getPageEnd();
		
		ArrayList<HashMap<String, Object>> boardList = (ArrayList<HashMap<String, Object>>) eduApplyService.online_consulting_boardListAll(start, end, searchOption, keyword, consulting_tp);
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("count", count); // 레코드의 갯수
	    map.put("searchOption", searchOption); // 검색옵션
	    map.put("keyword", keyword); // 검색키워드
	    map.put("boardPager", boardPager);
		    
		    for(int i=0;i<boardList.size();i++){
		    	String contents=  (((String) (boardList.get(i).get("consulting_title"))).replaceAll("\\<.*?>", "").substring(0,
						Math.min(((String) boardList.get(i).get("consulting_title")).replaceAll("\\<.*?>", "").length(), 150)));
		    	  if(contents.length()>51){
				    	contents=contents.substring(0,Math.min(contents.length(), 50));
				    	contents+="....";
				    }
		    	  boardList.get(i).put("consulting_title", contents);        
			}
		    
		    if (auth != null) {
		    	model.addAttribute("consulting_ins_id", auth.getName());
			}
		    
		    model.addAttribute("boardList", boardList);
			model.addAttribute("map", map);
			
		return PathConstants.SEGROUP_SOCIETY + "/smtp/support/sub04-04";
	}
	
	@RequestMapping(value = "/smtp/support/sub04-04-01", method = RequestMethod.GET)
	public String sub04_04_01(Model model, Authentication auth, int consulting_seq, String searchOption, HttpServletRequest request){
		
		logger.debug("온라인상담 게시판을 내용을 호출하는 컨트롤러 시작");
		
		eduApplyService.online_consulting_hit_update(consulting_seq);
		HashMap<String, Object> detail = null;
		if(searchOption==null){
			detail= eduApplyService.online_consulting_boardDetail(consulting_seq);
		} else if(searchOption.equals("next")){
			detail= eduApplyService.online_consulting_boardDetail(consulting_seq,searchOption);	
		} else if(searchOption.equals("previous")){
			detail= eduApplyService.online_consulting_boardDetail(consulting_seq,searchOption);	
		}
		if(detail==null){
			String referer = request.getHeader("Referer");
			return "redirect:"+ referer;
		}
		
		if (auth != null) {
	    	model.addAttribute("consulting_ins_id", auth.getName());
		}
		
		model.addAttribute("boardDetail", detail);
		
		logger.debug("온라인상담 게시판을 내용을 호출하는 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + "/smtp/support/sub04-04-01";
	}
	@ResponseBody
	@RequestMapping(value = "/smtp/support/apply_online", method = RequestMethod.POST)
	public boolean smtp_apply_online(Model model, Authentication auth, @ModelAttribute OnlineConsultingContents occ){
		logger.debug("온라인 상담 신청 컨트롤러 시작");
		
		boolean isRequested = false;

		if(eduApplyService.apply_online_insert(occ)) {
			isRequested = true;
			logger.debug("온라인 상담 신청 성공!");
			
//			seaService.online_consulting_admin_mail_send(occ, "온라인 상담 등록");
		}
		
		logger.debug("온라인 상담 신청 컨트롤러 종료");
		return isRequested;
	}
	@RequestMapping(value = "/smtp/support/sub04-04-03", method = RequestMethod.GET)
	public String sub04_04_02_update(int consulting_seq, Model model, Authentication auth){
		logger.debug("온라인상담 게시글 세부 내용 수정 폼 이동 컨트롤러 시작");
		
		HashMap<String, Object> resultMap = eduApplyService.online_consulting_boardDetail(consulting_seq);

		model.addAttribute("consulting_ins_id", auth.getName());
		model.addAttribute("contentDetail", resultMap);
		
		logger.debug("온라인상담 게시글 세부 내용 수정 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + "/smtp/support/sub04-04-03";
	}
//	
	@ResponseBody
	@RequestMapping(value = "/smtp/support/apply_online_udt", method = RequestMethod.POST)
	public boolean smtp_apply_online_udt(Model model, Authentication auth, @ModelAttribute OnlineConsultingContents occ){
		logger.debug("온라인 상담 수정 컨트롤러 시작");
		boolean isRequested = false;
		OnlineConsultingContents mail_occ = occ;

		if(eduApplyService.apply_online_update(occ)) {
			isRequested = true;
			logger.debug("온라인 상담 수정 성공!");
			
//			eduApplyService.online_consulting_admin_mail_send(mail_occ, "온라인 상담 수정");
		}
		
		logger.debug("온라인 상담 수정 컨트롤러 종료");
		return isRequested;
	}
	
	@ResponseBody
	@RequestMapping(value = "/smtp/support/apply_online_del", method = RequestMethod.POST)
	public boolean smtp_apply_online_del(Model model, Authentication auth, @ModelAttribute OnlineConsultingContents occ){
		logger.debug("온라인 상담 수정 컨트롤러 시작");
		
		boolean isRequested = false;
		OnlineConsultingContents mail_occ = occ;

		if(eduApplyService.apply_online_delete(occ)) {
			isRequested = true;
			logger.debug("온라인 상담 삭제 성공!");
			
//			eduApplyService.online_consulting_admin_mail_send(mail_occ, "온라인 상담 게시글 삭제");
		}
		
		logger.debug("온라인 상담 수정 컨트롤러 종료");
		return isRequested;
	}
	@RequestMapping(value = "/smtp/support/sub04-04-02" , method = RequestMethod.GET)
	public String sub04_04_02(Model model, Authentication auth){
		
		model.addAttribute("consulting_ins_id", auth.getName());
		
		return PathConstants.SEGROUP_SOCIETY + "/smtp/support/sub04-04-02";
	}
}
