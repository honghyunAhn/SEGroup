package global.segroup.society.smtp.apply.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.segroup.domain.User;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyCareer;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyEduHistory;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyForm;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyIntroduce;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyKmove;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyLanguage;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyLicense;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyOverseas;
import global.segroup.society.smtp.apply.domain.SocietyStuApplySes;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyStudy;

@Repository
public class SocietyStudentApplyDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyStudentApplyDAO.class);
	
	@Autowired
	SqlSession sqlSession;

	/**
	 * @Method Name : apply_insert
	 * @Date : 2020. 8. 5.
	 * @User : 김성미
	 * @Param : 지원신청 정보
	 * @Return : -
	 * @Method 설명 : 지원신청 정보를 Mapper에 전달 
	 */
	public void apply_insert(SocietyStuApplyForm ssaForm, SocietyStuApplyEduHistory ssaEduHistory
			,SocietyStuApplyCareer ssaCareer, SocietyStuApplyStudy ssaStudy, SocietyStuApplyLanguage ssaLanguage
			,SocietyStuApplyLicense ssaLicense, SocietyStuApplySes ssaSes, SocietyStuApplyKmove ssaKmove 
			,SocietyStuApplyOverseas ssaOverseas, SocietyStuApplyIntroduce ssaIntroduce) {

		logger.debug("지원신청 DAO 시작");
		
		SocietyStudentApplyMapper ssaMapper = sqlSession.getMapper(SocietyStudentApplyMapper.class);
		if(ssaForm.getStu_app_seq() != 0) ssaMapper.insertStuApplyForm(ssaForm);
		else ssaMapper.insertStuApplyForm(ssaForm);
		
		if(ssaEduHistory.getEduHistoryList().size() != 0){
			ssaMapper.insertStuApplyEduHistory(makeMap(ssaEduHistory.getEduHistoryList(), ssaForm.getStu_app_seq(),ssaForm.getUser_id()));
		}
		if(ssaCareer.getCareerList().size() != 0){
			ssaMapper.insertStuApplyCareer(makeMap(ssaCareer.getCareerList(), ssaForm.getStu_app_seq(), ssaForm.getUser_id()));
		}
		if(ssaStudy.getStudyList().size() != 0){
			ssaMapper.insertStuApplyStudy(makeMap(ssaStudy.getStudyList(), ssaForm.getStu_app_seq(), ssaForm.getUser_id()));
		}
		if(ssaLanguage.getLanguageList().size() != 0){
			ssaMapper.insertStuApplyLanguage(makeMap(ssaLanguage.getLanguageList(), ssaForm.getStu_app_seq(), ssaForm.getUser_id()));
		}
		if(ssaLicense.getLicenseList().size() != 0){
			ssaMapper.insertStuApplyLicense(makeMap(ssaLicense.getLicenseList(), ssaForm.getStu_app_seq(), ssaForm.getUser_id()));
		}
		if(ssaSes.getSesList().size() != 0){
			ssaMapper.insertStuApplySes(makeMap(ssaSes.getSesList(), ssaForm.getStu_app_seq(), ssaForm.getUser_id()));
		}
		if(ssaKmove.getKmoveList().size() != 0){
			ssaMapper.insertStuApplyKmove(makeMap(ssaKmove.getKmoveList(), ssaForm.getStu_app_seq(), ssaForm.getUser_id()));
		}
		if(ssaOverseas.getOverseasList().size() != 0){
			ssaMapper.insertStuApplyOverseas(makeMap(ssaOverseas.getOverseasList(), ssaForm.getStu_app_seq(), ssaForm.getUser_id()));
		}
		if(ssaIntroduce.getIntroduceList().size() != 0){
			ssaMapper.insertStuApplyIntroduce(makeMap(ssaIntroduce.getIntroduceList(), ssaForm.getStu_app_seq(), ssaForm.getUser_id()));
		}
		
		// 입과 처리
		if(ssaMapper.checkLearnApp(ssaForm) == 0) ssaMapper.insertLearnApp(ssaForm);
		logger.debug("지원신청 DAO 종료");

	}

	/**
	 * @Method Name : makeMap
	 * @Date : 2020. 8. 5.
	 * @User : 김성미
	 * @Param : 지원 신청서 세부정보 리스트, 지원신청서 시퀀스 , 지원신청자 아이디
	 * @Return : 입력받은 항목을 가진 맵 객체
	 * @Method 설명 : Mapper에 넘겨줄 맵 객체 생성 함수
	 */
	private <T>HashMap<String, Object> makeMap(List<T> list, int stu_app_seq, String user_id){
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("list", list);
		resultMap.put("stu_app_seq", stu_app_seq);
		resultMap.put("user_id", user_id);
		return resultMap;
	}
	
	public HashMap<String, Object> selectApplyInfo(HashMap<String, Object> param) {
		SocietyStudentApplyMapper ssaMapper = sqlSession.getMapper(SocietyStudentApplyMapper.class);
		return ssaMapper.selectApplyInfo(param);
	}

	public HashMap<String, Object> selectSmtpApply(HashMap<String, Object> param) {
		SocietyStudentApplyMapper ssaMapper = sqlSession.getMapper(SocietyStudentApplyMapper.class);
		return ssaMapper.selectSmtpApply(param);

	}

	public void deleteSmtpApplyForm(HashMap<String, Object> param) {
		SocietyStudentApplyMapper ssaMapper = sqlSession.getMapper(SocietyStudentApplyMapper.class);
		ssaMapper.deleteSmtpApplyForm(param);
	}

	public String compareForm(String subject) {
		String result = "";
		
		SocietyStudentApplyMapper ssaMapper = sqlSession.getMapper(SocietyStudentApplyMapper.class);
		
		result = ssaMapper.compareForm(subject);
		
		return result;
	}

	public ArrayList<HashMap<String, Object>> selectApplyResult(String user_id) {
		SocietyStudentApplyMapper ssaMapper = sqlSession.getMapper(SocietyStudentApplyMapper.class);
		return ssaMapper.selectApplyResult(user_id);
	}

	public HashMap<String, Object> selectGisuInfo(String cardinal_id) {
		SocietyStudentApplyMapper ssaMapper = sqlSession.getMapper(SocietyStudentApplyMapper.class);
		return ssaMapper.selectGisuInfo(cardinal_id);
	}

	public User selectUserById(String loginId) {
		SocietyStudentApplyMapper ssaMapper = sqlSession.getMapper(SocietyStudentApplyMapper.class);
		return ssaMapper.selectUserById(loginId);
	}
}

