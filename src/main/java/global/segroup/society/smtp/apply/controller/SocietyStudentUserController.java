package global.segroup.society.smtp.apply.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.segroup.domain.User;
import global.segroup.society.fap.agency.service.SocietyFapAgencyService;
import global.segroup.society.smtp.apply.domain.CardinalDTO;
import global.segroup.society.smtp.apply.domain.CourseDTO;
import global.segroup.society.smtp.apply.domain.Student_Resume_Apply_History_DTO;
import global.segroup.society.smtp.apply.domain.cnCourseDTO;
import global.segroup.society.smtp.apply.service.SocietyStudentUserService;

@Controller
public class SocietyStudentUserController {
	
	@Autowired
	SocietyStudentUserService SmgmtUService;
	
	@Autowired
	private SocietyFapAgencyService sfaService;
	
	@RequestMapping(value = "/studentMgmt", method = RequestMethod.GET)
	public String studentMgmt() {
		return "/segroup/society/smtp/main";
	}
	
	@RequestMapping(value = "/signupForm", method = RequestMethod.GET)
	public String signupForm(){
		return "/segroup/society/smtp/user/sginup";
		
	}
	
	@RequestMapping(value = "/loginForm", method = RequestMethod.GET)
	public String loginForm(){
		return "/segroup/society/smtp/user/login";
		
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public String logout(HttpSession session){
		session.invalidate();
		return "/segroup/society/smtp/main";
		
	}
	
	@RequestMapping(value = "/leaveSchool", method = RequestMethod.GET)
	public String leaveSchool(){
		return "/segroup/society/smtp/user/leaveSchool";
		
	}
	
	/*
	 * @RequestMapping(value = "/myStudentMgmt", method = RequestMethod.GET) public
	 * String myStudentMgmt(HttpSession session, Model model){ User loginUser = new
	 * User(); String loginId = (String) session.getAttribute("user_id"); loginUser
	 * = SmgmtUService.selectUserById(loginId); System.out.println(loginUser);
	 * 
	 * Student_Resume_Apply_History_DTO applyHistory = new
	 * Student_Resume_Apply_History_DTO(); applyHistory =
	 * SmgmtUService.selectStudentResumeApplyHistory(loginId); CardinalDTO cardinal
	 * = new CardinalDTO(); cardinal =
	 * SmgmtUService.selectCardinalById(applyHistory.getId());
	 * 
	 * CourseDTO course = new CourseDTO();
	 * 
	 * course = SmgmtUService.selectCourseByCardinalId(cardinal.getId());
	 * System.out.println("!!!!!!!!!!!!!"); System.out.println(course);
	 * System.out.println("!!!!!!!!!!!!!");
	 * 
	 * 
	 * model.addAttribute("cardinal", cardinal); model.addAttribute("course",
	 * course); model.addAttribute("detail", loginUser); return
	 * "/segroup/society/smtp/user/myStudentMgmt";
	 * 
	 * }
	 */
	
	@RequestMapping(value = "/selectSmgmtUser", method = RequestMethod.GET)
	public String selectSmgmtUser(String check){
		System.out.println(check);
		//boolean flag = false;
		String user_id_check = sfaService.user_id_check(check);
	//	flag = SmgmtUService.selectSmgmtUser(check);
		System.out.println("zzzzzzz");
		System.out.println(user_id_check);
		System.out.println("zzzzzzz");
		return user_id_check;
	}
	
	@RequestMapping(value = "/loginSmgmt", method = RequestMethod.POST)
	public @ResponseBody String loginSmgmt(User check, HttpSession session){
		System.out.println("value1");
		System.out.println(check);
		System.out.println("value2");
	//	check.setUser_pw("$2a$10$y4YT9obJVgbEf2g6GIpom.DewOnX.4UOzxXBo1BSknbti/DKL.Kxe");
		User loginUser = new User();
		loginUser = SmgmtUService.selectOneUser(check);
		System.out.println("result");
		System.out.println(loginUser);
		System.out.println("kkkkkkkkkkkkk");
		
		if(loginUser==null){
			System.out.println("asfsafasfafsad");
			return "idpwCheck";
		}else if(loginUser.getUser_flag().equals("A0105")){
			session.setAttribute("user_id", loginUser.getUser_id());
			session.setAttribute("user_flag", loginUser.getUser_flag());
			return "admin";
		}else if(loginUser.getUser_flag().equals("A0100")){
			Student_Resume_Apply_History_DTO checkApplyHistory = new Student_Resume_Apply_History_DTO();
			checkApplyHistory = SmgmtUService.selectStudentResumeApplyHistory(loginUser.getUser_id());
			if(checkApplyHistory==null||checkApplyHistory.getStudent_apply_history_state().equals("B1402")||checkApplyHistory.getStudent_apply_history_state().equals("B1702")){
				System.out.println("zzzzzzzzzzzzzz");
		//		boolean insertResult;
		//		insertResult = SmgmtUService.insertStudentEnterCRC();
				
				session.setAttribute("user_id", loginUser.getUser_id());
				session.setAttribute("user_flag", loginUser.getUser_flag());
				return "guest";
			}else if(checkApplyHistory.getStudent_apply_history_state().equals("B1300")||checkApplyHistory.getStudent_apply_history_state().equals("B1400")||checkApplyHistory.getStudent_apply_history_state().equals("B1700")||checkApplyHistory.getStudent_apply_history_state().equals("B1703")){
				
				session.setAttribute("user_id", loginUser.getUser_id());
				session.setAttribute("user_flag", loginUser.getUser_flag());
				return "wating";
			}else{
				
				session.setAttribute("user_id", loginUser.getUser_id());
				session.setAttribute("user_flag", loginUser.getUser_flag());
				return "guest";
				
			}
		}else if(loginUser.getUser_flag().equals("A0101")){
	/*		Student_Resume_Apply_History_DTO checkApplyHistory = new Student_Resume_Apply_History_DTO();
			checkApplyHistory = SmgmtUService.selectStudentResumeApplyHistory(loginUser.getUser_id());
			if(checkApplyHistory==null||checkApplyHistory.getStudent_apply_history_state().equals("B1402")||checkApplyHistory.getStudent_apply_history_state().equals("B1702")){
				System.out.println("zzzzzzzzzzzzzz");
		//		boolean insertResult;
		//		insertResult = SmgmtUService.insertStudentEnterCRC();
				return "guest";
			}else if(checkApplyHistory.getStudent_apply_history_state().equals("B1300")||checkApplyHistory.getStudent_apply_history_state().equals("B1400")||checkApplyHistory.getStudent_apply_history_state().equals("B1700")||checkApplyHistory.getStudent_apply_history_state().equals("B1703")){
				return "wating";
			}else{*/
				session.setAttribute("user_id", loginUser.getUser_id());
				session.setAttribute("user_flag", loginUser.getUser_flag());
				return "scit";
		/*	}
		}else{
			System.out.println("why");
			return "fail";*/
		
		}else{
			System.out.println("why");
			return "fail";
		}
	}
}
