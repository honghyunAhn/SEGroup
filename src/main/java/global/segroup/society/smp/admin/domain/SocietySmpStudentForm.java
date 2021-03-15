package global.segroup.society.smp.admin.domain;



import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 여명환
 * @Date : 2018. 8. 23.
 * @Class 설명 : Society 학생 기본 정보 
 * 
 */
public class SocietySmpStudentForm {
	/**
	 * 지원신청서 시퀀스
	 */
	private int smp_seq;
	
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
	private String smp_mt_ck;
	
	/**
	 * 군병력 사유 
	 */
	private String smp_mt_etc;
	
	/**
	 * 우편번호
	 */
	private String smp_zipcode;
	
	/**
	 * 현 주소
	 */
	private String smp_address;
	
	/**
	 * 상세주소
	 */
	private String smp_address_detail;
	
	/**
	 * 비상 연락처
	 */
	private String smp_em_phone;
	
	/**
	 * 본 과정 응시여부 체크(공통 코드)
	 */
	private String smp_take_ck;
	
	/**
	 * 본 과정 응시여부 지원년월(yyyyMM)
	 */
	private String smp_take_dt;
	
	/**
	 * 본 과정 응시여부 선발전형 결과
	 */
	private String smp_take_rt;
	
	/**
	 * 해외체류 경험 체크(공통 코드)
	 */
	private String smp_abroad_ck;
	
	/**
	 * K-MOVE 스쿨 참여여부 체크(공통 코드)
	 */
	private String smp_kmove_ck;
	
	/**
	 * K-MOVE 스쿨 참여여부 과정명
	 */
	private String smp_kmove_nm;
	
	/**
	 * K-MOVE 스쿨 참여여부 운영기관
	 */
	private String smp_kmove_ag;
	
	/**
	 * K-MOVE 스쿨 참여여부 수강기간 시작일(yyyyMMdd)
	 */
	private String smp_kmove_st;
	
	/**
	 * K-MOVE 스쿨 참여여부 수강기간 종료일(yyyyMMdd)
	 */
	private String smp_kmove_et;
	
	/**
	 * 자기 소개 
	 */
	private String smp_self_intro;
	
	/**
	 * 사진 저장 파일명
	 */
	private String smp_photo_saved;
	
	/**
	 * 사진 원본 파일명
	 */
	private String smp_photo_origin;
	
	/**
	 * 사진 파일
	 */
	private CommonsMultipartFile smp_photo_file;
	
	/**
	 * 최종 학력증명서 저장 파일명
	 */
	private String smp_edu_file_saved;
	
	/**
	 * 최종 학력증명서 원본 파일명
	 */
	private String smp_edu_file_origin;
	
	/**
	 * 최종 학력증명서 파일
	 */
	private CommonsMultipartFile smp_edu_file;
	
	/**
	 * 고용보험 상실확인 저장 파일명
	 */
	private String smp_isr_file_saved;
	
	/**
	 * 고용보험 상실확인 원본 파일명
	 */
	private String smp_isr_file_origin;
	
	/**
	 * 고용보험 상실확인 파일
	 */
	private CommonsMultipartFile smp_isr_file;
	
	/**
	 * 출입국 사실증명서 저장 파일명
	 */
	private String smp_imm_file_saved;
	
	/**
	 * 출입국 사실증명서 원본 파일명
	 */
	private String smp_imm_file_origin;
	
	/**
	 * 출입국 사실증명서 파일
	 */
	private CommonsMultipartFile smp_imm_file;
	
	/**
	 * 기숙사 희망 여부
	 */
	private String smp_domitory_ck;
	
	/**
	 * 등록인
	 */
	private String smp_ins_id;
	
	/**
	 * 등록일자(yyyyMMdd24hhmiss) 
	 */
	private String smp_ins_dt;
	
	/**
	 * 수정인 
	 */
	private String smp_udt_id;
	
	/**
	 * 수정일자(yyyyMMdd24hhmiss)
	 */
	private String smp_udt_dt;
	
	/**
	 * K-MOVE 대상자 구분
	 */
	private String smp_kmove_gb;
	
	/**
	 * 재학생 반 정보
	 */
	private String smp_class_info;
	
	/**
	 * 재학생 지원 지역 구분
	 */
	private String smp_app_lo_gb;
	
	/**
	 * 재학생 CUP과정 대상자 구분
	 */
	private String smp_cup_gb;
	
	/**
	 * 거주지
	 */
	private String smp_residence;
	
	/**
	 * 이전 기수 지원 여부
	 */
	private String smp_applied_ck;
	
	public SocietySmpStudentForm() {
		super();
	}

