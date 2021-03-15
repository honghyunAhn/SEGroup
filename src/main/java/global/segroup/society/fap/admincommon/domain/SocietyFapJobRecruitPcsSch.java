/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

/**
 * @Author : 신동철
 * @Date : 2019. 1. 13.
 * @Class 설명 : 채용전형 스케줄
 * 
 */
public class SocietyFapJobRecruitPcsSch {

	/**
	 * 채용전형 스케줄 일련번호
	 */
	private long fap_job_recruit_pcs_sch_seq;
	
	/**
	 * 채용전형 일련번호
	 */
	private long fap_job_recruit_pcs_seq;
		
	/**
	 * 잡페어 일련번호
	 */
	private int fap_jobfair_seq;
	
	/**
	 * 잡페어세부 일련번호
	 */
	private int fap_jobfair_divide_seq;
	
	/**
	 * 검색 회사명
	 */
	private String comp_nm;
	
	/**
	 * 회사 아이디
	 */
	private String fap_comp_id;
	
	/**
	 * 채용전형 시작날짜
	 */
	private String fap_job_recruit_pcs_sch_st;
	
	/**
	 * 채용전형 종료날짜
	 */
	private String fap_job_recruit_pcs_sch_et;
	
	/**
	 * 서류전형 시작일
	 */
	private String fap_job_review_date_st;
	
	/**
	 * 서류전형 시작시간
	 */
	private String fap_job_review_time_st;
	
	/**
	 * 서류전형 종료일
	 */
	private String fap_job_review_date_et;
	
	/**
	 * 서류전형 종료시간
	 */
	private String fap_job_review_time_et;
	
	/**
	 * 시험전형 시작일
	 */
	private String fap_job_exam_date_st;
	
	/**
	 * 시험전형 종료일
	 */
	private String fap_job_exam_date_et;
	
	/**
	 * 시험전형 시작 시간
	 */
	private String fap_job_exam_time_st;
	
	/**
	 * 시험전형 종료 시간
	 */
	private String fap_job_exam_time_et;
	
	/**
	 * 면접전형 시작일
	 */
	private String fap_job_itv_date_st;
	
	/**
	 * 면접전형 종료일
	 */
	private String fap_job_itv_date_et;
	
	/**
	 * 면접전형 시작 시간
	 */
	private String fap_job_itv_time_st;
	
	/**
	 * 면접전형 종료 시간
	 */
	private String fap_job_itv_time_et;
	
	/**
	 * 기타전형 시작일
	 */
	private String fap_job_test_etc_date_st;
	
	/**
	 * 기타전형 종료일
	 */
	private String fap_job_test_etc_date_et;
	
	/**
	 * 기타전형 시작 시간
	 */
	private String fap_job_test_etc_time_st;
	
	/**
	 * 기타전형 종료 시간
	 */
	private String fap_job_test_etc_time_et;	
	
	/**
	 * 채용전형 장소
	 */
	private String fap_job_recruit_pcs_sch_lo;
	
	/**
	 * 채용전형 대기실
	 */
	private String fap_job_recruit_pcs_sch_waitingroom;
	
	/**
	 * 채용전형 상세내용
	 */
	private String fap_job_recruit_pcs_sch_detail;
	
	/**
	 * 채용전형 색상
	 */
	private String fap_job_recruit_pcs_sch_color;
	
	/**
	 * 스케줄 설정여부(공통코드)
	 */
	private String fap_job_recruit_pcs_sch_ck;
	
	/**
	 * 전형구분(공통코드)
	 */
	private String fap_job_recruit_pcs_gb;
	
	/**
	 * 시험전형구분(공통코드)
	 */
	private String fap_job_exam_gb;
	
	/**
	 * 면접전형구분(공통코드)
	 */
	private String fap_job_itv_gb;

	/**
	 * 회사영문이름
	 */
	private String fap_comp_en_nm;	
	
	/**
	 * 채용전형 스케줄 등록자
	 */
	private String fap_job_recruit_pcs_sch_ins_id;
	
	/**
	 * 채용전형 스케줄 등록일
	 */
	private String fap_job_recruit_pcs_sch_ins_dt;
	
	/**
	 * 채용전형 스케줄 수정자
	 */
	private String fap_job_recruit_pcs_sch_udt_id;
	
	/**
	 * 채용전형 스케줄 수정일
	 */
	private String fap_job_recruit_pcs_sch_udt_dt;
	
	
	public SocietyFapJobRecruitPcsSch() {
		super();
	}

