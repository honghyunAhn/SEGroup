/**
 * 
 */
package global.segroup.society.edu.apply.domain;

import java.util.Date;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 26.
 * @Class 설명 : Society 모집홍보 지원신청서 기본 정보 
 * 
 */
public class SocietyEduApplyForm {
	/**
	 * 지원신청서 시퀀스
	 */
	private int app_seq;
	
	/**
	 * 회원 아이디
	 */
	private String app_id;

	/**
	 * 기수정보 시퀀스
	 */
	private int gisu_seq;
	
	/**
	 * 군병력 체크(공통코드)
	 */
	private String app_mt_ck;
	
	/**
	 * 군병력 사유 
	 */
	private String app_mt_etc;
	
	/**
	 * 우편번호
	 */
	private String app_zipcode;
	
	/**
	 * 현 주소
	 */
	private String app_address;
	
	/**
	 * 상세주소
	 */
	private String app_address_detail;
	
	/**
	 * 비상 연락처
	 */
	private String app_em_phone;
	
	/**
	 * 본 과정 응시여부 체크(공통 코드)
	 */
	private String app_take_ck;
	
	/**
	 * 본 과정 응시여부 지원년월(yyyyMM)
	 */
	private String app_take_dt;
	
	/**
	 * 본 과정 응시여부 선발전형 결과
	 */
	private String app_take_rt;
	
	/**
	 * 해외체류 경험 체크(공통 코드)
	 */
	private String app_abroad_ck;
	
	/**
	 * K-MOVE 스쿨 참여여부 체크(공통 코드)
	 */
	private String app_kmove_ck;
	
	/**
	 * K-MOVE 스쿨 참여여부 과정명
	 */
	private String app_kmove_nm;
	
	/**
	 * K-MOVE 스쿨 참여여부 운영기관
	 */
	private String app_kmove_ag;
	
	/**
	 * K-MOVE 스쿨 참여여부 수강기간 시작일(yyyyMMdd)
	 */
	private String app_kmove_st;
	
	/**
	 * K-MOVE 스쿨 참여여부 수강기간 종료일(yyyyMMdd)
	 */
	private String app_kmove_et;
	
	/**
	 * 자기 소개 
	 */
	private String app_self_intro;
	
	/**
	 * 사진 저장 파일명
	 */
	private String app_photo_saved;
	
	/**
	 * 사진 원본 파일명
	 */
	private String app_photo_origin;
	
	/**
	 * 사진 파일
	 */
	private CommonsMultipartFile app_photo_file;
	
	/**
	 * 최종 학력증명서 저장 파일명
	 */
	private String app_edu_file_saved;
	
	/**
	 * 최종 학력증명서 원본 파일명
	 */
	private String app_edu_file_origin;
	
	/**
	 * 최종 학력증명서 파일
	 */
	private CommonsMultipartFile app_edu_file;
	
	/**
	 * 고용보험 상실확인 저장 파일명
	 */
	private String app_isr_file_saved;
	
	/**
	 * 고용보험 상실확인 원본 파일명
	 */
	private String app_isr_file_origin;
	
	/**
	 * 고용보험 상실확인 파일
	 */
	private CommonsMultipartFile app_isr_file;
	
	/**
	 * 출입국 사실증명서 저장 파일명
	 */
	private String app_imm_file_saved;
	
	/**
	 * 출입국 사실증명서 원본 파일명
	 */
	private String app_imm_file_origin;
	
	/**
	 * 출입국 사실증명서 파일
	 */
	private CommonsMultipartFile app_imm_file;
	
	/**
	 * 워크넷 직무평가 결과 저장 파일명
	 */
	private String app_worknet_file_saved;
	
	/**
	 * 워크넷 직무평가 결과 원본 파일명
	 */
	private String app_worknet_file_origin;
	
	/**
	 * 워크넷 직무평가 결과 파일
	 */
	private CommonsMultipartFile app_worknet_file;
	
	/**
	 * 기숙사 희망 여부
	 */
	private String app_domitory_ck;
	
	/**
	 * 등록인
	 */
	private String app_ins_id;
	
	/**
	 * 등록일자(yyyyMMdd24hhmiss) 
	 */
	private String app_ins_dt;
	
	/**
	 * 등록일자(update용 DateType) 
	 */
	private Date app_ins_dt_forupdate;
	
	/**
	 * 수정인 
	 */
	private String app_udt_id;
	
	/**
	 * 수정일자(yyyyMMdd24hhmiss)
	 */
	private String app_udt_dt;
	
