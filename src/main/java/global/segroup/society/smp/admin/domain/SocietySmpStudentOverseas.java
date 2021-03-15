package global.segroup.society.smp.admin.domain;

import java.util.List;



/**
 * @Author : 여명환
 * @Date : 2018. 8. 23.
 * @Class 설명 : Society 학생 학력 정보
 * 
 */
public class SocietySmpStudentOverseas {

	/**
	 * 해외체류 시퀀스
	 */
	private int smp_overseas_seq;
	
	/**
	 * 지원 신청서 시퀀스
	 */
	private int smp_seq;
	
	/**
	 * 국가명
	 */
	private String smp_overseas_nm;
	
	/**
	 * 체류기간 시작일(yyyyMMdd)
	 */
	private String smp_overseas_st;
	
	/**
	 * 체류기간 종료일(yyyyMMdd)
	 */
	private String smp_overseas_et;
	
	/**
	 * 목적
	 */
	private String smp_overseas_purpose;
	
	/**
	 * 등록인
	 */
	private String smp_overseas_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String smp_overseas_ins_dt;
	
	/**
	 * 수정인
	 */
	private String smp_overseas_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String smp_overseas_udt_dt;
	
	private List<SocietySmpStudentOverseas> overseasList;

	public SocietySmpStudentOverseas() {
		super();
	}

	public SocietySmpStudentOverseas(int smp_overseas_seq, int smp_seq, String smp_overseas_nm, String smp_overseas_st,
			String smp_overseas_et, String smp_overseas_purpose, String smp_overseas_ins_id, String smp_overseas_ins_dt,
			String smp_overseas_udt_id, String smp_overseas_udt_dt, List<SocietySmpStudentOverseas> overseasList) {
		super();
		this.smp_overseas_seq = smp_overseas_seq;
		this.smp_seq = smp_seq;
		this.smp_overseas_nm = smp_overseas_nm;
		this.smp_overseas_st = smp_overseas_st;
		this.smp_overseas_et = smp_overseas_et;
		this.smp_overseas_purpose = smp_overseas_purpose;
		this.smp_overseas_ins_id = smp_overseas_ins_id;
		this.smp_overseas_ins_dt = smp_overseas_ins_dt;
		this.smp_overseas_udt_id = smp_overseas_udt_id;
		this.smp_overseas_udt_dt = smp_overseas_udt_dt;
		this.overseasList = overseasList;
	}

	public int getSmp_overseas_seq() {
		return smp_overseas_seq;
	}

	public void setSmp_overseas_seq(int smp_overseas_seq) {
		this.smp_overseas_seq = smp_overseas_seq;
	}

	public int getSmp_seq() {
		return smp_seq;
	}

	public void setSmp_seq(int smp_seq) {
		this.smp_seq = smp_seq;
	}

	public String getSmp_overseas_nm() {
		return smp_overseas_nm;
	}

	public void setSmp_overseas_nm(String smp_overseas_nm) {
		this.smp_overseas_nm = smp_overseas_nm;
	}

	public String getSmp_overseas_st() {
		return smp_overseas_st;
	}

	public void setSmp_overseas_st(String smp_overseas_st) {
		this.smp_overseas_st = smp_overseas_st;
	}

	public String getSmp_overseas_et() {
		return smp_overseas_et;
	}

	public void setSmp_overseas_et(String smp_overseas_et) {
		this.smp_overseas_et = smp_overseas_et;
	}

	public String getSmp_overseas_purpose() {
		return smp_overseas_purpose;
	}

	public void setSmp_overseas_purpose(String smp_overseas_purpose) {
		this.smp_overseas_purpose = smp_overseas_purpose;
	}

	public String getSmp_overseas_ins_id() {
		return smp_overseas_ins_id;
	}

	public void setSmp_overseas_ins_id(String smp_overseas_ins_id) {
		this.smp_overseas_ins_id = smp_overseas_ins_id;
	}

	public String getSmp_overseas_ins_dt() {
		return smp_overseas_ins_dt;
	}

	public void setSmp_overseas_ins_dt(String smp_overseas_ins_dt) {
		this.smp_overseas_ins_dt = smp_overseas_ins_dt;
	}

	public String getSmp_overseas_udt_id() {
		return smp_overseas_udt_id;
	}

	public void setSmp_overseas_udt_id(String smp_overseas_udt_id) {
		this.smp_overseas_udt_id = smp_overseas_udt_id;
	}

	public String getSmp_overseas_udt_dt() {
		return smp_overseas_udt_dt;
	}

	public void setSmp_overseas_udt_dt(String smp_overseas_udt_dt) {
		this.smp_overseas_udt_dt = smp_overseas_udt_dt;
	}

	public List<SocietySmpStudentOverseas> getOverseasList() {
		return overseasList;
	}

	public void setOverseasList(List<SocietySmpStudentOverseas> overseasList) {
		this.overseasList = overseasList;
	}

	@Override
	public String toString() {
		return "SocietyEduApplyOverseas [smp_overseas_seq=" + smp_overseas_seq + ", smp_seq=" + smp_seq
				+ ", smp_overseas_nm=" + smp_overseas_nm + ", smp_overseas_st=" + smp_overseas_st + ", smp_overseas_et="
				+ smp_overseas_et + ", smp_overseas_purpose=" + smp_overseas_purpose + ", smp_overseas_ins_id="
				+ smp_overseas_ins_id + ", smp_overseas_ins_dt=" + smp_overseas_ins_dt + ", smp_overseas_udt_id="
				+ smp_overseas_udt_id + ", smp_overseas_udt_dt=" + smp_overseas_udt_dt + ", overseasList="
				+ overseasList + "]";
	}

}
