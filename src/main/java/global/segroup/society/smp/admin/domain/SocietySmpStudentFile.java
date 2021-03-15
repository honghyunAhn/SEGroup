package global.segroup.society.smp.admin.domain;

import java.util.List;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

import global.segroup.society.edu.apply.domain.SocietyEduApplyFile;

/**
 * @Author : 여명환
 * @Date : 2018. 8. 23.
 * @Class 설명 : Society 학생 학력 정보
 * 
 */
public class SocietySmpStudentFile {


	/**
	 * 지원 신청서 시퀀스
	 */
	private int smp_seq;
	
	/**
	 * 지원 신청서 파일 시퀀스
	 */
	private int smp_file_seq;
	
	/**
	 * 원본 파일명
	 */
	private String smp_file_origin;
	
	/**
	 * 저장 파일명
	 */
	private String smp_file_saved;
	
	/**
	 * 지원 신청 관련 파일
	 */
	private CommonsMultipartFile smp_file;
	
	/**
	 * 등록인
	 */
	private String smp_file_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String smp_file_ins_dt;
	
	/**
	 * 수정인
	 */
	private String smp_file_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String smp_file_udt_dt;
	
	private List<SocietySmpStudentFile> fileList;

	public SocietySmpStudentFile() {
		super();
	}

	public SocietySmpStudentFile(int smp_seq, int smp_file_seq, String smp_file_origin, String smp_file_saved,
			CommonsMultipartFile smp_file, String smp_file_ins_id, String smp_file_ins_dt, String smp_file_udt_id,
			String smp_file_udt_dt) {
		super();
		this.smp_seq = smp_seq;
		this.smp_file_seq = smp_file_seq;
		this.smp_file_origin = smp_file_origin;
		this.smp_file_saved = smp_file_saved;
		this.smp_file = smp_file;
		this.smp_file_ins_id = smp_file_ins_id;
		this.smp_file_ins_dt = smp_file_ins_dt;
		this.smp_file_udt_id = smp_file_udt_id;
		this.smp_file_udt_dt = smp_file_udt_dt;
	}

	public int getSmp_seq() {
		return smp_seq;
	}

	public void setSmp_seq(int smp_seq) {
		this.smp_seq = smp_seq;
	}

	public int getSmp_file_seq() {
		return smp_file_seq;
	}

	public void setSmp_file_seq(int smp_file_seq) {
		this.smp_file_seq = smp_file_seq;
	}

	public String getSmp_file_origin() {
		return smp_file_origin;
	}

	public void setSmp_file_origin(String smp_file_origin) {
		this.smp_file_origin = smp_file_origin;
	}

	public String getSmp_file_saved() {
		return smp_file_saved;
	}

	public void setSmp_file_saved(String smp_file_saved) {
		this.smp_file_saved = smp_file_saved;
	}

	public CommonsMultipartFile getSmp_file() {
		return smp_file;
	}

	public void setSmp_file(CommonsMultipartFile smp_file) {
		this.smp_file = smp_file;
	}

	public String getSmp_file_ins_id() {
		return smp_file_ins_id;
	}

	public void setSmp_file_ins_id(String smp_file_ins_id) {
		this.smp_file_ins_id = smp_file_ins_id;
	}

	public String getSmp_file_ins_dt() {
		return smp_file_ins_dt;
	}

	public void setSmp_file_ins_dt(String smp_file_ins_dt) {
		this.smp_file_ins_dt = smp_file_ins_dt;
	}

	public String getSmp_file_udt_id() {
		return smp_file_udt_id;
	}

	public void setSmp_file_udt_id(String smp_file_udt_id) {
		this.smp_file_udt_id = smp_file_udt_id;
	}

	public String getSmp_file_udt_dt() {
		return smp_file_udt_dt;
	}

	public void setSmp_file_udt_dt(String smp_file_udt_dt) {
		this.smp_file_udt_dt = smp_file_udt_dt;
	}
	
	public List<SocietySmpStudentFile> getFileList() {
		return fileList;
	}

	public void setFileList(List<SocietySmpStudentFile> fileList) {
		this.fileList = fileList;
	}

	@Override
	public String toString() {
		return "SocietyEduApplyFile [smp_seq=" + smp_seq + ", smp_file_seq=" + smp_file_seq + ", smp_file_origin="
				+ smp_file_origin + ", smp_file_saved=" + smp_file_saved + ", smp_file=" + smp_file
				+ ", smp_file_ins_id=" + smp_file_ins_id + ", smp_file_ins_dt=" + smp_file_ins_dt + ", smp_file_udt_id="
				+ smp_file_udt_id + ", smp_file_udt_dt=" + smp_file_udt_dt + ", fileList=" + fileList + "]";
	}

}

