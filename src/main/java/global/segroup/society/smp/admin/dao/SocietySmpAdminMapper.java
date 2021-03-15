package global.segroup.society.smp.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

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
import global.segroup.society.smp.admin.domain.SocietySmpStudentForm;

/**
 * @Author : 여명환
 * @Date : 2018. 8. 20.
 * @Class 설명 : Soft Engineer Society 학사관리 매퍼
 * 
 */
public interface SocietySmpAdminMapper {
	public ArrayList<HashMap<String, Object>> smp_student_select(HashMap<String,Object> map);	//여명환
	public int smp_manager_select_count(HashMap<String,Object> map);//여명환
	public void insertCopyEduApplyForm(int app_seq);	//여명환
	public void insertCopyEduApplyEduHistory(int app_seq);//여명환
	public void insertCopyEduApplyCareer(int app_seq);//여명환
	public void insertCopyEduApplyStudy(int app_seq);//여명환
	public void insertCopyEduApplyLanguage(int app_seq);//여명환
	public void insertCopyEduApplyLicense(int app_seq);//여명환
	public void insertCopyEduApplyOverseas(int app_seq);//여명환
	public void insertCopyEduApplyFile(int app_seq);//여명환
	public HashMap<String, Object> selectSmpStudentUpdateForm(HashMap<String, Object> map);//여명환
	public void insertSmpStudentForm(SocietySmpStudentForm seaForm);	//여명환
	public void insertSmpStudentEduHistory(HashMap<String, Object> eduHistoryMap);//여명환
	public void insertSmpStudentCareer(HashMap<String, Object> eduCareerMap);//여명환
	public void insertSmpStudentStudy(HashMap<String, Object> eduStudyMap);//여명환
	public void insertSmpStudentLanguage(HashMap<String, Object> eduLanguageMap);//여명환
	public void insertSmpStudentLicense(HashMap<String, Object> eduLicenseMap);//여명환
	public void insertSmpStudentOverseas(HashMap<String, Object> eduOverseasMap);//여명환
	public void insertSmpStudentFile(HashMap<String, Object> eduFileMap);//여명환
	public void deleteSmpStudentForm(int smp_seq); // 여명환
	public List<HashMap<String, Object>> smpMainBoardListAll(HashMap<String, Object> param);//여명환
	public String smp_select_gisu_seq(); // 여명환
	public HashMap<String, Object> smp_select_print_student(String app_id);//여명환
	public int smp_check_student(SocietyEduApplyForm sf); //여명환
	public void smp_board_contents_delete(int board_content_seq); //여명환
	public void smp_board_gisu_delete(int board_content_seq); //여명환
	public void board_contents_file_delete(int board_content_seq); //여명환
	public ArrayList<BoardContent> selectMainPageBoard(int gisu_seq); //여명환
	public int selectSmpNumberOfStudent(); // 여명환
	public int smp_insert_memo(HashMap<String, Object> memo); // 여명환
	public String smp_select_memo(String memo); // 여명환
	public ArrayList<String> getApsTotal(); //여명환
	//public ArrayList<String> getApsGroup(); 여명환
	public ArrayList<String> getApsDetail(); //여명환
	public int selectGisuNumberOfTotal(int gisu_seq); //여명환
	public int selectGisuNumberOfGroup(String gisu_seq); //여명환
	public int selectGisuNumberOfDetail(String gisu_seq); //여명환
	public ArrayList<HashMap<String, Object>> selectAPSTotal(int gisu_seq); //여명환
	
	//public ArrayList<HashMap<String, Object>> selectAPSDetail(HashMap<String, Object> map); //여명환
	public int deleteTotal(String smp_aps_total_seq); // 여명환
	public int deleteGroup(String smp_aps_group_seq); // 여명환
	public int deleteDetail(String smp_aps_detail_seq); // 여명환
	
	
	public List<SocietySmpScheduleScheduleColor> selectAllSocietySmpSchedule(int gisu_seq); //박찬주
	public int deleteSocietySmpSchedule(int smp_sch_seq); //박찬주
	public int updateSocietySmpSchedule(SocietySmpScheduleScheduleColor sche); //박찬주
	public int insertSocietySmpSchedule(SocietySmpScheduleScheduleColor sche); //박찬주
	public List<SocietySmpScheduleScheduleColor> monthEventSelect(SocietySmpSchedule sche); //박찬주
	public SocietyEduAdminCurriculumGisu selectSocietySmpUserGisuNum(String app_id); //박찬주
	public List<SocietyEduAdminCurriculumGisu> selectGisuSeqNumList(); //박찬주
	public int selectGisuNum(int gisu_seq); //박찬주
	public List<SocietySmpScheduleColor> gisuTitleCheck(int gisu); //박찬주
	public int schColorInsert(List<SocietySmpScheduleColor> lssSchColor); //박찬주
	public int schColorUpdate(SocietySmpScheduleColor ssSchColor); //박찬주
	public int schColorDelete(int smp_sch_color_seq);
	
	public void smp_board_contents_insert(BoardContent boardContent);//전희배
	public String smp_select_admin_nm(String admin_id);//전희배
	public void smp_board_contents_update(BoardContent boardContent);//전희배
	
	public ArrayList<HashMap<String, Object>> board_gisu_search();//전희배
	public List<HashMap<String, Object>> smpBoardListAll(RowBounds rb,HashMap<String, Object> param);//전희배
	public int gettotal(HashMap<String, Object> param);//전희배
	public void insertBoardGisu(HashMap<String, Object> param);//전희배
	
