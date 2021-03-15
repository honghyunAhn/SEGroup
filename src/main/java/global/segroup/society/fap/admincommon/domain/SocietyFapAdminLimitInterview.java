/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

/**
 * @Author : 이종호
 * @Date : 2019. 7. 26.
 * @Class 설명 : 잡페어 현지면접 인원제한 정보
 * 
 */
public class SocietyFapAdminLimitInterview {
	
	private int fap_limit_interview_set_seq;
	
	private int fap_jobfair_seq;
	
	private String fap_limit_interview_type;
	
	private int fap_limit_interview_count;

	public SocietyFapAdminLimitInterview() {
		super();
	}

	public SocietyFapAdminLimitInterview(int fap_limit_interview_set_seq, int fap_jobfair_seq,
			String fap_limit_interview_type, int fap_limit_interview_count) {
		super();
		this.fap_limit_interview_set_seq = fap_limit_interview_set_seq;
		this.fap_jobfair_seq = fap_jobfair_seq;
		this.fap_limit_interview_type = fap_limit_interview_type;
		this.fap_limit_interview_count = fap_limit_interview_count;
	}

	public int getFap_limit_interview_set_seq() {
		return fap_limit_interview_set_seq;
	}

	public void setFap_limit_interview_set_seq(int fap_limit_interview_set_seq) {
		this.fap_limit_interview_set_seq = fap_limit_interview_set_seq;
	}

	public int getFap_jobfair_seq() {
		return fap_jobfair_seq;
	}

	public void setFap_jobfair_seq(int fap_jobfair_seq) {
		this.fap_jobfair_seq = fap_jobfair_seq;
	}

	public String getFap_limit_interview_type() {
		return fap_limit_interview_type;
	}

	public void setFap_limit_interview_type(String fap_limit_interview_type) {
		this.fap_limit_interview_type = fap_limit_interview_type;
	}

	public int getFap_limit_interview_count() {
		return fap_limit_interview_count;
	}

	public void setFap_limit_interview_count(int fap_limit_interview_count) {
		this.fap_limit_interview_count = fap_limit_interview_count;
	}

	@Override
	public String toString() {
		return "SocietyFapAdminLimitInterview [fap_limit_interview_set_seq=" + fap_limit_interview_set_seq
				+ ", fap_jobfair_seq=" + fap_jobfair_seq + ", fap_limit_interview_type=" + fap_limit_interview_type
				+ ", fap_limit_interview_count=" + fap_limit_interview_count + "]";
	}
	
}
