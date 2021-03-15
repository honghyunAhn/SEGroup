/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 시험전형정보
 * 
 */
public class SocietyFapJobExam {
	/**
	 * 시험전형정보 시퀀스
	 */
	private long fap_job_exam_seq;
	
	/**
	 * 채용전형 시퀀스
	 */
	private long fap_job_recruit_pcs_seq;
	
	/**
	 * 시험전형구분(공통코드)
	 */
	private String fap_job_exam_gb;
	
	/**
	 * 대상자(공통코드)
	 */
	private String fap_job_exam_obj;
	
	/**
	 * 지원자메일주소 필요유무(공통코드)
	 */
	private String fap_job_exam_mail;
	
	/**
	 * 소요시간
	 */
	private String fap_job_exam_tm;
	
	/**
	 * 시험감독관유무(공통코드)
	 */
	private String fap_job_exam_sv;
	
	/**
	 * 시험준비물(공통코드)
	 */
	private String fap_job_exam_need;

	/**
	 * 등록자
	 */
	private String fap_job_exam_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_exam_ins_dt;

	/**
	 * 수정자
	 */
	private String fap_job_exam_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_exam_udt_dt;

	private SocietyFapJobExamObjEtc jobExamObjEtc;
	
	private SocietyFapJobExamSvEtc jobExamSvEtc;
	
	private SocietyFapJobExamNeedEtc jobExamNeedEtc;
	
	private SocietyFapJobExamFile jobExamFile;
	
	private List<SocietyFapJobExamType> jobExamTypeList;
	
	public SocietyFapJobExam() {
		super();
	}

	public SocietyFapJobExam(long fap_job_exam_seq, long fap_job_recruit_pcs_seq, String fap_job_exam_gb,
			String fap_job_exam_obj, String fap_job_exam_mail, String fap_job_exam_tm, String fap_job_exam_sv,
			String fap_job_exam_need, String fap_job_exam_ins_id, String fap_job_exam_ins_dt,
			String fap_job_exam_udt_id, String fap_job_exam_udt_dt, SocietyFapJobExamObjEtc jobExamObjEtc,
			SocietyFapJobExamSvEtc jobExamSvEtc, SocietyFapJobExamNeedEtc jobExamNeedEtc,
			SocietyFapJobExamFile jobExamFile, List<SocietyFapJobExamType> jobExamTypeList) {
		super();
		this.fap_job_exam_seq = fap_job_exam_seq;
		this.fap_job_recruit_pcs_seq = fap_job_recruit_pcs_seq;
		this.fap_job_exam_gb = fap_job_exam_gb;
		this.fap_job_exam_obj = fap_job_exam_obj;
		this.fap_job_exam_mail = fap_job_exam_mail;
		this.fap_job_exam_tm = fap_job_exam_tm;
		this.fap_job_exam_sv = fap_job_exam_sv;
		this.fap_job_exam_need = fap_job_exam_need;
		this.fap_job_exam_ins_id = fap_job_exam_ins_id;
		this.fap_job_exam_ins_dt = fap_job_exam_ins_dt;
		this.fap_job_exam_udt_id = fap_job_exam_udt_id;
		this.fap_job_exam_udt_dt = fap_job_exam_udt_dt;
		this.jobExamObjEtc = jobExamObjEtc;
		this.jobExamSvEtc = jobExamSvEtc;
		this.jobExamNeedEtc = jobExamNeedEtc;
		this.jobExamFile = jobExamFile;
		this.jobExamTypeList = jobExamTypeList;
	}

	public long getFap_job_exam_seq() {
		return fap_job_exam_seq;
	}

	public void setFap_job_exam_seq(long fap_job_exam_seq) {
		this.fap_job_exam_seq = fap_job_exam_seq;
	}

	public long getFap_job_recruit_pcs_seq() {
		return fap_job_recruit_pcs_seq;
	}

	public void setFap_job_recruit_pcs_seq(long fap_job_recruit_pcs_seq) {
		this.fap_job_recruit_pcs_seq = fap_job_recruit_pcs_seq;
	}

	public String getFap_job_exam_gb() {
		return fap_job_exam_gb;
	}

	public void setFap_job_exam_gb(String fap_job_exam_gb) {
		this.fap_job_exam_gb = fap_job_exam_gb;
	}

	public String getFap_job_exam_obj() {
		return fap_job_exam_obj;
	}

	public void setFap_job_exam_obj(String fap_job_exam_obj) {
		this.fap_job_exam_obj = fap_job_exam_obj;
	}

	public String getFap_job_exam_mail() {
		return fap_job_exam_mail;
	}

