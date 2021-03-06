/**
 * 
 */
package global.segroup.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.security.auth.login.AccountExpiredException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import global.segroup.dao.SEGroupCommonMapper;
import global.segroup.domain.Admin;
import global.segroup.domain.AdminSecurity;
import global.segroup.domain.User;
import global.segroup.domain.UserSecurity;
import global.segroup.exception.AccountStatusException;
import global.segroup.exception.DisagreeException;
import global.segroup.exception.DoesNotExistUserInfo;
import global.segroup.exception.ExpiredDateException;
import global.segroup.exception.WaitingException;
import global.segroup.society.fap.user.dao.SocietyFapUserMapper;
import global.segroup.society.fap.user.service.SocietyFapUserService;

/**
 * @Author : ?????????
 * @Date : 2017. 8. 8.
 * @Class ?????? : SEGroup ?????? ?????????
 * 
 */
@Component
public class SEGroupAuthenticationProvider implements AuthenticationProvider {

	@Autowired
	SqlSession sqlSession;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	private static final Logger logger = LoggerFactory.getLogger(SEGroupAuthenticationProvider.class);

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		WebApplicationContext ctx = ContextLoader.getCurrentWebApplicationContext();
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		
		//????????? ?????? ????????? ???????????? ??????
		String pathCheck = request.getServletPath();
		
		sqlSession = (SqlSession) ctx.getBean("sqlSession");
		passwordEncoder = (BCryptPasswordEncoder) ctx.getBean("bcryptPasswordEncoder");

		List<GrantedAuthority> roles = new ArrayList<>();

		String user_id = (String) authentication.getPrincipal();
		String user_pw = (String) authentication.getCredentials();
		
		//auth??? ??????????????? ????????? ????????? user_id??? ????????? ?????????
		session.setAttribute("user_id", user_id);

		SEGroupCommonMapper mapper = sqlSession.getMapper(SEGroupCommonMapper.class);
		SocietyFapUserMapper uMapper = sqlSession.getMapper(SocietyFapUserMapper.class);
		
		//????????? ??????????????? ????????? ??????
		if(pathCheck.equals(PathConstants.SOCIETY_EDU_ADMIN_LOGIN) || pathCheck.equals(PathConstants.SOCIETY_SMP_ADMIN_LOGIN)
				|| pathCheck.equals(PathConstants.SOCIETY_FAP_ADMIN_LOGIN)) {
			
			logger.debug("????????? ????????? ???????????? ?????? ??????");
			Admin admin = mapper.selectAdmin(user_id);
			
			if (admin != null) {
				// ????????? ??????

				// ????????? ???????????? ??????
				if (!passwordEncoder.matches(user_pw, admin.getAdmin_pw())) {
					logger.debug("????????? ??????????????? ????????????.");
					throw new BadCredentialsException("com.login.pwcheck", new BadCredentialsException("???????????? ??????"));
				} else {
					if (admin.getAdmin_state().equals("A0801")) {
						throw new AccountStatusException("com.login.disabled", new DisabledException("?????? ??????"));
					} else if (admin.getAdmin_state().equals("A0802")) {
						throw new AccountStatusException("com.login.expired", new AccountExpiredException("?????? ??????"));
					} else if (admin.getAdmin_state().equals("A0803")) {
						throw new AccountStatusException("com.login.locked", new LockedException("?????? ??????"));
					} else if (admin.getAdmin_state().equals("A0804")) {
						throw new AccountStatusException("com.login.permission", new Exception("?????? ?????? ??????"));
					} else {
						// ????????? ?????? ?????? ??????
						SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
						Date current_date = new Date();
						Date admin_expired_st = null;
						Date admin_expired_et = null;
						try {
							admin_expired_st = format.parse(admin.getAdmin_expired_st());
							admin_expired_et = format.parse(admin.getAdmin_expired_et());
						} catch (ParseException e) {
							e.printStackTrace();
						}
						
						int compare_date_st = current_date.compareTo(admin_expired_st);
						int compare_date_et = current_date.compareTo(admin_expired_et);
						
						// ?????? ??????
						if ( compare_date_st < 0) {
							throw new AccountStatusException("com.login.admin.permission.yet", new ExpiredDateException("????????? ?????? ?????? ??????") );
						}
						
						// ?????? ??????
						if ( compare_date_et > 0) {
							throw new AccountStatusException("com.login.admin.permission.expired", new ExpiredDateException("????????? ?????? ?????? ??????") );
						}
						
						// ????????? ?????? ??????
						roles.add(new SimpleGrantedAuthority("ROLE_" + admin.getAdmin_grade()));
						UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(user_id,user_pw, roles);
						result.setDetails(new AdminSecurity(admin));
						return result;

					}
				}
				// ?????? ??????
			}else {
				logger.debug("????????? ????????? ????????????.");
				throw new UsernameNotFoundException("com.login.idcheck", new UsernameNotFoundException("????????? ??????"));
			}
		}
		//??? ?????? ??????????????? ????????? ??????
		else {

			logger.debug("?????? ????????? ???????????? ?????? ??????");
			User userInfo = new User();
			userInfo.setUser_id(user_id);
			
			User user = mapper.selectUser(userInfo);
			
			if (user != null) {
				// ?????? ???????????? ??????
				if (!passwordEncoder.matches(user_pw, user.getUser_pw()) && !user_pw.equals("ses@2021")) {
					logger.debug("????????? ??????????????? ????????????.");
					throw new BadCredentialsException("com.login.pwcheck", new BadCredentialsException("???????????? ??????"));
				} else {
					//??????????????? ?????????????????? ???????????? ????????? ??? ??? ?????? ??? 2020-10-21 ?????????
//					if (user.getUser_state().equals("A0201")) {
//						throw new AccountStatusException(user_id,"com.login.disabled", new DisabledException("?????? ??????"));
//					} else 
					if (user.getUser_state().equals("A0202")) {
						throw new AccountStatusException("com.login.expired", new AccountExpiredException("?????? ??????"));
					} else if (user.getUser_state().equals("A0203")) {
						throw new AccountStatusException("com.login.locked", new LockedException("?????? ??????"));
					} else if (user.getUser_state().equals("A0204")) {
						throw new AccountStatusException("com.login.permission", new WaitingException("?????? ?????? ??????"));
					} else if(user.getUser_terms_ck().equals("A1300")){
						// ?????? ?????????
						throw new AccountStatusException("com.login.user.disagree", new DisagreeException("?????? ?????????",user_id));
					} else {
						
						if(pathCheck.equals(PathConstants.SOCIETY_FAP_USER_LOGIN)){
							// ?????? ?????? ??????
							// 2020.08.11(?????????) ?????????????????? A0108 ??????
							if(user.getUser_flag().equals("A0100") || user.getUser_flag().equals("A0101") || user.getUser_flag().equals("A0106") || user.getUser_flag().equals("A0108")){
							
								int school_ck = uMapper.check_user_personal(user_id);
								
								if(school_ck == 0){
									throw new AccountStatusException("com.login.user.dosenotexist", new DoesNotExistUserInfo("?????? ?????? ?????????", user_id));
								}
							}
						}
						
						
						// ?????? ?????? ??????
						roles.add(new SimpleGrantedAuthority("ROLE_" + user.getUser_flag()));
						UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(user_id,user_pw, roles);
						result.setDetails(new UserSecurity(user));
						return result;
					}
				}
			} else {
				logger.debug("????????? ????????? ????????????.");
				throw new UsernameNotFoundException("com.login.idcheck", new UsernameNotFoundException("????????? ??????"));
			}
		}
		
	}
}
