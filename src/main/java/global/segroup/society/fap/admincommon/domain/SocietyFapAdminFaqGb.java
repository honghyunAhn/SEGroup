/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

/**
 * @Author : 이종호
 * @Date : 2019. 4. 9.
 * @Class 설명 : 파인애플 FAQ 구분 정보
 * 
 */
public class SocietyFapAdminFaqGb {
	private int fap_faq_gb_seq;
	private int consulting_seq;
	private String fap_faq_gb_cd;
	private String fap_faq_gb_ins_id;
	private String fap_faq_gb_ins_dt;
	private String fap_faq_gb_udt_id;
	private String fap_faq_gb_udt_dt;
	
	public SocietyFapAdminFaqGb() {
		super();
	}

	public SocietyFapAdminFaqGb(int fap_faq_gb_seq, int consulting_seq, String fap_faq_gb_cd, String fap_faq_gb_ins_id,
			String fap_faq_gb_ins_dt, String fap_faq_gb_udt_id, String fap_faq_gb_udt_dt) {
		super();
		this.fap_faq_gb_seq = fap_faq_gb_seq;
		this.consulting_seq = consulting_seq;
		this.fap_faq_gb_cd = fap_faq_gb_cd;
		this.fap_faq_gb_ins_id = fap_faq_gb_ins_id;
		this.fap_faq_gb_ins_dt = fap_faq_gb_ins_dt;
		this.fap_faq_gb_udt_id = fap_faq_gb_udt_id;
		this.fap_faq_gb_udt_dt = fap_faq_gb_udt_dt;
	}

	public int getFap_faq_gb_seq() {
		return fap_faq_gb_seq;
	}

	public void setFap_faq_gb_seq(int fap_faq_gb_seq) {
		this.fap_faq_gb_seq = fap_faq_gb_seq;
	}

	public int getConsulting_seq() {
		return consulting_seq;
	}

	public void setConsulting_seq(int consulting_seq) {
		this.consulting_seq = consulting_seq;
	}

	public String getFap_faq_gb_cd() {
		return fap_faq_gb_cd;
	}

	public void setFap_faq_gb_cd(String fap_faq_gb_cd) {
		this.fap_faq_gb_cd = fap_faq_gb_cd;
	}

	public String getFap_faq_gb_ins_id() {
		return fap_faq_gb_ins_id;
	}

	public void setFap_faq_gb_ins_id(String fap_faq_gb_ins_id) {
		this.fap_faq_gb_ins_id = fap_faq_gb_ins_id;
	}

	public String getFap_faq_gb_ins_dt() {
		return fap_faq_gb_ins_dt;
	}

	public void setFap_faq_gb_ins_dt(String fap_faq_gb_ins_dt) {
		this.fap_faq_gb_ins_dt = fap_faq_gb_ins_dt;
	}

	public String getFap_faq_gb_udt_id() {
		return fap_faq_gb_udt_id;
	}

	public void setFap_faq_gb_udt_id(String fap_faq_gb_udt_id) {
		this.fap_faq_gb_udt_id = fap_faq_gb_udt_id;
	}

	public String getFap_faq_gb_udt_dt() {
		return fap_faq_gb_udt_dt;
	}

	public void setFap_faq_gb_udt_dt(String fap_faq_gb_udt_dt) {
		this.fap_faq_gb_udt_dt = fap_faq_gb_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapAdminFaqGb [fap_faq_gb_seq=" + fap_faq_gb_seq + ", consulting_seq=" + consulting_seq
				+ ", fap_faq_gb_cd=" + fap_faq_gb_cd + ", fap_faq_gb_ins_id=" + fap_faq_gb_ins_id
				+ ", fap_faq_gb_ins_dt=" + fap_faq_gb_ins_dt + ", fap_faq_gb_udt_id=" + fap_faq_gb_udt_id
				+ ", fap_faq_gb_udt_dt=" + fap_faq_gb_udt_dt + "]";
	}
}
