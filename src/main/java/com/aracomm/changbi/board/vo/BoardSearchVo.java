package com.aracomm.changbi.board.vo;

import com.aracomm.changbi.common.base.BaseSearchVo;

public class BoardSearchVo extends BaseSearchVo {
	private String board_type;
	private String notice_type;
	private String course_id;
	private String teacher_id;
	private String cardinal_id;
	private int top;

	public String getBoard_type() {
		return board_type;
	}
	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}
	public String getNotice_type() {
		return notice_type;
	}
	public void setNotice_type(String notice_type) {
		this.notice_type = notice_type;
	}
	public String getCourse_id() {
		return course_id;
	}
	public void setCourse_id(String course_id) {
		this.course_id = course_id;
	}
	public String getTeacher_id() {
		return teacher_id;
	}
	public void setTeacher_id(String teacher_id) {
		this.teacher_id = teacher_id;
	}
	public String getCardinal_id() {
		return cardinal_id;
	}
	public void setCardinal_id(String cardinal_id) {
		this.cardinal_id = cardinal_id;
	}
	public int getTop() {
		return top;
	}
	public void setTop(int top) {
		this.top = top;
	}

}
