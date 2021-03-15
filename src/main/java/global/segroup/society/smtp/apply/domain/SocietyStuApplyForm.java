/**
 * 
 */
package global.segroup.society.smtp.apply.domain;

import java.util.Date;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 김성미
 * @Date : 2020. 8. 4.
 * @Class 설명 : Society 지원신청서 기본 정보 
 * 
 */
public class SocietyStuApplyForm {
	/**
	 * 지원신청서 시퀀스
	 */
	private int stu_app_seq;
	
	/**
	 * 지원신청자 아이디
	 */
	private String user_id;

	/**
	 * 기수정보 아이디
	 */
	private String gisu_id;
	
	/**
	 * 과정 코드
	 */
	private String crc_id;
	
	/**
	 * 지원신청자 이름
	 */
	private String stu_app_nm;

	/**
	 * 지원신청자 생년월일
	 */
	private String stu_app_birth;

	/**
	 * 지원신청자 성별(공통코드)
	 */
	private String stu_app_gender;

	/**
	 * 군병력 체크(공통코드)
	 */
	private String stu_app_mt_ck;
	
	/**
	 * 군병력 사유 
	 */
	private String stu_app_mt_etc;
	
	/**
	 * 우편번호
	 */
	private String stu_app_zipcode;
	
	/**
	 * 현 주소
	 */
	private String stu_app_addr;
	
	/**
	 * 상세주소
	 */
	private String stu_app_addr_detail;
	
	/**
	 * 연락처
	 */
	private String stu_app_phone;

	/**
	 * 비상 연락처
	 */
	private String stu_app_em_phone;

	/**
	 * 이메일
	 */
	private String stu_app_email;

	/**
	 * 사진 저장 파일명
	 */
	private String stu_app_photo_saved;
	
	/**
	 * 사진 원본 파일명
	 */
	private String stu_app_photo_origin;
	
	/**
	 * 사진 파일
	 */
	private CommonsMultipartFile stu_app_photo_file;
	/**
	 * 최종 학력증명서 저장 파일명
	 */
	private String stu_app_edu_file_saved;
	
	/**
	 * 최종 학력증명서 원본 파일명
	 */
	private String stu_app_edu_file_origin;
	
	/**
	 * 최종 학력증명서 파일
	 */
	private CommonsMultipartFile stu_app_edu_file;
	
	/**
	 * 고용보험 상실확인 저장 파일명
	 */
	private String stu_app_isr_file_saved;
	
	/**
	 * 고용보험 상실확인 원본 파일명
	 */
	private String stu_app_isr_file_origin;
	
	/**
	 * 고용보험 상실확인 파일
	 */
	private CommonsMultipartFile stu_app_isr_file;
	
	/**
	 * 출입국 사실증명서 저장 파일명
	 */
	private String stu_app_imm_file_saved;
	
	/**
	 * 출입국 사실증명서 원본 파일명
	 */
	private String stu_app_imm_file_origin;
	
	/**
	 * 출입국 사실증명서 파일
	 */
	private CommonsMultipartFile stu_app_imm_file;
	
	/**
	 * 워크넷 직무평가 결과 저장 파일명
	 */
	private String stu_app_worknet_file_saved;
	
	/**
	 * 워크넷 직무평가 결과 원본 파일명
	 */
	private String stu_app_worknet_file_origin;
	
	/**
	 * 워크넷 직무평가 결과 파일
	 */
	private CommonsMultipartFile stu_app_worknet_file; 
	
	/**
	 * 등록인
	 */
	private String stu_app_ins_id;
	
	/**
	 * 등록일자(yyyyMMdd24hhmiss) 
	 */
	private String stu_app_ins_dt;
	
	/**
	 * 등록일자(update용 DateType) 
	 */
	private Date stu_app_ins_dt_forupdate;
	
	/**
	 * 수정인 
	 */
	private String stu_app_udt_id;
	
	/**
	 * 수정일자(yyyyMMdd24hhmiss)
	 */
	private String stu_app_udt_dt;
	
	/**
	 * 서류결과(공통코드)
	 */
	private String stu_app_rt_doc;
	
	/**
	 * 서류결과 처리담당자 
	 */
	private String str_app_rt_doc_id;
	
