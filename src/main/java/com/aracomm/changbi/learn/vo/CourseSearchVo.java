package com.aracomm.changbi.learn.vo;

import com.aracomm.changbi.common.base.BaseSearchVo;

public class CourseSearchVo extends BaseSearchVo {
	private String main_display;
	private String icon_displays;
	private String course;
	private String credit;
	private String sort;
	private String gubun;	// 추천구분
	private String newYn;

	public String getMain_display() {
		return main_display;
	}
	public void setMain_display(String main_display) {
		this.main_display = main_display;
	}
	public String getIcon_displays() {
		return icon_displays;
	}
	public void setIcon_displays(String icon_displays) {
		this.icon_displays = icon_displays;
	}
	public String getCourse() {
		return course;
	}
	public void setCourse(String course) {
		this.course = course;
	}
	public String getCredit() {
		return credit;
	}
	public void setCredit(String credit) {
		this.credit = credit;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getNewYn() {
		return newYn;
	}
	public void setNewYn(String newYn) {
		this.newYn = newYn;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}


}
