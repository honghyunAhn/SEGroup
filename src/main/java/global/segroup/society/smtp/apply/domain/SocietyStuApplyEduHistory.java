/**
 * 
 */
package global.segroup.society.smtp.apply.domain;

import java.util.List;

/**
 * @Author : 김성미
 * @Date : 2020. 8. 4.
 * @Class 설명 : Society 지원신청서 학력 정보
 * 
 */
public class SocietyStuApplyEduHistory {
	
	/**
	 * 학력정보 시퀀스
	 */
	private int stu_app_edu_seq;
	
	/**
	 * 지원 신청서 시퀀스 
	 */
	private int stu_app_seq;
	
	/**
	 * 학교 이름
	 */
	private String stu_app_edu_sc_nm;
	
	/**
	 * 전공 계열
	 */
	private String stu_app_edu_field;
	
	/**
	 * 전공
	 */
	private String stu_app_edu_major;
		
	/**
	 * 졸업상태 체크(공통 코드)
	 */
	private String stu_app_edu_gd_ck;
	
	/**
	 * 졸업 날짜(yyyyMMdd)
	 */
	private String stu_app_edu_gd_dt;
	
	/**
	 * 소재지
	 */
	private String stu_app_edu_sc_lo;
	
	/**
	 * 졸업요건
	 */
	private String stu_app_edu_gd_rq;
	
	/**
	 * 등록인
	 */
	private String stu_app_edu_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String stu_app_edu_ins_dt;
	
	/**
	 * 수정인
	 */
	private String stu_app_edu_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String stu_app_edu_udt_dt;
	
	/**
	 * 지원신청서 학력정보 리스트
	 */
	private List<SocietyStuApplyEduHistory> eduHistoryList;

	public SocietyStuApplyEduHistory() {
		super();
	}

	public SocietyStuApplyEduHistory(int stu_app_edu_seq, int stu_app_seq, String stu_app_edu_sc_nm,
			String stu_app_edu_field, String stu_app_edu_major, String stu_app_edu_gd_ck, String stu_app_edu_gd_dt,
			String stu_app_edu_sc_lo, String stu_app_edu_gd_rq, String stu_app_edu_ins_id, String stu_app_edu_ins_dt,
			String stu_app_edu_udt_id, String stu_app_edu_udt_dt, List<SocietyStuApplyEduHistory> eduHistoryList) {
		super();
		this.stu_app_edu_seq = stu_app_edu_seq;
		this.stu_app_seq = stu_app_seq;
		this.stu_app_edu_sc_nm = stu_app_edu_sc_nm;
		this.stu_app_edu_field = stu_app_edu_field;
		this.stu_app_edu_major = stu_app_edu_major;
		this.stu_app_edu_gd_ck = stu_app_edu_gd_ck;
		this.stu_app_edu_gd_dt = stu_app_edu_gd_dt;
		this.stu_app_edu_sc_lo = stu_app_edu_sc_lo;
		this.stu_app_edu_gd_rq = stu_app_edu_gd_rq;
		this.stu_app_edu_ins_id = stu_app_edu_ins_id;
		this.stu_app_edu_ins_dt = stu_app_edu_ins_dt;
		this.stu_app_edu_udt_id = stu_app_edu_udt_id;
		this.stu_app_edu_udt_dt = stu_app_edu_udt_dt;
		this.eduHistoryList = eduHistoryList;
	}

	public int getStu_app_edu_seq() {
		return stu_app_edu_seq;
	}

	public void setStu_app_edu_seq(int stu_app_edu_seq) {
		this.stu_app_edu_seq = stu_app_edu_seq;
	}

	public int getStu_app_seq() {
		return stu_app_seq;
	}

	public void setStu_app_seq(int stu_app_seq) {
		this.stu_app_seq = stu_app_seq;
	}

	public String getStu_app_edu_sc_nm() {
		return stu_app_edu_sc_nm;
	}

	public void setStu_app_edu_sc_nm(String stu_app_edu_sc_nm) {
		this.stu_app_edu_sc_nm = stu_app_edu_sc_nm;
	}

