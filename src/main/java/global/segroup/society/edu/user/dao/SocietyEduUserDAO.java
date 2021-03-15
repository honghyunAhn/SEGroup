/**
 * 
 */
package global.segroup.society.edu.user.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.segroup.domain.User;
import global.segroup.domain.UserVerification;
import global.segroup.society.edu.user.domain.RefundInfo;

/**
 * @Author : 한진규
 * @Date : 2017. 8. 29.
 * @Class 설명 : Soft Engineer Society 공통유저 가입 DAO 
 * 
 */
@Repository
public class SocietyEduUserDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyEduUserDAO.class);
	
	/**
	 * SqlSession
	 */
	@Autowired
	private SqlSession sqlSession;
	
	/**
	 * @Method Name : user_insert
	 * @Date : 2017. 8. 29.
	 * @User : 한진규
	 * @Param : 
	 * @Return : 추가된 유저 숫자
	 * @Method 설명 : 공통유저를 등록하고 등록된 숫자를 반환한다
	 */
	public int user_insert(User user) {
		SocietyEduUserMapper mapper = sqlSession.getMapper(SocietyEduUserMapper.class);
		int count = mapper.insertUser(user);
		return count;
	}
	
	/**
	 * @Method Name : userveri_insert
	 * @Date : 2018. 9. 12.
	 * @User : 전상수
	 * @Param : 
	 * @Return : 추가된 유저 숫자
	 * @Method 설명 : 공통유저를 등록하고 등록된 숫자를 반환한다
	 */
	public int userveri_insert(UserVerification userVeri) {
		SocietyEduUserMapper mapper = sqlSession.getMapper(SocietyEduUserMapper.class);
		int count = mapper.insertUserVeri(userVeri);
		return count;
	}
	
	/**
	 * @Method Name : userveri_insert
	 * @Date : 2018. 9. 12.
	 * @User : 전상수
	 * @Param : 
	 * @Return : 추가된 유저 숫자
	 * @Method 설명 : 공통유저를 등록하고 등록된 숫자를 반환한다
	 */
	public UserVerification userveri_phone_select(UserVerification userVeri) {
		UserVerification result=null;
		SocietyEduUserMapper mapper = sqlSession.getMapper(SocietyEduUserMapper.class);
		result = mapper.userveri_phone_select(userVeri);
		return result;
	
	}
	/**
	 * @Method Name : updateUser
	 * @Date : 2017. 9. 1.
	 * @User : 이종호
	 * @Param : 수정할 회원 정보 객체
	 * @Return : -
	 * @Method 설명 : 회원 정보를 수정하는 DAO 함수
	 */
	public void user_update(User user){
		logger.debug("회원 정보 수정 DAO 시작");
		
		SocietyEduUserMapper mapper = sqlSession.getMapper(SocietyEduUserMapper.class);
		mapper.updateUser(user);
		
		logger.debug("회원 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : user_delete
	 * @Date : 2018. 9. 19.
	 * @User : 이종호
	 * @Param : 탈퇴할 회원 객체
	 * @Return : -
	 * @Method 설명 : 회원 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(30글자) 변경후 참조 테이블에 적용
	 */
	public void user_delete(User user){
		logger.debug("회원 정보 수정 DAO 시작");
		
		SocietyEduUserMapper mapper = sqlSession.getMapper(SocietyEduUserMapper.class);
		
		// 중복되기 어려운 임의의값 생성
		long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmssSSS"); 
		String deleteUserId = user.getUser_id() + dayTime.format(new Date(time));
		
		// DB에 ID길이가 30이므로 넘을 시 잘라줌
		if(deleteUserId.length() >= 30) {
			deleteUserId = deleteUserId.substring(0, 30);
		}
		
		//변경할 데이터 맵
		HashMap<String, String> updateMap = new HashMap<>();
		
		updateMap.put("user_id", user.getUser_id());
		updateMap.put("user_state", "A0202");
		updateMap.put("user_delete_id", deleteUserId);
			
		// 회원 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(30글자) 변경
		mapper.deleteUserDataRemove(updateMap);
		
		logger.debug("회원 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : user_apply_history
	 * @Date : 2017. 12. 6.
	 * @User : 전상수
	 * @Param :회원 정보 
	 * @Return : -
	 * @Method 설명 : 회원 신청정보를 수정하는 DAO 함수
	 */
	public ArrayList<HashMap<String, Object>> user_apply_history(String id){
		logger.debug("회원 정보 수정 DAO 시작");
		ArrayList<HashMap<String, Object>> applyList=null;
		SocietyEduUserMapper mapper = sqlSession.getMapper(SocietyEduUserMapper.class);
		applyList=mapper.user_apply_history(id);
		
		logger.debug("회원 정보 수정 DAO 종료");
		return applyList;
	}
	
	/**
	 * @Method Name : user_apply_history
	 * @Date : 2017. 12. 6.
	 * @User : 전상수
	 * @Param :회원 정보 
	 * @Return : -
	 * @Method 설명 : 회원 신청정보를 수정하는 DAO 함수
	 */
	public void user_pay_info(HashMap<String, String> params){
		logger.debug("회원 정보 수정 DAO 시작");
		SocietyEduUserMapper mapper = sqlSession.getMapper(SocietyEduUserMapper.class);
		mapper.user_pay_info(params);
		
		logger.debug("회원 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : user_payment
	 * @Date : 2017. 12. 6.
	 * @User : 전상수
	 * @Param :회원 정보 
	 * @Return : -
	 * @Method 설명 : 회원 결제가능정보를 가져오는 DAO 함수
	 */
	public ArrayList<HashMap<String, Object>> user_payment(HashMap<String, String> param){
		logger.debug("회원 결제가능정보를 가져오는 DAO 시작");
		ArrayList<HashMap<String, Object>> applyList=null;
		SocietyEduUserMapper mapper = sqlSession.getMapper(SocietyEduUserMapper.class);
		applyList=mapper.user_payment(param);
		
		logger.debug("회원 결제가능정보를 가져오는 DAO 종료");
		return applyList;
	}
	
	
	/**
	 * @Method Name : user_pay_status
	 * @Date : 2017. 12. 6.
	 * @User : 전상수
	 * @Param :회원 아이디
	 * @Return : -
	 * @Method 설명 : 회원 결제정보를 가져오는 DAO 함수
	 */
	public ArrayList<HashMap<String, Object>> user_pay_status(String id){
		logger.debug("회원 결제내역정보를 가져오는 DAO 시작");
		ArrayList<HashMap<String, Object>> applyList=null;
		SocietyEduUserMapper mapper = sqlSession.getMapper(SocietyEduUserMapper.class);
		applyList=mapper.user_pay_status(id);
		
		logger.debug("회원 결제내역정보를 가져오는 DAO 종료");
		return applyList;
	}
	
	/**
	 * @Method Name : user_refund_req
	 * @Date : 2017. 12. 18.
	 * @User : 전상수
	 * @Param :환불요청정보
	 * @Return : -
	 * @Method 설명 : 회원 환불요청하는 DAO 함수 (이미 DB에 있다면 수정, 없다면 등록하도록한다.)
	 */
	public void user_refund_req(RefundInfo refundInfo){
		logger.debug("회원 환불정보요청하는 DAO 시작");
		SocietyEduUserMapper mapper = sqlSession.getMapper(SocietyEduUserMapper.class);
		
		int num=mapper.user_check_refund(refundInfo.getSeq());
		
		if(num>0){
			mapper.user_refund_udt(refundInfo);
		}else{
			mapper.user_refund_req(refundInfo);
		}
		
		logger.debug("회원 환불정보요청하는 DAO 종료");
	}
	
	
	/**
	 * @Method Name : user_refund_req
	 * @Date : 2017. 12. 18.
	 * @User : 전상수
	 * @Param :환불요청정보
	 * @Return : -
	 * @Method 설명 : 회원 환불요청하는 DAO 함수 (이미 DB에 있다면 수정, 없다면 등록하도록한다.)
	 */
	public RefundInfo user_refund_status(String seq){
		logger.debug("회원 환불정보요청하는 DAO 시작");
		RefundInfo info=new RefundInfo();
		SocietyEduUserMapper mapper = sqlSession.getMapper(SocietyEduUserMapper.class);
		
		info=mapper.user_refund_status(seq);
		
		logger.debug("회원 환불정보요청하는 DAO 종료");
		
		return info;
	}
	
	/**
	 * @Method Name : user_udate_payinfo
	 * @Date : 2017. 12. 18.
	 * @User : 전상수
	 * @Param :환불요청정보
	 * @Return : -
	 * @Method 설명 : 회원 환불요청하는 DAO 함수 (이미 DB에 있다면 수정, 없다면 등록하도록한다.)
	 */
	public int user_udate_payinfo(HashMap<String,String> hmParam){
		logger.debug("회원 환불정보요청하는 DAO 시작");
		
		SocietyEduUserMapper mapper = sqlSession.getMapper(SocietyEduUserMapper.class);
		try{
		mapper.user_udate_payinfo(hmParam);
		} catch ( Exception e ){
		 return 0;	
		}
		return 1;
		
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
		logger.debug("user_refund_cancel DAO 시작");
		SocietyEduUserMapper mapper = sqlSession.getMapper(SocietyEduUserMapper.class);
		logger.debug("user_refund_cancel DAO 종료");
		return mapper.user_refund_cancel(pay_refund_seq);
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
		logger.debug("user_pay_cancel DAO 시작");
		SocietyEduUserMapper mapper = sqlSession.getMapper(SocietyEduUserMapper.class);
		logger.debug("user_pay_cancel DAO 종료");
		return mapper.user_pay_cancel(pay_user_seq);
	}
	
	/**
	 * @Method Name : user_consulting_list
	 * @Date : 2018. 07. 31.
	 * @User : 김도훈
	 * @Param : 온라인상담 내역
	 * @Return : -
	 * @Method 설명 : 온라인상담 내역 요청하는 DAO 함수
	 */
	public ArrayList<HashMap<String, Object>> user_consulting_list(String id){
		logger.debug("회원 온라인상담 내역정보를 가져오는 DAO 시작");
		ArrayList<HashMap<String, Object>> applyList = null;
		SocietyEduUserMapper mapper = sqlSession.getMapper(SocietyEduUserMapper.class);
		applyList=mapper.user_consulting_list(id);
		
		logger.debug("회원 온라인상담 내역정보를 가져오는 DAO 종료");
		return applyList;
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
		logger.debug("결제 ID로 해당 회원 ID를 검색하는 DAO 시작");
		
		SocietyEduUserMapper mapper = sqlSession.getMapper(SocietyEduUserMapper.class);
		
		logger.debug("결제 ID로 해당 회원 ID를 검색하는 DAO 종료");
		
		return mapper.select_pay_user_id(pay_moid);
	}
	
	public int select_pay_crc_seq(HashMap<String, Object> map) {
		logger.debug(" DAO 종료");
		
		SocietyEduUserMapper mapper = sqlSession.getMapper(SocietyEduUserMapper.class);
		
		logger.debug(" DAO 종료");
		
		return mapper.select_pay_crc_seq(map);
	}
	public int user_toefl_udate_payinfo(HashMap<String, String> hmParam) {
		
		SocietyEduUserMapper mapper = sqlSession.getMapper(SocietyEduUserMapper.class);
		try{
		mapper.user_toefl_udate_payinfo(hmParam);
		logger.debug(" DAO 종료");
		} catch ( Exception e ){
		 return 0;
		}
		return 1;
	}
	
}
