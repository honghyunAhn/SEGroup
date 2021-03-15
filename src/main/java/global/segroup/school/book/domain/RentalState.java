/**
 * 
 */
package global.segroup.school.book.domain;

/**
 * @Author : 서민수
 * @Date : 2017. 7. 26.
 * @Class 설명 : SES 도서관 대여 상태 클래스
 * 
 */
public class RentalState {
	/**
	 * 공통 게시판 게시물 테이블 시퀀스
	 */
	private int board_content_seq;
	
	/**
	 * BOOK_BOOK_TB 테이블 시퀀스
	 */
	private int book_seq;	
	
	/**
	 * BOOK_RENTAL_STATE_TB 테이블 시퀀스
	 */
	private int rental_seq;	
	
	/**
	 * 대여 신청 아이디 (학생)
	 */
	private String rental_req_id;		
	
	/**
	 * 대여 신청자 이름 (학생)
	 */
	private String user_nm;
	
	/**
	 * 대여 신창한 책 이름
	 */
	private String bookinfo_book_nm;
	
	/**
	 * 대여 신청 날짜
	 */
	private String rental_req_dt;			
	
	/**
	 * 대여 승인 아이디(관리자 또는 부관리자)
	 */
	private String rental_req_permit_id;
	
	/**
	 * 대여 승인 날짜
	 */	
	private String rental_req_permit_dt;	
	
	/**
	 * 대여 요청에 대한 상태 (공통 코드)
	 */		
	private String rental_req_state;		
	
	/**
	 * 반납 예정일
	 */		
	private String rental_rtn_due_dt;	
	
	/**
	 * 반납 승인 아이디(관리자)
	 */
	private String rental_rtn_permit_id;	
	
	/**
	 * 반납 승인 날짜 (실제 반납 날짜)
	 */
	private String rental_rtn_permit_dt;		
	
	/**
	 * 반납 상태(공통 코드)
	 */
	private String rental_rtn_state;	
	
	/**
	 * 연장 가능 여부
	 */
	private boolean rental_extendable;		
	
	/**
	 * 등록 날짜
	 */
	private String rental_ins_dt;	
	
	/**
	 * 수정 날짜
	 */
	private String rental_udt_dt;
	
	/**
	 * 도서 라벨
	 */
	private String book_label;
	
	public RentalState(){
		super();
	}



