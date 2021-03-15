package com.aracomm.changbi.footer.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/footer")
public class FooterController {

private static final Logger logger = LoggerFactory.getLogger(FooterController.class);
	
	
	@RequestMapping(value = "/{page}")
	public String page(Model model, @PathVariable("page") String page) {
		return "footer/"+page;
	}
}
