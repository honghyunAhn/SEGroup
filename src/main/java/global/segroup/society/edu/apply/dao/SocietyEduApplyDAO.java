/**
 * 
 */
package global.segroup.society.edu.apply.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.segroup.domain.FaqConsultingContents;
import global.segroup.domain.OfflineConsultingContents;
import global.segroup.domain.OnlineConsultingContents;
import global.segroup.domain.User;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculumGisu;
import global.segroup.society.edu.admin.domain.SocietyEduAdminPayment;
import global.segroup.society.edu.apply.domain.SocietyEduApplyCareer;
import global.segroup.society.edu.apply.domain.SocietyEduApplyEduHistory;
import global.segroup.society.edu.apply.domain.SocietyEduApplyFile;
import global.segroup.society.edu.apply.domain.SocietyEduApplyForm;
import global.segroup.society.edu.apply.domain.SocietyEduApplyLanguage;
import global.segroup.society.edu.apply.domain.SocietyEduApplyLicense;
import global.segroup.society.edu.apply.domain.SocietyEduApplyOverseas;
import global.segroup.society.edu.apply.domain.SocietyEduApplyStudy;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 31.
 * @Class 설명 : Soft Engineer Society 모집홍보 지원신청 DAO 
 * 
 */
@Repository
public class SocietyEduApplyDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyEduApplyDAO.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	/**
	 * @Method Name : apply_insert
	 * @Date : 2017. 8. 3.
	 * @User : 이종호
	 * @Param : 지원신청 정보
	 * @Return : -
	 * @Method 설명 : 지원신청 정보를 Mapper에 전달 
	 */
	public void apply_insert(SocietyEduApplyForm seaForm,SocietyEduApplyEduHistory seaEduHistory
			,SocietyEduApplyCareer seaCareer, SocietyEduApplyStudy seaStudy
			,SocietyEduApplyLanguage seaLanguage, SocietyEduApplyLicense seaLicense
			,SocietyEduApplyOverseas seaOverseas, SocietyEduApplyFile seaFile){
		
		logger.debug("모집홍보 지원신청 DAO 시작");
		
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		seaMapper.insertEduApplyForm(seaForm);
		
		if(seaEduHistory.getEduHistoryList().size() != 0){
			seaMapper.insertEduApplyEduHistory(makeMap(seaEduHistory.getEduHistoryList(), seaForm.getApp_seq(),seaForm.getApp_id()));
		}
		if(seaCareer.getCareerList().size() != 0){
			seaMapper.insertEduApplyCareer(makeMap(seaCareer.getCareerList(), seaForm.getApp_seq(), seaForm.getApp_id()));
		}
		if(seaStudy.getStudyList().size() != 0){
			seaMapper.insertEduApplyStudy(makeMap(seaStudy.getStudyList(), seaForm.getApp_seq(), seaForm.getApp_id()));
		}
		if(seaLanguage.getLanguageList().size() != 0){
			seaMapper.insertEduApplyLanguage(makeMap(seaLanguage.getLanguageList(), seaForm.getApp_seq(), seaForm.getApp_id()));
		}
		if(seaLicense.getLicenseList().size() != 0){
			seaMapper.insertEduApplyLicense(makeMap(seaLicense.getLicenseList(), seaForm.getApp_seq(), seaForm.getApp_id()));
		}
		if(seaOverseas.getOverseasList().size() != 0){
			seaMapper.insertEduApplyOverseas(makeMap(seaOverseas.getOverseasList(), seaForm.getApp_seq(), seaForm.getApp_id()));
		}
		if(seaFile.getFileList().size() != 0){
			seaMapper.insertEduApplyFile(makeMap(seaFile.getFileList(), seaForm.getApp_seq(), seaForm.getApp_id()));
		}
		
		seaMapper.insertEduApplyResult(seaForm.getApp_seq());
		
		logger.debug("모집홍보 지원신청 DAO 종료");
	}
	
	/**
	 * @Method Name : makeMap
	 * @Date : 2017. 8. 3.
	 * @User : 이종호
	 * @Param : 지원 신청 정보 리스트, 지원신청 시퀀스 , 지원신청자 아이디
	 * @Return : 입력받은 항목을 가진 맵 객체
	 * @Method 설명 : Mapper에 넘겨줄 맵 객체 생성 함수
	 */
	private <T>HashMap<String, Object> makeMap(List<T> list, int app_seq, String app_id){
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("app_seq", app_seq);
		resultMap.put("list", list);
		resultMap.put("app_id", app_id);
		return resultMap;
	}
	
	/**
	 * @param gisu_crc_class 
	 * @Method Name : selectLongTermList
	 * @Date : 2017. 8. 10.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 승인 된 장기 과정 기수 리스트 객체
	 * @Method 설명 : 승인 된 장기 과정 기수 리스트를 전달하는 DAO 함수
	 */
	// ArrayList<HashMap> -> 그냥 HashMap으로 수정; 2018. 10. 10. 김준영
	public HashMap<String, Object> selectLongTermList(String user_id, String gisu_crc_class, String division){
		logger.debug("모집홍보 승인 된 장기 과정 기수 리스트 검색 DAO 시작");
		
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		HashMap<String, Object> resultList = seaMapper.selectLongTermList(user_id, gisu_crc_class, division);
		
		logger.debug("모집홍보 승인 된 장기 과정 기수 리스트 검색 DAO 종료");
		return resultList;
	}
	
	/**
	 * @param gisu_crc_class 
	 * @Method Name : selectShortTermList
	 * @Date : 2017. 8. 10.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 승인 된 단기 과정 기수 리스트 객체
	 * @Method 설명 : 승인 된 단기 과정 기수 리스트를 전달하는 DAO 함수
	 */
	public ArrayList<HashMap<String, Object>> selectShortTermList(String user_id, String gisu_crc_class){
		logger.debug("모집홍보 승인 된 단기 과정 기수 리스트 검색 DAO 시작");
		
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		ArrayList<HashMap<String, Object>> resultList = seaMapper.selectShortTermList(user_id, gisu_crc_class);
		
		logger.debug("모집홍보 승인 된 단기 과정 기수 리스트 검색 DAO 종료");
		return resultList;
	}
	
	/**
	 * @param gisu_seq 
	 * @Method Name : selectShortTermPayInfo
	 * @Date : 2018. 12. 12.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 승인 된 단기 과정 결제정보 
	 * @Method 설명 : 승인 된 장기 과정 결제정보 전달하는 DAO 함수
	 */	
	public SocietyEduAdminPayment selectShortTermPayInfo(String gisu_seq) {
		logger.debug("모집홍보 승인 된 단기 과정 결제정보 검색 DAO 시작");
		
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		SocietyEduAdminPayment payment = seaMapper.selectShortTermPayInfo(gisu_seq);
		
		logger.debug("모집홍보 승인 된 단기 과정 결제정보 검색 DAO 종료");
		
		return payment;
	}
	
	/**
	 * @Method Name : selectShortTermList
	 * @Date : 2017. 8. 10.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 승인 된 장기 과정 기수 리스트 객체
	 * @Method 설명 : 승인 된 장기 과정 기수 리스트를 전달하는 DAO 함수
	 */
	public ArrayList<HashMap<String, Object>> selectShortTermInfo(String gisu_crc_class){
		logger.debug("모집홍보 승인 된 장기 과정 기수 리스트 검색 DAO 시작");
		
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		ArrayList<HashMap<String, Object>> resultList = seaMapper.selectShortTermInfo(gisu_crc_class);
		
		logger.debug("모집홍보 승인 된 장기 과정 기수 리스트 검색 DAO 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : selectImageNoticeList
	 * @Date : 2017. 11. 10.
	 * @User : 전상수
	 * @Param : -
	 * @Return : 이미지 게시판 내용 리스트 객체
	 * @Method 설명 : 이미지 게시판 내용 리스트를 전달하는 DAO 함수
	 */
	public ArrayList<HashMap<String, Object>> selectImageNoticeList(String user_id){
		logger.debug("이미지 게시판 내용 리스트 검색 DAO 시작");
		
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		ArrayList<HashMap<String, Object>> resultList = seaMapper.selectImageNoticeList(user_id);
		
		logger.debug("이미지 게시판 내용 리스트 검색 DAO 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : selectEduApplyResult
	 * @Date : 2017. 8. 10.
	 * @User : 이종호
	 * @Param : 회원 아이디와 기수 시퀀스 정보를 가진 맵 객체
	 * @Return : 해당 파람값의 결과를 담은 맵 객체
	 * @Method 설명 : 해당 아이디와 기수 정보를 가진 객체의 유/무를 판단하는 DAO 함수
	 */
	public HashMap<String, Object> selectEduApplyResult(HashMap<String, Object> param){
		logger.debug("모집홍보 지원 내역 조회 DAO 시작");
		
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		HashMap<String, Object> resultMap = seaMapper.selectEduApplyResult(param);
		
		logger.debug("모집홍보 지원 내역 조회 DAO 종료");
		return resultMap;
	}
	
	/**
	 * @Method Name : selectEduApply
	 * @Date : 2017. 8. 16.
	 * @User : 이종호
	 * @Param : 회원 아이디와 기수 시퀀스 정보를 가진 맵 객체
	 * @Return : 해당 파람값의 결과를 담은 맵 객체
	 * @Method 설명 : 해당 아이디와 기수 정보를 가진 지원 신청 전체 정보를 조회하는 DAO 함수
	 */
	public HashMap<String, Object> selectEduApply(HashMap<String, Object> param){
		logger.debug("모집홍보 특정 회원 정보 조회 DAO 시작");
		
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		
		logger.debug("모집홍보 특정 회원 정보 조회 DAO 종료");
		return seaMapper.selectEduApply(param);
	}
	
	/**
	 * @Method Name : deleteEduApplyForm
	 * @Date : 2017. 8. 16.
	 * @User : 이종호
	 * @Param : 지원신청서 시퀀스
	 * @Return : -
	 * @Method 설명 : 해당 지원신청서 정보를 삭제하는 DAO 함수 
	 */
	public void deleteEduApplyForm(HashMap<String, Object> param){
		logger.debug("모집홍보 특정 회원 정보 삭제 DAO 시작");

		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		seaMapper.deleteEduApplyForm(param);
		
		logger.debug("모집홍보 특정 회원 정보 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : countBoard
	 * @Date : 2017. 11. 14.
	 * @User : 전상수
	 * @Param : 검색어옵션, 검색어
	 * @Return : 페이지수
	 * @Method 설명 : 게시판의 현재페이지의 아이템갯수를 가져오는 DAO 함수 
	 */
	public int countBoard(HashMap<String, Object> param){
		logger.debug("게시판이미지 아이템갯수 가져오는 DAO 시작");

		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		
		int count=seaMapper.countBoard(param);
		
		logger.debug("게시판이미지 아이템갯수 가져오는 DAO 종료");
		return count;
	}
	
	/**
	 * @Method Name : boardListAll
	 * @Date : 2017. 11. 14.
	 * @User : 전상수
	 * @Param : 첫페이지,끝페이지,검색어옵션,검색어
	 * @Return : 페이지수
	 * @Method 설명 : 게시판의 현재페이지의 아이템갯수를 가져오는 DAO 함수 
	 */
	
	public List<HashMap<String, Object>> boardListAll(HashMap<String, Object> param){
		logger.debug("게시판이미지 아이템 가져오는 DAO 시작");

		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		List<HashMap<String, Object>> result=seaMapper.boardListAll(param);
		
		
		logger.debug("게시판이미지 아이템 가져오는 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : boardDetail
	 * @Date : 2017. 11. 14.
	 * @User : 전상수
	 * @Param : 첫페이지,끝페이지,검색어옵션,검색어
	 * @Return : 페이지수
	 * @Method 설명 : 게시판의 현재페이지의 아이템갯수를 가져오는 DAO 함수 
	 */
	
	public HashMap<String, Object> boardDetail(HashMap<String, Object> param){
		logger.debug("게시판이미지 내용아이템 가져오는 DAO 시작");

		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		HashMap<String, Object> result=seaMapper.boardDetail(param);
		
		
		logger.debug("게시판이미지 내용아이템 가져오는 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : boardHit
	 * @Date : 2017. 11. 14.
	 * @User : 김도훈
	 * @Param : 조회수
	 * @Return : 조회수 증가
	 * @Method 설명 : 게시판 읽기시 조회수를 증가시켜 주는 DAO 함수 
	 */
	public void boardHit(int board_content_hit){
		logger.debug("온라인상담 게시글 세부 내용 중 조회수 증가 DAO 함수 시작");
		
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		seaMapper.boardHit(board_content_hit);
		
		logger.debug("온라인상담 게시글 세부 내용 중 조회수 증가 DAO 함수 종료");
	}
	
	/**
	 * @Method Name : boardFile
	 * @Date : 2017. 11. 14.
	 * @User : 전상수
	 * @Param : 첫페이지,끝페이지,검색어옵션,검색어
	 * @Return : 페이지수
	 * @Method 설명 : 게시판의 현재페이지의 아이템갯수를 가져오는 DAO 함수 
	 */
	
	public ArrayList<HashMap<String, Object>> boardFile(HashMap<String, Object> param){
		logger.debug("게시판이미지  첨부파일 가져오는 DAO 시작");

		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		ArrayList<HashMap<String, Object>> result=seaMapper.boardFile(param);
		
		
		logger.debug("게시판이미지 첨부파일 가져오는 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : boardFileDetail
	 * @Date : 2017. 11. 14.
	 * @User : 전상수
	 * @Param : 파일DB 시퀀스
	 * @Return : 해당파일정보
	 * @Method 설명 : 해당파일정보를 가져오는 DAO 함수 
	 */
	
	public HashMap<String, Object> boardFileDetail(HashMap<String, Object> param){
		logger.debug("게시판이미지  첨부파일 가져오는 DAO 시작");
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		HashMap<String, Object> result=seaMapper.boardFileDetail(param);
		
		logger.debug("게시판이미지 첨부파일 가져오는 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : deleteUserInfo
	 * @Date : 2018. 7. 10.
	 * @User : 김지훈
	 * @Param : 삭제할 회원 정보 객체
	 * @Return : -
	 * @Method 설명 : 작성지원서테이블에서 탈퇴할 회원의 개인정보를 삭제하는 DAO 함수
	 */
	public int user_delete(User user){
		logger.debug("회원 정보 수정 DAO 시작");

		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
			
		// 작성지원서테이블에서 탈퇴할 회원의 개인정보를 삭제(임의의값으로 수정) 
		int dataRemoveMasterApplyCount = seaMapper.deleteUserDataRemoveMasterApply(user);
		System.out.println("dataRemoveMasterApplyCount : " + dataRemoveMasterApplyCount);
		
		logger.debug("회원 정보 수정 DAO 종료");
		return dataRemoveMasterApplyCount;
	}
	
	/**
	 * @Method Name : faq_consulting_countBoard
	 * @Date : 2018. 7. 26.
	 * @User : 김도훈
	 * @Param : 검색어옵션, 검색어
	 * @Return : 페이지수
	 * @Method 설명 : FAQ 상담 게시판 현재페이지의 아이템갯수를 가져오는 DAO 함수 (단, 게시판별로 구분은 되어있다) 
	 */
	public int faq_consulting_countBoard(HashMap<String, Object> param){
		logger.debug("FAQ 상담 게시판 아이템갯수 가져오는 DAO 시작");

		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		
		int count=seaMapper.faq_consulting_countBoard(param);
		
		logger.debug("FAQ 상담 게시판 아이템갯수 가져오는 DAO 종료");
		return count;
	}
	
	/**
	 * @Method Name : faq_consulting_boardListAll
	 * @Date : 2018. 7. 26.
	 * @User : 김도훈
	 * @Param : 첫페이지,끝페이지,검색어옵션,검색어
	 * @Return : 페이지수
	 * @Method 설명 : FAQ 상담 게시판의 모든페이지의 아이템갯수를 가져오는 DAO 함수
	 */
	public List<HashMap<String, Object>> faq_consulting_boardListAll(HashMap<String, Object> param){
		logger.debug("FAQ 상담 게시판 모든 아이템 가져오는 DAO 시작");

		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		List<HashMap<String, Object>> result=seaMapper.faq_consulting_boardListAll(param);
		
		
		logger.debug("FAQ 상담 게시판 모든 아이템 가져오는 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : online_consulting_countBoard
	 * @Date : 2018. 7. 26.
	 * @User : 김도훈
	 * @Param : 검색어옵션, 검색어
	 * @Return : 페이지수
	 * @Method 설명 : 온라인 상담 게시판 현재페이지의 아이템갯수를 가져오는 DAO 함수 (단, 게시판별로 구분은 되어있다) 
	 */
	public int online_consulting_countBoard(HashMap<String, Object> param){
		logger.debug("온라인 상담 게시판 아이템갯수 가져오는 DAO 시작");

		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		
		int count=seaMapper.online_consulting_countBoard(param);
		
		logger.debug("온라인 상담 게시판 아이템갯수 가져오는 DAO 종료");
		return count;
	}
	
	/**
	 * @Method Name : online_consulting_boardListAll
	 * @Date : 2018. 7. 26.
	 * @User : 김도훈
	 * @Param : 첫페이지,끝페이지,검색어옵션,검색어
	 * @Return : 페이지수
	 * @Method 설명 : 온라인 상담 게시판의 모든페이지의 아이템갯수를 가져오는 DAO 함수
	 */
	public List<HashMap<String, Object>> online_consulting_boardListAll(HashMap<String, Object> param){
		logger.debug("온라인 상담 게시판 모든 아이템 가져오는 DAO 시작");

		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		List<HashMap<String, Object>> result=seaMapper.online_consulting_boardListAll(param);
		
		
		logger.debug("온라인 상담 게시판 모든 아이템 가져오는 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : online_consulting_boardDetail
	 * @Date : 2018. 7. 26.
	 * @User : 김도훈
	 * @Param : 첫페이지,끝페이지,검색어옵션,검색어
	 * @Return : 페이지수
	 * @Method 설명 : 온라인 상담 게시판 상세내용을 가져오는 DAO 함수 (FAQ에서는 미사용) 
	 */
	public HashMap<String, Object> online_consulting_boardDetail(HashMap<String, Object> param){
		logger.debug("온라인 상담 게시판 상세내용을 가져오는 DAO 시작");

		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		HashMap<String, Object> result=seaMapper.online_consulting_boardDetail(param);
		
		
		logger.debug("온라인 상담 게시판 상세내용을 가져오는 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : online_consulting_hit_update
	 * @Date : 2018. 7. 30.
	 * @User : 김도훈
	 * @Param : 게시글 시퀀스
	 * @Return : -
	 * @Method 설명 : 온라인상담 게시글 조회수를 증가시키는 DAO 함수
	 */
	public void online_consulting_hit_update(int consulting_seq){
		logger.debug("온라인상담 게시글 세부 내용 중 조회수 증가 DAO 함수 시작");
		
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		seaMapper.online_consulting_hit_update(consulting_seq);
		
		logger.debug("온라인상담 게시글 세부 내용 중 조회수 증가 DAO 함수 종료");
	}

	/**
	 * @Method Name : apply_online_insert
	 * @Date : 2018. 7. 26.
	 * @User : 김도훈
	 * @Param : 온라인 상담 신청 정보
	 * @Return : 
	 * @Method 설명 : 온라인 상담 신청 정보를 DB에 저장
	 */
	public void apply_online_insert(OnlineConsultingContents occ) {
		logger.debug("온라인 상담 신청 DAO 시작");
		
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		System.out.println(occ);
		// 온라인 상담 신청 정보를 DB에 저장
		seaMapper.insertApplyOnlineContents(occ);
//		int applyOnlineContentsCount = seaMapper.insertApplyOnlineContents(occ);
//		System.out.println("applyOfflineContentsCount : " + applyOnlineContentsCount);

		logger.debug("온라인 상담 신청 DAO 종료");
	}
	
	/**
	 * @Method Name : apply_online_update
	 * @Date : 2018. 7. 30.
	 * @User : 김도훈
	 * @Param : 온라인 상담 신청 정보
	 * @Return : 
	 * @Method 설명 : 온라인 상담 신청 정보를 DB에 저장
	 */
	public void apply_online_update(OnlineConsultingContents occ) {
		logger.debug("온라인 상담 신청 DAO 시작");
		
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		// 온라인 상담 신청 정보를 DB에 저장
		seaMapper.updateApplyOnlineContents(occ);
//		int applyOnlineContentsCount = seaMapper.updateApplyOnlineContents(occ);
//		System.out.println("applyOfflineContentsCount : " + applyOnlineContentsCount);

		logger.debug("온라인 상담 신청 DAO 종료");
	}
	
	/**
	 * @Method Name : apply_online_delete
	 * @Date : 2018. 7. 30.
	 * @User : 김도훈
	 * @Param : 온라인 상담 신청 정보
	 * @Return : 
	 * @Method 설명 : 온라인 상담 신청 정보를 DB에 저장
	 */
	public void apply_online_delete(OnlineConsultingContents occ) {
		logger.debug("온라인 상담 신청 DAO 시작");
		
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		System.out.println(occ);
		// 온라인 상담 신청 정보를 DB에 저장
		seaMapper.deleteApplyOnlineContents(occ);
//		int applyOnlineContentsCount = seaMapper.updateApplyOnlineContents(occ);
//		System.out.println("applyOfflineContentsCount : " + applyOnlineContentsCount);

		logger.debug("온라인 상담 신청 DAO 종료");
	}
	
	/**
	 * @Method Name : apply_offline_insert
	 * @Date : 2018. 7. 12.
	 * @User : 김지훈
	 * @Param : 오프라인 상담 신청 정보
	 * @Return : 
	 * @Method 설명 : 오프라인 상담 신청 정보를 DB에 저장
	 */
	public void apply_offline_insert(OfflineConsultingContents occ) {
		logger.debug("오프라인 상담 신청 DAO 시작");
		
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
			
		// 오프라인 상담 신청 정보를 DB에 저장
		seaMapper.insertApplyOfflineContents(occ);
//		int applyOfflineContentsCount = seaMapper.insertApplyOfflineContents(occ);
//		System.out.println("applyOfflineContentsCount : " + applyOfflineContentsCount);

		logger.debug("오프라인 상담 신청 DAO 종료");
	}

	/**
	 * @Method Name : searchCurGisu
	 * @Date : 2018. 7. 27.
	 * @User : 김지훈
	 * @Param : 기수 시퀀스 정보
	 * @Return : 특정 기수 정보 객체
	 * @Method 설명 : 기수 시퀀스에 해당 하는 특정 기수 정보를 전달하는 DAO 함수
	 */
	public SocietyEduAdminCurriculumGisu searchCurGisu(int gisu_seq) {
		logger.debug("특정 기수 정보 검색 DAO 시작");
		
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		SocietyEduAdminCurriculumGisu seaCurGisu = seaMapper.searchCurGisu(gisu_seq);
		
		logger.debug("특정 기수 정보 검색 DAO 종료");
		return seaCurGisu;
	}
	
	/**
	 * @Method Name : faq_test_search
	 * @Date : 2018. 7. 19.
	 * @User : 김도훈
	 * @Param : FAQ 상담 게시판 그룹 객체 (구분포함)
	 * @Return : 게시물 타입, FAQ 게시판 그룹 리스트 객체
	 * @Method 설명 : FAQ 상담 게시판 그룹 리스트를 조회하는 DAO 함수
	 */
	public ArrayList<FaqConsultingContents> faq_test_search(FaqConsultingContents consultingTp){
		logger.debug("FAQ 상담 게시판  타입별 리스트 조회 DAO 함수 시작");
		
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		ArrayList<FaqConsultingContents> resultList = seaMapper.faq_test_search(consultingTp);
		
		logger.debug("FAQ 상담 게시판  타입별 리스트 조회 DAO 함수 종료");
		return resultList;
	}

	/**
	 * @Method Name : main_mediainit_list
	 * @Date : 2018. 7. 31.
	 * @User : 김지훈
	 * @Param : 
	 * @Return : ArrayList<HashMap<String, Object>>
	 * @Method 설명 : 메인에서 미디어속 SC IT 마스터 최신글 6개를 보여주기 위해 DB에 접근한다.
	 */
	public ArrayList<HashMap<String, Object>> main_mediainit_list() {
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		return seaMapper.main_mediainit_list();
	}

	/**
	 * @Method Name : main_graduate_list
	 * @Date : 2018. 7. 31.
	 * @User : 김지훈
	 * @Param : 
	 * @Return : ArrayList<HashMap<String, Object>>
	 * @Method 설명 : 메인에서 졸업생마당 최신글 6개를 보여주기 위해 DB에 접근한다.
	 */
	public ArrayList<HashMap<String, Object>> main_graduate_list() {
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		return seaMapper.main_graduate_list();
	}

	/**
	 * @Method Name : main_notice_list
	 * @Date : 2018. 7. 31.
	 * @User : 김지훈
	 * @Param : 
	 * @Return : ArrayList<HashMap<String, Object>>
	 * @Method 설명 : 메인에서 공지사항 최신글 6개를 보여주기 위해 DB에 접근한다.
	 */
	public ArrayList<HashMap<String, Object>> main_notice_list() {
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		return seaMapper.main_notice_list();
	}

	/**
	 * @Method Name : main_faq_list
	 * @Date : 2018. 7. 31.
	 * @User : 김지훈
	 * @Param : 
	 * @Return : ArrayList<HashMap<String, Object>>
	 * @Method 설명 : 메인에서 FAQ 최신글 6개를 보여주기 위해 DB에 접근한다.
	 */
	public ArrayList<HashMap<String, Object>> main_faq_list() {
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		return seaMapper.main_faq_list();
	}
	
	/**
	 * @Method Name : seoul_img_select
	 * @Date : 2018. 10. 10.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 서울 링크에 이미지 등록된 배열
	 * @Method 설명 : 서울 링크 클릭시 배너 관리에 등록되어있는 기수 이미지를 가져옴
	 */
	public ArrayList<String> seoul_img_select(){
		logger.debug("서울 이미지 가져오기 DAO 시작");
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		ArrayList<String> seoul_img_select = seaMapper.seoul_img_select();
		logger.debug("서울 이미지 가져오기 DAO 종료");
		return seoul_img_select;
	}
	
	/**
	 * @Method Name : gwangju_img_select
	 * @Date : 2018. 10. 10.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 광주 링크에 이미지 등록된 배열
	 * @Method 설명 : 광주 링크 클릭시 배너 관리에 등록되어있는 기수 이미지를 가져옴
	 */
	public ArrayList<String> gwangju_img_select(){
		logger.debug("광주 이미지 가져오기 DAO 시작");
		SocietyEduApplyMapper seaMapper = sqlSession.getMapper(SocietyEduApplyMapper.class);
		ArrayList<String> gwangju_img_select = seaMapper.gwangju_img_select();
		logger.debug("광주 이미지 가져오기 DAO 종료");
		return gwangju_img_select;
	}
	
	
	
	
	
	
	

	
	
}
