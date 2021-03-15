package com.aracomm.changbi.mypage.web;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.user.dao.UserDao;

@Controller
@RequestMapping(value = "/mypage/ip")
public class IpController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(IpController.class);
	private static final int MAX_IP_NUM = 5;

	@Resource(name="messageSource")
	private MessageSource messageSource;

	@Autowired
	private UserDao dao;

	@RequestMapping(value = "/ip")
	public String page(Model model, HttpServletRequest request) {
		model.addAttribute("user", getLoginUserInfo());
		model.addAttribute("remoteIp", CommonUtil.getRemoteAddr(request));
		model.addAttribute("list",dao.selectIpList(getLoginUserId()));
		return "mypage/ip/ip";
	}

	@RequestMapping(value = "/saveIpUseYn")
	public @ResponseBody Object saveIpUseYn(Model model, @RequestParam HashMap<String,String> param) {

		param.put("user_id", getLoginUserId());
		dao.updateIpUseYn(param);

		return getAjaxSuccessResult(getMessage(messageSource, "msg.common.updated"));
	}

	@RequestMapping(value = "/insertIp")
	public @ResponseBody Object insertIp(Model model, @RequestParam String ip) {
		HashMap<String, Object> result = null;

		String user_id = getLoginUserId();

		// 5개 까지만 등록할 수 있다
		List<HashMap<String, String>> ipList = dao.selectIpList(user_id);

		if(ipList != null) {
			if (ipList.size() >= MAX_IP_NUM) {
				result = getAjaxFailResult(getMessage(messageSource, new String [] {String.valueOf(MAX_IP_NUM)}, "msg.mypage.ipexceed"));
				return result;
			}

			// 중복체크
			for(int i=0; i<ipList.size(); i++) {
				HashMap<String, String> ipInfo = ipList.get(i);
				if(ip.equals(ipInfo.get("IP"))) {
					result = getAjaxFailResult(getMessage(messageSource, "msg.mypage.alreadyip"));
					return result;
				}
			}
		}

		HashMap<String, String> param = new HashMap<String, String>();
		param.put("ip", ip);
		param.put("user_id", user_id);
		dao.insertIp(param);

		return getAjaxSuccessResult(getMessage(messageSource, "msg.common.registered"));
	}

	@RequestMapping(value = "/deleteIp")
	public @ResponseBody Object deleteIp(Model model, @RequestParam String seq) {
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("seq", seq);
		param.put("user_id", getLoginUserId());
		dao.deleteIp(param);
		return getAjaxSuccessResult(getMessage(messageSource, "msg.common.deleted"));
	}
}
