/**
 * 
 */
package global.segroup.school.book.domain;

/**
 * @Author : 서민수
 * @Date : 2017. 7. 26.
 * @Class 설명 : SES 도서관 구매신청 클래스
 * 
 */
public class PurchaseReq {
	/**
	 * 공통 게시판 게시물 테이블 시퀀스 
	 */
	private int board_content_seq;		
	
	/**
	 * 구매신청한 책의 isbn
	 */
	private String purchase_req_isbn;	
	
	/**
	 * 구매신청한 책의 이름
	 */
	private String purchase_req_book_nm;	
	
	/**
	 * 구매신청한 책의 출판사
	 */
	private String purchase_req_publisher;	
	
	/**
	 * 구매신청한 책의 저자
	 */
	private String purchase_req_author;	
	
	/**
	 * 구매신청이유
	 */
	private String purchase_req_reason;	
	
	/**
	 * 구매신청 상태
	 */
	private String purchase_req_state;	
	
	/**
	 * 구매신청 날짜
	 */
	private String purchase_req_dt;		
	
	/**
	 * 구매신청한 사용자의 id
	 */
	private String purchase_req_id;	
	
	/**
	 * 수정 id(관리자)
	 */
	private String purchase_udt_id;		
	
	/**
	 * 등록 날짜
	 */
	private String purchase_ins_dt;		
	
	/**
	 * 수정 날짜
	 */
	private String purchase_udt_dt;	
	
	/**
	 * 삭제여부
	 */
	private boolean purchase_isdeleted;
	
	/**
	 * 신청자 이름(추가)
	 */
	private String user_nm;
	
	public PurchaseReq(){}
	
	public PurchaseReq(int board_content_seq, String purchase_req_isbn, String purchase_req_book_nm,
			String purchase_req_publisher, String purchase_req_author, String purchase_req_reason,
			String purchase_req_state, String purchase_req_dt, String purchase_req_id, String purchase_udt_id,
			String purchase_ins_dt, String purchase_udt_dt, boolean purchase_isdeleted) {
		super();
		this.board_content_seq = board_content_seq;
		this.purchase_req_isbn = purchase_req_isbn;
		this.purchase_req_book_nm = purchase_req_book_nm;
		this.purchase_req_publisher = purchase_req_publisher;
		this.purchase_req_author = purchase_req_author;
		this.purchase_req_reason = purchase_req_reason;
		this.purchase_req_state = purchase_req_state;
		this.purchase_req_dt = purchase_req_dt;
		this.purchase_req_id = purchase_req_id;
		this.purchase_udt_id = purchase_udt_id;
		this.purchase_ins_dt = purchase_ins_dt;
		this.purchase_udt_dt = purchase_udt_dt;
		this.purchase_isdeleted = purchase_isdeleted;
	}
	
