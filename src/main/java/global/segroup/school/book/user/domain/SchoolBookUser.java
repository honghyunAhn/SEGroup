/**
 * 
 */
package global.segroup.school.book.user.domain;

import global.segroup.domain.User;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 17.
 * @Class 설명 : Soft Engineer School 도서관리 유저 정보
 * 
 */
public class SchoolBookUser extends User {
	/**
	 * SCMaster 기수 정보
	 */
	private String gisu_num;
	
	/**
	 * 도서관리 회원 정보 등록 일자
	 */
	private String book_user_ins_dt;
	
	/**
	 * 도서관리 회원 정보 수정 일자
	 */
	private String book_user_udt_dt;
	
	/**
	 * 도서관리 회원 정보 등록인
	 */
	private String book_user_ins_id;
	
	/**
	 * 도서관리 회원 정보 수정인
	 */
	private String book_user_udt_id;
	
	

	public SchoolBookUser() {
		super();
	}



	public SchoolBookUser(String gisu_num, String book_user_ins_dt, String book_user_udt_dt, String book_user_ins_id,
			String book_user_udt_id) {
		super();
		this.gisu_num = gisu_num;
		this.book_user_ins_dt = book_user_ins_dt;
		this.book_user_udt_dt = book_user_udt_dt;
		this.book_user_ins_id = book_user_ins_id;
		this.book_user_udt_id = book_user_udt_id;
	}



	public String getGisu_num() {
		return gisu_num;
	}



	public void setGisu_num(String gisu_num) {
		this.gisu_num = gisu_num;
	}



	public String getBook_user_ins_dt() {
		return book_user_ins_dt;
	}



	public void setBook_user_ins_dt(String book_user_ins_dt) {
		this.book_user_ins_dt = book_user_ins_dt;
	}



	public String getBook_user_udt_dt() {
		return book_user_udt_dt;
	}



	public void setBook_user_udt_dt(String book_user_udt_dt) {
		this.book_user_udt_dt = book_user_udt_dt;
	}



	public String getBook_user_ins_id() {
		return book_user_ins_id;
	}



	public void setBook_user_ins_id(String book_user_ins_id) {
		this.book_user_ins_id = book_user_ins_id;
	}



	public String getBook_user_udt_id() {
		return book_user_udt_id;
	}



	public void setBook_user_udt_id(String book_user_udt_id) {
		this.book_user_udt_id = book_user_udt_id;
	}



	@Override
	public String toString() {
		return "SchoolBookUser [gisu_num=" + gisu_num + ", book_user_ins_dt=" + book_user_ins_dt + ", book_user_udt_dt="
				+ book_user_udt_dt + ", book_user_ins_id=" + book_user_ins_id + ", book_user_udt_id=" + book_user_udt_id
				+ ", getUser_id()=" + getUser_id() + ", getUser_pw()=" + getUser_pw() + ", getUser_nm()=" + getUser_nm()
				+ ", getUser_phone()=" + getUser_phone() + ", getUser_email()=" + getUser_email() + ", getUser_birth()="
				+ getUser_birth() + ", getUser_sex()=" + getUser_sex() + ", getUser_flag()=" + getUser_flag()
				+ ", getUser_state()=" + getUser_state() + "]";
	}

}
