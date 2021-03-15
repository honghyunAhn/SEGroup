/**
 * 
 */
package global.segroup.society.edu.admin.domain;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 신동철
 * @Date : 2018. 9. 20.
 * @Class 설명 : 모집 홍보 배너
 * 
 */
public class SocietyEduAdminBanner {
	/**
	 * 배너 시퀀스
	 */
	private int edu_ban_seq;
	
	/**
	 * 배너 이름
	 */
	private String edu_ban_nm;
	
	/**
	 * 배너 링크
	 */
	private String edu_ban_link;
	
	/**
	 * 배너 파일
	 */
	private CommonsMultipartFile edu_ban_file;
	
	/**
	 * 배너 원본 파일 이름
	 */
	private String edu_ban_origin;
	
	/**
	 * 배너 저장 파일 이름
	 */
	private String edu_ban_saved;
	
	/**
	 * 등록일자
	 */
	private String edu_ban_ins_dt;
	
	/**
	 * 등록인
	 */
	private String edu_ban_ins_id;
	
	/**
	 * 수정일자
	 */
	private String edu_ban_udt_dt;
	
	/**
	 * 수정인
	 */
	private String edu_ban_udt_id;
	
	/**
	 * 노출여부(기본값 : B2401)
	 */
	private String edu_ban_eps;
	
	/**
	 * 순서(기본값 : 1)
	 */
	private int edu_ban_od;

	/**
	 * 사진 경로
	 */
	private String img_full_path;

	public SocietyEduAdminBanner() {
		super();
	}

	public SocietyEduAdminBanner(int edu_ban_seq, String edu_ban_nm, String edu_ban_link,
			CommonsMultipartFile edu_ban_file, String edu_ban_origin, String edu_ban_saved, String edu_ban_ins_dt,
			String edu_ban_ins_id, String edu_ban_udt_dt, String edu_ban_udt_id, String edu_ban_eps, int edu_ban_od,
			String img_full_path) {
		super();
		this.edu_ban_seq = edu_ban_seq;
		this.edu_ban_nm = edu_ban_nm;
		this.edu_ban_link = edu_ban_link;
		this.edu_ban_file = edu_ban_file;
		this.edu_ban_origin = edu_ban_origin;
		this.edu_ban_saved = edu_ban_saved;
		this.edu_ban_ins_dt = edu_ban_ins_dt;
		this.edu_ban_ins_id = edu_ban_ins_id;
		this.edu_ban_udt_dt = edu_ban_udt_dt;
		this.edu_ban_udt_id = edu_ban_udt_id;
		this.edu_ban_eps = edu_ban_eps;
		this.edu_ban_od = edu_ban_od;
		this.img_full_path = img_full_path;
	}

	/**
	 * @return the edu_ban_seq
	 */
	public int getEdu_ban_seq() {
		return edu_ban_seq;
	}

	/**
	 * @param edu_ban_seq the edu_ban_seq to set
	 */
	public void setEdu_ban_seq(int edu_ban_seq) {
		this.edu_ban_seq = edu_ban_seq;
	}

	/**
	 * @return the edu_ban_nm
	 */
	public String getEdu_ban_nm() {
		return edu_ban_nm;
	}

	/**
	 * @param edu_ban_nm the edu_ban_nm to set
	 */
	public void setEdu_ban_nm(String edu_ban_nm) {
		this.edu_ban_nm = edu_ban_nm;
	}

	/**
	 * @return the edu_ban_link
	 */
	public String getEdu_ban_link() {
		return edu_ban_link;
	}

	/**
	 * @param edu_ban_link the edu_ban_link to set
	 */
	public void setEdu_ban_link(String edu_ban_link) {
		this.edu_ban_link = edu_ban_link;
	}

	/**
	 * @return the edu_ban_file
	 */
	public CommonsMultipartFile getEdu_ban_file() {
		return edu_ban_file;
	}

