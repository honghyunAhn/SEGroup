/**
 * 
 */
package global.segroup.society.edu.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import global.segroup.domain.Admin;
import global.segroup.domain.BoardContent;
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
 * @Class 설명 : Soft Engineer Society 모집홍보 관리자 매퍼
 * 
 */
public interface SocietyEduAdminMapper {
	public void curriculum_insert(SocietyEduAdminCurriculum seaCur);
	public void payInfoInsert(List<SocietyEduAdminPayment> list);
	public SocietyEduAdminCurriculum searchCurriculum(int crc_seq);
	public ArrayList<HashMap<String, Object>> searchCurriculumGisuOrder(int gisu_seq);
	public ArrayList<SocietyEduAdminCurriculumGisu> searchCurGisuList(int crc_seq);
	public ArrayList<SocietyEduAdminCurriculum> searchCurriculumAll(HashMap<String,Object> map);
	public int searchCurriculumAllCount();
	public ArrayList<SocietyEduAdminCurriculum> searchCurriculumPermission();
	public ArrayList<SocietyEduAdminCurriculumGisu> searchCurriculumGisuAll(HashMap<String,Object> map);
	public int searchCurriculumGisuAllCount(HashMap<String, Object> map);
	public void curriculum_update(SocietyEduAdminCurriculum seaCur);
	public SocietyEduAdminCurriculumGisu searchCurGisu(int gisu_seq);
	/*public void curriculum_gisu_insert(SocietyEduAdminCurriculumGisu seaCurGisu);*/
	public void curriculum_gisu_update(SocietyEduAdminCurriculumGisu seaCurGisu);
	public void curriculum_permission_update(SocietyEduAdminCurriculum seaCur);
	public void curriculum_gisu_permission_update(SocietyEduAdminCurriculumGisu seaCurGisu);
	public int curriculum_apply_select(int crc_seq);
	public int curriculum_gisu_apply_select(int gisu_seq);
	public ArrayList<HashMap<String, Object>> apply_manager_select(HashMap<String,Object> map);
	public int apply_manager_select_count(HashMap<String,Object> map);
	public ArrayList<HashMap<String, Object>> paid_manager_select(HashMap<String, Object> map);
	public ArrayList<HashMap<String, Object>> refund_manager_select(HashMap<String, Object> map);
	public ArrayList<HashMap<String, Object>> paid_name_select(HashMap<String, Object> map);
	public ArrayList<HashMap<String, Object>> refund_name_select(HashMap<String, Object> map);
	public ArrayList<HashMap<String, Object>> searchCurriculumRefund();
	public void eduApply_result_update(SocietyEduApplyResult seaResult);
	public ArrayList<BoardGroup> board_name_search(BoardGroup boardGb);
	public BoardGroup board_gb_search(BoardGroup boardGb);
	public ArrayList<BoardContent> board_contents_search(HashMap<String, Object> map);
	public void board_contents_hit_update(int board_content_seq);
	public HashMap<String, Object> board_contents_detail(int board_content_seq);
	public void board_contents_insert(BoardContent boardContent);
	public void board_contents_update(BoardContent boardContent);
	public void board_contents_delete(int board_content_seq);
	public void board_contents_file_delete(BoardContent boardContent);
	public void board_contents_file_insert(HashMap<String, Object> map);
	public List<HashMap<String, Object>> selectPayInfo(String gisu_seq);
	public void payInfoDelete(String seq);
	public int basic_user_select_all_count(HashMap<String, Object> map);
	public ArrayList<User> basic_user_select_all(HashMap<String,Object> map);
	public int refund_status_update(RefundInfo pay_refund_seq);
	public int refund_memo_update(RefundInfo refundInfo);
	public List<HashMap<String, Object>> refund_manager_list(HashMap<String, Object> map);
	public int delete_pay_info(int pay_user_seq);
	public List<HashMap<String, Object>> selectPayByGisu(int gisu_seq);
	public int insert_refund_temp(int pay_user_seq);
	public int paid_manager_select_count(HashMap<String, Object> map);
	public int refund_manager_list_count(HashMap<String, Object> map);
	public HashMap<String, Object> selectEduApplyUpdateForm(HashMap<String, Object> map);
	public int user_info_update(User user);
	public int faq_manager_select_count(HashMap<String, Object> map);
	public ArrayList<FaqConsultingContents> faq_manager_select_all(HashMap<String, Object> map);
	public FaqConsultingContents faq_manager_select(int consulting_seq);
	public HashMap<String, Object> faq_manager_detail(int consulting_seq);
	public void faq_manager_contents_insert(FaqConsultingContents consultingContent);
	public void faq_manager_contents_update(FaqConsultingContents consultingContent);
	public void online_manager_hit_update(int consulting_seq);
	public HashMap<String, Object> online_manager_detail(int consulting_seq);
	public int online_manager_select_count(HashMap<String, Object> map);
	public ArrayList<OnlineConsultingContents> online_manager_select_all(HashMap<String, Object> map);
	public OnlineConsultingContents online_manager_select(int consulting_seq);
	public void online_manager_contents_insert(OnlineConsultingContents consultingContent);
	public void online_manager_contents_update(OnlineConsultingContents consultingContent);
	public void online_manager_reply_insert(OnlineConsultingContents consultingContent);
	public void online_manager_reply_update(OnlineConsultingContents consultingContent);
	public int offline_manager_select_count(HashMap<String, Object> map);
	public ArrayList<OfflineConsultingContents> offline_manager_select_all(HashMap<String, Object> map);
	public OfflineConsultingContents offline_manager_select(String seq);
	public int offline_manager_mail_send(OfflineConsultingContents occ);
	/**
	 * @Method Name : select_refund_user_id
	 * @Date : 2018. 8. 20.
	 * @User : 이종호
	 * @Param : 환불 시퀀스
	 * @Return : 환불 받을 유저 아이디
	 * @Method 설명 : 환불 시퀀스로 환불 받을 유저 아이디 검색 (유저 권한 변경 시 사용)
	 */
	public RefundInfo select_refund_user_id(int pay_refund_seq);
	
