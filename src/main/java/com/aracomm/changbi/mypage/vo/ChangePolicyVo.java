package com.aracomm.changbi.mypage.vo;

public class ChangePolicyVo {
	private int id;
	private int delayCourseDay = 0;
	private int delayTrainDay = 0;
	private int cancelCourseDay = 0;
	private int cancelTrainDay = 0;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getDelayCourseDay() {
		return delayCourseDay;
	}
	public void setDelayCourseDay(int delayCourseDay) {
		this.delayCourseDay = delayCourseDay;
	}
	public int getDelayTrainDay() {
		return delayTrainDay;
	}
	public void setDelayTrainDay(int delayTrainDay) {
		this.delayTrainDay = delayTrainDay;
	}
	public int getCancelCourseDay() {
		return cancelCourseDay;
	}
	public void setCancelCourseDay(int cancelCourseDay) {
		this.cancelCourseDay = cancelCourseDay;
	}
	public int getCancelTrainDay() {
		return cancelTrainDay;
	}
	public void setCancelTrainDay(int cancelTrainDay) {
		this.cancelTrainDay = cancelTrainDay;
	}

	@Override
	public String toString() {
		return "ChangePolicyVo [id=" + id + ", delayCourseDay=" + delayCourseDay + ", delayTrainDay=" + delayTrainDay
				+ ", cancelCourseDay=" + cancelCourseDay + ", cancelTrainDay=" + cancelTrainDay + "]";
	}
}
