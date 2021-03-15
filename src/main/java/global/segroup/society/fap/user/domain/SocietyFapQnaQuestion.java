/**
 * 
 */
package global.segroup.society.fap.user.domain;

import global.segroup.society.fap.company.domain.SocietyFapQnaAnswer;

/**
 * @Author : 신동철
 * @Date : 2018. 12. 5.
 * @Class 설명 : 채용공고 Q&A 질문
 * 
 */
public class SocietyFapQnaQuestion {

	private long fap_job_qna_question_seq;
	
	private long fap_job_ad_seq;
	
	private String fap_job_qna_question_title;
	
	private String fap_job_qna_question_content;

	private String fap_job_qna_question_per;
	
	private String fap_job_qna_question_ins_id;
	
	private String fap_job_qna_question_ins_dt;
	
	private String fap_job_qna_question_udt_id;
	
	private String fap_job_qna_question_udt_dt;
	
	private String fap_job_qna_question_state;
	
	private String fap_job_qna_refuse_reason;
	
	private SocietyFapQnaAnswer qna_answer;
	

	/**
	 * @return the fap_job_qna_question_seq
	 */
	public long getFap_job_qna_question_seq() {
		return fap_job_qna_question_seq;
	}

	/**
	 * @param fap_job_qna_question_seq the fap_job_qna_question_seq to set
	 */
	public void setFap_job_qna_question_seq(long fap_job_qna_question_seq) {
		this.fap_job_qna_question_seq = fap_job_qna_question_seq;
	}

	/**
	 * @return the fap_job_ad_seq
	 */
	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	/**
	 * @param fap_job_ad_seq the fap_job_ad_seq to set
	 */
	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	/**
	 * @return the fap_job_qna_question_title
	 */
	public String getFap_job_qna_question_title() {
		return fap_job_qna_question_title;
	}

	/**
	 * @param fap_job_qna_question_title the fap_job_qna_question_title to set
	 */
	public void setFap_job_qna_question_title(String fap_job_qna_question_title) {
		this.fap_job_qna_question_title = fap_job_qna_question_title;
	}

	/**
	 * @return the fap_job_qna_question_content
	 */
	public String getFap_job_qna_question_content() {
		return fap_job_qna_question_content;
	}

	/**
	 * @param fap_job_qna_question_content the fap_job_qna_question_content to set
	 */
	public void setFap_job_qna_question_content(String fap_job_qna_question_content) {
		this.fap_job_qna_question_content = fap_job_qna_question_content;
	}

	/**
	 * @return the fap_job_qna_question_per
	 */
	public String getFap_job_qna_question_per() {
		return fap_job_qna_question_per;
	}

	/**
	 * @param fap_job_qna_question_per the fap_job_qna_question_per to set
	 */
	public void setFap_job_qna_question_per(String fap_job_qna_question_per) {
		this.fap_job_qna_question_per = fap_job_qna_question_per;
	}

	/**
	 * @return the fap_job_qna_question_ins_id
	 */
	public String getFap_job_qna_question_ins_id() {
		return fap_job_qna_question_ins_id;
	}

	/**
	 * @param fap_job_qna_question_ins_id the fap_job_qna_question_ins_id to set
	 */
	public void setFap_job_qna_question_ins_id(String fap_job_qna_question_ins_id) {
		this.fap_job_qna_question_ins_id = fap_job_qna_question_ins_id;
	}

	/**
	 * @return the fap_job_qna_question_ins_dt
	 */
	public String getFap_job_qna_question_ins_dt() {
		return fap_job_qna_question_ins_dt;
	}

	/**
	 * @param fap_job_qna_question_ins_dt the fap_job_qna_question_ins_dt to set
	 */
	public void setFap_job_qna_question_ins_dt(String fap_job_qna_question_ins_dt) {
		this.fap_job_qna_question_ins_dt = fap_job_qna_question_ins_dt;
	}

	/**
	 * @return the fap_job_qna_question_udt_id
	 */
	public String getFap_job_qna_question_udt_id() {
		return fap_job_qna_question_udt_id;
	}

	/**
	 * @param fap_job_qna_question_udt_id the fap_job_qna_question_udt_id to set
	 */
	public void setFap_job_qna_question_udt_id(String fap_job_qna_question_udt_id) {
		this.fap_job_qna_question_udt_id = fap_job_qna_question_udt_id;
	}

	/**
	 * @return the fap_job_qna_question_udt_dt
	 */
	public String getFap_job_qna_question_udt_dt() {
		return fap_job_qna_question_udt_dt;
	}

