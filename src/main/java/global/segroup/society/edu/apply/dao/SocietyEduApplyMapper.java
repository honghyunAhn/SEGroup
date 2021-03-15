/**
 * 
 */
package global.segroup.society.edu.apply.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import global.segroup.domain.FaqConsultingContents;
import global.segroup.domain.OfflineConsultingContents;
import global.segroup.domain.OnlineConsultingContents;
import global.segroup.domain.User;
import global.segroup.society.edu.admin.domain.SocietyEduAdminCurriculumGisu;
import global.segroup.society.edu.admin.domain.SocietyEduAdminPayment;
import global.segroup.society.edu.apply.domain.SocietyEduApplyForm;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 31.
 * @Class 설명 : Soft Engineer Society 모집홍보 매퍼
 * 
 */
public interface SocietyEduApplyMapper {
	public void insertEduApplyForm(SocietyEduApplyForm seaForm);
	public void insertEduApplyEduHistory(HashMap<String, Object> eduHistoryMap);
	public void insertEduApplyCareer(HashMap<String, Object> eduCareerMap);
	public void insertEduApplyStudy(HashMap<String, Object> eduStudyMap);
	public void insertEduApplyLanguage(HashMap<String, Object> eduLanguageMap);
	public void insertEduApplyLicense(HashMap<String, Object> eduLicenseMap);
	public void insertEduApplyOverseas(HashMap<String, Object> eduOverseasMap);
	public void insertEduApplyFile(HashMap<String, Object> eduFileMap);
	public void insertEduApplyResult(int app_seq);
	public HashMap<String, Object> selectEduApply(HashMap<String, Object> param);
	public void deleteEduApplyForm(HashMap<String, Object> param);
	// ArrayList<HashMap> -> 그냥 HashMap으로 수정; 2018. 10. 10. 김준영
	public HashMap<String, Object> selectLongTermList(String user_id, String gisu_crc_class, String division);
	public ArrayList<HashMap<String, Object>> selectShortTermList(String user_id, String gisu_crc_class);
	public ArrayList<HashMap<String, Object>> selectShortTermInfo(String gisu_crc_class);
	public HashMap<String, Object> selectEduApplyResult(HashMap<String, Object> param);
	public ArrayList<HashMap<String, Object>> selectImageNoticeList(String user_id);
	public int countBoard(HashMap<String, Object> param);
	public List<HashMap<String, Object>> boardListAll(HashMap<String, Object> param);
	public HashMap<String, Object> boardDetail(HashMap<String, Object> param);
	public void boardHit(int board_content_hit);
	public ArrayList<HashMap<String, Object>> boardFile(HashMap<String, Object> param);
	public HashMap<String, Object> boardFileDetail(HashMap<String, Object> param);
	public int deleteUserDataRemoveMasterApply(User user);
	public int faq_consulting_countBoard(HashMap<String, Object> param);
	public List<HashMap<String, Object>> faq_consulting_boardListAll(HashMap<String, Object> param);
	public int online_consulting_countBoard(HashMap<String, Object> param);
	public List<HashMap<String, Object>> online_consulting_boardListAll(HashMap<String, Object> param);
	public HashMap<String, Object> online_consulting_boardDetail(HashMap<String, Object> param);
	public void online_consulting_hit_update(int consulting_seq);
	public int insertApplyOnlineContents(OnlineConsultingContents occ);
	public int updateApplyOnlineContents(OnlineConsultingContents occ);
	public int deleteApplyOnlineContents(OnlineConsultingContents occ);
	public int insertApplyOfflineContents(OfflineConsultingContents occ);
	public SocietyEduAdminCurriculumGisu searchCurGisu(int gisu_seq);
	public ArrayList<HashMap<String, Object>> main_mediainit_list();
	public ArrayList<HashMap<String, Object>> main_graduate_list();
	public ArrayList<HashMap<String, Object>> main_notice_list();
	public ArrayList<HashMap<String, Object>> main_faq_list();
	public SocietyEduAdminPayment selectShortTermPayInfo(String gisu_seq);
	
	/**
	 * @Method Name : seoul_img_select
	 * @Date : 2018. 10. 10.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 
	 * @Method 설명 : 서울 링크 클릭시 배너 관리에 등록되어있는 기수 이미지를 가져옴
	 */
	public ArrayList<String> seoul_img_select();
	
	/**
	 * @Method Name : gwangju_img_select
	 * @Date : 2018. 10. 10.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 
	 * @Method 설명 : 광주 링크 클릭시 배너 관리에 등록되어있는 기수 이미지를 가져옴
	 */
	public ArrayList<String> gwangju_img_select();
	
	public ArrayList<FaqConsultingContents> faq_test_search(FaqConsultingContents consultingTp); //test용
}
