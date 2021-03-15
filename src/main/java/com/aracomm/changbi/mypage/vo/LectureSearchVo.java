package com.aracomm.changbi.mypage.vo;

import com.aracomm.changbi.common.base.BaseSearchVo;

public class LectureSearchVo extends BaseSearchVo {
	private String user_id;
	private String learn_type;

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getLearn_type() {
		return learn_type;
	}

	public void setLearn_type(String learn_type) {
		this.learn_type = learn_type;
	}

	@Override
	public String toString() {
		return "LectureSearchVo [getUser_id()=" + getUser_id() + ", getLearn_type()=" + getLearn_type()
				+ ", getSkipRows()=" + getSkipRows() + ", getTotalPages()=" + getTotalPages() + ", getStartPage()="
				+ getStartPage() + ", getId()=" + getId() + ", getSearchKeyword()=" + getSearchKeyword()
				+ ", getSearchCondition()=" + getSearchCondition() + ", getVisiblePages()=" + getVisiblePages()
				+ ", getTotalCnt()=" + getTotalCnt() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}


}
