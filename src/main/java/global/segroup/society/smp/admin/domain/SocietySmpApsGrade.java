/**
 * 
 */
package global.segroup.society.smp.admin.domain;

/**
 * @Author : Administrator
 * @Date : 2019. 1. 14.
 * @Class 설명 :
 * 
 */
public class SocietySmpApsGrade {

	private int smp_aps_grade_seq; // 성적 시퀀스

	private int smp_seq; // 학적부 시퀀스

	private int smp_aps_detail_exam_seq; // 평가항목 상세평가 정규시험 시퀀스

	private int smp_aps_detail_subexam_seq; // 평가항목 상세평가 과목평가 시퀀스

	private int smp_aps_grade_score; // 성적점수

	private int smp_aps_grade_count; // 성적횟수

	private String smp_aps_grade_etc; // 비고

	private String smp_aps_grade_ins_id; // 등록자

	private String smp_aps_grade_ins_dt; // 등록일자

	private String smp_aps_grade_udt_id; // 수정자

	private String smp_aps_grade_udt_dt; // 수정일자

	public SocietySmpApsGrade(int smp_aps_grade_seq, int smp_seq, int smp_aps_detail_exam_seq,
			int smp_aps_detail_subexam_seq, int smp_aps_grade_score, int smp_aps_grade_count, String smp_aps_grade_etc,
			String smp_aps_grade_ins_id, String smp_aps_grade_ins_dt, String smp_aps_grade_udt_id,
			String smp_aps_grade_udt_dt) {
		super();
		this.smp_aps_grade_seq = smp_aps_grade_seq;
		this.smp_seq = smp_seq;
		this.smp_aps_detail_exam_seq = smp_aps_detail_exam_seq;
		this.smp_aps_detail_subexam_seq = smp_aps_detail_subexam_seq;
		this.smp_aps_grade_score = smp_aps_grade_score;
		this.smp_aps_grade_count = smp_aps_grade_count;
		this.smp_aps_grade_etc = smp_aps_grade_etc;
		this.smp_aps_grade_ins_id = smp_aps_grade_ins_id;
		this.smp_aps_grade_ins_dt = smp_aps_grade_ins_dt;
		this.smp_aps_grade_udt_id = smp_aps_grade_udt_id;
		this.smp_aps_grade_udt_dt = smp_aps_grade_udt_dt;
	}

	public int getSmp_aps_grade_seq() {
		return smp_aps_grade_seq;
	}

	public void setSmp_aps_grade_seq(int smp_aps_grade_seq) {
		this.smp_aps_grade_seq = smp_aps_grade_seq;
	}

	public int getSmp_seq() {
		return smp_seq;
	}

	public void setSmp_seq(int smp_seq) {
		this.smp_seq = smp_seq;
	}

	public int getSmp_aps_detail_exam_seq() {
		return smp_aps_detail_exam_seq;
	}

	public void setSmp_aps_detail_exam_seq(int smp_aps_detail_exam_seq) {
		this.smp_aps_detail_exam_seq = smp_aps_detail_exam_seq;
	}

	public int getSmp_aps_detail_subexam_seq() {
		return smp_aps_detail_subexam_seq;
	}

	public void setSmp_aps_detail_subexam_seq(int smp_aps_detail_subexam_seq) {
		this.smp_aps_detail_subexam_seq = smp_aps_detail_subexam_seq;
	}

	public int getSmp_aps_grade_score() {
		return smp_aps_grade_score;
	}

	public void setSmp_aps_grade_score(int smp_aps_grade_score) {
		this.smp_aps_grade_score = smp_aps_grade_score;
	}

	public int getSmp_aps_grade_count() {
		return smp_aps_grade_count;
	}

	public void setSmp_aps_grade_count(int smp_aps_grade_count) {
		this.smp_aps_grade_count = smp_aps_grade_count;
	}

	public String getSmp_aps_grade_etc() {
		return smp_aps_grade_etc;
	}

	public void setSmp_aps_grade_etc(String smp_aps_grade_etc) {
		this.smp_aps_grade_etc = smp_aps_grade_etc;
	}

	public String getSmp_aps_grade_ins_id() {
		return smp_aps_grade_ins_id;
	}

	public void setSmp_aps_grade_ins_id(String smp_aps_grade_ins_id) {
		this.smp_aps_grade_ins_id = smp_aps_grade_ins_id;
	}

	public String getSmp_aps_grade_ins_dt() {
		return smp_aps_grade_ins_dt;
	}

	public void setSmp_aps_grade_ins_dt(String smp_aps_grade_ins_dt) {
		this.smp_aps_grade_ins_dt = smp_aps_grade_ins_dt;
	}

	public String getSmp_aps_grade_udt_id() {
		return smp_aps_grade_udt_id;
	}

	public void setSmp_aps_grade_udt_id(String smp_aps_grade_udt_id) {
		this.smp_aps_grade_udt_id = smp_aps_grade_udt_id;
	}

	public String getSmp_aps_grade_udt_dt() {
		return smp_aps_grade_udt_dt;
	}

	public void setSmp_aps_grade_udt_dt(String smp_aps_grade_udt_dt) {
		this.smp_aps_grade_udt_dt = smp_aps_grade_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietySmpApsGrade [smp_aps_grade_seq=" + smp_aps_grade_seq + ", smp_seq=" + smp_seq
				+ ", smp_aps_detail_exam_seq=" + smp_aps_detail_exam_seq + ", smp_aps_detail_subexam_seq="
				+ smp_aps_detail_subexam_seq + ", smp_aps_grade_score=" + smp_aps_grade_score + ", smp_aps_grade_count="
				+ smp_aps_grade_count + ", smp_aps_grade_etc=" + smp_aps_grade_etc + ", smp_aps_grade_ins_id="
				+ smp_aps_grade_ins_id + ", smp_aps_grade_ins_dt=" + smp_aps_grade_ins_dt + ", smp_aps_grade_udt_id="
				+ smp_aps_grade_udt_id + ", smp_aps_grade_udt_dt=" + smp_aps_grade_udt_dt + "]";
	}

}
