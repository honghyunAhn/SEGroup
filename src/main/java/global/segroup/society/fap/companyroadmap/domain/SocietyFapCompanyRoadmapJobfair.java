/**
 * 
 */
package global.segroup.society.fap.companyroadmap.domain;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 
 * @Date : 2018. 12. 14. 원병호
 * @Class 설명 : 기업 로드맵에서 사용되는 잡페어 VO
 * 
 */
public class SocietyFapCompanyRoadmapJobfair {
	
	/**
	 * 잡페어 시퀀스
	 */
	private int fap_jobfair_seq;
	
	/**
	 * 잡페어 제목
	 */
	private String fap_jobfair_title;
	
	/**
	 * 잡페어 시작일
	 */
	private String fap_jobfair_st;
	
	/**
	 * 잡페어 종료일
	 */
	private String fap_jobfair_et;

	/**
	 * 잡페어 로고 파일
	 */
	private CommonsMultipartFile fap_jobfair_log_file;
	
	/**
	 * 잡페어 로고 저장이름
	 */
	private String fap_jobfair_log_saved;
	
	/**
	 * 잡페어 로고 원본이름
	 */
	private String fap_jobfair_log_origin;
	
	/**
	 * 잡페어 노출여부
	 */
	private String fap_jobfair_eps;
	
	/**
	 * 잡페어 등록자
	 */
	private String fap_jobfair_ins_id;
	
	/**
	 * 잡페어 등록일
	 */
	private String fap_jobfair_ins_dt;
	
	/**
	 * 잡페어 수정자
	 */
	private String fap_jobfair_udt_id;
	
	/**
	 * 잡페어 수정일
	 */
	private String fap_jobfair_udt_dt;

	
	/**
	 * @Desc : 
	 */
	public SocietyFapCompanyRoadmapJobfair() {
		super();
	}


	/**
	 * @Desc : 
	 * @param fap_jobfair_seq
	 * @param fap_jobfair_title
	 * @param fap_jobfair_st
	 * @param fap_jobfair_et
	 * @param fap_jobfair_log_file
	 * @param fap_jobfair_log_saved
	 * @param fap_jobfair_log_origin
	 * @param fap_jobfair_eps
	 * @param fap_jobfair_ins_id
	 * @param fap_jobfair_ins_dt
	 * @param fap_jobfair_udt_id
	 * @param fap_jobfair_udt_dt
	 */
	public SocietyFapCompanyRoadmapJobfair(int fap_jobfair_seq, String fap_jobfair_title, String fap_jobfair_st,
			String fap_jobfair_et, CommonsMultipartFile fap_jobfair_log_file, String fap_jobfair_log_saved,
			String fap_jobfair_log_origin, String fap_jobfair_eps, String fap_jobfair_ins_id, String fap_jobfair_ins_dt,
			String fap_jobfair_udt_id, String fap_jobfair_udt_dt) {
		super();
		this.fap_jobfair_seq = fap_jobfair_seq;
		this.fap_jobfair_title = fap_jobfair_title;
		this.fap_jobfair_st = fap_jobfair_st;
		this.fap_jobfair_et = fap_jobfair_et;
		this.fap_jobfair_log_file = fap_jobfair_log_file;
		this.fap_jobfair_log_saved = fap_jobfair_log_saved;
		this.fap_jobfair_log_origin = fap_jobfair_log_origin;
		this.fap_jobfair_eps = fap_jobfair_eps;
		this.fap_jobfair_ins_id = fap_jobfair_ins_id;
		this.fap_jobfair_ins_dt = fap_jobfair_ins_dt;
		this.fap_jobfair_udt_id = fap_jobfair_udt_id;
		this.fap_jobfair_udt_dt = fap_jobfair_udt_dt;
	}


	/**
	 * @return the fap_jobfair_seq
	 */
	public int getFap_jobfair_seq() {
		return fap_jobfair_seq;
	}


	/**
	 * @param fap_jobfair_seq the fap_jobfair_seq to set
	 */
	public void setFap_jobfair_seq(int fap_jobfair_seq) {
		this.fap_jobfair_seq = fap_jobfair_seq;
	}


	/**
	 * @return the fap_jobfair_title
	 */
	public String getFap_jobfair_title() {
		return fap_jobfair_title;
	}


	/**
	 * @param fap_jobfair_title the fap_jobfair_title to set
	 */
	public void setFap_jobfair_title(String fap_jobfair_title) {
		this.fap_jobfair_title = fap_jobfair_title;
	}


	/**
	 * @return the fap_jobfair_st
	 */
	public String getFap_jobfair_st() {
		return fap_jobfair_st;
	}


	/**
	 * @param fap_jobfair_st the fap_jobfair_st to set
	 */
	public void setFap_jobfair_st(String fap_jobfair_st) {
		this.fap_jobfair_st = fap_jobfair_st;
	}


