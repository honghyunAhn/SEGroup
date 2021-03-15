/**
 * 
 */
package global.segroup.school.book.admin.domain;

/**
 * @Author : 서민수
 * @Date : 2017. 7. 26.
 * @Class 설명 : SES 도서관 책 정보 클래스
 * 
 */
public class BookInfo {

	/**
	 * 이미지 파일 저장 경로
	 */
	private String board_file_saved;

	/**
	 * 이미지 파일 원본 파일 이름
	 */
	private String board_file_origin;

	/**
	 * 책의 isbn
	 */
	private String bookinfo_isbn;

	/**
	 * 공통 게시판 게시물 테이블 시퀀스
	 */
	private int board_content_seq;

	/**
	 * 공통 파일 테이블 세퀀스
	 */
	private int board_file_seq;

	/**
	 * 책의 대분류(공통 코드)
	 */
	private String bookinfo_category;

	/**
	 * 책의 소분류(공통 코드)
	 */
	private String bookinfo_division;

	/**
	 * 책의 이름
	 */
	private String bookinfo_book_nm;

	/**
	 * 책의 출판사
	 */
	private String bookinfo_publisher;

	/**
	 * 책의 저자
	 */
	private String bookinfo_author;

	/**
	 * 책의 발행일
	 */
	private String bookinfo_published_dt;

	/**
	 * 책의 수량
	 */
	private int bookinfo_quantity;

	/**
	 * 연장 가능 여부
	 */
	private boolean bookinfo_extendable;

	/**
	 * 대여 가능 여부
	 */
	private boolean bookinfo_rentable;

	/**
	 * 삭제 여부
	 */
	private boolean bookinfo_isdeleted;

	/**
	 * 수정 id
	 */
	private String bookinfo_udt_id;

	/**
	 * 등록 id
	 */
	private String bookinfo_ins_id;

	/**
	 * 등록 날짜
	 */
	private String bookinfo_ins_dt;

	/**
	 * 수정 날짜
	 */
	private String bookinfo_udt_dt;

	public BookInfo() {

	}
	

	public BookInfo(String bookinfo_isbn, int board_content_seq, int board_file_seq, String board_file_saved,
			String board_file_origin, String bookinfo_category, String bookinfo_division, String bookinfo_book_nm,
			String bookinfo_publisher, String bookinfo_author, String bookinfo_published_dt, int bookinfo_quantity,
			boolean bookinfo_extendable, boolean bookinfo_rentable, boolean bookinfo_isdeleted, String bookinfo_udt_id,
			String bookinfo_ins_id, String bookinfo_ins_dt, String bookinfo_udt_dt) {
		super();
		this.bookinfo_isbn = bookinfo_isbn;
		this.board_content_seq = board_content_seq;
		this.board_file_seq = board_file_seq;
		this.board_file_saved = board_file_saved;
		this.board_file_origin = board_file_origin;
		this.bookinfo_category = bookinfo_category;
		this.bookinfo_division = bookinfo_division;
		this.bookinfo_book_nm = bookinfo_book_nm;
		this.bookinfo_publisher = bookinfo_publisher;
		this.bookinfo_author = bookinfo_author;
		this.bookinfo_published_dt = bookinfo_published_dt;
		this.bookinfo_quantity = bookinfo_quantity;
		this.bookinfo_extendable = bookinfo_extendable;
		this.bookinfo_rentable = bookinfo_rentable;
		this.bookinfo_isdeleted = bookinfo_isdeleted;
		this.bookinfo_udt_id = bookinfo_udt_id;
		this.bookinfo_ins_id = bookinfo_ins_id;
		this.bookinfo_ins_dt = bookinfo_ins_dt;
		this.bookinfo_udt_dt = bookinfo_udt_dt;
	}

	/**
	 * @return the bookinfo_isbn
	 */
	public String getBookinfo_isbn() {
		return bookinfo_isbn;
	}

	/**
	 * @param bookinfo_isbn
	 *            the bookinfo_isbn to set
	 */
	public void setBookinfo_isbn(String bookinfo_isbn) {
		this.bookinfo_isbn = bookinfo_isbn;
	}

