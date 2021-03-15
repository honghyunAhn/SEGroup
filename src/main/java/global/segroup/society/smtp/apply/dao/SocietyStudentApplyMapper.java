package global.segroup.society.smtp.apply.dao;

import java.util.ArrayList;
import java.util.HashMap;

import global.segroup.domain.User;
import global.segroup.society.smtp.apply.domain.SocietyStuApplyForm;

/**
 * @Author : 김성미
 * @Date : 2020. 8. 5.
 * @Class 설명 : Soft Engineer Society 지원서 신청 Mapper
 * 
 */
public interface SocietyStudentApplyMapper {

	public HashMap<String, Object> selectGisuInfo(String cardinal_id);
	public User selectUserById(String loginId);
	public void insertStuApplyForm(SocietyStuApplyForm ssaForm);
	public void insertStuApplyEduHistory(HashMap<String, Object> stuEduHistoryMap);
	public void insertStuApplyCareer(HashMap<String, Object> stuCareerMap);
	public void insertStuApplyStudy(HashMap<String, Object> stuStudyMap);
	public void insertStuApplyLanguage(HashMap<String, Object> stuLanguageMap);
	public void insertStuApplyLicense(HashMap<String, Object> stuLicenseMap);
	public void insertStuApplySes(HashMap<String, Object> stuSesMap);
	public void insertStuApplyKmove(HashMap<String, Object> stuKmoveMap);
	public void insertStuApplyOverseas(HashMap<String, Object> stuOverseasMap);
	public void insertStuApplyIntroduce(HashMap<String, Object> stuIntroduceMap);
	public int checkLearnApp(SocietyStuApplyForm ssaForm);
	public void insertLearnApp(SocietyStuApplyForm ssaForm);
	public HashMap<String, Object> selectApplyInfo(HashMap<String, Object> param);
	public HashMap<String, Object> selectSmtpApply(HashMap<String, Object> param);
	public void deleteSmtpApplyForm(HashMap<String, Object> param);
	public ArrayList<HashMap<String, Object>> selectApplyResult(String user_id);
	// 지원 폼 필요한 과목 분류
	public String compareForm(String subject);
}
