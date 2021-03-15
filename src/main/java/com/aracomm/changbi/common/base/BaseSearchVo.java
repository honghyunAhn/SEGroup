package com.aracomm.changbi.common.base;

import com.aracomm.base.common.util.CommonUtil;

public class BaseSearchVo {
	/** 기본 검색 항목 **/
	private String id;
	private String searchKeyword;
	private String searchCondition;

	/** paging **/
	private int startPage;
	private int visiblePages = 10;
	private int totalCnt;
	private String searchall;

	public int getSkipRows() {
		return startPage == 0 ? 0 : (startPage-1) * visiblePages;
	}

	public int getTotalPages() {
		return CommonUtil.getTotalPage(totalCnt, visiblePages).intValue();
	}
	public int getStartPage() {
		return startPage == 0 ? 1 : startPage;
	}


	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getVisiblePages() {
		return visiblePages;
	}
	public void setVisiblePages(int visiblePages) {
		this.visiblePages = visiblePages;
	}
	public int getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}

	public String getSearchall() {
		return searchall;
	}

	public void setSearchall(String searchall) {
		this.searchall = searchall;
	}


}
