/**
 * 
 */
package global.segroup.society.edu.admin.domain;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 김준영
 * @Date : 2018. 9. 17.
 * @Class 설명 : EDU_CURRICULUM_IMG 테이블 VO; 과정 등록시 이미지 파일 저장
 * 
 */
public class SpcietyEduAdminCurriculumImage {

	/**
	 * 과정 정보 이미지 시퀀스
	 */
	private int crc_img_seq;
	
	/**
	 * 과정 정보 시퀀스
	 */
	private int crc_seq;
	
	/**
	 * 파일 저장 이름
	 */
	private String crc_img_saved;
	
	/**
	 * 파일 원본 이름
	 */
	private String crc_img_origin;
	
	/**
	 * 등록 일자
	 */
	private String crc_img_ins_dt;
	
	/**
	 * 등록인
	 */
	private String crc_img_saved_file_ins_id;
	
	/**
	 * 수정 일자
	 */
	private String crc_img_udt_dt;
	
	/**
	 * 수정인
	 */
	private String crc_img_udt_id;
	
	/**
	 * 사진 순서
	 */
	private int crc_img_saved_file_od;
	
	/**
	 * 과정 정보 이미지 파일
	 */
	private CommonsMultipartFile crc_img_file;

	/**
	 * @Desc : 
	 */
	public SpcietyEduAdminCurriculumImage() {
		super();
	}

	/**
	 * @Desc : 
	 * @param crc_img_seq
	 * @param crc_seq
	 * @param crc_img_saved
	 * @param crc_img_origin
	 * @param crc_img_ins_dt
	 * @param crc_img_saved_file_ins_id
	 * @param crc_img_udt_dt
	 * @param crc_img_udt_id
	 * @param crc_img_saved_file_od
	 * @param crc_img_file
	 */
	public SpcietyEduAdminCurriculumImage(int crc_img_seq, int crc_seq, String crc_img_saved, String crc_img_origin,
			String crc_img_ins_dt, String crc_img_saved_file_ins_id, String crc_img_udt_dt, String crc_img_udt_id,
			int crc_img_saved_file_od, CommonsMultipartFile crc_img_file) {
		super();
		this.crc_img_seq = crc_img_seq;
		this.crc_seq = crc_seq;
		this.crc_img_saved = crc_img_saved;
		this.crc_img_origin = crc_img_origin;
		this.crc_img_ins_dt = crc_img_ins_dt;
		this.crc_img_saved_file_ins_id = crc_img_saved_file_ins_id;
		this.crc_img_udt_dt = crc_img_udt_dt;
		this.crc_img_udt_id = crc_img_udt_id;
		this.crc_img_saved_file_od = crc_img_saved_file_od;
		this.crc_img_file = crc_img_file;
	}

	/**
	 * @return the crc_img_seq
	 */
	public int getCrc_img_seq() {
		return crc_img_seq;
	}

	/**
	 * @param crc_img_seq the crc_img_seq to set
	 */
	public void setCrc_img_seq(int crc_img_seq) {
		this.crc_img_seq = crc_img_seq;
	}

	/**
	 * @return the crc_seq
	 */
	public int getCrc_seq() {
		return crc_seq;
	}

	/**
	 * @param crc_seq the crc_seq to set
	 */
	public void setCrc_seq(int crc_seq) {
		this.crc_seq = crc_seq;
	}

	/**
	 * @return the crc_img_saved
	 */
	public String getCrc_img_saved() {
		return crc_img_saved;
	}

	/**
	 * @param crc_img_saved the crc_img_saved to set
	 */
	public void setCrc_img_saved(String crc_img_saved) {
		this.crc_img_saved = crc_img_saved;
	}

	/**
	 * @return the crc_img_origin
	 */
	public String getCrc_img_origin() {
		return crc_img_origin;
	}

	/**
	 * @param crc_img_origin the crc_img_origin to set
	 */
	public void setCrc_img_origin(String crc_img_origin) {
		this.crc_img_origin = crc_img_origin;
	}

	/**
	 * @return the crc_img_ins_dt
	 */
	public String getCrc_img_ins_dt() {
		return crc_img_ins_dt;
	}

	/**
	 * @param crc_img_ins_dt the crc_img_ins_dt to set
	 */
	public void setCrc_img_ins_dt(String crc_img_ins_dt) {
		this.crc_img_ins_dt = crc_img_ins_dt;
	}

	/**
	 * @return the crc_img_saved_file_ins_id
	 */
	public String getCrc_img_saved_file_ins_id() {
		return crc_img_saved_file_ins_id;
	}

	/**
	 * @param crc_img_saved_file_ins_id the crc_img_saved_file_ins_id to set
	 */
	public void setCrc_img_saved_file_ins_id(String crc_img_saved_file_ins_id) {
		this.crc_img_saved_file_ins_id = crc_img_saved_file_ins_id;
	}

	/**
	 * @return the crc_img_udt_dt
	 */
	public String getCrc_img_udt_dt() {
		return crc_img_udt_dt;
	}

	/**
	 * @param crc_img_udt_dt the crc_img_udt_dt to set
	 */
	public void setCrc_img_udt_dt(String crc_img_udt_dt) {
		this.crc_img_udt_dt = crc_img_udt_dt;
	}

	/**
	 * @return the crc_img_udt_id
	 */
	public String getCrc_img_udt_id() {
		return crc_img_udt_id;
	}

	/**
	 * @param crc_img_udt_id the crc_img_udt_id to set
	 */
	public void setCrc_img_udt_id(String crc_img_udt_id) {
		this.crc_img_udt_id = crc_img_udt_id;
	}

	/**
	 * @return the crc_img_saved_file_od
	 */
	public int getCrc_img_saved_file_od() {
		return crc_img_saved_file_od;
	}

	/**
	 * @param crc_img_saved_file_od the crc_img_saved_file_od to set
	 */
	public void setCrc_img_saved_file_od(int crc_img_saved_file_od) {
		this.crc_img_saved_file_od = crc_img_saved_file_od;
	}

	/**
	 * @return the crc_img_file
	 */
	public CommonsMultipartFile getCrc_img_file() {
		return crc_img_file;
	}

	/**
	 * @param crc_img_file the crc_img_file to set
	 */
	public void setCrc_img_file(CommonsMultipartFile crc_img_file) {
		this.crc_img_file = crc_img_file;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "SpcietyEduAdminCurriculumImage [crc_img_seq=" + crc_img_seq + ", crc_seq=" + crc_seq
				+ ", crc_img_saved=" + crc_img_saved + ", crc_img_origin=" + crc_img_origin + ", crc_img_ins_dt="
				+ crc_img_ins_dt + ", crc_img_saved_file_ins_id=" + crc_img_saved_file_ins_id + ", crc_img_udt_dt="
				+ crc_img_udt_dt + ", crc_img_udt_id=" + crc_img_udt_id + ", crc_img_saved_file_od="
				+ crc_img_saved_file_od + ", crc_img_file=" + crc_img_file + "]";
	}
	
}
