/**
 * 
 */
package global.segroup.school.book.user.domain;

/**
 * @Author : 서민수
 * @Date : 2017. 7. 26.
 * @Class 설명 : SES 도서관 북마크(찜) 클래스
 * 
 */
public class BookMark {
	/**
	 * 북마크 추가한 사람의 아이디
	 */
	private String bookmark_id;		
	
	/**
	 * 책의 isbn
	 */
	private String bookinfo_isbn; 	
	
	/**
	 * 등록 날짜
	 */
	private String bookmark_ins_dt;
	
	public BookMark(){}

	public BookMark(String bookmark_id, String bookinfo_isbn, String bookmark_ins_dt) {
		super();
		this.bookmark_id = bookmark_id;
		this.bookinfo_isbn = bookinfo_isbn;
		this.bookmark_ins_dt = bookmark_ins_dt;
	}

	
	
	/**
	 * @return the bookmark_id
	 */
	public String getBookmark_id() {
		return bookmark_id;
	}



	/**
	 * @param bookmark_id the bookmark_id to set
	 */
	public void setBookmark_id(String bookmark_id) {
		this.bookmark_id = bookmark_id;
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
	 * @return the bookmark_ins_dt
	 */
	public String getBookmark_ins_dt() {
		return bookmark_ins_dt;
	}



	/**
	 * @param bookmark_ins_dt the bookmark_ins_dt to set
	 */
	public void setBookmark_ins_dt(String bookmark_ins_dt) {
		this.bookmark_ins_dt = bookmark_ins_dt;
	}



	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "BookMark [bookmark_id=" + bookmark_id + ", bookinfo_isbn=" + bookinfo_isbn + ", bookmark_ins_dt="
				+ bookmark_ins_dt + "]";
	}	
	
	
}
