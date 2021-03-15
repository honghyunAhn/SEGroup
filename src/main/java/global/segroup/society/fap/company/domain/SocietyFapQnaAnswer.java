/**
 * 
 */
package global.segroup.society.fap.company.domain;

/**
 * @Author : 신동철
 * @Date : 2018. 12. 5.
 * @Class 설명 : 채용공고 Q&A 답변
 * 
 */
public class SocietyFapQnaAnswer {

	private long fap_job_qna_answer_seq;
	
	private long fap_job_qna_question_seq;
	
	private String fap_job_qna_answer_content;
	
	private String fap_job_qna_answer_ins_id;
	
	private String fap_job_qna_answer_ins_dt;
	
	private String fap_job_qna_answer_udt_id;
	
	private String fap_job_qna_answer_udt_dt;

	/**
	 * @Desc : 
	 */
	public SocietyFapQnaAnswer() {
		super();
	}

	/**
	 * @Desc : 
	 * @param fap_job_qna_answer_seq
	 * @param fap_job_qna_question_seq
	 * @param fap_job_qna_answer_content
	 * @param fap_job_qna_answer_ins_id
	 * @param fap_job_qna_answer_ins_dt
	 * @param fap_job_qna_answer_udt_id
	 * @param fap_job_qna_answer_udt_dt
	 */
	public SocietyFapQnaAnswer(long fap_job_qna_answer_seq, long fap_job_qna_question_seq,
			String fap_job_qna_answer_content, String fap_job_qna_answer_ins_id, String fap_job_qna_answer_ins_dt,
			String fap_job_qna_answer_udt_id, String fap_job_qna_answer_udt_dt) {
		super();
		this.fap_job_qna_answer_seq = fap_job_qna_answer_seq;
		this.fap_job_qna_question_seq = fap_job_qna_question_seq;
		this.fap_job_qna_answer_content = fap_job_qna_answer_content;
		this.fap_job_qna_answer_ins_id = fap_job_qna_answer_ins_id;
		this.fap_job_qna_answer_ins_dt = fap_job_qna_answer_ins_dt;
		this.fap_job_qna_answer_udt_id = fap_job_qna_answer_udt_id;
		this.fap_job_qna_answer_udt_dt = fap_job_qna_answer_udt_dt;
	}

	/**
	 * @return the fap_job_qna_answer_seq
	 */
	public long getFap_job_qna_answer_seq() {
		return fap_job_qna_answer_seq;
	}

	/**
	 * @param fap_job_qna_answer_seq the fap_job_qna_answer_seq to set
	 */
	public void setFap_job_qna_answer_seq(long fap_job_qna_answer_seq) {
		this.fap_job_qna_answer_seq = fap_job_qna_answer_seq;
	}

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
	 * @return the fap_job_qna_answer_content
	 */
	public String getFap_job_qna_answer_content() {
		return fap_job_qna_answer_content;
	}

	/**
	 * @param fap_job_qna_answer_content the fap_job_qna_answer_content to set
	 */
	public void setFap_job_qna_answer_content(String fap_job_qna_answer_content) {
		this.fap_job_qna_answer_content = fap_job_qna_answer_content;
	}

	/**
	 * @return the fap_job_qna_answer_ins_id
	 */
	public String getFap_job_qna_answer_ins_id() {
		return fap_job_qna_answer_ins_id;
	}

	/**
	 * @param fap_job_qna_answer_ins_id the fap_job_qna_answer_ins_id to set
	 */
	public void setFap_job_qna_answer_ins_id(String fap_job_qna_answer_ins_id) {
		this.fap_job_qna_answer_ins_id = fap_job_qna_answer_ins_id;
	}

	/**
	 * @return the fap_job_qna_answer_ins_dt
	 */
	public String getFap_job_qna_answer_ins_dt() {
		return fap_job_qna_answer_ins_dt;
	}

	/**
	 * @param fap_job_qna_answer_ins_dt the fap_job_qna_answer_ins_dt to set
	 */
	public void setFap_job_qna_answer_ins_dt(String fap_job_qna_answer_ins_dt) {
		this.fap_job_qna_answer_ins_dt = fap_job_qna_answer_ins_dt;
	}

	/**
	 * @return the fap_job_qna_answer_udt_id
	 */
	public String getFap_job_qna_answer_udt_id() {
		return fap_job_qna_answer_udt_id;
	}

	/**
	 * @param fap_job_qna_answer_udt_id the fap_job_qna_answer_udt_id to set
	 */
	public void setFap_job_qna_answer_udt_id(String fap_job_qna_answer_udt_id) {
		this.fap_job_qna_answer_udt_id = fap_job_qna_answer_udt_id;
	}

	/**
	 * @return the fap_job_qna_answer_udt_dt
	 */
	public String getFap_job_qna_answer_udt_dt() {
		return fap_job_qna_answer_udt_dt;
	}

	/**
	 * @param fap_job_qna_answer_udt_dt the fap_job_qna_answer_udt_dt to set
	 */
	public void setFap_job_qna_answer_udt_dt(String fap_job_qna_answer_udt_dt) {
		this.fap_job_qna_answer_udt_dt = fap_job_qna_answer_udt_dt;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "SocietyFapQnaAnswer [fap_job_qna_answer_seq=" + fap_job_qna_answer_seq + ", fap_job_qna_question_seq="
				+ fap_job_qna_question_seq + ", fap_job_qna_answer_content=" + fap_job_qna_answer_content
				+ ", fap_job_qna_answer_ins_id=" + fap_job_qna_answer_ins_id + ", fap_job_qna_answer_ins_dt="
				+ fap_job_qna_answer_ins_dt + ", fap_job_qna_answer_udt_id=" + fap_job_qna_answer_udt_id
				+ ", fap_job_qna_answer_udt_dt=" + fap_job_qna_answer_udt_dt + "]";
	}
	
	
	
}
