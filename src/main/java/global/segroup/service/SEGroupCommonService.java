package global.segroup.service;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import global.segroup.dao.SEGroupCommonDAO;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 21.
 * @Class 설명 : Soft Engineer Group 공통 기능 서비스
 * 
 */
@Service
public class SEGroupCommonService{
	
	private static final Logger logger = LoggerFactory.getLogger(SEGroupCommonService.class);
	
	@Autowired
	private SEGroupCommonDAO sgcDao;
	
	/**
	 * @Method Name : selectCodeName
	 * @Date : 2017. 7. 21.
	 * @User : 이종호
	 * @Param : GroupId 와 Code 를 가진 HashMap 객체
	 * @Return : 해당 하는 CodeName
	 * @Method 설명 : 컨트롤러로 부터 전달 받은 GroupId와 Code를 Code 이름 검색 DAO에 전달 하고,
	 * 							DAO로 부터 전달 받은 Code 이름을 서비스에 전달해준다.
	 */
	public String selectCodeName(HashMap<String, String> fullCode){
		logger.debug("공통 코드 이름 검색 서비스 시작");
		String result = sgcDao.selectCodeName(fullCode);
		logger.debug("공통 코드 이름 검색 서비스 종료");
		
		return result;
	}
	
	/**
	 * @Method Name : updateUserFlag
	 * @Date : 2018.8.20
	 * @User : 이종호
	 * @Param : 회원 아이디 와 변경할 회원 등급 코드를 가진 HashMap 객체
	 * @Return : -
	 * @Method 설명 : 특정 회원의 회원등급을 변경하는 서비스
	 */
	public void updateUserFlag(HashMap<String, String> params) {
		logger.debug("특정 회원의 회원등급 변경 서비스 시작");
		
		sgcDao.updateUserFlag(params);
		
		logger.debug("특정 회원의 회원등급 변경 서비스 종료");
	}
	
}