	public SocietyFapJobRecruitPcsSch(long fap_job_recruit_pcs_sch_seq, long fap_job_recruit_pcs_seq,
			int fap_jobfair_seq, int fap_jobfair_divide_seq, String comp_nm, String fap_comp_id,
			String fap_job_recruit_pcs_sch_st, String fap_job_recruit_pcs_sch_et, String fap_job_review_date_st,
			String fap_job_review_time_st, String fap_job_review_date_et, String fap_job_review_time_et,
			String fap_job_exam_date_st, String fap_job_exam_date_et, String fap_job_exam_time_st,
			String fap_job_exam_time_et, String fap_job_itv_date_st, String fap_job_itv_date_et,
			String fap_job_itv_time_st, String fap_job_itv_time_et, String fap_job_test_etc_date_st,
			String fap_job_test_etc_date_et, String fap_job_test_etc_time_st, String fap_job_test_etc_time_et,
			String fap_job_recruit_pcs_sch_lo, String fap_job_recruit_pcs_sch_waitingroom,
			String fap_job_recruit_pcs_sch_detail, String fap_job_recruit_pcs_sch_color,
			String fap_job_recruit_pcs_sch_ck, String fap_job_recruit_pcs_gb, String fap_job_exam_gb,
			String fap_job_itv_gb, String fap_comp_en_nm, String fap_job_recruit_pcs_sch_ins_id,
			String fap_job_recruit_pcs_sch_ins_dt, String fap_job_recruit_pcs_sch_udt_id,
			String fap_job_recruit_pcs_sch_udt_dt) {
		super();
		this.fap_job_recruit_pcs_sch_seq = fap_job_recruit_pcs_sch_seq;
		this.fap_job_recruit_pcs_seq = fap_job_recruit_pcs_seq;
		this.fap_jobfair_seq = fap_jobfair_seq;
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
		this.comp_nm = comp_nm;
		this.fap_comp_id = fap_comp_id;
		this.fap_job_recruit_pcs_sch_st = fap_job_recruit_pcs_sch_st;
		this.fap_job_recruit_pcs_sch_et = fap_job_recruit_pcs_sch_et;
		this.fap_job_review_date_st = fap_job_review_date_st;
		this.fap_job_review_time_st = fap_job_review_time_st;
		this.fap_job_review_date_et = fap_job_review_date_et;
		this.fap_job_review_time_et = fap_job_review_time_et;
		this.fap_job_exam_date_st = fap_job_exam_date_st;
		this.fap_job_exam_date_et = fap_job_exam_date_et;
		this.fap_job_exam_time_st = fap_job_exam_time_st;
		this.fap_job_exam_time_et = fap_job_exam_time_et;
		this.fap_job_itv_date_st = fap_job_itv_date_st;
		this.fap_job_itv_date_et = fap_job_itv_date_et;
		this.fap_job_itv_time_st = fap_job_itv_time_st;
		this.fap_job_itv_time_et = fap_job_itv_time_et;
		this.fap_job_test_etc_date_st = fap_job_test_etc_date_st;
		this.fap_job_test_etc_date_et = fap_job_test_etc_date_et;
		this.fap_job_test_etc_time_st = fap_job_test_etc_time_st;
		this.fap_job_test_etc_time_et = fap_job_test_etc_time_et;
		this.fap_job_recruit_pcs_sch_lo = fap_job_recruit_pcs_sch_lo;
		this.fap_job_recruit_pcs_sch_waitingroom = fap_job_recruit_pcs_sch_waitingroom;
		this.fap_job_recruit_pcs_sch_detail = fap_job_recruit_pcs_sch_detail;
		this.fap_job_recruit_pcs_sch_color = fap_job_recruit_pcs_sch_color;
		this.fap_job_recruit_pcs_sch_ck = fap_job_recruit_pcs_sch_ck;
		this.fap_job_recruit_pcs_gb = fap_job_recruit_pcs_gb;
		this.fap_job_exam_gb = fap_job_exam_gb;
		this.fap_job_itv_gb = fap_job_itv_gb;
		this.fap_comp_en_nm = fap_comp_en_nm;
		this.fap_job_recruit_pcs_sch_ins_id = fap_job_recruit_pcs_sch_ins_id;
		this.fap_job_recruit_pcs_sch_ins_dt = fap_job_recruit_pcs_sch_ins_dt;
		this.fap_job_recruit_pcs_sch_udt_id = fap_job_recruit_pcs_sch_udt_id;
		this.fap_job_recruit_pcs_sch_udt_dt = fap_job_recruit_pcs_sch_udt_dt;
	}


	public long getFap_job_recruit_pcs_sch_seq() {
		return fap_job_recruit_pcs_sch_seq;
	}


