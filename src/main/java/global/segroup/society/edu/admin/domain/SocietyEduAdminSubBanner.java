/**
 * 
 */
package global.segroup.society.edu.admin.domain;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 신동철
 * @Date : 2018. 9. 20.
 * @Class 설명 : 모집 홍보 서브 배너
 * 
 */
public class SocietyEduAdminSubBanner {

	/**
	 * 서브 배너 시퀀스
	 */
	private int edu_sub_ban_seq;
	
	/**
	 * 서브 배너 이름
	 */
	private String edu_sub_ban_nm;
	
	/**
	 * 서브 배너 링크
	 */
	private String edu_sub_ban_link;
	
	/**
	 * 서브 배너 파일
	 */
	private CommonsMultipartFile edu_sub_ban_file;
	
	/**
	 * 서브 배너 원본 파일 이름
	 */
	private String edu_sub_ban_origin;
	
	/**
	 * 서브 배너 저장 파일 이름
	 */
	private String edu_sub_ban_saved;
	
	/**
	 * 등록일자
	 */
	private String edu_sub_ban_ins_dt;
	
	/**
	 * 등록인
	 */
	private String edu_sub_ban_ins_id;
	
	/**
	 * 수정일자
	 */
	private String edu_sub_ban_udt_dt;
	
	/**
	 * 수정인
	 */
	private String edu_sub_ban_udt_id;
	
	/**
	 * 노출여부(기본값 : B2401)
	 */
	private String edu_sub_ban_eps;
	
	/**
	 * 순서(기본값 : 1)
	 */
	private int edu_sub_ban_od;

	/**
	 * 신청기간 시작일
	 */
	private String edu_sub_ban_st;
	
	/**
	 * 신청기간 마감일
	 */
	private String edu_sub_ban_et;
	
	/**
	 * 사진 경로
	 */
	private String img_full_path;
	
	public SocietyEduAdminSubBanner() {
		super();
	}

	public SocietyEduAdminSubBanner(int edu_sub_ban_seq, String edu_sub_ban_nm, String edu_sub_ban_link,
			CommonsMultipartFile edu_sub_ban_file, String edu_sub_ban_origin, String edu_sub_ban_saved,
			String edu_sub_ban_ins_dt, String edu_sub_ban_ins_id, String edu_sub_ban_udt_dt, String edu_sub_ban_udt_id,
			String edu_sub_ban_eps, int edu_sub_ban_od, String edu_sub_ban_st, String edu_sub_ban_et, String img_full_path) {
		super();
		this.edu_sub_ban_seq = edu_sub_ban_seq;
		this.edu_sub_ban_nm = edu_sub_ban_nm;
		this.edu_sub_ban_link = edu_sub_ban_link;
		this.edu_sub_ban_file = edu_sub_ban_file;
		this.edu_sub_ban_origin = edu_sub_ban_origin;
		this.edu_sub_ban_saved = edu_sub_ban_saved;
		this.edu_sub_ban_ins_dt = edu_sub_ban_ins_dt;
		this.edu_sub_ban_ins_id = edu_sub_ban_ins_id;
		this.edu_sub_ban_udt_dt = edu_sub_ban_udt_dt;
		this.edu_sub_ban_udt_id = edu_sub_ban_udt_id;
		this.edu_sub_ban_eps = edu_sub_ban_eps;
		this.edu_sub_ban_od = edu_sub_ban_od;
		this.edu_sub_ban_st = edu_sub_ban_st;
		this.edu_sub_ban_et = edu_sub_ban_et;
		this.img_full_path = img_full_path;
	}

	public int getEdu_sub_ban_seq() {
		return edu_sub_ban_seq;
	}

	public void setEdu_sub_ban_seq(int edu_sub_ban_seq) {
		this.edu_sub_ban_seq = edu_sub_ban_seq;
	}

	public String getEdu_sub_ban_nm() {
		return edu_sub_ban_nm;
	}

	public void setEdu_sub_ban_nm(String edu_sub_ban_nm) {
		this.edu_sub_ban_nm = edu_sub_ban_nm;
	}

	public String getEdu_sub_ban_link() {
		return edu_sub_ban_link;
	}

	public void setEdu_sub_ban_link(String edu_sub_ban_link) {
		this.edu_sub_ban_link = edu_sub_ban_link;
	}

