/**
 * 
 */
package global.segroup.util;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;

/**
 * @Author : 이종호
 * @Date : 2019. 4. 8.
 * @Class 설명 : 설정된 Locale을 확인하는 클래스
 * 
 */
public class LocaleUtil {
	
	private static final Logger logger = LoggerFactory.getLogger(LocaleUtil.class);

    //기본 로케일을 리턴한다. 기본은 한글이다. 
    public static Locale getDefaultLocale() {
        return Locale.getDefault();
    }

    //HttpServletRequest 를 받아서 저장되어 있를 locale 값을 리턴한다. 
    //없는 경우는 기본 로케일을 리턴한다. 
    public static Locale getLocale(HttpServletRequest request) {
        Locale locale = null;
        HttpSession session = request.getSession(); 
        locale = (Locale)session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);

        if (locale == null ) {
            locale = getDefaultLocale();
        }
        return locale;
    }
    
    //session에 저장된 언어정보를 읽어와서 있을경우 그대로 사용 없을경우 지역정보로 사용
    //일본이 아닌경우는 한국어로 변경
    public static void setLocale(HttpServletRequest request, HttpServletResponse response) {
    	Locale locale = null;
        HttpSession session = request.getSession(); 
        locale = (Locale)session.getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);

        logger.info("session locale 정보 : {}" , locale);
        
        if (locale == null ) {
            String default_locale = request.getLocale().toString();
            
            logger.info("default locale 정보 : {}" , default_locale);
            
            if(default_locale.contains("ja")) {
        		
        		LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
        		localeResolver.setLocale(request, response, Locale.JAPANESE);
            	
            }else {
            	
            	LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
        		localeResolver.setLocale(request, response, Locale.KOREAN);
            	
            }
            
        }
    }
    
    //언어팩 변경시 호출
    public static void setLocale(HttpServletRequest request, HttpServletResponse response, String lo) {
    	
    	Locale locale = StringUtils.parseLocaleString(lo);
		
		LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
		localeResolver.setLocale(request, response, locale);
    	
    }
}