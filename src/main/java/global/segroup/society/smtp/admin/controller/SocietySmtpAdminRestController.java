/**
 * 
 */
/*
 * package global.segroup.society.smtp.admin.controller;
 * 
 * import java.util.ArrayList;
 * 
 * import org.slf4j.Logger; import org.slf4j.LoggerFactory; import
 * org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.stereotype.Controller; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestMethod; import
 * org.springframework.web.bind.annotation.ResponseBody;
 * 
 * import global.segroup.society.smtp.admin.domain.SocietySmtpAdminCurriculum;
 * import
 * global.segroup.society.smtp.admin.domain.SocietySmtpAdminCurriculumGisu;
 * import global.segroup.society.smtp.admin.service.SocietySmtpAdminService;
 * import global.segroup.util.PathConstants2;
 * 
 *//**
	 * @Author : 김슬기
	 * @Date : 2019. 12. 3.
	 * @Class 설명 : Soft Engineer Society 통합학사관리 관리자 View 컨트롤러
	 * 
	 */
/*
 * 
 * @Controller public class SocietySmtpAdminRestController {
 * 
 * private static final Logger logger =
 * LoggerFactory.getLogger(SocietySmtpAdminRestController.class);
 * 
 * @Autowired SocietySmtpAdminService ssaService;
 * 
 *//**
	 * @Method Name : searchCurriculum
	 * @Date : 2019. 12. 2.
	 * @User : 김슬기
	 * @Param : -
	 * @Return : 특정 과정 분류의 과정들 정보 리스트 객체
	 * @Method 설명 : 특정 과정 분류의 과정들 정보들을 조회 하는 컨트롤러 함수
	 */
/*
 * @ResponseBody
 * 
 * @RequestMapping(value = PathConstants2.SOCIETY_SMTP_ADMIN_SEARCH_CURRICULUM,
 * method = RequestMethod.POST) public ArrayList<SocietySmtpAdminCurriculum>
 * searchCurriculum(String crc_section) {
 * logger.debug("특정 과정 분류의 과정 검색 컨트롤러 시작");
 * 
 * ArrayList<SocietySmtpAdminCurriculum> resultList =
 * ssaService.searchCurriculum(crc_section);
 * 
 * logger.debug("특정 과정 분류의 과정 검색 컨트롤러 종료");
 * 
 * return resultList; }
 * 
 *//**
	 * @Method Name : searchCurriculumGisu
	 * @Date : 2019. 12. 2.
	 * @User : 김슬기
	 * @Param : 과정 코드
	 * @Return : 해당 과정 정보의 과정기수 정보들을 가진 리스트 객체
	 * @Method 설명 : 해당 과정 정보의 과정기수 정보들을 조회 하는 컨트롤러 함수
	 *//*
		 * @ResponseBody
		 * 
		 * @RequestMapping(value = PathConstants2.SOCIETY_SMTP_ADMIN_SEARCH_CUR_GISU,
		 * method = RequestMethod.POST) public ArrayList<SocietySmtpAdminCurriculumGisu>
		 * searchCurriculumGisu(String crc_code) {
		 * logger.debug("과정 코드로 과정기수 정보 검색 컨트롤러 시작");
		 * 
		 * ArrayList<SocietySmtpAdminCurriculumGisu> resultMap =
		 * ssaService.searchCurriculumGisu(crc_code);
		 * 
		 * logger.debug("과정 코드로 과정기수 정보 검색 컨트롤러 종료");
		 * 
		 * return resultMap; }
		 * 
		 * 
		 * }
		 */