package com.aracomm.changbi.mypage.web;

import java.security.Principal;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aracomm.base.common.AraCommConst;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.mypage.service.ReceiptService;
import com.aracomm.changbi.mypage.vo.LectureSearchVo;

@Controller
@RequestMapping(value = "/mypage/receipt")
public class ReceiptController {
	private static final Logger logger = LoggerFactory.getLogger(ReceiptController.class);

	@Autowired
	private ReceiptService service;

	@Value("#{config['boardPages']}")
	private int boardPages;

	@RequestMapping(value = "/receipt")
	public String page(Model model, LectureSearchVo searchVO, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		searchVO.setUser_id(user_id);
		searchVO.setVisiblePages(boardPages);

		model.addAttribute("list", service.selectLectureReceiptList(searchVO));
		model.addAttribute("searchVO", searchVO);

		return "mypage/receipt/receipt";
	}

	@RequestMapping(value="/selectCertificateAjax")
	public @ResponseBody Object selectCertificateAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		params.put("print_type", GlobalConst.PRINT_TYPE_CERTIFICATE);

		HashMap<String, Object> result = new HashMap<>();
		try {
			HashMap<String, Object> certificate = service.selectReceiptInfo(params);
			if (certificate == null) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "현재 이수증을 조회할 수 없습니다.");
				return result;
			}

			result.put("result", AraCommConst.TEXT_SUCCESS);
			result.put("certificate", certificate);

		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", AraCommConst.TEXT_FAIL);
		}

		return result;
	}

	@RequestMapping(value="/selectReceiptAjax")
	public @ResponseBody Object selectReceiptAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		params.put("print_type", GlobalConst.PRINT_TYPE_RECEIPT);

		HashMap<String, Object> result = new HashMap<>();
		try {
			HashMap<String, Object> receipt = service.selectReceiptInfo(params);
			if (receipt == null) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "현재 영수증을 조회할 수 없습니다.");
				return result;
			}

			result.put("result", AraCommConst.TEXT_SUCCESS);
			result.put("receipt", receipt);

		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", AraCommConst.TEXT_FAIL);
		}


		return result;
	}

	@RequestMapping(value="/selectRegisterAjax")
	public @ResponseBody Object selectRegisterAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		params.put("print_type", GlobalConst.PRINT_TYPE_REGISTER);

		HashMap<String, Object> result = new HashMap<>();

		try {
			HashMap<String, Object> register = service.selectReceiptInfo(params);
			if (register == null) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "현재 수강확인증을 조회할 수 없습니다.");
				return result;
			}

			result.put("result", AraCommConst.TEXT_SUCCESS);
			result.put("register", register);

		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", AraCommConst.TEXT_FAIL);
		}

		return result;
	}

	@RequestMapping(value="/selectScorecardAjax")
	public @ResponseBody Object selectScorecardAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		params.put("print_type", GlobalConst.PRINT_TYPE_SCORECARD);

		HashMap<String, Object> result = new HashMap<>();
		try {
			HashMap<String, Object> score = service.selectReceiptInfo(params);
			if (score == null) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "현재 성적을 조회할 수 없습니다.");
				return result;
			}

			result.put("result", AraCommConst.TEXT_SUCCESS);
			result.put("score", score);

		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", AraCommConst.TEXT_FAIL);
		}

		return result;
	}
	
	/**
	 * KCP 영수증 및 매출전표를 조회하기 위한 파라미터 조회
	 * @param model
	 * @param params
	 * @param principal
	 * @return
	 */
	@RequestMapping(value="/selectKcpReceiptAjax")
	public @ResponseBody Object selectKcpReceiptAjax(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);
		params.put("print_type", GlobalConst.PRINT_TYPE_RECEIPT);

		HashMap<String, Object> result = new HashMap<>();
		try {
			HashMap<String, Object> receipt = service.selectKcpRecieptParam(params);
			if (receipt == null) {
				result.put("result", AraCommConst.TEXT_FAIL);
				
				if (params.get("paymentType").equals("1")) {
					result.put("message", "현금영수증 발행중입니다.");
				} else {
					result.put("message", "현재 정보를 조회할 수 없습니다.");
				}
				
				return result;
			}

			result.put("result", AraCommConst.TEXT_SUCCESS);
			result.put("receipt", receipt);

		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", AraCommConst.TEXT_FAIL);
		}


		return result;
	}
}
