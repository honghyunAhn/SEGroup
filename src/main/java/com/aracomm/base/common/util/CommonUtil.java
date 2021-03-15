package com.aracomm.base.common.util;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.lang3.StringUtils;

public class CommonUtil {
	private static final Logger logger = LoggerFactory.getLogger(CommonUtil.class);
	private final static char[] CHAR_TABLE = new char[] {	// 랜덤문자열 생성용 문자테이블
			'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};

	/**
	 * paging 계산
	 *
	 * @param
	 * @return paging start 값
	 * @exception
	 * @see
	 */
	public static String getStart(String start, String pageSize) {
		if(start == null || "".equals(start)){
			start = "0";
		}else{
			start = String.valueOf((Integer.parseInt(start)-1) * Integer.parseInt(pageSize)) ;
		}
		return start;
	}
	public static BigDecimal getTotalPage(int totalCnt, int visiblePages){
        BigDecimal decimal1 = new BigDecimal(totalCnt);
        BigDecimal decimal2 = new BigDecimal(visiblePages);
        BigDecimal tatalPage = decimal1.divide(decimal2, 0, BigDecimal.ROUND_UP);
        return tatalPage;
	}

	public static String getTimeStamp(Locale locale) {

		String rtnStr = null;

		String pattern = "yyyyMMddHHmmss";

		SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern, locale);
		Timestamp ts = new Timestamp(System.currentTimeMillis());

		rtnStr = sdfCurrent.format(ts.getTime());

		return rtnStr;
	}


	/*
	 * 날짜처리
	 */
	public static String getFormatDate(String format) {
		return getFormatDate(new Date(), format);
	}
	public static String getFormatDate(java.util.Date date, String format) {
		return (new java.text.SimpleDateFormat( format )).format( date );
	}
	public static String getFormatDate(String datestr, String from_format, String to_format) {
		String result = datestr;
		try {
			java.util.Date date;
			if (datestr == null || "".equals(datestr.trim())) {
				date = new java.util.Date();
			} else {
				java.text.SimpleDateFormat format = new java.text.SimpleDateFormat(from_format);
				date = format.parse(datestr);
			}

			java.text.SimpleDateFormat format1 = new java.text.SimpleDateFormat(to_format);

			result = format1.format(date);
		} catch (Exception ex) {
		}

		return result;
	}

	public static String getDate(java.util.Date date, String format) {
		if (date==null || format == null) return "";
		SimpleDateFormat sdf = new SimpleDateFormat(format, Locale.getDefault());
		return sdf.format(date);
	}
	public static String getCurrentDate(String format) {
		return getDate(new Date(), format);
	}
	// 금일자
	public static String getCurrentDate() {
		return getDate(new Date(), "yyyyMMdd");
	}

	// XSS 방지 처리.
	public static String unscript(String data) {
		if (data == null || data.trim().equals("")) {
			return "";
		}

		String ret = data;

		ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script")
				.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script")
				.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object")
				.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object")
				.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet")
				.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet")
				.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed")
				.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed")
				.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form")
				.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form")
				.replaceAll("<(I|i)(F|f)(R|r)(A|a)(M|m)(E|e)", "&lt;iframe")
				.replaceAll("</(I|i)(F|f)(R|r)(A|a)(M|m)(E|e)", "&lt;iframe");

		return ret;
	}

	// tag escape
	public static String escapeTag(String s) {
		if (s==null) return "";
		String r = s.replaceAll("<", "&lt;")
					.replaceAll(">", "&gt;");
		return r;
	}

	// new line -> html line break
	public static String Cr2Br(String str) {
		return StringUtils.replace(StringUtils.replace(str, "\n\r", "<br/>"),"\n","<br/>");
	}

	// 문자열 자르기
	public static String getLimitByte(String string, int len) {
		if (len == 0)
			return string;
		else
			return getLimitByte(string, len, '+', "..");
	}

