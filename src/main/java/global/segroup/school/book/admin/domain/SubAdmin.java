/**
 * 
 */
package global.segroup.school.book.admin.domain;

/**
 * @Author : 서민수
 * @Date : 2017. 7. 26.
 * @Class 설명 : SES 도서관 부 관리자 클래스
 * 
 */
public class SubAdmin {
	/**
	 * 공통 게시판 게시물 테이블 시퀀스
	 */
	private int board_content_seq;	
	
	/**
	 * 부 관리자 id
	 */
	private String subadmin_id;	
	
	/**
	 * 부 관리자 비밀번호
	 */
	private String subadmin_pw;				
	
	/**
	 * 부 관리자 계정을 사용하는 학생 id
	 */
	private String subadmin_std_id;		
	
	/**
	 * 부 관리자 계정 생성 날짜
	 */
	private String subadmin_cr_dt;	

	/**
	 * 부 관리자 계정 상태
	 */
	private String subadmin_state;
	
	/**
	 * 계정 수정 id (수정 id)
	 */
	private String subadmin_udt_id;	
	
	/**
	 * 계정 생성 id (등록 id)
	 */
	private String subadmin_ins_id;	
	
	/**
	 * 등록 날짜
	 */
	private String subadmin_ins_dt;
	
	/**
	 * 수정 날짜
	 */
	private String subadmin_udt_dt;


	public SubAdmin(){}
	
	public SubAdmin(int board_content_seq, String subadmin_id, String subadmin_pw, String subadmin_std_id,
			String subadmin_cr_dt, String subadmin_state, String subadmin_udt_id, String subadmin_ins_id,
			String subadmin_ins_dt, String subadmin_udt_dt) {
		super();
		this.board_content_seq = board_content_seq;
		this.subadmin_id = subadmin_id;
		this.subadmin_pw = subadmin_pw;
		this.subadmin_std_id = subadmin_std_id;
		this.subadmin_cr_dt = subadmin_cr_dt;
		this.subadmin_state = subadmin_state;
		this.subadmin_udt_id = subadmin_udt_id;
		this.subadmin_ins_id = subadmin_ins_id;
		this.subadmin_ins_dt = subadmin_ins_dt;
		this.subadmin_udt_dt = subadmin_udt_dt;
	}


	
	/**
	 * @return the board_content_seq
	 */
	public int getBoard_content_seq() {
		return board_content_seq;
	}



	/**
	 * @param board_content_seq the board_content_seq to set
	 */
	public void setBoard_content_seq(int board_content_seq) {
		this.board_content_seq = board_content_seq;
	}



	/**
	 * @return the subadmin_id
	 */
	public String getSubadmin_id() {
		return subadmin_id;
	}



	/**
	 * @param subadmin_id the subadmin_id to set
	 */
	public void setSubadmin_id(String subadmin_id) {
		this.subadmin_id = subadmin_id;
	}



	/**
	 * @return the subadmin_pw
	 */
	public String getSubadmin_pw() {
		return subadmin_pw;
	}



	/**
	 * @param subadmin_pw the subadmin_pw to set
	 */
	public void setSubadmin_pw(String subadmin_pw) {
		this.subadmin_pw = subadmin_pw;
	}



	/**
	 * @return the subadmin_std_id
	 */
	public String getSubadmin_std_id() {
		return subadmin_std_id;
	}



	/**
	 * @param subadmin_std_id the subadmin_std_id to set
	 */
	public void setSubadmin_std_id(String subadmin_std_id) {
		this.subadmin_std_id = subadmin_std_id;
	}



	/**
	 * @return the subadmin_cr_dt
	 */
	public String getSubadmin_cr_dt() {
		return subadmin_cr_dt;
	}



	/**
	 * @param subadmin_cr_dt the subadmin_cr_dt to set
	 */
	public void setSubadmin_cr_dt(String subadmin_cr_dt) {
		this.subadmin_cr_dt = subadmin_cr_dt;
	}



	/**
	 * @return the subadmin_state
	 */
	public String getSubadmin_state() {
		return subadmin_state;
	}



	/**
	 * @param subadmin_state the subadmin_state to set
	 */
	public void setSubadmin_state(String subadmin_state) {
		this.subadmin_state = subadmin_state;
	}



	/**
	 * @return the subadmin_udt_id
	 */
	public String getSubadmin_udt_id() {
		return subadmin_udt_id;
	}



	/**
	 * @param subadmin_udt_id the subadmin_udt_id to set
	 */
	public void setSubadmin_udt_id(String subadmin_udt_id) {
		this.subadmin_udt_id = subadmin_udt_id;
	}



	/**
	 * @return the subadmin_ins_id
	 */
	public String getSubadmin_ins_id() {
		return subadmin_ins_id;
	}



	/**
	 * @param subadmin_ins_id the subadmin_ins_id to set
	 */
	public void setSubadmin_ins_id(String subadmin_ins_id) {
		this.subadmin_ins_id = subadmin_ins_id;
	}



	/**
	 * @return the subadmin_ins_dt
	 */
	public String getSubadmin_ins_dt() {
		return subadmin_ins_dt;
	}



	/**
	 * @param subadmin_ins_dt the subadmin_ins_dt to set
	 */
	public void setSubadmin_ins_dt(String subadmin_ins_dt) {
		this.subadmin_ins_dt = subadmin_ins_dt;
	}



	/**
	 * @return the subadmin_udt_dt
	 */
	public String getSubadmin_udt_dt() {
		return subadmin_udt_dt;
	}



	/**
	 * @param subadmin_udt_dt the subadmin_udt_dt to set
	 */
	public void setSubadmin_udt_dt(String subadmin_udt_dt) {
		this.subadmin_udt_dt = subadmin_udt_dt;
	}



	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "SubAdmin [board_content_seq=" + board_content_seq + ", subadmin_id=" + subadmin_id + ", subadmin_pw="
				+ subadmin_pw + ", subadmin_std_id=" + subadmin_std_id + ", subadmin_cr_dt=" + subadmin_cr_dt
				+ ", subadmin_state=" + subadmin_state + ", subadmin_udt_id=" + subadmin_udt_id + ", subadmin_ins_id="
				+ subadmin_ins_id + ", subadmin_ins_dt=" + subadmin_ins_dt + ", subadmin_udt_dt=" + subadmin_udt_dt
				+ "]";
	}
	
}
