/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

/**
 * @Author : 이종호
 * @Date : 2019. 9. 26.
 * @Class 설명 : 도쿄페어 전형 인원 정보
 * 
 */
public class SocietyFapTokyofairScrUser {
	private long fap_tokyofair_scr_user_seq;
	private int fap_tokyofair_screening_seq;
	private long fap_tokyofair_scr_resume_seq;
	
	private List<SocietyFapTokyofairScrUser> scrUserList;

	public SocietyFapTokyofairScrUser() {
		super();
	}

	public SocietyFapTokyofairScrUser(long fap_tokyofair_scr_user_seq, int fap_tokyofair_screening_seq,
			long fap_tokyofair_scr_resume_seq, List<SocietyFapTokyofairScrUser> scrUserList) {
		super();
		this.fap_tokyofair_scr_user_seq = fap_tokyofair_scr_user_seq;
		this.fap_tokyofair_screening_seq = fap_tokyofair_screening_seq;
		this.fap_tokyofair_scr_resume_seq = fap_tokyofair_scr_resume_seq;
		this.scrUserList = scrUserList;
	}

	public long getFap_tokyofair_scr_user_seq() {
		return fap_tokyofair_scr_user_seq;
	}

	public void setFap_tokyofair_scr_user_seq(long fap_tokyofair_scr_user_seq) {
		this.fap_tokyofair_scr_user_seq = fap_tokyofair_scr_user_seq;
	}

	public int getFap_tokyofair_screening_seq() {
		return fap_tokyofair_screening_seq;
	}

	public void setFap_tokyofair_screening_seq(int fap_tokyofair_screening_seq) {
		this.fap_tokyofair_screening_seq = fap_tokyofair_screening_seq;
	}

	public long getFap_tokyofair_scr_resume_seq() {
		return fap_tokyofair_scr_resume_seq;
	}

	public void setFap_tokyofair_scr_resume_seq(long fap_tokyofair_scr_resume_seq) {
		this.fap_tokyofair_scr_resume_seq = fap_tokyofair_scr_resume_seq;
	}

	public List<SocietyFapTokyofairScrUser> getScrUserList() {
		return scrUserList;
	}

	public void setScrUserList(List<SocietyFapTokyofairScrUser> scrUserList) {
		this.scrUserList = scrUserList;
	}

	@Override
	public String toString() {
		return "SocietyFapTokyofairScrUser [fap_tokyofair_scr_user_seq=" + fap_tokyofair_scr_user_seq
				+ ", fap_tokyofair_screening_seq=" + fap_tokyofair_screening_seq + ", fap_tokyofair_scr_resume_seq="
				+ fap_tokyofair_scr_resume_seq + ", scrUserList=" + scrUserList + "]";
	}
	
}
