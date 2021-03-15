package com.aracomm.changbi.common.web;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.common.base.BaseSearchVo;
import com.aracomm.changbi.common.service.SchoolSearchService;

@Controller
@RequestMapping("/common")
public class SchoolSearchController extends BaseController {
	@Autowired
	SchoolSearchService service;

	@RequestMapping(value = "/ajaxSchoolSearchList")
	public @ResponseBody HashMap<String, Object> ajaxSchoolSearchList(BaseSearchVo searchVo) {
		HashMap<String, Object> result = getSimpleAjaxResult();

		searchVo.setVisiblePages(5);
		result.put("schoolList", service.selectSchoolList(searchVo));
		result.put("searchVo", searchVo);

		return result;
	}
}