	public SocietyEduApplyForm() {
		super();
	}

	public SocietyEduApplyForm(int app_seq, String app_id, int gisu_seq, String app_mt_ck, String app_mt_etc,
			String app_zipcode, String app_address, String app_address_detail, String app_em_phone, String app_take_ck,
			String app_take_dt, String app_take_rt, String app_abroad_ck, String app_kmove_ck, String app_kmove_nm,
			String app_kmove_ag, String app_kmove_st, String app_kmove_et, String app_self_intro,
			String app_photo_saved, String app_photo_origin, CommonsMultipartFile app_photo_file,
			String app_edu_file_saved, String app_edu_file_origin, CommonsMultipartFile app_edu_file,
			String app_isr_file_saved, String app_isr_file_origin, CommonsMultipartFile app_isr_file,
			String app_imm_file_saved, String app_imm_file_origin, CommonsMultipartFile app_imm_file,
			String app_worknet_file_saved, String app_worknet_file_origin, CommonsMultipartFile app_worknet_file,
			String app_domitory_ck, String app_ins_id, String app_ins_dt, Date app_ins_dt_forupdate, String app_udt_id,
			String app_udt_dt) {
		super();
		this.app_seq = app_seq;
		this.app_id = app_id;
		this.gisu_seq = gisu_seq;
		this.app_mt_ck = app_mt_ck;
		this.app_mt_etc = app_mt_etc;
		this.app_zipcode = app_zipcode;
		this.app_address = app_address;
		this.app_address_detail = app_address_detail;
		this.app_em_phone = app_em_phone;
		this.app_take_ck = app_take_ck;
		this.app_take_dt = app_take_dt;
		this.app_take_rt = app_take_rt;
		this.app_abroad_ck = app_abroad_ck;
		this.app_kmove_ck = app_kmove_ck;
		this.app_kmove_nm = app_kmove_nm;
		this.app_kmove_ag = app_kmove_ag;
		this.app_kmove_st = app_kmove_st;
		this.app_kmove_et = app_kmove_et;
		this.app_self_intro = app_self_intro;
		this.app_photo_saved = app_photo_saved;
		this.app_photo_origin = app_photo_origin;
		this.app_photo_file = app_photo_file;
		this.app_edu_file_saved = app_edu_file_saved;
		this.app_edu_file_origin = app_edu_file_origin;
		this.app_edu_file = app_edu_file;
		this.app_isr_file_saved = app_isr_file_saved;
		this.app_isr_file_origin = app_isr_file_origin;
		this.app_isr_file = app_isr_file;
		this.app_imm_file_saved = app_imm_file_saved;
		this.app_imm_file_origin = app_imm_file_origin;
		this.app_imm_file = app_imm_file;
		this.app_worknet_file_saved = app_worknet_file_saved;
		this.app_worknet_file_origin = app_worknet_file_origin;
		this.app_worknet_file = app_worknet_file;
		this.app_domitory_ck = app_domitory_ck;
		this.app_ins_id = app_ins_id;
		this.app_ins_dt = app_ins_dt;
		this.app_ins_dt_forupdate = app_ins_dt_forupdate;
		this.app_udt_id = app_udt_id;
		this.app_udt_dt = app_udt_dt;
	}

	public int getApp_seq() {
		return app_seq;
	}

	public void setApp_seq(int app_seq) {
		this.app_seq = app_seq;
	}

	public String getApp_id() {
		return app_id;
	}

	public void setApp_id(String app_id) {
		this.app_id = app_id;
	}

	public int getGisu_seq() {
		return gisu_seq;
	}

	public void setGisu_seq(int gisu_seq) {
		this.gisu_seq = gisu_seq;
	}

	public String getApp_mt_ck() {
		return app_mt_ck;
	}

	public void setApp_mt_ck(String app_mt_ck) {
		this.app_mt_ck = app_mt_ck;
	}

	public String getApp_mt_etc() {
		return app_mt_etc;
	}

	public void setApp_mt_etc(String app_mt_etc) {
		this.app_mt_etc = app_mt_etc;
	}

	public String getApp_zipcode() {
		return app_zipcode;
	}

	public void setApp_zipcode(String app_zipcode) {
		this.app_zipcode = app_zipcode;
	}

	public String getApp_address() {
		return app_address;
	}

	public void setApp_address(String app_address) {
		this.app_address = app_address;
	}

