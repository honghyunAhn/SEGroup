/**
 * 
 */
package global.segroup.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import com.inicis.std.util.HttpUtil;
import com.inicis.std.util.ParseUtil;
import com.inicis.std.util.SignatureUtil;

import global.segroup.domain.User;
import global.segroup.society.edu.user.controller.SocietyEduUserViewController;
import global.segroup.util.PathConstants;

/**
 * @Author : user
 * @Date : 2017. 12. 7.
 * @Class 설명 : 
 * 
 */
@Controller
public class PayController {
 
    public Model payInfo(Model model, HttpServletRequest request,User user, String price, String goodname,String pay_seq, String from, String to)
            throws Exception {
 
        /**********************************************************************************************
         * INIpay 모듈 세팅 시작
         **********************************************************************************************/
 
        /*
         * //*** 위변조 방지체크를 signature 생성 *** oid, price, timestamp 3개의 키와 값을
         * key=value 형식으로 하여 '&'로 연결한 하여 SHA-256 Hash로 생성 된값
         * 
         * ex) oid=INIpayTest_1432813606995&price=819000&timestamp=2012-02-01
         * 09:19:04.004
         * 
         * key기준 알파벳 정렬
         * 
         * timestamp는 반드시 signature생성에 사용한 timestamp 값을 timestamp input에 그대로
         * 사용하여야함
         */
 
        // ############################################
        // 1.전문 필드 값 설정(***가맹점 개발수정***)
        // ############################################
 
        // 여기에 설정된 값은 Form 필드에 동일한 값으로 설정
        String mid = "softenjin0"; // 가맹점 ID(가맹점 수정후 고정)
 
        // 인증
        String signKey = "amVtb3M2SGE2NC9EeHVWUHBxTmtCdz09"; // 가맹점에 제공된 웹
                                                                // 표준
                                                                // 사인키(가맹점
                                                                // 수정후 고정)
        String timestamp = SignatureUtil.getTimestamp(); // util에 의해서 자동생성
        
 
        String oid = mid + "_" + SignatureUtil.getTimestamp(); // 가맹점
                                                                // 주문번호(가맹점에서
                                                                // 직접 설정)
 
      //  String price = price; // 상품가격(특수기호 제외, 가맹점에서 직접 설정)
 
        String cardNoInterestQuota = "11-2:3:,34-5:12,14-6:12:24,12-12:36,06-9:12,01-3:4"; // 카드
                                                                                            // 무이자
                                                                                            // 여부
                                                                                            // 설정(가맹점에서
                                                                                            // 직접
                                                                                            // 설정)
        String cardQuotaBase = "2:3:4:5:6:11:12:24:36"; // 가맹점에서 사용할 할부 개월수
                                                        // 설정
 
        // ###############################################
        // 2. 가맹점 확인을 위한 signKey를 해시값으로 변경 (SHA-256방식 사용)
        // ###############################################
        String mKey = SignatureUtil.hash(signKey, "SHA-256");
 
        // ###############################################
        // 2.signature 생성
        // ###############################################
        Map<String, String> signParam = new HashMap<String, String>();
        signParam.put("oid", oid); // 필수
        signParam.put("price", price); // 필수
        signParam.put("timestamp", timestamp); // 필수
 
        // signature 데이터 생성 (모듈에서 자동으로 signParam을 알파벳 순으로 정렬후 NVP 방식으로 나열해
        // hash)
        String signature = SignatureUtil.makeSignature(signParam);
 
        /* 기타 */
        // String siteDomain = "http://127.0.0.1:8080/service"; // 가맹점
        // 도메인
        // 입력
        // 페이지 URL에서 고정된 부분을 적는다.
        // Ex) returnURL이
        // http://localhost:8080INIpayStdSample/INIStdPayReturn.jsp 라면
        // http://localhost:8080/INIpayStdSample 까지만 기입한다.
 
        String siteDomain = request.getRequestURL().toString();
 
        model.addAttribute("mid", mid);
        model.addAttribute("oid", oid);
        model.addAttribute("price", price);
        model.addAttribute("timestamp", timestamp);
        model.addAttribute("signature", signature);
        model.addAttribute("mKey", mKey);
        model.addAttribute("cardQuotaBase", cardQuotaBase);
        model.addAttribute("cardNoInterestQuota", cardNoInterestQuota);
        model.addAttribute("siteDomain", siteDomain);
        model.addAttribute("goodname", goodname);
        user.setUser_phone(makePhoneNumber(user.getUser_phone()));
        model.addAttribute("user",user);
        model.addAttribute("offerPeriod",from+"-"+to);
        model.addAttribute("seq",pay_seq);
        /**********************************************************************************************
         * INIpay 모듈 세팅 종료
         **********************************************************************************************/
 
        // 모델 호출
        return model;
 
    }
    