	public SocietySmpStudentForm(int smp_seq, String app_id, int gisu_seq, String smp_mt_ck, String smp_mt_etc,
			String smp_zipcode, String smp_address, String smp_address_detail, String smp_em_phone, String smp_take_ck,
			String smp_take_dt, String smp_take_rt, String smp_abroad_ck, String smp_kmove_ck, String smp_kmove_nm,
			String smp_kmove_ag, String smp_kmove_st, String smp_kmove_et, String smp_self_intro,
			String smp_photo_saved, String smp_photo_origin, CommonsMultipartFile smp_photo_file,
			String smp_edu_file_saved, String smp_edu_file_origin, CommonsMultipartFile smp_edu_file,
			String smp_isr_file_saved, String smp_isr_file_origin, CommonsMultipartFile smp_isr_file,
			String smp_imm_file_saved, String smp_imm_file_origin, CommonsMultipartFile smp_imm_file, String smp_domitory_ck, 
			String smp_kmove_gb, String smp_class_info, String smp_app_lo_gb, String smp_cup_gb, String smp_residence, String smp_applied_ck, 
			String smp_ins_id, String smp_ins_dt, String smp_udt_id, String smp_udt_dt) {
		super();
		this.smp_seq = smp_seq;
		this.app_id = app_id;
		this.gisu_seq = gisu_seq;
		this.smp_mt_ck = smp_mt_ck;
		this.smp_mt_etc = smp_mt_etc;
		this.smp_zipcode = smp_zipcode;
		this.smp_address = smp_address;
		this.smp_address_detail = smp_address_detail;
		this.smp_em_phone = smp_em_phone;
		this.smp_take_ck = smp_take_ck;
		this.smp_take_dt = smp_take_dt;
		this.smp_take_rt = smp_take_rt;
		this.smp_abroad_ck = smp_abroad_ck;
		this.smp_kmove_ck = smp_kmove_ck;
		this.smp_kmove_nm = smp_kmove_nm;
		this.smp_kmove_ag = smp_kmove_ag;
		this.smp_kmove_st = smp_kmove_st;
		this.smp_kmove_et = smp_kmove_et;
		this.smp_self_intro = smp_self_intro;
		this.smp_photo_saved = smp_photo_saved;
		this.smp_photo_origin = smp_photo_origin;
		this.smp_photo_file = smp_photo_file;
		this.smp_edu_file_saved = smp_edu_file_saved;
		this.smp_edu_file_origin = smp_edu_file_origin;
		this.smp_edu_file = smp_edu_file;
		this.smp_isr_file_saved = smp_isr_file_saved;
		this.smp_isr_file_origin = smp_isr_file_origin;
		this.smp_isr_file = smp_isr_file;
		this.smp_imm_file_saved = smp_imm_file_saved;
		this.smp_imm_file_origin = smp_imm_file_origin;
		this.smp_imm_file = smp_imm_file;
		this.smp_domitory_ck = smp_domitory_ck;
		this.smp_ins_id = smp_ins_id;
		this.smp_ins_dt = smp_ins_dt;
		this.smp_udt_id = smp_udt_id;
		this.smp_udt_dt = smp_udt_dt;
		this.smp_kmove_gb = smp_kmove_gb;
		this.smp_class_info = smp_class_info;
		this.smp_app_lo_gb = smp_app_lo_gb;
		this.smp_cup_gb = smp_cup_gb;
		this.smp_residence = smp_residence;
		this.smp_applied_ck = smp_applied_ck;
	}

	public int getSmp_seq() {
		return smp_seq;
	}

