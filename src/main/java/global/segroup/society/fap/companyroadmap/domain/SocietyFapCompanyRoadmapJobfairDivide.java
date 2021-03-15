/**
 * 
 */
package global.segroup.society.fap.companyroadmap.domain;


/**
 * @Author : 
 * @Date : 2018. 12. 20. 원병호
 * @Class 설명 : 기업 로드맵에서 사용되는 세부 잡페어 VO
 * 
 */
public class SocietyFapCompanyRoadmapJobfairDivide {
	
	/**
	 * JOBFAIR 세부 일련번호
	 */
	int fap_jobfair_divide_seq;
	
	/**
	 * JOBFAIR 일련번호
	 */
	int fap_jobfair_seq;

	/**
	 * JOBFAIR 세부 시작일
	 */
	String fap_jobfair_divide_st;
	
	/**
	 * JOBFAIR 세부 종료일
	 */
	String fap_jobfair_divide_et;
	
	/**
	 * JOBFAIR 세부 설명
	 */
	String fap_jobfair_divide_detail;
	
	/**
	 * JOBFAIR 세부 구분(공통코드)
	 */
	String fap_jobfair_divide_gb;
	
	/**
	 * JOBFAIR 세부 구분 노출여부(공통코드)
	 */
	String fap_jobfair_divide_gb_eps;
	
	/**
	 * JOBFAIR 세부 참가신청 시작일
	 */
	String fap_jobfair_divide_app_st;
	
	/**
	 * JOBFAIR 세부 참가신청 마감일
	 */
	String fap_jobfair_divide_app_et;
	
	/**
	 * 등록자
	 */
	String fap_jobfair_divide_ins_id;
	
	/**
	 * 등록일 
	 */
	String fap_jobfair_divide_ins_dt;
	
	/**
	 * 수정자
	 */
	String fap_jobfair_divide_udt_id;
	
	/**
	 * 수정일
	 */
	String fap_jobfair_divide_udt_dt;

	
	/**
	 * @Desc : 
	 */
	public SocietyFapCompanyRoadmapJobfairDivide() {
		super();
	}


	/**
	 * @Desc : 
	 * @param fap_jobfair_divide_seq
	 * @param fap_jobfair_seq
	 * @param fap_jobfair_divide_st
	 * @param fap_jobfair_divide_et
	 * @param fap_jobfair_divide_detail
	 * @param fap_jobfair_divide_gb
	 * @param fap_jobfair_divide_gb_eps
	 * @param fap_jobfair_divide_app_st
	 * @param fap_jobfair_divide_app_et
	 * @param fap_jobfair_divide_ins_id
	 * @param fap_jobfair_divide_ins_dt
	 * @param fap_jobfair_divide_udt_id
	 * @param fap_jobfair_divide_udt_dt
	 */
	public SocietyFapCompanyRoadmapJobfairDivide(int fap_jobfair_divide_seq, int fap_jobfair_seq,
			String fap_jobfair_divide_st, String fap_jobfair_divide_et, String fap_jobfair_divide_detail,
			String fap_jobfair_divide_gb, String fap_jobfair_divide_gb_eps, String fap_jobfair_divide_app_st,
			String fap_jobfair_divide_app_et, String fap_jobfair_divide_ins_id, String fap_jobfair_divide_ins_dt,
			String fap_jobfair_divide_udt_id, String fap_jobfair_divide_udt_dt) {
		super();
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
		this.fap_jobfair_seq = fap_jobfair_seq;
		this.fap_jobfair_divide_st = fap_jobfair_divide_st;
		this.fap_jobfair_divide_et = fap_jobfair_divide_et;
		this.fap_jobfair_divide_detail = fap_jobfair_divide_detail;
		this.fap_jobfair_divide_gb = fap_jobfair_divide_gb;
		this.fap_jobfair_divide_gb_eps = fap_jobfair_divide_gb_eps;
		this.fap_jobfair_divide_app_st = fap_jobfair_divide_app_st;
		this.fap_jobfair_divide_app_et = fap_jobfair_divide_app_et;
		this.fap_jobfair_divide_ins_id = fap_jobfair_divide_ins_id;
		this.fap_jobfair_divide_ins_dt = fap_jobfair_divide_ins_dt;
		this.fap_jobfair_divide_udt_id = fap_jobfair_divide_udt_id;
		this.fap_jobfair_divide_udt_dt = fap_jobfair_divide_udt_dt;
	}


	/**
	 * @return the fap_jobfair_divide_seq
	 */
	public int getFap_jobfair_divide_seq() {
		return fap_jobfair_divide_seq;
	}


