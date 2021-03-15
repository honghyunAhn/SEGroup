package global.segroup.society.smp.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.segroup.domain.BoardContent;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculumGisu;
import global.segroup.society.edu.apply.domain.SocietyEduApplyForm;
import global.segroup.society.smp.admin.domain.SocietySmpApsDetail;
import global.segroup.society.smp.admin.domain.SocietySmpApsDetailExam;
import global.segroup.society.smp.admin.domain.SocietySmpApsDetailSubexam;
import global.segroup.society.smp.admin.domain.SocietySmpApsGroup;
import global.segroup.society.smp.admin.domain.SocietySmpApsGroupConfirmation;
import global.segroup.society.smp.admin.domain.SocietySmpApsGroupExam;
import global.segroup.society.smp.admin.domain.SocietySmpApsGroupSubexam;
import global.segroup.society.smp.admin.domain.SocietySmpApsSetDetail;
import global.segroup.society.smp.admin.domain.SocietySmpApsSetGroup;
import global.segroup.society.smp.admin.domain.SocietySmpApsSetList;
import global.segroup.society.smp.admin.domain.SocietySmpApsSetTotal;
import global.segroup.society.smp.admin.domain.SocietySmpApsTotal;
import global.segroup.society.smp.admin.domain.SocietySmpSchedule;
import global.segroup.society.smp.admin.domain.SocietySmpScheduleColor;
import global.segroup.society.smp.admin.domain.SocietySmpScheduleScheduleColor;
import global.segroup.society.smp.admin.domain.SocietySmpStudentCareer;
import global.segroup.society.smp.admin.domain.SocietySmpStudentEduHistory;
import global.segroup.society.smp.admin.domain.SocietySmpStudentFile;
import global.segroup.society.smp.admin.domain.SocietySmpStudentForm;
import global.segroup.society.smp.admin.domain.SocietySmpStudentLanguage;
import global.segroup.society.smp.admin.domain.SocietySmpStudentLicense;
import global.segroup.society.smp.admin.domain.SocietySmpStudentOverseas;
import global.segroup.society.smp.admin.domain.SocietySmpStudentStudy;

/**
 * @Author : 여명환
 * @Date : 2018. 8. 20.
 * @Class 설명 : Soft Engineer Society 학사관리 관리자 DAO
 * 
 */

@Repository
public class SocietySmpAdminDAO {

	private static final Logger logger = LoggerFactory.getLogger(SocietySmpAdminDAO.class);

	@Autowired
	private SqlSession sqlSession;