	public void setFap_job_recruit_pcs_sch_seq(long fap_job_recruit_pcs_sch_seq) {
		this.fap_job_recruit_pcs_sch_seq = fap_job_recruit_pcs_sch_seq;
	}


	public long getFap_job_recruit_pcs_seq() {
		return fap_job_recruit_pcs_seq;
	}


	public void setFap_job_recruit_pcs_seq(long fap_job_recruit_pcs_seq) {
		this.fap_job_recruit_pcs_seq = fap_job_recruit_pcs_seq;
	}


	public int getFap_jobfair_seq() {
		return fap_jobfair_seq;
	}


	public void setFap_jobfair_seq(int fap_jobfair_seq) {
		this.fap_jobfair_seq = fap_jobfair_seq;
	}


	public int getFap_jobfair_divide_seq() {
		return fap_jobfair_divide_seq;
	}


	public void setFap_jobfair_divide_seq(int fap_jobfair_divide_seq) {
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
	}


	public String getComp_nm() {
		return comp_nm;
	}


	public void setComp_nm(String comp_nm) {
		this.comp_nm = comp_nm;
	}


	public String getFap_comp_id() {
		return fap_comp_id;
	}


	public void setFap_comp_id(String fap_comp_id) {
		this.fap_comp_id = fap_comp_id;
	}


	public String getFap_job_recruit_pcs_sch_st() {
		return fap_job_recruit_pcs_sch_st;
	}


	public void setFap_job_recruit_pcs_sch_st(String fap_job_recruit_pcs_sch_st) {
		this.fap_job_recruit_pcs_sch_st = fap_job_recruit_pcs_sch_st;
	}


	public String getFap_job_recruit_pcs_sch_et() {
		return fap_job_recruit_pcs_sch_et;
	}


	public void setFap_job_recruit_pcs_sch_et(String fap_job_recruit_pcs_sch_et) {
		this.fap_job_recruit_pcs_sch_et = fap_job_recruit_pcs_sch_et;
	}


	public String getFap_job_review_date_st() {
		return fap_job_review_date_st;
	}


	public void setFap_job_review_date_st(String fap_job_review_date_st) {
		this.fap_job_review_date_st = fap_job_review_date_st;
	}


	public String getFap_job_review_time_st() {
		return fap_job_review_time_st;
	}


	public void setFap_job_review_time_st(String fap_job_review_time_st) {
		this.fap_job_review_time_st = fap_job_review_time_st;
	}


	public String getFap_job_review_date_et() {
		return fap_job_review_date_et;
	}


	public void setFap_job_review_date_et(String fap_job_review_date_et) {
		this.fap_job_review_date_et = fap_job_review_date_et;
	}


	public String getFap_job_review_time_et() {
		return fap_job_review_time_et;
	}


	public void setFap_job_review_time_et(String fap_job_review_time_et) {
		this.fap_job_review_time_et = fap_job_review_time_et;
	}


	public String getFap_job_exam_date_st() {
		return fap_job_exam_date_st;
	}


	public void setFap_job_exam_date_st(String fap_job_exam_date_st) {
		this.fap_job_exam_date_st = fap_job_exam_date_st;
	}


	public String getFap_job_exam_date_et() {
		return fap_job_exam_date_et;
	}


	public void setFap_job_exam_date_et(String fap_job_exam_date_et) {
		this.fap_job_exam_date_et = fap_job_exam_date_et;
	}


	public String getFap_job_exam_time_st() {
		return fap_job_exam_time_st;
	}


	public void setFap_job_exam_time_st(String fap_job_exam_time_st) {
		this.fap_job_exam_time_st = fap_job_exam_time_st;
	}


	public String getFap_job_exam_time_et() {
		return fap_job_exam_time_et;
	}


	public void setFap_job_exam_time_et(String fap_job_exam_time_et) {
		this.fap_job_exam_time_et = fap_job_exam_time_et;
	}


	public String getFap_job_itv_date_st() {
		return fap_job_itv_date_st;
	}


	public void setFap_job_itv_date_st(String fap_job_itv_date_st) {
		this.fap_job_itv_date_st = fap_job_itv_date_st;
	}


	public String getFap_job_itv_date_et() {
		return fap_job_itv_date_et;
	}


	public void setFap_job_itv_date_et(String fap_job_itv_date_et) {
		this.fap_job_itv_date_et = fap_job_itv_date_et;
	}


	public String getFap_job_itv_time_st() {
		return fap_job_itv_time_st;
	}


