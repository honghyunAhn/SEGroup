/**
 * 
 */
package global.segroup.domain;

/**
 * @Author : 김도훈
 * @Date : 2018. 7. 24.
 * @Class 설명 : FAQ 상담 글의 정보를 담을 객체
 * 
 */
public class FaqConsultingContents {
	/**
	 * FAQ 게시판 게시물 고유 시퀀스
	 */
	private int consulting_seq;
	
	/**
	 * FAQ 게시판 카테고리
	 */
	private String consulting_tp;
	
	/**
	 * FAQ 게시판 게시물 제목
	 */
	private String consulting_title;
	
	/**
	 * FAQ 게시판 게시물 내용
	 */
	private String consulting_ct;

	/**
	 * FAQ 게시판 게시물 작성자 이름
	 */
	private String consulting_nm;
	
	/**
	 * FAQ 게시판 게시물 등록인 
	 */
	private String consulting_ins_id;
	
	/**
	 * FAQ 게시판 게시물 등록 일자 
	 */
	private String consulting_ins_dt;
	
	/**
	 * FAQ 게시판 게시물 수정 일자
	 */
	private String consulting_udt_dt;
	
	/**
	 * FAQ 게시판 게시물 수정인 
	 */
	private String consulting_udt_id;

	public FaqConsultingContents() {
		super();
	}

	public FaqConsultingContents(int consulting_seq, String consulting_tp, String consulting_title,
			String consulting_ct, String consulting_nm, String consulting_ins_id, String consulting_ins_dt,
			String consulting_udt_dt, String consulting_udt_id) {
		super();
		this.consulting_seq = consulting_seq;
		this.consulting_tp = consulting_tp;
		this.consulting_title = consulting_title;
		this.consulting_ct = consulting_ct;
		this.consulting_nm = consulting_nm;
		this.consulting_ins_id = consulting_ins_id;
		this.consulting_ins_dt = consulting_ins_dt;
		this.consulting_udt_dt = consulting_udt_dt;
		this.consulting_udt_id = consulting_udt_id;
	}

	public int getConsulting_seq() {
		return consulting_seq;
	}

	public void setConsulting_seq(int consulting_seq) {
		this.consulting_seq = consulting_seq;
	}

	public String getConsulting_tp() {
		return consulting_tp;
	}

	public void setConsulting_tp(String consulting_tp) {
		this.consulting_tp = consulting_tp;
	}

	public String getConsulting_title() {
		return consulting_title;
	}

	public void setConsulting_title(String consulting_title) {
		this.consulting_title = consulting_title;
	}

	public String getConsulting_ct() {
		return consulting_ct;
	}

	public void setConsulting_ct(String consulting_ct) {
		this.consulting_ct = consulting_ct;
	}

	public String getConsulting_nm() {
		return consulting_nm;
	}

	public void setConsulting_nm(String consulting_nm) {
		this.consulting_nm = consulting_nm;
	}

	public String getConsulting_ins_id() {
		return consulting_ins_id;
	}

	public void setConsulting_ins_id(String consulting_ins_id) {
		this.consulting_ins_id = consulting_ins_id;
	}

	public String getConsulting_ins_dt() {
		return consulting_ins_dt;
	}

	public void setConsulting_ins_dt(String consulting_ins_dt) {
		this.consulting_ins_dt = consulting_ins_dt;
	}

	public String getConsulting_udt_dt() {
		return consulting_udt_dt;
	}

	public void setConsulting_udt_dt(String consulting_udt_dt) {
		this.consulting_udt_dt = consulting_udt_dt;
	}

	public String getConsulting_udt_id() {
		return consulting_udt_id;
	}

	public void setConsulting_udt_id(String consulting_udt_id) {
		this.consulting_udt_id = consulting_udt_id;
	}

	@Override
	public String toString() {
		return "FaqConsultingContents [consulting_seq=" + consulting_seq + ", consulting_tp=" + consulting_tp
				+ ", consulting_title=" + consulting_title + ", consulting_ct=" + consulting_ct + ", consulting_nm="
				+ consulting_nm + ", consulting_ins_id=" + consulting_ins_id + ", consulting_ins_dt="
				+ consulting_ins_dt + ", consulting_udt_dt=" + consulting_udt_dt + ", consulting_udt_id="
				+ consulting_udt_id + "]";
	}

}
