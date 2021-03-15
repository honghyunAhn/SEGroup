/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 채용공고 파일정보
 * 
 */
public class SocietyFapJobFile {
	/**
	 * 채용공고 파일정보 시퀀스
	 */
	private long fap_job_file_seq;
	
	/**
	 * 채용공고정보 시퀀스
	 */
	private long fap_job_ad_seq;

	/**
	 * 파일구분(공통코드)
	 */
	private String fap_job_file_gb;
	
	/**
	 * 파일저장이름
	 */
	private String fap_job_file_saved;
	
	/**
	 * 파일원본이름
	 */
	private String fap_job_file_origin;
	
	/**
	 * 등록자
	 */
	private String fap_job_file_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_file_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_file_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_file_udt_dt;
	
	/**
	 * 채용공고 신청 관련 파일
	 */
	private CommonsMultipartFile job_ad_file;
	
	private String file_path;
	
	private List<SocietyFapJobFile> jobFileList;

	public SocietyFapJobFile() {
		super();
	}

	public SocietyFapJobFile(long fap_job_file_seq, long fap_job_ad_seq, String fap_job_file_gb,
			String fap_job_file_saved, String fap_job_file_origin, String fap_job_file_ins_id,
			String fap_job_file_ins_dt, String fap_job_file_udt_id, String fap_job_file_udt_dt,
			CommonsMultipartFile job_ad_file, List<SocietyFapJobFile> jobFileList) {
		super();
		this.fap_job_file_seq = fap_job_file_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_job_file_gb = fap_job_file_gb;
		this.fap_job_file_saved = fap_job_file_saved;
		this.fap_job_file_origin = fap_job_file_origin;
		this.fap_job_file_ins_id = fap_job_file_ins_id;
		this.fap_job_file_ins_dt = fap_job_file_ins_dt;
		this.fap_job_file_udt_id = fap_job_file_udt_id;
		this.fap_job_file_udt_dt = fap_job_file_udt_dt;
		this.job_ad_file = job_ad_file;
		this.jobFileList = jobFileList;
	}

	public long getFap_job_file_seq() {
		return fap_job_file_seq;
	}

	public void setFap_job_file_seq(long fap_job_file_seq) {
		this.fap_job_file_seq = fap_job_file_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_job_file_gb() {
		return fap_job_file_gb;
	}

	public void setFap_job_file_gb(String fap_job_file_gb) {
		this.fap_job_file_gb = fap_job_file_gb;
	}

	public String getFap_job_file_saved() {
		return fap_job_file_saved;
	}

	public void setFap_job_file_saved(String fap_job_file_saved) {
		this.fap_job_file_saved = fap_job_file_saved;
	}

	public String getFap_job_file_origin() {
		return fap_job_file_origin;
	}

	public void setFap_job_file_origin(String fap_job_file_origin) {
		this.fap_job_file_origin = fap_job_file_origin;
	}

	public String getFap_job_file_ins_id() {
		return fap_job_file_ins_id;
	}

	public void setFap_job_file_ins_id(String fap_job_file_ins_id) {
		this.fap_job_file_ins_id = fap_job_file_ins_id;
	}

	public String getFap_job_file_ins_dt() {
		return fap_job_file_ins_dt;
	}

	public void setFap_job_file_ins_dt(String fap_job_file_ins_dt) {
		this.fap_job_file_ins_dt = fap_job_file_ins_dt;
	}

	public String getFap_job_file_udt_id() {
		return fap_job_file_udt_id;
	}

	public void setFap_job_file_udt_id(String fap_job_file_udt_id) {
		this.fap_job_file_udt_id = fap_job_file_udt_id;
	}

	public String getFap_job_file_udt_dt() {
		return fap_job_file_udt_dt;
	}

	public void setFap_job_file_udt_dt(String fap_job_file_udt_dt) {
		this.fap_job_file_udt_dt = fap_job_file_udt_dt;
	}
	
	public CommonsMultipartFile getJob_ad_file() {
		return job_ad_file;
	}

	public void setJob_ad_file(CommonsMultipartFile job_ad_file) {
		this.job_ad_file = job_ad_file;
	}

	public List<SocietyFapJobFile> getJobFileList() {
		return jobFileList;
	}

	public void setJobFileList(List<SocietyFapJobFile> jobFileList) {
		this.jobFileList = jobFileList;
	}

	public String getFile_path() {
		return file_path;
	}
	
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}

	@Override
	public String toString() {
		return "SocietyFapJobFile [fap_job_file_seq=" + fap_job_file_seq + ", fap_job_ad_seq=" + fap_job_ad_seq
				+ ", fap_job_file_gb=" + fap_job_file_gb + ", fap_job_file_saved=" + fap_job_file_saved
				+ ", fap_job_file_origin=" + fap_job_file_origin + ", fap_job_file_ins_id=" + fap_job_file_ins_id
				+ ", fap_job_file_ins_dt=" + fap_job_file_ins_dt + ", fap_job_file_udt_id=" + fap_job_file_udt_id
				+ ", fap_job_file_udt_dt=" + fap_job_file_udt_dt + ", job_ad_file=" + job_ad_file + ", file_path="
				+ file_path + ", jobFileList=" + jobFileList + "]";
	}

	

}