	public void setFap_job_itv_time_st(String fap_job_itv_time_st) {
		this.fap_job_itv_time_st = fap_job_itv_time_st;
	}


	public String getFap_job_itv_time_et() {
		return fap_job_itv_time_et;
	}


	public void setFap_job_itv_time_et(String fap_job_itv_time_et) {
		this.fap_job_itv_time_et = fap_job_itv_time_et;
	}


	public String getFap_job_test_etc_date_st() {
		return fap_job_test_etc_date_st;
	}


	public void setFap_job_test_etc_date_st(String fap_job_test_etc_date_st) {
		this.fap_job_test_etc_date_st = fap_job_test_etc_date_st;
	}


	public String getFap_job_test_etc_date_et() {
		return fap_job_test_etc_date_et;
	}


	public void setFap_job_test_etc_date_et(String fap_job_test_etc_date_et) {
		this.fap_job_test_etc_date_et = fap_job_test_etc_date_et;
	}


	public String getFap_job_test_etc_time_st() {
		return fap_job_test_etc_time_st;
	}


	public void setFap_job_test_etc_time_st(String fap_job_test_etc_time_st) {
		this.fap_job_test_etc_time_st = fap_job_test_etc_time_st;
	}


	public String getFap_job_test_etc_time_et() {
		return fap_job_test_etc_time_et;
	}


	public void setFap_job_test_etc_time_et(String fap_job_test_etc_time_et) {
		this.fap_job_test_etc_time_et = fap_job_test_etc_time_et;
	}


	public String getFap_job_recruit_pcs_sch_lo() {
		return fap_job_recruit_pcs_sch_lo;
	}


	public void setFap_job_recruit_pcs_sch_lo(String fap_job_recruit_pcs_sch_lo) {
		this.fap_job_recruit_pcs_sch_lo = fap_job_recruit_pcs_sch_lo;
	}


	public String getFap_job_recruit_pcs_sch_waitingroom() {
		return fap_job_recruit_pcs_sch_waitingroom;
	}


	public void setFap_job_recruit_pcs_sch_waitingroom(String fap_job_recruit_pcs_sch_waitingroom) {
		this.fap_job_recruit_pcs_sch_waitingroom = fap_job_recruit_pcs_sch_waitingroom;
	}


	public String getFap_job_recruit_pcs_sch_detail() {
		return fap_job_recruit_pcs_sch_detail;
	}


	public void setFap_job_recruit_pcs_sch_detail(String fap_job_recruit_pcs_sch_detail) {
		this.fap_job_recruit_pcs_sch_detail = fap_job_recruit_pcs_sch_detail;
	}


	public String getFap_job_recruit_pcs_sch_color() {
		return fap_job_recruit_pcs_sch_color;
	}


	public void setFap_job_recruit_pcs_sch_color(String fap_job_recruit_pcs_sch_color) {
		this.fap_job_recruit_pcs_sch_color = fap_job_recruit_pcs_sch_color;
	}


	public String getFap_job_recruit_pcs_sch_ck() {
		return fap_job_recruit_pcs_sch_ck;
	}


	public void setFap_job_recruit_pcs_sch_ck(String fap_job_recruit_pcs_sch_ck) {
		this.fap_job_recruit_pcs_sch_ck = fap_job_recruit_pcs_sch_ck;
	}


	public String getFap_job_recruit_pcs_gb() {
		return fap_job_recruit_pcs_gb;
	}


	public void setFap_job_recruit_pcs_gb(String fap_job_recruit_pcs_gb) {
		this.fap_job_recruit_pcs_gb = fap_job_recruit_pcs_gb;
	}


	public String getFap_job_exam_gb() {
		return fap_job_exam_gb;
	}


	public void setFap_job_exam_gb(String fap_job_exam_gb) {
		this.fap_job_exam_gb = fap_job_exam_gb;
	}


	public String getFap_job_itv_gb() {
		return fap_job_itv_gb;
	}


	public void setFap_job_itv_gb(String fap_job_itv_gb) {
		this.fap_job_itv_gb = fap_job_itv_gb;
	}


	public String getFap_comp_en_nm() {
		return fap_comp_en_nm;
	}


	public void setFap_comp_en_nm(String fap_comp_en_nm) {
		this.fap_comp_en_nm = fap_comp_en_nm;
	}


	public String getFap_job_recruit_pcs_sch_ins_id() {
		return fap_job_recruit_pcs_sch_ins_id;
	}


	public void setFap_job_recruit_pcs_sch_ins_id(String fap_job_recruit_pcs_sch_ins_id) {
		this.fap_job_recruit_pcs_sch_ins_id = fap_job_recruit_pcs_sch_ins_id;
	}


