/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 시험종류 정보
 * 
 */
public class SocietyFapJobExamType {
	/**
	 * 시험종류 시퀀스
	 */
	private long fap_job_exam_type_seq;
	
	/**
	 * 시험전형정보 시퀀스
	 */
	private long fap_job_exam_seq;
	
	/**
	 * 시험종류구분(공통코드)
	 */
	private String fap_job_exam_type_gb;
	
	/**
	 * 등록자
	 */
	private String fap_job_exam_type_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_exam_type_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_exam_type_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_exam_type_udt_dt;
	
	private List<SocietyFapJobExamType> jobExamTypeList;

	public SocietyFapJobExamType() {
		super();
	}

	public SocietyFapJobExamType(long fap_job_exam_type_seq, long fap_job_exam_seq, String fap_job_exam_type_gb,
			String fap_job_exam_type_ins_id, String fap_job_exam_type_ins_dt, String fap_job_exam_type_udt_id,
			String fap_job_exam_type_udt_dt, List<SocietyFapJobExamType> jobExamTypeList) {
		super();
		this.fap_job_exam_type_seq = fap_job_exam_type_seq;
		this.fap_job_exam_seq = fap_job_exam_seq;
		this.fap_job_exam_type_gb = fap_job_exam_type_gb;
		this.fap_job_exam_type_ins_id = fap_job_exam_type_ins_id;
		this.fap_job_exam_type_ins_dt = fap_job_exam_type_ins_dt;
		this.fap_job_exam_type_udt_id = fap_job_exam_type_udt_id;
		this.fap_job_exam_type_udt_dt = fap_job_exam_type_udt_dt;
		this.jobExamTypeList = jobExamTypeList;
	}

	public long getFap_job_exam_type_seq() {
		return fap_job_exam_type_seq;
	}

	public void setFap_job_exam_type_seq(long fap_job_exam_type_seq) {
		this.fap_job_exam_type_seq = fap_job_exam_type_seq;
	}

	public long getFap_job_exam_seq() {
		return fap_job_exam_seq;
	}

	public void setFap_job_exam_seq(long fap_job_exam_seq) {
		this.fap_job_exam_seq = fap_job_exam_seq;
	}

	public String getFap_job_exam_type_gb() {
		return fap_job_exam_type_gb;
	}

	public void setFap_job_exam_type_gb(String fap_job_exam_type_gb) {
		this.fap_job_exam_type_gb = fap_job_exam_type_gb;
	}

	public String getFap_job_exam_type_ins_id() {
		return fap_job_exam_type_ins_id;
	}

	public void setFap_job_exam_type_ins_id(String fap_job_exam_type_ins_id) {
		this.fap_job_exam_type_ins_id = fap_job_exam_type_ins_id;
	}

	public String getFap_job_exam_type_ins_dt() {
		return fap_job_exam_type_ins_dt;
	}

	public void setFap_job_exam_type_ins_dt(String fap_job_exam_type_ins_dt) {
		this.fap_job_exam_type_ins_dt = fap_job_exam_type_ins_dt;
	}

	public String getFap_job_exam_type_udt_id() {
		return fap_job_exam_type_udt_id;
	}

	public void setFap_job_exam_type_udt_id(String fap_job_exam_type_udt_id) {
		this.fap_job_exam_type_udt_id = fap_job_exam_type_udt_id;
	}

	public String getFap_job_exam_type_udt_dt() {
		return fap_job_exam_type_udt_dt;
	}

	public void setFap_job_exam_type_udt_dt(String fap_job_exam_type_udt_dt) {
		this.fap_job_exam_type_udt_dt = fap_job_exam_type_udt_dt;
	}

	public List<SocietyFapJobExamType> getJobExamTypeList() {
		return jobExamTypeList;
	}

	public void setJobExamTypeList(List<SocietyFapJobExamType> jobExamTypeList) {
		this.jobExamTypeList = jobExamTypeList;
	}

	@Override
	public String toString() {
		return "SocietyFapJobExamType [fap_job_exam_type_seq=" + fap_job_exam_type_seq + ", fap_job_exam_seq="
				+ fap_job_exam_seq + ", fap_job_exam_type_gb=" + fap_job_exam_type_gb + ", fap_job_exam_type_ins_id="
				+ fap_job_exam_type_ins_id + ", fap_job_exam_type_ins_dt=" + fap_job_exam_type_ins_dt
				+ ", fap_job_exam_type_udt_id=" + fap_job_exam_type_udt_id + ", fap_job_exam_type_udt_dt="
				+ fap_job_exam_type_udt_dt + ", jobExamTypeList=" + jobExamTypeList + "]";
	}

}
