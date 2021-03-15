package com.aracomm.changbi.common.web;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.common.service.HitKeywordService;

@Controller
public class HitKeywordController extends BaseController {
	@Autowired
	HitKeywordService service;

	@RequestMapping(value = "/ajaxHitKeywords")
	public @ResponseBody HashMap<String, Object> ajaxHitKeywords() {
		HashMap<String, Object> result = getSimpleAjaxResult();

		result.put("keywords", service.selectHitKeywordList());

		return result;
	}

}
