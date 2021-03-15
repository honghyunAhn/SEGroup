package global.segroup.society.smtp.apply.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import global.segroup.domain.User;
import global.segroup.society.smtp.apply.dao.SocietyStudentUserDAO;
import global.segroup.society.smtp.apply.domain.CardinalDTO;
import global.segroup.society.smtp.apply.domain.CourseDTO;
import global.segroup.society.smtp.apply.domain.Student_Enter_CRC_DTO;
import global.segroup.society.smtp.apply.domain.Student_Resume_Apply_History_DTO;

@Service
public class SocietyStudentUserService {
	
	@Autowired
	SocietyStudentUserDAO ssuDao;

	public User selectOneUser(User check) {
		// TODO Auto-generated method stub
		return ssuDao.selectOneUser(check);
	}

	public Student_Enter_CRC_DTO selectStudentEnterCRC(String user_id) {
		// TODO Auto-generated method stub
		return ssuDao.selectStudentEnterCRC(user_id);
	}

	public Student_Resume_Apply_History_DTO selectStudentResumeApplyHistory(String user_id) {
		// TODO Auto-generated method stub
		return ssuDao.selectStudentResumeApplyHistory(user_id);
	}

	public CardinalDTO selectCardinalById(String id) {
		// TODO Auto-generated method stub
		return ssuDao.selectCardinalById(id);
	}

	public CourseDTO selectCourseByCardinalId(String id) {
		// TODO Auto-generated method stub
		return ssuDao.selectCourseByCardinalId(id);
	}
	
/*	@Autowired
	SocietyStudentUserRepository SmgmtURepository;

	public User selectSmgmtUser(User check) {
		// TODO Auto-generated method stub
		return ssuDao.selectSmgmtUser(check);
	}*/

}
