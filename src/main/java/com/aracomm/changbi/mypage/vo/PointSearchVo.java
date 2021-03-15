package com.aracomm.changbi.mypage.vo;

import com.aracomm.base.common.util.CommonUtil;

public class PointSearchVo {
	private String user_id;

	private int pointStartPage;
	private int pointVisiblePages = 2;
	private int pointTotalCnt;

	private int couponStartPage;
	private int couponVisiblePages = 2;
	private int couponTotalCnt;

	private int course_id;

	public int getPointSkipRows() {
		return pointStartPage == 0 ? 0 : (pointStartPage-1) * pointVisiblePages;
	}

	public int getPointTotalPages() {
		return CommonUtil.getTotalPage(pointTotalCnt, pointVisiblePages).intValue();
	}

	public int getCouponSkipRows() {
		return couponStartPage == 0 ? 0 : (couponStartPage-1) * couponVisiblePages;
	}

	public int getCouponTotalPages() {
		return CommonUtil.getTotalPage(couponTotalCnt, couponVisiblePages).intValue();
	}

	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getPointStartPage() {
		return pointStartPage == 0 ? 1: pointStartPage;
	}
	public void setPointStartPage(int pointStartPage) {
		this.pointStartPage = pointStartPage;
	}
	public int getPointVisiblePages() {
		return pointVisiblePages;
	}
	public void setPointVisiblePages(int pointVisiblePages) {
		this.pointVisiblePages = pointVisiblePages;
	}
	public int getPointTotalCnt() {
		return pointTotalCnt;
	}
	public void setPointTotalCnt(int pointTotalCnt) {
		this.pointTotalCnt = pointTotalCnt;
	}
	public int getCouponStartPage() {
		return couponStartPage == 0 ? 1 : couponStartPage;
	}
	public void setCouponStartPage(int couponStartPage) {
		this.couponStartPage = couponStartPage;
	}
	public int getCouponVisiblePages() {
		return couponVisiblePages;
	}
	public void setCouponVisiblePages(int couponVisiblePages) {
		this.couponVisiblePages = couponVisiblePages;
	}
	public int getCouponTotalCnt() {
		return couponTotalCnt;
	}
	public void setCouponTotalCnt(int couponTotalCnt) {
		this.couponTotalCnt = couponTotalCnt;
	}

	public int getCourse_id() {
		return course_id;
	}

	public void setCourse_id(int course_id) {
		this.course_id = course_id;
	}

}