	/**
	 * @Method Name : board_search_count
	 * @Date : 2018. 9. 13
	 * @User : 정대영
	 * @Param : -
	 * @Return : 관리자 게시판의 모든 게시물 개수
	 * @Method 설명 : 관리자 게시판 진입 시 모든 게시물 개수 조회
	 */
	public int board_search_all_count(HashMap<String, Object> map);
	
	/**
	 * @Method Name : board_search_all
	 * @Date : 2018. 9. 12
	 * @User : 김준영
	 * @Param : -
	 * @Return : 관리자 게시판의 모든 게시물
	 * @Method 설명 : 관리자 게시판 진입 시 모든 게시물 조회
	 */
	public ArrayList<BoardGroup> board_search_all(HashMap<String, Object> map);
	
	/**
	 * 
	 * @Method Name : board_contents_count
	 * @Date : 2018. 9. 13.
	 * @User : 원병호
	 * @Param : 관리자 게시판 관리의 특정 게시판 정보 객체
	 * @Return : 관리자 게시판의 특정 게시판의 게시글 갯수
	 * @Method 설명 : 페이징을 위한 전체글 갯수 조회
	 */
	public int board_contents_count(HashMap<String, Object> map);
	
	/**
	 * @Method Name : admin_insert
	 * @Date : 2018. 9. 17
	 * @User : 이종호
	 * @Param : 관리자 정보
	 * @Return : -
	 * @Method 설명 : 관리자 회원 가입
	 */
	public void admin_insert(Admin admin);
	
	/**
	 * @Method Name : admin_info_list_select
	 * @Date : 2018. 9. 17
	 * @User : 이종호
	 * @Param : 페이징 및 검색어
	 * @Return : 관리자 정보 리스트
	 * @Method 설명 : 관리자 정보 리스트 조회
	 */
	public ArrayList<Admin> admin_info_list_select(HashMap<String, Object> map);

	/**
	 * @Method Name : admin_info_list_select_count
	 * @Date : 2018. 9. 17
	 * @User : 이종호
	 * @Param : 관리자 이름 (검색어)
	 * @Return : 관리자 정보 전체 개수(검색된)
	 * @Method 설명 : 관리자 정보 전체 개수 조회
	 */
	public int admin_info_list_select_count(HashMap<String, Object> map);
	
