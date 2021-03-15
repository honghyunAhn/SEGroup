package com.aracomm.changbi.mypage.vo;

import com.aracomm.changbi.common.base.BaseSearchVo;

public class NoteSearchVo extends BaseSearchVo {
	private String user_id;
	private String gubun;
	private String [] ids;

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getGubun() {
		return gubun;
	}

	public void setGubun(String gubun) {
		this.gubun = gubun;
	}

	public String[] getIds() {
		return ids;
	}

	public void setIds(String[] ids) {
		this.ids = ids;
	}


}
