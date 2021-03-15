/**
 * 
 */
package global.segroup.society.smtp.admin.dao;

import java.util.ArrayList;

import global.segroup.society.smtp.admin.domain.SocietySmtpAdminCurriculum;
import global.segroup.society.smtp.admin.domain.SocietySmtpAdminCurriculumGisu;

/**
 * @Author : 김슬기
 * @Date : 2019. 12. 3.
 * @Class 설명 : Soft Engineer Society 통합학사관리 관리자 매퍼
 * 
 */
public interface SocietySmtpAdminMapper {
	
	////////////////////////////////통합 검색
	public ArrayList<SocietySmtpAdminCurriculum> searchCurriculum(String crc_section);
	public ArrayList<SocietySmtpAdminCurriculumGisu> searchCurriculumGisu(String crc_code);
	////////////////////////////////통합 검색

}