	/**
	 * @Method Name : admin_info_update
	 * @Date : 2018. 9. 17
	 * @User : 이종호
	 * @Param : 관리자 정보 공통코드 (권한 , 상태 , 프로젝트) 및 권한기간
	 * @Return : -
	 * @Method 설명 : 관리자 정보 수정
	 */	
	public void admin_info_update(Admin admin);
		
	/**
	 * @Method Name : curriculum_gisu_insert
	 * @Date : 2018. 9. 18
	 * @User : 신동철
	 * @Param : 기수 정보 객체
	 * @Return : 기수 시퀀스
	 * @Method 설명 : 기수 정보 등록
	 */	
	public void curriculum_gisu_insert(SocietyEduAdminCurriculumGisu seaCurGisu);
		
	/**
	 * @Method Name : curriculum_gisu_img_insert
	 * @Date : 2018. 9. 18
	 * @User : 신동철
	 * @Param : 기수 정보 이미지 객체
	 * @Return : -
	 * @Method 설명 : 기수 정보 이미지 등록
	 */	
	public void curriculum_gisu_img_insert(ArrayList<SocietyEduAdminCurriculumGisuImg> seaCurGisuImgList);
	
	/**
	 * @Method Name : curriculum_gisu_img_update
	 * @Date : 2018. 10. 1
	 * @User : 신동철
	 * @Param : 기수 정보 이미지 객체
	 * @Return : -
	 * @Method 설명 : 기수 정보 이미지 수정
	 */	
	public void curriculum_gisu_img_update(ArrayList<SocietyEduAdminCurriculumGisuImg> seaCurGisuImgList);
	
	/**
	 * @Method Name : searchCurGisuImgList
	 * @Date : 2018. 9.28.
	 * @User : 신동철
	 * @Param : 과정 시퀀스 정보
	 * @Return : 검색된 기수 이미지 정보 리스트 객체
	 * @Method 설명 : 과정 시퀀스 정보에 해당하는 기수 이미지 정보들을 조회
	 */
	public ArrayList<SocietyEduAdminCurriculumGisuImg> searchCurGisuImgList(int gisu_seq);
		
	/**
	 * @Method Name : curriculum_gisu_img_delete
	 * @Date : 2018. 9. 18
	 * @User : 신동철
	 * @Param : 기수 정보 이미지 객체
	 * @Return : -
	 * @Method 설명 : 기수 정보 이미지 삭제
	 */	
	public void curriculum_gisu_img_delete(SocietyEduAdminCurriculumGisuImg seaCurGisuImg);
	
	/**
	 * @Method Name : curriculum_gisu_delete
	 * @Date : 2018. 9. 18
	 * @User : 신동철
	 * @Param : 기수 정보 객체
	 * @Return : -
	 * @Method 설명 : 기수 정보 삭제
	 */	
	public void curriculum_gisu_delete(int gisu_seq);
	
	/**
	 * @Method Name : subbanner_select_gisu_crc_nm
	 * @Date : 2018. 10. 1
	 * @User : 정대영
	 * @Param : -
	 * @Return : 서브배너에서 참조할 기수 정보
	 * @Method 설명 : 서브배너에서 참조할 기수 정보 조회
	 */	
	public ArrayList<String> subbanner_select_gisu_crc_nm();
	
	/**
	 * @Method Name : subbanner_insert
	 * @Date : 2018. 9. 20
	 * @User : 정대영
	 * @Param : 서브 배너 정보 객체
	 * @Return : -
	 * @Method 설명 : 서브 배너 정보 저장
	 */	
	public int subbanner_insert(SocietyEduAdminSubBanner seaSb);
	
	/**
	 * @Method Name : subbanner_delete
	 * @Date : 2018. 10. 1
	 * @User : 정대영
	 * @Param : 서브 배너 정보 시퀀스
	 * @Return : -
	 * @Method 설명 : 서브 배너 정보 삭제
	 */	
	public int subbanner_delete(int edu_sub_ban_seq);
	
