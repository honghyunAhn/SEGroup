package com.aracomm.changbi.mypage.web;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.aracomm.base.common.AraCommConst;
import com.aracomm.changbi.mypage.service.PointService;
import com.aracomm.changbi.mypage.vo.PointSearchVo;

@Controller
@RequestMapping(value = "/mypage/point")
public class PointController {
	private static final Logger logger = LoggerFactory.getLogger(PointController.class);

	@Autowired
	private PointService service;

	@Value("#{config['miniPages']}")
	private int miniPages;

	@RequestMapping(value = "/point")
	public String page(Model model, PointSearchVo searchVO ,  Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		searchVO.setUser_id(user_id);
		searchVO.setCouponVisiblePages(miniPages);
		searchVO.setPointVisiblePages(miniPages);

		model.addAttribute("pointList", service.selectPointList(searchVO));
		model.addAttribute("pointSummary", service.selectPointSummary(searchVO.getUser_id()));
		model.addAttribute("couponList", service.selectCouponList(searchVO));
		model.addAttribute("searchVO", searchVO);

		//TODO - 익월 소멸예정 포인트에 대한 정보 조회가 필요함.(현재 기준이 되는 데이터가 없음)
		//TODO - view단에 pointList 출력시 잔여포인트를 누적으로 처리해야함.

		return "mypage/point/point";
	}

	@RequestMapping(value="/couponRegistAjax")
	public @ResponseBody Object couponRegist(Model model, @RequestParam HashMap<String,Object> params, Principal principal) {
		String user_id = (principal != null ? principal.getName() : null);
		params.put("user_id", user_id);

		HashMap<String,Object> result = new HashMap<>();
		try {
			HashMap<String,Object> validCoupon = service.selectValidCouponInfo(params);
			if (validCoupon == null) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "유효하지 않은 쿠폰번호입니다.");
				return result;
			}

			if (validCoupon.get("USE_DATE") != null) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "이미 사용이 완료된 쿠폰입니다.");
				return result;
			}

			if ("Y".equals(validCoupon.get("EXP_YN"))) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "사용기간이 만료된 쿠폰입니다.");
				return result;
			}

			if (validCoupon.get("USER_ID") != null) {
				result.put("result", AraCommConst.TEXT_FAIL);
				result.put("message", "이미 등록된 쿠폰입니다.");
				return result;
			}

			int id = service.registCouponInfo(params);
			result.put("result", id>0?AraCommConst.TEXT_SUCCESS:AraCommConst.TEXT_FAIL);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("result", AraCommConst.TEXT_FAIL);
		}

		return result;
	}
}
