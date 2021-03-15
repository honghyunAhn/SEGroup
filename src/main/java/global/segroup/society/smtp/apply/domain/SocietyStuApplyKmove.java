/**
 * 
 */
package global.segroup.society.smtp.apply.domain;

import java.util.List;

/**
 * @Author : 김성미
 * @Date : 2020. 8. 5.
 * @Class 설명 : Society 지원신청서 K-MOVE참여 정보
 * 
 */
public class SocietyStuApplyKmove {

	/**
	 * K-MOVE참여 정보 시퀀스
	 */
	private int stu_app_kmove_seq;
	
	/**
	 * 지원 신청서 시퀀스
	 */
	private int stu_app_seq;
	
	/**
	 * K-MOVE스쿨 참여여부 체크
	 */
	private String stu_app_kmove_ck;
	
	/**
	 * K-MOVE스쿨 수강 과정명
	 */
	private String stu_app_kmove_nm;
	
	/**
	 * K-MOVE스쿨 과정 운영기관
	 */
	private String stu_app_kmove_ag;
	
	/**
	 * K-MOVE스쿨 수강기간 시작일(yyyyMMdd)
	 */
	private String stu_app_kmove_st;
	
	/**
	 * K-MOVE스쿨 수강기간 종료일(yyyyMMdd)
	 */
	private String stu_app_kmove_et;	
	
	/**
	 * 등록인
	 */
	private String stu_app_kmove_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String stu_app_kmove_ins_dt;
	
	/**
	 * 수정인
	 */
	private String stu_app_kmove_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String stu_app_kmove_udt_dt;
	
	/**
	 * 지원신청서 K-MOVE스쿨 참여정보 리스트
	 */
	private List<SocietyStuApplyKmove> kmoveList;

	public SocietyStuApplyKmove() {
		super();
	}
	

	public SocietyStuApplyKmove(int stu_app_kmove_seq, int stu_app_seq, String stu_app_kmove_ck,
			String stu_app_kmove_nm, String stu_app_kmove_ag, String stu_app_kmove_st, String stu_app_kmove_et,
			String stu_app_kmove_ins_id, String stu_app_kmove_ins_dt, String stu_app_kmove_udt_id,
			String stu_app_kmove_udt_dt, List<SocietyStuApplyKmove> kmoveList) {
		super();
		this.stu_app_kmove_seq = stu_app_kmove_seq;
		this.stu_app_seq = stu_app_seq;
		this.stu_app_kmove_ck = stu_app_kmove_ck;
		this.stu_app_kmove_nm = stu_app_kmove_nm;
		this.stu_app_kmove_ag = stu_app_kmove_ag;
		this.stu_app_kmove_st = stu_app_kmove_st;
		this.stu_app_kmove_et = stu_app_kmove_et;
		this.stu_app_kmove_ins_id = stu_app_kmove_ins_id;
		this.stu_app_kmove_ins_dt = stu_app_kmove_ins_dt;
		this.stu_app_kmove_udt_id = stu_app_kmove_udt_id;
		this.stu_app_kmove_udt_dt = stu_app_kmove_udt_dt;
		this.kmoveList = kmoveList;
	}

	public int getStu_app_kmove_seq() {
		return stu_app_kmove_seq;
	}

	public void setStu_app_kmove_seq(int stu_app_kmove_seq) {
		this.stu_app_kmove_seq = stu_app_kmove_seq;
	}

	public int getStu_app_seq() {
		return stu_app_seq;
	}

	public void setStu_app_seq(int stu_app_seq) {
		this.stu_app_seq = stu_app_seq;
	}

	public String getStu_app_kmove_ck() {
		return stu_app_kmove_ck;
	}

	public void setStu_app_kmove_ck(String stu_app_kmove_ck) {
		this.stu_app_kmove_ck = stu_app_kmove_ck;
	}

	public String getStu_app_kmove_nm() {
		return stu_app_kmove_nm;
	}

	public void setStu_app_kmove_nm(String stu_app_kmove_nm) {
		this.stu_app_kmove_nm = stu_app_kmove_nm;
	}

	public String getStu_app_kmove_ag() {
		return stu_app_kmove_ag;
	}

	public void setStu_app_kmove_ag(String stu_app_kmove_ag) {
		this.stu_app_kmove_ag = stu_app_kmove_ag;
	}

	public String getStu_app_kmove_st() {
		return stu_app_kmove_st;
	}

	public void setStu_app_kmove_st(String stu_app_kmove_st) {
		this.stu_app_kmove_st = stu_app_kmove_st;
	}

	public String getStu_app_kmove_et() {
		return stu_app_kmove_et;
	}

	public void setStu_app_kmove_et(String stu_app_kmove_et) {
		this.stu_app_kmove_et = stu_app_kmove_et;
	}

	public String getStu_app_kmove_ins_id() {
		return stu_app_kmove_ins_id;
	}

	public void setStu_app_kmove_ins_id(String stu_app_kmove_ins_id) {
		this.stu_app_kmove_ins_id = stu_app_kmove_ins_id;
	}

	public String getStu_app_kmove_ins_dt() {
		return stu_app_kmove_ins_dt;
	}

	public void setStu_app_kmove_ins_dt(String stu_app_kmove_ins_dt) {
		this.stu_app_kmove_ins_dt = stu_app_kmove_ins_dt;
	}

	public String getStu_app_kmove_udt_id() {
		return stu_app_kmove_udt_id;
	}

	public void setStu_app_kmove_udt_id(String stu_app_kmove_udt_id) {
		this.stu_app_kmove_udt_id = stu_app_kmove_udt_id;
	}

	public String getStu_app_kmove_udt_dt() {
		return stu_app_kmove_udt_dt;
	}

	public void setStu_app_kmove_udt_dt(String stu_app_kmove_udt_dt) {
		this.stu_app_kmove_udt_dt = stu_app_kmove_udt_dt;
	}

	public List<SocietyStuApplyKmove> getKmoveList() {
		return kmoveList;
	}

	public void setKmoveList(List<SocietyStuApplyKmove> kmoveList) {
		this.kmoveList = kmoveList;
	}

	@Override
	public String toString() {
		return "SocietyStuApplyKmove [stu_app_kmove_seq=" + stu_app_kmove_seq + ", stu_app_seq=" + stu_app_seq
				+ ", stu_app_kmove_ck=" + stu_app_kmove_ck + ", stu_app_kmove_nm=" + stu_app_kmove_nm
				+ ", stu_app_kmove_ag=" + stu_app_kmove_ag + ", stu_app_kmove_st=" + stu_app_kmove_st
				+ ", stu_app_kmove_et=" + stu_app_kmove_et + ", stu_app_kmove_ins_id=" + stu_app_kmove_ins_id
				+ ", stu_app_kmove_ins_dt=" + stu_app_kmove_ins_dt + ", stu_app_kmove_udt_id=" + stu_app_kmove_udt_id
				+ ", stu_app_kmove_udt_dt=" + stu_app_kmove_udt_dt + ", kmoveList=" + kmoveList + "]";
	}
	
}