	/**
	 * @param fap_job_qna_question_udt_dt the fap_job_qna_question_udt_dt to set
	 */
	public void setFap_job_qna_question_udt_dt(String fap_job_qna_question_udt_dt) {
		this.fap_job_qna_question_udt_dt = fap_job_qna_question_udt_dt;
	}

	/**
	 * @return the fap_job_qna_question_state
	 */
	public String getFap_job_qna_question_state() {
		return fap_job_qna_question_state;
	}

	/**
	 * @param fap_job_qna_question_state the fap_job_qna_question_state to set
	 */
	public void setFap_job_qna_question_state(String fap_job_qna_question_state) {
		this.fap_job_qna_question_state = fap_job_qna_question_state;
	}

	/**
	 * @return the fap_job_qna_refuse_reason
	 */
	public String getFap_job_qna_refuse_reason() {
		return fap_job_qna_refuse_reason;
	}

	/**
	 * @param fap_job_qna_refuse_reason the fap_job_qna_refuse_reason to set
	 */
	public void setFap_job_qna_refuse_reason(String fap_job_qna_refuse_reason) {
		this.fap_job_qna_refuse_reason = fap_job_qna_refuse_reason;
	}

	/**
	 * @return the qna_answer
	 */
	public SocietyFapQnaAnswer getQna_answer() {
		return qna_answer;
	}

	/**
	 * @param qna_answer the qna_answer to set
	 */
	public void setQna_answer(SocietyFapQnaAnswer qna_answer) {
		this.qna_answer = qna_answer;
	}

	/**
	 * @Desc : 
	 * @param fap_job_qna_question_seq
	 * @param fap_job_ad_seq
	 * @param fap_job_qna_question_title
	 * @param fap_job_qna_question_content
	 * @param fap_job_qna_question_per
	 * @param fap_job_qna_question_ins_id
	 * @param fap_job_qna_question_ins_dt
	 * @param fap_job_qna_question_udt_id
	 * @param fap_job_qna_question_udt_dt
	 * @param fap_job_qna_question_state
	 * @param fap_job_qna_refuse_reason
	 * @param qna_answer
	 */
	public SocietyFapQnaQuestion(long fap_job_qna_question_seq, long fap_job_ad_seq, String fap_job_qna_question_title,
			String fap_job_qna_question_content, String fap_job_qna_question_per, String fap_job_qna_question_ins_id,
			String fap_job_qna_question_ins_dt, String fap_job_qna_question_udt_id, String fap_job_qna_question_udt_dt,
			String fap_job_qna_question_state, String fap_job_qna_refuse_reason, SocietyFapQnaAnswer qna_answer) {
		super();
		this.fap_job_qna_question_seq = fap_job_qna_question_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_job_qna_question_title = fap_job_qna_question_title;
		this.fap_job_qna_question_content = fap_job_qna_question_content;
		this.fap_job_qna_question_per = fap_job_qna_question_per;
		this.fap_job_qna_question_ins_id = fap_job_qna_question_ins_id;
		this.fap_job_qna_question_ins_dt = fap_job_qna_question_ins_dt;
		this.fap_job_qna_question_udt_id = fap_job_qna_question_udt_id;
		this.fap_job_qna_question_udt_dt = fap_job_qna_question_udt_dt;
		this.fap_job_qna_question_state = fap_job_qna_question_state;
		this.fap_job_qna_refuse_reason = fap_job_qna_refuse_reason;
		this.qna_answer = qna_answer;
	}

	/**
	 * @Desc : 
	 */
	public SocietyFapQnaQuestion() {
		super();
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "SocietyFapQnaQuestion [fap_job_qna_question_seq=" + fap_job_qna_question_seq + ", fap_job_ad_seq="
				+ fap_job_ad_seq + ", fap_job_qna_question_title=" + fap_job_qna_question_title
				+ ", fap_job_qna_question_content=" + fap_job_qna_question_content + ", fap_job_qna_question_per="
				+ fap_job_qna_question_per + ", fap_job_qna_question_ins_id=" + fap_job_qna_question_ins_id
				+ ", fap_job_qna_question_ins_dt=" + fap_job_qna_question_ins_dt + ", fap_job_qna_question_udt_id="
				+ fap_job_qna_question_udt_id + ", fap_job_qna_question_udt_dt=" + fap_job_qna_question_udt_dt
				+ ", fap_job_qna_question_state=" + fap_job_qna_question_state + ", fap_job_qna_refuse_reason="
				+ fap_job_qna_refuse_reason + ", qna_answer=" + qna_answer + "]";
	}

	
	
	
	
}
