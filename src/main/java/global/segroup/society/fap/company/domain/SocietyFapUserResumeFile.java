/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 남유송
 * @Date : 2018. 12. 6.
 * @Class 설명 : 통합잡페어(FAP)이력서 파일 정보
 * 
 */
public class SocietyFapUserResumeFile {
	/**
	 * 이력서 파일 일련 번호
	 */
	private long fap_resume_file_seq;
	
	/**
	 * 이력서 일련번호
	 */
	private long fap_resume_seq;
	
	/**
	 * 이력서 파일 저장이름
	 */
	private String fap_resume_file_saved;
	
	/**
	 * 이력서 파일 원본이름
	 */
	private String fap_resume_file_origin;
		
	/**
	 * 이력서 파일 구분(공통코드)
	 */
	private String fap_resume_file_gb;
	
	/**
	 * 등록자
	 */
	private String fap_resume_file_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_resume_file_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_resume_file_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_resume_file_udt_dt;
	
	/**
	 * 이력서 파일 
	 */
	private CommonsMultipartFile fap_resume_file;
	
	/**
	 * 파일 리스트
	 */
	private List<SocietyFapUserResumeFile> resumeFileList;
	
	public SocietyFapUserResumeFile() {
		super();
	}

	public SocietyFapUserResumeFile(long fap_resume_file_seq, long fap_resume_seq, String fap_resume_file_saved,
			String fap_resume_file_origin, String fap_resume_file_gb, String fap_resume_file_ins_id,
			String fap_resume_file_ins_dt, String fap_resume_file_udt_id, String fap_resume_file_udt_dt,
			CommonsMultipartFile fap_resume_file, List<SocietyFapUserResumeFile> resumeFileList) {
		super();
		this.fap_resume_file_seq = fap_resume_file_seq;
		this.fap_resume_seq = fap_resume_seq;
		this.fap_resume_file_saved = fap_resume_file_saved;
		this.fap_resume_file_origin = fap_resume_file_origin;
		this.fap_resume_file_gb = fap_resume_file_gb;
		this.fap_resume_file_ins_id = fap_resume_file_ins_id;
		this.fap_resume_file_ins_dt = fap_resume_file_ins_dt;
		this.fap_resume_file_udt_id = fap_resume_file_udt_id;
		this.fap_resume_file_udt_dt = fap_resume_file_udt_dt;
		this.fap_resume_file = fap_resume_file;
		this.resumeFileList = resumeFileList;
	}

	public long getFap_resume_file_seq() {
		return fap_resume_file_seq;
	}

	public void setFap_resume_file_seq(long fap_resume_file_seq) {
		this.fap_resume_file_seq = fap_resume_file_seq;
	}

	public long getFap_resume_seq() {
		return fap_resume_seq;
	}

	public void setFap_resume_seq(long fap_resume_seq) {
		this.fap_resume_seq = fap_resume_seq;
	}

	public String getFap_resume_file_saved() {
		return fap_resume_file_saved;
	}

	public void setFap_resume_file_saved(String fap_resume_file_saved) {
		this.fap_resume_file_saved = fap_resume_file_saved;
	}

	public String getFap_resume_file_origin() {
		return fap_resume_file_origin;
	}

	public void setFap_resume_file_origin(String fap_resume_file_origin) {
		this.fap_resume_file_origin = fap_resume_file_origin;
	}

	public String getFap_resume_file_gb() {
		return fap_resume_file_gb;
	}

	public void setFap_resume_file_gb(String fap_resume_file_gb) {
		this.fap_resume_file_gb = fap_resume_file_gb;
	}

	public String getFap_resume_file_ins_id() {
		return fap_resume_file_ins_id;
	}

	public void setFap_resume_file_ins_id(String fap_resume_file_ins_id) {
		this.fap_resume_file_ins_id = fap_resume_file_ins_id;
	}

	public String getFap_resume_file_ins_dt() {
		return fap_resume_file_ins_dt;
	}

	public void setFap_resume_file_ins_dt(String fap_resume_file_ins_dt) {
		this.fap_resume_file_ins_dt = fap_resume_file_ins_dt;
	}

	public String getFap_resume_file_udt_id() {
		return fap_resume_file_udt_id;
	}

	public void setFap_resume_file_udt_id(String fap_resume_file_udt_id) {
		this.fap_resume_file_udt_id = fap_resume_file_udt_id;
	}

	public String getFap_resume_file_udt_dt() {
		return fap_resume_file_udt_dt;
	}

	public void setFap_resume_file_udt_dt(String fap_resume_file_udt_dt) {
		this.fap_resume_file_udt_dt = fap_resume_file_udt_dt;
	}

	public CommonsMultipartFile getFap_resume_file() {
		return fap_resume_file;
	}

	public void setFap_resume_file(CommonsMultipartFile fap_resume_file) {
		this.fap_resume_file = fap_resume_file;
	}

	public List<SocietyFapUserResumeFile> getResumeFileList() {
		return resumeFileList;
	}

	public void setResumeFileList(List<SocietyFapUserResumeFile> resumeFileList) {
		this.resumeFileList = resumeFileList;
	}

	@Override
	public String toString() {
		return "SocietyFapUserResumeFile [fap_resume_file_seq=" + fap_resume_file_seq + ", fap_resume_seq="
				+ fap_resume_seq + ", fap_resume_file_saved=" + fap_resume_file_saved + ", fap_resume_file_origin="
				+ fap_resume_file_origin + ", fap_resume_file_gb=" + fap_resume_file_gb + ", fap_resume_file_ins_id="
				+ fap_resume_file_ins_id + ", fap_resume_file_ins_dt=" + fap_resume_file_ins_dt
				+ ", fap_resume_file_udt_id=" + fap_resume_file_udt_id + ", fap_resume_file_udt_dt="
				+ fap_resume_file_udt_dt + ", fap_resume_file=" + fap_resume_file + ", resumeFileList=" + resumeFileList
				+ "]";
	}
}
