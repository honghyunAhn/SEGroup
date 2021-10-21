package global.segroup.society.smtp.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Set;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aracomm.base.common.FileDownloadView;
import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.base.common.vo.FileVo;
import com.aracomm.changbi.mypage.service.LectureService;
import com.aracomm.changbi.user.service.MyLectureService;
import com.aracomm.changbi.user.web.MyLectureController;

@Controller
public class SmtpMyLectureController {

	private static final Logger logger = LoggerFactory.getLogger(MyLectureController.class);
	
	@Autowired
	private MyLectureService service;
	
	@Value("#{config['boardPages']}")
	String boardPages;
	
	@RequestMapping(value = "/smtp/user/rainbow-class01-01", method = RequestMethod.GET)
	public String rainbow_class01_01(Authentication auth, @RequestParam HashMap<String,Object> params, Model model ) {
		logger.info("학습현황-학습중 페이지 이동 컨트롤러 시작");
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id",user_id);
		
		model.addAttribute("progressList", service.smtpSelectProgressList(params));
		model.addAttribute("waitingList", service.smtpSelectWaitingList(params));
		model.addAttribute("completeList", service.smtpSelectCompleteList(params));
		
		logger.info("학습현황-학습중 페이지 이동 컨트롤러 종료");
		return "/segroup/society/smtp/user/rainbow-class01-01";
	}
	
	@RequestMapping(value = "smtp/user/sub05-01", method = RequestMethod.GET)
	public String sub05_01(Authentication auth, @RequestParam HashMap<String,Object> params, Model model ) {
		logger.info("학습현황-학습중 페이지 이동 컨트롤러 시작");
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id",user_id);
		
		model.addAttribute("progressList", service.smtpSelectProgressList(params));
		model.addAttribute("waitingList", service.smtpSelectWaitingList(params));
		model.addAttribute("completeList", service.smtpSelectCompleteList(params));
		
		logger.info("학습현황-학습중 페이지 이동 컨트롤러 종료");
		return "/segroup/society/smtp/user/sub05-01";
	}
	
	@RequestMapping(value="smtp/user/sub05-01-list", method = RequestMethod.GET)
	public @ResponseBody Object sub05_01_list (Authentication auth,@RequestParam HashMap<String,Object> params) {
		
		logger.info("학습현황 리스트 가져오는 컨트롤러 시작");
		String user_id = (auth!=null ? auth.getName() : null);
		params.put("user_id",user_id);
		
		//시작 페이지 객체
		String startPage = StringUtils.isBlank((String) params.get("startPage")) ? "1" : (String) params.get("startPage");
		// 시작 페이지 설정
		params.put("startPage", CommonUtil.getStart(startPage, boardPages));
		// 볼 수 있는 페이지 설정
		params.put("visiblePages", boardPages);
		
		int listNum = Integer.parseInt((String) params.get("listNum"));
		
		HashMap<String, List<HashMap<String,Object>>> result = new HashMap<String, List<HashMap<String,Object>>>();
		
		if(listNum == 0) {
			List<HashMap<String,Object>> progressList = service.smtpSelectProgressList(params);
			result.put("progressList", progressList);
		} else if (listNum == 1) {
			List<HashMap<String,Object>> waitingList = service.smtpSelectWaitingList(params);
			result.put("waitingList", waitingList);
		} else if (listNum == 2) {
			List<HashMap<String,Object>> completeList = service.smtpSelectCompleteList(params);
			result.put("completeList", completeList);
		}
		
		return result;
	}
	
	/*
	 * zoom 연동 테스트(JWT)
	 */
	@RequestMapping(value="smtp/user/zoom", method = RequestMethod.POST)
	public @ResponseBody String zoonEvent(@RequestBody HashMap<String, Object> param) {
		
		System.out.println("zoom이 호출했습니다.");
		Set keys = param.keySet();
		for (Object object : keys) {
			System.out.println(param.get(object));
		}
		System.out.println("zoom이 호출 끝났습니다..");
		
		
		return "뭔가 넘어옴............................................................................";
	}
	
	/*
	 * zoom 연동 테스트(OAuth)
	 */
	@RequestMapping(value="smtp/user/zoom", method = RequestMethod.GET)
	public @ResponseBody String zoonEvent2(HttpServletRequest request) {
		
		System.out.println("zoom이 호출했습니다.");
		/*
		 * Set keys = param.keySet(); for (Object object : keys) {
		 * System.out.println(param.get(object)); }
		 */
		System.out.println("zoom이 호출 끝났습니다..");
		
		
		return "뭔가 넘어옴............................................................................";
	}
}