	public void setFap_job_exam_mail(String fap_job_exam_mail) {
		this.fap_job_exam_mail = fap_job_exam_mail;
	}

	public String getFap_job_exam_tm() {
		return fap_job_exam_tm;
	}

	public void setFap_job_exam_tm(String fap_job_exam_tm) {
		this.fap_job_exam_tm = fap_job_exam_tm;
	}

	public String getFap_job_exam_sv() {
		return fap_job_exam_sv;
	}

	public void setFap_job_exam_sv(String fap_job_exam_sv) {
		this.fap_job_exam_sv = fap_job_exam_sv;
	}

	public String getFap_job_exam_need() {
		return fap_job_exam_need;
	}

	public void setFap_job_exam_need(String fap_job_exam_need) {
		this.fap_job_exam_need = fap_job_exam_need;
	}

	public String getFap_job_exam_ins_id() {
		return fap_job_exam_ins_id;
	}

	public void setFap_job_exam_ins_id(String fap_job_exam_ins_id) {
		this.fap_job_exam_ins_id = fap_job_exam_ins_id;
	}

	public String getFap_job_exam_ins_dt() {
		return fap_job_exam_ins_dt;
	}

	public void setFap_job_exam_ins_dt(String fap_job_exam_ins_dt) {
		this.fap_job_exam_ins_dt = fap_job_exam_ins_dt;
	}

	public String getFap_job_exam_udt_id() {
		return fap_job_exam_udt_id;
	}

	public void setFap_job_exam_udt_id(String fap_job_exam_udt_id) {
		this.fap_job_exam_udt_id = fap_job_exam_udt_id;
	}

	public String getFap_job_exam_udt_dt() {
		return fap_job_exam_udt_dt;
	}

	public void setFap_job_exam_udt_dt(String fap_job_exam_udt_dt) {
		this.fap_job_exam_udt_dt = fap_job_exam_udt_dt;
	}

	public SocietyFapJobExamObjEtc getJobExamObjEtc() {
		return jobExamObjEtc;
	}

	public void setJobExamObjEtc(SocietyFapJobExamObjEtc jobExamObjEtc) {
		this.jobExamObjEtc = jobExamObjEtc;
	}

	public SocietyFapJobExamSvEtc getJobExamSvEtc() {
		return jobExamSvEtc;
	}

	public void setJobExamSvEtc(SocietyFapJobExamSvEtc jobExamSvEtc) {
		this.jobExamSvEtc = jobExamSvEtc;
	}

	public SocietyFapJobExamNeedEtc getJobExamNeedEtc() {
		return jobExamNeedEtc;
	}

	public void setJobExamNeedEtc(SocietyFapJobExamNeedEtc jobExamNeedEtc) {
		this.jobExamNeedEtc = jobExamNeedEtc;
	}

	public SocietyFapJobExamFile getJobExamFile() {
		return jobExamFile;
	}

	public void setJobExamFile(SocietyFapJobExamFile jobExamFile) {
		this.jobExamFile = jobExamFile;
	}

	public List<SocietyFapJobExamType> getJobExamTypeList() {
		return jobExamTypeList;
	}

	public void setJobExamTypeList(List<SocietyFapJobExamType> jobExamTypeList) {
		this.jobExamTypeList = jobExamTypeList;
	}

	@Override
	public String toString() {
		return "SocietyFapJobExam [fap_job_exam_seq=" + fap_job_exam_seq + ", fap_job_recruit_pcs_seq="
				+ fap_job_recruit_pcs_seq + ", fap_job_exam_gb=" + fap_job_exam_gb + ", fap_job_exam_obj="
				+ fap_job_exam_obj + ", fap_job_exam_mail=" + fap_job_exam_mail + ", fap_job_exam_tm=" + fap_job_exam_tm
				+ ", fap_job_exam_sv=" + fap_job_exam_sv + ", fap_job_exam_need=" + fap_job_exam_need
				+ ", fap_job_exam_ins_id=" + fap_job_exam_ins_id + ", fap_job_exam_ins_dt=" + fap_job_exam_ins_dt
				+ ", fap_job_exam_udt_id=" + fap_job_exam_udt_id + ", fap_job_exam_udt_dt=" + fap_job_exam_udt_dt
				+ ", jobExamObjEtc=" + jobExamObjEtc + ", jobExamSvEtc=" + jobExamSvEtc + ", jobExamNeedEtc="
				+ jobExamNeedEtc + ", jobExamFile=" + jobExamFile + ", jobExamTypeList=" + jobExamTypeList + "]";
	}

}
