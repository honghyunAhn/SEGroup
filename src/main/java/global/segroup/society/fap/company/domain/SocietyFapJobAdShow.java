/**
 * 
 */
package global.segroup.society.fap.company.domain;

/**
 * @Author : 이종호
 * @Date : 2019. 3. 22.
 * @Class 설명 : 채용공고 노출 대상자 정보
 * 
 */
public class SocietyFapJobAdShow {
	private long fap_job_ad_show_seq;
	private long fap_job_ad_seq;
	private String fap_job_ad_show_gb;
	private String fap_job_ad_show_ins_id;
	private String fap_job_ad_show_ins_dt;
	private String fap_job_ad_show_udt_id;
	private String fap_job_ad_show_udt_dt;
	
	public SocietyFapJobAdShow() {
		super();
	}

	public SocietyFapJobAdShow(long fap_job_ad_show_seq, long fap_job_ad_seq, String fap_job_ad_show_gb,
			String fap_job_ad_show_ins_id, String fap_job_ad_show_ins_dt, String fap_job_ad_show_udt_id,
			String fap_job_ad_show_udt_dt) {
		super();
		this.fap_job_ad_show_seq = fap_job_ad_show_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_job_ad_show_gb = fap_job_ad_show_gb;
		this.fap_job_ad_show_ins_id = fap_job_ad_show_ins_id;
		this.fap_job_ad_show_ins_dt = fap_job_ad_show_ins_dt;
		this.fap_job_ad_show_udt_id = fap_job_ad_show_udt_id;
		this.fap_job_ad_show_udt_dt = fap_job_ad_show_udt_dt;
	}

	public long getFap_job_ad_show_seq() {
		return fap_job_ad_show_seq;
	}

	public void setFap_job_ad_show_seq(long fap_job_ad_show_seq) {
		this.fap_job_ad_show_seq = fap_job_ad_show_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_job_ad_show_gb() {
		return fap_job_ad_show_gb;
	}

	public void setFap_job_ad_show_gb(String fap_job_ad_show_gb) {
		this.fap_job_ad_show_gb = fap_job_ad_show_gb;
	}

	public String getFap_job_ad_show_ins_id() {
		return fap_job_ad_show_ins_id;
	}

	public void setFap_job_ad_show_ins_id(String fap_job_ad_show_ins_id) {
		this.fap_job_ad_show_ins_id = fap_job_ad_show_ins_id;
	}

	public String getFap_job_ad_show_ins_dt() {
		return fap_job_ad_show_ins_dt;
	}

	public void setFap_job_ad_show_ins_dt(String fap_job_ad_show_ins_dt) {
		this.fap_job_ad_show_ins_dt = fap_job_ad_show_ins_dt;
	}

	public String getFap_job_ad_show_udt_id() {
		return fap_job_ad_show_udt_id;
	}

	public void setFap_job_ad_show_udt_id(String fap_job_ad_show_udt_id) {
		this.fap_job_ad_show_udt_id = fap_job_ad_show_udt_id;
	}

	public String getFap_job_ad_show_udt_dt() {
		return fap_job_ad_show_udt_dt;
	}

	public void setFap_job_ad_show_udt_dt(String fap_job_ad_show_udt_dt) {
		this.fap_job_ad_show_udt_dt = fap_job_ad_show_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapJobAdShow [fap_job_ad_show_seq=" + fap_job_ad_show_seq + ", fap_job_ad_seq=" + fap_job_ad_seq
				+ ", fap_job_ad_show_gb=" + fap_job_ad_show_gb + ", fap_job_ad_show_ins_id=" + fap_job_ad_show_ins_id
				+ ", fap_job_ad_show_ins_dt=" + fap_job_ad_show_ins_dt + ", fap_job_ad_show_udt_id="
				+ fap_job_ad_show_udt_id + ", fap_job_ad_show_udt_dt=" + fap_job_ad_show_udt_dt + "]";
	}
}
