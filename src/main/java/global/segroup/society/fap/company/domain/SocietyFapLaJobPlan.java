/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

/**
 * @Author : 이종호
 * @Date : 2018. 12. 26.
 * @Class 설명 : 현지 잡페어 채용공고당 타임 테이블 정보
 * 
 */
public class SocietyFapLaJobPlan {
	
	//현지 잡페어 타임 테이블 시퀀스
	private long fap_la_job_plan_seq;
	//채용공고 시퀀스
	private long fap_job_ad_seq;
	//잡페어 참가 날짜
	private String fap_la_job_plan_dt;
	//잡페어 참가 시간
	private String fap_la_job_plan_tm;
	//잡페어 참가 가능여부(공통 코드)
	private String fap_la_job_plan_gb;
	//등록인
	private String fap_la_job_plan_ins_id;
	//등록일
	private String fap_la_job_plan_ins_dt;
	//수정인
	private String fap_la_job_plan_udt_id;
	//수정일
	private String fap_la_job_plan_udt_dt;
	
	private List<SocietyFapLaJobPlan> setTimeList;
	
	public SocietyFapLaJobPlan() {
		super();
	}

	public SocietyFapLaJobPlan(long fap_la_job_plan_seq, long fap_job_ad_seq, String fap_la_job_plan_dt,
			String fap_la_job_plan_tm, String fap_la_job_plan_gb, String fap_la_job_plan_ins_id,
			String fap_la_job_plan_ins_dt, String fap_la_job_plan_udt_id, String fap_la_job_plan_udt_dt,
			List<SocietyFapLaJobPlan> setTimeList) {
		super();
		this.fap_la_job_plan_seq = fap_la_job_plan_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_la_job_plan_dt = fap_la_job_plan_dt;
		this.fap_la_job_plan_tm = fap_la_job_plan_tm;
		this.fap_la_job_plan_gb = fap_la_job_plan_gb;
		this.fap_la_job_plan_ins_id = fap_la_job_plan_ins_id;
		this.fap_la_job_plan_ins_dt = fap_la_job_plan_ins_dt;
		this.fap_la_job_plan_udt_id = fap_la_job_plan_udt_id;
		this.fap_la_job_plan_udt_dt = fap_la_job_plan_udt_dt;
		this.setTimeList = setTimeList;
	}

	public long getFap_la_job_plan_seq() {
		return fap_la_job_plan_seq;
	}

	public void setFap_la_job_plan_seq(long fap_la_job_plan_seq) {
		this.fap_la_job_plan_seq = fap_la_job_plan_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_la_job_plan_dt() {
		return fap_la_job_plan_dt;
	}

	public void setFap_la_job_plan_dt(String fap_la_job_plan_dt) {
		this.fap_la_job_plan_dt = fap_la_job_plan_dt;
	}

	public String getFap_la_job_plan_tm() {
		return fap_la_job_plan_tm;
	}

	public void setFap_la_job_plan_tm(String fap_la_job_plan_tm) {
		this.fap_la_job_plan_tm = fap_la_job_plan_tm;
	}

	public String getFap_la_job_plan_gb() {
		return fap_la_job_plan_gb;
	}

	public void setFap_la_job_plan_gb(String fap_la_job_plan_gb) {
		this.fap_la_job_plan_gb = fap_la_job_plan_gb;
	}

	public String getFap_la_job_plan_ins_id() {
		return fap_la_job_plan_ins_id;
	}

	public void setFap_la_job_plan_ins_id(String fap_la_job_plan_ins_id) {
		this.fap_la_job_plan_ins_id = fap_la_job_plan_ins_id;
	}

	public String getFap_la_job_plan_ins_dt() {
		return fap_la_job_plan_ins_dt;
	}

	public void setFap_la_job_plan_ins_dt(String fap_la_job_plan_ins_dt) {
		this.fap_la_job_plan_ins_dt = fap_la_job_plan_ins_dt;
	}

	public String getFap_la_job_plan_udt_id() {
		return fap_la_job_plan_udt_id;
	}

	public void setFap_la_job_plan_udt_id(String fap_la_job_plan_udt_id) {
		this.fap_la_job_plan_udt_id = fap_la_job_plan_udt_id;
	}

	public String getFap_la_job_plan_udt_dt() {
		return fap_la_job_plan_udt_dt;
	}

	public void setFap_la_job_plan_udt_dt(String fap_la_job_plan_udt_dt) {
		this.fap_la_job_plan_udt_dt = fap_la_job_plan_udt_dt;
	}

	public List<SocietyFapLaJobPlan> getSetTimeList() {
		return setTimeList;
	}

	public void setSetTimeList(List<SocietyFapLaJobPlan> setTimeList) {
		this.setTimeList = setTimeList;
	}

	@Override
	public String toString() {
		return "SocietyFapLaJobPlan [fap_la_job_plan_seq=" + fap_la_job_plan_seq + ", fap_job_ad_seq=" + fap_job_ad_seq
				+ ", fap_la_job_plan_dt=" + fap_la_job_plan_dt + ", fap_la_job_plan_tm=" + fap_la_job_plan_tm
				+ ", fap_la_job_plan_gb=" + fap_la_job_plan_gb + ", fap_la_job_plan_ins_id=" + fap_la_job_plan_ins_id
				+ ", fap_la_job_plan_ins_dt=" + fap_la_job_plan_ins_dt + ", fap_la_job_plan_udt_id="
				+ fap_la_job_plan_udt_id + ", fap_la_job_plan_udt_dt=" + fap_la_job_plan_udt_dt + ", setTimeList="
				+ setTimeList + "]";
	}

}
