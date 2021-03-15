package global.segroup.society.smtp.dao;

import java.util.HashMap;
import java.util.List;

public interface SmtpCourseDao {
	
	public List<HashMap<String, String>> selectCourseList();
	
	public List<HashMap<String, String>> selectCourseBoardList(HashMap<String, String> param);

	public int selectCourseListTotCnt(HashMap<String, String> param);
	
	public HashMap<String, String> getUserInfo(String user_id);
	
	public List<HashMap<String, String>> checkCardinalMatched(String course_id);

	public int checkValidCardinalExist(HashMap<String, String> param);
	
	public int insertCardinal(HashMap<String, Object> param);
	
	public int insertCardinalCourseInfo(HashMap<String, String> param);
	
	public Integer selectMaxCardinalSeq();
	
	public String selectCardinalId(HashMap<String, String> param);
	
	public int insertApply(HashMap<String, String> param);
	
	public HashMap<String, Object> selectCourseDetail(String course_id);
	
	public List<HashMap<String, String>> selectCourseChapterListAll(String course_id);
	
	public List<HashMap<String, String>> selectCardinalList(HashMap<String, String> param);
	
	public List<HashMap<String, String>> selectSearchCourseList(HashMap<String, String> param);
	
	public int searchCourseListTotCnt(HashMap<String, String> param);
	
	public int selectLearnAppId(HashMap<String, String> param);
	
	public int selectEnrolledListCnt(HashMap<String, String> param);
	
	public int selectCbCnCardinalCnt(HashMap<String, String> param);

	public int insertLearnCancelApp(HashMap<String, Object> param);

	public int changeLearnPaymentState(String id);

	public HashMap<String, String> selectLearnCancelInfo(HashMap<String, String> param);

	public int updateLearnCancelInfo(HashMap<String, Object> param);

	public int deleteRefundInfo(String learn_id);

	public int updateLearnAppState(String learn_id);

	public int updateUserInfo(HashMap<String, String> param);

	public int updateAdditionalUserInfo(HashMap<String, String> param);

	public int insertAdditionalUserInfo(HashMap<String, String> param);

	/* public String searchCoursePage(String course_id); */

}