	/**
	 * @Method Name : subbanner_list
	 * @Date : 2018. 9. 21
	 * @User : 정대영
	 * @Param : -
	 * @Return : 테이블 내 모든 서브 배너 정보 객체
	 * @Method 설명 : 서브 배너 정보 리스트 출력
	 */	
	public ArrayList<SocietyEduAdminSubBanner> subbanner_list();
	
	/**
	 * @Method Name : subbanner_update_select
	 * @Date : 2018. 9. 27
	 * @User : 정대영
	 * @Param : -
	 * @Return : 수정 할 서브 배너 정보 객체  
	 * @Method 설명 : 서브 배너 수정 시 해당 서브 배너 객체 정보 객체 출력
	 */	
	public SocietyEduAdminSubBanner subbanner_update_select(SocietyEduAdminSubBanner seaSb);
	
	/**
	 * @Method Name : subbanner_update
	 * @Date : 2018. 9. 28
	 * @User : 정대영
	 * @Param : 서브 배너 정보 객체
	 * @Return : -
	 * @Method 설명 : 서브 배너 정보 수정
	 */	
	public int subbanner_update(SocietyEduAdminSubBanner seaSb);
	
	/**
	 * @Method Name : banner_insert
	 * @Date : 2018. 9. 27.
	 * @User : 김준영
	 * @Param : 메인 배너 정보 객체
	 * @Return : -
	 * @Method 설명 : 메인 배너 정보 저장
	 */	
	public void banner_insert(SocietyEduAdminBanner seaB);
	
	/**
	 * @Method Name : banner_shown_list
	 * @Date : 2018. 9. 28.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 메인 배너 정보 객체
	 * @Method 설명 : 메인 배너 중 노출 되는 배너 객체
	 */	
	public ArrayList<SocietyEduAdminBanner> banner_shown_list();
	
	/**
	 * @Method Name : banner_unshown_list
	 * @Date : 2018. 9. 28.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 메인 배너 정보 객체
	 * @Method 설명 : 메인 배너 중 노출 되지 않는 배너 객체
	 */	
	public ArrayList<SocietyEduAdminBanner> banner_unshown_list();
	
	 /**
	 * @Method Name : curriculum_nm_list
	 * @Date : 2018. 9. 27.
	 * @User : 김준영
	 * @Param : -
	 * @Return : currculum_nm 리스트
	 * @Method 설명 : 메인 배너 등록시 기존 과정명 불러오기
	 */	
	public ArrayList<String> curriculum_nm_list();
	
	/**
	 * @Method Name : banner_od_list
	 * @Date : 2018. 9. 28.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 메인 배너 사진 순서 리스트
	 * @Method 설명 : 메인 배너의 사진 순서를 리스트로 불러오기
	 */
	public ArrayList<Integer> banner_od_list();
	
	/**
	 * @Method Name : banner_shown_update
	 * @Date : 2018. 9. 28.
	 * @User : 김준영
	 * @Param : 노출 여부와 순서 변경에 필요한 Map
	 * @Return : -
	 * @Method 설명 : 메인 배너 노출 변경 시 순서, 노출 여부 변경
	 */
	public void banner_shown_update(HashMap<String, Object> map);
	
	/**
	 * @Method Name : banner_ini
	 * @Date : 2018. 9. 28.
	 * @User : 김준영
	 * @Param : 수정인
	 * @Return : -
	 * @Method 설명 : 메인 배너 노출여부, 순서 초기화
	 */
	public void banner_ini(String edu_ban_udt_id);
	
	/**
	 * @Method Name : subbanner_shown_list
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 서브 배너 정보 객체
	 * @Method 설명 : 서브 배너 중 노출 되는 배너 객체
	 */	
	public ArrayList<SocietyEduAdminSubBanner> subbanner_shown_list();

	/**
	 * @Method Name : subbanner_unshown_list
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 서브 배너 정보 객체
	 * @Method 설명 : 서브 배너 중 노출 되지 않는 배너 객체
	 */	
	public ArrayList<SocietyEduAdminSubBanner> subbanner_unshown_list();

	/**
	 * @Method Name : subbanner_od_list
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 서브 배너 사진 순서 리스트
	 * @Method 설명 : 서브 배너의 사진 순서를 리스트로 불러오기
	 */
	public ArrayList<Integer> subbanner_od_list();
	
