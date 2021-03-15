package global.segroup.society.smp.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import global.segroup.domain.AdminPager;
import global.segroup.domain.BoardGroup;
import global.segroup.domain.User;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculumGisu;
import global.segroup.society.edu.admin.service.SocietyEduAdminService;
import global.segroup.society.edu.apply.domain.SocietyEduApplyResult;
import global.segroup.society.smp.admin.domain.SocietySmpApsDetail;
import global.segroup.society.smp.admin.domain.SocietySmpApsGroup;
import global.segroup.society.smp.admin.domain.SocietySmpApsSetDetail;
import global.segroup.society.smp.admin.domain.SocietySmpApsSetGroup;
import global.segroup.society.smp.admin.domain.SocietySmpApsSetTotal;
import global.segroup.society.smp.admin.domain.SocietySmpApsTotal;
import global.segroup.society.smp.admin.domain.SocietySmpSchedule;
import global.segroup.society.smp.admin.domain.SocietySmpScheduleColor;
import global.segroup.society.smp.admin.domain.SocietySmpScheduleScheduleColor;
import global.segroup.society.smp.admin.service.SocietySmpAdminService;
import global.segroup.util.PathConstants;

@Controller
public class SocietySmpAdminRestController implements PathConstants {

	private static final Logger logger = LoggerFactory.getLogger(SocietySmpAdminRestController.class);

	@Autowired
	private SocietyEduAdminService seaService;
	
	@Autowired
	private SocietySmpAdminService ssaService;

