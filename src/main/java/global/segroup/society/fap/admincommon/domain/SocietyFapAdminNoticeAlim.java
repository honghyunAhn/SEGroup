/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

/**
 * @Author : 김경아
 * @Date : 2019. 8. 29.
 * @Class 설명 : FAP 관리자 알림 정보
 * 
 */
public class SocietyFapAdminNoticeAlim {
	
	/*
	 * 관리자 알림게시판 시퀀스 
	 */
	private int fap_admin_notice_seq;
	
	/*
	 * 알림 내용 
	 */
	private String fap_admin_notice_ct;
	
	/*
	 * 등록자 
	 */
	private String fap_admin_notice_ins_id;
	
	/*
	 * 알림 등록일 
	 */
	private String fap_admin_notice_ins_dt;
	
	/*
	 * 알림내용 처리자 
	 */
	private String fap_admin_notice_handle_id;
	
	/*
	 * 알림내용에 대한 관리자 처리 필요여부(공통코드D21)
	 */
	private String fap_admin_notice_handle_need_gb;
	
	/*
	 * 알림내용에 대한 관리자 처리 완료여부(공통코드D22)
	 */
	private String fap_admin_notice_handle_fin_gb;
	
	/*
	 * 관리자 알림 구분(공통코드D23)
	 */
	private String fap_admin_notice_handle_gb;
	

	

	
	public SocietyFapAdminNoticeAlim() {
		super();
	}


	public SocietyFapAdminNoticeAlim(int fap_admin_notice_seq, String fap_admin_notice_ct,
			String fap_admin_notice_ins_id, String fap_admin_notice_ins_dt, String fap_admin_notice_handle_id,
			String fap_admin_notice_handle_need_gb, String fap_admin_notice_handle_fin_gb,
			String fap_admin_notice_handle_gb) {
		super();
		this.fap_admin_notice_seq = fap_admin_notice_seq;
		this.fap_admin_notice_ct = fap_admin_notice_ct;
		this.fap_admin_notice_ins_id = fap_admin_notice_ins_id;
		this.fap_admin_notice_ins_dt = fap_admin_notice_ins_dt;
		this.fap_admin_notice_handle_id = fap_admin_notice_handle_id;
		this.fap_admin_notice_handle_need_gb = fap_admin_notice_handle_need_gb;
		this.fap_admin_notice_handle_fin_gb = fap_admin_notice_handle_fin_gb;
		this.fap_admin_notice_handle_gb = fap_admin_notice_handle_gb;
	}







	public int getFap_admin_notice_seq() {
		return fap_admin_notice_seq;
	}

	public void setFap_admin_notice_seq(int fap_admin_notice_seq) {
		this.fap_admin_notice_seq = fap_admin_notice_seq;
	}

	public String getFap_admin_notice_ct() {
		return fap_admin_notice_ct;
	}

	public void setFap_admin_notice_ct(String fap_admin_notice_ct) {
		this.fap_admin_notice_ct = fap_admin_notice_ct;
	}

	public String getFap_admin_notice_ins_id() {
		return fap_admin_notice_ins_id;
	}

	public void setFap_admin_notice_ins_id(String fap_admin_notice_ins_id) {
		this.fap_admin_notice_ins_id = fap_admin_notice_ins_id;
	}

	public String getFap_admin_notice_ins_dt() {
		return fap_admin_notice_ins_dt;
	}

	public void setFap_admin_notice_ins_dt(String fap_admin_notice_ins_dt) {
		this.fap_admin_notice_ins_dt = fap_admin_notice_ins_dt;
	}

	public String getFap_admin_notice_handle_id() {
		return fap_admin_notice_handle_id;
	}

	public void setFap_admin_notice_handle_id(String fap_admin_notice_handle_id) {
		this.fap_admin_notice_handle_id = fap_admin_notice_handle_id;
	}

	public String getFap_admin_notice_handle_need_gb() {
		return fap_admin_notice_handle_need_gb;
	}

	public void setFap_admin_notice_handle_need_gb(String fap_admin_notice_handle_need_gb) {
		this.fap_admin_notice_handle_need_gb = fap_admin_notice_handle_need_gb;
	}

	public String getFap_admin_notice_handle_fin_gb() {
		return fap_admin_notice_handle_fin_gb;
	}

	public void setFap_admin_notice_handle_fin_gb(String fap_admin_notice_handle_fin_gb) {
		this.fap_admin_notice_handle_fin_gb = fap_admin_notice_handle_fin_gb;
	}
	
	public String getFap_admin_notice_handle_gb() {
		return fap_admin_notice_handle_gb;
	}



	public void setFap_admin_notice_handle_gb(String fap_admin_notice_handle_gb) {
		this.fap_admin_notice_handle_gb = fap_admin_notice_handle_gb;
	}

	
	@Override
	public String toString() {
		return "SocietyFapAdminNoticeAlim [fap_admin_notice_seq=" + fap_admin_notice_seq + ", fap_admin_notice_ct="
				+ fap_admin_notice_ct + ", fap_admin_notice_ins_id=" + fap_admin_notice_ins_id
				+ ", fap_admin_notice_ins_dt=" + fap_admin_notice_ins_dt + ", fap_admin_notice_handle_id="
				+ fap_admin_notice_handle_id + ", fap_admin_notice_handle_need_gb=" + fap_admin_notice_handle_need_gb
				+ ", fap_admin_notice_handle_fin_gb=" + fap_admin_notice_handle_fin_gb + ", fap_admin_notice_handle_gb="
				+ fap_admin_notice_handle_gb + "]";
	}

 

	  


	
}
