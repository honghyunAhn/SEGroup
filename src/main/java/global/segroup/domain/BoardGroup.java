/**
 * 
 */
package global.segroup.domain;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 20.
 * @Class 설명 : 공통 게시판 그룹 클래스
 * 
 */
public class BoardGroup {
	
	/**
	 * 공통 게시판 시퀀스
	 */
	private int board_seq;
	
	/**
	 * 공통 게시판 구분 (FS, 도서관리, 모집홍보 ...)
	 */
	private String board_gb;
	
	/**
	 * 공통 게시판 이름 
	 */
	private String board_nm;
	
	/**
	 * 공통 게시판 타입 (공지알림 , 동영상 , 사진 ... ) 
	 */
	private String board_tp;
	
	/**
	 * 공통 게시판 등록인
	 */
	private String board_ins_id;
	
	/**
	 * 공통 게시판 등록 일자 
	 */
	private String board_ins_dt;
	
	/**
	 * 공통 게시판 수정인
	 */
	private String board_udt_id;
	
	/**
	 * 공통 게시판 수정일자
	 */
	private String board_ud_dt;

	/**
	 * 공통 게시판 갱신아이콘 표시기간; 2018. 12. 4. 김준영
	 */
	private int board_icon_pd;
	
	/*
	 * 공통게시판 게시판 세부 구분; 2019. 07. 31. 김경아 
	 */
	private String board_detail_gb;

	
	public BoardGroup() {
		super();
	}

	public BoardGroup(int board_seq, String board_gb, String board_nm, String board_tp, String board_ins_id,
			String board_ins_dt, String board_udt_id, String board_ud_dt, int board_icon_pd, String board_detail_gb) {
		super();
		this.board_seq = board_seq;
		this.board_gb = board_gb;
		this.board_nm = board_nm;
		this.board_tp = board_tp;
		this.board_ins_id = board_ins_id;
		this.board_ins_dt = board_ins_dt;
		this.board_udt_id = board_udt_id;
		this.board_ud_dt = board_ud_dt;
		this.board_icon_pd = board_icon_pd;
		this.board_detail_gb = board_detail_gb;
	}

	public int getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}

	public String getBoard_gb() {
		return board_gb;
	}

	public void setBoard_gb(String board_gb) {
		this.board_gb = board_gb;
	}

	public String getBoard_nm() {
		return board_nm;
	}

	public void setBoard_nm(String board_nm) {
		this.board_nm = board_nm;
	}

	public String getBoard_tp() {
		return board_tp;
	}

	public void setBoard_tp(String board_tp) {
		this.board_tp = board_tp;
	}

	public String getBoard_ins_id() {
		return board_ins_id;
	}

	public void setBoard_ins_id(String board_ins_id) {
		this.board_ins_id = board_ins_id;
	}

	public String getBoard_ins_dt() {
		return board_ins_dt;
	}

	public void setBoard_ins_dt(String board_ins_dt) {
		this.board_ins_dt = board_ins_dt;
	}

	public String getBoard_udt_id() {
		return board_udt_id;
	}

	public void setBoard_udt_id(String board_udt_id) {
		this.board_udt_id = board_udt_id;
	}

	public String getBoard_ud_dt() {
		return board_ud_dt;
	}

	public void setBoard_ud_dt(String board_ud_dt) {
		this.board_ud_dt = board_ud_dt;
	}

	public int getBoard_icon_pd() {
		return board_icon_pd;
	}

	public void setBoard_icon_pd(int board_icon_pd) {
		this.board_icon_pd = board_icon_pd;
	}

	public String getBoard_detail_gb() {
		return board_detail_gb;
	}

	public void setBoard_detail_gb(String board_detail_gb) {
		this.board_detail_gb = board_detail_gb;
	}
	

	
}
