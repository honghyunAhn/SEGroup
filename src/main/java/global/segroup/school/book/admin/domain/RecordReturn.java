/**
 * 
 */
package global.segroup.school.book.admin.domain;

/**
 * @Author : 선희경
 * @Date : 2017. 7. 28.
 * @Class 설명 :
 * 
 */
public class RecordReturn {

	/**
	 * 누적 도서 신청상태
	 */
	private String rental_rtn_state;

	/**
	 * 누적 도서 신청상태 - 카운트
	 */
	private String rental_rtn_state_cnt;

	/**
	 * @Desc :
	 */
	public RecordReturn() {
		super();
	}

	/**
	 * @Desc : 
	 * @param rental_rtn_state
	 * @param rental_rtn_state_cnt
	 */
	public RecordReturn(String rental_rtn_state, String rental_rtn_state_cnt) {
		super();
		this.rental_rtn_state = rental_rtn_state;
		this.rental_rtn_state_cnt = rental_rtn_state_cnt;
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
	 * @return the rental_rtn_state_cnt
	 */
	public String getRental_rtn_state_cnt() {
		return rental_rtn_state_cnt;
	}

	/**
	 * @param rental_rtn_state_cnt the rental_rtn_state_cnt to set
	 */
	public void setRental_rtn_state_cnt(String rental_rtn_state_cnt) {
		this.rental_rtn_state_cnt = rental_rtn_state_cnt;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "RecordReturn [rental_rtn_state=" + rental_rtn_state + ", rental_rtn_state_cnt=" + rental_rtn_state_cnt
				+ "]";
	}

	

}
