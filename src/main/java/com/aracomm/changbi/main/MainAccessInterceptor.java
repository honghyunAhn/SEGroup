package com.aracomm.changbi.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.aracomm.changbi.board.vo.BoardSearchVo;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.common.service.BannerService;
import com.aracomm.changbi.course.service.ChangbiCourseService;
import com.aracomm.changbi.serviceCenter.service.BbsService;



public class MainAccessInterceptor extends HandlerInterceptorAdapter {
	
	@Autowired
	private BannerService bannerService;
	
	@Autowired
	private BbsService bbsService;

	@Autowired
	private ChangbiCourseService courseService;

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
		
		
		// 헤더 적용 (smtp에서는 불필요하기 때문에 빼주었음)
		if (modelAndView != null && !("segroup/society/smtp/**".equals(modelAndView.getViewName()))) {
			// 최상단 배너
			List<Map<String, Object>> topBannerList = bannerService.selectBannerList("1");
			
			// 공지사항  리스트
			BoardSearchVo searchVo = new BoardSearchVo();
			searchVo.setTop(5);
			searchVo.setBoard_type(GlobalConst.BBS_TYPE_NOTICE); //1
			searchVo.setNotice_type("1"); // 공지사항만
			List<Map<String, Object>> headerNoticeList = bbsService.selectSimpleTopBoardList(searchVo);
			
			modelAndView.addObject("topBannerList", topBannerList);
			modelAndView.addObject("headerNoticeList", headerNoticeList);

			//header 전체보기 리스트 동적 관리
			List<HashMap<String, String>> courseList = courseService.selectCourseList();
			modelAndView.addObject("courseList", courseList);

			
		
		}
		
		
	}
}
