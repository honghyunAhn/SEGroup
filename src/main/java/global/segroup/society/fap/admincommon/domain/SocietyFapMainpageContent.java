/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

/**
 * @Author : 이종호
 * @Date : 2019. 9. 3.
 * @Class 설명 : 지원자 메인페이지 기업 컨텐츠 관리 정보
 * 
 */
public class SocietyFapMainpageContent {
	private int fap_mainpage_ct_seq;
	private int fap_jobfair_divide_seq;
	private int fap_jobfair_seq;
	private String fap_mainpage_ct_top_ko;
	private String fap_mainpage_ct_top_ja;
	private String fap_mainpage_ct_quarter_ko;
	private String fap_mainpage_ct_quarter_ja;
	private String fap_mainpage_ct_imp_code;
	private String fap_mainpage_ct_ins_id;
	private String fap_mainpage_ct_ins_dt;
	private String fap_mainpage_ct_udt_id;
	private String fap_mainpage_ct_udt_dt;
	
	public SocietyFapMainpageContent() {
		super();
	}

	public SocietyFapMainpageContent(int fap_mainpage_ct_seq, int fap_jobfair_divide_seq, int fap_jobfair_seq,
			String fap_mainpage_ct_top_ko, String fap_mainpage_ct_top_ja, String fap_mainpage_ct_quarter_ko,
			String fap_mainpage_ct_quarter_ja, String fap_mainpage_ct_imp_code, String fap_mainpage_ct_ins_id,
			String fap_mainpage_ct_ins_dt, String fap_mainpage_ct_udt_id, String fap_mainpage_ct_udt_dt) {
		super();
		this.fap_mainpage_ct_seq = fap_mainpage_ct_seq;
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
		this.fap_jobfair_seq = fap_jobfair_seq;
		this.fap_mainpage_ct_top_ko = fap_mainpage_ct_top_ko;
		this.fap_mainpage_ct_top_ja = fap_mainpage_ct_top_ja;
		this.fap_mainpage_ct_quarter_ko = fap_mainpage_ct_quarter_ko;
		this.fap_mainpage_ct_quarter_ja = fap_mainpage_ct_quarter_ja;
		this.fap_mainpage_ct_imp_code = fap_mainpage_ct_imp_code;
		this.fap_mainpage_ct_ins_id = fap_mainpage_ct_ins_id;
		this.fap_mainpage_ct_ins_dt = fap_mainpage_ct_ins_dt;
		this.fap_mainpage_ct_udt_id = fap_mainpage_ct_udt_id;
		this.fap_mainpage_ct_udt_dt = fap_mainpage_ct_udt_dt;
	}

	public int getFap_mainpage_ct_seq() {
		return fap_mainpage_ct_seq;
	}

	public void setFap_mainpage_ct_seq(int fap_mainpage_ct_seq) {
		this.fap_mainpage_ct_seq = fap_mainpage_ct_seq;
	}

	public int getFap_jobfair_divide_seq() {
		return fap_jobfair_divide_seq;
	}

	public void setFap_jobfair_divide_seq(int fap_jobfair_divide_seq) {
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
	}

	public int getFap_jobfair_seq() {
		return fap_jobfair_seq;
	}

	public void setFap_jobfair_seq(int fap_jobfair_seq) {
		this.fap_jobfair_seq = fap_jobfair_seq;
	}

	public String getFap_mainpage_ct_top_ko() {
		return fap_mainpage_ct_top_ko;
	}

	public void setFap_mainpage_ct_top_ko(String fap_mainpage_ct_top_ko) {
		this.fap_mainpage_ct_top_ko = fap_mainpage_ct_top_ko;
	}

	public String getFap_mainpage_ct_top_ja() {
		return fap_mainpage_ct_top_ja;
	}

	public void setFap_mainpage_ct_top_ja(String fap_mainpage_ct_top_ja) {
		this.fap_mainpage_ct_top_ja = fap_mainpage_ct_top_ja;
	}

	public String getFap_mainpage_ct_quarter_ko() {
		return fap_mainpage_ct_quarter_ko;
	}

	public void setFap_mainpage_ct_quarter_ko(String fap_mainpage_ct_quarter_ko) {
		this.fap_mainpage_ct_quarter_ko = fap_mainpage_ct_quarter_ko;
	}

	public String getFap_mainpage_ct_quarter_ja() {
		return fap_mainpage_ct_quarter_ja;
	}

	public void setFap_mainpage_ct_quarter_ja(String fap_mainpage_ct_quarter_ja) {
		this.fap_mainpage_ct_quarter_ja = fap_mainpage_ct_quarter_ja;
	}

	public String getFap_mainpage_ct_imp_code() {
		return fap_mainpage_ct_imp_code;
	}

	public void setFap_mainpage_ct_imp_code(String fap_mainpage_ct_imp_code) {
		this.fap_mainpage_ct_imp_code = fap_mainpage_ct_imp_code;
	}

	public String getFap_mainpage_ct_ins_id() {
		return fap_mainpage_ct_ins_id;
	}

	public void setFap_mainpage_ct_ins_id(String fap_mainpage_ct_ins_id) {
		this.fap_mainpage_ct_ins_id = fap_mainpage_ct_ins_id;
	}

	public String getFap_mainpage_ct_ins_dt() {
		return fap_mainpage_ct_ins_dt;
	}

	public void setFap_mainpage_ct_ins_dt(String fap_mainpage_ct_ins_dt) {
		this.fap_mainpage_ct_ins_dt = fap_mainpage_ct_ins_dt;
	}

	public String getFap_mainpage_ct_udt_id() {
		return fap_mainpage_ct_udt_id;
	}

	public void setFap_mainpage_ct_udt_id(String fap_mainpage_ct_udt_id) {
		this.fap_mainpage_ct_udt_id = fap_mainpage_ct_udt_id;
	}

	public String getFap_mainpage_ct_udt_dt() {
		return fap_mainpage_ct_udt_dt;
	}

	public void setFap_mainpage_ct_udt_dt(String fap_mainpage_ct_udt_dt) {
		this.fap_mainpage_ct_udt_dt = fap_mainpage_ct_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapMainpageContent [fap_mainpage_ct_seq=" + fap_mainpage_ct_seq + ", fap_jobfair_divide_seq="
				+ fap_jobfair_divide_seq + ", fap_jobfair_seq=" + fap_jobfair_seq + ", fap_mainpage_ct_top_ko="
				+ fap_mainpage_ct_top_ko + ", fap_mainpage_ct_top_ja=" + fap_mainpage_ct_top_ja
				+ ", fap_mainpage_ct_quarter_ko=" + fap_mainpage_ct_quarter_ko + ", fap_mainpage_ct_quarter_ja="
				+ fap_mainpage_ct_quarter_ja + ", fap_mainpage_ct_imp_code=" + fap_mainpage_ct_imp_code
				+ ", fap_mainpage_ct_ins_id=" + fap_mainpage_ct_ins_id + ", fap_mainpage_ct_ins_dt="
				+ fap_mainpage_ct_ins_dt + ", fap_mainpage_ct_udt_id=" + fap_mainpage_ct_udt_id
				+ ", fap_mainpage_ct_udt_dt=" + fap_mainpage_ct_udt_dt + "]";
	}
	
}
