/**
 * 
 */
package global.segroup.society.edu.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.segroup.domain.Admin;
import global.segroup.domain.BoardContent;
import global.segroup.domain.BoardFile;
import global.segroup.domain.BoardGroup;
import global.segroup.domain.FaqConsultingContents;
import global.segroup.domain.OfflineConsultingContents;
import global.segroup.domain.OnlineConsultingContents;
import global.segroup.domain.User;
import global.segroup.society.edu.admin.domain.SocietyEduAdminBanner;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculum;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculumGisu;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculumGisuImg;
import global.segroup.society.edu.admin.domain.SocietyEduAdminPayment;
import global.segroup.society.edu.admin.domain.SocietyEduAdminSubBanner;
import global.segroup.society.edu.apply.domain.SocietyEduApplyResult;
import global.segroup.society.edu.user.domain.RefundInfo;

/**
 * @Author : 이종호
 * @Date : 2017. 8. 4.
 * @Class 설명 : Soft Engineer Society 모집홍보 관리자 DAO
 * 
 */

@Repository
public class SocietyEduAdminDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyEduAdminDAO.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	/**
	 * @Method Name : curriculum_insert
	 * @Date : 2018. 9. 17.
	 * @User : 이종호
	 * @Param : 관리자 정보
	 * @Return : -
	 * @Method 설명 : 관리자 회원 가입 DAO 함수 
	 */
	public void admin_insert(Admin admin) {
		logger.debug("관리자 회원 가입 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.admin_insert(admin);
		
		logger.debug("관리자 회원 가입 DAO 종료");
	}
	
	/**
	 * @Method Name : admin_info_list_select
	 * @Date : 2018. 9. 17.
	 * @User : 이종호
	 * @Param : 페이징 및 검색어
	 * @Return : 관리자 정보 리스트
	 * @Method 설명 : 관리자 정보 리스트 조회 DAO 함수 
	 */
	public ArrayList<Admin> admin_info_list_select(HashMap<String, Object> map){
		logger.debug("관리자 정보 리스트 조회 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<Admin> result = seaMapper.admin_info_list_select(map);
		logger.debug("관리자 정보 리스트 조회 DAO 종료");
		
		return result;
	}
	
	/**
	 * @Method Name : admin_info_update
	 * @Date : 2018. 9. 17
	 * @User : 이종호
	 * @Param : 관리자 정보 공통코드 (권한 , 상태 , 프로젝트) 및 권한기간
	 * @Return : -
	 * @Method 설명 : 관리자 정보 수정 DAO 함수
	 */		
	public void admin_info_update(Admin admin) {
		logger.debug("관리자 정보 수정 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.admin_info_update(admin);
		
		logger.debug("관리자 정보 수정 DAO 종료");
	}

	/**
	 * @Method Name : admin_info_list_select_count
	 * @Date : 2018. 9. 17.
	 * @User : 이종호
	 * @Param : 관리자 이름 (검색어)
	 * @Return : 관리자 정보 전체 개수 (검색된)
	 * @Method 설명 : 관리자 정보 전체 개수 조회 
	 */
	public int admin_info_list_select_count(HashMap<String, Object> map) {
		logger.debug("관리자 정보 전체 개수 조회 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		int result = seaMapper.admin_info_list_select_count(map);
		
		logger.debug("관리자 정보 전체 개수 조회 DAO 종료");
		
		return result;
	}
	
	/**
	 * @Method Name : curriculum_insert
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 과정 개설 정보
	 * @Return : -
	 * @Method 설명 : 과정 개설 정보를 등록하는 DAO 함수 
	 */
	public void curriculum_insert(SocietyEduAdminCurriculum seaCur){
		logger.debug("과정 개설 등록 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.curriculum_insert(seaCur);
		
		logger.debug("과정 개설 등록 DAO 종료");
	}  
	
	/**
	 * @Method Name : payInfoInsert
	 * @Date : 2017. 12. 4.
	 * @User : 전상수
	 * @Param : 과정 결제 정보
	 * @Return : -
	 * @Method 설명 : 과정 결제 정보를 등록하는 DAO 함수 
	 */
	public void payInfoInsert(SocietyEduAdminPayment seap){
		logger.debug("과정 결제 등록 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		if(seaMapper.selectPayInfo(seap.getPaymentList().get(0).getSeq()).size()!=0){//있을 경우 삭제후, 등록
		seaMapper.payInfoDelete(seap.getPaymentList().get(0).getSeq());
		seaMapper.payInfoInsert(seap.getPaymentList());	
		}else{//없을경우 새로등록
		seaMapper.payInfoInsert(seap.getPaymentList());
		}
		logger.debug("과정 결제 등록 DAO 종료");
	} 
	
	/**
	 * @Method Name : payInfoDelete
	 * @Date : 2017. 12. 4.
	 * @User : 전상수
	 * @Param : 과정 결제 정보
	 * @Return : -
	 * @Method 설명 : 과정 결제 정보를삭제하는 DAO 함수 
	 */
	public void payInfoDelete(SocietyEduAdminPayment seap){
		logger.debug("과정 결제 삭제 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		if(seaMapper.selectPayInfo(seap.getPaymentList().get(0).getSeq()).size()!=0){//있을 경우 삭제후, 등록
		seaMapper.payInfoDelete(seap.getPaymentList().get(0).getSeq());
		}
		logger.debug("과정 결제 삭제 DAO 종료");
	} 
	
	
	/**
	 * @Method Name : searchCurriculum
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 과정 시퀀스 정보
	 * @Return : 검색된 과정 정보 객체
	 * @Method 설명 : 과정 시퀀스 정보에 해당하는 과정 정보를 검색하는 DAO 함수
	 */
	public SocietyEduAdminCurriculum searchCurriculum(int crc_seq){
		logger.debug("과정 검색 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		SocietyEduAdminCurriculum seaCurriculum = seaMapper.searchCurriculum(crc_seq);
		
		logger.debug("과정 검색 DAO 종료");
		return seaCurriculum;
	}
	
	/**
	 * @Method Name : searchCurriculumGisuOrder
	 * @Date : 2017. 12. 19.
	 * @User : 전상수
	 * @Param : 기수 시퀀스 정보
	 * @Return : 검색된 결제분납 정보 객체
	 * @Method 설명 : 기수 시퀀스 정보에 해당하는 분납결제 정보를 검색하는 DAO 함수
	 */
	public ArrayList<HashMap<String, Object>> searchCurriculumGisuOrder(int gisu_seq){
		logger.debug("과정 검색 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<HashMap<String, Object>> seaCurriculumOrder = seaMapper.searchCurriculumGisuOrder(gisu_seq);
		
		logger.debug("과정 검색 DAO 종료");
		return seaCurriculumOrder;
	}
	
	/**
	 * @Method Name : searchCurGisu
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 과정 시퀀스 정보
	 * @Return : 검색된 기수 정보 리스트 객체
	 * @Method 설명 : 과정 시퀀스 정보에 해당하는 기수 정보들을 검색하는 DAO 함수
	 */
	public ArrayList<SocietyEduAdminCurriculumGisu> searchCurGisuList(int crc_seq){
		logger.debug("기수 검색 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<SocietyEduAdminCurriculumGisu> seaCurGisuList = seaMapper.searchCurGisuList(crc_seq);
		
		logger.debug("기수 검색 DAO 종료");
		return seaCurGisuList;
	}
	
	/**
	 * @Method Name : searchCurGisuImgList
	 * @Date : 2018. 9.28.
	 * @User : 신동철
	 * @Param : 과정 시퀀스 정보
	 * @Return : 검색된 기수 이미지 정보 리스트 객체
	 * @Method 설명 : 과정 시퀀스 정보에 해당하는 기수 이미지 정보들을 검색하는 DAO 함수
	 */
	public ArrayList<SocietyEduAdminCurriculumGisuImg> searchCurGisuImgList(int gisu_seq){
		logger.debug("기수 검색 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<SocietyEduAdminCurriculumGisuImg> seaCurGisuImgList = seaMapper.searchCurGisuImgList(gisu_seq);
		
		logger.debug("기수 검색 DAO 종료");
		return seaCurGisuImgList;
	}
	
	/**
	 * @Method Name : searchCurriculumAllCount
	 * @Date : 2017. 02. 08.
	 * @User : 박기호
	 * @Param : -
	 * @Return : 전체 과정 정보 리스트 count
	 * @Method 설명 : 전체 과정 정보 count를 검색하는 DAO 함수
	 */
	public int searchCurriculumAllCount(){
		logger.debug("전체 과정 count 검색 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		int result = seaMapper.searchCurriculumAllCount();
		
		logger.debug("전체 과정 count 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : searchCurriculumAll
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 전체 과정 정보 리스트 객체
	 * @Method 설명 : 전체 과정 정보를 검색하는 DAO 함수
	 */
	public ArrayList<SocietyEduAdminCurriculum> searchCurriculumAll(HashMap<String,Object> map){
		logger.debug("전체 과정 검색 DAO 시작");
		
		ArrayList<SocietyEduAdminCurriculum> resultList = new ArrayList<>();
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		resultList = seaMapper.searchCurriculumAll(map);
		
		logger.debug("전체 과정 검색 DAO 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : searchCurriculumPermission
	 * @Date : 2017. 8. 18.
	 * @User : 이종호
	 * @Param : - 
	 * @Return : 승인된 과정들 정보 리스트 객체
	 * @Method 설명 : 승인된 과정들 정보를 검색하는 DAO 함수
	 */
	public ArrayList<SocietyEduAdminCurriculum> searchCurriculumPermission(){
		logger.debug("승인된 과정들 검색 DAO 시작");
		
		ArrayList<SocietyEduAdminCurriculum> resultList = new ArrayList<>();
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		resultList = seaMapper.searchCurriculumPermission();
		
		logger.debug("승인된 과정들 검색 DAO 종료");
		return resultList;
	}
	
	
	/**
	 * @Method Name : searchCurriculumRefund
	 * @Date : 2017. 12. 26.
	 * @User : 전상수
	 * @Param : - 
	 * @Return : 환불 정보 리스트 객체
	 * @Method 설명 : 환불 정보를 검색하는 DAO 함수
	 */
	public ArrayList<HashMap<String, Object>> searchCurriculumRefund(){
		logger.debug("승인된 과정들 검색 DAO 시작");
		
		ArrayList<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		resultList = seaMapper.searchCurriculumRefund();
		
		logger.debug("승인된 과정들 검색 DAO 종료");
		return resultList;
	}
	
	/**
	 * @param map 
	 * @Method Name : searchCurriculumGisuAllCount
	 * @Date : 2017. 02. 08.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 전체 과정의 전체 기수 count
	 * @Method 설명 : 전체 과정의 전체 기수 count를 검색하는 DAO 함수
	 */
	public int searchCurriculumGisuAllCount(HashMap<String, Object> map){
		logger.debug("전체 과정의 전체 기수 count 검색 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		int result = seaMapper.searchCurriculumGisuAllCount(map);
		
		logger.debug("전체 과정의 전체 기수 count 검색 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : searchCurriculumGisuAll
	 * @Date : 2017. 8. 16.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 전체 과정의 전체 기수 정보 리스트 객체
	 * @Method 설명 : 전체 과정의 전체 기수 정보를 검색하는 DAO 함수
	 */
	public ArrayList<SocietyEduAdminCurriculumGisu> searchCurriculumGisuAll(HashMap<String,Object> map){
		logger.debug("전체 과정의 전체 기수 정보 검색 DAO 시작");
		
		ArrayList<SocietyEduAdminCurriculumGisu> resultList = new ArrayList<>();
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		resultList = seaMapper.searchCurriculumGisuAll(map);
		
		logger.debug("전체 과정의 전체 기수 정보 검색 DAO 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : curriculum_update
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 과정 수정 정보
	 * @Return : -
	 * @Method 설명 : 전달 받은 과정 정보를 수정하는 DAO 함수 
	 */
	public void curriculum_update(SocietyEduAdminCurriculum seaCur){
		logger.debug("과정 정보 수정 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.curriculum_update(seaCur);
		
		logger.debug("과정 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : searchCurGisu
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 기수 시퀀스 정보
	 * @Return : 특정 기수 정보 객체
	 * @Method 설명 : 기수 시퀀스에 해당 하는 특정 기수 정보를 전달하는 DAO 함수
	 */
	public SocietyEduAdminCurriculumGisu searchCurGisu(int gisu_seq){
		logger.debug("특정 기수 정보 검색 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		SocietyEduAdminCurriculumGisu seaCurGisu = seaMapper.searchCurGisu(gisu_seq);
		
		logger.debug("특정 기수 정보 검색 DAO 종료");
		return seaCurGisu;
	}
	
	/**
	 * @Method Name : curriculum_gisu_insert
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 기수 정보 객체
	 * @Return : -
	 * @Method 설명 : 전달 받은 기수 정보를 등록하는 DAO 함수
	 */
	/*public void curriculum_gisu_insert(SocietyEduAdminCurriculumGisu seaCurGisu){
		logger.debug("기수 정보 등록 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.curriculum_gisu_insert(seaCurGisu);
		
		logger.debug("기수 정보 등록 DAO 종료");
	}*/
	
	/**
	 * @Method Name : curriculum_gisu_update
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 기수 정보 객체
	 * @Return : -
	 * @Method 설명 : 전달 받은 기수 정보를 수정하는 DAO 함수 
	 */
	public void curriculum_gisu_update(SocietyEduAdminCurriculumGisu seaCurGisu){
		logger.debug("기수 정보 수정 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.curriculum_gisu_update(seaCurGisu);
		
		logger.debug("기수 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : curriculum_permission_update
	 * @Date : 2017. 8. 7.
	 * @User : 이종호
	 * @Param : 과정 정보 객체(과정 시퀀스, 승인 코드, 수정 인)
	 * @Return : -
	 * @Method 설명 : 과정 승인 정보를 수정하는 DAO 함수
	 */
	public void curriculum_permission_update(SocietyEduAdminCurriculum seaCur){
		logger.debug("과정 승인 정보 수정 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.curriculum_permission_update(seaCur);
		
		logger.debug("과정 승인 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : curriculum_gisu_permission_update
	 * @Date : 2017. 8. 18.
	 * @User : 이종호
	 * @Param : 기수 정보 객체(기수 시퀀스, 노출 승인 코드, 수정 인) 
	 * @Return : -
	 * @Method 설명 : 기수 노출 승인 정보를 수정하는 DAO 함수
	 */
	public void curriculum_gisu_permission_update(SocietyEduAdminCurriculumGisu seaCurGisu){
		logger.debug("기수 노출 승인 정보 수정 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.curriculum_gisu_permission_update(seaCurGisu);
		
		logger.debug("기수 노출 승인 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : curriculum_apply_select
	 * @Date : 2017. 8. 18.
	 * @User : 이종호
	 * @Param : 과정 시퀀스 
	 * @Return : 해당 과정 신청자 수
	 * @Method 설명 : 특정 과정의 신청자 여부 체크 DAO 함수
	 */
	public int curriculum_apply_select(int crc_seq){
		logger.debug("특정 과정의 신청자 여부 체크 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		logger.debug("특정 과정의 신청자 여부 체크 DAO 종료");
		return seaMapper.curriculum_apply_select(crc_seq);
	}
	
	/**
	 * @Method Name : curriculum_gisu_apply_select
	 * @Date : 2017. 8. 18.
	 * @User : 이종호
	 * @Param : 기수 시퀀스
	 * @Return : 해당 기수 신청자 수
	 * @Method 설명 : 특정 기수의 신청자 여부 체크 DAO 함수
	 */
	public int curriculum_gisu_apply_select(int gisu_seq){
		logger.debug("특정 기수의 신청자 여부 체크 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		logger.debug("특정 기수의 신청자 여부 체크 DAO 종료");
		return seaMapper.curriculum_gisu_apply_select(gisu_seq);
	}
	
	/**
	 * @Method Name : apply_manager_select_count
	 * @Date : 2018. 02. 08.
	 * @User : 박기호
	 * @Param : 기수 시퀀스, 검색어
	 * @Return : 해당 기수의 신청자 정보 count
	 * @Method 설명 : 특정 기수의 신청자 정보count를 조회하는 DAO 함수
	 */
	public int apply_manager_select_count(HashMap<String,Object> map){
		logger.debug("특정 기수의 신청자 정보들을 조회하는 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		logger.debug("특정 기수의 신청자 정보들을 조회하는 DAO 종료");
		return seaMapper.apply_manager_select_count(map);
	}
	
	/**
	 * @Method Name : apply_manager_select
	 * @Date : 2017. 8. 18.
	 * @User : 이종호, 박기호 수정
	 * @Param : 기수 시퀀스, 검색어
	 * @Return : 해당 기수의 신청자 정보들 리스트 객체
	 * @Method 설명 : 특정 기수의 신청자 정보들을 조회하는 DAO 함수
	 */
	public ArrayList<HashMap<String, Object>> apply_manager_select(HashMap<String,Object> map){
		logger.debug("특정 기수의 신청자 정보들을 조회하는 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		logger.debug("특정 기수의 신청자 정보들을 조회하는 DAO 종료");
		return seaMapper.apply_manager_select(map);
	}
	
	/**
	 * @Method Name : paid_manager_select
	 * @Date : 2017. 12. 19.
	 * @User : 전상수
	 * @Param : 기수 시퀀스
	 * @Return : 해당 기수의 신청자 정보들 리스트 객체
	 * @Method 설명 : 특정 기수의 신청자 정보들을 조회하는 DAO 함수
	 */
	public ArrayList<HashMap<String, Object>> paid_manager_select(HashMap<String, Object> map){
		logger.debug("특정 기수의 신청자 정보들을 조회하는 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		logger.debug("특정 기수의 신청자 정보들을 조회하는 DAO 종료");
		return seaMapper.paid_manager_select(map);
	}
	
	/**
	 * @Method Name : refund_manager_select
	 * @Date : 2017. 12. 19.
	 * @User : 전상수
	 * @Param : 기수 시퀀스
	 * @Return : 해당 기수의 환불 신청자 정보들 리스트 객체
	 * @Method 설명 : 특정 기수의 환불 신청자 정보들을 조회하는 DAO 함수
	 */
	public ArrayList<HashMap<String, Object>> refund_manager_select(HashMap<String, Object> map){
		logger.debug("특정 기수의 환불 신청자 정보들을 조회하는 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		logger.debug("특정 기수의 환불 신청자 정보들을 조회하는 DAO 종료");
		return seaMapper.refund_manager_select(map);
	}
	
	/**
	 * @Method Name : paid_name_select
	 * @Date : 2017. 12. 20.
	 * @User : 전상수
	 * @Param : 이름
	 * @Return : 해당 이름의 신청자 정보들 리스트 객체
	 * @Method 설명 : 특정 이름의 신청자 정보들을 조회하는 DAO 함수
	 */
	public ArrayList<HashMap<String, Object>> paid_name_select(HashMap<String, Object> map){
		logger.debug("특정 기수의 신청자 정보들을 조회하는 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		logger.debug("특정 기수의 신청자 정보들을 조회하는 DAO 종료");
		return seaMapper.paid_name_select(map);
	}
	
	/**
	 * @Method Name : refund_name_select
	 * @Date : 2017. 12. 20.
	 * @User : 전상수
	 * @Param : 이름
	 * @Return : 해당 이름의 환불신청자 정보들 리스트 객체
	 * @Method 설명 : 특정 이름의 환불신청자 정보들을 조회하는 DAO 함수
	 */
	public ArrayList<HashMap<String, Object>> refund_name_select(HashMap<String, Object> map){
		logger.debug("특정 기수의 환불신청자 정보들을 조회하는 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		logger.debug("특정 기수의 환불신청자 정보들을 조회하는 DAO 종료");
		return seaMapper.refund_name_select(map);
	}
	
	/**
	 * @Method Name : eduApply_result_update
	 * @Date : 2017. 8. 24.
	 * @User : 이종호
	 * @Param : 특정 지원자의 결과 정보 객체
	 * @Return : -
	 * @Method 설명 : 특정 지원자의 결과 정보 수정하는 DAO 함수 
	 */
	public void eduApply_result_update(SocietyEduApplyResult seaResult){
		logger.debug("특정 지원자의 결과 정보 수정 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.eduApply_result_update(seaResult);
		logger.debug("특정 지원자의 결과 정보 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : board_name_search
	 * @Date : 2017. 8. 25.
	 * @User : 이종호
	 * @Param : 게시판 구분, 게시판 타입을 가진 게시판 그룹 객체
	 * @Return : 게시판 시퀀스, 게시판 이름을 가진 게시판 그룹 리스트 객체
	 * @Method 설명 : 특정 구분, 타입 값을 가진 게시판 그룹 리스트를 조회하는 DAO 함수
	 */
	public ArrayList<BoardGroup> board_name_search(BoardGroup boardGb){
		logger.debug("게시판 그룹 리스트 조회 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<BoardGroup> resultList = seaMapper.board_name_search(boardGb);
		
		logger.debug("게시판 그룹 리스트 조회 DAO 함수 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : board_contents_search
	 * @Date : 2017. 9. 8.
	 * @User : 이종호
	 * @Param : 게시판 시퀀스
	 * @Return : 특정 게시판 시퀀스에 해당하는 게시글 리스트 객체
	 * @Method 설명 : 특정 게시판 시퀀스에 해당하는 게시글을 조회하는 DAO함수
	 */
	public ArrayList<BoardContent> board_contents_search(HashMap<String, Object> map){
		logger.debug("게시글 리스트 조회 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<BoardContent> resultList = seaMapper.board_contents_search(map);
		
		logger.debug("게시글 리스트 조회 DAO 함수 종료");
		
		return resultList;
	}
	
	/**
	 * @Method Name : board_gb_search
	 * @Date : 2019. 1. 24.
	 * @User : 신동철
	 * @Param : 게시판 시퀀스
	 * @Return : 게시판 구분, 타입 검색
	 * @Method 설명 : 게시판 구분, 타입 검색 함수
	 */
	public BoardGroup board_gb_search(BoardGroup boardGb){
	logger.debug("게시판 구분, 타입 검색  DAO 함수 시작");
		
	SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
	BoardGroup boardGroup = seaMapper.board_gb_search(boardGb);
	
	logger.debug("게시판 구분, 타입 검색  DAO 함수 종료");
	return boardGroup;
	}
	
	/**
	 * @Method Name : company_board_contents_search
	 * @Date : 2019. 1. 23.
	 * @User : 신동철
	 * @Param : 게시판 시퀀스
	 * @Return : 잡페어 채용기업 메인 공지사항 정보
	 * @Method 설명 : 잡페어 채용기업 메인 공지사항 검색 서비스함수
	 */
	public ArrayList<BoardContent> company_board_contents_search(HashMap<String, Object> map){
		logger.debug("잡페어 채용기업 메인 공지사항 검색 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<BoardContent> resultList = seaMapper.company_board_contents_search(map);
		
		logger.debug("잡페어 채용기업 메인 공지사항 검색 DAO 함수 종료");
		
		return resultList;
	}
		
	/**
	 * @Method Name : board_contents_hit_update
	 * @Date : 2017. 9. 29.
	 * @User : 이종호
	 * @Param : 게시글 시퀀스
	 * @Return : -
	 * @Method 설명 : 해당 게시글 조회수를 증가시키는 DAO 함수
	 */
	public void board_contents_hit_update(int board_content_seq){
		logger.debug("게시글 세부 내용 중 조회수 증가 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.board_contents_hit_update(board_content_seq);
		
		logger.debug("게시글 세부 내용 중 조회수 증가 DAO 함수 종료");
	}
	
	/**
	 * @Method Name : board_contents_detail
	 * @Date : 2017. 9. 13.
	 * @User : 이종호
	 * @Param : 게시글 시퀀스
	 * @Return : 특정 게시글의 세부 내용 및 파일 정보를 담은 맵객체
	 * @Method 설명 : 특정 게시글의 세부 내용 및 파일 정보를 조회하는 DAO 함수
	 */
	public HashMap<String, Object> board_contents_detail(int board_content_seq){
		logger.debug("게시글 세부 내용 조회 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		HashMap<String, Object> resultMap = seaMapper.board_contents_detail(board_content_seq);
		logger.debug("게시글 세부 내용 조회 DAO 함수 종료");
		return resultMap;
	}
	
	/**
	 * @Method Name : selectPayInfo
	 * @Date : 2017. 12. 5.
	 * @User : 전상수
	 * @Param : 게시글 시퀀스
	 * @Return : 특정 결제정보를 내용 및 파일 정보를 담은 맵객체
	 * @Method 설명 : 특정 결제정보를 조회하는 DAO 함수
	 */
	public List<HashMap<String, Object>> selectPayInfo(String gisu_seq){
		logger.debug("특정 결제정보를 조회 DAO 함수 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		List<HashMap<String, Object>> resultMap = seaMapper.selectPayInfo(gisu_seq);
		logger.debug("특정 결제정보를 조회 DAO 함수 종료");
		return resultMap;
	}
	
	/**
	 * @Method Name : board_contents_insert
	 * @Date : 2017. 9. 28.
	 * @User : 이종호
	 * @Param : 게시글 세부 내용
	 * @Return : -
	 * @Method 설명 : 게시글을 등록하는 DAO 함수
	 */
	public void board_contents_insert(BoardContent boardContent){
		logger.debug("게시글 세부 내용 등록 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.board_contents_insert(boardContent);
		
		logger.debug("게시글 세부 내용 등록 DAO 함수 종료");
	}
	
	/**
	 * @Method Name : board_contents_update
	 * @Date : 2017. 9. 25.
	 * @User : 이종호
	 * @Param : 게시글 세부 내용
	 * @Return : -
	 * @Method 설명 : 게시글을 수정하는 DAO 함수 
	 */
	public void board_contents_update(BoardContent boardContent){
		logger.debug("게시글 세부 내용 수정 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.board_contents_update(boardContent);
		
		logger.debug("게시글 세부 내용 수정 DAO 함수 종료");
	}
	
	/**
	 * @Method Name : board_contents_file_delete
	 * @Date : 2017. 9. 26.
	 * @User : 이종호
	 * @Param : 게시글 세부 내용(시퀀스)
	 * @Return :  -
	 * @Method 설명 : 해당 게시글의 파일 정보를 삭제하는 DAO 함수 
	 */
	public void board_contents_file_delete(BoardContent boardContent){
		logger.debug("해당 게시글 파일 정보 삭제 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.board_contents_file_delete(boardContent);
		
		logger.debug("해당 게시글 파일 정보 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : board_contents_file_insert
	 * @Date : 2017. 9. 27.
	 * @User : 이종호
	 * @Param : 해당 게시글 파일 정보 맵 객체
	 * @Return : -
	 * @Method 설명 : 해당 게시글 파일정보를 등록하는 DAO 함수
	 */
	public void board_contents_file_insert(BoardFile boardFile, int board_content_seq, String id){
		logger.debug("해당 게시글 파일 정보 등록 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.board_contents_file_insert(makeMap(boardFile.getBoardFileList(), board_content_seq, id));
		
		logger.debug("해당 게시글 파일 정보 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : makeMap
	 * @Date : 2017. 9. 27.
	 * @User : 이종호
	 * @Param : 게시글 파일 리스트, 게시글 세부 정보 시퀀스 , 로그인 아이디
	 * @Return : 입력받은 항목을 가진 맵 객체
	 * @Method 설명 : Mapper에 넘겨줄 맵 객체 생성 함수
	 */
	private <T>HashMap<String, Object> makeMap(List<T> list, int board_content_seq, String id){
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("board_content_seq", board_content_seq);
		resultMap.put("list", list);
		resultMap.put("id", id);
		return resultMap;
	}
	
	/**
	 * @param map 
	 * @Method Name : basic_user_select_all_count
	 * @Date : 2017. 02. 12.
	 * @User : 박기호
	 * @Param : -
	 * @Return : 일반 회원(등급)의 전체 회원 정보 리스트 count
	 * @Method 설명 : 일반 회원(등급)의 전체 회원 정보count를 조회하는 DAO 함수
	 */
	public int basic_user_select_all_count(HashMap<String, Object> map){
		logger.debug("일반 회원(등급)의 전체 회원 정보count 조회 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		int result = seaMapper.basic_user_select_all_count(map);
		
		logger.debug("일반 회원(등급)의 전체 회원 정보 count 조회 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : basic_user_select_all
	 * @Date : 2017. 9. 29.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 일반 회원(등급)의 전체 회원 정보 리스트
	 * @Method 설명 : 일반 회원(등급)의 전체 회원 정보를 조회하는 DAO 함수
	 */
	public ArrayList<User> basic_user_select_all(HashMap<String,Object> map){
		logger.debug("일반 회원(등급)의 전체 회원 정보 조회 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<User> resultList = seaMapper.basic_user_select_all(map);
		
		logger.debug("일반 회원(등급)의 전체 회원 정보 조회 DAO 종료");
		return resultList;
	}

	/**
	 * @Method Name : refund_status_update
	 * @Date : 2018. 2. 7.
	 * @User : 윤상혁
	 * @Param : 환불정보
	 * @Return : 처리 결과
	 * @Method 설명 : 환불 상태 갱신
	 */
	public int refund_status_update(RefundInfo pay_refund_seq) {
		logger.debug("환불 상태 갱신 DAO 시작");
		SocietyEduAdminMapper mapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		logger.debug("환불 상태 갱신 DAO 종료");
		return mapper.refund_status_update(pay_refund_seq);
	}

	/**
	 * @Method Name : refund_memo_update
	 * @Date : 2018. 2. 7.
	 * @User : SCITMaster
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int refund_memo_update(RefundInfo refundInfo) {
		logger.debug("환불 메모 갱신 DAO 시작");
		SocietyEduAdminMapper mapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		logger.debug("환불 메모 갱신 DAO 종료");
		return mapper.refund_memo_update(refundInfo);
	}

	/**
	 * @Method Name : refund_manager_list
	 * @Date : 2018. 2. 8.
	 * @User : SCITMaster
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public List<HashMap<String, Object>> refund_manager_list(HashMap<String, Object> map) {
		logger.debug("환불 메모 갱신 DAO 시작");
		SocietyEduAdminMapper mapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		logger.debug("환불 메모 갱신 DAO 종료");
		return mapper.refund_manager_list(map);
	}

	/**
	 * @Method Name : delete_pay_info
	 * @Date : 2018. 2. 8.
	 * @User : SCITMaster
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int delete_pay_info(int pay_user_seq) {
		logger.debug("delete_pay_info DAO 시작");
		SocietyEduAdminMapper mapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		logger.debug("delete_pay_info DAO 종료");
		return mapper.delete_pay_info(pay_user_seq);
	}

	/**
	 * @Method Name : select_refund_user_id
	 * @Date : 2018. 8. 20.
	 * @User : 이종호
	 * @Param : 환불 시퀀스
	 * @Return : 환불 받을 유저 아이디
	 * @Method 설명 : 환불 시퀀스로 환불 받을 유저 아이디 검색 (유저 권한 변경 시 사용)
	 */
	public RefundInfo select_refund_user_id(int pay_refund_seq) {
		logger.debug("환불 시퀀스로 환불 받을 유저 아이디 검색 DAO 시작");
		
		SocietyEduAdminMapper mapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		RefundInfo result = mapper.select_refund_user_id(pay_refund_seq);
		
		logger.debug("환불 시퀀스로 환불 받을 유저 아이디 검색 DAO 종료");
		
		return result;
	}
	
	/**
	 * @Method Name : selectPayByGisu
	 * @Date : 2018. 2. 10.
	 * @User : SCITMaster
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public List<HashMap<String, Object>> selectPayByGisu(int gisu_seq) {
		logger.debug("selectPayByGisu DAO 시작");
		SocietyEduAdminMapper mapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		logger.debug("selectPayByGisu DAO 종료");
		return mapper.selectPayByGisu(gisu_seq);
	}

	/**
	 * @Method Name : insert_refund_temp
	 * @Date : 2018. 2. 10.
	 * @User : SCITMaster
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int insert_refund_temp(int pay_user_seq) {
		logger.debug("insert_refund_temp DAO 시작");
		SocietyEduAdminMapper mapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		logger.debug("insert_refund_temp DAO 종료");
		return mapper.insert_refund_temp(pay_user_seq);
	}

	/**
	 * @Method Name : paid_manager_select_count
	 * @Date : 2018. 2. 13.
	 * @User : SCITMaster
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int paid_manager_select_count(HashMap<String, Object> map) {
		return sqlSession.getMapper(SocietyEduAdminMapper.class).paid_manager_select_count(map);
	}

	/**
	 * @Method Name : refund_manager_list_count
	 * @Date : 2018. 2. 13.
	 * @User : SCITMaster
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int refund_manager_list_count(HashMap<String, Object> map) {
		return sqlSession.getMapper(SocietyEduAdminMapper.class).refund_manager_list_count(map);
	}
	
	/**
	 * @Method Name : selecEduApplyForm
	 * @Date : 2018. 2. 13.
	 * @User : SCITMaster
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 해당 유저 지원서 정보 검색
	 */
	public HashMap<String, Object> selectEduApplyUpdateForm(HashMap<String,Object> map) {
		logger.debug("selectEduApplyForm DAO 시작");
		SocietyEduAdminMapper mapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		logger.debug("selectEduApplyForm DAO 종료");
		return mapper.selectEduApplyUpdateForm(map);
	}

	/**
	 * @Method Name : user_info_update
	 * @Date : 2018. 2. 14.
	 * @User : SCITMaster
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 
	 */
	public int user_info_update(User user) {
		return sqlSession.getMapper(SocietyEduAdminMapper.class).user_info_update(user);
	}
	
	/**
	 * @Method Name : faq_manager_select_count
	 * @Date : 2018. 7. 24.
	 * @User : 김도훈
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : FAQ 상담 항목count를 조회한다.
	 */
	public int faq_manager_select_count(HashMap<String, Object> map) {
		logger.debug("FAQ 상담 항목count를 조회하는 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		logger.debug("FAQ 상담 항목count를 조회하는 DAO 종료");
		return seaMapper.faq_manager_select_count(map);
	}
	
	/**
	 * @Method Name : online_manager_select_all
	 * @Date : 2018. 7. 27.
	 * @User : 김도훈
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : FAQ 항목 정보를 조회한다.
	 */
	public ArrayList<FaqConsultingContents> faq_manager_select_all(HashMap<String, Object> map) {
		logger.debug("FAQ 항목 정보들을 조회하는 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<FaqConsultingContents> resultList = seaMapper.faq_manager_select_all(map);
		logger.debug("FAQ 항목 정보들을 조회하는 DAO 종료");
		return resultList;
	}

	/**
	 * @Method Name : faq_manager_select
	 * @Date : 2018. 7. 25.
	 * @User : 김도훈
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : FAQ 리스트 중 하나의 상세정보를 조회하는 DAO
	 */
	public FaqConsultingContents faq_manager_select(int consulting_seq) {
		logger.debug("FAQ 리스트 중 하나의 상세정보를 조회하는 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		FaqConsultingContents result = seaMapper.faq_manager_select(consulting_seq);
		logger.debug("FAQ 리스트 중 하나의 상세정보를 조회하는 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : faq_manager_detail
	 * @Date : 2018. 7. 19.
	 * @User : 김도훈
	 * @Param : FAQ 상담 게시판 게시글 시퀀스
	 * @Return : 특정 FAQ 상담 게시판 게시글의 세부 내용 및 파일 정보를 담은 맵객체
	 * @Method 설명 : 특정 FAQ 상담 게시판 게시글의 세부 내용 및 파일 정보를 조회하는 DAO 함수
	 */
	public HashMap<String, Object> faq_manager_detail(int consulting_seq){
		logger.debug("FAQ 게시판 글 세부 내용 조회 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		HashMap<String, Object> resultMap = seaMapper.faq_manager_detail(consulting_seq);
		logger.debug("FAQ 게시판 글 세부 내용 조회 DAO 함수 종료");
		return resultMap;
	}
	
	/**
	 * @Method Name : faq_manager_contents_insert
	 * @Date : 2018. 7. 19.
	 * @User : 김도훈
	 * @Param : FAQ 게시판 게시글 세부 내용
	 * @Return : -
	 * @Method 설명 : FAQ 게시판 게시글 세부내용을 등록하는 DAO 함수
	 */
	public void faq_manager_contents_insert(FaqConsultingContents consultingContent){
		logger.debug("FAQ 게시판 글 세부 내용 등록 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.faq_manager_contents_insert(consultingContent);
		
		logger.debug("FAQ 게시판 글 세부 내용 등록 DAO 함수 종료");
	}
	
	/**
	 * @Method Name : faq_manager_contents_update
	 * @Date : 2018. 7. 19.
	 * @User : 김도훈
	 * @Param : FAQ게시글 세부 내용
	 * @Return : -
	 * @Method 설명 : FAQ 게시판 게시글을 수정하는 DAO 함수 
	 */
	public void faq_manager_contents_update(FaqConsultingContents consultingContent){
		logger.debug("FAQ 게시판 글 세부 내용 수정 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.faq_manager_contents_update(consultingContent);
		
		logger.debug("FAQ 게시판 글 세부 내용 수정 DAO 함수 종료");
	}
	
	/**
	 * @Method Name : online_manager_select_count
	 * @Date : 2018. 7. 27.
	 * @User : 김도훈
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 온라인 상담신청 정보count를 조회한다.
	 */
	public int online_manager_select_count(HashMap<String, Object> map) {
		logger.debug("온라인 상담신청 정보count를 조회하는 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		logger.debug("온라인 상담신청 정보count를 조회하는 DAO 종료");
		return seaMapper.online_manager_select_count(map);
	}

	/**
	 * @Method Name : online_manager_select_all
	 * @Date : 2018. 7. 27.
	 * @User : 김도훈
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 온라인 상담신청 정보를 조회한다.
	 */
	public ArrayList<OnlineConsultingContents> online_manager_select_all(HashMap<String, Object> map) {
		logger.debug("온라인 상담신청 정보들을 조회하는 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<OnlineConsultingContents> resultList = seaMapper.online_manager_select_all(map);
		logger.debug("온라인 상담신청 정보들을 조회하는 DAO 종료");
		return resultList;
	}

	/**
	 * @Method Name : online_manager_select
	 * @Date : 2018. 7. 27.
	 * @User : 김도훈
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 온라인 상담신청 중 하나의 상세정보를 조회하는 DAO
	 */
	public OnlineConsultingContents online_manager_select(int consulting_seq) {
		logger.debug("온라인 상담신청 중 하나의 상세정보를 조회하는 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		OnlineConsultingContents result = seaMapper.online_manager_select(consulting_seq);
		logger.debug("온라인 상담신청 중 하나의 상세정보를 조회하는 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : online_manager_hit_update
	 * @Date : 2018. 7. 19.
	 * @User : 김도훈
	 * @Param : 온라인 상담 게시판 글 시퀀스
	 * @Return : -
	 * @Method 설명 : 해당 온라인 상담 게시판 글 조회수를 증가시키는 DAO 함수
	 */
	public void online_manager_hit_update(int consulting_seq){
		logger.debug("온라인 상담 게시판 글 세부 내용 중 조회수 증가 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.online_manager_hit_update(consulting_seq);
		
		logger.debug("온라인 상담 게시판 글 세부 내용 중 조회수 증가 DAO 함수 종료");
	}
	
	/**
	 * @Method Name : online_manager_contents_insert
	 * @Date : 2018. 7. 19.
	 * @User : 김도훈
	 * @Param : 온라인 상담 게시판 게시글 세부 내용
	 * @Return : -
	 * @Method 설명 : 온라인 상담 게시판 게시글 세부내용을 등록하는 DAO 함수
	 */
	public void online_manager_contents_insert(OnlineConsultingContents consultingContent){
		logger.debug("온라인 상담 게시판 글 세부 내용 등록 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.online_manager_contents_insert(consultingContent);
		
		logger.debug("온라인 상담 게시판 글 세부 내용 등록 DAO 함수 종료");
	}
	
	/**
	 * @Method Name : online_manager_contents_update
	 * @Date : 2018. 7. 19.
	 * @User : 김도훈
	 * @Param : FAQ게시글 세부 내용
	 * @Return : -
	 * @Method 설명 : 온라인 상담 게시판 게시글을 수정하는 DAO 함수 
	 */
	public void online_manager_contents_update(OnlineConsultingContents consultingContent){
		logger.debug("온라인 상담 게시판 글 세부 내용 수정 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.online_manager_contents_update(consultingContent);
		
		logger.debug("온라인 상담 게시판 글 세부 내용 수정 DAO 함수 종료");
	}
	
	/**
	 * @Method Name : online_manager_reply_insert
	 * @Date : 2018. 7. 19.
	 * @User : 김도훈
	 * @Param : 온라인상담 답변글 세부 내용
	 * @Return : -
	 * @Method 설명 : 온라인상담 답변글을 등록하는 DAO 함수
	 */
	public void online_manager_reply_insert(OnlineConsultingContents consultingContent){
		logger.debug("온라인 상담 게시판 답변글 세부 내용 등록 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.online_manager_reply_insert(consultingContent);
		
		logger.debug("온라인 상담 게시판 답변글 세부 내용 등록 DAO 함수 종료");
	}
	
	/**
	 * @Method Name : online_manager_reply_update
	 * @Date : 2018. 7. 19.
	 * @User : 김도훈
	 * @Param : 온라인상담 답변글 세부 내용
	 * @Return : -
	 * @Method 설명 : 온라인상담 답변글을 수정하는 DAO 함수 
	 */
	public void online_manager_reply_update(OnlineConsultingContents consultingContent){
		logger.debug("온라인 상담 게시판 답변글 세부 내용 수정 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.online_manager_reply_update(consultingContent);
		
		logger.debug("온라인 상담 게시판 답변글 세부 내용 수정 DAO 함수 종료");
	}	
	
	/**
	 * @Method Name : makeConsultingMap
	 * @Date : 2018. 7. 19.
	 * @User : 김도훈
	 * @Param : 온라인상담 파일 리스트, 온라인상담 및 FAQ 시퀀스 , 로그인 아이디
	 * @Return : 입력받은 항목을 가진 맵 객체
	 * @Method 설명 : Mapper에 넘겨줄 맵 객체 생성 함수
	 */
	private <T>HashMap<String, Object> makeConsultingMap(List<T> list, int consulting_seq, String id){
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("consulting_seq", consulting_seq);
		resultMap.put("list", list);
		resultMap.put("id", id);
		return resultMap;
	}
	
	/**
	 * @Method Name : offline_manager_select_count
	 * @Date : 2018. 7. 16.
	 * @User : 김지훈
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 오프라인 상담신청 정보count를 조회한다.
	 */
	public int offline_manager_select_count(HashMap<String, Object> map) {
		logger.debug("오프라인 상담신청 정보count를 조회하는 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		logger.debug("오프라인 상담신청 정보count를 조회하는 DAO 종료");
		return seaMapper.offline_manager_select_count(map);
	}

	/**
	 * @Method Name : offline_manager_select_all
	 * @Date : 2018. 7. 16.
	 * @User : 김지훈
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 오프라인 상담신청 정보를 조회한다.
	 */
	public ArrayList<OfflineConsultingContents> offline_manager_select_all(HashMap<String, Object> map) {
		logger.debug("오프라인 상담신청 정보들을 조회하는 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<OfflineConsultingContents> resultList = seaMapper.offline_manager_select_all(map);
		logger.debug("오프라인 상담신청 정보들을 조회하는 DAO 종료");
		return resultList;
	}

	/**
	 * @Method Name : offline_manager_select
	 * @Date : 2018. 7. 17.
	 * @User : 김지훈
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 오프라인 상담신청 중 하나의 상세정보를 조회하는 DAO
	 */
	public OfflineConsultingContents offline_manager_select(String seq) {
		logger.debug("오프라인 상담신청 중 하나의 상세정보를 조회하는 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		OfflineConsultingContents result = seaMapper.offline_manager_select(seq);
		logger.debug("오프라인 상담신청 중 하나의 상세정보를 조회하는 DAO 종료");
		return result;
	}

	/**
	 * @Method Name : offline_manager_mail_send
	 * @Date : 2018. 7. 18.
	 * @User : 김지훈
	 * @Param : occ 오프라인 상담 신청자의 정보를 담을 객체
	 * @Return : int update 성공 갯수를 반환
	 * @Method 설명 : 오프라인 상담 상세내용에 대한 메일답신내용을 DB에 저장
	 */
	public int offline_manager_mail_send(OfflineConsultingContents occ) {
		logger.debug("오프라인 상담 상세내용에 대한 메일답신내용을 DB에 저장하는 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		int result = seaMapper.offline_manager_mail_send(occ);
		logger.debug("오프라인 상담 상세내용에 대한 메일답신내용을 DB에 저장하는 DAO 종료");
		return result;
	}

	/**
	 * @Method Name : board_contents_delete
	 * @Date : 2018. 8. 23.
	 * @User : 김지훈
	 * @Param : 게시글 등록번호
	 * @Method 설명 : 게시글의 등록번호에 해당하는 DB Data 삭제
	 */
	public void board_contents_delete(int board_content_seq) {
		logger.debug("게시글 세부 내용 삭제 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.board_contents_delete(board_content_seq);
		
		logger.debug("게시글 세부 내용 삭제 DAO 함수 종료");
	}
	
	/**
	 * @Method Name : board_search_count
	 * @Date : 2018. 9. 13.
	 * @User : 정대영
	 * @Param : -
	 * @Return : 관리자 게시판의 모든 게시물 개수
	 * @Method 설명 : 관리자 게시판 진입 시 모든 게시물 개수 조회
	 */
	
	public int board_search_all_count(HashMap<String, Object> map){
		logger.debug("관리자 게시판 모든 게시물 개수 조회 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		int board_all_count = seaMapper.board_search_all_count(map);
		
		logger.debug("관리자 게시판 모든 게시물 개수 조회 DAO 함수 종료");
		return board_all_count;
	}
	
	/**
	 * @Method Name : board_search_all
	 * @Date : 2018. 9. 12.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 관리자 게시판의 모든 게시물
	 * @Method 설명 : 관리자 게시판 진입 시 모든 게시물 조회
	 */
	
	public ArrayList<BoardGroup> board_search_all(HashMap<String, Object> map){
		logger.debug("관리자 게시판 모든 게시물 조회 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<BoardGroup> resultList = seaMapper.board_search_all(map);
		
		logger.debug("관리자 게시판 모든 게시물 조회 DAO 함수 종료");
		return resultList;
	}
	
	/**
	 * 
	 * @Method Name : board_contents_count
	 * @Date : 2018. 9. 13.
	 * @User : 원병호
	 * @Param : 관리자 게시판 관리의 특정 게시판 정보 객체
	 * @Return : 관리자 게시판의 특정 게시판의 게시글 갯수
	 * @Method 설명 : 페이징을 위한 전체글 갯수 조회
	 */
	public int board_contents_count(HashMap<String, Object> map){
		logger.debug("관리자 게시판 특정 게시판 개시글 갯수 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		int result = seaMapper.board_contents_count(map);
		
		logger.debug("관리자 게시판 특정 게시판 개시글 갯수 DAO 함수 종료");
		return result;
	}
		
	/**
	 * @Method Name : curriculum_gisu_insert
	 * @Date : 2018. 9. 18.
	 * @User : 신동철
	 * @Param : 기수 정보 객체
	 * @Return : 기수 시퀀스
	 * @Method 설명 : 전달 받은 기수 정보를 등록하는 DAO 함수
	 */
	public void curriculum_gisu_insert(SocietyEduAdminCurriculumGisu seaCurGisu){
		logger.debug("기수 정보 등록 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.curriculum_gisu_insert(seaCurGisu);
		
		logger.debug("기수 정보 등록 DAO 종료");
	}
	
	/**
	 * 
	 * @Method Name : curriculum_gisu_img_insert
	 * @Date : 2018. 9. 18.
	 * @User : 신동철
	 * @Param : 기수 정보 이미지 객체
	 * @Return : -
	 * @Method 설명 : 기수 정보 이미지 등록
	 */
	public void curriculum_gisu_img_insert(ArrayList<SocietyEduAdminCurriculumGisuImg> seaCurGisuImgList){
		logger.debug("기수 정보 이미지 등록 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.curriculum_gisu_img_insert(seaCurGisuImgList);
		
		logger.debug("기수 정보 이미지 등록 DAO 함수 종료");
	}
	
	/**
	 * 
	 * @Method Name : curriculum_gisu_img_update
	 * @Date : 2018. 9. 18.
	 * @User : 신동철
	 * @Param : 기수 정보 이미지 객체
	 * @Return : -
	 * @Method 설명 : 기수 정보 이미지 수정
	 */
	public void curriculum_gisu_img_update(ArrayList<SocietyEduAdminCurriculumGisuImg> seaCurGisuImgList){
		logger.debug("기수 정보 이미지 등록 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.curriculum_gisu_img_update(seaCurGisuImgList);
		
		logger.debug("기수 정보 이미지 등록 DAO 함수 종료");
	}
	
	/**
	 * @Method Name : curriculum_gisu_img_delete
	 * @Date : 2018. 9. 18.
	 * @User : 신동철
	 * @Param : 기수 정보 이미지 객체
	 * @Return : -
	 * @Method 설명 : 기수 정보 이미지 삭제
	 */	
	public void curriculum_gisu_img_delete(SocietyEduAdminCurriculumGisuImg seaCurGisuImg){
		logger.debug("기수 정보 이미지 삭제 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.curriculum_gisu_img_delete(seaCurGisuImg);
		
		logger.debug("기수 정보 이미지 삭제 DAO 함수 종료");
	
	}
	
	/**
	 * @Method Name : curriculum_gisu_delete
	 * @Date : 2018. 9. 18
	 * @User : 신동철
	 * @Param : 기수 정보 객체
	 * @Return : -
	 * @Method 설명 : 기수 정보 삭제
	 */	
	public void curriculum_gisu_delete(int gisu_seq){
		logger.debug("기수 정보 삭제 DAO 함수 시작");
		
		SocietyEduAdminMapper  seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.curriculum_gisu_delete(gisu_seq);
		
		logger.debug("기수 정보 삭제 DAO 함수 종료");
		
	}
	
	/**
	 * @Method Name : subbanner_insert
	 * @Date : 2018. 9. 20.
	 * @User : 정대영
	 * @Param : 서브 배너 정보 객체
	 * @Return : -
	 * @Method 설명 : 서브 배너를 등록하는 DAO 함수 
	 */
	public void subbanner_insert(SocietyEduAdminSubBanner seaSb){
		logger.debug("서브 배너 등록 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.subbanner_insert(seaSb);
		
		logger.debug("서브 배너 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : subbanner_delete
	 * @Date : 2018. 10. 1.
	 * @User : 정대영
	 * @Param : 서브 배너 정보 시퀀스
	 * @Return : -
	 * @Method 설명 : 서브 배너를 삭제하는 DAO 함수 
	 */
	public void subbanner_delete(int edu_sub_ban_seq){
		logger.debug("서브 배너 삭제 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.subbanner_delete(edu_sub_ban_seq);
		
		logger.debug("서브 배너 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : subbanner_select_gisu_crc_nm
	 * @Date : 2018. 10. 1.
	 * @User : 정대영
	 * @Param : -
	 * @Return : 서브배너에서 참조할 기수 정보
	 * @Method 설명 : 서브배너에서 참조할 기수 정보 조회 DAO 함수 
	 */
	public ArrayList<String> subbanner_select_gisu_crc_nm(){
		logger.debug("서브배너에서 참조할 기수 정보 조회 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<String> resultList = seaMapper.subbanner_select_gisu_crc_nm();
		
		logger.debug("서브배너에서 참조할 기수 정보 조회 DAO 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : subbanner_list
	 * @Date : 2018. 9. 21.
	 * @User : 정대영
	 * @Param : -
	 * @Return : 테이블 내 모든 서브 배너 정보 객체
	 * @Method 설명 : 서브 배너를 출력하는 DAO 함수
	 */
	public ArrayList<SocietyEduAdminSubBanner> subbanner_list(){
		logger.debug("서브 배너를 출력하는 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<SocietyEduAdminSubBanner> resultList = seaMapper.subbanner_list();
		
		logger.debug("서브 배너를 출력하는 DAO 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : subbanner_update_select
	 * @Date : 2018. 9. 27.
	 * @User : 정대영
	 * @Param : 
	 * @Return : 수정 할 서브 배너 정보 객체 
	 * @Method 설명 : 서브 배너 수정 시 해당 서브 배너 객체 정보 객체 출력
	 */
	public SocietyEduAdminSubBanner subbanner_update_select(SocietyEduAdminSubBanner seaSb){
		logger.debug("수정 할 서브 배너 정보를 출력하는 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		SocietyEduAdminSubBanner result = seaMapper.subbanner_update_select(seaSb);
		
		logger.debug("수정 할 서브 배너 정보를 출력하는 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : subbanner_update
	 * @Date : 2018. 9. 28.
	 * @User : 정대영
	 * @Param : 서브 배너 정보 객체
	 * @Return : -
	 * @Method 설명 : 서브 배너를 수정하는 DAO 함수 
	 */
	public void subbanner_update(SocietyEduAdminSubBanner seaSb){
		logger.debug("서브 배너 수정 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.subbanner_update(seaSb);
		
		logger.debug("서브 배너 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : banner_insert
	 * @Date : 2018. 9. 27
	 * @User : 김준영
	 * @Param : 메인 배너 정보 객체
	 * @Return : -
	 * @Method 설명 : 메인 배너 정보 저장
	 */	
	public void banner_insert(SocietyEduAdminBanner seaB){
		logger.debug("메인 배너 등록 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.banner_insert(seaB);
		logger.debug("메인 배너 등록 DAO 종료");
	}
	
	/**
	 * @Method Name : banner_delete
	 * @Date : 2018. 10. 2.
	 * @User : 정대영
	 * @Param : 배너 정보 시퀀스
	 * @Return : -
	 * @Method 설명 : 배너를 삭제하는 DAO 함수 
	 */
	public void banner_delete(int edu_ban_seq){
		logger.debug("메인 배너 삭제 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.banner_delete(edu_ban_seq);
		
		logger.debug("메인 배너 삭제 DAO 종료");
	}
	
	/**
	 * @Method Name : banner_shown_list
	 * @Date : 2018. 9. 28.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 메인 배너 정보 객체
	 * @Method 설명 : 메인 배너 중 노출 되는 배너 객체
	 */	
	public ArrayList<SocietyEduAdminBanner> banner_shown_list(){
		logger.debug("메인 배너 중 노출 되는 리스트 출력 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<SocietyEduAdminBanner> banner_shown_list = seaMapper.banner_shown_list();
		logger.debug("메인 배너 중 노출 되는 리스트 출력 DAO 종료");
		return banner_shown_list;
	}
	
	/**
	 * @Method Name : banner_unshown_list
	 * @Date : 2018. 9. 28.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 메인 배너 정보 객체
	 * @Method 설명 : 메인 배너 중 노출 되지 않는 배너 객체
	 */	
	public ArrayList<SocietyEduAdminBanner> banner_unshown_list(){
		logger.debug("메인 배너 중 노출 되지 않는 리스트 출력 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<SocietyEduAdminBanner> banner_unshown_list = seaMapper.banner_unshown_list();
		logger.debug("메인 배너 중 노출 되지 않는 리스트 출력 DAO 종료");
		return banner_unshown_list;
	}
	
	/**
	 * @Method Name : curriculum_nm_list
	 * @Date : 2018. 9. 27.
	 * @User : 김준영
	 * @Param : -
	 * @Return : currculum_nm 리스트
	 * @Method 설명 : 메인 배너 등록시 기존 과정명 불러오기
	 */
	public ArrayList<String> curriculum_nm_list(){
		logger.debug("과정명 리스트 출력 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<String> curriculum_nm_list = seaMapper.curriculum_nm_list();
		logger.debug("과정명 리스트 출력 DAO 종료");
		return curriculum_nm_list;
	}
	
	/**
	 * @Method Name : banner_od_list
	 * @Date : 2018. 9. 28.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 메인 배너 사진 순서 리스트
	 * @Method 설명 : 메인 배너의 사진 순서를 리스트로 불러오기
	 */
	public ArrayList<Integer> banner_od_list(){
		logger.debug("메인 배너 사진 순서 리스트 출력 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<Integer> banner_od_list = seaMapper.banner_od_list();
		logger.debug("메인 배너 사진 순서 리스트 출력 DAO 종료");
		return banner_od_list;
	}
	
	/**
	 * @Method Name : banner_shown_update
	 * @Date : 2018. 9. 28.
	 * @User : 김준영
	 * @Param : 노출 여부와 순서 변경에 필요한 Map
	 * @Return : -
	 * @Method 설명 : 메인 배너 노출 변경 시 순서, 노출 여부 변경
	 */
	public void banner_shown_update(HashMap<String, Object> map){
		logger.debug("메인 배너 노출 변경 시 순서, 노출 여부 변경 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.banner_shown_update(map);
		logger.debug("메인 배너 노출 변경 시 순서, 노출 여부 변경 DAO 종료");
	}
	
	/**
	 * @Method Name : banner_ini
	 * @Date : 2018. 9. 28.
	 * @User : 김준영
	 * @Param : 수정인
	 * @Return : -
	 * @Method 설명 : 메인 배너 노출여부, 순서 초기화
	 */
	public void banner_ini(String edu_ban_udt_id){
		logger.debug("메인 배너 노출여부, 순서 초기화 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.banner_ini(edu_ban_udt_id);
		logger.debug("메인 배너 노출여부, 순서 초기화 DAO 종료");
	}
		
	/**
	 * @Method Name : subbanner_shown_list
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 서브 배너 정보 객체
	 * @Method 설명 : 서브 배너 중 노출 되는 서브 배너 객체
	 */	
	public ArrayList<SocietyEduAdminSubBanner> subbanner_shown_list(){
		logger.debug("서브 배너 중 노출 되는 리스트 출력 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<SocietyEduAdminSubBanner> subbanner_shown_list = seaMapper.subbanner_shown_list();
		logger.debug("서브 배너 중 노출 되는 리스트 출력 DAO 종료");
		return subbanner_shown_list;
	}
	
	/**
	 * @Method Name : subbanner_unshown_list
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 서브 배너 정보 객체
	 * @Method 설명 : 서브 배너 중 노출 되지 않는 서브 배너 객체
	 */	
	public ArrayList<SocietyEduAdminSubBanner> subbanner_unshown_list(){
		logger.debug("서브 배너 중 노출 되지 않는 리스트 출력 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<SocietyEduAdminSubBanner> subbanner_unshown_list = seaMapper.subbanner_unshown_list();
		logger.debug("서브 배너 중 노출 되지 않는 리스트 출력 DAO 종료");
		return subbanner_unshown_list;
	}
	
	/**
	 * @Method Name : subbanner_od_list
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 서브 배너 사진 순서 리스트
	 * @Method 설명 : 서브 배너의 사진 순서를 리스트로 불러오기
	 */
	public ArrayList<Integer> subbanner_od_list(){
		logger.debug("서브 배너 사진 순서 리스트 출력 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<Integer> subbanner_od_list = seaMapper.subbanner_od_list();
		logger.debug("서브 배너 사진 순서 리스트 출력 DAO 종료");
		return subbanner_od_list;
	}
	
	/**
	 * @Method Name : subbanner_shown_update
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : 서브 배너 노출 여부와 순서 변경에 필요한 Map
	 * @Return : -
	 * @Method 설명 : 서브 배너 노출 변경 시 순서, 노출 여부 변경
	 */
	public void subbanner_shown_update(HashMap<String, Object> map){
		logger.debug("서브 배너 노출 변경 시 순서, 노출 여부 변경 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.subbanner_shown_update(map);
		logger.debug("서브 배너 노출 변경 시 순서, 노출 여부 변경 DAO 종료");
	}
	
	/**
	 * @Method Name : subbanner_ini
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : 수정인
	 * @Return : -
	 * @Method 설명 : 서브 배너 노출여부, 순서 초기화
	 */
	public void subbanner_ini(String edu_sub_ban_udt_id){
		logger.debug("서브 배너 노출여부, 순서 초기화 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.subbanner_ini(edu_sub_ban_udt_id);
		logger.debug(" 서브 노출여부, 순서 초기화 DAO 종료");
	}
	
	/**
	 * @Method Name : banner_od_udt
	 * @Date : 2018. 10. 1.
	 * @User : 김준영
	 * @Param : 메인 배너의 seq, 순서
	 * @Return : -
	 * @Method 설명 : 메인 배너의 순서 수정
	 */
	public void banner_od_udt(HashMap<String, Object> map){
		logger.debug("메인 배너 순서 변경 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.banner_od_udt(map);
		logger.debug("메인 배너 순서 변경 DAO 종료");
	}
	
	/**
	 * @Method Name : banner_od_udt
	 * @Date : 2018. 10. 1.
	 * @User : 김준영
	 * @Param : 서브 배너의 seq, 순서
	 * @Return : -
	 * @Method 설명 : 서브 배너의 순서 수정
	 */
	public void subbanner_od_udt(HashMap<String, Object> map){
		logger.debug("메인 배너 순서 변경 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.subbanner_od_udt(map);
		logger.debug("메인 배너 순서 변경 DAO 종료");
	}
	
	/**
	 * @Method Name : banner_update_select
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : 수정 할 배너 정보 객체
	 * @Return : 
	 * @Method 설명 : 배너 수정 시 해당 배너 객체 정보 출력
	 */
	public SocietyEduAdminBanner banner_update_select(SocietyEduAdminBanner seaB){
		logger.debug("수정 할 배너 정보를 출력하는 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		SocietyEduAdminBanner result = seaMapper.banner_update_select(seaB);
		
		logger.debug("수정 할 배너 정보를 출력하는 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : banner_update
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : 배너 정보 객체
	 * @Return : -
	 * @Method 설명 : 배너를 수정하는 DAO 함수 
	 */
	public void banner_update(SocietyEduAdminBanner seaB){
		logger.debug("배너 수정 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.banner_update(seaB);
		
		logger.debug("배너 수정 DAO 종료");
	}
	
	/**
	 * @Method Name : select_gisu_crc_nm
	 * @Date : 2018. 10. 5.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 링크 관리 시 보여 줄  리스트
	 * @Method 설명 : 링크 관리 시 보여 줄  리스트 DAO 함수 
	 */
	public ArrayList<SocietyEduAdminCurriculumGisu> select_gisu_crc_nm(){
		logger.debug("링크 관리 시 보여 줄  리스트 DAO 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<SocietyEduAdminCurriculumGisu> resultList = seaMapper.select_gisu_crc_nm();
		
		logger.debug("링크 관리 시 보여 줄  리스트 DAO 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : select_curriculum
	 * @Date : 2018. 10. 8.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 과정 객체
	 * @Method 설명 : 과정의 seq, class, nm 가져오기
	 */
	public ArrayList<SocietyEduAdminCurriculum> select_curriculum(){
		logger.info("과정 가져오기 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<SocietyEduAdminCurriculum> select_curriculum = seaMapper.select_curriculum();
		logger.info("과정 가져오기 DAO 종료");
		return select_curriculum;
	}
	
	/**
	 * @Method Name : update_gisu_crc_division
	 * @Date : 2018. 10. 8.
	 * @User : 김준영
	 * @Param : 구분자, gisu_seq
	 * @Return : -
	 * @Method 설명 : 링크 등록과 삭제를 위한 함수
	 */
	public void update_gisu_crc_division(HashMap<String, Object> map){
		logger.info("링크 업데이트 DAO 시작");
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		seaMapper.update_gisu_crc_division(map);
		logger.info("링크 업데이트 DAO 종료");
	}
	
	/**
	 * @Method Name : company_board_contents_list_search
	 * @Date : 2019. 1. 24.
	 * @User : 신동철
	 * @Param : 게시판 시퀀스
	 * @Return : 관리자 잡페어 공지사항 게시판 리스트
	 * @Method 설명 : 관리자 잡페어 공지사항 게시판 리스트 검색 함수
	 */
	public ArrayList<BoardContent> company_board_contents_list_search(HashMap<String, Object> map){
		logger.debug("잡페어 채용기업 메인 공지사항 리스트 검색 DAO 함수 시작");
		
		SocietyEduAdminMapper seaMapper = sqlSession.getMapper(SocietyEduAdminMapper.class);
		ArrayList<BoardContent> resultList = seaMapper.company_board_contents_list_search(map);
		
		logger.debug("잡페어 채용기업 메인 공지사항 리스트 검색 DAO 함수 종료");
		
		return resultList;
	}
	
	
}