	/**
	 * @Desc : 
	 * @param board_content_seq
	 * @param book_seq
	 * @param rental_seq
	 * @param rental_req_id
	 * @param user_nm
	 * @param bookinfo_book_nm
	 * @param rental_req_dt
	 * @param rental_req_permit_id
	 * @param rental_req_permit_dt
	 * @param rental_req_state
	 * @param rental_rtn_due_dt
	 * @param rental_rtn_permit_id
	 * @param rental_rtn_permit_dt
	 * @param rental_rtn_state
	 * @param rental_extendable
	 * @param rental_ins_dt
	 * @param rental_udt_dt
	 * @param book_label
	 */
	public RentalState(int board_content_seq, int book_seq, int rental_seq, String rental_req_id, String user_nm,
			String bookinfo_book_nm, String rental_req_dt, String rental_req_permit_id, String rental_req_permit_dt,
			String rental_req_state, String rental_rtn_due_dt, String rental_rtn_permit_id, String rental_rtn_permit_dt,
			String rental_rtn_state, boolean rental_extendable, String rental_ins_dt, String rental_udt_dt,
			String book_label) {
		super();
		this.board_content_seq = board_content_seq;
		this.book_seq = book_seq;
		this.rental_seq = rental_seq;
		this.rental_req_id = rental_req_id;
		this.user_nm = user_nm;
		this.bookinfo_book_nm = bookinfo_book_nm;
		this.rental_req_dt = rental_req_dt;
		this.rental_req_permit_id = rental_req_permit_id;
		this.rental_req_permit_dt = rental_req_permit_dt;
		this.rental_req_state = rental_req_state;
		this.rental_rtn_due_dt = rental_rtn_due_dt;
		this.rental_rtn_permit_id = rental_rtn_permit_id;
		this.rental_rtn_permit_dt = rental_rtn_permit_dt;
		this.rental_rtn_state = rental_rtn_state;
		this.rental_extendable = rental_extendable;
		this.rental_ins_dt = rental_ins_dt;
		this.rental_udt_dt = rental_udt_dt;
		this.book_label = book_label;
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
	 * @return the book_seq
	 */
	public int getBook_seq() {
		return book_seq;
	}




	/**
	 * @param book_seq the book_seq to set
	 */
	public void setBook_seq(int book_seq) {
		this.book_seq = book_seq;
	}




	/**
	 * @return the rental_seq
	 */
	public int getRental_seq() {
		return rental_seq;
	}




	/**
	 * @param rental_seq the rental_seq to set
	 */
	public void setRental_seq(int rental_seq) {
		this.rental_seq = rental_seq;
	}




	/**
	 * @return the rental_req_id
	 */
	public String getRental_req_id() {
		return rental_req_id;
	}




	/**
	 * @param rental_req_id the rental_req_id to set
	 */
	public void setRental_req_id(String rental_req_id) {
		this.rental_req_id = rental_req_id;
	}




	/**
	 * @return the rental_req_dt
	 */
	public String getRental_req_dt() {
		return rental_req_dt;
	}




	/**
	 * @param rental_req_dt the rental_req_dt to set
	 */
	public void setRental_req_dt(String rental_req_dt) {
		this.rental_req_dt = rental_req_dt;
	}




	/**
	 * @return the rental_req_permit_id
	 */
	public String getRental_req_permit_id() {
		return rental_req_permit_id;
	}




	/**
	 * @param rental_req_permit_id the rental_req_permit_id to set
	 */
	public void setRental_req_permit_id(String rental_req_permit_id) {
		this.rental_req_permit_id = rental_req_permit_id;
	}




	/**
	 * @return the rental_req_permit_dt
	 */
	public String getRental_req_permit_dt() {
		return rental_req_permit_dt;
	}




	/**
	 * @param rental_req_permit_dt the rental_req_permit_dt to set
	 */
	public void setRental_req_permit_dt(String rental_req_permit_dt) {
		this.rental_req_permit_dt = rental_req_permit_dt;
	}




	/**
	 * @return the rental_req_state
	 */
	public String getRental_req_state() {
		return rental_req_state;
	}




	/**
	 * @param rental_req_state the rental_req_state to set
	 */
	public void setRental_req_state(String rental_req_state) {
		this.rental_req_state = rental_req_state;
	}




	/**
	 * @return the rental_rtn_due_dt
	 */
	public String getRental_rtn_due_dt() {
		return rental_rtn_due_dt;
	}




	/**
	 * @param rental_rtn_due_dt the rental_rtn_due_dt to set
	 */
	public void setRental_rtn_due_dt(String rental_rtn_due_dt) {
		this.rental_rtn_due_dt = rental_rtn_due_dt;
	}




	/**
	 * @return the rental_rtn_permit_id
	 */
	public String getRental_rtn_permit_id() {
		return rental_rtn_permit_id;
	}




	/**
	 * @param rental_rtn_permit_id the rental_rtn_permit_id to set
	 */
	public void setRental_rtn_permit_id(String rental_rtn_permit_id) {
		this.rental_rtn_permit_id = rental_rtn_permit_id;
	}




	/**
	 * @return the rental_rtn_permit_dt
	 */
	public String getRental_rtn_permit_dt() {
		return rental_rtn_permit_dt;
	}




	/**
	 * @param rental_rtn_permit_dt the rental_rtn_permit_dt to set
	 */
	public void setRental_rtn_permit_dt(String rental_rtn_permit_dt) {
		this.rental_rtn_permit_dt = rental_rtn_permit_dt;
	}




	/**
	 * @return the rental_rtn_state
	 */
	public String getRental_rtn_state() {
		return rental_rtn_state;
	}




	/**
	 * @param rental_rtn_state the rental_rtn_state to set
	 */
	public void setRental_rtn_state(String rental_rtn_state) {
		this.rental_rtn_state = rental_rtn_state;
	}




	/**
	 * @return the rental_extendable
	 */
	public boolean isRental_extendable() {
		return rental_extendable;
	}




	/**
	 * @param rental_extendable the rental_extendable to set
	 */
	public void setRental_extendable(boolean rental_extendable) {
		this.rental_extendable = rental_extendable;
	}




	/**
	 * @return the rental_ins_dt
	 */
	public String getRental_ins_dt() {
		return rental_ins_dt;
	}




	/**
	 * @param rental_ins_dt the rental_ins_dt to set
	 */
	public void setRental_ins_dt(String rental_ins_dt) {
		this.rental_ins_dt = rental_ins_dt;
	}




	/**
	 * @return the rental_udt_dt
	 */
	public String getRental_udt_dt() {
		return rental_udt_dt;
	}




	/**
	 * @param rental_udt_dt the rental_udt_dt to set
	 */
	public void setRental_udt_dt(String rental_udt_dt) {
		this.rental_udt_dt = rental_udt_dt;
	}



	/**
	 * @return the user_nm
	 */
	public String getUser_nm() {
		return user_nm;
	}



	/**
	 * @param user_nm the user_nm to set
	 */
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}



	/**
	 * @return the bookinfo_book_nm
	 */
	public String getBookinfo_book_nm() {
		return bookinfo_book_nm;
	}



	/**
	 * @param bookinfo_book_nm the bookinfo_book_nm to set
	 */
	public void setBookinfo_book_nm(String bookinfo_book_nm) {
		this.bookinfo_book_nm = bookinfo_book_nm;
	}


	/**
	 * @return the book_label
	 */
	public String getBook_label() {
		return book_label;
	}



	/**
	 * @param book_label the book_label to set
	 */
	public void setBook_label(String book_label) {
		this.book_label = book_label;
	}


	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "RentalState [board_content_seq=" + board_content_seq + ", book_seq=" + book_seq + ", rental_seq="
				+ rental_seq + ", rental_req_id=" + rental_req_id + ", user_nm=" + user_nm + ", bookinfo_book_nm="
				+ bookinfo_book_nm + ", rental_req_dt=" + rental_req_dt + ", rental_req_permit_id="
				+ rental_req_permit_id + ", rental_req_permit_dt=" + rental_req_permit_dt + ", rental_req_state="
				+ rental_req_state + ", rental_rtn_due_dt=" + rental_rtn_due_dt + ", rental_rtn_permit_id="
				+ rental_rtn_permit_id + ", rental_rtn_permit_dt=" + rental_rtn_permit_dt + ", rental_rtn_state="
				+ rental_rtn_state + ", rental_extendable=" + rental_extendable + ", rental_ins_dt=" + rental_ins_dt
				+ ", rental_udt_dt=" + rental_udt_dt + ", book_label=" + book_label + "]";
	}


}
