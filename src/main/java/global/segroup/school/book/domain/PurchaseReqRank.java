/**
 * 
 */
package global.segroup.school.book.domain;

/**
 * @Author : 선희경
 * @Date : 2017. 8. 1
 * @Class 설명 : SES 도서관 구매신청 - 통계 클래스
 * 
 */
public class PurchaseReqRank extends PurchaseReq {

	public int purchase_req_cnt;

	public PurchaseReqRank() {
	}

	/**
	 * @return the purchase_req_cnt
	 */
	public int getPurchase_req_cnt() {
		return purchase_req_cnt;
	}

	/**
	 * @param purchase_req_cnt
	 *            the purchase_req_cnt to set
	 */
	public void setPurchase_req_cnt(int purchase_req_cnt) {
		this.purchase_req_cnt = purchase_req_cnt;
	}

	/**
	 * @Desc :
	 * @param purchase_req_cnt
	 */
	public PurchaseReqRank(int purchase_req_cnt) {
		super();
		this.purchase_req_cnt = purchase_req_cnt;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return super.toString() + " + Rank [purchase_req_cnt=" + purchase_req_cnt + "]";
	}

}
