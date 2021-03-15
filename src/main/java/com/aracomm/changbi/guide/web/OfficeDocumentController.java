package com.aracomm.changbi.guide.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.base.common.vo.FileVo;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.common.service.CommonService;
import com.aracomm.changbi.serviceCenter.service.BbsService;

@Controller
@RequestMapping(value = "/guide/training")
public class OfficeDocumentController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(OfficeDocumentController.class);

	@Value("#{config['boardPages']}")
	String boardPages;

	@Autowired
	private BbsService service;

	@Autowired
	private CommonService commonService;

	@RequestMapping(value = "/offidoc/list")
	public String offidoc(@RequestParam HashMap<String,String> param, Model model) {

		String startPage = StringUtils.isBlank(param.get("startPage")) ? "1":param.get("startPage");
		param.put("startPage", CommonUtil.getStart(startPage, boardPages));
        param.put("visiblePages", boardPages);
        param.put("board_type", GlobalConst.BBS_TYPE_NOTICE);
        param.put("notice_type", GlobalConst.BBS_NOTICE_TYPE_OFFICEDOCUMENT);

        int totalCnt = service.selectBbsListTotCnt(param);
        param.put("totalCnt", String.valueOf(totalCnt));

        model.addAttribute("board_type", GlobalConst.BBS_TYPE_NOTICE);
        model.addAttribute("notice_type", GlobalConst.BBS_NOTICE_TYPE_OFFICEDOCUMENT);
        model.addAttribute("startPage", startPage);
        model.addAttribute("visiblePages", boardPages);
        model.addAttribute("totalCnt", totalCnt);
        model.addAttribute("totalPages", String.valueOf(CommonUtil.getTotalPage(totalCnt,Integer.parseInt(boardPages))));

		model.addAttribute("bbslist", service.selectBbsList(param));
		model.addAttribute("param", param);

		return "guide/training/offidoc";
	}

	@RequestMapping(value = "/offidoc/detail")
	public String detail(Model model, @RequestParam HashMap<String,String> param) {
		List<String> file_ids = new ArrayList<String>();
        HashMap<String, String> detail = service.selectBbsDetail(param);
        String fileId = detail.get("attach1_file");
        if (!StringUtils.isEmpty(fileId)) file_ids.add(fileId);
        fileId = detail.get("attach2_file");
        if (!StringUtils.isEmpty(fileId)) file_ids.add(fileId);
        List<FileVo> fileList = null;
        if (file_ids.size() > 0) {
        	fileList = commonService.selectAttachFileListByIds(file_ids.toArray(new String[0]));
        }

		model.addAttribute("detail", service.selectBbsDetail(param));
		model.addAttribute("fileList", fileList);
		model.addAttribute("preNext", service.selectBbsDetailPrevNext(param));
		return "guide/training/offidocdetail";
	}
}
