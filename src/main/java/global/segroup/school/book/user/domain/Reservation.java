/**
 * 
 */
package global.segroup.school.book.user.domain;

/**
 * @Author : 서민수
 * @Date : 2017. 7. 26.
 * @Class 설명 : 도서 예약 클래스
 * 
 */
public class Reservation {
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
	 * BOOK_RESERVATION_TB 테이블 시퀀스
	 */
	private int reservation_seq;		
	
	/**
	 * 예약한 사용자 id
	 */
	private String reservation_id;		
	
	/**
	 * 예약한 날짜
	 */
	private String reservation_dt;		
	
	/**
	 * 예약 상태
	 */
	private String reservation_state;			
	
	/**
	 * 등록 날짜
	 */
	private String reservation_ins_dt;	
	
	/**
	 * 수정 날짜
	 */
	private String reservation_udt_dt;


	
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
	 * @return the reservation_seq
	 */
	public int getReservation_seq() {
		return reservation_seq;
	}

	/**
	 * @param reservation_seq the reservation_seq to set
	 */
	public void setReservation_seq(int reservation_seq) {
		this.reservation_seq = reservation_seq;
	}

	/**
	 * @return the reservation_id
	 */
	public String getReservation_id() {
		return reservation_id;
	}

	/**
	 * @param reservation_id the reservation_id to set
	 */
	public void setReservation_id(String reservation_id) {
		this.reservation_id = reservation_id;
	}

	/**
	 * @return the reservation_dt
	 */
	public String getReservation_dt() {
		return reservation_dt;
	}

	/**
	 * @param reservation_dt the reservation_dt to set
	 */
	public void setReservation_dt(String reservation_dt) {
		this.reservation_dt = reservation_dt;
	}

	/**
	 * @return the reservation_state
	 */
	public String getReservation_state() {
		return reservation_state;
	}

	/**
	 * @param reservation_state the reservation_state to set
	 */
	public void setReservation_state(String reservation_state) {
		this.reservation_state = reservation_state;
	}

	/**
	 * @return the reservation_ins_dt
	 */
	public String getReservation_ins_dt() {
		return reservation_ins_dt;
	}

	/**
	 * @param reservation_ins_dt the reservation_ins_dt to set
	 */
	public void setReservation_ins_dt(String reservation_ins_dt) {
		this.reservation_ins_dt = reservation_ins_dt;
	}

	/**
	 * @return the reservation_udt_dt
	 */
	public String getReservation_udt_dt() {
		return reservation_udt_dt;
	}

	/**
	 * @param reservation_udt_dt the reservation_udt_dt to set
	 */
	public void setReservation_udt_dt(String reservation_udt_dt) {
		this.reservation_udt_dt = reservation_udt_dt;
	}

	public Reservation(){}
	
	public Reservation(int board_content_seq, int book_seq, int rental_seq, int reservation_seq, String reservation_id,
			String reservation_dt, String reservation_state, String reservation_ins_dt, String reservation_udt_dt) {
		super();
		this.board_content_seq = board_content_seq;
		this.book_seq = book_seq;
		this.rental_seq = rental_seq;
		this.reservation_seq = reservation_seq;
		this.reservation_id = reservation_id;
		this.reservation_dt = reservation_dt;
		this.reservation_state = reservation_state;
		this.reservation_ins_dt = reservation_ins_dt;
		this.reservation_udt_dt = reservation_udt_dt;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Reservation [board_content_seq=" + board_content_seq + ", book_seq=" + book_seq + ", rental_seq="
				+ rental_seq + ", reservation_seq=" + reservation_seq + ", reservation_id=" + reservation_id
				+ ", reservation_dt=" + reservation_dt + ", reservation_state=" + reservation_state
				+ ", reservation_ins_dt=" + reservation_ins_dt + ", reservation_udt_dt=" + reservation_udt_dt + "]";
	}
	
	
}
