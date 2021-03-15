/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

/**
 * @Author : 김준영
 * @Date : 2019. 2. 14.
 * @Class 설명 : FAP 공지사항
 * 
 */
public class SocietyFapAdminNoticeContent {

	private int fap_notice_seq;
	
	private int board_content_seq;
	
	private String fap_notice_view_target_ck;
	
	private String fap_notice_kind;

	public SocietyFapAdminNoticeContent() {
		super();
	}

	public SocietyFapAdminNoticeContent(int fap_notice_seq, int board_content_seq, String fap_notice_view_target_ck,
			String fap_notice_kind) {
		super();
		this.fap_notice_seq = fap_notice_seq;
		this.board_content_seq = board_content_seq;
		this.fap_notice_view_target_ck = fap_notice_view_target_ck;
		this.fap_notice_kind = fap_notice_kind;
	}

	public int getFap_notice_seq() {
		return fap_notice_seq;
	}

	public void setFap_notice_seq(int fap_notice_seq) {
		this.fap_notice_seq = fap_notice_seq;
	}

	public int getBoard_content_seq() {
		return board_content_seq;
	}

	public void setBoard_content_seq(int board_content_seq) {
		this.board_content_seq = board_content_seq;
	}

	public String getFap_notice_view_target_ck() {
		return fap_notice_view_target_ck;
	}

	public void setFap_notice_view_target_ck(String fap_notice_view_target_ck) {
		this.fap_notice_view_target_ck = fap_notice_view_target_ck;
	}

	public String getFap_notice_kind() {
		return fap_notice_kind;
	}

	public void setFap_notice_kind(String fap_notice_kind) {
		this.fap_notice_kind = fap_notice_kind;
	}

	@Override
	public String toString() {
		return "SocietyFapAdminNoticeContent [fap_notice_seq=" + fap_notice_seq + ", board_content_seq="
				+ board_content_seq + ", fap_notice_view_target_ck=" + fap_notice_view_target_ck + ", fap_notice_kind="
				+ fap_notice_kind + "]";
	}
	
}