	/**
	 * @return the fap_jobfair_et
	 */
	public String getFap_jobfair_et() {
		return fap_jobfair_et;
	}


	/**
	 * @param fap_jobfair_et the fap_jobfair_et to set
	 */
	public void setFap_jobfair_et(String fap_jobfair_et) {
		this.fap_jobfair_et = fap_jobfair_et;
	}


	/**
	 * @return the fap_jobfair_log_file
	 */
	public CommonsMultipartFile getFap_jobfair_log_file() {
		return fap_jobfair_log_file;
	}


	/**
	 * @param fap_jobfair_log_file the fap_jobfair_log_file to set
	 */
	public void setFap_jobfair_log_file(CommonsMultipartFile fap_jobfair_log_file) {
		this.fap_jobfair_log_file = fap_jobfair_log_file;
	}


	/**
	 * @return the fap_jobfair_log_saved
	 */
	public String getFap_jobfair_log_saved() {
		return fap_jobfair_log_saved;
	}


	/**
	 * @param fap_jobfair_log_saved the fap_jobfair_log_saved to set
	 */
	public void setFap_jobfair_log_saved(String fap_jobfair_log_saved) {
		this.fap_jobfair_log_saved = fap_jobfair_log_saved;
	}


	/**
	 * @return the fap_jobfair_log_origin
	 */
	public String getFap_jobfair_log_origin() {
		return fap_jobfair_log_origin;
	}


	/**
	 * @param fap_jobfair_log_origin the fap_jobfair_log_origin to set
	 */
	public void setFap_jobfair_log_origin(String fap_jobfair_log_origin) {
		this.fap_jobfair_log_origin = fap_jobfair_log_origin;
	}


	/**
	 * @return the fap_jobfair_eps
	 */
	public String getFap_jobfair_eps() {
		return fap_jobfair_eps;
	}


	/**
	 * @param fap_jobfair_eps the fap_jobfair_eps to set
	 */
	public void setFap_jobfair_eps(String fap_jobfair_eps) {
		this.fap_jobfair_eps = fap_jobfair_eps;
	}


	/**
	 * @return the fap_jobfair_ins_id
	 */
	public String getFap_jobfair_ins_id() {
		return fap_jobfair_ins_id;
	}


	/**
	 * @param fap_jobfair_ins_id the fap_jobfair_ins_id to set
	 */
	public void setFap_jobfair_ins_id(String fap_jobfair_ins_id) {
		this.fap_jobfair_ins_id = fap_jobfair_ins_id;
	}


	/**
	 * @return the fap_jobfair_ins_dt
	 */
	public String getFap_jobfair_ins_dt() {
		return fap_jobfair_ins_dt;
	}


	/**
	 * @param fap_jobfair_ins_dt the fap_jobfair_ins_dt to set
	 */
	public void setFap_jobfair_ins_dt(String fap_jobfair_ins_dt) {
		this.fap_jobfair_ins_dt = fap_jobfair_ins_dt;
	}


	/**
	 * @return the fap_jobfair_udt_id
	 */
	public String getFap_jobfair_udt_id() {
		return fap_jobfair_udt_id;
	}


	/**
	 * @param fap_jobfair_udt_id the fap_jobfair_udt_id to set
	 */
	public void setFap_jobfair_udt_id(String fap_jobfair_udt_id) {
		this.fap_jobfair_udt_id = fap_jobfair_udt_id;
	}


	/**
	 * @return the fap_jobfair_udt_dt
	 */
	public String getFap_jobfair_udt_dt() {
		return fap_jobfair_udt_dt;
	}


	/**
	 * @param fap_jobfair_udt_dt the fap_jobfair_udt_dt to set
	 */
	public void setFap_jobfair_udt_dt(String fap_jobfair_udt_dt) {
		this.fap_jobfair_udt_dt = fap_jobfair_udt_dt;
	}


	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "SocietyFapCompanyRoadmapJobfair [fap_jobfair_seq=" + fap_jobfair_seq + ", fap_jobfair_title="
				+ fap_jobfair_title + ", fap_jobfair_st=" + fap_jobfair_st + ", fap_jobfair_et=" + fap_jobfair_et
				+ ", fap_jobfair_log_file=" + fap_jobfair_log_file + ", fap_jobfair_log_saved=" + fap_jobfair_log_saved
				+ ", fap_jobfair_log_origin=" + fap_jobfair_log_origin + ", fap_jobfair_eps=" + fap_jobfair_eps
				+ ", fap_jobfair_ins_id=" + fap_jobfair_ins_id + ", fap_jobfair_ins_dt=" + fap_jobfair_ins_dt
				+ ", fap_jobfair_udt_id=" + fap_jobfair_udt_id + ", fap_jobfair_udt_dt=" + fap_jobfair_udt_dt + "]";
	}	

	
	
}
