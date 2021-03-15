package global.segroup.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.segroup.domain.Admin;
import global.segroup.domain.CertificationCode;
import global.segroup.domain.User;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 21.
 * @Class 설명 : Soft Engineer Group 공통 기능 DAO
 * 
 */
@Repository
public class SEGroupCommonDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(SEGroupCommonDAO.class);
	
	@Autowired
	SqlSession sqlSession;
	
	/**
	 * @Method Name : selectCodeName
	 * @Date : 2017. 7. 21.
	 * @User : 이종호
	 * @Param : GroupId 와 Code 를 가진 HashMap 객체
	 * @Return : 해당 하는 CodeName
	 * @Method 설명 : 서비스로 부터 전달 받은 GroupId와 Code를 Code 이름 검색 매퍼에 전달 하고,
	 * 							매퍼로 부터 전달 받은 Code 이름을 서비스에 전달해준다.
	 */
	public String selectCodeName(HashMap<String, String> fullCode){
		logger.debug("공통 코드 이름 검색 DAO 시작");
		SEGroupCommonMapper mapper = sqlSession.getMapper(SEGroupCommonMapper.class);
		logger.debug("공통 코드 이름 검색 DAO 종료");
		return mapper.selectCodeName(fullCode); 
		
	}
	
	/**
	 * @Method Name : selectUser
	 * @Date : 2017. 8. 8.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : 회원 정보 객체
	 * @Method 설명 : 전달 받은 회원 아이디의 회원 정보를 조회하는 DAO 함수
	 */
	public User selectUser(User user){
		logger.debug("회원 정보 검색 DAO 시작");
		SEGroupCommonMapper mapper = sqlSession.getMapper(SEGroupCommonMapper.class);
		logger.debug("회원 정보 검색 DAO 종료");
		return mapper.selectUser(user);
	}
	
	/**
	 * @Method Name : selectUserAll
	 * @Date : 2017. 9. 29.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 전체 회원 정보 리스트
	 * @Method 설명 : 전체 회원 정보를 조회하는 DAO 함수
	 */
	public ArrayList<User> selectUserAll(){
		logger.debug("전체 회원 정보 조회 DAO 시작");
		
		SEGroupCommonMapper mapper = sqlSession.getMapper(SEGroupCommonMapper.class);
		ArrayList<User> resultList = mapper.selectUserAll();
		
		logger.debug("전체 회원 정보 조회 DAO 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : selectAdmin
	 * @Date : 2017. 8. 8.
	 * @User : 이종호
	 * @Param : 관리자 아이디
	 * @Return : 관리자 정보 객체
	 * @Method 설명 : 전달 받은 관리자 아이디의 관리자 정보를 조회하는 DAO 함수
	 */
	public Admin selectAdmin(String admin_id){
		logger.debug("관리자 정보 검색 DAO 시작");
		SEGroupCommonMapper mapper = sqlSession.getMapper(SEGroupCommonMapper.class);
		logger.debug("관리자 정보 검색 DAO 종료");
		return mapper.selectAdmin(admin_id);
	}
	
	/**
	 * @Method Name : selectCertificationCode
	 * @Date : 2017. 10. 16.
	 * @User : 한진규
	 * @Param : 코드 정보
	 * @Return : 일치하는 인증 코드 정보
	 * @Method 설명 : 일부 코드 정보를 가지고 전체 정보 검색
	 */
	public CertificationCode selectCertificationCode(CertificationCode code) {
		logger.debug("인증 코드 정보 검색 DAO 시작");
		SEGroupCommonMapper mapper = sqlSession.getMapper(SEGroupCommonMapper.class);
		logger.debug("인증 코드  검색 DAO 종료");
		return mapper.selectCertificationCode(code);
	}
	
	/**
	 * @Method Name : chooseCertificationCode
	 * @Date : 2017. 10. 16.
	 * @User : 한진규
	 * @Param : 
	 * @Return : 랜덤으로 선택된 인증 코드 정보
	 * @Method 설명 : 랜덤으로 정보를 가져온다
	 */
	public CertificationCode chooseCertificationCode() {
		logger.debug("인증 코드 정보 검색 DAO 시작");
		SEGroupCommonMapper mapper = sqlSession.getMapper(SEGroupCommonMapper.class);
		logger.debug("인증 코드  검색 DAO 종료");
		return mapper.chooseCertificationCode();
	}
	
	/**
	 * @Method Name : updateCertificationCode
	 * @Date : 2017. 10. 16.
	 * @User : 한진규
	 * @Param : 코드 정보
	 * @Return : 갱신된 갯수
	 * @Method 설명 : 코드 정보를 갱신한다
	 */
	public int updateCertificationCode(CertificationCode code) {
		logger.debug("인증 코드 정보 검색 DAO 시작");
		SEGroupCommonMapper mapper = sqlSession.getMapper(SEGroupCommonMapper.class);
		logger.debug("인증 코드  검색 DAO 종료");
		return mapper.updateCertificationCode(code);
	}
	
	/**
	 * @Method Name : updateUserFlag
	 * @Date : 2018.8.20
	 * @User : 이종호
	 * @Param : 회원 아이디 와 변경할 회원 등급 코드를 가진 HashMap 객체
	 * @Return : -
	 * @Method 설명 : 특정 회원의 회원등급을 변경하는 DAO
	 */
	public void updateUserFlag(HashMap<String, String> params) {
		logger.debug("특정 회원의 회원등급 변경 DAO 시작");
		SEGroupCommonMapper mapper = sqlSession.getMapper(SEGroupCommonMapper.class);
		
		mapper.updateUserFlag(params);
		
		logger.debug("특정 회원의 회원등급 변경 DAO 종료");
	}
}
