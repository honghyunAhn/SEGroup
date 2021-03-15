/**
 * 
 */
package global.segroup.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import global.segroup.exception.GroupIdNotFoundException;
import global.segroup.service.SEGroupCommonService;
import global.segroup.util.CodeConverter;
import global.segroup.util.PathConstants;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 21.
 * @Class 설명 : AngularJS를 위한 샘플 컨트롤러 
 * 
 */
@Controller
public class AngularController implements PathConstants {
	
	@Autowired
	private SEGroupCommonService sgcService;
	
	@ResponseBody
	@RequestMapping(value = "ajax", method = RequestMethod.POST)
	public ArrayList<HashMap<String, String>> ajax() {
		
		ArrayList<HashMap<String, String>> maplist = new ArrayList<>();
		HashMap<String, String> map1 = new HashMap<>();
		map1.put("name", "이상철");
		map1.put("class", "B");
		HashMap<String, String> map2 = new HashMap<>();
		map2.put("name", "서민수");
		map2.put("class", "C");
		HashMap<String, String> map3 = new HashMap<>();
		map3.put("name", "이정식");
		map3.put("class", "A");
		HashMap<String, String> map4 = new HashMap<>();
		map4.put("name", "선희경");
		map4.put("class", "A");
		maplist.add(map1);
		maplist.add(map2);
		maplist.add(map3);
		maplist.add(map4);
		return maplist;
	}
	
	@ResponseBody
	@RequestMapping(value = "codeconverter", method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public String codeconverter(@RequestParam("code") String code, Locale locale){
		String result = "";
		try {
			result = sgcService.selectCodeName(CodeConverter.getCodeMap(code, locale));
		} catch (GroupIdNotFoundException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@RequestMapping(value = "/sample1", method = RequestMethod.GET)
	public String sample1() {
		return "segroup/angularSample/sample1";
	}
	
	@RequestMapping(value = "/sample2", method = RequestMethod.GET)
	public String sample2() {
		return "segroup/angularSample/sample2";
	}
	
	@RequestMapping(value = "/sample3", method = RequestMethod.GET)
	public String sample3() {
		return "segroup/angularSample/sample3";
	}
	
	@RequestMapping(value = "/sample4", method = RequestMethod.GET)
	public String sample4() {
		return "segroup/angularSample/sample4";
	}
	
	@RequestMapping(value = "/sample5", method = RequestMethod.GET)
	public String sample5() {
		return "segroup/angularSample/sample5";
	}
	
	@RequestMapping(value = "/sample6", method = RequestMethod.GET)
	public String sample6() {
		return "segroup/angularSample/sample6";
	}
	
	@RequestMapping(value = "/sample7", method = RequestMethod.GET)
	public String sample7() {
		return "segroup/angularSample/sample7";
	}
	
	@RequestMapping(value = "/sample8", method = RequestMethod.GET)
	public String sample8() {
		return "segroup/angularSample/sample8";
	}
	
	@RequestMapping(value = "/addressTest", method = RequestMethod.GET)
	public String addressTest() {
		return "segroup/addressSample/addressForm";
	}
	
	@RequestMapping(value = "/popupTest", method = RequestMethod.GET)
	public String popupTest(Model model) {
		model.addAttribute("popupCall","Y");
		return "segroup/addressSample/addressPopup";
	}
	
	@RequestMapping(value = "/popupTest", method = RequestMethod.POST)
	public String popupTest2(Model model, HttpServletRequest request) {
		model.addAttribute("address",request.getParameter("roadAddrPart1"));
		model.addAttribute("addressDetail",request.getParameter("addrDetail"));
		model.addAttribute("zipcode",request.getParameter("zipNo"));
		return "segroup/addressSample/addressPopup";
	}
}