	public CommonsMultipartFile getEdu_sub_ban_file() {
		return edu_sub_ban_file;
	}

	public void setEdu_sub_ban_file(CommonsMultipartFile edu_sub_ban_file) {
		this.edu_sub_ban_file = edu_sub_ban_file;
	}

	public String getEdu_sub_ban_origin() {
		return edu_sub_ban_origin;
	}

	public void setEdu_sub_ban_origin(String edu_sub_ban_origin) {
		this.edu_sub_ban_origin = edu_sub_ban_origin;
	}

	public String getEdu_sub_ban_saved() {
		return edu_sub_ban_saved;
	}

	public void setEdu_sub_ban_saved(String edu_sub_ban_saved) {
		this.edu_sub_ban_saved = edu_sub_ban_saved;
	}

	public String getEdu_sub_ban_ins_dt() {
		return edu_sub_ban_ins_dt;
	}

	public void setEdu_sub_ban_ins_dt(String edu_sub_ban_ins_dt) {
		this.edu_sub_ban_ins_dt = edu_sub_ban_ins_dt;
	}

	public String getEdu_sub_ban_ins_id() {
		return edu_sub_ban_ins_id;
	}

	public void setEdu_sub_ban_ins_id(String edu_sub_ban_ins_id) {
		this.edu_sub_ban_ins_id = edu_sub_ban_ins_id;
	}

	public String getEdu_sub_ban_udt_dt() {
		return edu_sub_ban_udt_dt;
	}

	public void setEdu_sub_ban_udt_dt(String edu_sub_ban_udt_dt) {
		this.edu_sub_ban_udt_dt = edu_sub_ban_udt_dt;
	}

	public String getEdu_sub_ban_udt_id() {
		return edu_sub_ban_udt_id;
	}

	public void setEdu_sub_ban_udt_id(String edu_sub_ban_udt_id) {
		this.edu_sub_ban_udt_id = edu_sub_ban_udt_id;
	}

	public String getEdu_sub_ban_eps() {
		return edu_sub_ban_eps;
	}

	public void setEdu_sub_ban_eps(String edu_sub_ban_eps) {
		this.edu_sub_ban_eps = edu_sub_ban_eps;
	}

	public int getEdu_sub_ban_od() {
		return edu_sub_ban_od;
	}

	public void setEdu_sub_ban_od(int edu_sub_ban_od) {
		this.edu_sub_ban_od = edu_sub_ban_od;
	}

	public String getEdu_sub_ban_st() {
		return edu_sub_ban_st;
	}

	public void setEdu_sub_ban_st(String edu_sub_ban_st) {
		this.edu_sub_ban_st = edu_sub_ban_st;
	}

	public String getEdu_sub_ban_et() {
		return edu_sub_ban_et;
	}

	public void setEdu_sub_ban_et(String edu_sub_ban_et) {
		this.edu_sub_ban_et = edu_sub_ban_et;
	}
	
	/**
	 * @return the img_full_path
	 */
	public String getImg_full_path() {
		return img_full_path;
	}

	/**
	 * @param img_full_path the img_full_path to set
	 */
	public void setImg_full_path(String img_full_path) {
		this.img_full_path = img_full_path;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "SocietyEduAdminSubBanner [edu_sub_ban_seq=" + edu_sub_ban_seq + ", edu_sub_ban_nm=" + edu_sub_ban_nm
				+ ", edu_sub_ban_link=" + edu_sub_ban_link + ", edu_sub_ban_file=" + edu_sub_ban_file
				+ ", edu_sub_ban_origin=" + edu_sub_ban_origin + ", edu_sub_ban_saved=" + edu_sub_ban_saved
				+ ", edu_sub_ban_ins_dt=" + edu_sub_ban_ins_dt + ", edu_sub_ban_ins_id=" + edu_sub_ban_ins_id
				+ ", edu_sub_ban_udt_dt=" + edu_sub_ban_udt_dt + ", edu_sub_ban_udt_id=" + edu_sub_ban_udt_id
				+ ", edu_sub_ban_eps=" + edu_sub_ban_eps + ", edu_sub_ban_od=" + edu_sub_ban_od + ", edu_sub_ban_st="
				+ edu_sub_ban_st + ", edu_sub_ban_et=" + edu_sub_ban_et + ", img_full_path=" + img_full_path + "]";
	}
		
}
