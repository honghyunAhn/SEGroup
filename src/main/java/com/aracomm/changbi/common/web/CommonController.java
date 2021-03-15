package com.aracomm.changbi.common.web;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/common")
public class CommonController {
	/**
	 * 페이지 이동
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/forward")
	public String forward(Model model) {
		return "common/forward";
	}

	/**
	 * layer popup contents 페이지
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/layer/{page}")
	public String page(@PathVariable("page") String page) {
		return "common/layer/"+page;
	}
	@RequestMapping(value = "/layer/{sub}/{page}")
	public String page(@PathVariable("sub") String sub, @PathVariable("page") String page) {
		return "common/layer/"+sub+"/"+page;
	}
}
