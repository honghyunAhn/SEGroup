/**
 * 
 */
package global.segroup.society.fap.user.domain;

import java.util.List;

/**
 * @Author : 남유송
 * @Date : 2018. 12. 6.
 * @Class 설명 : 이력서 주소 정보
 * 
 */
public class SocietyFapUserResumeAddr {
	/**
	 * 이력서 주소 정보 일련번호
	 */
	private long fap_resume_address_seq;
	
	/**
	 * 이력서 일련 번호
	 */
	private long fap_resume_seq;
	
	/**
	 * 이력서 주소
	 */
	private String fap_resume_address;
	
	/**
	 * 언어구분(공통코드)
	 */
	private String fap_resume_lang_gb;

	/**
	 * 등록자
	 */
	private String fap_resume_address_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_resume_address_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_resume_address_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_resume_address_udt_dt;
	
	/**
	 * 주소 리스트
	 */
	private List<SocietyFapUserResumeAddr> resumeAddrList;
	
	public SocietyFapUserResumeAddr() {
		super();
	}

	public SocietyFapUserResumeAddr(long fap_resume_address_seq, long fap_resume_seq, String fap_resume_address,
			String fap_resume_lang_gb, String fap_resume_address_ins_id, String fap_resume_address_ins_dt,
			String fap_resume_address_udt_id, String fap_resume_address_udt_dt, List<SocietyFapUserResumeAddr> resumeAddrList) {
		super();
		this.fap_resume_address_seq = fap_resume_address_seq;
		this.fap_resume_seq = fap_resume_seq;
		this.fap_resume_address = fap_resume_address;
		this.fap_resume_lang_gb = fap_resume_lang_gb;
		this.fap_resume_address_ins_id = fap_resume_address_ins_id;
		this.fap_resume_address_ins_dt = fap_resume_address_ins_dt;
		this.fap_resume_address_udt_id = fap_resume_address_udt_id;
		this.fap_resume_address_udt_dt = fap_resume_address_udt_dt;
		this.resumeAddrList = resumeAddrList;
	}

	public long getFap_resume_address_seq() {
		return fap_resume_address_seq;
	}

	public void setFap_resume_address_seq(long fap_resume_address_seq) {
		this.fap_resume_address_seq = fap_resume_address_seq;
	}

	public long getFap_resume_seq() {
		return fap_resume_seq;
	}

	public void setFap_resume_seq(long fap_resume_seq) {
		this.fap_resume_seq = fap_resume_seq;
	}

	public String getFap_resume_address() {
		return fap_resume_address;
	}

	public void setFap_resume_address(String fap_resume_address) {
		this.fap_resume_address = fap_resume_address;
	}

	public String getFap_resume_lang_gb() {
		return fap_resume_lang_gb;
	}

	public void setFap_resume_lang_gb(String fap_resume_lang_gb) {
		this.fap_resume_lang_gb = fap_resume_lang_gb;
	}

	public String getFap_resume_address_ins_id() {
		return fap_resume_address_ins_id;
	}

	public void setFap_resume_address_ins_id(String fap_resume_address_ins_id) {
		this.fap_resume_address_ins_id = fap_resume_address_ins_id;
	}

	public String getFap_resume_address_ins_dt() {
		return fap_resume_address_ins_dt;
	}

	public void setFap_resume_address_ins_dt(String fap_resume_address_ins_dt) {
		this.fap_resume_address_ins_dt = fap_resume_address_ins_dt;
	}

	public String getFap_resume_address_udt_id() {
		return fap_resume_address_udt_id;
	}

	public void setFap_resume_address_udt_id(String fap_resume_address_udt_id) {
		this.fap_resume_address_udt_id = fap_resume_address_udt_id;
	}

	public String getFap_resume_address_udt_dt() {
		return fap_resume_address_udt_dt;
	}

	public void setFap_resume_address_udt_dt(String fap_resume_address_udt_dt) {
		this.fap_resume_address_udt_dt = fap_resume_address_udt_dt;
	}

	public List<SocietyFapUserResumeAddr> getResumeAddrList() {
		return resumeAddrList;
	}

	public void setResumeAddrList(List<SocietyFapUserResumeAddr> resumeAddrList) {
		this.resumeAddrList = resumeAddrList;
	}

	@Override
	public String toString() {
		return "ResumeAddr [fap_resume_address_seq=" + fap_resume_address_seq + ", fap_resume_seq=" + fap_resume_seq
				+ ", fap_resume_address=" + fap_resume_address + ", fap_resume_lang_gb=" + fap_resume_lang_gb
				+ ", fap_resume_address_ins_id=" + fap_resume_address_ins_id + ", fap_resume_address_ins_dt="
				+ fap_resume_address_ins_dt + ", fap_resume_address_udt_id=" + fap_resume_address_udt_id
				+ ", fap_resume_address_udt_dt=" + fap_resume_address_udt_dt + ", resumeAddrList=" + resumeAddrList
				+ "]";
	}

}
