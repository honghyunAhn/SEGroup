package com.aracomm.changbi.guide.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/guide/training")
public class GuideController {

private static final Logger logger = LoggerFactory.getLogger(GuideController.class);


	@RequestMapping(value = "/{page}")
	public String page(Model model, @PathVariable("page") String page) {
		return "guide/training/"+page;
	}
}