	/**
	 * @Method Name : searchApplyList
	 * @Date : 2018. 08. 19.
	 * @User : 여명환
	 * @Param : 기수 시퀀스, 현재페이지, 한페이지당 목록 수, 검색어, 정렬컬럼명, 정렬 방식
	 * @Return : 해당 기수의 학생 정보들 리스트 객체
	 * @Method 설명 : 특정 기수의 학생 정보들을 조회하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_SMP_SEARCH_STUDENT_LIST, method = RequestMethod.POST)

	public HashMap<String, Object> searchStudentList(String gisu_seq, @RequestParam(defaultValue = "1") String curPage,
			@RequestParam(defaultValue = "10") String pageCount, @RequestParam(defaultValue = "") String search_name,
			@RequestParam(defaultValue = "") String orderType, @RequestParam(defaultValue = "") String orderValue) {
		logger.debug("특정 기수 학생들 정보 조회 컨트롤러 시작");

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search_name", search_name); // 검색키워드
		map.put("gisu_seq", gisu_seq);
		map.put("orderType", orderType);
		map.put("orderValue", orderValue);
		System.out.println(map);
		int count = ssaService.selectSmpNumberOfStudent();
		map.put("count", count); // 레코드의 갯수
		// AdminPager.setBLOCK_SCALE(10);
		AdminPager.setPAGE_SCALE(Integer.parseInt(pageCount));
		AdminPager adminPager = new AdminPager(count, Integer.parseInt(curPage));
		adminPager.setPageEnd(30);
		
		ArrayList<Integer> pageCountList = new ArrayList<>();
		pageCountList.add(1);
		pageCountList.add(2);
		adminPager.setPageCountList(pageCountList);
		System.out.println(adminPager);
		map.put("adminPager", adminPager); // 페이징 객체
		ArrayList<HashMap<String, Object>> tempList = ssaService.smp_student_select(map);
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();

		int num = Integer.parseInt(pageCount);	// ~개씩의 개수
		for(int i = Integer.parseInt(curPage)*num-num; i < Integer.parseInt(curPage)*num && i < tempList.size(); i++) {
			if(tempList.get(i) != null)
				resultList.add(tempList.get(i));
		}
		resultList = ssaService.dataModify(resultList);	//데이터 가공해서 넘겨받음
		System.out.println(resultList.size());
		System.out.println(map);
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("pageCount", pageCount);
		resultMap.put("resultList", resultList);
		resultMap.put("adminPager", adminPager);
		
		logger.debug("특정 기수 학생들 정보 조회 컨트롤러 종료");
		return resultMap;
	}

	/**
	 * @Method Name : insertMemo
	 * @Date : 2018. 9. 08.
	 * @User : 여명환
	 * @Param : 학생 정보, 메모
	 * @Return : 과정 정보 객체
	 * @Method 설명 : 학적부 메모 삽입
	 */
	
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_INSERT_MEMO, method = RequestMethod.POST)
	public @ResponseBody boolean insertMemo(Authentication auth, String smp_memo, String app_id) {
		HashMap<String, Object> memo = new HashMap<>();
		memo.put("smp_memo", smp_memo);
		memo.put("app_id", app_id);
		ssaService.smp_insert_memo(memo);
		return true;
	}
	/**
	 * @Method Name : selectMemo
	 * @Date : 2018. 9. 09.
	 * @User : 여명환
	 * @Param : 학생 정보, 메모
	 * @Return : 과정 정보 객체
	 * @Method 설명 : 학적부 메모 조회
	 */
	
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_SELECT_MEMO, method = RequestMethod.POST)
	public @ResponseBody String selectMemo(Authentication auth, String app_id) {
		String memo = ssaService.smp_select_memo(app_id);
		return memo;
	}
	/**
	 * @Method Name : total_search_gisu
	 * @Date : 2018. 09. 11.
	 * @User : 여명환
	 * @Param : 기수 시퀀스, 현재페이지, 한페이지당 목록 수, 검색어, 정렬컬럼명, 정렬 방식
	 * @Return : 해당 기수의 학생 정보들 리스트 객체
	 * @Method 설명 : 특정 기수의 학생 정보들을 조회하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_SMP_TOTAL_SEARCH_GISU, method = RequestMethod.POST)

	public HashMap<String, Object> total_search_gisu(int gisu_seq, Model model) {
		logger.debug("특정 기수 학생들 정보 조회 컨트롤러 시작");

		int count = ssaService.selectGisuNumberOfTotal(gisu_seq);
		
		ArrayList<HashMap<String, Object>> resultList = ssaService.selectAPSTotal(gisu_seq);

		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("resultList", resultList);
		
		logger.debug("특정 기수 학생들 정보 조회 컨트롤러 종료");
		return resultMap;
	}
	/**
	 * @Method Name : group_search_gisu
	 * @Date : 2018. 09. 11.
	 * @User : 여명환
	 * @Param : 기수 시퀀스, 현재페이지, 한페이지당 목록 수, 검색어, 정렬컬럼명, 정렬 방식
	 * @Return : 해당 기수의 학생 정보들 리스트 객체
	 * @Method 설명 : 특정 기수의 학생 정보들을 조회하는 컨트롤러 함수
	 */
	/*@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_SMP_GROUP_SEARCH_GISU, method = RequestMethod.POST)

	public HashMap<String, Object> group_search_gisu(String gisu_seq, @RequestParam(defaultValue = "1") String curPage,
			@RequestParam(defaultValue = "10") String pageCount, @RequestParam(defaultValue = "") String search_name,
			@RequestParam(defaultValue = "") String orderType, @RequestParam(defaultValue = "") String orderValue, Model model) {
		logger.debug("특정 기수 학생들 정보 조회 컨트롤러 시작");

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search_name", search_name); // 검색키워드
		map.put("gisu_seq", gisu_seq);
		map.put("orderType", orderType);
		map.put("orderValue", orderValue);
		System.out.println(map);
		int count = ssaService.selectGisuNumberOfTotal(gisu_seq);
		map.put("count", count); // 레코드의 갯수
		// AdminPager.setBLOCK_SCALE(10);
		AdminPager.setPAGE_SCALE(Integer.parseInt(pageCount));
		AdminPager adminPager = new AdminPager(count, Integer.parseInt(curPage));
		adminPager.setPageEnd(30);
		
		ArrayList<Integer> pageCountList = new ArrayList<>();
		pageCountList.add(1);
		pageCountList.add(2);
		adminPager.setPageCountList(pageCountList);
		System.out.println(adminPager);
		map.put("adminPager", adminPager); // 페이징 객체
		ArrayList<HashMap<String, Object>> resultList = ssaService.selectAPSGroup(map);

		System.out.println(resultList.size());
		System.out.println(map);
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("pageCount", pageCount);
		resultMap.put("resultList", resultList);
		resultMap.put("adminPager", adminPager);
		
		logger.debug("특정 기수 학생들 정보 조회 컨트롤러 종료");
		return resultMap;
	}*/
	/**
	 * @Method Name : detail_search_gisu
	 * @Date : 2018. 09. 11.
	 * @User : 여명환
	 * @Param : 기수 시퀀스, 현재페이지, 한페이지당 목록 수, 검색어, 정렬컬럼명, 정렬 방식
	 * @Return : 해당 기수의 학생 정보들 리스트 객체
	 * @Method 설명 : 특정 기수의 학생 정보들을 조회하는 컨트롤러 함수
	 */
	/*@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_SMP_DETAIL_SEARCH_GISU, method = RequestMethod.POST)

	public HashMap<String, Object> detail_search_gisu(String gisu_seq, @RequestParam(defaultValue = "1") String curPage,
			@RequestParam(defaultValue = "10") String pageCount, @RequestParam(defaultValue = "") String search_name,
			@RequestParam(defaultValue = "") String orderType, @RequestParam(defaultValue = "") String orderValue, Model model) {
		logger.debug("특정 기수 학생들 정보 조회 컨트롤러 시작");

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search_name", search_name); // 검색키워드
		map.put("gisu_seq", gisu_seq);
		map.put("orderType", orderType);
		map.put("orderValue", orderValue);
		System.out.println(map);
		int count = ssaService.selectGisuNumberOfTotal(gisu_seq);
		map.put("count", count); // 레코드의 갯수
		// AdminPager.setBLOCK_SCALE(10);
		AdminPager.setPAGE_SCALE(Integer.parseInt(pageCount));
		AdminPager adminPager = new AdminPager(count, Integer.parseInt(curPage));
		adminPager.setPageEnd(30);
		
		ArrayList<Integer> pageCountList = new ArrayList<>();
		pageCountList.add(1);
		pageCountList.add(2);
		adminPager.setPageCountList(pageCountList);
		System.out.println(adminPager);
		map.put("adminPager", adminPager); // 페이징 객체
		ArrayList<HashMap<String, Object>> resultList = ssaService.selectAPSDetail(map);

		System.out.println(resultList.size());
		System.out.println(map);
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("pageCount", pageCount);
		resultMap.put("resultList", resultList);
		resultMap.put("adminPager", adminPager);
		
		logger.debug("특정 기수 학생들 정보 조회 컨트롤러 종료");
		return resultMap;
	}*/
	/**
	 * @Method Name : deleteTotal
	 * @Date : 2018. 9. 11.
	 * @User : 여명환
	 * @Param : 종합평가 삭제
	 * @Return : 종합평가 삭제
	 * @Method 설명 : 종합평가 삭제
	 */
	
	@RequestMapping(value = PathConstants.SOCIETY_SMP_DELETE_TOTAL, method = RequestMethod.POST)
	public @ResponseBody void deleteTotal(String smp_aps_total_seq) {
		ssaService.deleteTotal(smp_aps_total_seq);
	}
	
	/**
	 * @Method Name : deleteDetail
	 * @Date : 2018. 9. 11.
	 * @User : 여명환
	 * @Param : 상세평가 삭제
	 * @Return : 상세평가 삭제
	 * @Method 설명 : 상세평가 삭제
	 */
	
	@RequestMapping(value = PathConstants.SOCIETY_SMP_DELETE_DETAIL, method = RequestMethod.POST)
	public @ResponseBody void deleteDetail(String smp_aps_detail_seq) {
		ssaService.deleteDetail(smp_aps_detail_seq);
	}
	
	/**
	 * @Method Name : apsTotalList
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param :  
	 * @Return : ajax
	 * @Method 설명 : 평가항목종합 시퀀스, 이름 조회하는 컨트롤러 함수
	 */
	@RequestMapping(value = "/apsTotalList", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody List<SocietySmpApsTotal> apsTotalList(int gisu_seq) {
		return ssaService.selectApsTotalListByGisuSeq(gisu_seq);
	}
	
	/**
	 * @Method Name : apsGroupList
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param :  
	 * @Return : ajax
	 * @Method 설명 : 평가항목그룹 시퀀스, 이름 조회하는 컨트롤러 함수
	 */
	/*@RequestMapping(value = "/apsGroupList", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody List<SocietySmpApsGroup> apsGroupList(@RequestParam int smp_aps_total_seq) {
		return ssaService.selectApsGroupList(smp_aps_total_seq);
	}*/
	
	/**
	 * @Method Name : selectApsGroup
	 * @Date : 2019. 02. 13.
	 * @User : 김홍일
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 기수 값에 따른 그룹평가 리스트 전체 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_SELECT_APS_GROUP, method = RequestMethod.POST)
	public @ResponseBody ArrayList<HashMap<String, Object>> selectApsGroup(int gisu_seq) {

		System.out.println(ssaService.selectAPSGroup(gisu_seq));
		
		return ssaService.selectAPSGroup(gisu_seq);
	}
	
	/**
	 * @Method Name : selectApsDetail
	 * @Date : 2019. 02. 28.
	 * @User : 김홍일
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 기수 값에 따른 상세평가 리스트 전체 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_SELECT_APS_DETAIL, method = RequestMethod.POST)
	public @ResponseBody ArrayList<HashMap<String, Object>> selectApsDetail(int smp_aps_total_seq, int gisu_seq) {

		System.out.println(ssaService.selectAPSDetail(smp_aps_total_seq));
		
		return ssaService.selectAPSGroup(smp_aps_total_seq);
	}
	
	/**
	 * @Method Name : apsGroupList
	 * @Date : 2019. 02. 13.
	 * @User : 김홍일
	 * @Param :  
	 * @Return : ajax
	 * @Method 설명 : 종합평가에 따른 그룹평가 리스트를 호출하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_SELECT_APS_GROUP_LIST, method = RequestMethod.POST)
	public @ResponseBody ArrayList<HashMap<String, Object>> selectApsGroupList(int smp_aps_total_seq, int gisu_seq) {
		HashMap<String, Object> params  = new HashMap<>();
		params.put("smp_aps_total_seq", smp_aps_total_seq);
		params.put("gisu_seq", gisu_seq);
		return ssaService.selectApsGroupList(params);
	}
	
	/**
	 * @Method Name : deleteGroup
	 * @Date : 2019. 2. 25.
	 * @User : 김홍일
	 * @Param : 그룹평가 삭제
	 * @Return : 그룹평가 삭제
	 * @Method 설명 : 그룹평가 삭제
	 */
	
	@RequestMapping(value = PathConstants.SOCIETY_SMP_DELETE_GROUP, method = RequestMethod.POST)
	public @ResponseBody void deleteGroup(String smp_aps_group_seq) {
		ssaService.deleteGroup(smp_aps_group_seq);
	}
	
	/**
	 * @Method Name : apsDetailList
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param :  
	 * @Return : ajax
	 * @Method 설명 : 평가항목상세 시퀀스, 이름 조회하는 컨트롤러 함수
	 */
	@RequestMapping(value = "/apsDetailList", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody List<SocietySmpApsDetail> apsDetailList(@RequestParam int smp_aps_group_seq) {
		return ssaService.selectApsDetailList(smp_aps_group_seq);
	}
	
	/**
	 * @Method Name : ajaxTotalOverlab
	 * @Date : 2018. 09. 14.
	 * @User : 전희배
	 * @Param :  
	 * @Return : ajax
	 * @Method 설명 : 평가항목 total 중복검색
	 */
	@RequestMapping(value = "/ajaxTotalOverlab", method = RequestMethod.POST/*, produces = "application/json"*/)
	public @ResponseBody String ajaxTotalOverlab(int gisu_seq, String smp_aps_total_nm, @RequestParam(defaultValue = "0") int smp_aps_total_seq) {
		logger.debug("평가항목종합 조회 컨트롤러 시작");
		String result= "N";
		List<String> overlap = ssaService.selectTotalOverlap(gisu_seq, smp_aps_total_nm,smp_aps_total_seq);
		 //overlap.size()==0 이면 중복없음
		if(overlap.size()==0) {result="canInsert";}
		return result;
	}
	/**
	 * @Method Name : ajaxGroupOverlab
	 * @Date : 2018. 09. 14.
	 * @User : 전희배
	 * @Param :  
	 * @Return : ajax
	 * @Method 설명 : 평가항목 group 중복검색
	 */
	@RequestMapping(value = "/ajaxGroupOverlab", method = RequestMethod.POST)
	public @ResponseBody String ajaxGroupOverlab(int smp_aps_total_seq, String smp_aps_group_nm, @RequestParam(defaultValue = "0") int smp_aps_group_seq) {
		logger.debug("평가항목그룹 조회 컨트롤러 시작");
		String result= "N";
		List<String> overlap = ssaService.selectGroupOverlap(smp_aps_total_seq, smp_aps_group_nm,smp_aps_group_seq);
		System.out.println(overlap);
		 //overlap.size()==0 이면 중복없음
		if(overlap.size()==0) {result="canInsert";}
		return result;
	}
	/**
	 * @Method Name : ajaxDetailOverlab
	 * @Date : 2018. 09. 14.
	 * @User : 전희배
	 * @Param :  
	 * @Return : ajax
	 * @Method 설명 : 평가항목 detail 중복검색
	 */
	@RequestMapping(value = "/ajaxDetailOverlab", method = RequestMethod.POST)
	public @ResponseBody String ajaxDetailOverlab(int smp_aps_group_seq, String smp_aps_detail_nm, @RequestParam(defaultValue = "0") int smp_aps_detail_seq) {
		logger.debug("평가항목상세 조회 컨트롤러 시작");
		String result= "N";
		List<String> overlap = ssaService.selectDetailOverlap(smp_aps_group_seq, smp_aps_detail_nm,smp_aps_detail_seq);
		 //overlap.size()==0 이면 중복없음
		if(overlap.size()==0) {result="canInsert";}
		return result;
	}
	
	/**
	 * @Method Name : sumTotalRatio
	 * @Date : 2018. 09. 15.
	 * @User : 전희배
	 * @Param :  
	 * @Return : ajax
	 * @Method 설명 : 평가항목 total 비율 합계 조회
	 */
	@RequestMapping(value = "/ajaxSumTotalRatio", method = RequestMethod.POST)
	public @ResponseBody int sumTotalRatio(int gisu_seq, @RequestParam(defaultValue = "0") int smp_aps_total_seq) {
		logger.debug("평가항목 total 비율 합계 조회 시작");
		int result= 0;
		result = ssaService.sumTotalRatio(gisu_seq, smp_aps_total_seq);
		return result;
	}
	
	/**
	 * @Method Name : sumGroupRatio
	 * @Date : 2018. 09. 16.
	 * @User : 전희배
	 * @Param :  
	 * @Return : ajax
	 * @Method 설명 : 평가항목 group 비율 합계 조회
	 */
	@RequestMapping(value = "/ajaxSumGroupRatio", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody List<HashMap<String, Object>> sumGroupRatio(int gisu_seq, 
			@RequestParam(defaultValue = "0") int smp_aps_total_seq, @RequestParam(defaultValue = "0") int smp_aps_group_seq) {
		logger.debug("평가항목 group 비율 합계 조회 시작");
		List<HashMap<String, Object>> result= ssaService.sumGroupRatio(gisu_seq, smp_aps_total_seq,smp_aps_group_seq);
		return result;
	}
	
	/**
	 * @Method Name : ajaxTotalNm
	 * @Date : 2018. 09. 11.
	 * @User : 전희배
	 * @Param :  
	 * @Return : ajax
	 * @Method 설명 : 평가항목종합 시퀀스, 이름 조회하는 컨트롤러 함수
	 */
	@RequestMapping(value = "/ajaxTotalNm", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody List<HashMap<String, Object>> ajaxTotalNm(int gisu_seq, Model model) {
		logger.debug("평가항목종합 조회 컨트롤러 시작");
		List<HashMap<String, Object>> totalList = ssaService.selectApsTotalNm(gisu_seq);
		model.addAttribute("totalList", totalList);
		return totalList;
	}
	/**
	 * @Method Name : ajaxGroupNm
	 * @Date : 2018. 09. 11.
	 * @User : 전희배
	 * @Param :  
	 * @Return : ajax
	 * @Method 설명 : 평가항목그룹 시퀀스, 이름 조회하는 컨트롤러 함수
	 */
	@RequestMapping(value = "/ajaxGroupNm", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody List<HashMap<String, Object>> ajaxGroupNm(@RequestParam(defaultValue = "0")int smp_aps_total_seq) {
		logger.debug("평가항목그룹 조회 컨트롤러 시작");
		List<HashMap<String, Object>> groupList =ssaService.selectApsGroupNm(smp_aps_total_seq);
		return groupList;
	}
	/**
	 * @Method Name : ajaxDetailNm
	 * @Date : 2018. 09. 11.
	 * @User : 전희배
	 * @Param :  
	 * @Return : ajax
	 * @Method 설명 : 평가항목상세 시퀀스, 이름 조회하는 컨트롤러 함수
	 */
	@RequestMapping(value = "/ajaxDetailNm", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody List<HashMap<String, Object>> ajaxDetailNm(@RequestParam(defaultValue = "0")int smp_asp_group_seq) {
		logger.debug("평가항목상세 조회 컨트롤러 시작");
		List<HashMap<String, Object>> detailList = ssaService.selectApsDetailNm(smp_asp_group_seq);
		return detailList;
	}
	
	/**
	 * @Method Name : smp_schedule_selectAll
	 * @Date : 2018. 8. 24.
	 * @User : 박찬주
	 * @Param : 기수 시퀀스
	 * @Return : 기수별 일정 이벤트 리스트
	 * @Method 설명 : AJAX로 요청한 기수별 일정 이벤트를 조회한 후 전달하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_SCHEDULE_SELECTALL, method = RequestMethod.POST)
	public @ResponseBody List<SocietySmpScheduleScheduleColor> smp_schedule_selectAll(int gisu_seq) {
		return ssaService.selectAllSocietySmpSchedule(gisu_seq);
	}
	
	/**
	 * @Method Name : monthEventSelect
	 * @Date : 2018. 8. 24.
	 * @User : 박찬주
	 * @Param : 일정 이벤트 객체
	 * @Return : 특정 기수의 월별 이벤트 리스트
	 * @Method 설명 : AJAX로 요청한 특정 기수의 월별 이벤트를 조회한 후 전달하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_SCHEDULE_MONTHEVENT_SELECT, method = RequestMethod.POST)
	public @ResponseBody List<SocietySmpScheduleScheduleColor> monthEventSelect(SocietySmpSchedule schedule) {
		return ssaService.monthEventSelect(schedule);
	}
	
	/**
	 * @Method Name : smp_schedule_delete
	 * @Date : 2018. 8. 24.
	 * @User : 박찬주
	 * @Param : 일정 이벤트 객체
	 * @Return : JSP 학사관리 일정 페이지 요청
	 * @Method 설명 : 특정 일정 이벤트를 삭제하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_SCHEDULE_DELETE, method = RequestMethod.POST)
	public @ResponseBody String smp_schedule_delete(int smp_sch_seq) {
		ssaService.deleteSocietySmpSchedule(smp_sch_seq);
		return "일정이 삭제되었습니다";
	}

	/**
	 * @Method Name : smp_schedule_updateSch
	 * @Date : 2018. 8. 24.
	 * @User : 박찬주
	 * @Param : 일정 이벤트 객체
	 * @Return : JSP 학사관리 일정 페이지 요청
	 * @Method 설명 : 특정 일정 이벤트를 수정하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_SCHEDULE_UPDATE, method = RequestMethod.POST)
	public @ResponseBody String smp_schedule_updateSch(@RequestBody SocietySmpScheduleScheduleColor schedule) {
		ssaService.updateSocietySmpSchedule(schedule);
		return "일정 수정이 완료되었습니다";
	}

	/**
	 * @Method Name : smp_schedule_insertSch
	 * @Date : 2018. 8. 24.
	 * @User : 박찬주
	 * @Param : 일정 이벤트 객체
	 * @Return : JSP 학사관리 일정 페이지 요청
	 * @Method 설명 : 일정 이벤트를 입력하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_SCHEDULE_INSERT, method = RequestMethod.POST)
	public @ResponseBody String smp_schedule_insertSch(@RequestBody SocietySmpScheduleScheduleColor ssssColor) {
		ssaService.insertSocietySmpSchedule(ssssColor);
		return "일정 입력완료";
	}

	/**
	 * @Method Name : monthEventSelect
	 * @Date : 
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	@RequestMapping(value = "/smp/user/gisuTitleCheck", method = RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> monthEventSelect(int gisu_seq) {
		List<SocietySmpScheduleColor> lssScheCol =  ssaService.gisuTitleCheck(gisu_seq);
		HashMap<String, Object> hm = new HashMap<>();
		if(lssScheCol.isEmpty()) {
			hm.put("subject", null);
			return hm;
		}
		else {
			hm.put("subject", lssScheCol);
			
			return hm;
		}	
		
	}
	
	/**
	 * @Method Name : schColorInsert
	 * @Date : 
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	@RequestMapping(value = "/smp/admin/schColorInsert", method = RequestMethod.POST)
	public @ResponseBody boolean schColorInsert(@RequestBody List<SocietySmpScheduleColor> lssSchColor) {
		int cnt = ssaService.schColorInsert(lssSchColor);
		if(cnt>0){
			return true;
		}	
		return false;
	}
	
	/**
	 * @Method Name : schColorUpdate
	 * @Date : 
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	@RequestMapping(value = "/smp/admin/schColorUpdate", method = RequestMethod.POST)
	public @ResponseBody boolean schColorUpdate(@RequestBody List<SocietySmpScheduleColor> lssSchColor) {
		
		int cnt = 0;
		
		for(int i=0;i<lssSchColor.size();i++) {
			SocietySmpScheduleColor ssSC = lssSchColor.get(i);
			 cnt = ssaService.schColorUpdate(ssSC);
		}	
		
		if(cnt>0) {
			return true;
		}
		return false;
	}

	/**
	 * @Method Name : schColorDelete
	 * @Date : 
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	@RequestMapping(value = "/smp/admin/schColorDelete", method = RequestMethod.POST)
	public @ResponseBody boolean schColorDelete(@RequestBody List<SocietySmpScheduleColor> lssSchColor) {
		int cnt = 0;
		for(int i=0;i<lssSchColor.size();i++) {
			int smp_sch_color_seq = lssSchColor.get(i).getSmp_sch_color_seq();
			cnt = ssaService.schColorDelete(smp_sch_color_seq);
		}
		if(cnt>0) {
			return true;
		}
		return false;
	}
	
	/**
	 * @Method Name : smp_specific_user_gisu
	 * @Date : 2018. 08. 31.
	 * @User : 김진환
	 * @Param :
	 * @Return : session에 로그인한 유저의 gisu_seq 정보
	 * @Method 설명 :
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_SMP_SPECIFIC_USER_GISU, method = RequestMethod.POST)
	public SocietyEduAdminCurriculumGisu smp_specific_user_gisu(HttpSession session, Authentication auth, Model model) {
		User user = new User();
		if(auth != null) {
			user.setUser_id(auth.getName());
			User userInfo = seaService.user_info_select(user);
			String id = userInfo.getUser_id();
			SocietyEduAdminCurriculumGisu gisu_info = ssaService.get_specific_user_gisu(id);
			return gisu_info;
		} else
			return null;
	}
	
	/**
	 * @Method Name : applySetList
	 * @Date : 2018. 09. 13.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_APPLYSETLIST, method = RequestMethod.POST)
	public @ResponseBody boolean applySetList(int gisu_seq, int setlist_seq, Authentication auth) {
		List<SocietySmpApsTotal> smpApsTotalList = ssaService.selectApsTotalListByGisuSeq(gisu_seq);
		if(smpApsTotalList.isEmpty()==false){
			ssaService.deleteSmpApsTotal(gisu_seq);
		}
		List<SocietySmpApsSetTotal> smpApsSetTotal = ssaService.selectSmpApsSetTotal(setlist_seq);
		for(int i=0;i<smpApsSetTotal.size();i++){
			SocietySmpApsTotal total = new SocietySmpApsTotal();
			total.setGisu_seq(gisu_seq);
			total.setSmp_aps_total_nm(smpApsSetTotal.get(i).getSmp_aps_settotal_nm());
			total.setSmp_aps_total_ratio(smpApsSetTotal.get(i).getSmp_aps_settotal_ratio());
			total.setSmp_aps_total_ins_id(auth.getName());
			total.setSmp_aps_total_udt_id(auth.getName());
			ssaService.insertApsTotalSetting(total);
			List<SocietySmpApsSetGroup> smpApsSetGroup = ssaService.selectSmpApsSetGroup(smpApsSetTotal.get(i).getSmp_aps_settotal_seq());
			
			for(int j=0;j<smpApsSetGroup.size();j++){
				SocietySmpApsGroup group = new SocietySmpApsGroup();
				group.setSmp_aps_total_seq(total.getSmp_aps_total_seq());
				group.setSmp_aps_group_tp(smpApsSetGroup.get(j).getSmp_aps_setgroup_tp());
				group.setSmp_aps_group_ins_id(auth.getName());
				group.setSmp_aps_group_udt_id(auth.getName());
				ssaService.insertApsGroupSetting(group);
				List<SocietySmpApsSetDetail> smpApsSetDetail = ssaService.selectSmpApsSetDetail(smpApsSetGroup.get(j).getSmp_aps_setgroup_seq());
				
				for(int k=0;k<smpApsSetDetail.size();k++){
					SocietySmpApsDetail detail = new SocietySmpApsDetail();
					detail.setSmp_aps_group_seq(group.getSmp_aps_group_seq());
					detail.setSmp_aps_detail_nm(smpApsSetDetail.get(k).getSmp_aps_setdetail_nm());
					detail.setSmp_aps_detail_ratio(smpApsSetDetail.get(k).getSmp_aps_setdetail_ratio());
					detail.setSmp_aps_detail_ins_id(auth.getName());
					detail.setSmp_aps_detail_udt_id(auth.getName());
					ssaService.insertApsDetailSetting(detail);
				}
			}
		}
		
		return true;
	}
	
	/**
	 * @Method Name : smp_aps_setTotal_selectSetTotal
	 * @Date : 2018. 09. 14.
	 * @User : 김진환
	 * @Param :  
	 * @Return : smp_aps_setTotal
	 * @Method 설명 : 
	 */
	
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_SELECTSETTOTAL, method = RequestMethod.POST)
	public @ResponseBody List<SocietySmpApsSetTotal> smp_aps_setTotal_selectSetTotal(int smp_aps_setlistseq) {
		return ssaService.selectSmpApsSetTotal(smp_aps_setlistseq);
	}
	
	/**
	 * @Method Name : smp_aps_setGroup_appendGroup
	 * @Date : 2018. 09. 14.
	 * @User : 김진환
	 * @Param :  
	 * @Return : smp_aps_setGroup
	 * @Method 설명 : 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_APPENDGROUP, method = RequestMethod.POST)
	public @ResponseBody List<SocietySmpApsSetGroup> smp_aps_setGroup_appendGroup(int smp_aps_settotal_seq) {
		List<SocietySmpApsSetGroup> returnGroup = ssaService.selectSmpApsSetGroup(smp_aps_settotal_seq);
		return returnGroup;
	}
	
	/**
	 * @Method Name : smp_aps_setdetail_appendDetail
	 * @Date : 2018. 09. 14.
	 * @User : 김진환
	 * @Param :  
	 * @Return : smp_aps_setDetail
	 * @Method 설명 : 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_APPENDDETAIL, method = RequestMethod.POST)
    public @ResponseBody List<SocietySmpApsSetDetail> smp_aps_setdetail_appendDetail(int smp_aps_setgroup_seq) {
        List<SocietySmpApsSetDetail> returnDetail = ssaService.selectSmpApsSetDetail(smp_aps_setgroup_seq);     
        return returnDetail;
    }
	
	/**
	 * @Method Name : smp_aps_setTotal_newTotal
	 * @Date : 2018. 09. 19.
	 * @User : 김진환
	 * @Param :  
	 * @Return : setTotal 추가
	 * @Method 설명 : 
	 */
	// 김준영 주석
	// SocietySmpApsSetTotal 객체로 받을 수 있지만 jsp단과 변수명이 일치하지 않음
	// segroup / society / smp / admin / aps_setlist.jsp 805번째 줄과 연결
	// 데이터 베이스 smp_aps_settotal_tb 테이블에 들어감
	// 변경 완료 - 테스트 필요
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_NEWTOTAL, method = RequestMethod.POST)
    public @ResponseBody int smp_aps_setTotal_newTotal(Authentication auth, SocietySmpApsSetTotal societySmpApsSetTotal) {
        int setlist_seq=societySmpApsSetTotal.getSmp_aps_setlist_seq();
        
        List<SocietySmpApsSetTotal> setTotalList = ssaService.selectSmpApsSetTotal();
        int ratio=societySmpApsSetTotal.getSmp_aps_settotal_ratio();

        for(SocietySmpApsSetTotal i : setTotalList) {
        	if(i.getSmp_aps_setlist_seq()==societySmpApsSetTotal.getSmp_aps_setlist_seq()) {
        		ratio+=i.getSmp_aps_settotal_ratio();
        	}
        	if(ratio>100) {
        		return ratio;
        	}
        }
        societySmpApsSetTotal.setSmp_aps_settotal_ins_id(auth.getName());
		ssaService.insertApsSetTotal(societySmpApsSetTotal);
        return ratio;
    }
	
	/**
	 * @Method Name : smp_aps_setGroup_newGroup
	 * @Date : 2018. 09. 19.
	 * @User : 김진환
	 * @Param :  
	 * @Return : setGroup 추가
	 * @Method 설명 : 
	 */
	// 김준영 주석
	// SocietySmpApsSetGroup 객체로 받을 수 있지만 jsp단과 변수명이 일치하지 않음
	// segroup / society / smp / admin / aps_setlist.jsp 857번째 줄과 연결
	// 데이터 베이스 smp_aps_setgroup_tb 테이블에 들어감
	// 변경 완료 - 테스트 필요
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_NEWGROUP, method = RequestMethod.POST)
    public @ResponseBody int smp_aps_setGroup_newGroup(Authentication auth, SocietySmpApsSetGroup societySmpApsSetGroup) {
		
        List<SocietySmpApsSetGroup> setGroupList = ssaService.selectSmpApsSetGroup(societySmpApsSetGroup.getSmp_aps_settotal_seq());
        int ratio=societySmpApsSetGroup.getSmp_aps_setgroup_ratio();
        for(SocietySmpApsSetGroup i : setGroupList) {
        	if(i.getSmp_aps_settotal_seq()==societySmpApsSetGroup.getSmp_aps_settotal_seq()) {
        		ratio+=i.getSmp_aps_setgroup_ratio();
        	}
        	if(ratio>100) {
        		return ratio;
        	}
        }

        societySmpApsSetGroup.setSmp_aps_setgroup_ins_id(auth.getName());
		ssaService.insertApsSetGroup(societySmpApsSetGroup);
        return ratio;
    }
	
	/**
	 * @Method Name : smp_aps_setTotal_newDetail
	 * @Date : 2018. 09. 19.
	 * @User : 김진환
	 * @Param :  
	 * @Return : setDetail 추가
	 * @Method 설명 : 
	 */
	// 김준영 주석
	// SocietySmpApsSetDetail 객체로 받을 수 있지만 jsp단과 변수명이 일치하지 않음; 
	// segroup / society / smp / admin / aps_setlist.jsp 909번째 줄과 연결
	// 데이터 베이스 smp_aps_setdetail_tb 테이블에 들어감
	// 변경완료 - 테스트 필요
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_NEWDETAIL, method = RequestMethod.POST)
    public @ResponseBody int smp_aps_setDetail_newDetail(Authentication auth, SocietySmpApsSetDetail societySmpApsSetDetail) {
        int ratio=societySmpApsSetDetail.getSmp_aps_setdetail_ratio();
        // smp_aps_setgroup_seq, smp_aps_setdetail_nm, setSmp_aps_setdetail_ratio
        societySmpApsSetDetail.setSmp_aps_setdetail_ins_id(auth.getName());
		ssaService.insertApsSetDetail(societySmpApsSetDetail);
        return ratio;
    }
	
	/**
	 * @Method Name : deleteSetList
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param :  
	 * @Return :
	 * @Method 설명 : 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_DELETESETLIST, method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody boolean deleteSetList(int setlist_seq){
		int result= ssaService.deleteSetList(setlist_seq);
		if(result>0){
			return true;
		}
		return false;
	}
	
	/**
	 * @Method Name : deleteSet
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param :  
	 * @Return :
	 * @Method 설명 : 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_DELETESET, method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody boolean deleteSet(int set_seq, int section){
		int result;
		if(section==1){
			result= ssaService.deleteSetTotal(set_seq);
		}
		else if(section==2){
			result= ssaService.deleteSetGroup(set_seq);
		}
		else{
			result= ssaService.deleteSetDetail(set_seq);
		}
		
		if(result>0){
			return true;
		}	
		return false;
	}
	
	/**
	 * @Method Name : selectSet
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param :  
	 * @Return :
	 * @Method 설명 : 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_SELECTSET, method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody HashMap<String, Object> selectSet(int set_seq, int section){
		HashMap<String, Object> map = new HashMap<>();
		if(section==1){
			SocietySmpApsSetTotal total = ssaService.selectApsSetTotal(set_seq);
			map.put("smp_aps_settotal_nm", total.getSmp_aps_settotal_nm());
			map.put("smp_aps_settotal_ratio", total.getSmp_aps_settotal_ratio());
			map.put("smp_aps_settotal_seq", total.getSmp_aps_settotal_seq());
		}
		else if(section==2){
			SocietySmpApsSetGroup group = ssaService.selectSetGroup(set_seq);
			map.put("smp_aps_setgroup_nm", group.getSmp_aps_setgroup_nm());
			map.put("smp_aps_setgroup_ratio", group.getSmp_aps_setgroup_ratio());
			map.put("smp_aps_setgroup_seq", group.getSmp_aps_setgroup_seq());
			map.put("smp_aps_setgroup_tp", group.getSmp_aps_setgroup_tp());
		}
		else{
			SocietySmpApsSetDetail detail = ssaService.selectSetDetail(set_seq);
			map.put("smp_aps_setdetail_nm", detail.getSmp_aps_setdetail_nm());
			map.put("smp_aps_setdetail_ratio", detail.getSmp_aps_setdetail_ratio());
			map.put("smp_aps_setdetail_seq", detail.getSmp_aps_setdetail_seq());
		}
		return map;
	}
	
	/**
	 * @Method Name : setUpdate
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주s
	 * @Param :  
	 * @Return :
	 * @Method 설명 : 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_APS_SETUPDATE, method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody int selectSet(int set_seq, int section, int set_ratio, String set_nm, 
										@RequestParam(defaultValue = "0")String set_tp, Authentication auth, 
										@RequestParam(defaultValue = "0")int parent_seq)
	{
		if(section==1){
			SocietySmpApsSetTotal settotal = ssaService.selectApsSetTotal(set_seq);
			List<SocietySmpApsSetTotal> list = ssaService.selectSmpApsSetTotal(parent_seq);
			int value=set_ratio;
			for(SocietySmpApsSetTotal i : list){
				value+=i.getSmp_aps_settotal_ratio();
			}
			if(value-settotal.getSmp_aps_settotal_ratio()>100){
				return -1;
			}
			SocietySmpApsSetTotal total = new SocietySmpApsSetTotal();
			total.setSmp_aps_settotal_seq(set_seq);
			total.setSmp_aps_settotal_nm(set_nm);
			total.setSmp_aps_settotal_ratio(set_ratio);
			total.setSmp_aps_settotal_udt_id(auth.getName());
			ssaService.updateSetTotal(total);
		}
		else if(section==2){
			SocietySmpApsSetGroup setgroup = ssaService.selectSetGroup(set_seq);
			List<SocietySmpApsSetGroup> list = ssaService.selectSmpApsSetGroup(parent_seq);
			int value=set_ratio;
			for(SocietySmpApsSetGroup i : list){
				value+=i.getSmp_aps_setgroup_ratio();
			}
			if(value-setgroup.getSmp_aps_setgroup_ratio()>100){
				return -1;
			}
			SocietySmpApsSetGroup group = new SocietySmpApsSetGroup();
			group.setSmp_aps_setgroup_seq(set_seq);
			group.setSmp_aps_setgroup_nm(set_nm);
			group.setSmp_aps_setgroup_ratio(set_ratio);
			group.setSmp_aps_setgroup_tp(set_tp);
			group.setSmp_aps_setgroup_udt_id(auth.getName());
			ssaService.updateSetGroup(group);
		}
		else{
			SocietySmpApsSetDetail detail = new SocietySmpApsSetDetail();
			detail.setSmp_aps_setdetail_seq(set_seq);
			detail.setSmp_aps_setdetail_nm(set_nm);
			detail.setSmp_aps_setdetail_ratio(set_ratio);
			detail.setSmp_aps_setdetail_udt_id(auth.getName());
			ssaService.updateSetDetail(detail);
		}
		
		return section;
	}
	
	
	@RequestMapping(value = PathConstants.SOCIETY_SMP_ADMIN_UPDATE_BOARD_PD, method = RequestMethod.GET, produces = "application/json")
	public @ResponseBody int update_board_pd(BoardGroup boardGroup){
		logger.error("param : {}", boardGroup);
		int result = ssaService.update_board_pd(boardGroup.getBoard_seq(), boardGroup.getBoard_icon_pd());
		return result;
	}
	
}