	public static String getLimitByte(String str, int length ,char type, String tail) {
		String test = "가";
		int div = test.getBytes().length;

		String f_str = null;

		if (length == 0)
			return str;

		if (str == null || str.length() == 0)
			return "";

		byte[] bytes = str.getBytes();
		int len = bytes.length;

		if (length >= len)
			return str;

		int charbyte_count = 0;	// 한글을 2byte로 취급하여 계산한 byte count
		int hcheck_count = 0;	// 한글을 체크하기 위한 count
		int cut_index = 0; // 자를 위치
		for(int i=0; i<len; i++) {
			++cut_index;
			if (((int)bytes[i] & 0x80) == 0) {
				if (charbyte_count+1 > length) {
					cut_index = cut_index - 1;
					break;
				}
				++charbyte_count; // 아스키문자
			}
			else {
				++hcheck_count;
				if (hcheck_count==div) {
					if (charbyte_count+2 > length) {
						if ("-".equals(type)) {
							cut_index = cut_index - div;
						}
						break;
					}
					hcheck_count = 0;
					charbyte_count = charbyte_count+2;	// 한글은 2byte로 계산(화면상표시기준)
				}
			}
		}

		f_str = new String(bytes, 0, cut_index);

		return f_str+(bytes.length>cut_index?tail:"");
	}

	/**
	 * 접속 ip 반환(L4 client ip 적용)
	 *
	 * @param
	 * @return IP 값
	 * @exception
	 * @see
	 */
	public static String getRemoteAddr(HttpServletRequest request) {

		String ip = request.getHeader("X-Forwarded-For");

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		    ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		    ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		    ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		    ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		    ip = request.getRemoteAddr();
		}
	    return ip;
	}

	// 연락처를 세단락으로 분리
	public static String [] splitTel(String tel) {
		String [] s = new String [] {"", "", ""};
		if (tel == null) return s;

		String t = tel.replaceAll("[-\\.]", "");
		int len = t.length();
		if (len >= 9 && len <= 11) {
			s[2] = t.substring(len-4);
			if ("02".equals(t.substring(0, 2))) {
				s[0] = "02";
				s[1] = t.substring(2, len-4);
			} else {
				s[0] = t.substring(0,3);
				s[1] = t.substring(3, len-4);
			}
		} else {
			s[2] = t;
		}

		return s;

	}

	// 이메일주소를 두단락으로 분리
	public static String [] splitEmail(String email) {
		String [] s = new String [] {"", ""};
		if (email == null) return s;

		String [] t = email.split("@");

		if (t.length == 2) {
			s[0] = t[0];
			s[1] = t[1];
		}

		return s;
	}

	// 생년월일을 년월일 세단락으로 분리
	public static String [] splitBirthday(String birthday) {
		String [] s = new String [] {"", "", ""};
		if (birthday == null) return s;

		String t = birthday.replaceAll("-", "").replaceAll("\\s", "");

		if (t.length() == 8) {
			s[0] = t.substring(0,4);
			s[1] = t.substring(4,6);
			s[2] = t.substring(6);
		} else {
			s[0] = t;
		}

		return s;
	}

	// 생년월일 YYYY-MM-DD형태로
	public static String getFormattedBirthday(String birthday) {
		String formatted;
		String t = birthday.replaceAll("-", "").replaceAll("\\s", "");
		if (t.length() == 8) {
			formatted = t.substring(0,4) + "-" + t.substring(4,6) + "-" + t.substring(6);
		} else {
			formatted = t;
		}

		return formatted;
	}

	// 영대소문자숫자 조합의 랜덤문자열 생성
	public static String generateRandomString(int len) {

		int idx = 0;
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < len; i++) {
			idx = (int) (CHAR_TABLE.length * Math.random());
			sb.append(CHAR_TABLE[idx]);
		}
		return sb.toString();
	}

	// 전화번호 구분 문자열 제거
	public static String removeTelSeparator(String tel) {
		if (tel == null) return "";
		return tel.replaceAll("\\s", "").replaceAll("-", "").replaceAll("\\)", "");
	}

	// 새주문번호 얻기
	public static String getOrderNumber(long seq) {
		return getCurrentDate() + String.format("%05d", seq);
	}

	public static int getIntValue(Object val) {
		BigDecimal b = null;
		if (val == null) {
			b = new BigDecimal(0);
		} else if (val instanceof BigDecimal) {
			b =  (BigDecimal)val;
		} else if (val instanceof Integer) {
			b = new BigDecimal((Integer)val);
		} else if (val instanceof Long) {
			b = new BigDecimal((Long)val);
		} else if (val instanceof String) {
			b = new BigDecimal((String)val);
		} else {
			b = new BigDecimal((String)val);
		}

		return b.intValue();
	}

}
