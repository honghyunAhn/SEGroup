package global.segroup.society.smtp.apply.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.segroup.domain.User;
import global.segroup.society.smtp.apply.domain.CardinalDTO;
import global.segroup.society.smtp.apply.domain.CourseDTO;
import global.segroup.society.smtp.apply.domain.Student_Enter_CRC_DTO;
import global.segroup.society.smtp.apply.domain.Student_Resume_Apply_History_DTO;

@Repository
public class SocietyStudentUserDAO {
	
	@Autowired
	private SqlSession sqlSession;

	public User selectOneUser(User check) {
		User loginUser = new User();
		SocietyStudentUserMapper mapper = sqlSession.getMapper(SocietyStudentUserMapper.class);
		try{
			loginUser = mapper.selectOneUser(check);
		}catch(Exception e){
			e.printStackTrace();
			return loginUser;
		}
		return loginUser;
	}

	public Student_Enter_CRC_DTO selectStudentEnterCRC(String user_id) {
		// TODO Auto-generated method stub
		Student_Enter_CRC_DTO checkStudent = new Student_Enter_CRC_DTO();
		SocietyStudentUserMapper mapper = sqlSession.getMapper(SocietyStudentUserMapper.class);
		try{
			checkStudent = mapper.selectStudentEnterCRC(user_id);
		}catch(Exception e){
			e.printStackTrace();
			return checkStudent;
		}
		return checkStudent;
	}

	public Student_Resume_Apply_History_DTO selectStudentResumeApplyHistory(String user_id) {
		// TODO Auto-generated method stub
		Student_Resume_Apply_History_DTO checkApplyHistory = new Student_Resume_Apply_History_DTO();
		SocietyStudentUserMapper mapper = sqlSession.getMapper(SocietyStudentUserMapper.class);
		try{
			checkApplyHistory = mapper.selectStudentResumeApplyHistory(user_id);
		}catch(Exception e){
			e.printStackTrace();
			return checkApplyHistory;
		}
		return checkApplyHistory;
	}

	public CardinalDTO selectCardinalById(String id) {
		// TODO Auto-generated method stub
		CardinalDTO cardinal = new CardinalDTO();
		SocietyStudentUserMapper mapper = sqlSession.getMapper(SocietyStudentUserMapper.class);
		try{
			cardinal = mapper.selectCardinalById(id);
		}catch(Exception e){
			e.printStackTrace();
			return cardinal;
		}
		return cardinal;
	}

	public CourseDTO selectCourseByCardinalId(String id) {
		// TODO Auto-generated method stub
		CourseDTO course = new CourseDTO();
		SocietyStudentUserMapper mapper = sqlSession.getMapper(SocietyStudentUserMapper.class);
		try{
			course = mapper.selectCourseByCardinalId(id);
		}catch(Exception e){
			e.printStackTrace();
			return course;
		}
		return course;
	}
	
/*	@Autowired
	SqlSession session;

	public User selectSmgmtUser(User check) {
		// TODO Auto-generated method stub
		User member = new User();
		SocietyStudentUserMapper mapper = session.getMapper(SocietyStudentUserMapper.class);
		try{
			member = mapper.selectSmgmtUser(check);
		}catch(Exception e){
			return member;
		}
		return member;
	}*/

}
