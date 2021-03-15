package com.aracomm.changbi.serviceCenter.web;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.serviceCenter.service.EventService;
import com.aracomm.changbi.serviceCenter.vo.EventSearchVo;

@Controller
@RequestMapping(value="/serviceCenter/event")
public class EventController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(EventController.class);

	@Autowired
	private EventService service;

	@RequestMapping(value = "/eventList")
	public String eventList(EventSearchVo searchVo, Model model) {

		List<Map<String, Object>> eventList = service.selectEventList(searchVo);

		model.addAttribute("searchVo", searchVo);
		model.addAttribute("eventList", eventList);

		return "serviceCenter/event/eventList";
	}

	@RequestMapping(value = "/eventDetail")
	public String eventDetail(EventSearchVo searchVo, Model model) {

		Map<String, Object> event = service.selectEvent(searchVo.getId());


		model.addAttribute("searchVo", searchVo);
		model.addAttribute("event", event);

		return "serviceCenter/event/eventDetail";
	}


}
