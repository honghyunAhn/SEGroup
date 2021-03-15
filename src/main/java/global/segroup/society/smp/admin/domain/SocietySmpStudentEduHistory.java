package global.segroup.society.smp.admin.domain;

import java.util.List;

/**
 * @Author : 여명환
 * @Date : 2018. 8. 23.
 * @Class 설명 : Society 학생 학력 정보
 * 
 */
public class SocietySmpStudentEduHistory {
	
	/**
	 * 학력정보 시퀀스
	 */
	private int smp_edu_seq;
	
	/**
	 * 지원 신청서 시퀀스 
	 */
	private int smp_seq;
	
	/**
	 * 학교명
	 */
	private String smp_edu_sc_nm;
	
	/**
	 * 전공
	 */
	private String smp_edu_major;
		
	/**
	 * 졸업상태 체크(공통 코드)
	 */
	private String smp_edu_gd_ck;
	
	/**
	 * 졸업 날짜(yyyyMMdd)
	 */
	private String smp_edu_gd_dt;
	
	/**
	 * 소재지
	 */
	private String smp_edu_sc_lo;
	
	/**
	 * 졸업요건
	 */
	private String smp_edu_gd_rq;
	
	/**
	 * 등록인
	 */
	private String smp_edu_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String smp_edu_ins_dt;
	
	/**
	 * 수정인
	 */
	private String smp_edu_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String smp_edu_udt_dt;
	
	/**
	 * 지원신청서 학력정보 리스트
	 */
	private List<SocietySmpStudentEduHistory> eduHistoryList;

	public SocietySmpStudentEduHistory() {
		super();
	}

	public SocietySmpStudentEduHistory(int smp_edu_seq, int smp_seq, String smp_edu_sc_nm, String smp_edu_major,
			String smp_edu_gd_ck, String smp_edu_gd_dt, String smp_edu_sc_lo, String smp_edu_gd_rq,
			String smp_edu_ins_id, String smp_edu_ins_dt, String smp_edu_udt_id, String smp_edu_udt_dt,
			List<SocietySmpStudentEduHistory> eduHistoryList) {
		super();
		this.smp_edu_seq = smp_edu_seq;
		this.smp_seq = smp_seq;
		this.smp_edu_sc_nm = smp_edu_sc_nm;
		this.smp_edu_major = smp_edu_major;
		this.smp_edu_gd_ck = smp_edu_gd_ck;
		this.smp_edu_gd_dt = smp_edu_gd_dt;
		this.smp_edu_sc_lo = smp_edu_sc_lo;
		this.smp_edu_gd_rq = smp_edu_gd_rq;
		this.smp_edu_ins_id = smp_edu_ins_id;
		this.smp_edu_ins_dt = smp_edu_ins_dt;
		this.smp_edu_udt_id = smp_edu_udt_id;
		this.smp_edu_udt_dt = smp_edu_udt_dt;
		this.eduHistoryList = eduHistoryList;
	}

	public int getSmp_edu_seq() {
		return smp_edu_seq;
	}

	public void setSmp_edu_seq(int smp_edu_seq) {
		this.smp_edu_seq = smp_edu_seq;
	}

	public int getSmp_seq() {
		return smp_seq;
	}

	public void setSmp_seq(int smp_seq) {
		this.smp_seq = smp_seq;
	}

	public String getSmp_edu_sc_nm() {
		return smp_edu_sc_nm;
	}

	public void setSmp_edu_sc_nm(String smp_edu_sc_nm) {
		this.smp_edu_sc_nm = smp_edu_sc_nm;
	}

	public String getSmp_edu_major() {
		return smp_edu_major;
	}

	public void setSmp_edu_major(String smp_edu_major) {
		this.smp_edu_major = smp_edu_major;
	}

	public String getSmp_edu_gd_ck() {
		return smp_edu_gd_ck;
	}

	public void setSmp_edu_gd_ck(String smp_edu_gd_ck) {
		this.smp_edu_gd_ck = smp_edu_gd_ck;
	}

	public String getSmp_edu_gd_dt() {
		return smp_edu_gd_dt;
	}

	public void setSmp_edu_gd_dt(String smp_edu_gd_dt) {
		this.smp_edu_gd_dt = smp_edu_gd_dt;
	}

	public String getSmp_edu_sc_lo() {
		return smp_edu_sc_lo;
	}

	public void setSmp_edu_sc_lo(String smp_edu_sc_lo) {
		this.smp_edu_sc_lo = smp_edu_sc_lo;
	}

	public String getSmp_edu_gd_rq() {
		return smp_edu_gd_rq;
	}

	public void setSmp_edu_gd_rq(String smp_edu_gd_rq) {
		this.smp_edu_gd_rq = smp_edu_gd_rq;
	}

	public String getSmp_edu_ins_id() {
		return smp_edu_ins_id;
	}

	public void setSmp_edu_ins_id(String smp_edu_ins_id) {
		this.smp_edu_ins_id = smp_edu_ins_id;
	}

	public String getSmp_edu_ins_dt() {
		return smp_edu_ins_dt;
	}

	public void setSmp_edu_ins_dt(String smp_edu_ins_dt) {
		this.smp_edu_ins_dt = smp_edu_ins_dt;
	}

	public String getSmp_edu_udt_id() {
		return smp_edu_udt_id;
	}

	public void setSmp_edu_udt_id(String smp_edu_udt_id) {
		this.smp_edu_udt_id = smp_edu_udt_id;
	}

	public String getSmp_edu_udt_dt() {
		return smp_edu_udt_dt;
	}

	public void setSmp_edu_udt_dt(String smp_edu_udt_dt) {
		this.smp_edu_udt_dt = smp_edu_udt_dt;
	}

	public List<SocietySmpStudentEduHistory> getEduHistoryList() {
		return eduHistoryList;
	}

	public void setEduHistoryList(List<SocietySmpStudentEduHistory> eduHistoryList) {
		this.eduHistoryList = eduHistoryList;
	}

	@Override
	public String toString() {
		return "SocietyEdusmplyEduHistory [smp_edu_seq=" + smp_edu_seq + ", smp_seq=" + smp_seq + ", smp_edu_sc_nm="
				+ smp_edu_sc_nm + ", smp_edu_major=" + smp_edu_major + ", smp_edu_gd_ck=" + smp_edu_gd_ck
				+ ", smp_edu_gd_dt=" + smp_edu_gd_dt + ", smp_edu_sc_lo=" + smp_edu_sc_lo + ", smp_edu_gd_rq="
				+ smp_edu_gd_rq + ", smp_edu_ins_id=" + smp_edu_ins_id + ", smp_edu_ins_dt=" + smp_edu_ins_dt
				+ ", smp_edu_udt_id=" + smp_edu_udt_id + ", smp_edu_udt_dt=" + smp_edu_udt_dt + ", eduHistoryList="
				+ eduHistoryList + "]";
	}

}
