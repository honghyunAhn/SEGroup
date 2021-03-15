package com.aracomm.changbi.mypage.web;

import java.security.Principal;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aracomm.changbi.mypage.service.DeliveryService;
import com.aracomm.changbi.mypage.vo.DeliverySearchVo;

@Controller
@RequestMapping(value = "/mypage/delivery")
public class DeliveryController {
	private static final Logger logger = LoggerFactory.getLogger(DeliveryController.class);

	@Autowired
	private DeliveryService service;

	@Value("#{config['boardPages']}")
	private int boardPages;

	@RequestMapping(value = "/delivery")
	public String page(Model model, DeliverySearchVo searchVO, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		searchVO.setUser_id(user_id);
		searchVO.setVisiblePages(boardPages);

		model.addAttribute("searchVO", searchVO);
		model.addAttribute("list", service.selectDeliveryList(searchVO));

		return "mypage/delivery/delivery";
	}
}
