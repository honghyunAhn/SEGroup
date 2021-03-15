/**
 * 
 */
package global.segroup.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import global.segroup.util.PathConstants;

/**
 * @Author : KimJihoon
 * @Date : 2018. 6. 28.
 * @Class 설명 : 요청을 받아 사용자의 Locale을 변환하는 Controller
 * 
 */
@Controller
public class LocaleController {
    
    @RequestMapping(value = "/changeLocale", method = RequestMethod.GET)
    public String changeLocale(HttpServletRequest request, HttpServletResponse response, 
    		@RequestParam("lang") String locale) {
        HttpSession session = request.getSession();
        Locale lo = null;
        
        //step. Parameter에 따라서 Locale 생성, 기본은 KOREAN.
        if (locale.matches("en")) {
            lo = Locale.ENGLISH;
        } else if(locale.matches("ja")) {
            lo = Locale.JAPANESE;
        }else {
            lo = Locale.KOREAN;
        }

        // step. Locale을 새로 설정한다.
        session.setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, lo);
        
        // step. 
        return PathConstants.SES+PathConstants.SES_MAIN;
    }
}
