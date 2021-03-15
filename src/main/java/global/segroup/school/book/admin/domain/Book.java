/**
 * 
 */
package global.segroup.school.book.admin.domain;

/**
 * @Author : 서민수
 * @Date : 2017. 7. 26.
 * @Class 설명 : SES 도서관  책 각각에 대한 클래스
 * 
 */
public class Book {
	/**
	 * 공통 게시판 게시물 테이블 시퀀스
	 */
	private int board_content_seq;
	/**
	 * BOOK_BOOK_TB 테이블 시퀀스
	 */
	private int book_seq;
	/**
	 * 책의 isbn
	 */
	private String bookinfo_isbn;
	/**
	 * 책상태 코드 (공통 코드)
	 */
	private String book_bookstate;
	/**
	 * 책 라벨
	 */
	private String book_label;	
	/**
	 * 대여 가능 여부
	 */
	private boolean book_rentable;
	/**
	 * 삭제 여부
	 */
	private boolean book_isdelete;
	/**
	 * 수정 id
	 */
	private String book_udt_id;
	/**
	 * 등록 id
	 */
	private String book_ins_id;
	/**
	 * 등록일
	 */
	private String book_ins_dt;
	/**
	 * 수정일
	 */
	private String book_udt_dt;
	
	public Book(){
	}

	public Book(int board_content_seq, int book_seq, String bookinfo_isbn, String book_bookstate, String book_label,
			boolean book_rentable, boolean book_isdelete, String book_udt_id, String book_ins_id, String book_ins_dt,
			String book_udt_dt) {
		super();
		this.board_content_seq = board_content_seq;
		this.book_seq = book_seq;
		this.bookinfo_isbn = bookinfo_isbn;
		this.book_bookstate = book_bookstate;
		this.book_label = book_label;
		this.book_rentable = book_rentable;
		this.book_isdelete = book_isdelete;
		this.book_udt_id = book_udt_id;
		this.book_ins_id = book_ins_id;
		this.book_ins_dt = book_ins_dt;
		this.book_udt_dt = book_udt_dt;
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
	 * @return the bookinfo_isbn
	 */
	public String getBookinfo_isbn() {
		return bookinfo_isbn;
	}

	/**
	 * @param bookinfo_isbn the bookinfo_isbn to set
	 */
	public void setBookinfo_isbn(String bookinfo_isbn) {
		this.bookinfo_isbn = bookinfo_isbn;
	}

	/**
	 * @return the book_bookstate
	 */
	public String getBook_bookstate() {
		return book_bookstate;
	}

	/**
	 * @param book_bookstate the book_bookstate to set
	 */
	public void setBook_bookstate(String book_bookstate) {
		this.book_bookstate = book_bookstate;
	}

	/**
	 * @return the book_rentable
	 */
	public boolean isBook_rentable() {
		return book_rentable;
	}

	/**
	 * @param book_rentable the book_rentable to set
	 */
	public void setBook_rentable(boolean book_rentable) {
		this.book_rentable = book_rentable;
	}

	/**
	 * @return the book_isdelete
	 */
	public boolean isBook_isdelete() {
		return book_isdelete;
	}

	/**
	 * @param book_isdelete the book_isdelete to set
	 */
	public void setBook_isdelete(boolean book_isdelete) {
		this.book_isdelete = book_isdelete;
	}

	/**
	 * @return the book_udt_id
	 */
	public String getBook_udt_id() {
		return book_udt_id;
	}

	/**
	 * @param book_udt_id the book_udt_id to set
	 */
	public void setBook_udt_id(String book_udt_id) {
		this.book_udt_id = book_udt_id;
	}

	/**
	 * @return the book_ins_id
	 */
	public String getBook_ins_id() {
		return book_ins_id;
	}

	/**
	 * @param book_ins_id the book_ins_id to set
	 */
	public void setBook_ins_id(String book_ins_id) {
		this.book_ins_id = book_ins_id;
	}

	/**
	 * @return the book_ins_dt
	 */
	public String getBook_ins_dt() {
		return book_ins_dt;
	}

	/**
	 * @param book_ins_dt the book_ins_dt to set
	 */
	public void setBook_ins_dt(String book_ins_dt) {
		this.book_ins_dt = book_ins_dt;
	}

	/**
	 * @return the book_udt_dt
	 */
	public String getBook_udt_dt() {
		return book_udt_dt;
	}

	/**
	 * @param book_udt_dt the book_udt_dt to set
	 */
	public void setBook_udt_dt(String book_udt_dt) {
		this.book_udt_dt = book_udt_dt;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Book [board_content_seq=" + board_content_seq + ", book_seq=" + book_seq + ", bookinfo_isbn="
				+ bookinfo_isbn + ", book_bookstate=" + book_bookstate + ", book_rentable=" + book_rentable
				+ ", book_isdelete=" + book_isdelete + ", book_udt_id=" + book_udt_id + ", book_ins_id=" + book_ins_id
				+ ", book_ins_dt=" + book_ins_dt + ", book_udt_dt=" + book_udt_dt + "]";
	}	
	
}
