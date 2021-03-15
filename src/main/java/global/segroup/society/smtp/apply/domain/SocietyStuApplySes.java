/**
 * 
 */
package global.segroup.society.smtp.apply.domain;

import java.util.List;

/**
 * @Author : 김성미
 * @Date : 2020. 8. 5.
 * @Class 설명 : Society 지원신청서 본 과정 응시 정보
 * 
 */
public class SocietyStuApplySes {

	/**
	 * 본 과정 응시 정보 시퀀스
	 */
	private int stu_app_ses_seq;
	
	/**
	 * 지원 신청서 시퀀스
	 */
	private int stu_app_seq;
	
	/**
	 * 본 과정 응시여부 체크
	 */
	private String stu_app_ses_ck;
	
	/**
	 * 본 과정 지원년월(yyyyMM)
	 */
	private String stu_app_ses_apply_dt;
	
	/**
	 * 본 과정 선발전형 결과
	 */
	private String stu_app_ses_apply_rt;
	
	/**
	 * 등록인
	 */
	private String stu_app_ses_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String stu_app_ses_ins_dt;
	
	/**
	 * 수정인
	 */
	private String stu_app_ses_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String stu_app_ses_udt_dt;
	
	/**
	 * 지원신청서 본 과정 응시여부 리스트
	 */
	private List<SocietyStuApplySes> sesList;

	public SocietyStuApplySes() {
		super();
	}
	
	public SocietyStuApplySes(int stu_app_ses_seq, int stu_app_seq, String stu_app_ses_ck, String stu_app_ses_apply_dt,
			String stu_app_ses_apply_rt, String stu_app_ses_ins_id, String stu_app_ses_ins_dt,
			String stu_app_ses_udt_id, String stu_app_ses_udt_dt, List<SocietyStuApplySes> sesList) {
		super();
		this.stu_app_ses_seq = stu_app_ses_seq;
		this.stu_app_seq = stu_app_seq;
		this.stu_app_ses_ck = stu_app_ses_ck;
		this.stu_app_ses_apply_dt = stu_app_ses_apply_dt;
		this.stu_app_ses_apply_rt = stu_app_ses_apply_rt;
		this.stu_app_ses_ins_id = stu_app_ses_ins_id;
		this.stu_app_ses_ins_dt = stu_app_ses_ins_dt;
		this.stu_app_ses_udt_id = stu_app_ses_udt_id;
		this.stu_app_ses_udt_dt = stu_app_ses_udt_dt;
		this.sesList = sesList;
	}

	public int getStu_app_ses_seq() {
		return stu_app_ses_seq;
	}

	public void setStu_app_ses_seq(int stu_app_ses_seq) {
		this.stu_app_ses_seq = stu_app_ses_seq;
	}

	public int getStu_app_seq() {
		return stu_app_seq;
	}

	public void setStu_app_seq(int stu_app_seq) {
		this.stu_app_seq = stu_app_seq;
	}

	public String getStu_app_ses_ck() {
		return stu_app_ses_ck;
	}

	public void setStu_app_ses_ck(String stu_app_ses_ck) {
		this.stu_app_ses_ck = stu_app_ses_ck;
	}

	public String getStu_app_ses_apply_dt() {
		return stu_app_ses_apply_dt;
	}

	public void setStu_app_ses_apply_dt(String stu_app_ses_apply_dt) {
		this.stu_app_ses_apply_dt = stu_app_ses_apply_dt;
	}

	public String getStu_app_ses_apply_rt() {
		return stu_app_ses_apply_rt;
	}

	public void setStu_app_ses_apply_rt(String stu_app_ses_apply_rt) {
		this.stu_app_ses_apply_rt = stu_app_ses_apply_rt;
	}

	public String getStu_app_ses_ins_id() {
		return stu_app_ses_ins_id;
	}

	public void setStu_app_ses_ins_id(String stu_app_ses_ins_id) {
		this.stu_app_ses_ins_id = stu_app_ses_ins_id;
	}

	public String getStu_app_ses_ins_dt() {
		return stu_app_ses_ins_dt;
	}

	public void setStu_app_ses_ins_dt(String stu_app_ses_ins_dt) {
		this.stu_app_ses_ins_dt = stu_app_ses_ins_dt;
	}

	public String getStu_app_ses_udt_id() {
		return stu_app_ses_udt_id;
	}

	public void setStu_app_ses_udt_id(String stu_app_ses_udt_id) {
		this.stu_app_ses_udt_id = stu_app_ses_udt_id;
	}

	public String getStu_app_ses_udt_dt() {
		return stu_app_ses_udt_dt;
	}

	public void setStu_app_ses_udt_dt(String stu_app_ses_udt_dt) {
		this.stu_app_ses_udt_dt = stu_app_ses_udt_dt;
	}

	public List<SocietyStuApplySes> getSesList() {
		return sesList;
	}

	public void setSesList(List<SocietyStuApplySes> sesList) {
		this.sesList = sesList;
	}

	@Override
	public String toString() {
		return "SocietyStuApplySes [stu_app_ses_seq=" + stu_app_ses_seq + ", stu_app_seq=" + stu_app_seq
				+ ", stu_app_ses_ck=" + stu_app_ses_ck + ", stu_app_ses_apply_dt=" + stu_app_ses_apply_dt
				+ ", stu_app_ses_apply_rt=" + stu_app_ses_apply_rt + ", stu_app_ses_ins_id=" + stu_app_ses_ins_id
				+ ", stu_app_ses_ins_dt=" + stu_app_ses_ins_dt + ", stu_app_ses_udt_id=" + stu_app_ses_udt_id
				+ ", stu_app_ses_udt_dt=" + stu_app_ses_udt_dt + ", sesList=" + sesList + "]";
	}

}