    public static String makePhoneNumber(String phoneNumber) {
 	   String regEx = "(\\d{3})(\\d{3,4})(\\d{4})";
 	   String regEx2 = "^01([0|1|6|7|8|9]?)-([0-9]{3,4})-([0-9]{4})$";
 	   if(Pattern.matches(regEx2, phoneNumber)) return phoneNumber;
 	   if(!Pattern.matches(regEx, phoneNumber)) return null;
 	   
 	   return phoneNumber.replaceAll(regEx, "$1-$2-$3");
 	   
    }


 
    /**
     * 결제 후 처리
     * 
     * @throws Exception
     */
    /*public String payAfter(Model model, HttpServletRequest request,
            HttpServletResponse response, Authentication auth) throws Exception {
 
        String retUrl = "";
 
        HttpSession session = request.getSession();
 
        *//**********************************************************************************************
         * INIpay 모듈 세팅 시작
         **********************************************************************************************//*
 
        // #############################
        // 인증결과 파라미터 일괄 수신
        // #############################
        request.setCharacterEncoding("UTF-8");
 
        Map<String, String> paramMap = new Hashtable<String, String>();
 
        Enumeration elems = request.getParameterNames();
 
        String temp = "";
 
        while (elems.hasMoreElements()) {
            temp = (String) elems.nextElement();
            paramMap.put(temp, request.getParameter(temp));
 
        }
 
        // #####################
        // 인증이 성공일 경우만
        // #####################
        if ("0000".equals(paramMap.get("resultCode"))) {
 
            // ############################################
            // 1.전문 필드 값 설정(***가맹점 개발수정***)
            // ############################################
 
            String mid = paramMap.get("mid"); // 가맹점 ID 수신 받은 데이터로 설정
 
            String signKey = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS"; // 가맹점에 제공된
            // 키(이니라이트키)
            // (가맹점
            // 수정후
            // 고정)
            // !!!절대!!
            // 전문
            // 데이터로
            // 설정금지
 
            String timestamp = SignatureUtil.getTimestamp(); // util에 의해서
            // 자동생성
 
            String charset = "UTF-8"; // 리턴형식[UTF-8,EUC-KR](가맹점 수정후 고정)
            String format = "NVP"; // 리턴형식[XML,JSON,NVP](가맹점 수정후 고정)
 
            // 추가적 noti가 필요한 경우(필수아님, 공백일 경우 미발송, 승인은 성공시, 실패시 모두 Noti발송됨)
            // 미사용
            // String notiUrl = "";
 
            String authToken = paramMap.get("authToken"); // 취소 요청 tid에 따라서
                                                            // 유동적(가맹점 수정후 고정)
 
            String authUrl = paramMap.get("authUrl"); // 승인요청 API url(수신 받은값으로
                                                        // 설정, 임의 세팅 금지)
 
            String netCancel = paramMap.get("netCancelUrl"); // 망취소 API url (수신
                                                                // 받은값으로 설정, 임의
                                                                // 세팅 금지)
 
            // #####################
            // 2.signature 생성
            // #####################
            Map<String, String> signParam = new HashMap<String, String>();
 
            signParam.put("authToken", authToken); // 필수
            signParam.put("timestamp", timestamp); // 필수
 
            // signature 데이터 생성 (모듈에서 자동으로 signParam을 알파벳 순으로 정렬후 NVP 방식으로
            // 나열해 hash)
            String signature = SignatureUtil.makeSignature(signParam);
 
            String price = ""; // 가맹점에서 최종 결제 가격 표기 (필수입력)
 
            // 1. 가맹점에서 승인시 주문번호가 변경될 경우 (선택입력) 하위 연결.
            // String oid = "";
 
            // #####################
            // 3.API 요청 전문 생성
            // #####################
            Map<String, String> authMap = new Hashtable<String, String>();
 
            authMap.put("mid", mid); // 필수
            authMap.put("authToken", authToken); // 필수
            authMap.put("signature", signature); // 필수
            authMap.put("timestamp", timestamp); // 필수
            authMap.put("charset", charset); // default=UTF-8
            authMap.put("format", format); // default=XML
            authMap.put("price", price); // 필수 (가격위변조체크기능)
            // 2. 가맹점에서 승인시 주문번호가 변경될 경우 (선택입력) 하위 연결.
            // authMap.put("oid", oid);
 
            // if(null != notiUrl && notiUrl.length() > 0){
            // authMap.put("notiUrl" ,notiUrl);
            // }
 
            HttpUtil httpUtil = new HttpUtil();
 
            // #####################
            // 4.API 통신 시작
            // #####################
 
            String authResultString = "";
 
            authResultString = httpUtil.processHTTP(authMap, authUrl);
 
            // ############################################################
            // 5.API 통신결과 처리(***가맹점 개발수정***)
            // ############################################################
 
            String test = authResultString.replace(",", "&").replace(":", "=")
                    .replace("\"", "").replace(" ", "").replace("\n", "")
                    .replace("}", "").replace("{", "");
 
            Map<String, String> resultMap = new HashMap<String, String>();
 
            resultMap = ParseUtil.parseStringToMap(test); // 문자열을 MAP형식으로 파싱
 
            if ("0000".equals(resultMap.get("resultCode"))) {
                *//*****************************************************************************
                 * 여기에 가맹점 내부 DB에 결제 결과를 반영하는 관련 프로그램 코드를 구현한다.
                 * 
                 * [중요!] 승인내용에 이상이 없음을 확인한 뒤 가맹점 DB에 해당건이 정상처리 되었음을 반영함 처리중 에러
                 * 발생시 망취소를 한다.
                 ******************************************************************************//*
 
                retUrl = "url.do";
 
            } else {
 
                // 결제오류
                model.addAttribute("errorMsg", resultMap.get("resultMsg"));
                retUrl = "url.do";
 
            }
        }
        
        SocietyEduUserViewController se=new SocietyEduUserViewController();
 
        return se.user_up(model,auth);
 
    }*/
 
}
