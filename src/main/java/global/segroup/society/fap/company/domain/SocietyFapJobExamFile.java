/**
 * 
 */
package global.segroup.society.fap.company.domain;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 시험문제 파일정보
 * 
 */
public class SocietyFapJobExamFile {
	/**
	 * 시험문제파일 시퀀스
	 */
	private long fap_job_exam_file_seq;
	
	/**
	 * 시험전형정보 시퀀스
	 */
	private long fap_job_exam_seq;
	
	/**
	 * 파일저장이름
	 */
	private String fap_job_exam_file_saved;
	
	/**
	 * 파일원본이름
	 */
	private String fap_job_exam_file_origin;
	
	/**
	 * 등록자
	 */
	private String fap_job_exam_file_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_exam_file_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_exam_file_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_exam_file_udt_dt;
	
	/*
	 * 넣어 줄 파일
	 */
	private CommonsMultipartFile fap_job_exam_file;
	
	/*
	 * 저장한 파일 path
	 */
	private String file_path;
	

	/**
	 * @Desc : 
	 */
	public SocietyFapJobExamFile() {
		super();
	}

	/**
	 * @Desc : 
	 * @param fap_job_exam_file_seq
	 * @param fap_job_exam_seq
	 * @param fap_job_exam_file_saved
	 * @param fap_job_exam_file_origin
	 * @param fap_job_exam_file_ins_id
	 * @param fap_job_exam_file_ins_dt
	 * @param fap_job_exam_file_udt_id
	 * @param fap_job_exam_file_udt_dt
	 * @param fap_job_exam_file
	 */
	public SocietyFapJobExamFile(long fap_job_exam_file_seq, long fap_job_exam_seq, String fap_job_exam_file_saved,
			String fap_job_exam_file_origin, String fap_job_exam_file_ins_id, String fap_job_exam_file_ins_dt,
			String fap_job_exam_file_udt_id, String fap_job_exam_file_udt_dt, CommonsMultipartFile fap_job_exam_file) {
		super();
		this.fap_job_exam_file_seq = fap_job_exam_file_seq;
		this.fap_job_exam_seq = fap_job_exam_seq;
		this.fap_job_exam_file_saved = fap_job_exam_file_saved;
		this.fap_job_exam_file_origin = fap_job_exam_file_origin;
		this.fap_job_exam_file_ins_id = fap_job_exam_file_ins_id;
		this.fap_job_exam_file_ins_dt = fap_job_exam_file_ins_dt;
		this.fap_job_exam_file_udt_id = fap_job_exam_file_udt_id;
		this.fap_job_exam_file_udt_dt = fap_job_exam_file_udt_dt;
		this.fap_job_exam_file = fap_job_exam_file;
	}

	/**
	 * @return the fap_job_exam_file_seq
	 */
	public long getFap_job_exam_file_seq() {
		return fap_job_exam_file_seq;
	}

	/**
	 * @param fap_job_exam_file_seq the fap_job_exam_file_seq to set
	 */
	public void setFap_job_exam_file_seq(long fap_job_exam_file_seq) {
		this.fap_job_exam_file_seq = fap_job_exam_file_seq;
	}

	/**
	 * @return the fap_job_exam_seq
	 */
	public long getFap_job_exam_seq() {
		return fap_job_exam_seq;
	}

	/**
	 * @param fap_job_exam_seq the fap_job_exam_seq to set
	 */
	public void setFap_job_exam_seq(long fap_job_exam_seq) {
		this.fap_job_exam_seq = fap_job_exam_seq;
	}

	/**
	 * @return the fap_job_exam_file_saved
	 */
	public String getFap_job_exam_file_saved() {
		return fap_job_exam_file_saved;
	}

	/**
	 * @param fap_job_exam_file_saved the fap_job_exam_file_saved to set
	 */
	public void setFap_job_exam_file_saved(String fap_job_exam_file_saved) {
		this.fap_job_exam_file_saved = fap_job_exam_file_saved;
	}