	public void setSmp_seq(int smp_seq) {
		this.smp_seq = smp_seq;
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

	public String getSmp_mt_ck() {
		return smp_mt_ck;
	}

	public void setSmp_mt_ck(String smp_mt_ck) {
		this.smp_mt_ck = smp_mt_ck;
	}

	public String getSmp_mt_etc() {
		return smp_mt_etc;
	}

	public void setSmp_mt_etc(String smp_mt_etc) {
		this.smp_mt_etc = smp_mt_etc;
	}

	public String getSmp_zipcode() {
		return smp_zipcode;
	}

	public void setSmp_zipcode(String smp_zipcode) {
		this.smp_zipcode = smp_zipcode;
	}

	public String getSmp_address() {
		return smp_address;
	}

	public void setSmp_address(String smp_address) {
		this.smp_address = smp_address;
	}

	public String getSmp_address_detail() {
		return smp_address_detail;
	}

	public void setSmp_address_detail(String smp_address_detail) {
		this.smp_address_detail = smp_address_detail;
	}

	public String getSmp_em_phone() {
		return smp_em_phone;
	}

	public void setSmp_em_phone(String smp_em_phone) {
		this.smp_em_phone = smp_em_phone;
	}

	public String getSmp_take_ck() {
		return smp_take_ck;
	}

	public void setSmp_take_ck(String smp_take_ck) {
		this.smp_take_ck = smp_take_ck;
	}

	public String getSmp_take_dt() {
		return smp_take_dt;
	}

	public void setSmp_take_dt(String smp_take_dt) {
		this.smp_take_dt = smp_take_dt;
	}

	public String getSmp_take_rt() {
		return smp_take_rt;
	}

	public void setSmp_take_rt(String smp_take_rt) {
		this.smp_take_rt = smp_take_rt;
	}

	public String getSmp_abroad_ck() {
		return smp_abroad_ck;
	}

	public void setSmp_abroad_ck(String smp_abroad_ck) {
		this.smp_abroad_ck = smp_abroad_ck;
	}

	public String getSmp_kmove_ck() {
		return smp_kmove_ck;
	}

	public void setSmp_kmove_ck(String smp_kmove_ck) {
		this.smp_kmove_ck = smp_kmove_ck;
	}

	public String getSmp_kmove_nm() {
		return smp_kmove_nm;
	}

	public void setSmp_kmove_nm(String smp_kmove_nm) {
		this.smp_kmove_nm = smp_kmove_nm;
	}

	public String getSmp_kmove_ag() {
		return smp_kmove_ag;
	}

	public void setSmp_kmove_ag(String smp_kmove_ag) {
		this.smp_kmove_ag = smp_kmove_ag;
	}

	public String getSmp_kmove_st() {
		return smp_kmove_st;
	}

	public void setSmp_kmove_st(String smp_kmove_st) {
		this.smp_kmove_st = smp_kmove_st;
	}

	public String getSmp_kmove_et() {
		return smp_kmove_et;
	}

	public void setSmp_kmove_et(String smp_kmove_et) {
		this.smp_kmove_et = smp_kmove_et;
	}

	public String getSmp_self_intro() {
		return smp_self_intro;
	}

	public void setSmp_self_intro(String smp_self_intro) {
		this.smp_self_intro = smp_self_intro;
	}

	public String getSmp_photo_saved() {
		return smp_photo_saved;
	}

	public void setSmp_photo_saved(String smp_photo_saved) {
		this.smp_photo_saved = smp_photo_saved;
	}

	public String getSmp_photo_origin() {
		return smp_photo_origin;
	}

	public void setSmp_photo_origin(String smp_photo_origin) {
		this.smp_photo_origin = smp_photo_origin;
	}

	public CommonsMultipartFile getSmp_photo_file() {
		return smp_photo_file;
	}

	public void setSmp_photo_file(CommonsMultipartFile smp_photo_file) {
		this.smp_photo_file = smp_photo_file;
	}

	public String getSmp_edu_file_saved() {
		return smp_edu_file_saved;
	}

	public void setSmp_edu_file_saved(String smp_edu_file_saved) {
		this.smp_edu_file_saved = smp_edu_file_saved;
	}

	public String getSmp_edu_file_origin() {
		return smp_edu_file_origin;
	}

	public void setSmp_edu_file_origin(String smp_edu_file_origin) {
		this.smp_edu_file_origin = smp_edu_file_origin;
	}

	public CommonsMultipartFile getSmp_edu_file() {
		return smp_edu_file;
	}

	public void setSmp_edu_file(CommonsMultipartFile smp_edu_file) {
		this.smp_edu_file = smp_edu_file;
	}

	public String getSmp_isr_file_saved() {
		return smp_isr_file_saved;
	}

	public void setSmp_isr_file_saved(String smp_isr_file_saved) {
		this.smp_isr_file_saved = smp_isr_file_saved;
	}

	public String getSmp_isr_file_origin() {
		return smp_isr_file_origin;
	}

	public void setSmp_isr_file_origin(String smp_isr_file_origin) {
		this.smp_isr_file_origin = smp_isr_file_origin;
	}

	public CommonsMultipartFile getSmp_isr_file() {
		return smp_isr_file;
	}

	public void setSmp_isr_file(CommonsMultipartFile smp_isr_file) {
		this.smp_isr_file = smp_isr_file;
	}

	public String getSmp_imm_file_saved() {
		return smp_imm_file_saved;
	}

	public void setSmp_imm_file_saved(String smp_imm_file_saved) {
		this.smp_imm_file_saved = smp_imm_file_saved;
	}

	public String getSmp_imm_file_origin() {
		return smp_imm_file_origin;
	}

	public void setSmp_imm_file_origin(String smp_imm_file_origin) {
		this.smp_imm_file_origin = smp_imm_file_origin;
	}

	public CommonsMultipartFile getSmp_imm_file() {
		return smp_imm_file;
	}

	public void setSmp_imm_file(CommonsMultipartFile smp_imm_file) {
		this.smp_imm_file = smp_imm_file;
	}
	
	public String getSmp_domitory_ck() {
		return smp_domitory_ck;
	}

	public void setSmp_domitory_ck(String smp_domitory_ck) {
		this.smp_domitory_ck = smp_domitory_ck;
	}

	public String getSmp_ins_id() {
		return smp_ins_id;
	}

	public void setSmp_ins_id(String smp_ins_id) {
		this.smp_ins_id = smp_ins_id;
	}

	public String getSmp_ins_dt() {
		return smp_ins_dt;
	}

	public void setSmp_ins_dt(String smp_ins_dt) {
		this.smp_ins_dt = smp_ins_dt;
	}

	public String getSmp_udt_id() {
		return smp_udt_id;
	}

	public void setSmp_udt_id(String smp_udt_id) {
		this.smp_udt_id = smp_udt_id;
	}

	public String getSmp_udt_dt() {
		return smp_udt_dt;
	}

	public void setSmp_udt_dt(String smp_udt_dt) {
		this.smp_udt_dt = smp_udt_dt;
	}

	public String getSmp_kmove_gb() {
		return smp_kmove_gb;
	}

	public void setSmp_kmove_gb(String smp_kmove_gb) {
		this.smp_kmove_gb = smp_kmove_gb;
	}

	public String getSmp_class_info() {
		return smp_class_info;
	}

	public void setSmp_class_info(String smp_class_info) {
		this.smp_class_info = smp_class_info;
	}

	public String getSmp_app_lo_gb() {
		return smp_app_lo_gb;
	}

	public void setSmp_app_lo_gb(String smp_app_lo_gb) {
		this.smp_app_lo_gb = smp_app_lo_gb;
	}

	public String getSmp_cup_gb() {
		return smp_cup_gb;
	}

	public void setSmp_cup_gb(String smp_cup_gb) {
		this.smp_cup_gb = smp_cup_gb;
	}

	public String getSmp_residence() {
		return smp_residence;
	}

	public void setSmp_residence(String smp_residence) {
		this.smp_residence = smp_residence;
	}

	public String getSmp_applied_ck() {
		return smp_applied_ck;
	}

	public void setSmp_applied_ck(String smp_applied_ck) {
		this.smp_applied_ck = smp_applied_ck;
	}

	@Override
	public String toString() {
		return "SocietySmpStudentForm [smp_seq=" + smp_seq + ", app_id=" + app_id + ", gisu_seq=" + gisu_seq
				+ ", smp_mt_ck=" + smp_mt_ck + ", smp_mt_etc=" + smp_mt_etc + ", smp_zipcode=" + smp_zipcode
				+ ", smp_address=" + smp_address + ", smp_address_detail=" + smp_address_detail + ", smp_em_phone="
				+ smp_em_phone + ", smp_take_ck=" + smp_take_ck + ", smp_take_dt=" + smp_take_dt + ", smp_take_rt="
				+ smp_take_rt + ", smp_abroad_ck=" + smp_abroad_ck + ", smp_kmove_ck=" + smp_kmove_ck
				+ ", smp_kmove_nm=" + smp_kmove_nm + ", smp_kmove_ag=" + smp_kmove_ag + ", smp_kmove_st=" + smp_kmove_st
				+ ", smp_kmove_et=" + smp_kmove_et + ", smp_self_intro=" + smp_self_intro + ", smp_photo_saved="
				+ smp_photo_saved + ", smp_photo_origin=" + smp_photo_origin + ", smp_photo_file=" + smp_photo_file
				+ ", smp_edu_file_saved=" + smp_edu_file_saved + ", smp_edu_file_origin=" + smp_edu_file_origin
				+ ", smp_edu_file=" + smp_edu_file + ", smp_isr_file_saved=" + smp_isr_file_saved
				+ ", smp_isr_file_origin=" + smp_isr_file_origin + ", smp_isr_file=" + smp_isr_file
				+ ", smp_imm_file_saved=" + smp_imm_file_saved + ", smp_imm_file_origin=" + smp_imm_file_origin
				+ ", smp_imm_file=" + smp_imm_file + ", smp_domitory_ck=" + smp_domitory_ck + ", smp_ins_id="
				+ smp_ins_id + ", smp_ins_dt=" + smp_ins_dt + ", smp_udt_id=" + smp_udt_id + ", smp_udt_dt="
				+ smp_udt_dt + ", smp_kmove_gb=" + smp_kmove_gb + ", smp_class_info=" + smp_class_info
				+ ", smp_app_lo_gb=" + smp_app_lo_gb + ", smp_cup_gb=" + smp_cup_gb + ", smp_residence=" + smp_residence
				+ ", smp_applied_ck=" + smp_applied_ck + "]";
	}

	

}
