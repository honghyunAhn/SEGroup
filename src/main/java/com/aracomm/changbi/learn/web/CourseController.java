package com.aracomm.changbi.learn.web;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.base.common.util.CookieUtil;
import com.aracomm.base.exceptions.InvalidRightException;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.common.base.BaseController;
import com.aracomm.changbi.learn.service.CourseService;
import com.aracomm.changbi.learn.vo.CardinalSearchVo;
import com.aracomm.changbi.serviceCenter.service.BbsService;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping(value = "/learn/course")
public class CourseController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(CourseController.class);
	private static final int VIEWCOURSES_COOKIE_EXPIRED_MINUTES = 1440;		// 24시간

	@Value("#{config['popupPages']}")
	String popupPages;

	@Value("#{config['boardPages']}")
	String boardPages;

	@Autowired
	private CourseService service;

	@Autowired
	private BbsService bservice;

	@RequestMapping(value = "/course")
	public String course(Model model, @RequestParam HashMap<String,String> param) {
		model.addAttribute("code",service.code(GlobalConst.CODE_GROUP_COURSE));

		param.put("learn_types", "J");
		model.addAttribute("slide", service.slide());
		model.addAttribute("list", service.selectCourseList(param));
		model.addAttribute("listCnt", service.selectCourseListTotCnt(param));
		model.addAttribute("paramp", param);
		return "learn/course/course";
	}
	@RequestMapping(value = "/grades")
	public String grades(Model model, @RequestParam HashMap<String,String> param) {
		param.put("learn_types", "J");
		model.addAttribute("slide", service.slide());
		model.addAttribute("list", service.selectCourseList(param));
		model.addAttribute("listCnt", service.selectCourseListTotCnt(param));
		model.addAttribute("paramp", param);
		return "learn/course/grades";
	}
	@RequestMapping(value = "/object")
	public String object(Model model, @RequestParam HashMap<String,String> param) {
		param.put("learn_types", "J");
		model.addAttribute("slide", service.slide());
		model.addAttribute("list", service.selectCourseList(param));
		model.addAttribute("listCnt", service.selectCourseListTotCnt(param));
		model.addAttribute("paramp", param);
		return "learn/course/object";
	}
	@RequestMapping(value = "/group")
	public String group(Model model, @RequestParam HashMap<String,String> param) {
		if(StringUtils.isEmpty(param.get("closed"))) {
			param.put("closed", "N");
		}
		model.addAttribute("list", service.selectGroupLearnList(param));
		model.addAttribute("paramp", param);

		return "learn/course/group";
	}
	@RequestMapping(value = "/groupDetail")
	public String groupDetail(Model model, @RequestParam HashMap<String,String> param, HttpServletRequest request, HttpServletResponse response) {
		String course_id = param.get("course_id");
		String cardinal_seq = param.get("cardinal_seq");
		HashMap<String, Object> detail = service.selectGroupLearn(param);
		model.addAttribute("detail", detail);
		model.addAttribute("cardinalList", service.selectCardinalBySeq(cardinal_seq));
		model.addAttribute("paramp", param);

		// facebook og data
		Map<String, String> ogdata = new HashMap<String, String>();
		ogdata.put("description", (String)detail.get("SUMMARY"));
		ogdata.put("image", (String)detail.get("URL_PATH"));
		model.addAttribute(GlobalConst.FACEBOOK_OG_KEY, ogdata);

		// 인기순위갱신
		String viewCourses = CookieUtil.getCookieObject(request, GlobalConst.COOKIE_NAME_VIEWCOURSES, "");
		String vcs [] = viewCourses.split("_");
		boolean alreadyHit = false;
		if (vcs.length > 0 && course_id != null) {
			for(int i=0; i<vcs.length; i++) {
				if(course_id.equals(vcs[i])) {
					alreadyHit = true;
					break;
				}
			}

			if (!alreadyHit) {
				service.updateCourseHitsOrderPlus(param.get("course_id"));

				String [] s= vcs;
				if(vcs.length >= GlobalConst.COOKIE_VIEWCOURSES_MAX) {
					s = Arrays.copyOfRange(vcs, vcs.length-GlobalConst.COOKIE_VIEWCOURSES_MAX+1, vcs.length);
				}
				String nvcs = org.apache.commons.lang3.StringUtils.join(s, "_");
				nvcs = (nvcs.length() < 0?"":"_")+course_id;
				CookieUtil.setCookieObject(response, GlobalConst.COOKIE_NAME_VIEWCOURSES, nvcs, VIEWCOURSES_COOKIE_EXPIRED_MINUTES);
			}
		}

		return "learn/course/groupdetail";
	}

	@RequestMapping(value = "/autonomy")
	public String autonomy(Model model, @RequestParam HashMap<String,String> param) {
		param.put("learn_types", "S");
		model.addAttribute("slide", service.slide());
		model.addAttribute("list", service.selectCourseList(param));
		model.addAttribute("listCnt", service.selectCourseListTotCnt(param));
		model.addAttribute("paramp", param);
		return "learn/course/autonomy";
	}
	@RequestMapping(value = "/set")
	public String set(Model model, @RequestParam HashMap<String,String> param) {
		param.put("learn_types", "M");
		model.addAttribute("slide", service.slide());
		model.addAttribute("list", service.selectCourseList(param));
		model.addAttribute("listCnt", service.selectCourseListTotCnt(param));
		model.addAttribute("paramp", param);
		return "learn/course/set";
	}

	@RequestMapping(value = "/detail")
	public String detail(Model model, @RequestParam HashMap<String,String> param, HttpServletRequest request, HttpServletResponse response) {

		String course_id = param.get("course_id");
		Map<String, Object> detail = service.selectCourseDetail(param);
		model.addAttribute("detail", detail);
		model.addAttribute("cardinalList", service.selectCourseCardinalListAll(course_id));
		model.addAttribute("chapterList", service.selectCourseChapterListAll(course_id));

		// facebook og data
		Map<String, String> ogdata = new HashMap<String, String>();
		ogdata.put("description", (String)detail.get("SUMMARY"));
		ogdata.put("image", (String)detail.get("URL_PATH"));
		model.addAttribute(GlobalConst.FACEBOOK_OG_KEY, ogdata);

		// 인기순위갱신
		String viewCourses = CookieUtil.getCookieObject(request, GlobalConst.COOKIE_NAME_VIEWCOURSES, "");
		String vcs [] = viewCourses.split("_");
		boolean alreadyHit = false;
		if (vcs.length > 0 && course_id != null) {
			for(int i=0; i<vcs.length; i++) {
				if(course_id.equals(vcs[i])) {
					alreadyHit = true;
					break;
				}
			}

			if (!alreadyHit) {
				service.updateCourseHitsOrderPlus(param.get("course_id"));

				String [] s= vcs;
				if(vcs.length >= GlobalConst.COOKIE_VIEWCOURSES_MAX) {
					s = Arrays.copyOfRange(vcs, vcs.length-GlobalConst.COOKIE_VIEWCOURSES_MAX+1, vcs.length);
				}
				String nvcs = org.apache.commons.lang3.StringUtils.join(s, "_");
				nvcs = (nvcs.length() < 0?"":"_")+course_id;
				CookieUtil.setCookieObject(response, GlobalConst.COOKIE_NAME_VIEWCOURSES, nvcs, VIEWCOURSES_COOKIE_EXPIRED_MINUTES);
			}
		}

		return "learn/course/detail";
	}

	/**
	 * 과정 기수 리스트 조회
	 * @param searchVo
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/ajaxCourseNotationList")
	public @ResponseBody HashMap<String, Object> ajaxCourseNotationList(Model model, CardinalSearchVo searchVo) throws Exception {
		HashMap<String, Object> result = getSimpleAjaxResult();

		result.put("cardinalList", service.selectCourseCardinalList(searchVo));
		result.put("searchVo", searchVo);

		return result;
	}

	@RequestMapping(value = "/review")
	public @ResponseBody Object review(Model model, @RequestParam HashMap<String,String> param) throws Exception {
		param.put("board_type", GlobalConst.BBS_TYPE_REVIEW);
		param.put("startPage", CommonUtil.getStart(param.get("startPage"), boardPages));
		param.put("visiblePages", boardPages);
		int totalCnt = bservice.selectBbsListTotCnt(param);

		param.put("startPage", param.get("startPage"));
		param.put("totalCnt", String.valueOf(totalCnt));
		param.put("totalPages", String.valueOf(CommonUtil.getTotalPage(totalCnt,Integer.parseInt(boardPages))));

		ObjectMapper mapper = new ObjectMapper();
		HashMap<String,String> paging = new HashMap<String,String>();
		paging.put("pagingParam", mapper.writeValueAsString(param));
		paging.put("list", mapper.writeValueAsString(bservice.selectBbsList(param)));
		return paging;
	}

	/**
	 * 리뷰보기
	 * @param model
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/layer/reviewdetail")
	public String reviewdetail(Model model, String id) throws Exception {

		HashMap<String, String> param = new HashMap<String, String>();
		param.put("id", id);
		HashMap<String, String> detail = bservice.selectBbsDetail(param);

		// 권한체크
		checkBbsOwnerWithException(getLoginUserId(), detail.get("user_id"), detail.get("board_type"), detail.get("secretYn"));

		model.addAttribute("detail", detail);

		// 조회수 증가
		bservice.updateHits(id);

		return "learn/course/layer/reviewdetail";
	}

	/**
	 * 과정 교재 정보
	 * @param model
	 * @param course_id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/layer/bookinfo")
	public String bookinfo(Model model, String course_id) throws Exception {

		Map<String, Object> book = service.selectCourseMainBookInfo(course_id);

		model.addAttribute("book", book);

		return "learn/course/layer/bookinfo";
	}


	/**
	 * 게시물 접근 권한 체크
	 * @param loginId
	 * @param owner
	 * @param boardType
	 * @param secretYn
	 */
	private void checkBbsOwnerWithException(String loginId, String owner, String boardType, String secretYn) {
		// 1:1상담이나 비밀글은 자신만 볼 수 있고 수정할 수 있음
		if(GlobalConst.BBS_TYPE_CONSULT.equals(boardType) || "Y".equals(secretYn)) {
			if (StringUtils.isEmpty(loginId) || !loginId.equals(owner)) {
				throw new InvalidRightException();	// 권한없음 exception
			}
		}
	}

}