	public ArrayList<HashMap<String, Object>> selectApsTotalNm(int gisu_seq);//전희배
	public ArrayList<HashMap<String, Object>> selectApsGroupNm(int smp_aps_total_seq);//전희배
	public ArrayList<HashMap<String, Object>> selectApsDetailNm(int smp_aps_group_seq);//전희배
	public void insertSmpApsTotal(HashMap<String, Object> param);//강인석
	
	public ArrayList<HashMap<String, Object>> selectAPSGroup(int gisu_seq); //김홍일
	public ArrayList<HashMap<String, Object>> selectAPSDetail(int smp_aps_total_seq); //김홍일;
	
	public void insertSmpApsGroup(SocietySmpApsGroup societySmpApsGroup);//김홍일
	public void insertSmpApsGroupExam(SocietySmpApsGroupExam societySmpApsGroupExam);//김홍일
	public void insertSmpApsGroupSubexam(SocietySmpApsGroupSubexam societySmpApsGroupSubexam);//김홍일
	public void insertSmpApsGroupConfirmation(SocietySmpApsGroupConfirmation societySmpApsGroupConfirmation);//김홍일
	
	public void insertSmpApsDetail(HashMap<String, Object> param);//강인석
	public void insertSmpApsDetailExam(SocietySmpApsDetailExam societySmpApsDetailExam);//김홍일
	public void insertSmpApsDetailSubexam(SocietySmpApsDetailSubexam SocietySmpApsDetailSubexam);//김홍일
	
	public HashMap<String, Object> selectApsTotalDetail(HashMap<String, Object> param); //전희배
	public HashMap<String, Object> selectApsGroupDetail(HashMap<String, Object> param); //전희배
	public HashMap<String, Object> selectApsDetailDetail(HashMap<String, Object> param); //전희배
	
	public void updateApsTotal(HashMap<String, Object> param); //전희배
	public void updateApsGroup(HashMap<String, Object> param); //전희배
	public void updateApsDetail(HashMap<String, Object> param); //전희배
	
	public List<SocietySmpApsSetList> selectSmpApsSetList(); //박찬주
	public int deleteSmpApsTotal(int gisu_seq); //박찬주
	public List<SocietySmpApsSetTotal> selectSmpApsSetTotal(int smp_aps_setlist_seq); //박찬주
	public List<SocietySmpApsSetDetail> selectSmpApsSetDetail(int smp_aps_setgroup_seq); //김진환
	public List<SocietySmpApsSetTotal> selectSetTotal(); //김진환
	public List<SocietySmpApsSetGroup> selectSmpApsSetGroup(int smp_aps_settotal_seq); //김진환
	
	public List<SocietySmpApsTotal> selectApsTotalListByGisuSeq(int gisu_seq); //박찬주
	/*public List<SocietySmpApsGroup> selectApsGroupList(int smp_aps_total_seq);*/ //박찬주
	public ArrayList<HashMap<String, Object>> selectApsGroupList(HashMap<String, Object> params); //김홍일
	public List<SocietySmpApsDetail> selectApsDetailList(int smp_aps_group_seq); //박찬주
	
	public void insertApsTotalSetting(SocietySmpApsTotal total); //박찬주
	public void insertApsGroupSetting(SocietySmpApsGroup group); //박찬주
	public void insertApsDetailSetting(SocietySmpApsDetail detail); //박찬주
	
	public int insertApsSetList(SocietySmpApsSetList SMPApsSetList); //박찬주
	public int insertApsSetTotal(SocietySmpApsSetTotal SMPApsSetTotal); //박찬주
	public int insertApsSetGroup(SocietySmpApsSetGroup SMPApsSetGroup); //박찬주
	public int insertApsSetDetail(SocietySmpApsSetDetail SMPApsSetDetail); //박찬주

	public List<String> selectTotalOverlap(HashMap<String, Object> param);//전희배
	public List<String> selectGroupOverlap(HashMap<String, Object> param);//전희배
	public List<String> selectDetailOverlap(HashMap<String, Object> param);//전희배
	
	public int sumTotalRatio(HashMap<String, Object> param);//전희배
	public List<HashMap<String, Object>> sumGroupRatio(HashMap<String, Object> param);//전희배
	
	public int deleteSetList(int smp_aps_setlist_seq); //박찬주
	public int deleteSetTotal(int smp_aps_settotal_seq); //박찬주
	public int deleteSetGroup(int smp_aps_setgroup_seq); //박찬주
	public int deleteSetDetail(int smp_aps_setdetail_seq); //박찬주
	public SocietySmpApsSetTotal selectApsSetTotal(int smp_aps_settotal_seq); //박찬주
	public SocietySmpApsSetGroup selectSetGroup(int smp_aps_setgroup_seq); //박찬주
	public SocietySmpApsSetDetail selectSetDetail(int smp_aps_setdetail_seq); //박찬주
	public int updateSetTotal(SocietySmpApsSetTotal SMPApsSetTotal); //박찬주
	public int updateSetGroup(SocietySmpApsSetGroup SMPApsSetGroup); //박찬주
	public int updateSetDetail(SocietySmpApsSetDetail SMPApsSetDetail); //박찬주
	
	public int selectBoardGisuSeq(int board_content_seq);	//원병호
	public HashMap<String, String> select_board_detail2(int board_content_seq);	//원병호
	public int update_board_pd(HashMap<String, Object> map);	//원병호
	public int select_board_pd(int board_seq);	//원병호
}
