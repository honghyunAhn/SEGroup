package com.aracomm.changbi.common.web;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.common.service.BannerService;

@Controller
public class BannerController extends BaseController {
	@Autowired
	BannerService service;

	@RequestMapping(value = "/ajaxSideBanners")
	public @ResponseBody HashMap<String, Object> ajaxBanners() {
		HashMap<String, Object> result = getSimpleAjaxResult();

		result.put("banners", service.selectBannerList(GlobalConst.BANNER_POSTION_SIDE));

		return result;
	}
	
}
