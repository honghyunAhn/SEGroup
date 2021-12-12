package global.segroup.society.smtp.apply.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import global.segroup.domain.User;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyCareer;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyEduHistory;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyForm;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyIntroduce;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyKmove;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyLanguage;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyLicense;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyOverseas;
import global.segroup.society.smtp.apply.domain.SocietyStuApplySes;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyStudy;
import global.segroup.society.smtp.apply.service.SocietyStudentApplyService;
import global.segroup.society.smtp.apply.service.SocietyStudentUserService;

@Controller
public class SocietyStudentApplyController {
	
	@Autowired
	SocietyStudentApplyService ssaService;
	
	@Autowired
	SocietyStudentUserService ssuService;
	
	// 지원신청서로 이동
	@RequestMapping(value = "/smtp/apply/sub00-01", method = RequestMethod.GET)
	public String sub00_01(Authentication auth, Model model, String course_id, String cardinal_id, RedirectAttributes redirectAttributes){
		
		int result = checkApplyState(auth, cardinal_id);
		HashMap<String, Object> gisuInfo = null;
		
		switch(result) {
		case 0 :
			User loginUser = new User();
			String loginId = (String)auth.getPrincipal();
			loginUser = ssaService.selectUserById(loginId);
			gisuInfo = ssaService.selectGisuInfo(cardinal_id);
			
			model.addAttribute("detail", loginUser);
			model.addAttribute("crc_id", course_id);
			model.addAttribute("gisu_id", cardinal_id);
			model.addAttribute("gisu_nm", gisuInfo.get("gisu_nm"));
			model.addAttribute("app_end_date", gisuInfo.get("app_end_date"));
			return "/segroup/society/smtp/apply/rainbow-apply01-01";
		case 1 :
			gisuInfo = ssaService.selectGisuInfo(cardinal_id);
			redirectAttributes.addAttribute("gisu_id", cardinal_id);
			redirectAttributes.addAttribute("app_end_date", gisuInfo.get("app_end_date"));
			redirectAttributes.addAttribute("message", true);
			return "redirect:/smtp/apply/rainbow-apply01-03";
		case 2 :
			redirectAttributes.addAttribute("message", true);
			return "redirect:/smtp/user/rainbow-class02-01";
		}
		return "/segroup/society/smtp/apply/rainbow-apply01-01"; // case3: 로그인 안되어 있는 경우로, 지원서 페이지 인터셉터로 로그인 페이지로 넘어감.
	}
	
	// 지원신청서로 이동
	@RequestMapping(value = "/smtp/apply/rainbow-apply01-01", method = RequestMethod.GET)
	public String rainbow_apply01_01(Authentication auth, Model model, String course_id, String cardinal_id, RedirectAttributes redirectAttributes){
		
		int result = checkApplyState(auth, cardinal_id);
		HashMap<String, Object> gisuInfo = null;
		
		switch(result) {
		case 0 :
			User loginUser = new User();
			String loginId = (String)auth.getPrincipal();
			loginUser = ssaService.selectUserById(loginId);
			gisuInfo = ssaService.selectGisuInfo(cardinal_id);
			
			model.addAttribute("detail", loginUser);
			model.addAttribute("crc_id", course_id);
			model.addAttribute("gisu_id", cardinal_id);
			model.addAttribute("gisu_nm", gisuInfo.get("gisu_nm"));
			model.addAttribute("app_end_date", gisuInfo.get("app_end_date"));
			return "/segroup/society/smtp/apply/rainbow-apply01-01";
		case 1 :
			gisuInfo = ssaService.selectGisuInfo(cardinal_id);
			redirectAttributes.addAttribute("gisu_id", cardinal_id);
			redirectAttributes.addAttribute("app_end_date", gisuInfo.get("app_end_date"));
			redirectAttributes.addAttribute("message", true);
			//수정하기부분
			return "redirect:/smtp/apply/rainbow-apply01-03";
		case 2 :
			redirectAttributes.addAttribute("message", true);
			return "redirect:/smtp/user/rainbow-class02-01";
		}
		return "/segroup/society/smtp/apply/rainbow-apply01-01"; // case3: 로그인 안되어 있는 경우로, 지원서 페이지 인터셉터로 로그인 페이지로 넘어감.
	}
		
	// 지원 상태 확인 : result값  -->  0:지원이력 없음, 1:지원하였으나 결과가 나오지 않은 경우, 2:지원결과가 나온 경우, 3:로그인 필요
	@ResponseBody
	@RequestMapping(value = "/smtp/apply/checkApplyState", method = RequestMethod.POST)
	public int checkApplyState(Authentication auth, @RequestBody String gisu_id){
		
		if(auth != null){
			String loginId = (String)auth.getPrincipal();
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("gisu_id", gisu_id);
			param.put("user_id", loginId);
			HashMap<String, Object> applyInfo = ssaService.selectApplyInfo(param);
			
			if(applyInfo != null){
				String docResult = (String)applyInfo.get("stu_app_rt_doc");
				String itvResult = (String)applyInfo.get("stu_app_rt_itv");
				
				if(docResult.equals("B1400") && itvResult.equals("B1700")) return 1;
				else return 2; //서류,면접 결과 중 하나라도 합/불 결과가 나왔을 때
				
			}else return 0;
		}else return 3;
	}
	
