/**
 * 
 */
package global.segroup.society.edu.user.dao;

import java.util.ArrayList;
import java.util.HashMap;

import global.segroup.domain.User;
import global.segroup.domain.UserVerification;
import global.segroup.society.edu.user.domain.RefundInfo;

/**
 * @Author : 한진규
 * @Date : 2017. 8. 29.
 * @Class 설명 :  Soft Engineer Society 모집홍보 공통유저 매퍼
 */
public interface SocietyEduUserMapper {
	
	/**
	 * @Method Name : insertUser
	 * @Date : 2017. 8. 29.
	 * @User : 한진규
	 * @Param : 
	 * @Return : 등록된 공통 유저 숫자
	 * @Method 설명 : 공통 유저를 등록하고 등록된 수를 얻어온다
	 */
	public int insertUser(User user);
	/**
	 * @Method Name : insertUserVeri
	 * @Date : 2018. 9. 12.
	 * @User : 전상수
	 * @Param : 휴대폰인증값
	 * @Return : 등록된 공통 유저 인증숫자
	 * @Method 설명 : 공통 유저를 등록하고 등록된 수를 얻어온다
	 */
	public int insertUserVeri(UserVerification userVeri);
	/**
	 * @Method Name : userveri_phone_select
	 * @Date : 2018. 9. 12.
	 * @User : 전상수
	 * @Param : 휴대폰인증값
	 * @Return : 휴대폰인증값과 관련된 회원
	 * @Method 설명 : 번
	 */
	public UserVerification userveri_phone_select(UserVerification userVeri);
	
	/**
	 * @Method Name : updateUser
	 * @Date : 2017. 9. 1.
	 * @User : 이종호
	 * @Param : 수정 할 회원 정보 객체
	 * @Return : -
	 * @Method 설명 : 회원 정보를 수정하는 매퍼 함수 
	 */
	public void updateUser(User user);
	
	/**
	 * @Method Name : user_apply_history
	 * @Date : 2017. 11. 23.
	 * @User : 전상수
	 * @Param :  회원 정보 
	 * @Return : -
	 * @Method 설명 : 회원 신청 정보 가져오는 매퍼 함수 
	 */
	public ArrayList<HashMap<String, Object>> user_apply_history(String id);
	
	
	/**
	 * @Method Name : user_pay_info
	 * @Date : 2017. 11. 23.
	 * @User : 전상수
	 * @Param :  회원 정보 
	 * @Return : -
	 * @Method 설명 : 회원 신청 정보 가져오는 매퍼 함수 
	 */
	public void user_pay_info(HashMap<String, String> params);
	
	
	
	/**
	 * @Method Name : user_apply_history
	 * @Date : 2017. 11. 23.
	 * @User : 전상수
	 * @Param :  결제 시퀀스 
	 * @Return : -
	 * @Method 설명 : 회원 결제가능 정보 가져오는 매퍼 함수 
	 */
	public ArrayList<HashMap<String, Object>> user_payment(HashMap<String, String> param);
	
	/**
	 * @Method Name : user_pay_status
	 * @Date : 2017. 11. 23.
	 * @User : 전상수
	 * @Param :  결제 시퀀스 
	 * @Return : -
	 * @Method 설명 : 회원 결제가능 정보 가져오는 매퍼 함수 
	 */
	public ArrayList<HashMap<String, Object>> user_pay_status(String id);
	
	/**
	 * @Method Name : user_check_refund
	 * @Date : 2017. 11. 23.
	 * @User : 전상수
	 * @Param :  결제 시퀀스 
	 * @Return : -
	 * @Method 설명 : 회원 결제가능 정보 가져오는 매퍼 함수 
	 */
	public int user_check_refund(String seq);
	
	/**
	 * @Method Name : user_check_refund
	 * @Date : 2017. 11. 23.
	 * @User : 전상수
	 * @Param :  화불정보 객체
	 * @Return : -
	 * @Method 설명 : 회원 환불정보를 수정하는 매퍼 함수 
	 */
	public void user_refund_udt(RefundInfo info);
	
	/**
	 * @Method Name : user_check_refund
	 * @Date : 2017. 11. 23.
	 * @User : 전상수
	 * @Param :  화불정보 객체 
	 * @Return : -
	 * @Method 설명 : 회원 환불정보를 등록하는 매퍼 함수 
	 */
	public void user_refund_req(RefundInfo info);
	
	/**
	 * @Method Name : user_refund_status
	 * @Date : 2017. 11. 23.
	 * @User : 전상수
	 * @Param :  환불정보 시퀀스 
	 * @Return : -
	 * @Method 설명 : 회원 환불내역을 가져오는 매퍼 함수 
	 */
	public RefundInfo user_refund_status(String seq);
	
	/**
	 * @Method Name : user_udate_payinfo
	 * @Date : 2017. 11. 23.
	 * @User : 전상수
	 * @Param :  무통장입금 결제완료 정보 
	 * @Return : -
	 * @Method 설명 : 무통장입금 결제완료 매퍼 함수 
	 */
	public void user_udate_payinfo(HashMap<String,String> hmParam);

	/**
	 * @Method Name : user_refund_cancel
	 * @Date : 2018. 2. 12.
	 * @User : SCITMaster
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int user_refund_cancel(int pay_refund_seq);

	/**
	 * @Method Name : user_pay_cancel
	 * @Date : 2018. 2. 14.
	 * @User : SCITMaster
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int user_pay_cancel(int pay_user_seq);

	/**
	 * @Method Name : deleteUser
	 * @Date : 2018. 9. 19.
	 * @User : 이종호
	 * @Param : 탈퇴할 회원 객체
	 * @Return : -
	 * @Method 설명 : 회원 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(30글자) 변경후 참조 테이블에 적용
	 */
	public int deleteUserDataRemove(HashMap<String, String> updateMap);

	/**
	 * @Method Name : user_consulting_list
	 * @Date : 2018. 7. 31.
	 * @User : 김도훈
	 * @Param : 온라인상담 내역 시퀀스
	 * @Return : 
	 * @Method 설명 : 회원 온라인 상담 내역을 가져오는 매퍼 함수 
	 */
	public ArrayList<HashMap<String, Object>> user_consulting_list(String id);
	
	/**
	 * @Method Name : select_pay_user_id
	 * @Date : 2018. 8. 20.
	 * @User : 이종호
	 * @Param : 결제 ID
	 * @Return : 회원 ID
	 * @Method 설명 : 결제 ID로 해당 회원 ID를 검색 (회원 권한 변경에 사용됨)
	 */
	public String select_pay_user_id(String pay_moid);
	
	public int select_pay_crc_seq(HashMap<String, Object> map);
	
	public void user_toefl_udate_payinfo(HashMap<String,String> hmParam);
	
}