	public String getFap_job_recruit_pcs_sch_ins_dt() {
		return fap_job_recruit_pcs_sch_ins_dt;
	}


	public void setFap_job_recruit_pcs_sch_ins_dt(String fap_job_recruit_pcs_sch_ins_dt) {
		this.fap_job_recruit_pcs_sch_ins_dt = fap_job_recruit_pcs_sch_ins_dt;
	}


	public String getFap_job_recruit_pcs_sch_udt_id() {
		return fap_job_recruit_pcs_sch_udt_id;
	}


	public void setFap_job_recruit_pcs_sch_udt_id(String fap_job_recruit_pcs_sch_udt_id) {
		this.fap_job_recruit_pcs_sch_udt_id = fap_job_recruit_pcs_sch_udt_id;
	}


	public String getFap_job_recruit_pcs_sch_udt_dt() {
		return fap_job_recruit_pcs_sch_udt_dt;
	}


	public void setFap_job_recruit_pcs_sch_udt_dt(String fap_job_recruit_pcs_sch_udt_dt) {
		this.fap_job_recruit_pcs_sch_udt_dt = fap_job_recruit_pcs_sch_udt_dt;
	}


	@Override
	public String toString() {
		return "SocietyFapJobRecruitPcsSch [fap_job_recruit_pcs_sch_seq=" + fap_job_recruit_pcs_sch_seq
				+ ", fap_job_recruit_pcs_seq=" + fap_job_recruit_pcs_seq + ", fap_jobfair_seq=" + fap_jobfair_seq
				+ ", fap_jobfair_divide_seq=" + fap_jobfair_divide_seq + ", comp_nm=" + comp_nm + ", fap_comp_id="
				+ fap_comp_id + ", fap_job_recruit_pcs_sch_st=" + fap_job_recruit_pcs_sch_st
				+ ", fap_job_recruit_pcs_sch_et=" + fap_job_recruit_pcs_sch_et + ", fap_job_review_date_st="
				+ fap_job_review_date_st + ", fap_job_review_time_st=" + fap_job_review_time_st
				+ ", fap_job_review_date_et=" + fap_job_review_date_et + ", fap_job_review_time_et="
				+ fap_job_review_time_et + ", fap_job_exam_date_st=" + fap_job_exam_date_st + ", fap_job_exam_date_et="
				+ fap_job_exam_date_et + ", fap_job_exam_time_st=" + fap_job_exam_time_st + ", fap_job_exam_time_et="
				+ fap_job_exam_time_et + ", fap_job_itv_date_st=" + fap_job_itv_date_st + ", fap_job_itv_date_et="
				+ fap_job_itv_date_et + ", fap_job_itv_time_st=" + fap_job_itv_time_st + ", fap_job_itv_time_et="
				+ fap_job_itv_time_et + ", fap_job_test_etc_date_st=" + fap_job_test_etc_date_st
				+ ", fap_job_test_etc_date_et=" + fap_job_test_etc_date_et + ", fap_job_test_etc_time_st="
				+ fap_job_test_etc_time_st + ", fap_job_test_etc_time_et=" + fap_job_test_etc_time_et
				+ ", fap_job_recruit_pcs_sch_lo=" + fap_job_recruit_pcs_sch_lo
				+ ", fap_job_recruit_pcs_sch_waitingroom=" + fap_job_recruit_pcs_sch_waitingroom
				+ ", fap_job_recruit_pcs_sch_detail=" + fap_job_recruit_pcs_sch_detail
				+ ", fap_job_recruit_pcs_sch_color=" + fap_job_recruit_pcs_sch_color + ", fap_job_recruit_pcs_sch_ck="
				+ fap_job_recruit_pcs_sch_ck + ", fap_job_recruit_pcs_gb=" + fap_job_recruit_pcs_gb
				+ ", fap_job_exam_gb=" + fap_job_exam_gb + ", fap_job_itv_gb=" + fap_job_itv_gb + ", fap_comp_en_nm="
				+ fap_comp_en_nm + ", fap_job_recruit_pcs_sch_ins_id=" + fap_job_recruit_pcs_sch_ins_id
				+ ", fap_job_recruit_pcs_sch_ins_dt=" + fap_job_recruit_pcs_sch_ins_dt
				+ ", fap_job_recruit_pcs_sch_udt_id=" + fap_job_recruit_pcs_sch_udt_id
				+ ", fap_job_recruit_pcs_sch_udt_dt=" + fap_job_recruit_pcs_sch_udt_dt + "]";
	}
}