	/**
	 * @return the board_content_seq
	 */
	public int getBoard_content_seq() {
		return board_content_seq;
	}

	/**
	 * @param board_content_seq
	 *            the board_content_seq to set
	 */
	public void setBoard_content_seq(int board_content_seq) {
		this.board_content_seq = board_content_seq;
	}

	/**
	 * @return the board_file_seq
	 */
	public int getBoard_file_seq() {
		return board_file_seq;
	}

	/**
	 * @param board_file_seq
	 *            the board_file_seq to set
	 */
	public void setBoard_file_seq(int board_file_seq) {
		this.board_file_seq = board_file_seq;
	}

	/**
	 * @return the board_file_saved
	 */
	public String getBoard_file_saved() {
		return board_file_saved;
	}

	/**
	 * @param board_file_saved
	 *            the board_file_saved to set
	 */
	public void setBoard_file_saved(String board_file_saved) {
		this.board_file_saved = board_file_saved;
	}

	/**
	 * @return the board_file_origin
	 */
	public String getBoard_file_origin() {
		return board_file_origin;
	}

	/**
	 * @param board_file_origin
	 *            the board_file_origin to set
	 */
	public void setBoard_file_origin(String board_file_origin) {
		this.board_file_origin = board_file_origin;
	}

	/**
	 * @return the bookinfo_category
	 */
	public String getBookinfo_category() {
		return bookinfo_category;
	}

	/**
	 * @param bookinfo_category
	 *            the bookinfo_category to set
	 */
	public void setBookinfo_category(String bookinfo_category) {
		this.bookinfo_category = bookinfo_category;
	}

	/**
	 * @return the bookinfo_division
	 */
	public String getBookinfo_division() {
		return bookinfo_division;
	}

	/**
	 * @param bookinfo_division
	 *            the bookinfo_division to set
	 */
	public void setBookinfo_division(String bookinfo_division) {
		this.bookinfo_division = bookinfo_division;
	}

	/**
	 * @return the bookinfo_book_nm
	 */
	public String getBookinfo_book_nm() {
		return bookinfo_book_nm;
	}

	/**
	 * @param bookinfo_book_nm
	 *            the bookinfo_book_nm to set
	 */
	public void setBookinfo_book_nm(String bookinfo_book_nm) {
		this.bookinfo_book_nm = bookinfo_book_nm;
	}

	/**
	 * @return the bookinfo_publisher
	 */
	public String getBookinfo_publisher() {
		return bookinfo_publisher;
	}

	/**
	 * @param bookinfo_publisher
	 *            the bookinfo_publisher to set
	 */
	public void setBookinfo_publisher(String bookinfo_publisher) {
		this.bookinfo_publisher = bookinfo_publisher;
	}

	/**
	 * @return the bookinfo_author
	 */
	public String getBookinfo_author() {
		return bookinfo_author;
	}

	/**
	 * @param bookinfo_author
	 *            the bookinfo_author to set
	 */
	public void setBookinfo_author(String bookinfo_author) {
		this.bookinfo_author = bookinfo_author;
	}

	/**
	 * @return the bookinfo_published_dt
	 */
	public String getBookinfo_published_dt() {
		return bookinfo_published_dt;
	}

	/**
	 * @param bookinfo_published_dt
	 *            the bookinfo_published_dt to set
	 */
	public void setBookinfo_published_dt(String bookinfo_published_dt) {
		this.bookinfo_published_dt = bookinfo_published_dt;
	}

	/**
	 * @return the bookinfo_quantity
	 */
	public int getBookinfo_quantity() {
		return bookinfo_quantity;
	}

	/**
	 * @param bookinfo_quantity
	 *            the bookinfo_quantity to set
	 */
	public void setBookinfo_quantity(int bookinfo_quantity) {
		this.bookinfo_quantity = bookinfo_quantity;
	}

	/**
	 * @return the bookinfo_extendable
	 */
	public boolean isBookinfo_extendable() {
		return bookinfo_extendable;
	}

