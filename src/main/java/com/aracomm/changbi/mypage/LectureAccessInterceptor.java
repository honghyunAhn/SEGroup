package com.aracomm.changbi.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.aracomm.base.common.AraCommConst;
import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.changbi.common.GlobalConst;
import com.aracomm.changbi.user.dao.UserDao;
import com.aracomm.changbi.user.vo.UserVo;

/**
 * 강의실 입장시 본인인증체크 및 등록 IP체크
 * @author Park
 *
 */
public class LectureAccessInterceptor extends HandlerInterceptorAdapter {
	@Autowired
	private UserDao dao;

	@Resource(name="messageSource")
	private MessageSource messageSource;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		Authentication authen = SecurityContextHolder.getContext().getAuthentication();
		if (authen == null || authen.getPrincipal() instanceof String) {	// 로그인x
			response.sendRedirect(AraCommConst.URL_LOGOUOT);
			return false;
		}

		UserVo userVo = (UserVo)authen.getPrincipal();

		// 등록 ip 체크
		int count = 0;
		String username = userVo.getUsername();
		List<HashMap<String, String>> ipList = dao.selectIpList(username);
		if (ipList != null && ipList.size() > 0) {
			Map<String, String> param = new HashMap<String, String>();
			param.put("user_id", username);
			param.put("ip", CommonUtil.getRemoteAddr(request));
			count = dao.selectUserIpCount(param);
		}

		if (count < 1) {
			String message = messageSource.getMessage("msg.mypage.notregisterdip", null, Locale.getDefault());
			request.setAttribute("script", "alert('"+cr2slashn(message)+"'); location.href='"+GlobalConst.URL_MYPAGE_IP+"'");
			request.getRequestDispatcher(AraCommConst.URL_FORWARD).forward(request, response);
			return false;
		}


		// 본인인증 체크
		if (!userVo.isSelfCertDone()) {	// 본인 인증이 필요

			// 강의실 입장을 위해 본인인증을 거쳤을 경우는 본인인증완료 설정
			HttpSession session = request.getSession();
			String ss_iden_di = (String)session.getAttribute(GlobalConst.SESSION_KEY_IDEN_DI);
			if (!StringUtils.isEmpty(ss_iden_di)) {
				session.removeAttribute(GlobalConst.SESSION_KEY_IDEN_DI);
				userVo.setSelfCertDone(true);	// 본인인증완료
			} else {
				/*String id = request.getParameter("id");
				String cardinal_id = request.getParameter("cardinal");
				String course_id = request.getParameter("course");

				response.sendRedirect(GlobalConst.URL_LECTURE_SELFCERT+"?id="+id+"&cardinal="+cardinal_id+"&course="+course_id);
				return false;*/
				session.removeAttribute(GlobalConst.SESSION_KEY_IDEN_DI);
				userVo.setSelfCertDone(true);	// 본인인증완료
			}

		}


		return true;
	}

	private String cr2slashn(String str) {
		return str.replaceAll("\\n", "\\\\n");
	}

}