	/**
	 * 서류결과 처리일 
	 */
	private String str_app_rt_doc_dt;
	
	/**
	 * 면접결과(공통코드) 
	 */
	private String str_app_rt_itv;
	
	/**
	 * 면접결과 처리담당자 
	 */
	private String str_app_rt_itv_id;
	
	/**
	 * 면접결과 처리일 
	 */
	private String str_app_rt_itv_dt;
	
	public SocietyStuApplyForm() {
		super();
	}


	public SocietyStuApplyForm(int stu_app_seq, String user_id, String gisu_id, String crc_id, String stu_app_nm, String stu_app_birth,
			String stu_app_gender, String stu_app_mt_ck, String stu_app_mt_etc, String stu_app_zipcode,
			String stu_app_addr, String stu_app_addr_detail, String stu_app_phone, String stu_app_em_phone,
			String stu_app_email, String stu_app_photo_saved, String stu_app_photo_origin,
			CommonsMultipartFile stu_app_photo_file, String stu_app_edu_file_saved, String stu_app_edu_file_origin,
			CommonsMultipartFile stu_app_edu_file, String stu_app_isr_file_saved, String stu_app_isr_file_origin,
			CommonsMultipartFile stu_app_isr_file, String stu_app_imm_file_saved, String stu_app_imm_file_origin,
			CommonsMultipartFile stu_app_imm_file, String stu_app_worknet_file_saved,
			String stu_app_worknet_file_origin, CommonsMultipartFile stu_app_worknet_file, String stu_app_ins_id,
			String stu_app_ins_dt, Date stu_app_ins_dt_forupdate, String stu_app_udt_id, String stu_app_udt_dt,
			String stu_app_rt_doc, String str_app_rt_doc_id, String str_app_rt_doc_dt, String str_app_rt_itv,
			String str_app_rt_itv_id, String str_app_rt_itv_dt) {
		super();
		this.stu_app_seq = stu_app_seq;
		this.user_id = user_id;
		this.gisu_id = gisu_id;
		this.crc_id = crc_id;
		this.stu_app_nm = stu_app_nm;
		this.stu_app_birth = stu_app_birth;
		this.stu_app_gender = stu_app_gender;
		this.stu_app_mt_ck = stu_app_mt_ck;
		this.stu_app_mt_etc = stu_app_mt_etc;
		this.stu_app_zipcode = stu_app_zipcode;
		this.stu_app_addr = stu_app_addr;
		this.stu_app_addr_detail = stu_app_addr_detail;
		this.stu_app_phone = stu_app_phone;
		this.stu_app_em_phone = stu_app_em_phone;
		this.stu_app_email = stu_app_email;
		this.stu_app_photo_saved = stu_app_photo_saved;
		this.stu_app_photo_origin = stu_app_photo_origin;
		this.stu_app_photo_file = stu_app_photo_file;
		this.stu_app_edu_file_saved = stu_app_edu_file_saved;
		this.stu_app_edu_file_origin = stu_app_edu_file_origin;
		this.stu_app_edu_file = stu_app_edu_file;
		this.stu_app_isr_file_saved = stu_app_isr_file_saved;
		this.stu_app_isr_file_origin = stu_app_isr_file_origin;
		this.stu_app_isr_file = stu_app_isr_file;
		this.stu_app_imm_file_saved = stu_app_imm_file_saved;
		this.stu_app_imm_file_origin = stu_app_imm_file_origin;
		this.stu_app_imm_file = stu_app_imm_file;
		this.stu_app_worknet_file_saved = stu_app_worknet_file_saved;
		this.stu_app_worknet_file_origin = stu_app_worknet_file_origin;
		this.stu_app_worknet_file = stu_app_worknet_file;
		this.stu_app_ins_id = stu_app_ins_id;
		this.stu_app_ins_dt = stu_app_ins_dt;
		this.stu_app_ins_dt_forupdate = stu_app_ins_dt_forupdate;
		this.stu_app_udt_id = stu_app_udt_id;
		this.stu_app_udt_dt = stu_app_udt_dt;
		this.stu_app_rt_doc = stu_app_rt_doc;
		this.str_app_rt_doc_id = str_app_rt_doc_id;
		this.str_app_rt_doc_dt = str_app_rt_doc_dt;
		this.str_app_rt_itv = str_app_rt_itv;
		this.str_app_rt_itv_id = str_app_rt_itv_id;
		this.str_app_rt_itv_dt = str_app_rt_itv_dt;
	}