	/**
	 * @param bookinfo_extendable
	 *            the bookinfo_extendable to set
	 */
	public void setBookinfo_extendable(boolean bookinfo_extendable) {
		this.bookinfo_extendable = bookinfo_extendable;
	}

	/**
	 * @return the bookinfo_rentable
	 */
	public boolean isBookinfo_rentable() {
		return bookinfo_rentable;
	}

	/**
	 * @param bookinfo_rentable
	 *            the bookinfo_rentable to set
	 */
	public void setBookinfo_rentable(boolean bookinfo_rentable) {
		this.bookinfo_rentable = bookinfo_rentable;
	}

	/**
	 * @return the bookinfo_isdeleted
	 */
	public boolean isBookinfo_isdeleted() {
		return bookinfo_isdeleted;
	}

	/**
	 * @param bookinfo_isdeleted
	 *            the bookinfo_isdeleted to set
	 */
	public void setBookinfo_isdeleted(boolean bookinfo_isdeleted) {
		this.bookinfo_isdeleted = bookinfo_isdeleted;
	}

	/**
	 * @return the bookinfo_udt_id
	 */
	public String getBookinfo_udt_id() {
		return bookinfo_udt_id;
	}

	/**
	 * @param bookinfo_udt_id
	 *            the bookinfo_udt_id to set
	 */
	public void setBookinfo_udt_id(String bookinfo_udt_id) {
		this.bookinfo_udt_id = bookinfo_udt_id;
	}

	/**
	 * @return the bookinfo_ins_id
	 */
	public String getBookinfo_ins_id() {
		return bookinfo_ins_id;
	}

	/**
	 * @param bookinfo_ins_id
	 *            the bookinfo_ins_id to set
	 */
	public void setBookinfo_ins_id(String bookinfo_ins_id) {
		this.bookinfo_ins_id = bookinfo_ins_id;
	}

	/**
	 * @return the bookinfo_ins_dt
	 */
	public String getBookinfo_ins_dt() {
		return bookinfo_ins_dt;
	}

	/**
	 * @param bookinfo_ins_dt
	 *            the bookinfo_ins_dt to set
	 */
	public void setBookinfo_ins_dt(String bookinfo_ins_dt) {
		this.bookinfo_ins_dt = bookinfo_ins_dt;
	}

	/**
	 * @return the bookinfo_udt_dt
	 */
	public String getBookinfo_udt_dt() {
		return bookinfo_udt_dt;
	}

	/**
	 * @param bookinfo_udt_dt
	 *            the bookinfo_udt_dt to set
	 */
	public void setBookinfo_udt_dt(String bookinfo_udt_dt) {
		this.bookinfo_udt_dt = bookinfo_udt_dt;
	}

	@Override
	public String toString() {
		return "BookInfo [bookinfo_isbn=" + bookinfo_isbn + ", board_content_seq=" + board_content_seq
				+ ", board_file_seq=" + board_file_seq + ", board_file_saved=" + board_file_saved
				+ ", board_file_origin=" + board_file_origin + ", bookinfo_category=" + bookinfo_category
				+ ", bookinfo_division=" + bookinfo_division + ", bookinfo_book_nm=" + bookinfo_book_nm
				+ ", bookinfo_publisher=" + bookinfo_publisher + ", bookinfo_author=" + bookinfo_author
				+ ", bookinfo_published_dt=" + bookinfo_published_dt + ", bookinfo_quantity=" + bookinfo_quantity
				+ ", bookinfo_extendable=" + bookinfo_extendable + ", bookinfo_rentable=" + bookinfo_rentable
				+ ", bookinfo_isdeleted=" + bookinfo_isdeleted + ", bookinfo_udt_id=" + bookinfo_udt_id
				+ ", bookinfo_ins_id=" + bookinfo_ins_id + ", bookinfo_ins_dt=" + bookinfo_ins_dt + ", bookinfo_udt_dt="
				+ bookinfo_udt_dt + "]";
	}

}
