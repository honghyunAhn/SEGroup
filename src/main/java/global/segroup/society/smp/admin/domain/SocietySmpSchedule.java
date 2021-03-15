package global.segroup.society.smp.admin.domain;

/**
 * @Author : 박찬주, 김진환
 * @Date : 2018. 8. 24.
 * @Class 설명 : Society 학생 일정 정보
 * 
 */

public class SocietySmpSchedule {
	
	/**
	 * 일정 시퀀스
	 */
	private int smp_sch_seq;
	
	/**
	 * 기수정보 시퀀스
	 */
	private int gisu_seq;
	
	/**
	 * 일정색상 시퀀스
	 */
	private int smp_sch_color_seq;
	
	/**
	 * 일정 제목
	 */
	private String smp_sch_ct;
	
	/**
	 * 일정 내용
	 */
	private String smp_sch_cont;
	
	/**
	 * 일정 시작일
	 */
	private String smp_sch_st;
	
	/**
	 * 일정 종료일
	 */
	private String smp_sch_et;
	
	/**
	 * 등록인
	 */
	private String smp_sch_ins_id;
	
	/**
	 * 등록 일자
	 */
	private String smp_sch_ins_dt;
	
	/**
	 * 수정인
	 */
	private String smp_sch_udt_id;
	
	/**
	 * 수정 일자
	 */
	private String smp_sch_udt_dt;
	
	
	public SocietySmpSchedule(){
	}


	public SocietySmpSchedule(int smp_sch_seq, int gisu_seq, int smp_sch_color_seq, String smp_sch_ct,
			String smp_sch_cont, String smp_sch_st, String smp_sch_et, String smp_sch_ins_id, String smp_sch_ins_dt,
			String smp_sch_udt_id, String smp_sch_udt_dt) {
		super();
		this.smp_sch_seq = smp_sch_seq;
		this.gisu_seq = gisu_seq;
		this.smp_sch_color_seq = smp_sch_color_seq;
		this.smp_sch_ct = smp_sch_ct;
		this.smp_sch_cont = smp_sch_cont;
		this.smp_sch_st = smp_sch_st;
		this.smp_sch_et = smp_sch_et;
		this.smp_sch_ins_id = smp_sch_ins_id;
		this.smp_sch_ins_dt = smp_sch_ins_dt;
		this.smp_sch_udt_id = smp_sch_udt_id;
		this.smp_sch_udt_dt = smp_sch_udt_dt;
	}


	public int getSmp_sch_seq() {
		return smp_sch_seq;
	}


	public void setSmp_sch_seq(int smp_sch_seq) {
		this.smp_sch_seq = smp_sch_seq;
	}


	public int getGisu_seq() {
		return gisu_seq;
	}


	public void setGisu_seq(int gisu_seq) {
		this.gisu_seq = gisu_seq;
	}


	public int getSmp_sch_color_seq() {
		return smp_sch_color_seq;
	}


	public void setSmp_sch_color_seq(int smp_sch_color_seq) {
		this.smp_sch_color_seq = smp_sch_color_seq;
	}


	public String getSmp_sch_ct() {
		return smp_sch_ct;
	}


	public void setSmp_sch_ct(String smp_sch_ct) {
		this.smp_sch_ct = smp_sch_ct;
	}


	public String getSmp_sch_cont() {
		return smp_sch_cont;
	}


	public void setSmp_sch_cont(String smp_sch_cont) {
		this.smp_sch_cont = smp_sch_cont;
	}


	public String getSmp_sch_st() {
		return smp_sch_st;
	}


	public void setSmp_sch_st(String smp_sch_st) {
		this.smp_sch_st = smp_sch_st;
	}


	public String getSmp_sch_et() {
		return smp_sch_et;
	}


	public void setSmp_sch_et(String smp_sch_et) {
		this.smp_sch_et = smp_sch_et;
	}


	public String getSmp_sch_ins_id() {
		return smp_sch_ins_id;
	}


	public void setSmp_sch_ins_id(String smp_sch_ins_id) {
		this.smp_sch_ins_id = smp_sch_ins_id;
	}


	public String getSmp_sch_ins_dt() {
		return smp_sch_ins_dt;
	}


	public void setSmp_sch_ins_dt(String smp_sch_ins_dt) {
		this.smp_sch_ins_dt = smp_sch_ins_dt;
	}


	public String getSmp_sch_udt_id() {
		return smp_sch_udt_id;
	}


	public void setSmp_sch_udt_id(String smp_sch_udt_id) {
		this.smp_sch_udt_id = smp_sch_udt_id;
	}


	public String getSmp_sch_udt_dt() {
		return smp_sch_udt_dt;
	}


	public void setSmp_sch_udt_dt(String smp_sch_udt_dt) {
		this.smp_sch_udt_dt = smp_sch_udt_dt;
	}


	@Override
	public String toString() {
		return "SocietySmpSchedule [smp_sch_seq=" + smp_sch_seq + ", gisu_seq=" + gisu_seq + ", smp_sch_color_seq="
				+ smp_sch_color_seq + ", smp_sch_ct=" + smp_sch_ct + ", smp_sch_cont=" + smp_sch_cont + ", smp_sch_st="
				+ smp_sch_st + ", smp_sch_et=" + smp_sch_et + ", smp_sch_ins_id=" + smp_sch_ins_id + ", smp_sch_ins_dt="
				+ smp_sch_ins_dt + ", smp_sch_udt_id=" + smp_sch_udt_id + ", smp_sch_udt_dt=" + smp_sch_udt_dt + "]";
	}


}