	/**
	 * @Method Name : subbanner_shown_update
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : 서브 배너 노출 여부와 순서 변경에 필요한 Map
	 * @Return : -
	 * @Method 설명 : 서브 배너 노출 변경 시 순서, 노출 여부 변경
	 */
	public void subbanner_shown_update(HashMap<String, Object> map);
	
	/**
	 * @Method Name : subbanner_ini
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : 수정인
	 * @Return : -
	 * @Method 설명 : 서브 배너 노출여부, 순서 초기화
	 */
	public void subbanner_ini(String edu_sub_ban_udt_id);
	
	/**
	 * @Method Name : banner_od_udt
	 * @Date : 2018. 10. 1.
	 * @User : 김준영
	 * @Param : 메인 배너의 seq, 순서
	 * @Return : -
	 * @Method 설명 : 메인 배너의 순서 수정
	 */
	public void banner_od_udt(HashMap<String, Object> map);
	
	/**
	 * @Method Name : subbanner_od_udt
	 * @Date : 2018. 10. 1.
	 * @User : 김준영
	 * @Param : 서브 배너의 seq, 순서
	 * @Return : -
	 * @Method 설명 : 서브 배너의 순서 수정
	 */
	public void subbanner_od_udt(HashMap<String, Object> map);
	
	/**
	 * @Method Name : banner_update_select
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 수정 할 배너 정보 객체  
	 * @Method 설명 : 배너 수정 시 해당 배너 객체 정보 출력
	 */	
	public SocietyEduAdminBanner banner_update_select(SocietyEduAdminBanner seaB);
	
	/**
	 * @Method Name : banner_update
	 * @Date : 2018. 10. 1.
	 * @User : 이재준
	 * @Param : 배너 정보 객체
	 * @Return : -
	 * @Method 설명 : 배너 정보 수정
	 */	
	public int banner_update(SocietyEduAdminBanner seaB);
	
	/**
	 * @Method Name : select_gisu_crc_nm
	 * @Date : 2018. 10. 5.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 링크 관리 시 보여 줄  리스트
	 * @Method 설명 : 링크 관리 시 보여 줄  리스트
	 */	
	public ArrayList<SocietyEduAdminCurriculumGisu> select_gisu_crc_nm();
	
	/**
	 * @Method Name : banner_delete
	 * @Date : 2018. 10. 2
	 * @User : 정대영
	 * @Param : 배너 정보 시퀀스
	 * @Return : -
	 * @Method 설명 : 배너 정보 삭제
	 */	
	public int banner_delete(int edu_ban_seq);
	
	/**
	 * @Method Name : select_curriculum
	 * @Date : 2018. 10. 8.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 과정 객체
	 * @Method 설명 : 과정의 seq, class, nm 가져오기
	 */
	public ArrayList<SocietyEduAdminCurriculum> select_curriculum();
	
	/**
	 * @Method Name : update_gisu_crc_division
	 * @Date : 2018. 10. 8.
	 * @User : 김준영
	 * @Param : 구분자, gisu_seq
	 * @Return : -
	 * @Method 설명 : 링크 등록과 삭제를 위한 함수
	 */
	public void update_gisu_crc_division(HashMap<String, Object> map);
	
	/**
	 * @Method Name : company_board_contents_search
	 * @Date : 2019. 1. 23.
	 * @User : 신동철
	 * @Param : 게시판 시퀀스
	 * @Return : 잡페어 채용기업 메인 공지사항 정보
	 * @Method 설명 : 잡페어 채용기업 메인 공지사항 검색 서비스함수
	 */
	public ArrayList<BoardContent> company_board_contents_search(HashMap<String, Object> map);
	
	/**
	 * @Method Name : company_board_contents_list_search
	 * @Date : 2019. 1. 24.
	 * @User : 신동철
	 * @Param : 게시판 시퀀스
	 * @Return : 관리자 잡페어 공지사항 게시판 리스트
	 * @Method 설명 : 관리자 잡페어 공지사항 게시판 리스트 검색 함수
	 */
	public ArrayList<BoardContent> company_board_contents_list_search(HashMap<String, Object> map);
	
}