	public String getStu_app_edu_field() {
		return stu_app_edu_field;
	}

	public void setStu_app_edu_field(String stu_app_edu_field) {
		this.stu_app_edu_field = stu_app_edu_field;
	}

	public String getStu_app_edu_major() {
		return stu_app_edu_major;
	}

	public void setStu_app_edu_major(String stu_app_edu_major) {
		this.stu_app_edu_major = stu_app_edu_major;
	}

	public String getStu_app_edu_gd_ck() {
		return stu_app_edu_gd_ck;
	}

	public void setStu_app_edu_gd_ck(String stu_app_edu_gd_ck) {
		this.stu_app_edu_gd_ck = stu_app_edu_gd_ck;
	}

	public String getStu_app_edu_gd_dt() {
		return stu_app_edu_gd_dt;
	}

	public void setStu_app_edu_gd_dt(String stu_app_edu_gd_dt) {
		this.stu_app_edu_gd_dt = stu_app_edu_gd_dt;
	}

	public String getStu_app_edu_sc_lo() {
		return stu_app_edu_sc_lo;
	}

	public void setStu_app_edu_sc_lo(String stu_app_edu_sc_lo) {
		this.stu_app_edu_sc_lo = stu_app_edu_sc_lo;
	}

	public String getStu_app_edu_gd_rq() {
		return stu_app_edu_gd_rq;
	}

	public void setStu_app_edu_gd_rq(String stu_app_edu_gd_rq) {
		this.stu_app_edu_gd_rq = stu_app_edu_gd_rq;
	}

	public String getStu_app_edu_ins_id() {
		return stu_app_edu_ins_id;
	}

	public void setStu_app_edu_ins_id(String stu_app_edu_ins_id) {
		this.stu_app_edu_ins_id = stu_app_edu_ins_id;
	}

	public String getStu_app_edu_ins_dt() {
		return stu_app_edu_ins_dt;
	}

	public void setStu_app_edu_ins_dt(String stu_app_edu_ins_dt) {
		this.stu_app_edu_ins_dt = stu_app_edu_ins_dt;
	}

	public String getStu_app_edu_udt_id() {
		return stu_app_edu_udt_id;
	}

	public void setStu_app_edu_udt_id(String stu_app_edu_udt_id) {
		this.stu_app_edu_udt_id = stu_app_edu_udt_id;
	}

	public String getStu_app_edu_udt_dt() {
		return stu_app_edu_udt_dt;
	}

	public void setStu_app_edu_udt_dt(String stu_app_edu_udt_dt) {
		this.stu_app_edu_udt_dt = stu_app_edu_udt_dt;
	}

	public List<SocietyStuApplyEduHistory> getEduHistoryList() {
		return eduHistoryList;
	}

	public void setEduHistoryList(List<SocietyStuApplyEduHistory> eduHistoryList) {
		this.eduHistoryList = eduHistoryList;
	}

	@Override
	public String toString() {
		return "SocietyStuApplyEduHistory [stu_app_edu_seq=" + stu_app_edu_seq + ", stu_app_seq=" + stu_app_seq
				+ ", stu_app_edu_sc_nm=" + stu_app_edu_sc_nm + ", stu_app_edu_field=" + stu_app_edu_field
				+ ", stu_app_edu_major=" + stu_app_edu_major + ", stu_app_edu_gd_ck=" + stu_app_edu_gd_ck
				+ ", stu_app_edu_gd_dt=" + stu_app_edu_gd_dt + ", stu_app_edu_sc_lo=" + stu_app_edu_sc_lo
				+ ", stu_app_edu_gd_rq=" + stu_app_edu_gd_rq + ", stu_app_edu_ins_id=" + stu_app_edu_ins_id
				+ ", stu_app_edu_ins_dt=" + stu_app_edu_ins_dt + ", stu_app_edu_udt_id=" + stu_app_edu_udt_id
				+ ", stu_app_edu_udt_dt=" + stu_app_edu_udt_dt + ", eduHistoryList=" + eduHistoryList + "]";
	}

}
