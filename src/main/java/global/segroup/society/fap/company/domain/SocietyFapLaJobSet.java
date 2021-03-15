/**
 * 
 */
package global.segroup.society.fap.company.domain;

/**
 * @Author : 이종호
 * @Date : 2018. 12. 26.
 * @Class 설명 : 현지 잡페어 채용공고당 설정
 * 
 */
public class SocietyFapLaJobSet {
	//현지 잡페어 채용공고당 설정 시퀀스
	private int fap_la_job_set_seq;
	//채용공고 시퀀스
	private long fap_job_ad_seq;
	//잡페어 중 참가 가능 일수
	private String fap_la_job_set_join_dt;
	//잡페어 중 전형 진행 일수
	private String fap_la_job_set_itv_dt;
	//등록인
	private String fap_la_job_set_ins_id;
	//수정인
	private String fap_la_job_set_udt_id;
	//등록일
	private String fap_la_job_set_ins_dt;
	//수정일
	private String fap_la_job_set_udt_dt;
	
	public SocietyFapLaJobSet() {
		super();
	}

	public SocietyFapLaJobSet(int fap_la_job_set_seq, long fap_job_ad_seq, String fap_la_job_set_join_dt,
			String fap_la_job_set_itv_dt, String fap_la_job_set_ins_id, String fap_la_job_set_udt_id,
			String fap_la_job_set_ins_dt, String fap_la_job_set_udt_dt) {
		super();
		this.fap_la_job_set_seq = fap_la_job_set_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_la_job_set_join_dt = fap_la_job_set_join_dt;
		this.fap_la_job_set_itv_dt = fap_la_job_set_itv_dt;
		this.fap_la_job_set_ins_id = fap_la_job_set_ins_id;
		this.fap_la_job_set_udt_id = fap_la_job_set_udt_id;
		this.fap_la_job_set_ins_dt = fap_la_job_set_ins_dt;
		this.fap_la_job_set_udt_dt = fap_la_job_set_udt_dt;
	}

	public int getFap_la_job_set_seq() {
		return fap_la_job_set_seq;
	}

	public void setFap_la_job_set_seq(int fap_la_job_set_seq) {
		this.fap_la_job_set_seq = fap_la_job_set_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_la_job_set_join_dt() {
		return fap_la_job_set_join_dt;
	}

	public void setFap_la_job_set_join_dt(String fap_la_job_set_join_dt) {
		this.fap_la_job_set_join_dt = fap_la_job_set_join_dt;
	}

	public String getFap_la_job_set_itv_dt() {
		return fap_la_job_set_itv_dt;
	}

	public void setFap_la_job_set_itv_dt(String fap_la_job_set_itv_dt) {
		this.fap_la_job_set_itv_dt = fap_la_job_set_itv_dt;
	}

	public String getFap_la_job_set_ins_id() {
		return fap_la_job_set_ins_id;
	}

	public void setFap_la_job_set_ins_id(String fap_la_job_set_ins_id) {
		this.fap_la_job_set_ins_id = fap_la_job_set_ins_id;
	}

	public String getFap_la_job_set_udt_id() {
		return fap_la_job_set_udt_id;
	}

	public void setFap_la_job_set_udt_id(String fap_la_job_set_udt_id) {
		this.fap_la_job_set_udt_id = fap_la_job_set_udt_id;
	}

	public String getFap_la_job_set_ins_dt() {
		return fap_la_job_set_ins_dt;
	}

	public void setFap_la_job_set_ins_dt(String fap_la_job_set_ins_dt) {
		this.fap_la_job_set_ins_dt = fap_la_job_set_ins_dt;
	}

	public String getFap_la_job_set_udt_dt() {
		return fap_la_job_set_udt_dt;
	}

	public void setFap_la_job_set_udt_dt(String fap_la_job_set_udt_dt) {
		this.fap_la_job_set_udt_dt = fap_la_job_set_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapLaJobSet [fap_la_job_set_seq=" + fap_la_job_set_seq + ", fap_job_ad_seq=" + fap_job_ad_seq
				+ ", fap_la_job_set_join_dt=" + fap_la_job_set_join_dt + ", fap_la_job_set_itv_dt="
				+ fap_la_job_set_itv_dt + ", fap_la_job_set_ins_id=" + fap_la_job_set_ins_id
				+ ", fap_la_job_set_udt_id=" + fap_la_job_set_udt_id + ", fap_la_job_set_ins_dt="
				+ fap_la_job_set_ins_dt + ", fap_la_job_set_udt_dt=" + fap_la_job_set_udt_dt + "]";
	}

}
