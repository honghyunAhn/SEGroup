package global.segroup.society.smp.admin.domain;


/**
 * @Author : 강인석
 * @Date : 2018. 9. 10.
 * @Class 설명 : Society 평가항목 VO
 * 
 */


public class SocietySmpApsTotal {
	
	private int smp_aps_total_seq;			//평가 항목 종합 시퀀스
	
	private int gisu_seq;					//기수정보 시퀀스
	
	private String smp_aps_total_nm;		//평가항목 종합명
	
	private int smp_aps_total_ratio;		//평가항목 종합 비율
	
	private String smp_aps_total_ins_id;	//등록인
	
	private String smp_aps_total_ins_dt;	//등록일자
	
	private String smp_aps_total_udt_id;	//수정인
	
	private String smp_aps_total_udt_dt;	//수정날짜
	
	private String smp_aps_total_ct;

	public SocietySmpApsTotal(){
	}
	
	public SocietySmpApsTotal(int smp_aps_total_seq, int gisu_seq, String smp_aps_total_nm, int smp_aps_total_ratio,
			String smp_aps_total_ins_id, String smp_aps_total_ins_dt, String smp_aps_total_udt_id,
			String smp_aps_total_udt_dt, String smp_aps_total_ct) {
		super();
		this.smp_aps_total_seq = smp_aps_total_seq;
		this.gisu_seq = gisu_seq;
		this.smp_aps_total_nm = smp_aps_total_nm;
		this.smp_aps_total_ratio = smp_aps_total_ratio;
		this.smp_aps_total_ins_id = smp_aps_total_ins_id;
		this.smp_aps_total_ins_dt = smp_aps_total_ins_dt;
		this.smp_aps_total_udt_id = smp_aps_total_udt_id;
		this.smp_aps_total_udt_dt = smp_aps_total_udt_dt;
		this.smp_aps_total_ct = smp_aps_total_ct;
	}

	public int getSmp_aps_total_seq() {
		return smp_aps_total_seq;
	}

	public void setSmp_aps_total_seq(int smp_aps_total_seq) {
		this.smp_aps_total_seq = smp_aps_total_seq;
	}

	public int getGisu_seq() {
		return gisu_seq;
	}

	public void setGisu_seq(int gisu_seq) {
		this.gisu_seq = gisu_seq;
	}

	public String getSmp_aps_total_nm() {
		return smp_aps_total_nm;
	}

	public void setSmp_aps_total_nm(String smp_aps_total_nm) {
		this.smp_aps_total_nm = smp_aps_total_nm;
	}

	public int getSmp_aps_total_ratio() {
		return smp_aps_total_ratio;
	}

	public void setSmp_aps_total_ratio(int smp_aps_total_ratio) {
		this.smp_aps_total_ratio = smp_aps_total_ratio;
	}

	public String getSmp_aps_total_ins_id() {
		return smp_aps_total_ins_id;
	}

	public void setSmp_aps_total_ins_id(String smp_aps_total_ins_id) {
		this.smp_aps_total_ins_id = smp_aps_total_ins_id;
	}

	public String getSmp_aps_total_ins_dt() {
		return smp_aps_total_ins_dt;
	}

	public void setSmp_aps_total_ins_dt(String smp_aps_total_ins_dt) {
		this.smp_aps_total_ins_dt = smp_aps_total_ins_dt;
	}

	public String getSmp_aps_total_udt_id() {
		return smp_aps_total_udt_id;
	}

	public void setSmp_aps_total_udt_id(String smp_aps_total_udt_id) {
		this.smp_aps_total_udt_id = smp_aps_total_udt_id;
	}

	public String getSmp_aps_total_udt_dt() {
		return smp_aps_total_udt_dt;
	}

	public void setSmp_aps_total_udt_dt(String smp_aps_total_udt_dt) {
		this.smp_aps_total_udt_dt = smp_aps_total_udt_dt;
	}

	public String getSmp_aps_total_ct() {
		return smp_aps_total_ct;
	}

	public void setSmp_aps_total_ct(String smp_aps_total_ct) {
		this.smp_aps_total_ct = smp_aps_total_ct;
	}

	@Override
	public String toString() {
		return "SmpApsTotal [smp_aps_total_seq=" + smp_aps_total_seq + ", gisu_seq=" + gisu_seq + ", smp_aps_total_nm="
				+ smp_aps_total_nm + ", smp_aps_total_ratio=" + smp_aps_total_ratio + ", smp_aps_total_ins_id="
				+ smp_aps_total_ins_id + ", smp_aps_total_ins_dt=" + smp_aps_total_ins_dt + ", smp_aps_total_udt_id="
				+ smp_aps_total_udt_id + ", smp_aps_total_udt_dt=" + smp_aps_total_udt_dt + ", smp_aps_total_ct="
				+ smp_aps_total_ct + "]";
	}

	
}
