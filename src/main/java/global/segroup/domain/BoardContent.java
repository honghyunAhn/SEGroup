/**
 * 
 */
package global.segroup.domain;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 20.
 * @Class 설명 : 공통 게시판 게시물 클래스
 * 
 */
public class BoardContent {
	/**
	 * 공통 게시판 게시물 시퀀스
	 */
	private int board_content_seq;
	
	/**
	 * 공통 게시판 시퀀스 ( BoardGroup 클래스 board_seq 참조 ) 
	 */
	private int board_seq;
	
	/**
	 * 공통 게시판 게시물 제목
	 */
	private String board_content_title;
	
	/**
	 * 공통 게시판 게시물 내용
	 */
	private String board_content_ct;
	
	/**
	 * 공통 게시판 게시물 작성자 
	 */
	private String board_content_nm;
	
	/**
	 * 공통 게시판 게시물 조회수
	 */
	private int board_content_hit;
	
	/**
	 * 중요게시물
	 */
	private String board_content_imp;
	
	/**
	 * 게시판 타입
	 */
	private String board_tp;
	
	/**
	 * 게시판 구분
	 */
	private String board_gb;	
	
	/**
	 * 공통 게시판 게시물 등록 일자 
	 */
	private String board_content_ins_dt;
	
	/**
	 * 공통 게시판 게시물 등록인 
	 */
	private String board_content_ins_id;
	
	/**
	 * 공통 게시판 게시물 수정 일자
	 */
	private String board_content_udt_dt;
	
	/**
	 * 공통 게시판 게시물 수정인 
	 */
	private String board_content_udt_id;

	public BoardContent() {
		super();
	}

	/**
	 * @Desc : 
	 * @param board_content_seq
	 * @param board_seq
	 * @param board_content_title
	 * @param board_content_ct
	 * @param board_content_nm
	 * @param board_content_hit
	 * @param board_content_imp
	 * @param board_tp
	 * @param board_gb
	 * @param board_content_ins_dt
	 * @param board_content_ins_id
	 * @param board_content_udt_dt
	 * @param board_content_udt_id
	 */
	public BoardContent(int board_content_seq, int board_seq, String board_content_title, String board_content_ct,
			String board_content_nm, int board_content_hit, String board_content_imp, String board_tp, String board_gb,
			String board_content_ins_dt, String board_content_ins_id, String board_content_udt_dt,
			String board_content_udt_id) {
		super();
		this.board_content_seq = board_content_seq;
		this.board_seq = board_seq;
		this.board_content_title = board_content_title;
		this.board_content_ct = board_content_ct;
		this.board_content_nm = board_content_nm;
		this.board_content_hit = board_content_hit;
		this.board_content_imp = board_content_imp;
		this.board_tp = board_tp;
		this.board_gb = board_gb;
		this.board_content_ins_dt = board_content_ins_dt;
		this.board_content_ins_id = board_content_ins_id;
		this.board_content_udt_dt = board_content_udt_dt;
		this.board_content_udt_id = board_content_udt_id;
	}

	public int getBoard_content_seq() {
		return board_content_seq;
	}

	public void setBoard_content_seq(int board_content_seq) {
		this.board_content_seq = board_content_seq;
	}

	public int getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}

	public String getBoard_content_title() {
		return board_content_title;
	}

	public void setBoard_content_title(String board_content_title) {
		this.board_content_title = board_content_title;
	}

	public String getBoard_content_ct() {
		return board_content_ct;
	}

	public void setBoard_content_ct(String board_content_ct) {
		this.board_content_ct = board_content_ct;
	}

	public String getBoard_content_nm() {
		return board_content_nm;
	}

	public void setBoard_content_nm(String board_content_nm) {
		this.board_content_nm = board_content_nm;
	}

	public int getBoard_content_hit() {
		return board_content_hit;
	}

	public void setBoard_content_hit(int board_content_hit) {
		this.board_content_hit = board_content_hit;
	}

	public String getBoard_content_imp() {
		return board_content_imp;
	}

	public void setBoard_content_imp(String board_content_imp) {
		this.board_content_imp = board_content_imp;
	}

	public String getBoard_tp() {
		return board_tp;
	}

	public void setBoard_tp(String board_tp) {
		this.board_tp = board_tp;
	}

	public String getBoard_gb() {
		return board_gb;
	}

	public void setBoard_gb(String board_gb) {
		this.board_gb = board_gb;
	}

	public String getBoard_content_ins_dt() {
		return board_content_ins_dt;
	}

	public void setBoard_content_ins_dt(String board_content_ins_dt) {
		this.board_content_ins_dt = board_content_ins_dt;
	}

	public String getBoard_content_ins_id() {
		return board_content_ins_id;
	}

	public void setBoard_content_ins_id(String board_content_ins_id) {
		this.board_content_ins_id = board_content_ins_id;
	}

	public String getBoard_content_udt_dt() {
		return board_content_udt_dt;
	}

	public void setBoard_content_udt_dt(String board_content_udt_dt) {
		this.board_content_udt_dt = board_content_udt_dt;
	}

	public String getBoard_content_udt_id() {
		return board_content_udt_id;
	}

	public void setBoard_content_udt_id(String board_content_udt_id) {
		this.board_content_udt_id = board_content_udt_id;
	}

	@Override
	public String toString() {
		return "BoardContent [board_content_seq=" + board_content_seq + ", board_seq=" + board_seq
				+ ", board_content_title=" + board_content_title + ", board_content_ct=" + board_content_ct
				+ ", board_content_nm=" + board_content_nm + ", board_content_hit=" + board_content_hit
				+ ", board_content_imp=" + board_content_imp + ", board_tp=" + board_tp + ", board_gb=" + board_gb
				+ ", board_content_ins_dt=" + board_content_ins_dt + ", board_content_ins_id=" + board_content_ins_id
				+ ", board_content_udt_dt=" + board_content_udt_dt + ", board_content_udt_id=" + board_content_udt_id
				+ "]";
	}
	
	
	
	
}