	public int getStu_app_seq() {
		return stu_app_seq;
	}

	public void setStu_app_seq(int stu_app_seq) {
		this.stu_app_seq = stu_app_seq;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getGisu_id() {
		return gisu_id;
	}

	public void setGisu_id(String gisu_id) {
		this.gisu_id = gisu_id;
	}

	public String getCrc_id() {
		return crc_id;
	}

	public void setCrc_id(String crc_id) {
		this.crc_id = crc_id;
	}
	
	public String getStu_app_nm() {
		return stu_app_nm;
	}

	public void setStu_app_nm(String stu_app_nm) {
		this.stu_app_nm = stu_app_nm;
	}

	public String getStu_app_birth() {
		return stu_app_birth;
	}

	public void setStu_app_birth(String stu_app_birth) {
		this.stu_app_birth = stu_app_birth;
	}

	public String getStu_app_gender() {
		return stu_app_gender;
	}

	public void setStu_app_gender(String stu_app_gender) {
		this.stu_app_gender = stu_app_gender;
	}

	public String getStu_app_mt_ck() {
		return stu_app_mt_ck;
	}

	public void setStu_app_mt_ck(String stu_app_mt_ck) {
		this.stu_app_mt_ck = stu_app_mt_ck;
	}

	public String getStu_app_mt_etc() {
		return stu_app_mt_etc;
	}

	public void setStu_app_mt_etc(String stu_app_mt_etc) {
		this.stu_app_mt_etc = stu_app_mt_etc;
	}

	public String getStu_app_zipcode() {
		return stu_app_zipcode;
	}

	public void setStu_app_zipcode(String stu_app_zipcode) {
		this.stu_app_zipcode = stu_app_zipcode;
	}

	public String getStu_app_addr() {
		return stu_app_addr;
	}

	public void setStu_app_addr(String stu_app_addr) {
		this.stu_app_addr = stu_app_addr;
	}

	public String getStu_app_addr_detail() {
		return stu_app_addr_detail;
	}

	public void setStu_app_addr_detail(String stu_app_addr_detail) {
		this.stu_app_addr_detail = stu_app_addr_detail;
	}

	public String getStu_app_phone() {
		return stu_app_phone;
	}

	public void setStu_app_phone(String stu_app_phone) {
		this.stu_app_phone = stu_app_phone;
	}

	public String getStu_app_em_phone() {
		return stu_app_em_phone;
	}

	public void setStu_app_em_phone(String stu_app_em_phone) {
		this.stu_app_em_phone = stu_app_em_phone;
	}

	public String getStu_app_email() {
		return stu_app_email;
	}

	public void setStu_app_email(String stu_app_email) {
		this.stu_app_email = stu_app_email;
	}

	public String getStu_app_photo_saved() {
		return stu_app_photo_saved;
	}

	public void setStu_app_photo_saved(String stu_app_photo_saved) {
		this.stu_app_photo_saved = stu_app_photo_saved;
	}

	public String getStu_app_photo_origin() {
		return stu_app_photo_origin;
	}

	public void setStu_app_photo_origin(String stu_app_photo_origin) {
		this.stu_app_photo_origin = stu_app_photo_origin;
	}

	public CommonsMultipartFile getStu_app_photo_file() {
		return stu_app_photo_file;
	}

	public void setStu_app_photo_file(CommonsMultipartFile stu_app_photo_file) {
		this.stu_app_photo_file = stu_app_photo_file;
	}

	public String getStu_app_edu_file_saved() {
		return stu_app_edu_file_saved;
	}

	public void setStu_app_edu_file_saved(String stu_app_edu_file_saved) {
		this.stu_app_edu_file_saved = stu_app_edu_file_saved;
	}

	public String getStu_app_edu_file_origin() {
		return stu_app_edu_file_origin;
	}

	public void setStu_app_edu_file_origin(String stu_app_edu_file_origin) {
		this.stu_app_edu_file_origin = stu_app_edu_file_origin;
	}

	public CommonsMultipartFile getStu_app_edu_file() {
		return stu_app_edu_file;
	}

	public void setStu_app_edu_file(CommonsMultipartFile stu_app_edu_file) {
		this.stu_app_edu_file = stu_app_edu_file;
	}

	public String getStu_app_isr_file_saved() {
		return stu_app_isr_file_saved;
	}

	public void setStu_app_isr_file_saved(String stu_app_isr_file_saved) {
		this.stu_app_isr_file_saved = stu_app_isr_file_saved;
	}

	public String getStu_app_isr_file_origin() {
		return stu_app_isr_file_origin;
	}

	public void setStu_app_isr_file_origin(String stu_app_isr_file_origin) {
		this.stu_app_isr_file_origin = stu_app_isr_file_origin;
	}

	public CommonsMultipartFile getStu_app_isr_file() {
		return stu_app_isr_file;
	}

	public void setStu_app_isr_file(CommonsMultipartFile stu_app_isr_file) {
		this.stu_app_isr_file = stu_app_isr_file;
	}

	public String getStu_app_imm_file_saved() {
		return stu_app_imm_file_saved;
	}

	public void setStu_app_imm_file_saved(String stu_app_imm_file_saved) {
		this.stu_app_imm_file_saved = stu_app_imm_file_saved;
	}

	public String getStu_app_imm_file_origin() {
		return stu_app_imm_file_origin;
	}

	public void setStu_app_imm_file_origin(String stu_app_imm_file_origin) {
		this.stu_app_imm_file_origin = stu_app_imm_file_origin;
	}

	public CommonsMultipartFile getStu_app_imm_file() {
		return stu_app_imm_file;
	}

	public void setStu_app_imm_file(CommonsMultipartFile stu_app_imm_file) {
		this.stu_app_imm_file = stu_app_imm_file;
	}

	public String getStu_app_worknet_file_saved() {
		return stu_app_worknet_file_saved;
	}

	public void setStu_app_worknet_file_saved(String stu_app_worknet_file_saved) {
		this.stu_app_worknet_file_saved = stu_app_worknet_file_saved;
	}

	public String getStu_app_worknet_file_origin() {
		return stu_app_worknet_file_origin;
	}

	public void setStu_app_worknet_file_origin(String stu_app_worknet_file_origin) {
		this.stu_app_worknet_file_origin = stu_app_worknet_file_origin;
	}

	public CommonsMultipartFile getStu_app_worknet_file() {
		return stu_app_worknet_file;
	}

	public void setStu_app_worknet_file(CommonsMultipartFile stu_app_worknet_file) {
		this.stu_app_worknet_file = stu_app_worknet_file;
	}

	public String getStu_app_ins_id() {
		return stu_app_ins_id;
	}

	public void setStu_app_ins_id(String stu_app_ins_id) {
		this.stu_app_ins_id = stu_app_ins_id;
	}

	public String getStu_app_ins_dt() {
		return stu_app_ins_dt;
	}

	public void setStu_app_ins_dt(String stu_app_ins_dt) {
		this.stu_app_ins_dt = stu_app_ins_dt;
	}

	public Date getStu_app_ins_dt_forupdate() {
		return stu_app_ins_dt_forupdate;
	}

	public void setStu_app_ins_dt_forupdate(Date stu_app_ins_dt_forupdate) {
		this.stu_app_ins_dt_forupdate = stu_app_ins_dt_forupdate;
	}

	public String getStu_app_udt_id() {
		return stu_app_udt_id;
	}

	public void setStu_app_udt_id(String stu_app_udt_id) {
		this.stu_app_udt_id = stu_app_udt_id;
	}

	public String getStu_app_udt_dt() {
		return stu_app_udt_dt;
	}

	public void setStu_app_udt_dt(String stu_app_udt_dt) {
		this.stu_app_udt_dt = stu_app_udt_dt;
	}

	public String getStu_app_rt_doc() {
		return stu_app_rt_doc;
	}

	public void setStu_app_rt_doc(String stu_app_rt_doc) {
		this.stu_app_rt_doc = stu_app_rt_doc;
	}

	public String getStr_app_rt_doc_id() {
		return str_app_rt_doc_id;
	}

	public void setStr_app_rt_doc_id(String str_app_rt_doc_id) {
		this.str_app_rt_doc_id = str_app_rt_doc_id;
	}

	public String getStr_app_rt_doc_dt() {
		return str_app_rt_doc_dt;
	}

	public void setStr_app_rt_doc_dt(String str_app_rt_doc_dt) {
		this.str_app_rt_doc_dt = str_app_rt_doc_dt;
	}

	public String getStr_app_rt_itv() {
		return str_app_rt_itv;
	}

	public void setStr_app_rt_itv(String str_app_rt_itv) {
		this.str_app_rt_itv = str_app_rt_itv;
	}

	public String getStr_app_rt_itv_id() {
		return str_app_rt_itv_id;
	}

	public void setStr_app_rt_itv_id(String str_app_rt_itv_id) {
		this.str_app_rt_itv_id = str_app_rt_itv_id;
	}

	public String getStr_app_rt_itv_dt() {
		return str_app_rt_itv_dt;
	}

	public void setStr_app_rt_itv_dt(String str_app_rt_itv_dt) {
		this.str_app_rt_itv_dt = str_app_rt_itv_dt;
	}


	@Override
	public String toString() {
		return "SocietyStuApplyForm [stu_app_seq=" + stu_app_seq + ", user_id=" + user_id + ", gisu_id=" + gisu_id
				+ ", crc_id=" + crc_id + ", stu_app_nm=" + stu_app_nm + ", stu_app_birth=" + stu_app_birth
				+ ", stu_app_gender=" + stu_app_gender + ", stu_app_mt_ck=" + stu_app_mt_ck + ", stu_app_mt_etc="
				+ stu_app_mt_etc + ", stu_app_zipcode=" + stu_app_zipcode + ", stu_app_addr=" + stu_app_addr
				+ ", stu_app_addr_detail=" + stu_app_addr_detail + ", stu_app_phone=" + stu_app_phone
				+ ", stu_app_em_phone=" + stu_app_em_phone + ", stu_app_email=" + stu_app_email
				+ ", stu_app_photo_saved=" + stu_app_photo_saved + ", stu_app_photo_origin=" + stu_app_photo_origin
				+ ", stu_app_photo_file=" + stu_app_photo_file + ", stu_app_edu_file_saved=" + stu_app_edu_file_saved
				+ ", stu_app_edu_file_origin=" + stu_app_edu_file_origin + ", stu_app_edu_file=" + stu_app_edu_file
				+ ", stu_app_isr_file_saved=" + stu_app_isr_file_saved + ", stu_app_isr_file_origin="
				+ stu_app_isr_file_origin + ", stu_app_isr_file=" + stu_app_isr_file + ", stu_app_imm_file_saved="
				+ stu_app_imm_file_saved + ", stu_app_imm_file_origin=" + stu_app_imm_file_origin
				+ ", stu_app_imm_file=" + stu_app_imm_file + ", stu_app_worknet_file_saved="
				+ stu_app_worknet_file_saved + ", stu_app_worknet_file_origin=" + stu_app_worknet_file_origin
				+ ", stu_app_worknet_file=" + stu_app_worknet_file + ", stu_app_ins_id=" + stu_app_ins_id
				+ ", stu_app_ins_dt=" + stu_app_ins_dt + ", stu_app_ins_dt_forupdate=" + stu_app_ins_dt_forupdate
				+ ", stu_app_udt_id=" + stu_app_udt_id + ", stu_app_udt_dt=" + stu_app_udt_dt + ", stu_app_rt_doc="
				+ stu_app_rt_doc + ", str_app_rt_doc_id=" + str_app_rt_doc_id + ", str_app_rt_doc_dt="
				+ str_app_rt_doc_dt + ", str_app_rt_itv=" + str_app_rt_itv + ", str_app_rt_itv_id=" + str_app_rt_itv_id
				+ ", str_app_rt_itv_dt=" + str_app_rt_itv_dt + "]";
	}
}