	/**
	 * @param fap_jobfair_divide_seq the fap_jobfair_divide_seq to set
	 */
	public void setFap_jobfair_divide_seq(int fap_jobfair_divide_seq) {
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
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
	 * @return the fap_jobfair_divide_st
	 */
	public String getFap_jobfair_divide_st() {
		return fap_jobfair_divide_st;
	}


	/**
	 * @param fap_jobfair_divide_st the fap_jobfair_divide_st to set
	 */
	public void setFap_jobfair_divide_st(String fap_jobfair_divide_st) {
		this.fap_jobfair_divide_st = fap_jobfair_divide_st;
	}


	/**
	 * @return the fap_jobfair_divide_et
	 */
	public String getFap_jobfair_divide_et() {
		return fap_jobfair_divide_et;
	}


	/**
	 * @param fap_jobfair_divide_et the fap_jobfair_divide_et to set
	 */
	public void setFap_jobfair_divide_et(String fap_jobfair_divide_et) {
		this.fap_jobfair_divide_et = fap_jobfair_divide_et;
	}


	/**
	 * @return the fap_jobfair_divide_detail
	 */
	public String getFap_jobfair_divide_detail() {
		return fap_jobfair_divide_detail;
	}


	/**
	 * @param fap_jobfair_divide_detail the fap_jobfair_divide_detail to set
	 */
	public void setFap_jobfair_divide_detail(String fap_jobfair_divide_detail) {
		this.fap_jobfair_divide_detail = fap_jobfair_divide_detail;
	}


	/**
	 * @return the fap_jobfair_divide_gb
	 */
	public String getFap_jobfair_divide_gb() {
		return fap_jobfair_divide_gb;
	}


	/**
	 * @param fap_jobfair_divide_gb the fap_jobfair_divide_gb to set
	 */
	public void setFap_jobfair_divide_gb(String fap_jobfair_divide_gb) {
		this.fap_jobfair_divide_gb = fap_jobfair_divide_gb;
	}


	/**
	 * @return the fap_jobfair_divide_gb_eps
	 */
	public String getFap_jobfair_divide_gb_eps() {
		return fap_jobfair_divide_gb_eps;
	}


	/**
	 * @param fap_jobfair_divide_gb_eps the fap_jobfair_divide_gb_eps to set
	 */
	public void setFap_jobfair_divide_gb_eps(String fap_jobfair_divide_gb_eps) {
		this.fap_jobfair_divide_gb_eps = fap_jobfair_divide_gb_eps;
	}


	/**
	 * @return the fap_jobfair_divide_app_st
	 */
	public String getFap_jobfair_divide_app_st() {
		return fap_jobfair_divide_app_st;
	}


	/**
	 * @param fap_jobfair_divide_app_st the fap_jobfair_divide_app_st to set
	 */
	public void setFap_jobfair_divide_app_st(String fap_jobfair_divide_app_st) {
		this.fap_jobfair_divide_app_st = fap_jobfair_divide_app_st;
	}


	/**
	 * @return the fap_jobfair_divide_app_et
	 */
	public String getFap_jobfair_divide_app_et() {
		return fap_jobfair_divide_app_et;
	}


	/**
	 * @param fap_jobfair_divide_app_et the fap_jobfair_divide_app_et to set
	 */
	public void setFap_jobfair_divide_app_et(String fap_jobfair_divide_app_et) {
		this.fap_jobfair_divide_app_et = fap_jobfair_divide_app_et;
	}


	/**
	 * @return the fap_jobfair_divide_ins_id
	 */
	public String getFap_jobfair_divide_ins_id() {
		return fap_jobfair_divide_ins_id;
	}


	/**
	 * @param fap_jobfair_divide_ins_id the fap_jobfair_divide_ins_id to set
	 */
	public void setFap_jobfair_divide_ins_id(String fap_jobfair_divide_ins_id) {
		this.fap_jobfair_divide_ins_id = fap_jobfair_divide_ins_id;
	}


	/**
	 * @return the fap_jobfair_divide_ins_dt
	 */
	public String getFap_jobfair_divide_ins_dt() {
		return fap_jobfair_divide_ins_dt;
	}


	/**
	 * @param fap_jobfair_divide_ins_dt the fap_jobfair_divide_ins_dt to set
	 */
	public void setFap_jobfair_divide_ins_dt(String fap_jobfair_divide_ins_dt) {
		this.fap_jobfair_divide_ins_dt = fap_jobfair_divide_ins_dt;
	}


	/**
	 * @return the fap_jobfair_divide_udt_id
	 */
	public String getFap_jobfair_divide_udt_id() {
		return fap_jobfair_divide_udt_id;
	}


	/**
	 * @param fap_jobfair_divide_udt_id the fap_jobfair_divide_udt_id to set
	 */
	public void setFap_jobfair_divide_udt_id(String fap_jobfair_divide_udt_id) {
		this.fap_jobfair_divide_udt_id = fap_jobfair_divide_udt_id;
	}


	/**
	 * @return the fap_jobfair_divide_udt_dt
	 */
	public String getFap_jobfair_divide_udt_dt() {
		return fap_jobfair_divide_udt_dt;
	}


	/**
	 * @param fap_jobfair_divide_udt_dt the fap_jobfair_divide_udt_dt to set
	 */
	public void setFap_jobfair_divide_udt_dt(String fap_jobfair_divide_udt_dt) {
		this.fap_jobfair_divide_udt_dt = fap_jobfair_divide_udt_dt;
	}


	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "SocietyFapCompanyRoadmapJobfairDivide [fap_jobfair_divide_seq=" + fap_jobfair_divide_seq
				+ ", fap_jobfair_seq=" + fap_jobfair_seq + ", fap_jobfair_divide_st=" + fap_jobfair_divide_st
				+ ", fap_jobfair_divide_et=" + fap_jobfair_divide_et + ", fap_jobfair_divide_detail="
				+ fap_jobfair_divide_detail + ", fap_jobfair_divide_gb=" + fap_jobfair_divide_gb
				+ ", fap_jobfair_divide_gb_eps=" + fap_jobfair_divide_gb_eps + ", fap_jobfair_divide_app_st="
				+ fap_jobfair_divide_app_st + ", fap_jobfair_divide_app_et=" + fap_jobfair_divide_app_et
				+ ", fap_jobfair_divide_ins_id=" + fap_jobfair_divide_ins_id + ", fap_jobfair_divide_ins_dt="
				+ fap_jobfair_divide_ins_dt + ", fap_jobfair_divide_udt_id=" + fap_jobfair_divide_udt_id
				+ ", fap_jobfair_divide_udt_dt=" + fap_jobfair_divide_udt_dt + "]";
	}
	
	
	
}
