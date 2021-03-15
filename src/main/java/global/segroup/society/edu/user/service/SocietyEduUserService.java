/**
 * 
 */
package global.segroup.society.edu.user.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.mail.MessagingException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import global.segroup.dao.SEGroupCommonDAO;
import global.segroup.domain.CertificationCode;
import global.segroup.domain.User;
import global.segroup.domain.UserVerification;
import global.segroup.society.edu.user.dao.SocietyEduUserDAO;
import global.segroup.society.edu.user.domain.RefundInfo;
import global.segroup.util.MailService;

/**
 * @Author : 한진규
 * @Date : 2017. 8. 29.
 * @Class 설명 : 공통 유저 로그인 서비스 
 */
@Service
public class SocietyEduUserService {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyEduUserService.class);

	/**
	 * 공통 유저 관련 DAO
	 */
	@Autowired
	private SocietyEduUserDAO seuDAO;
	
	/**
	 * 공통 기능 관련 DAO
	 */
	@Autowired
	private SEGroupCommonDAO sgcDAO;
	
	/**
	 * 암호화 관련 클래스
	 */
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	/**
	 * 메일을 보내는 서비스
	 */
	@Autowired
	private MailService mail;

	/**
	 * @Method Name : user_insert
	 * @Date : 2017. 8. 29.
	 * @User : 한진규
	 * @Param : 
	 * @Return : 유저가 등록되었는지에 대해 참/거짓값을 반환
	 * @Method 설명 : 공통 유저 정보를 등록하는 서비스 함수
	 */
	public void user_insert(User user) {
		logger.debug("유저 정보 등록 서비스 시작");

		// 유저 비밀번호를 암호화하여 저장
		String encodedPw = passwordEncoder.encode(user.getUser_pw());
		user.setUser_pw(encodedPw);
		
		// 최종 데이터 확인
		logger.debug(user.toString());
		
		// DB로 저장
		int count = seuDAO.user_insert(user);
		if (count == 0) {
			// TODO: 유저 유효성 검사시에 터지면 404
			new Exception();
		}
		
		logger.debug("유저 정보 등록 서비스 종료");
	}
	
	/**
	 * @Method Name : userveri_insert
	 * @Date : 2018. 9. 12.
	 * @User : 전상수
	 * @Param : 
	 * @Return : 유저가 등록되었는지에 대해 참/거짓값을 반환
	 * @Method 설명 : 공통 유저 정보를 등록하는 서비스 함수
	 */
	public void userveri_insert(UserVerification userVeri) {
		logger.debug("유저 인증정보 등록 서비스 시작");
		
		// DB로 저장
		int count = seuDAO.userveri_insert(userVeri);
		if (count == 0) {
			// TODO: 유저 유효성 검사시에 터지면 404
			new Exception();
		}
		
		logger.debug("유저 인증정보 정보 등록 서비스 종료");
	}
	
	/**
	 * @Method Name : userveri_phone_select
	 * @Date : 2018. 9. 12.
	 * @User : 전상수
	 * @Param : 
	 * @Return : 유저가 등록되었는지에 대해 참/거짓값을 반환
	 * @Method 설명 : 공통 유저 정보를 등록하는 서비스 함수
	 */
	public UserVerification userveri_phone_select(UserVerification userVeri) {
		logger.debug("유저 인증정보 조회 서비스 시작");
		UserVerification result=null;
		// DB로 저장
		result = seuDAO.userveri_phone_select(userVeri);
		
		logger.debug("유저 인증정보 정보 조회 서비스 종료");
		
		return result;
	}
	
	/**
	 * @Method Name : user_update
	 * @Date : 2017. . .
	 * @User : 
	 * @Param : 
	 * @Return : 
	 * @Method 설명 :
	 */
	public void user_update(User user){
		logger.debug("유저 정보 수정 서비스 시작");
		
		//유저 비밀번호를 암호화하여 저장
		String encodedPw = passwordEncoder.encode(user.getUser_pw());
		user.setUser_pw(encodedPw);
		
		seuDAO.user_update(user);
		
		logger.debug("유저 정보 수정 서비스 종료");
	}
	
	/**
	 * @Method Name : user_delete
	 * @Date : 2018. 9. 19
	 * @User : 이종호
	 * @Param : 탈퇴할 회원 객체
	 * @Return : -
	 * @Method 설명 : 회원 탈퇴 서비스
	 */
	public void user_delete(User user){
		logger.debug("유저 탈퇴 서비스 시작");
		
		seuDAO.user_delete(user);
		
		logger.debug("유저 탈퇴 서비스 종료");
	}
	
	/**
	 * @Method Name : user_apply_history
	 * @Date : 2017. . .
	 * @User : 
	 * @Param : 
	 * @Return : 
	 * @Method 설명 :
	 */
	public ArrayList<HashMap<String, Object>> user_apply_history(String id){
		logger.debug("유저 지원정보 서비스 시작");
		ArrayList<HashMap<String, Object>> applyList=null;
		applyList=seuDAO.user_apply_history(id);
		
		logger.debug("유저 지원정보 서비스 종료");
	    return applyList;
	}
	
	/**
	 * @Method Name : user_apply_history
	 * @Date : 2017. . .
	 * @User : 
	 * @Param : 
	 * @Return : 
	 * @Method 설명 :
	 */
	public void user_pay_info(HashMap<String, String> params){
		logger.debug("유저 결제정보 insert 시작");
		
		seuDAO.user_pay_info(params);
		
		logger.debug("유저 결제정보 insert 종료");
	}
	
	
	/**
	 * @Method Name : user_payment_form
	 * @Date : 2017. 12. 6.
	 * @User : 전상수
	 * @Param : 기수 시퀀스
	 * @Return : 기수 결제정보 
	 * @Method 설명 : 기수별로 결제할 것이 있는지 가져오는 메소드
	 */
	public ArrayList<HashMap<String, Object>> user_payment(String seq,String id){
		logger.debug("유저 지원정보 서비스 시작");
		HashMap<String, String> params=new HashMap<String, String>();
		params.put("seq", seq);
		params.put("id", id);
		
		ArrayList<HashMap<String, Object>> payList=null;
		payList=seuDAO.user_payment(params);
		
		logger.debug("유저 지원정보 서비스 종료");
	    return payList;
	}
	
	/**
	 * @Method Name : user_pay_status
	 * @Date : 2017. 12. 6.
	 * @User : 전상수
	 * @Param : 유저아이디
	 * @Return :  결제정보 
	 * @Method 설명 : 유저별로 결제정보  가져오는 메소드
	 */
	public ArrayList<HashMap<String, Object>> user_pay_status(String id){
		logger.debug("유저 지원정보 서비스 시작");
		ArrayList<HashMap<String, Object>> payList = null; //결제내역리스트
		payList=seuDAO.user_pay_status(id);
		
		logger.debug("유저 지원정보 서비스 종료");
	    return payList;
	}
	
	
	/**
	 * @Method Name : user_refund_req
	 * @Date : 2017. 12. 18.
	 * @User : 전상수
	 * @Param : 환불정보객체
	 * @Return :  
	 * @Method 설명 : 환불정보를 DAO에 넘기는 메소드
	 */
	public void user_refund_req(RefundInfo refundInfo){
		logger.debug("유저 환불요청 서비스 시작");
		seuDAO.user_refund_req(refundInfo);
		logger.debug("유저 환불요청 서비스 종료");
	}
	
	/**
	 * @Method Name : user_refund_req
	 * @Date : 2017. 12. 18.
	 * @User : 전상수
	 * @Param : 환불정보객체
	 * @Return :  
	 * @Method 설명 : 환불정보를 DAO에 넘기는 메소드
	 */
	public RefundInfo user_refund_status(String seq){
		logger.debug("유저 환불내역 서비스 시작");
		RefundInfo info= new RefundInfo();
		info=seuDAO.user_refund_status(seq);
		logger.debug("유저 환불내역 서비스 종료");
		return info;
	}
	
	/**
	 * @Method Name : user_consulting_list
	 * @Date : 2018. 07. 31.
	 * @User : 김도훈
	 * @Param : 온라인상담 정보객체
	 * @Return :  
	 * @Method 설명 : 온라인상담 정보를 DAO에 넘기는 메소드
	 */
	public ArrayList<HashMap<String, Object>> user_consulting_list(String id){
		logger.debug("유저 지원정보 서비스 시작");
		ArrayList<HashMap<String, Object>> consultingList = null; //결제내역리스트
		consultingList = seuDAO.user_consulting_list(id);
		
		logger.debug("유저 지원정보 서비스 종료");
	    return consultingList;
	}
	
	/**
	 * @Method Name : user_id_duplicated
	 * @Date : 2017. 8. 29.
	 * @User : 한진규
	 * @Param : 검색 아이디
	 * @Return : 중복되면 true / 중복되지 않으면 false 
	 * @Method 설명 : 중복되는지 확인한다
	 */
	public boolean user_duplicated(User userInfo) {
		logger.debug("유저 정보 중복 검사 서비스 시작");
		User user = sgcDAO.selectUser(userInfo);
		
		boolean isDuplicated = (user != null);
		
		logger.debug("유저 정보 중복 검사 서비스 종료");
		return isDuplicated;
	}
	
	/**
	 * @Method Name : user_forgot_id
	 * @Date : 2017. 10. 12.
	 * @User : 한진규
	 * @Param : 
	 * @Return : 정보와 일치하는 유저 아이디를 검색한다
	 * @Method 설명 : 아이디를 찾아서 정보를 바꾸어 보낸다
	 */
	public String user_forgot_id(User userInfo) {
		logger.debug("유저 정보 검색 서비스 시작");
		
		User found = sgcDAO.selectUser(userInfo);
		String foundId = null;
		String blindId = "";
		String cutedId = "";
		
		if (found != null) {
			foundId = found.getUser_id();
			
			final int INDEX = foundId.length();
			
			for (int i = INDEX; i > 4; i--) {
				blindId += "*";
			}
			
			cutedId = foundId.substring(0,4);
			foundId = cutedId + blindId;
			
		}
		
		logger.debug("유저 정보 검색 서비스 종료");
		
		return foundId;
	}
	
	/**
	 * @Method Name : user_forgot_password
	 * @Date : 2017. 10. 23.
	 * @User : 한진규
	 * @Param : 유저아이디, 현재 비밀번호, 바꿀 비밀번호
	 * @Return : 
	 * @Method 설명 :
	 */
	public boolean user_forgot_password(String user_id, String user_pw) {
		logger.debug("유저 정보 검색 서비스 시작");
		
		User userInfo = new User();
		userInfo.setUser_id(user_id);
		
		User found = sgcDAO.selectUser(userInfo);
		if (found == null) {
			return false;
		}
		
		String encodedPw = passwordEncoder.encode(user_pw);
		found.setUser_pw(encodedPw);
		seuDAO.user_update(found);
		
		logger.debug("유저 정보 검색 서비스 종료");
		return true;
	}
	
	
	/**
	 * @Method Name : user_certification_code
	 * @Date : 2017. 10. 13.
	 * @User : 한진규
	 * @Param : 
	 * @Return : 요청되었으면 true, 안 되었으면 false
	 * @Method 설명 : 일치하는 유저가 있다면 코드를 요청한다
	 */
	public int user_request_certification_code(User userInfo) {
		try {
			// 유저 정보 검색
			User found = sgcDAO.selectUser(userInfo);
			if (found == null) {
				return 1;
			}
			
			// 유저가 사용하고 있는 코드가 있는지 검색한다
			CertificationCode code = new CertificationCode();
			code.setUser_id(found.getUser_id());
			CertificationCode foundCode = sgcDAO.selectCertificationCode(code);
	
			// 만약 유저에 해당되는 코드가 존재한다면 없애버린다
			if (foundCode != null) {
				foundCode.setUser_id(null);
				sgcDAO.updateCertificationCode(foundCode);
			}
	
			// 랜덤으로 숫자를 골라온다
			CertificationCode sendCode = sgcDAO.chooseCertificationCode();
			if (sendCode == null) {
				return 3;
			}
			
			// 코드를 세팅한다
			userInfo.setUser_id(code.getUser_id());
			code.setCertification_code(sendCode.getCertification_code());
			
			sgcDAO.updateCertificationCode(code);
			
			final String FROM = "sesoc2019@gamil.com";
//	        final String TO = "han.jinkyu@softengineer.school";
	        final String TO = userInfo.getUser_email();
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
	 * @Method Name : user_check_certification_code
	 * @Date : 2017. 10. 16.
	 * @User : 한진규
	 * @Param : 유저 정보
	 * @Return : 
	 * @Method 설명 : 인증 코드가 맞는지 체크한다
	 */
	public boolean user_check_certification_code(CertificationCode code) {
		if (code.getUser_id() == null) {
			return false;
		}
		
		// 유저가 사용하고 있는 코드가 있는지 검색한다
		CertificationCode foundCode = sgcDAO.selectCertificationCode(code);
		if (foundCode == null) {
			return false;
		}
		
		// 찾았다면 갱신하여 삭제한다
		code.setUser_id(null);
		sgcDAO.updateCertificationCode(foundCode);
	
		return true;
	}
	
	/**
	 * @Method Name : user_select
	 * @Date : 2017. 9. 1.
	 * @User : 이종호
	 * @Param : 로그인 한 유저 아이디
	 * @Return : 로그인 한 유저 정보
	 * @Method 설명 : 특정 유저 정보를 검색하는 서비스 함수 
	 */
	public User user_select(User userInfo){
		logger.debug("유저 정보 검색 서비스 시작");
		
		User user = sgcDAO.selectUser(userInfo);
		
		logger.debug("유저 정보 검색 서비스 종료");
		
		return user;
	}

	/**
	 * @Method Name : user_refund_cancel
	 * @Date : 2018. 2. 12.
	 * @User : SCITMaster
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int user_refund_cancel(int pay_refund_seq) {
		logger.debug("user_refund_cancel 서비스 시작");
		int result = seuDAO.user_refund_cancel(pay_refund_seq);
		logger.debug("user_refund_cancel 서비스 종료");
		return result;
	}

	/**
	 * @Method Name : user_pay_cancel
	 * @Date : 2018. 2. 14.
	 * @User : SCITMaster
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int user_pay_cancel(int pay_user_seq) {
		logger.debug("user_pay_cancel 서비스 시작");
		int result = seuDAO.user_pay_cancel(pay_user_seq);
		logger.debug("user_pay_cancel 서비스 종료");
		return result;
	}

	/**
	 * @Method Name : checkPassword
	 * @Date : 2018. 7. 11.
	 * @User : 김지훈
	 * @Param : 유저 아이디와 비밀번호
	 * @Return : 비밀번호가 맞다면 true, 틀리다면 false
	 * @Method 설명 : 아이디를 통해 DB의 유저 비밀번호를 취득한 뒤, 입력받은 비밀번호와 DB의 비밀번호의 일치성을 확인한다. 
	 */
	public boolean checkPassword(String user_id, String user_pw) {
		User inputUser = new User();
		// 아이디를 유저객체에 주입
		inputUser.setUser_id(user_id);
		// 아이디에 해당하는 DB의 유저정보를 취득 
		User dbUserInfo = user_select(inputUser);
		// 비교 결과 리턴
		return passwordEncoder.matches(user_pw, dbUserInfo.getUser_pw());
	}
	
	/**
	 * @Method Name : select_pay_user_id
	 * @Date : 2018. 8. 20.
	 * @User : 이종호
	 * @Param : 결제 ID
	 * @Return : 회원 ID
	 * @Method 설명 : 결제 ID로 해당 회원 ID를 검색 (회원 권한 변경에 사용됨)
	 */	
	public String select_pay_user_id(String pay_moid) {
		logger.debug("결제 ID로 해당 회원 ID를 검색하는 서비스 시작");
		
		String result = seuDAO.select_pay_user_id(pay_moid);
		
		logger.debug("결제 ID로 해당 회원 ID를 검색하는 서비스 종료");
		
		return result;
	}
	
	public int select_pay_crc_seq(String course, String cardinal) {
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("course_id", course);
		map.put("cardinal_id", cardinal);
		
		return seuDAO.select_pay_crc_seq(map);
	}
}
