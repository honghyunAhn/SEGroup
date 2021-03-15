package com.aracomm.changbi.serviceCenter.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aracomm.changbi.common.base.BaseController;

@Controller
@RequestMapping(value="/serviceCenter")
public class ServiceCenterController extends BaseController {

	/**
	 * PC원격지원
	 * @return
	 */
	@RequestMapping(value = "/remote/remote")
	public String remote() {

		return "serviceCenter/remote";
	}
	/**
	 * 오시는길
	 * @return
	 */

	@RequestMapping(value = "/tocome")
	public String toCome() {

		return "serviceCenter/tocome";
	}

	

}
