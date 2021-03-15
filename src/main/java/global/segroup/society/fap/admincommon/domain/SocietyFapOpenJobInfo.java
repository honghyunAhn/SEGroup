/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

/**
 * @Author : 김경아
 * @Date : 2019. 6. 26.
 * @Class 설명 : 오픈잡페어 취업정보 & 전략 정보
 * 
 */
public class SocietyFapOpenJobInfo {

	/*
	 *취업정보&전략 게시판 일련번호
	 */
	private int fap_open_job_info_seq;
	
	/*
	 * 게시물일련번호
	 */
	private int board_content_seq;
	
	/*
	 * 공개여부,대상 
	 */
	private String fap_open_job_info_view_target_ck;
	
	/*
	 * 공지종류 
	 */
	private String fap_open_job_info_kind;

	/*
	 *검색-작성자 
	 */
	private String searchNm;
	
	/*
	 * 검색-제목
	 */
	private String searchTitle;
		
	public SocietyFapOpenJobInfo() {
		super();
	}

	public SocietyFapOpenJobInfo(int fap_open_job_info_seq, int board_content_seq,
			String fap_open_job_info_view_target_ck, String fap_open_job_info_kind) {
		super();
		this.fap_open_job_info_seq = fap_open_job_info_seq;
		this.board_content_seq = board_content_seq;
		this.fap_open_job_info_view_target_ck = fap_open_job_info_view_target_ck;
		this.fap_open_job_info_kind = fap_open_job_info_kind;
	}

	public int getFap_open_job_info_seq() {
		return fap_open_job_info_seq;
	}

	public void setFap_open_job_info_seq(int fap_open_job_info_seq) {
		this.fap_open_job_info_seq = fap_open_job_info_seq;
	}

	public int getBoard_content_seq() {
		return board_content_seq;
	}

	public void setBoard_content_seq(int board_content_seq) {
		this.board_content_seq = board_content_seq;
	}

	public String getFap_open_job_info_view_target_ck() {
		return fap_open_job_info_view_target_ck;
	}

	public void setFap_open_job_info_view_target_ck(String fap_open_job_info_view_target_ck) {
		this.fap_open_job_info_view_target_ck = fap_open_job_info_view_target_ck;
	}

	public String getFap_open_job_info_kind() {
		return fap_open_job_info_kind;
	}

	public void setFap_open_job_info_kind(String fap_open_job_info_kind) {
		this.fap_open_job_info_kind = fap_open_job_info_kind;
	}
	
	public String getSearchNm() {
		return searchNm;
	}

	
	public void setSearchNm(String searchNm) {
		this.searchNm = searchNm;
	}

	
	public String getSearchTitle() {
		return searchTitle;
	}

	public void setSearchTitle(String searchTitle) {
		this.searchTitle = searchTitle;
	}
	

	@Override
	public String toString() {
		return "SocietyFapOpenJobInfo [fap_open_job_info_seq=" + fap_open_job_info_seq + ", board_content_seq="
				+ board_content_seq + ", fap_open_job_info_view_target_ck=" + fap_open_job_info_view_target_ck
				+ ", fap_open_job_info_kind=" + fap_open_job_info_kind + "]";
	}



	
	
	
	
}
