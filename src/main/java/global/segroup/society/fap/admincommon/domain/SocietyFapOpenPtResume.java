/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

/**
 * @Author : 이종호
 * @Date : 2019. 4. 11.
 * @Class 설명 : 오픈잡페어 설명회 지원자 이력서 정보
 * 
 */
public class SocietyFapOpenPtResume {
	private int fap_open_pt_resume_seq;
	private int fap_open_pt_apply_seq;
	private long fap_resume_seq;
	private String fap_open_pt_resume_gb;
	
	public SocietyFapOpenPtResume() {
		super();
	}

	public SocietyFapOpenPtResume(int fap_open_pt_resume_seq, int fap_open_pt_apply_seq, long fap_resume_seq,
			String fap_open_pt_resume_gb) {
		super();
		this.fap_open_pt_resume_seq = fap_open_pt_resume_seq;
		this.fap_open_pt_apply_seq = fap_open_pt_apply_seq;
		this.fap_resume_seq = fap_resume_seq;
		this.fap_open_pt_resume_gb = fap_open_pt_resume_gb;
	}

	public int getFap_open_pt_resume_seq() {
		return fap_open_pt_resume_seq;
	}

	public void setFap_open_pt_resume_seq(int fap_open_pt_resume_seq) {
		this.fap_open_pt_resume_seq = fap_open_pt_resume_seq;
	}

	public int getFap_open_pt_apply_seq() {
		return fap_open_pt_apply_seq;
	}

	public void setFap_open_pt_apply_seq(int fap_open_pt_apply_seq) {
		this.fap_open_pt_apply_seq = fap_open_pt_apply_seq;
	}

	public long getFap_resume_seq() {
		return fap_resume_seq;
	}

	public void setFap_resume_seq(long fap_resume_seq) {
		this.fap_resume_seq = fap_resume_seq;
	}

	public String getFap_open_pt_resume_gb() {
		return fap_open_pt_resume_gb;
	}

	public void setFap_open_pt_resume_gb(String fap_open_pt_resume_gb) {
		this.fap_open_pt_resume_gb = fap_open_pt_resume_gb;
	}

	@Override
	public String toString() {
		return "SocietyFapOpenPtResume [fap_open_pt_resume_seq=" + fap_open_pt_resume_seq + ", fap_open_pt_apply_seq="
				+ fap_open_pt_apply_seq + ", fap_resume_seq=" + fap_resume_seq + ", fap_open_pt_resume_gb="
				+ fap_open_pt_resume_gb + "]";
	}
}