	/**
	 * @param edu_ban_file the edu_ban_file to set
	 */
	public void setEdu_ban_file(CommonsMultipartFile edu_ban_file) {
		this.edu_ban_file = edu_ban_file;
	}

	/**
	 * @return the edu_ban_origin
	 */
	public String getEdu_ban_origin() {
		return edu_ban_origin;
	}

	/**
	 * @param edu_ban_origin the edu_ban_origin to set
	 */
	public void setEdu_ban_origin(String edu_ban_origin) {
		this.edu_ban_origin = edu_ban_origin;
	}

	/**
	 * @return the edu_ban_saved
	 */
	public String getEdu_ban_saved() {
		return edu_ban_saved;
	}

	/**
	 * @param edu_ban_saved the edu_ban_saved to set
	 */
	public void setEdu_ban_saved(String edu_ban_saved) {
		this.edu_ban_saved = edu_ban_saved;
	}

	/**
	 * @return the edu_ban_ins_dt
	 */
	public String getEdu_ban_ins_dt() {
		return edu_ban_ins_dt;
	}

	/**
	 * @param edu_ban_ins_dt the edu_ban_ins_dt to set
	 */
	public void setEdu_ban_ins_dt(String edu_ban_ins_dt) {
		this.edu_ban_ins_dt = edu_ban_ins_dt;
	}

	/**
	 * @return the edu_ban_ins_id
	 */
	public String getEdu_ban_ins_id() {
		return edu_ban_ins_id;
	}

	/**
	 * @param edu_ban_ins_id the edu_ban_ins_id to set
	 */
	public void setEdu_ban_ins_id(String edu_ban_ins_id) {
		this.edu_ban_ins_id = edu_ban_ins_id;
	}

	/**
	 * @return the edu_ban_udt_dt
	 */
	public String getEdu_ban_udt_dt() {
		return edu_ban_udt_dt;
	}

	/**
	 * @param edu_ban_udt_dt the edu_ban_udt_dt to set
	 */
	public void setEdu_ban_udt_dt(String edu_ban_udt_dt) {
		this.edu_ban_udt_dt = edu_ban_udt_dt;
	}

	/**
	 * @return the edu_ban_udt_id
	 */
	public String getEdu_ban_udt_id() {
		return edu_ban_udt_id;
	}

	/**
	 * @param edu_ban_udt_id the edu_ban_udt_id to set
	 */
	public void setEdu_ban_udt_id(String edu_ban_udt_id) {
		this.edu_ban_udt_id = edu_ban_udt_id;
	}

	/**
	 * @return the edu_ban_eps
	 */
	public String getEdu_ban_eps() {
		return edu_ban_eps;
	}

	/**
	 * @param edu_ban_eps the edu_ban_eps to set
	 */
	public void setEdu_ban_eps(String edu_ban_eps) {
		this.edu_ban_eps = edu_ban_eps;
	}

	/**
	 * @return the edu_ban_od
	 */
	public int getEdu_ban_od() {
		return edu_ban_od;
	}

	/**
	 * @param edu_ban_od the edu_ban_od to set
	 */
	public void setEdu_ban_od(int edu_ban_od) {
		this.edu_ban_od = edu_ban_od;
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

	
	@Override
	public String toString() {
		return "SocietyEduAdminBanner [edu_ban_seq=" + edu_ban_seq + ", edu_ban_nm=" + edu_ban_nm + ", edu_ban_link="
				+ edu_ban_link + ", edu_ban_file=" + edu_ban_file + ", edu_ban_origin=" + edu_ban_origin
				+ ", edu_ban_saved=" + edu_ban_saved + ", edu_ban_ins_dt=" + edu_ban_ins_dt + ", edu_ban_ins_id="
				+ edu_ban_ins_id + ", edu_ban_udt_dt=" + edu_ban_udt_dt + ", edu_ban_udt_id=" + edu_ban_udt_id
				+ ", edu_ban_eps=" + edu_ban_eps + ", edu_ban_od=" + edu_ban_od + ", img_full_path=" + img_full_path
				+ "]";
	}

}
