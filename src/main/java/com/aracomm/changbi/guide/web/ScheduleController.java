package com.aracomm.changbi.guide.web;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.guide.service.CardinalService;

@Controller
@RequestMapping(value = "/guide/training")
public class ScheduleController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(ScheduleController.class);
	private static final String CARDINAL_UNIT_4 = "4";
	private static final String CARDINAL_UNIT_3 = "3";
	private static final String CARDINAL_UNIT_2 = "2";
	private static final String CARDINAL_UNIT_1 = "1";

	@Autowired
	private CardinalService service;

	@RequestMapping(value = "/schedule")
	public String schedule(Model model) {

		List<Map<String, Object>> credit4List = service.selectCardinalList(CARDINAL_UNIT_4);
		List<Map<String, Object>> credit3List = service.selectCardinalList(CARDINAL_UNIT_3);
		List<Map<String, Object>> credit2List = service.selectCardinalList(CARDINAL_UNIT_2);
		List<Map<String, Object>> credit1List = service.selectCardinalList(CARDINAL_UNIT_1);

		model.addAttribute("credit4List", credit4List);
		model.addAttribute("credit3List", credit3List);
		model.addAttribute("credit2List", credit2List);
		model.addAttribute("credit1List", credit1List);

		return "guide/training/schedule";
	}

}
