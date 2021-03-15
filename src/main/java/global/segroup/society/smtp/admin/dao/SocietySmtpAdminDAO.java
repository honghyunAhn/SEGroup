/**
 * 
 */
package global.segroup.society.smtp.admin.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.segroup.society.smtp.admin.domain.SocietySmtpAdminCurriculum;
import global.segroup.society.smtp.admin.domain.SocietySmtpAdminCurriculumGisu;

/**
 * @Author : 김슬기
 * @Date : 2019. 12. 3.
 * @Class 설명 : Soft Engineer Society 통합학사관리 관리자 DAO
 * 
 */

@Repository
public class SocietySmtpAdminDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietySmtpAdminDAO.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	////////////////////////////////통합 검색
	/**
	* @Method Name : searchCurriculum
	* @Date : 2019. 12. 2.
	* @User : 김슬기
	* @Param : -
	* @Return : 특정 과정 분류의 과정들 정보 리스트 객체
	* @Method 설명 : 특정 과정 분류의 과정들 정보들을 조회 하는 DAO 함수
	*/
	public ArrayList<SocietySmtpAdminCurriculum> searchCurriculum(String crc_section) {
		logger.debug("특정 과정 분류의 과정들 정보를 조회하는 DAO 시작");
		
		ArrayList<SocietySmtpAdminCurriculum> resultList = new ArrayList<>();
		SocietySmtpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmtpAdminMapper.class);
		resultList = ssaMapper.searchCurriculum(crc_section);
		
		logger.debug("특정 과정 분류의 과정들 정보를 조회하는 DAO 종료");
	return resultList;
	}
	
	/**
	* @Method Name : searchCurriculumGisu
	* @Date : 2019. 12. 2.
	* @User : 김슬기
	* @Param : 과정 코드 정보
	* @Return : 해당 과정 정보의 과정기수 정보들을 가진 리스트 객체
	* @Method 설명 : 해당 과정 정보의 과정기수 정보들을 조회하는 DAO 함수
	*/
	public ArrayList<SocietySmtpAdminCurriculumGisu> searchCurriculumGisu(String crc_code){
		logger.debug("과정 코드로 과정기수 정보 검색 DAO 시작");
		
		SocietySmtpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmtpAdminMapper.class);
		ArrayList<SocietySmtpAdminCurriculumGisu> ssaGisuList = ssaMapper.searchCurriculumGisu(crc_code);
		
		logger.debug("과정 코드로 과정기수 정보 검색 DAO 종료");
		return ssaGisuList;
	}
	
	//////////////////////////////// 통합 검색

}
