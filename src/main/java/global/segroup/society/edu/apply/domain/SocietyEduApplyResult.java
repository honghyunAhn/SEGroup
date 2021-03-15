/**
 * 
 */
package global.segroup.society.edu.apply.domain;

/**
 * @Author : 이종호
 * @Date : 2017. 8. 24.
 * @Class 설명 : 
 * 
 */
public class SocietyEduApplyResult {
	
	/**
	 * 지원신청 결과 시퀀스
	 */
	private int app_rt_seq;
	
	/**
	 * 지원신청서 시퀀스
	 */
	private int app_seq;
	
	/**
	 * 서류 결과 (공통코드)
	 */
	private String app_rt_doc;
	
	/**
	 * 서류 결과 처리 담당자
	 */
	private String app_rt_doc_id;
	
	/**
	 * 서류 결과 처리일
	 */
	private String app_rt_doc_dt;
	
	/**
	 * 면접 결과 (공통코드)
	 */
	private String app_rt_itv;
	
	/**
	 * 면접 결과 처리 담당자
	 */
	private String app_rt_itv_id;
	
	/**
	 * 면접 결과 처리일
	 */
	private String app_rt_itv_dt;
	
	public SocietyEduApplyResult() {
		super();
	}

	public SocietyEduApplyResult(int app_rt_seq, int app_seq, String app_rt_doc, String app_rt_doc_id,
			String app_rt_doc_dt, String app_rt_itv, String app_rt_itv_id, String app_rt_itv_dt) {
		super();
		this.app_rt_seq = app_rt_seq;
		this.app_seq = app_seq;
		this.app_rt_doc = app_rt_doc;
		this.app_rt_doc_id = app_rt_doc_id;
		this.app_rt_doc_dt = app_rt_doc_dt;
		this.app_rt_itv = app_rt_itv;
		this.app_rt_itv_id = app_rt_itv_id;
		this.app_rt_itv_dt = app_rt_itv_dt;
	}

	public int getApp_rt_seq() {
		return app_rt_seq;
	}

	public void setApp_rt_seq(int app_rt_seq) {
		this.app_rt_seq = app_rt_seq;
	}

	public int getApp_seq() {
		return app_seq;
	}

	public void setApp_seq(int app_seq) {
		this.app_seq = app_seq;
	}

	public String getApp_rt_doc() {
		return app_rt_doc;
	}

	public void setApp_rt_doc(String app_rt_doc) {
		this.app_rt_doc = app_rt_doc;
	}

	public String getApp_rt_doc_id() {
		return app_rt_doc_id;
	}

	public void setApp_rt_doc_id(String app_rt_doc_id) {
		this.app_rt_doc_id = app_rt_doc_id;
	}

	public String getApp_rt_doc_dt() {
		return app_rt_doc_dt;
	}

	public void setApp_rt_doc_dt(String app_rt_doc_dt) {
		this.app_rt_doc_dt = app_rt_doc_dt;
	}

	public String getApp_rt_itv() {
		return app_rt_itv;
	}

	public void setApp_rt_itv(String app_rt_itv) {
		this.app_rt_itv = app_rt_itv;
	}

	public String getApp_rt_itv_id() {
		return app_rt_itv_id;
	}

	public void setApp_rt_itv_id(String app_rt_itv_id) {
		this.app_rt_itv_id = app_rt_itv_id;
	}

	public String getApp_rt_itv_dt() {
		return app_rt_itv_dt;
	}

	public void setApp_rt_itv_dt(String app_rt_itv_dt) {
		this.app_rt_itv_dt = app_rt_itv_dt;
	}

	@Override
	public String toString() {
		return "SocietyEduApplyResult [app_rt_seq=" + app_rt_seq + ", app_seq=" + app_seq + ", app_rt_doc=" + app_rt_doc
				+ ", app_rt_doc_id=" + app_rt_doc_id + ", app_rt_doc_dt=" + app_rt_doc_dt + ", app_rt_itv=" + app_rt_itv
				+ ", app_rt_itv_id=" + app_rt_itv_id + ", app_rt_itv_dt=" + app_rt_itv_dt + "]";
	}
	
}