	/**
	 * @Desc : 
	 * @param board_content_seq
	 * @param purchase_req_isbn
	 * @param purchase_req_book_nm
	 * @param purchase_req_publisher
	 * @param purchase_req_author
	 * @param purchase_req_reason
	 * @param purchase_req_state
	 * @param purchase_req_dt
	 * @param purchase_req_id
	 * @param purchase_udt_id
	 * @param purchase_ins_dt
	 * @param purchase_udt_dt
	 * @param purchase_isdeleted
	 * @param user_nm
	 */
	public PurchaseReq(int board_content_seq, String purchase_req_isbn, String purchase_req_book_nm,
			String purchase_req_publisher, String purchase_req_author, String purchase_req_reason,
			String purchase_req_state, String purchase_req_dt, String purchase_req_id, String purchase_udt_id,
			String purchase_ins_dt, String purchase_udt_dt, boolean purchase_isdeleted, String user_nm) {
		super();
		this.board_content_seq = board_content_seq;
		this.purchase_req_isbn = purchase_req_isbn;
		this.purchase_req_book_nm = purchase_req_book_nm;
		this.purchase_req_publisher = purchase_req_publisher;
		this.purchase_req_author = purchase_req_author;
		this.purchase_req_reason = purchase_req_reason;
		this.purchase_req_state = purchase_req_state;
		this.purchase_req_dt = purchase_req_dt;
		this.purchase_req_id = purchase_req_id;
		this.purchase_udt_id = purchase_udt_id;
		this.purchase_ins_dt = purchase_ins_dt;
		this.purchase_udt_dt = purchase_udt_dt;
		this.purchase_isdeleted = purchase_isdeleted;
		this.user_nm = user_nm;
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
	 * @return the purchase_req_isbn
	 */
	public String getPurchase_req_isbn() {
		return purchase_req_isbn;
	}



	/**
	 * @param purchase_req_isbn the purchase_req_isbn to set
	 */
	public void setPurchase_req_isbn(String purchase_req_isbn) {
		this.purchase_req_isbn = purchase_req_isbn;
	}



	/**
	 * @return the purchase_req_book_nm
	 */
	public String getPurchase_req_book_nm() {
		return purchase_req_book_nm;
	}



	/**
	 * @param purchase_req_book_nm the purchase_req_book_nm to set
	 */
	public void setPurchase_req_book_nm(String purchase_req_book_nm) {
		this.purchase_req_book_nm = purchase_req_book_nm;
	}



	/**
	 * @return the purchase_req_publisher
	 */
	public String getPurchase_req_publisher() {
		return purchase_req_publisher;
	}



	/**
	 * @param purchase_req_publisher the purchase_req_publisher to set
	 */
	public void setPurchase_req_publisher(String purchase_req_publisher) {
		this.purchase_req_publisher = purchase_req_publisher;
	}



	/**
	 * @return the purchase_req_author
	 */
	public String getPurchase_req_author() {
		return purchase_req_author;
	}



	/**
	 * @param purchase_req_author the purchase_req_author to set
	 */
	public void setPurchase_req_author(String purchase_req_author) {
		this.purchase_req_author = purchase_req_author;
	}



	/**
	 * @return the purchase_req_reason
	 */
	public String getPurchase_req_reason() {
		return purchase_req_reason;
	}



	/**
	 * @param purchase_req_reason the purchase_req_reason to set
	 */
	public void setPurchase_req_reason(String purchase_req_reason) {
		this.purchase_req_reason = purchase_req_reason;
	}



	/**
	 * @return the purchase_req_state
	 */
	public String getPurchase_req_state() {
		return purchase_req_state;
	}



	/**
	 * @param purchase_req_state the purchase_req_state to set
	 */
	public void setPurchase_req_state(String purchase_req_state) {
		this.purchase_req_state = purchase_req_state;
	}



	/**
	 * @return the purchase_req_dt
	 */
	public String getPurchase_req_dt() {
		return purchase_req_dt;
	}



	/**
	 * @param purchase_req_dt the purchase_req_dt to set
	 */
	public void setPurchase_req_dt(String purchase_req_dt) {
		this.purchase_req_dt = purchase_req_dt;
	}



	/**
	 * @return the purchase_req_id
	 */
	public String getPurchase_req_id() {
		return purchase_req_id;
	}



	/**
	 * @param purchase_req_id the purchase_req_id to set
	 */
	public void setPurchase_req_id(String purchase_req_id) {
		this.purchase_req_id = purchase_req_id;
	}



	/**
	 * @return the purchase_udt_id
	 */
	public String getPurchase_udt_id() {
		return purchase_udt_id;
	}



	/**
	 * @param purchase_udt_id the purchase_udt_id to set
	 */
	public void setPurchase_udt_id(String purchase_udt_id) {
		this.purchase_udt_id = purchase_udt_id;
	}



	/**
	 * @return the purchase_ins_dt
	 */
	public String getPurchase_ins_dt() {
		return purchase_ins_dt;
	}



	/**
	 * @param purchase_ins_dt the purchase_ins_dt to set
	 */
	public void setPurchase_ins_dt(String purchase_ins_dt) {
		this.purchase_ins_dt = purchase_ins_dt;
	}



	/**
	 * @return the purchase_udt_dt
	 */
	public String getPurchase_udt_dt() {
		return purchase_udt_dt;
	}



	/**
	 * @param purchase_udt_dt the purchase_udt_dt to set
	 */
	public void setPurchase_udt_dt(String purchase_udt_dt) {
		this.purchase_udt_dt = purchase_udt_dt;
	}



	/**
	 * @return the purchase_isdeleted
	 */
	public boolean isPurchase_isdeleted() {
		return purchase_isdeleted;
	}



	/**
	 * @param purchase_isdeleted the purchase_isdeleted to set
	 */
	public void setPurchase_isdeleted(boolean purchase_isdeleted) {
		this.purchase_isdeleted = purchase_isdeleted;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "PurchaseReq [board_content_seq=" + board_content_seq + ", purchase_req_isbn=" + purchase_req_isbn
				+ ", purchase_req_book_nm=" + purchase_req_book_nm + ", purchase_req_publisher="
				+ purchase_req_publisher + ", purchase_req_author=" + purchase_req_author + ", purchase_req_reason="
				+ purchase_req_reason + ", purchase_req_state=" + purchase_req_state + ", purchase_req_dt="
				+ purchase_req_dt + ", purchase_req_id=" + purchase_req_id + ", purchase_udt_id=" + purchase_udt_id
				+ ", purchase_ins_dt=" + purchase_ins_dt + ", purchase_udt_dt=" + purchase_udt_dt
				+ ", purchase_isdeleted=" + purchase_isdeleted + ", user_nm=" + user_nm + "]";
	}

	
}