	/**
	 * @return the fap_job_exam_file_origin
	 */
	public String getFap_job_exam_file_origin() {
		return fap_job_exam_file_origin;
	}

	/**
	 * @param fap_job_exam_file_origin the fap_job_exam_file_origin to set
	 */
	public void setFap_job_exam_file_origin(String fap_job_exam_file_origin) {
		this.fap_job_exam_file_origin = fap_job_exam_file_origin;
	}

	/**
	 * @return the fap_job_exam_file_ins_id
	 */
	public String getFap_job_exam_file_ins_id() {
		return fap_job_exam_file_ins_id;
	}

	/**
	 * @param fap_job_exam_file_ins_id the fap_job_exam_file_ins_id to set
	 */
	public void setFap_job_exam_file_ins_id(String fap_job_exam_file_ins_id) {
		this.fap_job_exam_file_ins_id = fap_job_exam_file_ins_id;
	}

	/**
	 * @return the fap_job_exam_file_ins_dt
	 */
	public String getFap_job_exam_file_ins_dt() {
		return fap_job_exam_file_ins_dt;
	}

	/**
	 * @param fap_job_exam_file_ins_dt the fap_job_exam_file_ins_dt to set
	 */
	public void setFap_job_exam_file_ins_dt(String fap_job_exam_file_ins_dt) {
		this.fap_job_exam_file_ins_dt = fap_job_exam_file_ins_dt;
	}

	/**
	 * @return the fap_job_exam_file_udt_id
	 */
	public String getFap_job_exam_file_udt_id() {
		return fap_job_exam_file_udt_id;
	}

	/**
	 * @param fap_job_exam_file_udt_id the fap_job_exam_file_udt_id to set
	 */
	public void setFap_job_exam_file_udt_id(String fap_job_exam_file_udt_id) {
		this.fap_job_exam_file_udt_id = fap_job_exam_file_udt_id;
	}

	/**
	 * @return the fap_job_exam_file_udt_dt
	 */
	public String getFap_job_exam_file_udt_dt() {
		return fap_job_exam_file_udt_dt;
	}

	/**
	 * @param fap_job_exam_file_udt_dt the fap_job_exam_file_udt_dt to set
	 */
	public void setFap_job_exam_file_udt_dt(String fap_job_exam_file_udt_dt) {
		this.fap_job_exam_file_udt_dt = fap_job_exam_file_udt_dt;
	}

	/**
	 * @return the fap_job_exam_file
	 */
	public CommonsMultipartFile getFap_job_exam_file() {
		return fap_job_exam_file;
	}

	/**
	 * @param fap_job_exam_file the fap_job_exam_file to set
	 */
	public void setFap_job_exam_file(CommonsMultipartFile fap_job_exam_file) {
		this.fap_job_exam_file = fap_job_exam_file;
	}
	
	
	

	/**
	 * @return the file_path
	 */
	public String getFile_path() {
		return file_path;
	}

	/**
	 * @param file_path the file_path to set
	 */
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "SocietyFapJobExamFile [fap_job_exam_file_seq=" + fap_job_exam_file_seq + ", fap_job_exam_seq="
				+ fap_job_exam_seq + ", fap_job_exam_file_saved=" + fap_job_exam_file_saved
				+ ", fap_job_exam_file_origin=" + fap_job_exam_file_origin + ", fap_job_exam_file_ins_id="
				+ fap_job_exam_file_ins_id + ", fap_job_exam_file_ins_dt=" + fap_job_exam_file_ins_dt
				+ ", fap_job_exam_file_udt_id=" + fap_job_exam_file_udt_id + ", fap_job_exam_file_udt_dt="
				+ fap_job_exam_file_udt_dt + ", fap_job_exam_file=" + fap_job_exam_file + ", file_path=" + file_path
				+ "]";
	}

	

}
