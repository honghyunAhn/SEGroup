/**
 * 
 */
package global.segroup.society.smtp.apply.domain;

import java.util.List;

/**
 * @Author : 김성미
 * @Date : 2020. 8. 5.
 * @Class 설명 : Society 지원신청서 자기소개  정보
 * 
 */
public class SocietyStuApplyIntroduce {

	/**
	 * 자기소개 정보 시퀀스
	 */
	private int stu_app_introduce_seq;
	
	/**
	 * 지원 신청서 시퀀스
	 */
	private int stu_app_seq;
	
	/**
	 * 자기소개 제목
	 */
	private String stu_app_introduce_title;
	
	/**
	 * 자기소개 내용
	 */
	private String stu_app_introduce_detail;
	
	/**
	 * 등록인
	 */
	private String stu_app_introduce_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String stu_app_introduce_ins_dt;
	
	/**
	 * 수정인
	 */
	private String stu_app_introduce_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String stu_app_introduce_udt_dt;
	
	/**
	 * 지원신청서 자기소개 정보 리스트
	 */
	private List<SocietyStuApplyIntroduce> introduceList;

	public SocietyStuApplyIntroduce() {
		super();
	}

	public SocietyStuApplyIntroduce(int stu_app_introduce_seq, int stu_app_seq, String stu_app_introduce_title,
			String stu_app_introduce_detail, String stu_app_introduce_ins_id, String stu_app_introduce_ins_dt,
			String stu_app_introduce_udt_id, String stu_app_introduce_udt_dt,
			List<SocietyStuApplyIntroduce> introduceList) {
		super();
		this.stu_app_introduce_seq = stu_app_introduce_seq;
		this.stu_app_seq = stu_app_seq;
		this.stu_app_introduce_title = stu_app_introduce_title;
		this.stu_app_introduce_detail = stu_app_introduce_detail;
		this.stu_app_introduce_ins_id = stu_app_introduce_ins_id;
		this.stu_app_introduce_ins_dt = stu_app_introduce_ins_dt;
		this.stu_app_introduce_udt_id = stu_app_introduce_udt_id;
		this.stu_app_introduce_udt_dt = stu_app_introduce_udt_dt;
		this.introduceList = introduceList;
	}

	public int getStu_app_introduce_seq() {
		return stu_app_introduce_seq;
	}

	public void setStu_app_introduce_seq(int stu_app_introduce_seq) {
		this.stu_app_introduce_seq = stu_app_introduce_seq;
	}

	public int getStu_app_seq() {
		return stu_app_seq;
	}

	public void setStu_app_seq(int stu_app_seq) {
		this.stu_app_seq = stu_app_seq;
	}

	public String getStu_app_introduce_title() {
		return stu_app_introduce_title;
	}

	public void setStu_app_introduce_title(String stu_app_introduce_title) {
		this.stu_app_introduce_title = stu_app_introduce_title;
	}

	public String getStu_app_introduce_detail() {
		return stu_app_introduce_detail;
	}

	public void setStu_app_introduce_detail(String stu_app_introduce_detail) {
		this.stu_app_introduce_detail = stu_app_introduce_detail;
	}

	public String getStu_app_introduce_ins_id() {
		return stu_app_introduce_ins_id;
	}

	public void setStu_app_introduce_ins_id(String stu_app_introduce_ins_id) {
		this.stu_app_introduce_ins_id = stu_app_introduce_ins_id;
	}

	public String getStu_app_introduce_ins_dt() {
		return stu_app_introduce_ins_dt;
	}

	public void setStu_app_introduce_ins_dt(String stu_app_introduce_ins_dt) {
		this.stu_app_introduce_ins_dt = stu_app_introduce_ins_dt;
	}

	public String getStu_app_introduce_udt_id() {
		return stu_app_introduce_udt_id;
	}

	public void setStu_app_introduce_udt_id(String stu_app_introduce_udt_id) {
		this.stu_app_introduce_udt_id = stu_app_introduce_udt_id;
	}

	public String getStu_app_introduce_udt_dt() {
		return stu_app_introduce_udt_dt;
	}

	public void setStu_app_introduce_udt_dt(String stu_app_introduce_udt_dt) {
		this.stu_app_introduce_udt_dt = stu_app_introduce_udt_dt;
	}

	public List<SocietyStuApplyIntroduce> getIntroduceList() {
		return introduceList;
	}

	public void setIntroduceList(List<SocietyStuApplyIntroduce> introduceList) {
		this.introduceList = introduceList;
	}
	
}
