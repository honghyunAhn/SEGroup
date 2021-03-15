/**
 * 
 */
package global.segroup.society.edu.admin.domain;

import java.util.List;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 신동철
 * @Date : 2018. 9. 17.
 * @Class 설명 : Society 모집홍보 기수 이미지 정보
 * 
 */
public class SocietyEduAdminCurriculumGisuImg {

	/**
	 * 기수 정보 이미지 시퀀스
	 */
	private int gisu_crc_img_seq;
	
	/**
	 * 기수 정보 시퀀스
	 */
	private int gisu_seq;
	
	/**
	 * 이미지 파일 저장 이름
	 */
	private String gisu_crc_img_saved;
	
	/**
	 * 이미지 파일 원본 이름
	 */
	private String gisu_crc_img_origin;
	
	/**
	 * 등록일자
	 */
	private String gisu_crc_img_ins_dt;
	
	/**
	 * 등록인
	 */
	private String gisu_crc_img_saved_file_ins_id;
	
	/**
	 * 수정일자
	 */
	private String gisu_crc_img_udt_dt;
	
	/**
	 * 수정인
	 */
	private String gisu_crc_img_udt_id;
	
	/**
	 * 사진순서
	 */
	private int gisu_crc_img_saved_file_od;
	
	/**
	 * 기수 정보 이미지 파일
	 */
	private CommonsMultipartFile gisu_crc_img_file;

	/**
	 * 기수 이미지 파일 리스트
	 */
	private List<SocietyEduAdminCurriculumGisuImg> gisu_crc_img_list;
	
	
	public SocietyEduAdminCurriculumGisuImg() {
		super();
	}

	public SocietyEduAdminCurriculumGisuImg(int gisu_crc_img_seq, int gisu_seq, String gisu_crc_img_saved,
			String gisu_crc_img_origin, String gisu_crc_img_ins_dt, String gisu_crc_img_saved_file_ins_id,
			String gisu_crc_img_udt_dt, String gisu_crc_img_udt_id, int gisu_crc_img_saved_file_od,
			CommonsMultipartFile gisu_crc_img_file, List<SocietyEduAdminCurriculumGisuImg> gisu_crc_img_list) {
		super();
		this.gisu_crc_img_seq = gisu_crc_img_seq;
		this.gisu_seq = gisu_seq;
		this.gisu_crc_img_saved = gisu_crc_img_saved;
		this.gisu_crc_img_origin = gisu_crc_img_origin;
		this.gisu_crc_img_ins_dt = gisu_crc_img_ins_dt;
		this.gisu_crc_img_saved_file_ins_id = gisu_crc_img_saved_file_ins_id;
		this.gisu_crc_img_udt_dt = gisu_crc_img_udt_dt;
		this.gisu_crc_img_udt_id = gisu_crc_img_udt_id;
		this.gisu_crc_img_saved_file_od = gisu_crc_img_saved_file_od;
		this.gisu_crc_img_file = gisu_crc_img_file;
		this.gisu_crc_img_list = gisu_crc_img_list;
	}

	public int getGisu_crc_img_seq() {
		return gisu_crc_img_seq;
	}

	public void setGisu_crc_img_seq(int gisu_crc_img_seq) {
		this.gisu_crc_img_seq = gisu_crc_img_seq;
	}

	public int getGisu_seq() {
		return gisu_seq;
	}

	public void setGisu_seq(int gisu_seq) {
		this.gisu_seq = gisu_seq;
	}

	public String getGisu_crc_img_saved() {
		return gisu_crc_img_saved;
	}

	public void setGisu_crc_img_saved(String gisu_crc_img_saved) {
		this.gisu_crc_img_saved = gisu_crc_img_saved;
	}

	public String getGisu_crc_img_origin() {
		return gisu_crc_img_origin;
	}

	public void setGisu_crc_img_origin(String gisu_crc_img_origin) {
		this.gisu_crc_img_origin = gisu_crc_img_origin;
	}

	public String getGisu_crc_img_ins_dt() {
		return gisu_crc_img_ins_dt;
	}

	public void setGisu_crc_img_ins_dt(String gisu_crc_img_ins_dt) {
		this.gisu_crc_img_ins_dt = gisu_crc_img_ins_dt;
	}

	public String getGisu_crc_img_saved_file_ins_id() {
		return gisu_crc_img_saved_file_ins_id;
	}

	public void setGisu_crc_img_saved_file_ins_id(String gisu_crc_img_saved_file_ins_id) {
		this.gisu_crc_img_saved_file_ins_id = gisu_crc_img_saved_file_ins_id;
	}

	public String getGisu_crc_img_udt_dt() {
		return gisu_crc_img_udt_dt;
	}

	public void setGisu_crc_img_udt_dt(String gisu_crc_img_udt_dt) {
		this.gisu_crc_img_udt_dt = gisu_crc_img_udt_dt;
	}

	public String getGisu_crc_img_udt_id() {
		return gisu_crc_img_udt_id;
	}

	public void setGisu_crc_img_udt_id(String gisu_crc_img_udt_id) {
		this.gisu_crc_img_udt_id = gisu_crc_img_udt_id;
	}

	public int getGisu_crc_img_saved_file_od() {
		return gisu_crc_img_saved_file_od;
	}

	public void setGisu_crc_img_saved_file_od(int gisu_crc_img_saved_file_od) {
		this.gisu_crc_img_saved_file_od = gisu_crc_img_saved_file_od;
	}

	public CommonsMultipartFile getGisu_crc_img_file() {
		return gisu_crc_img_file;
	}

	public void setGisu_crc_img_file(CommonsMultipartFile gisu_crc_img_file) {
		this.gisu_crc_img_file = gisu_crc_img_file;
	}

	public List<SocietyEduAdminCurriculumGisuImg> getGisu_crc_img_list() {
		return gisu_crc_img_list;
	}

	public void setGisu_crc_img_list(List<SocietyEduAdminCurriculumGisuImg> gisu_crc_img_list) {
		this.gisu_crc_img_list = gisu_crc_img_list;
	}

	@Override
	public String toString() {
		return "SocietyEduAdminCurriculumGisuImg [gisu_crc_img_seq=" + gisu_crc_img_seq + ", gisu_seq=" + gisu_seq
				+ ", gisu_crc_img_saved=" + gisu_crc_img_saved + ", gisu_crc_img_origin=" + gisu_crc_img_origin
				+ ", gisu_crc_img_ins_dt=" + gisu_crc_img_ins_dt + ", gisu_crc_img_saved_file_ins_id="
				+ gisu_crc_img_saved_file_ins_id + ", gisu_crc_img_udt_dt=" + gisu_crc_img_udt_dt
				+ ", gisu_crc_img_udt_id=" + gisu_crc_img_udt_id + ", gisu_crc_img_saved_file_od="
				+ gisu_crc_img_saved_file_od + ", gisu_crc_img_file=" + gisu_crc_img_file + ", gisu_crc_img_list="
				+ gisu_crc_img_list + "]";
	}		
}
