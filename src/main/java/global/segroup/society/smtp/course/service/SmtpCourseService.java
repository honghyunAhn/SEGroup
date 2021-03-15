package global.segroup.society.smtp.course.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aracomm.changbi.course.dao.LmsCourseDao;

import global.segroup.society.smtp.dao.SmtpCourseDao;

@Service
public class SmtpCourseService {
	
	@Autowired
	LmsCourseDao dao;
	
	public List<HashMap<String, String>> selectCourseList(){
		return dao.selectCourseList();		
	}
	
	public List<HashMap<String, String>> selectCourseBoardList(HashMap<String, String> param){
		return dao.selectCourseBoardList(param);		
	}
	
	public int selectCourseListTotCnt(HashMap<String, String> param){
		return dao.selectCourseListTotCnt(param);		
	}
	
	public HashMap<String, String> getUserInfo(String user_id){
		return dao.getUserInfo(user_id);
	}
	
	public List<HashMap<String, String>> checkCardinalMatched(String course_id) {
		return dao.checkCardinalMatched(course_id);
	}
	
	public int checkValidCardinalExist(HashMap<String, String> param) {
		return dao.checkValidCardinalExist(param);
	}
	
	public int insertCardinal(HashMap<String, Object> param) {
		return dao.insertCardinal(param);
	}
	
	public int selectCbCnCardinalCnt(HashMap<String, String> param) {
		return dao.selectCbCnCardinalCnt(param);
	};

	public int insertCardinalCourseInfo(HashMap<String, String> param) {
		return dao.insertCardinalCourseInfo(param);
	}
	
	public Integer selectMaxCardinalSeq() {
		return dao.selectMaxCardinalSeq();
	}
	
	public String selectCardinalId(HashMap<String, String> param) {
		return dao.selectCardinalId(param);
	}
	
	public int insertApply(HashMap<String, String> param) {
		return dao.insertApply(param);
	}
	
	public HashMap<String, Object> selectCourseDetail(String course_id){
		return dao.selectCourseDetail(course_id);
	}
	
	public List<HashMap<String, String>> selectCourseChapterListAll(String course_id){
		return dao.selectCourseChapterListAll(course_id);
	}
	
	public List<HashMap<String, String>> selectCardinalList(HashMap<String, String> param){
		return dao.selectCardinalList(param);
	}
	
	public List<HashMap<String, String>> selectSearchCourseList(HashMap<String, String> param){
		return dao.selectSearchCourseList(param);		
	};
	
	public int searchCourseListTotCnt(HashMap<String, String> param){
		return dao.searchCourseListTotCnt(param);		
	};

	public int selectLearnAppId(HashMap<String, String> param) {
		return dao.selectLearnAppId(param);
	};

	
	public int selectEnrolledListCnt(HashMap<String, String> param) {
		return dao.selectEnrolledListCnt(param);
	}
	
	public int insertLearnCancelApp(HashMap<String, Object> param) {
		return dao.insertLearnCancelApp(param);
	};

	
	public int changeLearnPaymentState(String id) {
		return dao.changeLearnPaymentState(id);
	};
	
	public HashMap<String, String> selectLearnCancelInfo(HashMap<String, String> param){
		return dao.selectLearnCancelInfo(param);
	};

	public int updateLearnCancelInfo(HashMap<String, Object> param) {
		return dao.updateLearnCancelInfo(param);
	};
	
	public int insertEduUserRefundTb(HashMap<String, Object> param) {
		return dao.insertEduUserRefundTb(param);
	}
	
	public int deleteRefundInfo(String learn_id) {
		return dao.deleteRefundInfo(learn_id);
	};

	public int updateLearnAppState(String learn_id) {
		return dao.updateLearnAppState(learn_id);
	}

	public int updateUserInfo(HashMap<String, String> param) {		 
		return dao.updateUserInfo(param);
	}

	public int updateAdditionalUserInfo(HashMap<String, String> param) {
		return dao.updateAdditionalUserInfo(param);
		
	}

	public int insertAdditionalUserInfo(HashMap<String, String> param) {
		return dao.insertAdditionalUserInfo(param);
		
	};	
	
	public String getCourse(String gisu) {
		System.out.println(gisu);
		return dao.getCourse(gisu);
	}
	
	public HashMap<String, Object> getCardinalDetail(String cardinalId) {
		return dao.getCardinalDetail(cardinalId);
	}
	
	/*
	 * public String searchCoursePage(String course_id){ return
	 * dao.searchCoursePage(course_id); };
	 */
	
	public int deletePayUserRefundTb(String pay_user_seq) {
		return dao.deletePayUserRefundTb(pay_user_seq);
	}
	
	public int updateEduUserPayTb(String pay_user_seq) {
		return dao.updateEduUserPayTb(pay_user_seq);
	}
	
	public int refundUpdate(String pay_user_seq) {
		return dao.refundUpdate(pay_user_seq);
	}
	
	public int payBackUpdateSubmit(HashMap<String, Object> param) {
		return dao.payBackUpdateSubmit(param);
	}
	
	public List<HashMap<String, Object>> selectAvailableCourse() {
		return dao.selectAvailableCourse();
	}
	
	//목차/페이지 조회
	public List<HashMap<String, String>> getChapPage(HashMap<String, String> param) {
		return dao.getChapPage(param);
	}
	//목차/페이지 조회
	public List<HashMap<String, String>> getChapPage2(HashMap<String, String> param) {
		return dao.getChapPage2(param);
	}
		//입과시 수강정보 생성
	public void insertAttLec(HashMap<String, String> param, List<HashMap<String, String>> chapList) {
		for(HashMap<String, String> c : chapList) {
			HashMap<String, Object> p = new HashMap<String, Object>();
			p.put("learn_app_id", param.get("id"));
			p.put("user_id", param.get("user_id"));
			p.put("cardinal_id", param.get("cardinal_id"));
			p.put("course_id", param.get("course_id"));
			p.put("chapter", c.get("ID"));
			p.put("chasi", c.get("ORDER_NUM"));
			if(c.get("MAIN_URL") == null || c.get("MAIN_URL") == "") {
				p.put("subchap", c.get("seq"));
				dao.insertAttLec(p);
			} else {
				p.put("subchap", 0);
				dao.insertAttLec(p);
			}
		}
	}
}
