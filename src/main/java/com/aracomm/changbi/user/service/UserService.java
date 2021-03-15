package com.aracomm.changbi.user.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.aracomm.changbi.member.dao.PointDao;
import com.aracomm.changbi.member.vo.MemberForm;
import com.aracomm.changbi.user.dao.UserDao;
import com.aracomm.changbi.user.web.UserController;

import global.segroup.domain.CertificationCode;
import global.segroup.domain.User;
import global.segroup.society.smtp.apply.domain.DateAttendanceVO;
import global.segroup.society.smtp.apply.domain.InfoAttendance;
import global.segroup.util.FileService;
import global.segroup.util.MailService;

@Service
public class UserService {
	@Autowired
	private UserDao dao;
	
	@Autowired
	private PointDao pDao;
	
	@Autowired
	MessageSource messageSource;
	
	@Value("#{props['smtp.user.attendance_certificate']}")
	private String stuAttendanceCertificate;
	
	// 메일을 보내는 서비스
	@Autowired
	private MailService mail;
	
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	public String selectUserNeisNum(String user_id) {
		return dao.selectUserNeisNum(user_id);
	}
	
	/**LMS 회원가입 **/
	public int insertUser(MemberForm memberForm) {
		
		int result = 0;
		// 정책에 따른 포인트 등록
		Map<String, Object> pointPolicy = pDao.selectPolicyPoint();
		Map<String, Object> point;
		
		result = dao.insertUser(memberForm);
		if (pointPolicy != null) {
			// 회원가입 포인트 등록
			String useYn = (String)pointPolicy.get("SAVE_JOIN_USE");
			if("Y".equals(useYn)) {
				point = new HashMap<String, Object>();
				point.put("user_id", memberForm.getId());
				point.put("learn_app_id", null);
				//point.put("name", memberForm.getName());
				point.put("give", pointPolicy.get("SAVE_JOIN_POINT"));
				point.put("withdraw", 0);
				point.put("note", messageSource.getMessage("point.joinSave", null, "point.joinSave", Locale.getDefault()));
				pDao.insertPoint(point);
			}
		}
		return result;
	}
	public int insertUserInfo(MemberForm memberForm) {
		return dao.insertUserInfo(memberForm);
	}
	/**LMS 클라이언트 IP 조회**/
	public String getClintIp(HttpServletRequest request) {
		
		request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
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
            ip = request.getHeader("X-Real-IP"); 
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("X-RealIP"); 
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getHeader("REMOTE_ADDR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
            ip = request.getRemoteAddr(); 
        }
		
		return ip;
	}
	
//	/**LMS 휴면계정 등록 **/
	public int insertRestUser(User user) {
		return dao.insertRestUser(user);
	}
	/**LMS 휴면계정 처리 **/
	public int updateRestUserInfo(User user) {
		return dao.updateRestUserInfo(user);
	}
	/**LMS 휴면해제 **/
	public int updateUserInfo(User user) {
		return dao.updateUserInfo(user);
	}
	/**LMS 휴면회원 테이블 데이터 삭제**/
	public int deleteRestUser(String user_id) {
		return dao.deleteRestUser(user_id);
	}
	/**
	 * LMS 비밀번호 수정
	 */
	public int updatePassword(String id, String passwd) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", id);
		param.put("pw", passwd);
		return dao.updatePassword(param);
	}
	
	/**
	 * LMS 회원정보 조회
	 */
	public HashMap<String, Object> selectMemberInfo(String user_id) {
		return dao.selectMemberInfo(user_id);
	}
	/**LMS 휴면회원정보 조회 **/
	public User selectRestMemberInfo(String user_id){
		return dao.selectRestMemberInfo(user_id);
	}
	/**LMS 전체 회원 목록 **/
	public List<User> selectUserListAll() {
		return dao.selectUserListAll();
	}
	/**
	 * LMS 휴면계정 대상여부 조회
	 */
	public User selectRestUser(String user_id) {
		return dao.selectRestUser(user_id);
	}
	/*LMS 접속 이력 저장*/
	public int insertUserAccInfo(MemberForm memberForm) {
		return dao.insertUserAccInfo(memberForm);
	}
	
	/**
	 * LMS 회원정보 수정(기본)
	 */
	public int updateMemberInfo(MemberForm memberForm) {
		return dao.updateMemberInfo(memberForm);
	}
	
	/**
	 * LMS 회원정보 수정(선택)
	 */
	
	public int selectIfAdditionalInfoExist(String id) {
		return dao.selectIfAdditionalInfoExist(id);
	}

	public int updateAdditionalMemberInfo(MemberForm memberForm) {		 
		return dao.updateAdditionalMemberInfo(memberForm);
	}

	public int insertAdditionalMemberInfo(MemberForm memberForm) {		 
		return dao.insertAdditionalMemberInfo(memberForm);
	}
	
	/**
	 * LMS 아이디 찾기
	 */
	public HashMap<String, String> selectMemberForFindId (HashMap<String, String> findMap) {
		return dao.selectMemberForFindId(findMap);
	}
	
	/**
	 * LMS 비밀번호 찾기
	 */
	
	public int user_request_certification_code(HashMap<String, String> param) {
		try {
			// 유저 정보 검색
			HashMap<String,String> found = dao.selectMemberForFindPw(param);
			if (found == null) {
				return 1;
			}
			
			// 유저가 사용하고 있는 코드가 있는지 검색한다
			CertificationCode code = new CertificationCode();
			code.setUser_id(found.get("USER_ID"));
			CertificationCode foundCode = dao.selectCertificationCode(code);
	
			// 만약 유저에 해당되는 코드가 존재한다면 없애버린다
			if (foundCode != null) {
				foundCode.setUser_id(null);
				dao.updateCertificationCode(foundCode);
			}
	
			// 랜덤으로 숫자를 골라온다
			CertificationCode sendCode = dao.chooseCertificationCode();
			if (sendCode == null) {
				return 3;
			}
			
			// 코드를 세팅한다
			param.put("user_id", code.getUser_id());
			code.setCertification_code(sendCode.getCertification_code());
			
			dao.updateCertificationCode(code);
			
			final String FROM = "sesoc2019@gmail.com";		   
//	        final String TO = "han.jinkyu@softengineer.school";
	        final String TO = param.get("user_email");
	        final String SUBJECT = "인증번호";
	        final String TEXT = String.format("인증번호: %04d", code.getCertification_code());
//			System.out.println("인증번호:" + TEXT);
			mail.sendMail(FROM, TO, SUBJECT, TEXT);
			
		} catch (MessagingException e) {
			e.printStackTrace();
			return 2;
		} catch (NullPointerException ne) {
			ne.printStackTrace();
			return 2;
		}
		return 0;
	}
	/**
	 * 인증 코드가 맞는지 체크
	 */
	public boolean user_check_certification_code(CertificationCode code) {
		if (code.getUser_id() == null) {
			return false;
		}
		
		// 유저가 사용하고 있는 코드가 있는지 검색한다
		CertificationCode foundCode = dao.selectCertificationCode(code);
		if (foundCode == null) {
			return false;
		}
		
		// 찾았다면 갱신하여 삭제한다
		code.setUser_id(null);
		dao.updateCertificationCode(foundCode);
	
		return true;
	}
	
	public HashMap<String, String> selectMemberForFindPw(HashMap<String, String> param) {
		return dao.selectMemberForFindPw(param);
	}
	
	/**
	 * SMTP, LMS, FAP(지원자 회원) 회원탈퇴
	 */
	public int deleteMemberInfo(HashMap<String, Object> param) {
		String id = (String)param.get("USER_ID");
//		HashMap<String, Object> user = dao.selectMemberInfo(id); // 탈퇴 시, 추가 정보 필요 시 사용
		
		// 중복되기 어려운 임의의값 생성
		long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmssSSS"); 
		String deleteUserId = id + dayTime.format(new Date(time));
		
		// DB에 ID길이가 30이므로 넘을 시 잘라줌
		if(deleteUserId.length() >= 30) {
			deleteUserId = deleteUserId.substring(0, 30);
		}
		
		Map<String, String> map = new HashMap<String,String>();
		map.put("id", id);
		map.put("deleteUserId",deleteUserId);
		map.put("user_nm", (String)param.get("USER_NM"));
		// 탈퇴 시, 추가 정보 필요 시 사용
/*		map.put("user_phone", String.valueOf(user.get("USER_PHONE")));
		map.put("user_email", String.valueOf(user.get("USER_EMAIL")));
		map.put("user_birth", String.valueOf(user.get("USER_BIRTH")));
		map.put("user_sex", String.valueOf(user.get("USER_SEX")));
		map.put("user_flag", String.valueOf(user.get("USER_FLAG")));*/ 
		//1. 기존 아이디를 새로운 아이디로 변경 : com_user_tb를 업데이트하면, 외래키로 연결된 다른 테이블의 user_id도 바뀜(on update cascade)
		dao.changeIDInfo(map);
		dao.changeCertificationID(map); //com_certification_code_tb테이블의 user_id를 바꿔준다. 
		// com_certification_code_tb는 비밀번호 찾기 인증 정보 테이블인데, 인증과정상 user_id를 null로 세팅하는 게 있어서 외래키 설정이 불가능하여
		// on update cascade를 사용할 수 없음. 따라서 위와 같이 별도의 매서드를 통해 user_id를 업데이트한다.
		
		//2. 회원정보를 com_user_tb에서 삭제 : 탈퇴 후에 더이상 필요하지 않은 정보는 함께 삭제됨(on delete cascade)
		//							        탈퇴 후에도 보관이 필요한 정보는 삭제되지 않음(on delete no action)
		//**********************com_user_tb에 남길 것.***************************
//		int result = dao.deleteMemberInfo(deleteUserId); // 회원 테이블 삭제 시, 활용 
//		if(result == 1){
			//3. 탈퇴회원정보를 cb_member_out에 저장 : 탈퇴회원용 아이디, 이름
		int	result = dao.insertMemberOut(map);
//		}
		return result;
	}
	
	/**
	 * LMS 개인 결제현황/환불
	 */
	public ArrayList<HashMap<String, Object>> individualPayList(HashMap<String,String> param) {
		return dao.individualPayList(param);
	}
	/**LMS 개인 결제 정보 결과 수 **/
	public int individualPayListCnt(HashMap<String, String> param) {
		return dao.individualPayListCnt(param);
	}

	/**
	 * LMS 영수증 조회
	 */
	public HashMap<String, Object> selectReceiptNum(HashMap<String, Object> selectMap) {
		
		return dao.selectReceiptNum(selectMap);
	}
	
	/**
	 * LMS 영수증 입력
	 */
	public int insertReceipt(HashMap<String, Object> param) {
		return dao.insertReceipt(param);
	}
	/**
	 * LMS 일련번호 생성 
	 */
	public HashMap<String, Object> createReceiptNum() {
		//오늘 날짜 생성
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		String strToday = dateFormat.format(cal.getTime());
		//발행일
		String strToday2 = dateFormat2.format(cal.getTime());
		
		//원래 있던 시퀀스의 가장 최근 번호를 조회한다.
		Integer receiptSeq = dao.selectReceiptSeq();
			
			if(receiptSeq == null) {
				receiptSeq = 0;
			}		
			
				receiptSeq +=1;
		//일련번호	
		String newReceiptNum = strToday+"-"+receiptSeq;
		
		HashMap<String, Object> newMap = new HashMap<String, Object>();
		newMap.put("RECEIPT_DATE", strToday2);
		newMap.put("RECEIPT_NUM", newReceiptNum);
		
			return newMap;
	}
	
	public void submitCertificate(InfoAttendance attendance, DateAttendanceVO date) {
		 
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date time = new Date();
		String today = format.format(time);
		
		HashMap<String, Object> param = new HashMap<>();
		param.put("course_id", date.getCourseId());
		param.put("cardinal_id", date.getCardinalId());
		param.put("att_date", date.getAttDate());
		
		String userName = dao.putUserName(attendance.getRegUser());
		int seq = dao.putSeq(param);
		
		String fullPath = "/" + attendance.getRegUser() + "_" + String.valueOf(date.getCardinalId());
		
		String certificateSaved = FileService.saveFile(attendance.getRegFile(), fullPath);
		
		attendance.setAttDtSeq(seq);
		attendance.setRegUser(userName);
		attendance.setRegSavedFile(certificateSaved);
		attendance.setRegOriginFile(attendance.getRegFile().getOriginalFilename());
		attendance.setRegDate(today);
		
		dao.stuUpdate(attendance);
	}
	
	public ArrayList<HashMap<String, Object>> smtpIndividualPayList(HashMap<String,String> param) {
		return dao.smtpIndividualPayList(param);
	}
	
	public HashMap<String, Object> getUserPayInfo(String pay_crc_seq, String user_nm) {
		HashMap<String, Object> param = new HashMap<>();
		
		param.put("pay_crc_seq", pay_crc_seq);
		param.put("user_nm", user_nm);
		
		return dao.getUserPayInfo(param);
	}
	
	public HashMap<String, Object> getRefundInfo(String pay_user_seq) {
		return dao.getRefundInfo(pay_user_seq);
	}
	
	public HashMap<String, Object> getEduCurriculumPayInfo(int payCrcSeq) {
		return dao.getEduCurriculumPayInfo(payCrcSeq);
	}
	
	public HashMap<String, Object> getToeflRefundInfo(String pay_toefl_seq) {
		return dao.getToeflRefundInfo(pay_toefl_seq);
	}

	public int toeflRefundUpdate(HashMap<String,Object> param) {
		return dao.toeflRefundUpdate(param);
	}
	
	public int toeflRefundDelete(String pay_toefl_seq) {
		return dao.toeflRefundDelete(pay_toefl_seq);
	}
}
