/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 이종호
 * @Date : 2019. 4. 19.
 * @Class 설명 : FAP 팝업 정보
 * 
 */
public class SocietyFapPopup {
	private int fap_popup_seq;
	private String fap_popup_title;
	private String fap_popup_ct;
	private String fap_popup_img_origin;
	private String fap_popup_img_saved;
	private String fap_popup_gb;
	private String fap_popup_st;
	private String fap_popup_link;
	private String fap_popup_ins_id;
	private String fap_popup_ins_dt;
	private String fap_popup_udt_id;
	private String fap_popup_udt_dt;
	private CommonsMultipartFile fap_popup_img;
	
	public SocietyFapPopup() {
		super();
	}

	public SocietyFapPopup(int fap_popup_seq, String fap_popup_title, String fap_popup_ct, String fap_popup_img_origin,
			String fap_popup_img_saved, String fap_popup_gb, String fap_popup_st, String fap_popup_link,
			String fap_popup_ins_id, String fap_popup_ins_dt, String fap_popup_udt_id, String fap_popup_udt_dt,
			CommonsMultipartFile fap_popup_img) {
		super();
		this.fap_popup_seq = fap_popup_seq;
		this.fap_popup_title = fap_popup_title;
		this.fap_popup_ct = fap_popup_ct;
		this.fap_popup_img_origin = fap_popup_img_origin;
		this.fap_popup_img_saved = fap_popup_img_saved;
		this.fap_popup_gb = fap_popup_gb;
		this.fap_popup_st = fap_popup_st;
		this.fap_popup_link = fap_popup_link;
		this.fap_popup_ins_id = fap_popup_ins_id;
		this.fap_popup_ins_dt = fap_popup_ins_dt;
		this.fap_popup_udt_id = fap_popup_udt_id;
		this.fap_popup_udt_dt = fap_popup_udt_dt;
		this.fap_popup_img = fap_popup_img;
	}

	public int getFap_popup_seq() {
		return fap_popup_seq;
	}

	public void setFap_popup_seq(int fap_popup_seq) {
		this.fap_popup_seq = fap_popup_seq;
	}

	public String getFap_popup_title() {
		return fap_popup_title;
	}

	public void setFap_popup_title(String fap_popup_title) {
		this.fap_popup_title = fap_popup_title;
	}

	public String getFap_popup_ct() {
		return fap_popup_ct;
	}

	public void setFap_popup_ct(String fap_popup_ct) {
		this.fap_popup_ct = fap_popup_ct;
	}

	public String getFap_popup_img_origin() {
		return fap_popup_img_origin;
	}

	public void setFap_popup_img_origin(String fap_popup_img_origin) {
		this.fap_popup_img_origin = fap_popup_img_origin;
	}

	public String getFap_popup_img_saved() {
		return fap_popup_img_saved;
	}

	public void setFap_popup_img_saved(String fap_popup_img_saved) {
		this.fap_popup_img_saved = fap_popup_img_saved;
	}

	public String getFap_popup_gb() {
		return fap_popup_gb;
	}

	public void setFap_popup_gb(String fap_popup_gb) {
		this.fap_popup_gb = fap_popup_gb;
	}

	public String getFap_popup_st() {
		return fap_popup_st;
	}

	public void setFap_popup_st(String fap_popup_st) {
		this.fap_popup_st = fap_popup_st;
	}

	public String getFap_popup_link() {
		return fap_popup_link;
	}

	public void setFap_popup_link(String fap_popup_link) {
		this.fap_popup_link = fap_popup_link;
	}

	public String getFap_popup_ins_id() {
		return fap_popup_ins_id;
	}

	public void setFap_popup_ins_id(String fap_popup_ins_id) {
		this.fap_popup_ins_id = fap_popup_ins_id;
	}

	public String getFap_popup_ins_dt() {
		return fap_popup_ins_dt;
	}

	public void setFap_popup_ins_dt(String fap_popup_ins_dt) {
		this.fap_popup_ins_dt = fap_popup_ins_dt;
	}

	public String getFap_popup_udt_id() {
		return fap_popup_udt_id;
	}

	public void setFap_popup_udt_id(String fap_popup_udt_id) {
		this.fap_popup_udt_id = fap_popup_udt_id;
	}

	public String getFap_popup_udt_dt() {
		return fap_popup_udt_dt;
	}

	public void setFap_popup_udt_dt(String fap_popup_udt_dt) {
		this.fap_popup_udt_dt = fap_popup_udt_dt;
	}

	public CommonsMultipartFile getFap_popup_img() {
		return fap_popup_img;
	}

	public void setFap_popup_img(CommonsMultipartFile fap_popup_img) {
		this.fap_popup_img = fap_popup_img;
	}

	@Override
	public String toString() {
		return "SocietyFapPopup [fap_popup_seq=" + fap_popup_seq + ", fap_popup_title=" + fap_popup_title
				+ ", fap_popup_ct=" + fap_popup_ct + ", fap_popup_img_origin=" + fap_popup_img_origin
				+ ", fap_popup_img_saved=" + fap_popup_img_saved + ", fap_popup_gb=" + fap_popup_gb + ", fap_popup_st="
				+ fap_popup_st + ", fap_popup_link=" + fap_popup_link + ", fap_popup_ins_id=" + fap_popup_ins_id
				+ ", fap_popup_ins_dt=" + fap_popup_ins_dt + ", fap_popup_udt_id=" + fap_popup_udt_id
				+ ", fap_popup_udt_dt=" + fap_popup_udt_dt + ", fap_popup_img=" + fap_popup_img + "]";
	}
	
}
