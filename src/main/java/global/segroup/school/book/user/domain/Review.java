/**
 * 
 */
package global.segroup.school.book.user.domain;

/**
 * @Author : 서민수
 * @Date : 2017. 7. 26.
 * @Class 설명 : SES 도서관 리뷰 클래스
 * 
 */
public class Review {
	/**
	 * 공통 게시판 게시물 테이블 시퀀스
	 */
	private int board_content_seq;	
	
	/**
	 * 리뷰 작성자 id
	 */
	private String review_id;	
	
	/**
	 * 리뷰 작석한 책의 isbn
	 */
	private String bookinfo_isbn;	
	
	/**
	 * 리뷰 내용
	 */
	private String review_contents;

	/**
	 * 별점 (0~10)
	 */
	private int review_score;				
	
	/**
	 * 삭제여부
	 */
	private boolean review_isdeleted;
	
	/**
	 * 등록 날짜
	 */
	private String review_ins_dt;
	
	/**
	 * 수저어 날짜
	 */
	private String review_udt_dt;
	
	public Review(){}

	public Review(int board_content_seq, String review_id, String bookinfo_isbn, String review_contents,
			int review_score, boolean review_isdeleted, String review_ins_dt, String review_udt_dt) {
		super();
		this.board_content_seq = board_content_seq;
		this.review_id = review_id;
		this.bookinfo_isbn = bookinfo_isbn;
		this.review_contents = review_contents;
		this.review_score = review_score;
		this.review_isdeleted = review_isdeleted;
		this.review_ins_dt = review_ins_dt;
		this.review_udt_dt = review_udt_dt;
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
	 * @return the review_id
	 */
	public String getReview_id() {
		return review_id;
	}



	/**
	 * @param review_id the review_id to set
	 */
	public void setReview_id(String review_id) {
		this.review_id = review_id;
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
	 * @return the review_contents
	 */
	public String getReview_contents() {
		return review_contents;
	}



	/**
	 * @param review_contents the review_contents to set
	 */
	public void setReview_contents(String review_contents) {
		this.review_contents = review_contents;
	}



	/**
	 * @return the review_score
	 */
	public int getReview_score() {
		return review_score;
	}



	/**
	 * @param review_score the review_score to set
	 */
	public void setReview_score(int review_score) {
		this.review_score = review_score;
	}



	/**
	 * @return the review_isdeleted
	 */
	public boolean isReview_isdeleted() {
		return review_isdeleted;
	}



	/**
	 * @param review_isdeleted the review_isdeleted to set
	 */
	public void setReview_isdeleted(boolean review_isdeleted) {
		this.review_isdeleted = review_isdeleted;
	}



	/**
	 * @return the review_ins_dt
	 */
	public String getReview_ins_dt() {
		return review_ins_dt;
	}



	/**
	 * @param review_ins_dt the review_ins_dt to set
	 */
	public void setReview_ins_dt(String review_ins_dt) {
		this.review_ins_dt = review_ins_dt;
	}



	/**
	 * @return the review_udt_dt
	 */
	public String getReview_udt_dt() {
		return review_udt_dt;
	}



	/**
	 * @param review_udt_dt the review_udt_dt to set
	 */
	public void setReview_udt_dt(String review_udt_dt) {
		this.review_udt_dt = review_udt_dt;
	}



	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Review [board_content_seq=" + board_content_seq + ", review_id=" + review_id + ", bookinfo_isbn="
				+ bookinfo_isbn + ", review_contents=" + review_contents + ", review_score=" + review_score
				+ ", review_isdeleted=" + review_isdeleted + ", review_ins_dt=" + review_ins_dt + ", review_udt_dt="
				+ review_udt_dt + "]";
	}
	
}
