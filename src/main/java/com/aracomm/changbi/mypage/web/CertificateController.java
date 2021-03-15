package com.aracomm.changbi.mypage.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/mypage/certificate")
public class CertificateController {
	private static final Logger logger = LoggerFactory.getLogger(CertificateController.class);
	
	@RequestMapping(value = "/{page}")
	public String page(Model model, @PathVariable("page") String page) {
		return "mypage/certificate/"+page;
	}
}
