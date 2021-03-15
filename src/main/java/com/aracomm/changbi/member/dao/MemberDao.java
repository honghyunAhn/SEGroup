package com.aracomm.changbi.member.dao;

import java.util.HashMap;
import java.util.Map;

import com.aracomm.changbi.member.vo.MemberForm;


public interface MemberDao {

	/** 회원 가입 **/
	public HashMap<String, Object> selectValidMemberByDi(String iden_di);
	public int selectValidMemberCountById(String id);
	public int selectMemberCountByNeis(Map<String, String> param);
	public int insertUser(MemberForm memberForm);

	/** 아이디 비번 찾기 **/
	public HashMap<String, String> selectMemberForFindId(Map<String, String> param);
	public HashMap<String, String> selectMemberForFindPw(Map<String, String> param);
	public int selectMemberCountByIdPasswd(Map<String, String> param);
	public int updateTempPassword(Map<String, String> param);
	public int updatePassword(Map<String, String> param);


	public HashMap<String, Object> selectMember1(String id);
	
	/**LMS 아이디 중복 체크 **/
	public int selectMemberCountById(String id);
	
	/** LMS 이메일 중복 체크 **/
	public int checkEmailDuplicated(String email);


}