	/**
	 * @Method Name : smp_student_select
	 * @Date : 2018. 8. 19.
	 * @User : 여명환
	 * @Param : 기수 시퀀스, 검색어
	 * @Return : 해당 기수의 학생 정보들 리스트 객체
	 * @Method 설명 : 특정 기수의 학생 정보들을 조회하는 DAO 함수
	 */
	public ArrayList<HashMap<String, Object>> smp_student_select(HashMap<String, Object> map) {
		logger.debug("특정 기수의 학생 정보들을 조회하는 DAO 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("특정 기수의 학생 정보들을 조회하는 DAO 종료");
		return ssaMapper.smp_student_select(map);
	}

	/**
	 * @Method Name : smp_manager_select_count
	 * @Date : 2018. 8. 19.
	 * @User : 여명환
	 * @Param : 기수 시퀀스, 검색어
	 * @Return : 해당 기수의 신청자 정보 count
	 * @Method 설명 : 특정 기수의 신청자 정보count를 조회하는 DAO 함수
	 */
	public int smp_manager_select_count(HashMap<String, Object> map) {
		logger.debug("특정 기수의 신청자 정보들을 조회하는 DAO 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("특정 기수의 신청자 정보들을 조회하는 DAO 종료");
		return ssaMapper.smp_manager_select_count(map);
	}

	/**
	 * @Method Name : smp_copy_studentinfo
	 * @Date : 2018. 08. 21.
	 * @User : 여명환
	 * @Param : 기수 시퀀스, 검색어
	 * @Return : 해당 기수의 신청자 정보 count
	 * @Method 설명 : 특정 기수의 신청자 정보count를 조회하는 DAO 함수
	 */
	public void smp_copy_studentinfo(int app_seq) {
		logger.debug("특정 지원자의 결과 정보 수정 DAO 복사 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		/*
		 * 데이터 최종 합격자 테이블에 복사 (여명환)
		 */

		ssaMapper.insertCopyEduApplyForm(app_seq);
		ssaMapper.insertCopyEduApplyEduHistory(app_seq);
		ssaMapper.insertCopyEduApplyCareer(app_seq);
		ssaMapper.insertCopyEduApplyStudy(app_seq);
		ssaMapper.insertCopyEduApplyLanguage(app_seq);
		ssaMapper.insertCopyEduApplyLicense(app_seq);
		ssaMapper.insertCopyEduApplyOverseas(app_seq);
		ssaMapper.insertCopyEduApplyFile(app_seq);

		logger.debug("특정 지원자의 결과 정보 수정 DAO 복사 종료");
	}
	
	/**
	 * @Method Name : selectSmpStudentUpdateForm
	 * @Date : 2018. 8. 23.
	 * @User : 여명환
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 해당 유저 지원서 정보 검색
	 */
	public HashMap<String, Object> selectSmpStudentUpdateForm(HashMap<String,Object> map) {
		logger.debug("selectSmpStudentUpdateForm DAO 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("selectSmpStudentUpdateForm DAO 종료");
		return ssaMapper.selectSmpStudentUpdateForm(map);
	}
	
	/**
	 * @Method Name : deleteSmpStudentForm
	 * @Date : 2018. 8. 23.
	 * @User : 여명환
	 * @Param : 학생정보 시퀀스
	 * @Return : -
	 * @Method 설명 : 해당 학생 정보를 삭제하는 DAO 함수 
	 */
	public void deleteSmpStudentForm(int smp_seq){
		logger.debug("모집홍보 특정 회원 정보 삭제 DAO 시작");

		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		ssaMapper.deleteSmpStudentForm(smp_seq);
		
		logger.debug("모집홍보 특정 회원 정보 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : smp_insert
	 * @Date : 2018. 8. 23.
	 * @User : 여명환
	 * @Param : 학생정보 정보
	 * @Return : -
	 * @Method 설명 : 학생 정보를 Mapper에 전달 
	 */
	public void smp_insert(SocietySmpStudentForm seaForm,SocietySmpStudentEduHistory seaEduHistory
			,SocietySmpStudentCareer seaCareer, SocietySmpStudentStudy seaStudy
			,SocietySmpStudentLanguage seaLanguage, SocietySmpStudentLicense seaLicense
			,SocietySmpStudentOverseas seaOverseas, SocietySmpStudentFile seaFile){
		
		logger.debug("학생정보 수정 DAO 시작");
		
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		ssaMapper.insertSmpStudentForm(seaForm);
		
		if(seaEduHistory.getEduHistoryList().size() != 0){
			ssaMapper.insertSmpStudentEduHistory(makeMap(seaEduHistory.getEduHistoryList(), seaForm.getSmp_seq(),seaForm.getApp_id()));
		}
		if(seaCareer.getCareerList().size() != 0){
			ssaMapper.insertSmpStudentCareer(makeMap(seaCareer.getCareerList(), seaForm.getSmp_seq(), seaForm.getApp_id()));
		}
		if(seaStudy.getStudyList().size() != 0){
			ssaMapper.insertSmpStudentStudy(makeMap(seaStudy.getStudyList(), seaForm.getSmp_seq(), seaForm.getApp_id()));
		}
		if(seaLanguage.getLanguageList().size() != 0){
			ssaMapper.insertSmpStudentLanguage(makeMap(seaLanguage.getLanguageList(), seaForm.getSmp_seq(), seaForm.getApp_id()));
		}
		if(seaLicense.getLicenseList().size() != 0){
			ssaMapper.insertSmpStudentLicense(makeMap(seaLicense.getLicenseList(), seaForm.getSmp_seq(), seaForm.getApp_id()));
		}
		if(seaOverseas.getOverseasList().size() != 0){
			ssaMapper.insertSmpStudentOverseas(makeMap(seaOverseas.getOverseasList(), seaForm.getSmp_seq(), seaForm.getApp_id()));
		}
		if(seaFile.getFileList().size() != 0){
			ssaMapper.insertSmpStudentFile(makeMap(seaFile.getFileList(), seaForm.getSmp_seq(), seaForm.getApp_id()));
		}
		
		logger.debug("학생정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : makeMap
	 * @Date : 2018. 8. 23.
	 * @User : 여명환
	 * @Param : 학생 정보 리스트, 학생 시퀀스 , 학생 아이디
	 * @Return : 입력받은 항목을 가진 맵 객체
	 * @Method 설명 : Mapper에 넘겨줄 맵 객체 생성 함수
	 */
	private <T>HashMap<String, Object> makeMap(List<T> list, int smp_seq, String app_id){
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("smp_seq", smp_seq);
		resultMap.put("list", list);
		resultMap.put("app_id", app_id);
		return resultMap;
	}
	
	
	/**
	 * @Method Name : selectAllSocietySmpSchedule
	 * @Date : 2018. 8. 24.
	 * @User : 박찬주
	 * @Param : 기수 시퀀스
	 * @Return : 특정 기수의 일정 리스트
	 * @Method 설명 : 특정 기수의 일정 리스트를 Mapper에 전달
	 */
	public List<SocietySmpScheduleScheduleColor> selectAllSocietySmpSchedule(int gisu_seq){
		logger.debug("특정 기수의 일정 리스트 조회하는 DAO 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("특정 기수의 일정 리스트 조회하는 DAO 종료");
		return ssaMapper.selectAllSocietySmpSchedule(gisu_seq);
	}
	
	/**
	 * @Method Name : deleteSocietySmpSchedule
	 * @Date : 2018. 8. 24.
	 * @User : 박찬주
	 * @Param : 일정 이벤트 시퀀스
	 * @Return : 삭제한 일정 이벤트 count
	 * @Method 설명 : 삭제한 일정 이벤트 count를 조회하는 DAO 함수
	 */
	public int deleteSocietySmpSchedule(int smp_sch_seq){
		logger.debug("특정 일정 이벤트 정보 삭제하는 DAO 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("특정 일정 이벤트 정보 삭제하는 DAO 종료");
		return ssaMapper.deleteSocietySmpSchedule(smp_sch_seq);
	}
	
	/**
	 * @Method Name : updateSocietySmpSchedule
	 * @Date : 2018. 8. 24.
	 * @User : 박찬주
	 * @Param : 일정 이벤트 객체
	 * @Return : 수정한 일정 이벤트 count
	 * @Method 설명 : 수정한 일정 이벤트 count를 조회하는 DAO 함수
	 */
	public int updateSocietySmpSchedule(SocietySmpScheduleScheduleColor sche){
		logger.debug("일정 이벤트 정보 업데이트하는 DAO 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("일정 이벤트 정보 업데이트하는 DAO 종료");
		return ssaMapper.updateSocietySmpSchedule(sche);
	}
	
	/**
	 * @Method Name : insertSocietySmpSchedule
	 * @Date : 2018. 8. 24.
	 * @User : 박찬주
	 * @Param : 일정 이벤트 객체
	 * @Return : 입력한 일정 이벤트 count
	 * @Method 설명 : 입력한 일정 이벤트 count를 조회하는 DAO 함수
	 */
	public int insertSocietySmpSchedule(SocietySmpScheduleScheduleColor sche){
		logger.debug("일정 이벤트 정보 입력하는 DAO 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("일정 이벤트 정보 입력하는 DAO 종료");
		return ssaMapper.insertSocietySmpSchedule(sche);
	}
	
	/**
	 * @Method Name : monthEventSelect
	 * @Date : 2018. 8. 24.
	 * @User : 박찬주
	 * @Param :일정 이벤트 객체
	 * @Return : 특정 기수의 월별 일정 이벤트 리스트
	 * @Method 설명 : 특정 기수의 월별 일정 리스트를 Mapper에 전달
	 */
	public List<SocietySmpScheduleScheduleColor> monthEventSelect(SocietySmpSchedule sche){
		logger.debug("월별 일정 이벤트 리스트 조회하는 DAO 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("월별 일정 이벤트 리스트 조회하는 DAO 종료");
		return ssaMapper.monthEventSelect(sche);
	}
	
	/**
	 * @Method Name : selectSocietySmpUserGisu
	 * @Date : 2018. 8.29
	 * @User : 박찬주
	 * @Param : 학생 아이디
	 * @Return : 특정 학생의 기수
	 * @Method 설명 : 특정 학생의 기수를 Mapper에 전달
	 */
	public SocietyEduAdminCurriculumGisu selectSocietySmpUserGisuNum(String app_id){
		logger.debug("특정 학생 기수를 조회하는 DAO 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("특정 학생 기수를 조회하는 DAO 종료");
		return ssaMapper.selectSocietySmpUserGisuNum(app_id);
	}
	
	/**
	 * @Method Name : selectGisuSeqNumList
	 * @Date : 2018. 8.30
	 * @User : 박찬주
	 * @Param : -
	 * @Return : smart cloud it마스터 과정의 전체 기수 리스트
	 * @Method 설명 : smart cloud it마스터 전체 기수를 Mapper에 전달
	 */
	public List<SocietyEduAdminCurriculumGisu> selectGisuSeqNumList(){
		logger.debug("smart cloud it마스터 전체 기수 조회하는 DAO 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("smart cloud it마스터 전체 기수 조회하는 DAO 종료");	
		return ssaMapper.selectGisuSeqNumList();
	}
	
	/**
	 * @Method Name : selectGisuNum
	 * @Date : 2018. 8.30
	 * @User : 박찬주
	 * @Param : 기수 시퀀스
	 * @Return : 기수 넘버
	 * @Method 설명 : 기수 시퀀스에 따른 기수 넘버 Mapper에 전달
	 */
	public int selectGisuNum(int gisu_seq){
		logger.debug("기수 시퀀스에 따른 기수 넘버 조회하는 DAO 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("기수 시퀀스에 따른 기수 넘버 조회하는 DAO 종료");	
		return ssaMapper.selectGisuNum(gisu_seq);
	}
	
	/**
	 * @Method Name : selectGisuNum
	 * @Date : 2018. 8.30
	 * @User : 박찬주
	 * @Param : 기수 시퀀스
	 * @Return : 기수 넘버
	 * @Method 설명 : 기수 시퀀스에 따른 기수 넘버 Mapper에 전달
	 */
	public List<SocietySmpScheduleColor> gisuTitleCheck(int gisu_seq){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.gisuTitleCheck(gisu_seq);
	}
	
	public int schColorInsert(List<SocietySmpScheduleColor> lssSchColor){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.schColorInsert(lssSchColor);
	}
	
	public int schColorUpdate(SocietySmpScheduleColor ssSchColor){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.schColorUpdate(ssSchColor);
	}
	
	public int schColorDelete(int smp_sch_color_seq){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.schColorDelete(smp_sch_color_seq);
	}
	
	/**
	 * @Method Name : smp_board_contents_insert
	 * @Date : 2018. 08. 28.
	 * @User : 전희배
	 * @Param : 게시글 세부 내용
	 * @Return : -
	 * @Method 설명 : 게시글을 등록하는 DAO 함수
	 */
	public void smp_board_contents_insert(BoardContent boardContent){
		logger.debug("게시글 세부 내용 등록 DAO 함수 시작");
		
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		 ssaMapper.smp_board_contents_insert(boardContent);
		
		logger.debug("게시글 세부 내용 등록 DAO 함수 종료");
		 
	}
	/**
	 * @Method Name : smp_select_admin_nm
	 * @Date : 2018. 08. 28.
	 * @User : 전희배
	 * @Param : admin_id
	 * @Return : admin_nm
	 * @Method 설명 :  
	 */
	public String smp_select_admin_nm(String admin_id){
		 		
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.smp_select_admin_nm(admin_id);
		 
	}
	
	/**
	 * @Method Name : smp_specific_user_gisu
	 * @Date : 2018. 08. 28.
	 * @User : 김진환
	 * @Param : 
	 * @Return : gisu_seq
	 * @Method 설명 :  
	 */
	public SocietyEduAdminCurriculumGisu get_specific_user_gisu(String id) {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		SocietyEduAdminCurriculumGisu seaCurGisu = ssaMapper.selectSocietySmpUserGisuNum(id);
		return seaCurGisu;
		
	}
	
	/**
	 * @Method Name : smp_board_contents_update
	 * @Date : 2018. 8. 30.
	 * @User : 전희배
	 * @Param : 게시글 세부 내용
	 * @Return : -
	 * @Method 설명 : 게시글을 수정하는 DAO 함수 
	 */
	public void smp_board_contents_update(BoardContent boardContent){
		logger.debug("게시글 세부 내용 수정 DAO 함수 시작");
		
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		ssaMapper.smp_board_contents_update(boardContent);
		
		logger.debug("게시글 세부 내용 수정 DAO 함수 종료");
	}
	/**
	 * @Method Name : smp_select_print_student
	 * @Date : 2018. 8. 30.
	 * @User : 여명환
	 * @Param : 학생ID
	 * @Return : -
	 * @Method 설명 : 프린트 하기위해 학생의 필요정보 조회 
	 */
	public HashMap<String, Object> smp_select_print_student(String app_id){
		logger.debug("게시글 세부 내용 수정 DAO 함수 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("게시글 세부 내용 수정 DAO 함수 종료");
		return ssaMapper.smp_select_print_student(app_id);
	}
	
	/**
	 * @Method Name : smp_copy_studentinfo
	 * @Date : 2018. 08. 21.
	 * @User : 여명환
	 * @Param : 기수 시퀀스, 검색어
	 * @Return : 해당 기수의 신청자 정보 count
	 * @Method 설명 : 특정 기수의 신청자 정보count를 조회하는 DAO 함수
	 */
	public int smp_check_student(SocietyEduApplyForm sf) {
		logger.debug("최종합격자 존재여부");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		int result = ssaMapper.smp_check_student(sf);

		return result;
	}
	
 
	/**
	 * @Method Name : board_gisu_search
	 * @Date : 2018. 09. 04.
	 * @User : 전희배
	 * @Param : 기수이름
	 * @Return : board_seq, board_nm
	 * @Method 설명 : 해당 기수이름의 게시판정보 조회하는 DAO 함수
	 */
	public ArrayList<HashMap<String, Object>> board_gisu_search() {
		logger.debug("해당 기수이름의 게시판정보");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		
		ArrayList<HashMap<String, Object>> result = ssaMapper.board_gisu_search();

		return result;
	}
	
	/**
	 * @Method Name : smpBoardListAll
	 * @Date : 2018. 09. 04.
	 * @User : 전희배
	 * @Param :  
	 * @Return : 
	 * @Method 설명 :  게시물불러오는 DAO 함수
	 */
	
	public List<HashMap<String, Object>> smpBoardListAll(RowBounds rb,HashMap<String, Object> param){
		logger.debug("게시물불러오는 DAO 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		List<HashMap<String, Object>> result=ssaMapper.smpBoardListAll(rb,param);
		logger.debug("게시물불러오는 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name :gettotal
	 * @Date : 2018. 09. 04.
	 * @User : 전희배
	 * @Param :  
	 * @Return :  
	 * @Method 설명 : 게시물 개수 조회 DAO
	 */
	
	public int gettotal(HashMap<String, Object> param){
		logger.debug("게시물 개수 조회 DAO 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		int result=ssaMapper.gettotal(param);
		logger.debug("게시물 개수 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name :insertBoardGisu
	 * @Date : 2018. 09. 04.
	 * @User : 전희배
	 * @Param :  
	 * @Return :  
	 * @Method 설명 : 게시판 기수 등록 DAO
	 */
	
	public void insertBoardGisu(HashMap<String, Object> param){
		logger.debug("게시판 기수 등록 DAO 시작");

		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		 ssaMapper.insertBoardGisu(param);
		logger.debug("게시판 기수 등록 DAO 종료");
		 
	}
	/**
	 * @Method Name : smpMainBoardListAll
	 * @Date : 2018. 09. 05.
	 * @User : 전희배
	 * @Param :  
	 * @Return : 
	 * @Method 설명 :  
	 */
	
	public List<HashMap<String, Object>> smpMainBoardListAll(HashMap<String, Object> param){
		logger.debug("게시판이미지 아이템 가져오는 DAO 시작");

		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		List<HashMap<String, Object>> result=ssaMapper.smpMainBoardListAll(param);
		
		
		logger.debug("게시판이미지 아이템 가져오는 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : smp_board_delete
	 * @Date : 2018. 09. 05.
	 * @User : 여명환
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 공지삭제
	 */
	public void smp_board_delete(int board_content_seq) {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		ssaMapper.smp_board_gisu_delete(board_content_seq);
		ssaMapper.board_contents_file_delete(board_content_seq);
		ssaMapper.smp_board_contents_delete(board_content_seq);
	}
	
	/**
	 * @Method Name : smp_board_delete
	 * @Date : 2018. 09. 05.
	 * @User : 여명환
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 공지삭제
	 */
	public ArrayList<BoardContent> selectMainPageBoard(int gisu_seq) {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.selectMainPageBoard(gisu_seq);		
	}	
	
	/**
	 * @Method Name : selectSmpNumberOfStudent
	 * @Date : 2018. 09. 05.
	 * @User : 여명환
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int selectSmpNumberOfStudent() {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.selectSmpNumberOfStudent();		
	}
	
	/**
	 * @Method Name : smp_insert_memo
	 * @Date : 2018. 09. 07.
	 * @User : 여명환
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 학적부 메모 삽입
	 */
	public void smp_insert_memo(HashMap<String, Object> memo) {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		ssaMapper.smp_insert_memo(memo);
	}
	/**
	 * @Method Name : selectSmpNumberOfStudent
	 * @Date : 2018. 09. 07.
	 * @User : 여명환
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 학적부 메모 삽입
	 */
	public String smp_select_memo(String memo) {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.smp_select_memo(memo);
	}
	
	/**
	 * @Method Name : selectApsTotalNm
	 * @Date : 2018. 09. 10.
	 * @User : 전희배
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 평가종합 시퀀스, 이름 select
	 */
	public List<HashMap<String, Object>> selectApsTotalNm(int gisu_seq) {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.selectApsTotalNm(gisu_seq);
	}
	
	/**
	 * @Method Name : selectApsGroupNm
	 * @Date : 2018. 09. 10.
	 * @User : 전희배
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 평가그룹 시퀀스, 이름 select
	 */
	public List<HashMap<String, Object>> selectApsGroupNm(int smp_aps_total_seq) {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.selectApsGroupNm(smp_aps_total_seq);
	}
	
	/**
	 * @Method Name : selectApsDetailNm
	 * @Date : 2018. 09. 10.
	 * @User : 전희배
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 평가상세 시퀀스, 이름 select
	 */
	public List<HashMap<String, Object>> selectApsDetailNm(int smp_aps_group_seq) {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.selectApsDetailNm(smp_aps_group_seq);
	}
	
	

	/**
	 * @Method Name : getApsTotal
	 * @Date : 2018. 09. 10.
	 * @User : 여명환
	 * @Param : 
	 * @Return : ApsTotal정보 
	 * @Method 설명 : 종합평가 정보 리턴
	 */
	public ArrayList<String> getApsTotal() {
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		ArrayList<String> result = seaMapper.getApsTotal();
		return result;
	}
	
	/**
	 * @Method Name : getApsGroup
	 * @Date : 2018. 09. 10.
	 * @User : 여명환
	 * @Param : 
	 * @Return : ApsGroup 정보
	 * @Method 설명 : 그룹평가 정보 리턴
	 */
	/*public ArrayList<String> getApsGroup() {
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		ArrayList<String> result = seaMapper.getApsGroup();
		return result;
	}*/
	
	/**
	 * @Method Name : getApsDetail
	 * @Date : 2018. 09. 10.
	 * @User : 여명환
	 * @Param : 
	 * @Return : ApsDetail 정보
	 * @Method 설명 : 개별평가 정보 리턴
	 */
	public ArrayList<String> getApsDetail() {
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		ArrayList<String> result = seaMapper.getApsDetail();
		return result;
	}
	

	/**
	 * @Method Name : selectGisuNumberOfTotal
	 * @Date : 2018. 09. 11.
	 * @User : 여명환
	 * @Param : 
	 * @Return : 종합평가 기수별 수 정보
	 * @Method 설명 : 개별평가 정보 리턴
	 */
	public int selectGisuNumberOfTotal(int gisu_seq) {
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		int result = seaMapper.selectGisuNumberOfTotal(gisu_seq);
		return result;
	}
	/**
	 * @Method Name : selectGisuNumberOfGroup
	 * @Date : 2018. 09. 11.
	 * @User : 여명환
	 * @Param : 
	 * @Return : 그룹평가 기수별 수 정보
	 * @Method 설명 : 개별평가 정보 리턴
	 */
	public int selectGisuNumberOfGroup(String gisu_seq) {
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		int result = seaMapper.selectGisuNumberOfGroup(gisu_seq);
		return result;
	}
	/**
	 * @Method Name : selectGisuNumberOfDetail
	 * @Date : 2018. 09. 11.
	 * @User : 여명환
	 * @Param : 
	 * @Return : 개별평가 기수별 수 정보
	 * @Method 설명 : 개별평가 정보 리턴
	 */
	public int selectGisuNumberOfDetail(String gisu_seq) {
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		int result = seaMapper.selectGisuNumberOfDetail(gisu_seq);
		return result;
	}
	/**
	 * @Method Name : selectAPSTotal
	 * @Date : 2018. 09. 11.
	 * @User : 여명환
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 학적부 메모 삽입
	 */
	public ArrayList<HashMap<String, Object>> selectAPSTotal(int gisu_seq) {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.selectAPSTotal(gisu_seq);
	}
	
	/**
	 * @Method Name : selectAPSDetail
	 * @Date : 2018. 09. 11.
	 * @User : 여명환
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 학적부 메모 삽입
	 */
	/*public ArrayList<HashMap<String, Object>> selectAPSDetail(HashMap<String, Object> map) {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.selectAPSDetail(map);
	}*/
	/**
	 * @Method Name : deleteTotal
	 * @Date : 2018. 09. 11.
	 * @User : 여명환
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 종합평가 정보 삭제
	 */
	public void deleteTotal(String smp_aps_total_seq) {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		ssaMapper.deleteTotal(smp_aps_total_seq);
	}
	/**
	 * @Method Name : deleteGroup
	 * @Date : 2018. 09. 11.
	 * @User : 여명환
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 그룹평가 정보 삭제
	 */
	public void deleteGroup(String smp_aps_group_seq) {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		ssaMapper.deleteGroup(smp_aps_group_seq);
	}
	/**
	 * @Method Name : deleteDetail
	 * @Date : 2018. 09. 11.
	 * @User : 여명환
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 종합평가 정보 삭제
	 */
	public void deleteDetail(String smp_aps_detail_seq) {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		ssaMapper.deleteDetail(smp_aps_detail_seq);
	}
	
	
	/**
	 * @Method Name : insertSmpApsTotal
	 * @Date : 2018. 09. 11.
	 * @User : 강인석
	 * @Param :
	 * @Return :
	 * @Method 설명 : 평가항목 전체 입력
	 */
	
	public void insertSmpApsTotal(HashMap<String, Object> param) {
		logger.debug("평가항목 전체 입력 DAO 시작");
		
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		ssaMapper.insertSmpApsTotal(param);
		logger.debug("평가항목 전체 입력 DAO 종료" );
	}
	
	/**
	 * @Method Name : insertSmpApsGroup
	 * @Date : 2019. 01. 17.
	 * @User : 김홍일
	 * @Param :
	 * @Return :
	 * @Method 설명 : 평가항목 그룹 타입 입력
	 */
	
	public void insertSmpApsGroup(SocietySmpApsGroup societySmpApsGroup) {
		logger.debug("평가항목 그룹 입력 DAO 시작");
		
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		ssaMapper.insertSmpApsGroup(societySmpApsGroup);
		logger.debug("평가항목 그룹 입력 DAO 종료");
	}
	
	/**
	 * @Method Name : selectAPSGroup
	 * @Date : 2019. 02. 21.
	 * @User : 김홍일
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 기수 값에 따른 그룹평가 리스트 전체 
	 */
	public ArrayList<HashMap<String, Object>> selectAPSGroup(int gisu_seq) {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.selectAPSGroup(gisu_seq);
	}
	
	/**
	 * @Method Name : selectAPSDetail
	 * @Date : 2019. 02. 28.
	 * @User : 김홍일
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 종합평가 값에 따른 상세평가 리스트 전체 
	 */
	public ArrayList<HashMap<String, Object>> selectAPSDetail(int smp_aps_total_seq) {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.selectAPSDetail(smp_aps_total_seq);
	}
	
	/**
	 * @Method Name : insertSmpApsGroupExam
	 * @Date : 2019. 01. 17.
	 * @User : 김홍일
	 * @Param :
	 * @Return :
	 * @Method 설명 : 평가항목 정규시험 그룹 입력
	 */
	
	public void insertSmpApsGroupExam(SocietySmpApsGroupExam societySmpApsGroupExam){
		logger.debug("평가항목 그룹 정규시험 입력 DAO 시작");
		
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		ssaMapper.insertSmpApsGroupExam(societySmpApsGroupExam);
		logger.debug("평가항목 그룹 정규시험 입력 DAO 종료");
	}
	
	/**
	 * @Method Name : insertSmpApsGroupSubexam
	 * @Date : 2019. 01. 18.
	 * @User : 김홍일
	 * @Param :
	 * @Return :
	 * @Method 설명 : 평가항목 과목평가 그룹 입력
	 */
	
	public void insertSmpApsGroupSubexam(SocietySmpApsGroupSubexam societySmpApsGroupSubexam){
		logger.debug("평가항목 그룹  과목평가 입력 DAO 시작");
		
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		ssaMapper.insertSmpApsGroupSubexam(societySmpApsGroupSubexam);
		logger.debug("평가항목 그룹 과목평가 입력 DAO 종료");
	}
	
	/**
	 * @Method Name : insertSmpApsGroupSubexam
	 * @Date : 2019. 01. 18.
	 * @User : 김홍일
	 * @Param :
	 * @Return :
	 * @Method 설명 : 평가항목 개별점수 및 확인서 그룹 입력
	 */
	
	public void insertSmpApsGroupConfirmation(SocietySmpApsGroupConfirmation societySmpApsGroupConfirmation){
		logger.debug("평가항목 그룹 개별점수 및 확인서 입력 DAO 시작");
		
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		ssaMapper.insertSmpApsGroupConfirmation(societySmpApsGroupConfirmation);
		logger.debug("평가항목 그룹 개별점수 및 확인서 입력 DAO 종료");
	}
	
	/**
	 * @Method Name : insertSmpApsDetail
	 * @Date : 2018. 09. 11.
	 * @User : 강인석
	 * @Param :
	 * @Return :
	 * @Method 설명 : 평가항목 세부 입력
	 */
	
	public void insertApsDetail(HashMap<String, Object>param) {
		logger.debug("평가항목 세부 입력 DAO 시작");
		
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		ssaMapper.insertSmpApsDetail(param);
		logger.debug("평가항목 세부 입력 DAO 종료");
	}
	
	/**
	 * @Method Name : insertSmpApsDetailExam
	 * @Date : 2019. 02. 27.
	 * @User : 김홍일
	 * @Param :
	 * @Return :
	 * @Method 설명 : 평가항목 세부 입력
	 */
	
	public void insertSmpApsDetailExam(SocietySmpApsDetailExam societySmpApsDetailExam) {
		logger.debug("평가항목 상세 정규시험 입력 DAO 시작");
		
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		ssaMapper.insertSmpApsDetailExam(societySmpApsDetailExam);
		logger.debug("평가항목 상세 정규시험 입력 DAO 종료");
	}
	
	/**
	 * @Method Name : insertSmpApsDetailSubexam
	 * @Date : 2019. 02. 27.
	 * @User : 김홍일
	 * @Param :
	 * @Return :
	 * @Method 설명 : 평가항목 세부 입력
	 */
	
	public void insertSmpApsDetailSubexam(SocietySmpApsDetailSubexam societySmpApsDetailExam) {
		logger.debug("평가항목 상세 과목시험 입력 DAO 시작");
		
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		ssaMapper.insertSmpApsDetailSubexam(societySmpApsDetailExam);
		logger.debug("평가항목 상세 과목시험 입력 DAO 종료");
	}
	
	/**
	 * @Method Name : selectApsTotalDetail
	 * @Date : 2018. 09. 12.
	 * @User : 전희배
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 평가항목종합 상세 조회
	 */
	public HashMap<String, Object> selectApsTotalDetail(HashMap<String, Object> param) {
		logger.debug("평가항목종합 상세조회 DAO 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("평가항목종합 상세조회 DAO 종료");
		return ssaMapper.selectApsTotalDetail(param);
	}
	
	/**
	 * @Method Name : selectApsGroupDetail
	 * @Date : 2018. 09. 12.
	 * @User : 전희배
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 평가항목그룹 상세 조회
	 */
	public HashMap<String, Object> selectApsGroupDetail(HashMap<String, Object> param) {
		logger.debug("평가항목그룹 상세조회 DAO 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("평가항목그룹 상세조회 DAO 종료");
		return ssaMapper.selectApsGroupDetail(param);
	}
	
	/**
	 * @Method Name : selectApsDetailDetail
	 * @Date : 2018. 09. 12.
	 * @User : 전희배
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 평가항목종합 상세 조회
	 */
	public HashMap<String, Object> selectApsDetailDetail(HashMap<String, Object> param) {
		logger.debug("평가항목상세 상세조회 DAO 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("평가항목상세 상세조회 DAO 종료");
		return ssaMapper.selectApsDetailDetail(param);
	}
	
	/**
	 * @Method Name : updateApsTotal
	 * @Date : 2018. 09. 12.
	 * @User : 전희배
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 평가항목종합 수정
	 */
	public void updateApsTotal(HashMap<String, Object> param) {
		logger.debug("평가항목상세 수정 DAO 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("평가항목상세 수정 DAO 종료");
		ssaMapper.updateApsTotal(param);
	}
	/**
	 * @Method Name : updateApsGroup
	 * @Date : 2018. 09. 12.
	 * @User : 전희배
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 평가항목종합 수정
	 */
	public void updateApsGroup(HashMap<String, Object> param) {
		logger.debug("평가항목그룹 수정 DAO 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("평가항목그룹 수정 DAO 종료");
		ssaMapper.updateApsGroup(param);
	}
	/**
	 * @Method Name : updateApsDetail
	 * @Date : 2018. 09. 12.
	 * @User : 전희배
	 * @Param :  
	 * @Return : 
	 * @Method 설명 : 평가항목상세 수정
	 */
	public void updateApsDetail(HashMap<String, Object> param) {
		logger.debug("평가항목상세 수정 DAO 시작");
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("평가항목상세 수정 DAO 종료");
		ssaMapper.updateApsDetail(param);
	}
	
	/**
	 * @Method Name : selectSmpApsSetList
	 * @Date : 2018. 09. 11.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public List<SocietySmpApsSetList> selectSmpApsSetList() {
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return seaMapper.selectSmpApsSetList();
	}
	
	/**
	 * @Method Name : deleteSmpApsTotal
	 * @Date : 2018. 09. 13.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int deleteSmpApsTotal(int gisu_seq) {
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return seaMapper.deleteSmpApsTotal(gisu_seq);
	}
	
	/**
	 * @Method Name : selectSmpApsSetTotal
	 * @Date : 2018. 09. 13.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public List<SocietySmpApsSetTotal> selectSmpApsSetTotal(int smp_aps_setlist_seq) {
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return seaMapper.selectSmpApsSetTotal(smp_aps_setlist_seq);
	}
	
	/**
	 * @Method Name : selectSmpApsSetGroup
	 * @Date : 2018. 09. 13.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public List<SocietySmpApsSetGroup> selectSmpApsSetGroup(int smp_aps_settotal_seq) {
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return seaMapper.selectSmpApsSetGroup(smp_aps_settotal_seq);
	}
	
	/**
	 * @Method Name : selectSmpApsSetDetail
	 * @Date : 2018. 09. 13.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public List<SocietySmpApsSetDetail> selectSmpApsSetDetail(int smp_aps_setgroup_seq) {
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return seaMapper.selectSmpApsSetDetail(smp_aps_setgroup_seq);
	}
	
	/**
	 * @Method Name : insertApsTotalSetting
	 * @Date : 2018. 09. 13.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public void insertApsTotalSetting(SocietySmpApsTotal total) {
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		seaMapper.insertApsTotalSetting(total);
	}
	
	/**
	 * @Method Name : insertApsGroupSetting
	 * @Date : 2018. 09. 14.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public void insertApsGroupSetting(SocietySmpApsGroup group) {
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		seaMapper.insertApsGroupSetting(group);
	}
	
	/**
	 * @Method Name : insertApsDetailSetting
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public void insertApsDetailSetting(SocietySmpApsDetail detail) {
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		seaMapper.insertApsDetailSetting(detail);
	}
	
	/**
	 * @Method Name : selectApsTotalListByGisuSeq
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public List<SocietySmpApsTotal> selectApsTotalListByGisuSeq(int gisu_seq) {
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return seaMapper.selectApsTotalListByGisuSeq(gisu_seq);
	}
	
	/**
	 * @Method Name : selectApsGroupList
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	/*public List<SocietySmpApsGroup> selectApsGroupList(int smp_aps_total_seq) {
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return seaMapper.selectApsGroupList(smp_aps_total_seq);
	}*/
	
	/**
	 * @Method Name : selectApsGroupList
	 * @Date : 2019. 02. 13.
	 * @User : 김홍일
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public ArrayList<HashMap<String, Object>> selectApsGroupList(HashMap<String, Object> params) {
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return seaMapper.selectApsGroupList(params);
	}
	
	/**
	 * @Method Name : selectApsDetailList
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public List<SocietySmpApsDetail> selectApsDetailList(int smp_aps_group_seq) {
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return seaMapper.selectApsDetailList(smp_aps_group_seq);
	}

	/**
	 * @Method Name : insertApsSetList
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int insertApsSetList(SocietySmpApsSetList SMPApsSetList){
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return seaMapper.insertApsSetList(SMPApsSetList);
	}
	
	/**
	 * @Method Name : insertApsSetTotal
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int insertApsSetTotal(SocietySmpApsSetTotal SMPApsSetTotal){
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return seaMapper.insertApsSetTotal(SMPApsSetTotal);
	}
	
	/**
	 * @Method Name : insertApsSetGroup
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int insertApsSetGroup(SocietySmpApsSetGroup SMPApsSetGroup){
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return seaMapper.insertApsSetGroup(SMPApsSetGroup);
	}
	
	/**
	 * @Method Name : insertApsSetDetail
	 * @Date : 2018. 09. 16.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int insertApsSetDetail(SocietySmpApsSetDetail SMPApsSetDetail){
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return seaMapper.insertApsSetDetail(SMPApsSetDetail);
	}
	
	
	
	public List<SocietySmpApsSetTotal> selectSmpApsSetTotal() {
		SocietySmpAdminMapper seaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return seaMapper.selectSetTotal();
	}
	
	
	
	/**
	 * @Method Name : selectTotalOverlap
	 * @Date : 2018. 09. 14.
	 * @User : 전희배
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 평가항목 total 이름 중복 체크
	 */
	public List<String> selectTotalOverlap(HashMap<String, Object> param){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("평가항목 total 이름 중복 체크 DAO");
		return ssaMapper.selectTotalOverlap(param);		
	};
	
	/**
	 * @Method Name : selectGroupOverlap
	 * @Date : 2018. 09. 14.
	 * @User : 전희배
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 평가항목 group 이름 중복 체크
	 */
	public List<String> selectGroupOverlap(HashMap<String, Object> param){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("평가항목 group 이름 중복 체크 DAO");
		return ssaMapper.selectGroupOverlap(param);		
	};
	
	/**
	 * @Method Name : selectDetailOverlap
	 * @Date : 2018. 09. 14.
	 * @User : 전희배
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 평가항목 detail 이름 중복 체크
	 */
	public List<String> selectDetailOverlap(HashMap<String, Object> param){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug("평가항목 detail 이름 중복 체크 DAO");
		return ssaMapper.selectDetailOverlap(param);		
	};
	/**
	 * @Method Name : sumTotalRatio
	 * @Date : 2018. 09. 15.
	 * @User : 전희배
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 평가항목 total 비율 합계
	 */
	public int sumTotalRatio(HashMap<String, Object> param) {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug(" 평가항목 total 비율 합계 DAO");
		return ssaMapper.sumTotalRatio(param);	
	};
	/**
	 * @Method Name : sumGroupRatio
	 * @Date : 2018. 09. 16.
	 * @User : 전희배
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 평가항목 group 비율 합계
	 */
	public List<HashMap<String, Object>> sumGroupRatio(HashMap<String, Object> param) {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug(" 평가항목 group 비율 합계 DAO");
		return ssaMapper.sumGroupRatio(param);	
	};
	/**
	 * @Method Name : sumDetailRatio
	 * @Date : 2018. 09. 16.
	 * @User : 전희배
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 평가항목 detail 비율 합계
	 */
	/*public List<HashMap<String, Object>> sumDetailRatio(HashMap<String, Object> param) {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		logger.debug(" 평가항목 detial 비율 합계 DAO");
		return ssaMapper.sumDetailRatio(param);	
	};*/
	
	/**
	 * @Method Name : deleteSetList
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int deleteSetList(int smp_aps_setlist_seq) {
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.deleteSetList(smp_aps_setlist_seq);
	};
	
	/**
	 * @Method Name : deleteSetTotal
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int deleteSetTotal(int smp_aps_settotal_seq){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.deleteSetTotal(smp_aps_settotal_seq);
	}
	
	/**
	 * @Method Name : deleteSetGroup
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int deleteSetGroup(int smp_aps_setgroup_seq){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.deleteSetGroup(smp_aps_setgroup_seq);
	}	
	
	/**
	 * @Method Name : deleteSetDetail
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int deleteSetDetail(int smp_aps_setdetail_seq){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.deleteSetDetail(smp_aps_setdetail_seq);
	}
	
	/**
	 * @Method Name : selectSetTotal
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public SocietySmpApsSetTotal selectApsSetTotal(int smp_aps_settotal_seq){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.selectApsSetTotal(smp_aps_settotal_seq);
	}
	
	/**
	 * @Method Name : selectSetGroup
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public SocietySmpApsSetGroup selectSetGroup(int smp_aps_setgroup_seq){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.selectSetGroup(smp_aps_setgroup_seq);
	}
	
	/**
	 * @Method Name : selectSetDetail
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public SocietySmpApsSetDetail selectSetDetail(int smp_aps_setdetail_seq){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.selectSetDetail(smp_aps_setdetail_seq);
	}
	
	/**
	 * @Method Name : updateSetTotal
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int updateSetTotal(SocietySmpApsSetTotal SMPApsSetTotal){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.updateSetTotal(SMPApsSetTotal);
		
	}
	
	/**
	 * @Method Name : updateSetGroup
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int updateSetGroup(SocietySmpApsSetGroup SMPApsSetGroup){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.updateSetGroup(SMPApsSetGroup);
	}
	
	/**
	 * @Method Name :updateSetDetail
	 * @Date : 2018. 09. 18.
	 * @User : 박찬주
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int updateSetDetail(SocietySmpApsSetDetail SMPApsSetDetail){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		return ssaMapper.updateSetDetail(SMPApsSetDetail);
	}
	
	/**
	 * 
	 * @Method Name : selectBoardGisuSeq
	 * @Date : 2018. 12. 3.
	 * @User : 원병호
	 * @Param : board_content_seq 
	 * @Return : gisu_seq
	 * @Method 설명 : 게시판 번호로 기수를 찾는 메소드
	 */
	public int selectBoardGisuSeq(int board_content_seq){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		int gisu_seq = ssaMapper.selectBoardGisuSeq(board_content_seq);
		return gisu_seq;
	}
	
	/**
	 * @Method Name : select_board_detail2
	 * @Date : 2018. 12. 4.
	 * @User : 원병호
	 * @Param : board_content_seq
	 * @Return : hashMap<String,String>(key : gisu_crc_nm, board_content_imp)
	 * @Method 설명 : 게시판 상세보기(학사,기수별)에 필요한 정보중 com_board_content_tb에 없는 항목 가져오는 메소드
	 */
	public HashMap<String, String> select_board_detail2(int board_content_seq){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		HashMap<String, String> result = ssaMapper.select_board_detail2(board_content_seq);
		return result;
	}
	
	/** 
	 * @Method Name : update_board_pd
	 * @Date : 2018. 12. 6.
	 * @User : 원병호
	 * @Param : hashMap (board_seq, board_icon_pd)
	 * @Return : 
	 * @Method 설명 : 아이콘 갱신 표시기간 수정(board_icon_pd)
	 */
	public int update_board_pd(HashMap<String, Object> map){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		int result =  ssaMapper.update_board_pd(map);
		return result;
	}
	
	/**
	 * @Method Name : select_board_pd
	 * @Date : 2018. 12. 6.
	 * @User : Administrator
	 * @Param : board_seq
	 * @Return : board_icon_pd
	 * @Method 설명 : 해당 board_seq의 boardGroup의 아이콘갱신표시기간(board_icon_pd) return
	 */
	public int select_board_pd(int board_seq){
		SocietySmpAdminMapper ssaMapper = sqlSession.getMapper(SocietySmpAdminMapper.class);
		int board_icon_pd = ssaMapper.select_board_pd(board_seq);
		return board_icon_pd;
	}
	
}