	// 지원신청서 수정
	@RequestMapping(value = "/smtp/apply/sub00-02", method = RequestMethod.GET)
	public String sub00_02(Authentication auth, @RequestParam HashMap<String, Object> param, Model model){
		
		if(auth != null){
			param.put("user_id", (String)auth.getPrincipal());
			HashMap<String, Object> applyForm = ssaService.selectSmtpApply(param);
			
			Gson gson = new Gson();
			model.addAttribute("apply", gson.toJson(applyForm));
			model.addAttribute("data", applyForm);
			model.addAttribute("app_end_date", param.get("app_end_date"));
			model.addAttribute("message", param.get("message"));
		}
		return "/segroup/society/smtp/apply/sub00-02";
	}
	
	// 지원신청서 수정
	@RequestMapping(value = "/smtp/apply/rainbow-apply01-03", method = RequestMethod.GET)
	public String rainbow_apply01_03(Authentication auth, @RequestParam HashMap<String, Object> param, Model model){
		
		if(auth != null){
			param.put("user_id", (String)auth.getPrincipal());
			HashMap<String, Object> applyForm = ssaService.selectSmtpApply(param);
			
			Gson gson = new Gson();
			model.addAttribute("apply", gson.toJson(applyForm));
			model.addAttribute("data", applyForm);
			model.addAttribute("app_end_date", param.get("app_end_date"));
			model.addAttribute("message", param.get("message"));
		}
		return "/segroup/society/smtp/apply/rainbow-apply01-03";
	}
	
	/**
	 * @Method Name : apply_insert
	 * @Date : 2020. 8. 6.
	 * @User : 김성미
	 * @Param : SMART Cloud IT마스터 지원신청 정보(기본정보 , 학력, 경력, 교육이수, 언어능력, 자격증, 본 과정 응시여부, Kmove스쿨 경험, 해외체류, 자기소개서)
	 * @Return : JSP 리턴페이지(TODO)
	 * @Method 설명 : 사용자로부터 입력받은 정보를 지원 서비스로 전달한다.
	 */
	@RequestMapping(value = "/smtp/apply/insert", method = RequestMethod.POST)
	public String apply_insert(SocietyStuApplyForm ssaForm, SocietyStuApplyEduHistory ssaEduHistory
								,SocietyStuApplyCareer ssaCareer, SocietyStuApplyStudy ssaStudy
								,SocietyStuApplyLanguage ssaLanguage, SocietyStuApplyLicense ssaLicense
								,SocietyStuApplySes ssaSes, SocietyStuApplyKmove ssaKmove
								,SocietyStuApplyOverseas ssaOverseas, SocietyStuApplyIntroduce ssaIntroduce
								,String app_end_date, Authentication auth, RedirectAttributes rttr){

		HashMap<String, Object> param = new HashMap<>();
		param.put("user_id", ssaForm.getUser_id());
		param.put("gisu_seq", ssaForm.getGisu_id());
		
		boolean result = ssaService.apply_insert(ssaForm, ssaEduHistory, ssaCareer, ssaStudy, ssaLanguage, ssaLicense, ssaSes, ssaKmove, ssaOverseas, ssaIntroduce, app_end_date, param);
		if(result) {
			return "redirect:/smtp/user/rainbow-class02-01";
		} else {
			return "/segroup/society/smtp/apply/insertFail";
		}

/*		if(ssaService.selectEduApplyResult(param) == null){
			ssaService.apply_insert(seaForm, seaEduHistory, seaCareer, seaStudy, seaLanguage, seaLicense, seaOverseas, seaFile);
		}
*/		
//		return "redirect:"+PathConstants.SOCIETY_ICTCENTER;
	}	
	
	/**
	 * @Method Name : apply_update
	 * @Date : 2020. 8. 6.
	 * @User : 김성미
	 * @Param : SMART Cloud IT마스터 지원신청 정보(기본정보 , 학력, 경력, 교육이수, 언어능력, 자격증, 본 과정 응시여부, Kmove스쿨 경험, 해외체류, 자기소개서)
	 * @Return : JSP 리턴페이지(TODO)
	 * @Method 설명 : 사용자로부터 입력받은 정보를 지원 서비스로 전달한다.
	 */
	@RequestMapping(value = "/smtp/apply/update", method = RequestMethod.POST)
	public String apply_update(SocietyStuApplyForm ssaForm, SocietyStuApplyEduHistory ssaEduHistory
								,SocietyStuApplyCareer ssaCareer, SocietyStuApplyStudy ssaStudy
								,SocietyStuApplyLanguage ssaLanguage, SocietyStuApplyLicense ssaLicense
								,SocietyStuApplySes ssaSes, SocietyStuApplyKmove ssaKmove
								,SocietyStuApplyOverseas ssaOverseas, SocietyStuApplyIntroduce ssaIntroduce
								,String app_end_date , Authentication auth){

		HashMap<String, Object> param = new HashMap<>();
		param.put("user_id", ssaForm.getUser_id());
		param.put("gisu_id", ssaForm.getGisu_id());
		
		boolean result = ssaService.apply_insert(ssaForm, ssaEduHistory, ssaCareer, ssaStudy, ssaLanguage, ssaLicense, ssaSes, ssaKmove, ssaOverseas, ssaIntroduce, app_end_date, param);
		if(result) {
			return "redirect:/smtp/user/rainbow-class02-01";
		} else {
			return "/segroup/society/smtp/apply/insertFail";
		}
/*		if(ssaService.selectEduApplyResult(param) == null){
			ssaService.apply_insert(seaForm, seaEduHistory, seaCareer, seaStudy, seaLanguage, seaLicense, seaOverseas, seaFile);
		}
*/		
//		return "redirect:"+PathConstants.SOCIETY_ICTCENTER;
	}	

}