	public String getApp_address_detail() {
		return app_address_detail;
	}

	public void setApp_address_detail(String app_address_detail) {
		this.app_address_detail = app_address_detail;
	}

	public String getApp_em_phone() {
		return app_em_phone;
	}

	public void setApp_em_phone(String app_em_phone) {
		this.app_em_phone = app_em_phone;
	}

	public String getApp_take_ck() {
		return app_take_ck;
	}

	public void setApp_take_ck(String app_take_ck) {
		this.app_take_ck = app_take_ck;
	}

	public String getApp_take_dt() {
		return app_take_dt;
	}

	public void setApp_take_dt(String app_take_dt) {
		this.app_take_dt = app_take_dt;
	}

	public String getApp_take_rt() {
		return app_take_rt;
	}

	public void setApp_take_rt(String app_take_rt) {
		this.app_take_rt = app_take_rt;
	}

	public String getApp_abroad_ck() {
		return app_abroad_ck;
	}

	public void setApp_abroad_ck(String app_abroad_ck) {
		this.app_abroad_ck = app_abroad_ck;
	}

	public String getApp_kmove_ck() {
		return app_kmove_ck;
	}

	public void setApp_kmove_ck(String app_kmove_ck) {
		this.app_kmove_ck = app_kmove_ck;
	}

	public String getApp_kmove_nm() {
		return app_kmove_nm;
	}

	public void setApp_kmove_nm(String app_kmove_nm) {
		this.app_kmove_nm = app_kmove_nm;
	}

	public String getApp_kmove_ag() {
		return app_kmove_ag;
	}

	public void setApp_kmove_ag(String app_kmove_ag) {
		this.app_kmove_ag = app_kmove_ag;
	}

	public String getApp_kmove_st() {
		return app_kmove_st;
	}

	public void setApp_kmove_st(String app_kmove_st) {
		this.app_kmove_st = app_kmove_st;
	}

	public String getApp_kmove_et() {
		return app_kmove_et;
	}

	public void setApp_kmove_et(String app_kmove_et) {
		this.app_kmove_et = app_kmove_et;
	}

	public String getApp_self_intro() {
		return app_self_intro;
	}

	public void setApp_self_intro(String app_self_intro) {
		this.app_self_intro = app_self_intro;
	}

	public String getApp_photo_saved() {
		return app_photo_saved;
	}

	public void setApp_photo_saved(String app_photo_saved) {
		this.app_photo_saved = app_photo_saved;
	}

	public String getApp_photo_origin() {
		return app_photo_origin;
	}

	public void setApp_photo_origin(String app_photo_origin) {
		this.app_photo_origin = app_photo_origin;
	}

	public CommonsMultipartFile getApp_photo_file() {
		return app_photo_file;
	}

	public void setApp_photo_file(CommonsMultipartFile app_photo_file) {
		this.app_photo_file = app_photo_file;
	}

	public String getApp_edu_file_saved() {
		return app_edu_file_saved;
	}

	public void setApp_edu_file_saved(String app_edu_file_saved) {
		this.app_edu_file_saved = app_edu_file_saved;
	}

	public String getApp_edu_file_origin() {
		return app_edu_file_origin;
	}

	public void setApp_edu_file_origin(String app_edu_file_origin) {
		this.app_edu_file_origin = app_edu_file_origin;
	}

	public CommonsMultipartFile getApp_edu_file() {
		return app_edu_file;
	}

	public void setApp_edu_file(CommonsMultipartFile app_edu_file) {
		this.app_edu_file = app_edu_file;
	}

	public String getApp_isr_file_saved() {
		return app_isr_file_saved;
	}

	public void setApp_isr_file_saved(String app_isr_file_saved) {
		this.app_isr_file_saved = app_isr_file_saved;
	}

	public String getApp_isr_file_origin() {
		return app_isr_file_origin;
	}

	public void setApp_isr_file_origin(String app_isr_file_origin) {
		this.app_isr_file_origin = app_isr_file_origin;
	}

	public CommonsMultipartFile getApp_isr_file() {
		return app_isr_file;
	}

	public void setApp_isr_file(CommonsMultipartFile app_isr_file) {
		this.app_isr_file = app_isr_file;
	}

	public String getApp_imm_file_saved() {
		return app_imm_file_saved;
	}

	public void setApp_imm_file_saved(String app_imm_file_saved) {
		this.app_imm_file_saved = app_imm_file_saved;
	}

	public String getApp_imm_file_origin() {
		return app_imm_file_origin;
	}

