package global.segroup.society.smtp.apply.dao;

import global.segroup.domain.User;
import global.segroup.society.smtp.apply.domain.CardinalDTO;
import global.segroup.society.smtp.apply.domain.CourseDTO;
import global.segroup.society.smtp.apply.domain.Student_Enter_CRC_DTO;
import global.segroup.society.smtp.apply.domain.Student_Resume_Apply_History_DTO;

public interface SocietyStudentUserMapper {

	public User selectOneUser(User check);

	public User selectUserById(String loginId);

	public Student_Enter_CRC_DTO selectStudentEnterCRC(String user_id);

	public Student_Resume_Apply_History_DTO selectStudentResumeApplyHistory(String user_id);

	public CardinalDTO selectCardinalById(String id);

	public CourseDTO selectCourseByCardinalId(String id);


}
