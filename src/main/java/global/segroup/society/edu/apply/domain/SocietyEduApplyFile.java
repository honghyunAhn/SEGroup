/**
 * 
 */
package global.segroup.society.edu.apply.domain;

import java.util.List;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 26.
 * @Class 설명 : Society 모집홍보 지원신청서 파일 정보
 * 
 */
public class SocietyEduApplyFile {
	
	/**
	 * 지원 신청서 시퀀스
	 */
	private int app_seq;
	
	/**
	 * 지원 신청서 파일 시퀀스
	 */
	private int app_file_seq;
	
	/**
	 * 원본 파일명
	 */
	private String app_file_origin;
	
	/**
	 * 저장 파일명
	 */
	private String app_file_saved;
	
	/**
	 * 지원 신청 관련 파일
	 */
	private CommonsMultipartFile app_file;
	
	/**
	 * 등록인
	 */
	private String app_file_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String app_file_ins_dt;
	
	/**
	 * 수정인
	 */
	private String app_file_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String app_file_udt_dt;
	
	private List<SocietyEduApplyFile> fileList;

	public SocietyEduApplyFile() {
		super();
	}

	public SocietyEduApplyFile(int app_seq, int app_file_seq, String app_file_origin, String app_file_saved,
			CommonsMultipartFile app_file, String app_file_ins_id, String app_file_ins_dt, String app_file_udt_id,
			String app_file_udt_dt) {
		super();
		this.app_seq = app_seq;
		this.app_file_seq = app_file_seq;
		this.app_file_origin = app_file_origin;
		this.app_file_saved = app_file_saved;
		this.app_file = app_file;
		this.app_file_ins_id = app_file_ins_id;
		this.app_file_ins_dt = app_file_ins_dt;
		this.app_file_udt_id = app_file_udt_id;
		this.app_file_udt_dt = app_file_udt_dt;
	}

	public int getApp_seq() {
		return app_seq;
	}

	public void setApp_seq(int app_seq) {
		this.app_seq = app_seq;
	}

	public int getApp_file_seq() {
		return app_file_seq;
	}

	public void setApp_file_seq(int app_file_seq) {
		this.app_file_seq = app_file_seq;
	}

	public String getApp_file_origin() {
		return app_file_origin;
	}

	public void setApp_file_origin(String app_file_origin) {
		this.app_file_origin = app_file_origin;
	}

	public String getApp_file_saved() {
		return app_file_saved;
	}

	public void setApp_file_saved(String app_file_saved) {
		this.app_file_saved = app_file_saved;
	}

	public CommonsMultipartFile getApp_file() {
		return app_file;
	}

	public void setApp_file(CommonsMultipartFile app_file) {
		this.app_file = app_file;
	}

	public String getApp_file_ins_id() {
		return app_file_ins_id;
	}

	public void setApp_file_ins_id(String app_file_ins_id) {
		this.app_file_ins_id = app_file_ins_id;
	}

	public String getApp_file_ins_dt() {
		return app_file_ins_dt;
	}

	public void setApp_file_ins_dt(String app_file_ins_dt) {
		this.app_file_ins_dt = app_file_ins_dt;
	}

	public String getApp_file_udt_id() {
		return app_file_udt_id;
	}

	public void setApp_file_udt_id(String app_file_udt_id) {
		this.app_file_udt_id = app_file_udt_id;
	}

	public String getApp_file_udt_dt() {
		return app_file_udt_dt;
	}

	public void setApp_file_udt_dt(String app_file_udt_dt) {
		this.app_file_udt_dt = app_file_udt_dt;
	}
	
	public List<SocietyEduApplyFile> getFileList() {
		return fileList;
	}

	public void setFileList(List<SocietyEduApplyFile> fileList) {
		this.fileList = fileList;
	}

	@Override
	public String toString() {
		return "SocietyEduApplyFile [app_seq=" + app_seq + ", app_file_seq=" + app_file_seq + ", app_file_origin="
				+ app_file_origin + ", app_file_saved=" + app_file_saved + ", app_file=" + app_file
				+ ", app_file_ins_id=" + app_file_ins_id + ", app_file_ins_dt=" + app_file_ins_dt + ", app_file_udt_id="
				+ app_file_udt_id + ", app_file_udt_dt=" + app_file_udt_dt + ", fileList=" + fileList + "]";
	}

}