	public void setApp_imm_file_origin(String app_imm_file_origin) {
		this.app_imm_file_origin = app_imm_file_origin;
	}

	public CommonsMultipartFile getApp_imm_file() {
		return app_imm_file;
	}

	public void setApp_imm_file(CommonsMultipartFile app_imm_file) {
		this.app_imm_file = app_imm_file;
	}

	public String getApp_worknet_file_saved() {
		return app_worknet_file_saved;
	}

	public void setApp_worknet_file_saved(String app_worknet_file_saved) {
		this.app_worknet_file_saved = app_worknet_file_saved;
	}

	public String getApp_worknet_file_origin() {
		return app_worknet_file_origin;
	}

	public void setApp_worknet_file_origin(String app_worknet_file_origin) {
		this.app_worknet_file_origin = app_worknet_file_origin;
	}

	public CommonsMultipartFile getApp_worknet_file() {
		return app_worknet_file;
	}

	public void setApp_worknet_file(CommonsMultipartFile app_worknet_file) {
		this.app_worknet_file = app_worknet_file;
	}

	public String getApp_domitory_ck() {
		return app_domitory_ck;
	}

	public void setApp_domitory_ck(String app_domitory_ck) {
		this.app_domitory_ck = app_domitory_ck;
	}

	public String getApp_ins_id() {
		return app_ins_id;
	}

	public void setApp_ins_id(String app_ins_id) {
		this.app_ins_id = app_ins_id;
	}

	public String getApp_ins_dt() {
		return app_ins_dt;
	}

	public void setApp_ins_dt(String app_ins_dt) {
		this.app_ins_dt = app_ins_dt;
	}

	public Date getApp_ins_dt_forupdate() {
		return app_ins_dt_forupdate;
	}

	public void setApp_ins_dt_forupdate(Date app_ins_dt_forupdate) {
		this.app_ins_dt_forupdate = app_ins_dt_forupdate;
	}

	public String getApp_udt_id() {
		return app_udt_id;
	}

	public void setApp_udt_id(String app_udt_id) {
		this.app_udt_id = app_udt_id;
	}

	public String getApp_udt_dt() {
		return app_udt_dt;
	}

	public void setApp_udt_dt(String app_udt_dt) {
		this.app_udt_dt = app_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyEduApplyForm [app_seq=" + app_seq + ", app_id=" + app_id + ", gisu_seq=" + gisu_seq
				+ ", app_mt_ck=" + app_mt_ck + ", app_mt_etc=" + app_mt_etc + ", app_zipcode=" + app_zipcode
				+ ", app_address=" + app_address + ", app_address_detail=" + app_address_detail + ", app_em_phone="
				+ app_em_phone + ", app_take_ck=" + app_take_ck + ", app_take_dt=" + app_take_dt + ", app_take_rt="
				+ app_take_rt + ", app_abroad_ck=" + app_abroad_ck + ", app_kmove_ck=" + app_kmove_ck
				+ ", app_kmove_nm=" + app_kmove_nm + ", app_kmove_ag=" + app_kmove_ag + ", app_kmove_st=" + app_kmove_st
				+ ", app_kmove_et=" + app_kmove_et + ", app_self_intro=" + app_self_intro + ", app_photo_saved="
				+ app_photo_saved + ", app_photo_origin=" + app_photo_origin + ", app_photo_file=" + app_photo_file
				+ ", app_edu_file_saved=" + app_edu_file_saved + ", app_edu_file_origin=" + app_edu_file_origin
				+ ", app_edu_file=" + app_edu_file + ", app_isr_file_saved=" + app_isr_file_saved
				+ ", app_isr_file_origin=" + app_isr_file_origin + ", app_isr_file=" + app_isr_file
				+ ", app_imm_file_saved=" + app_imm_file_saved + ", app_imm_file_origin=" + app_imm_file_origin
				+ ", app_imm_file=" + app_imm_file + ", app_worknet_file_saved=" + app_worknet_file_saved
				+ ", app_worknet_file_origin=" + app_worknet_file_origin + ", app_worknet_file=" + app_worknet_file
				+ ", app_domitory_ck=" + app_domitory_ck + ", app_ins_id=" + app_ins_id + ", app_ins_dt=" + app_ins_dt
				+ ", app_ins_dt_forupdate=" + app_ins_dt_forupdate + ", app_udt_id=" + app_udt_id + ", app_udt_dt="
				+ app_udt_dt + "]";
	}

}
