package com.aracomm.changbi.user.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.aracomm.changbi.member.vo.MemberForm;

import global.segroup.domain.CertificationCode;
import global.segroup.domain.User;
import global.segroup.society.smtp.apply.domain.InfoAttendance;

public interface UserDao {

	List<String> selectUserIpList(HashMap<String, String> param);

	List<HashMap<String, String>> selectIpList(String username);
	int updateIpUseYn(HashMap<String, String> param);
	int insertIp(HashMap<String, String> param);
	int deleteIp(HashMap<String, String> param);

	String selectUserNeisNum(String user_id);

	HashMap<String, Object> selectUserForLogin(String username);
	Map<String, Object> selectUserForLoginByIdenDi(String iden_di);
	int updateLastLogin(String user_id);

	int selectUserIpCount(Map<String, String> param);
	
	/**LMS 회원가입 **/
	public int insertUser(MemberForm memberForm);
	public int insertUserInfo(MemberForm memberForm);
	/**LMS 휴면계정 등록 **/
	public int insertRestUser(User user);
	/**LMS 회원정보 조회 **/
	public HashMap<String, Object> selectMemberInfo(String user_id);
	
	/**LMS 휴면회원정보 조회 **/
	public User selectRestMemberInfo(String user_id);
	/**LMS 전체 회원 목록 **/
	public List<User> selectUserListAll();	
	/**LMS 휴면계정 대상여부 조회 **/
	public User selectRestUser(String user_id);
	/*LMS 접속 이력 저장*/
	public int insertUserAccInfo(MemberForm memberForm);
	
	/**LMS 휴면계정 처리 **/
	public int updateRestUserInfo(User user);
	/**LMS 휴면해제 **/
	public int updateUserInfo(User user);
	/**LMS 휴면회원 테이블 데이터 삭제**/
	public int deleteRestUser(String user_id);
	/**LMS 회원정보 수정(기본)**/
	public int updateMemberInfo(MemberForm memberForm);
	/**LMS 회원정보(선택) 유무 확인**/
	public int selectIfAdditionalInfoExist(String id);
	/**LMS 회원정보 수정(선택)1**/
	public int updateAdditionalMemberInfo(MemberForm memberForm);
	/**LMS 회원정보 수정(선택)2**/
	public int insertAdditionalMemberInfo(MemberForm memberForm);
	/**LMS 아이디 찾기**/
	public HashMap<String,String> selectMemberForFindId(HashMap<String, String> findMap);
	/**LMS 비밀번호 찾기**/
	public HashMap<String,String> selectMemberForFindPw(HashMap<String,String> param);
	/**LMS 비밀번호 변경 **/
	public int updatePassword(Map<String, String> param);
	/**LMS 회원탈퇴**/
	public int changeIDInfo(Map<String, String> param);
	public int changeCertificationID(Map<String, String> map);
	public int deleteMemberInfo(String id);
	public int insertMemberOut(Map<String, String> param);
	/**LMS 개인 결제 정보 **/
	public ArrayList<HashMap<String, Object>> individualPayList(HashMap<String,String> param);
	/**LMS 개인 결제 정보 결과 수 **/
	public int individualPayListCnt(HashMap<String, String> param);
	/**LMS 인증 정보 **/
	CertificationCode selectCertificationCode(CertificationCode code);
	/**LMS 인증 정보 갱신**/
	public int updateCertificationCode(CertificationCode foundCode);
	/**LMS 인증 코드 정보 추첨 **/
	public CertificationCode chooseCertificationCode();
	/**LMS 영수증 정보 조회**/
	public HashMap<String, Object> selectReceiptNum(HashMap<String, Object> selectMap);
	/** LMS 영수증 일련번호 존재 여부(시퀀스조회) **/
	public Integer selectReceiptSeq();
	/**LMS 영수증 정보 입력**/
	public int insertReceipt(Map<String, Object> param);



	public String putUserName(String userName);
	public int putSeq(HashMap<String, Object> param);
	public void stuUpdate(InfoAttendance info);
	
	/**SMTP 개인 결제 정보 **/
	public ArrayList<HashMap<String, Object>> smtpIndividualPayList(HashMap<String,String> param);
	
	public HashMap<String, Object> getUserPayInfo(HashMap<String, Object> param);
	public HashMap<String, Object> getRefundInfo(String pay_user_seq);
	public HashMap<String, Object> getEduCurriculumPayInfo(int payCrcSeq);
	
	/**모의 토플 환불 정보 **/
	public HashMap<String, Object> getToeflRefundInfo(String pay_toefl_seq);
	
	/** 모의 토플 환불 수정 **/
	public int toeflRefundUpdate(HashMap<String, Object> param);

	/** 모의 토플 환불 삭제 **/
	public int toeflRefundDelete(String pay_toefl_seq);
}
