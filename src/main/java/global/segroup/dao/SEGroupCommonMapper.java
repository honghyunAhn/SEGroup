package global.segroup.dao;

import java.util.ArrayList;
import java.util.HashMap;

import global.segroup.domain.Admin;
import global.segroup.domain.CertificationCode;
import global.segroup.domain.User;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 21.
 * @Class 설명 : Soft Engineer Group 공통 기능 매퍼
 * 
 */
public interface SEGroupCommonMapper {
	/**
	 * @Method Name : selectCodeName
	 * @Date : 2017. 7. 21.
	 * @User : 이종호
	 * @Param : GroupId 와 Code 를 가진 HashMap 객체
	 * @Return : 해당 하는 CodeName
	 * @Method 설명 : DAO로 부터 전달 받은 GroupId와 Code로 CodeName을 찾은 SQL과 매핑
	 */
	public String selectCodeName(HashMap<String, String> fullCode);
	
	/**
	 * @Method Name : selectUser
	 * @Date : 2017. 8. 8.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : 회원 정보 객체
	 * @Method 설명 : 전달 받은 아이디로 해당 회원 정보 조회
	 */
	public User selectUser(User user);
	
	/**
	 * @Method Name : selectUserAll
	 * @Date : 2017. 9. 29.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 전체 회원 정보 리스트
	 * @Method 설명 : 전체 회원 정보를 조회하는 매퍼 함수
	 */
	public ArrayList<User> selectUserAll();
	
	/**
	 * @Method Name : selectAdmin
	 * @Date : 2017. 8. 8.
	 * @User : 이종호
	 * @Param : 관리자 아이디
	 * @Return : 관리자 정보 객체
	 * @Method 설명 : 전달 받은 아이디로 해당 관리자 정보 조회
	 */
	public Admin selectAdmin(String admin_id);
	
	/**
	 * @Method Name : selectCertificationCode
	 * @Date : 2017. 10. 16.
	 * @User : 한진규
	 * @Param : 코드 정보
	 * @Return : 일치하는 인증 코드 정보
	 * @Method 설명 : 전달 받은 코드 정보와 일치하는 정보 조회
	 */
	public CertificationCode selectCertificationCode(CertificationCode code);
	
	/**
	 * @Method Name : chooseCertificationCode
	 * @Date : 2017. 10. 16.
	 * @User : 한진규
	 * @Param : 
	 * @Return : 랜덤으로 선택된 코드 정보
	 * @Method 설명 : 랜덤으로 코드를 선택하여 가져 온다
	 */
	public CertificationCode chooseCertificationCode();
	
	/**
	 * @Method Name : updateCertificationCode
	 * @Date : 2017. 10. 16.
	 * @User : 한진규
	 * @Param : 코드 정보
	 * @Return : 갱신된 갯수
	 * @Method 설명 : 전달 받은 코드 정보를 갱신한다
	 */
	public int updateCertificationCode(CertificationCode code);
	
	/**
	 * @Method Name : updateUserFlag
	 * @Date : 2018.8.20
	 * @User : 이종호
	 * @Param : 회원 아이디 와 변경할 회원 등급 코드를 가진 HashMap 객체
	 * @Return : -
	 * @Method 설명 : 특정 회원의 회원등급을 변경하는 Mapper
	 */
	public void updateUserFlag(HashMap<String, String> params);
}
