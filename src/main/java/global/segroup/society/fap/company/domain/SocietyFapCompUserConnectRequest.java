/**
 * 
 */
package global.segroup.society.fap.company.domain;

/**
 * @Author : 김준영
 * @Date : 2019. 2. 7.
 * @Class 설명 : 기업 - 담당자 연결 요청
 * 
 */
public class SocietyFapCompUserConnectRequest {

	private int fap_comp_user_request_seq;
	
	private String user_id;
	
	private String fap_comp_en_nm;
	
	private String Fap_comp_ja_nm;

	private String fap_comp_user_request_ck;

	public SocietyFapCompUserConnectRequest() {
		super();
	}

	public SocietyFapCompUserConnectRequest(int fap_comp_user_request_seq, String user_id, String fap_comp_en_nm,
			String fap_comp_ja_nm, String fap_comp_user_request_ck) {
		super();
		this.fap_comp_user_request_seq = fap_comp_user_request_seq;
		this.user_id = user_id;
		this.fap_comp_en_nm = fap_comp_en_nm;
		Fap_comp_ja_nm = fap_comp_ja_nm;
		this.fap_comp_user_request_ck = fap_comp_user_request_ck;
	}

	public int getFap_comp_user_request_seq() {
		return fap_comp_user_request_seq;
	}

	public void setFap_comp_user_request_seq(int fap_comp_user_request_seq) {
		this.fap_comp_user_request_seq = fap_comp_user_request_seq;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getFap_comp_en_nm() {
		return fap_comp_en_nm;
	}

	public void setFap_comp_en_nm(String fap_comp_en_nm) {
		this.fap_comp_en_nm = fap_comp_en_nm;
	}

	public String getFap_comp_ja_nm() {
		return Fap_comp_ja_nm;
	}

	public void setFap_comp_ja_nm(String fap_comp_ja_nm) {
		Fap_comp_ja_nm = fap_comp_ja_nm;
	}

	public String getFap_comp_user_request_ck() {
		return fap_comp_user_request_ck;
	}

	public void setFap_comp_user_request_ck(String fap_comp_user_request_ck) {
		this.fap_comp_user_request_ck = fap_comp_user_request_ck;
	}

	@Override
	public String toString() {
		return "SocietyFapCompUserConnectRequest [fap_comp_user_request_seq=" + fap_comp_user_request_seq + ", user_id="
				+ user_id + ", fap_comp_en_nm=" + fap_comp_en_nm + ", Fap_comp_ja_nm=" + Fap_comp_ja_nm
				+ ", fap_comp_user_request_ck=" + fap_comp_user_request_ck + "]";
	}
	
	
	
}
