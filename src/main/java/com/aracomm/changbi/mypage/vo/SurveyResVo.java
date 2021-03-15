package com.aracomm.changbi.mypage.vo;

import java.util.List;

public class SurveyResVo {
	private String user_id;
	private String cardinal;
	private String course;
	private String learn_app_id;
	private List<SurveyVo> survey;

	public String getLearn_app_id() {
		return learn_app_id;
	}
	public void setLearn_app_id(String learn_app_id) {
		this.learn_app_id = learn_app_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getCardinal() {
		return cardinal;
	}
	public void setCardinal(String cardinal) {
		this.cardinal = cardinal;
	}
	public String getCourse() {
		return course;
	}
	public void setCourse(String course) {
		this.course = course;
	}
	public List<SurveyVo> getSurvey() {
		return survey;
	}
	public void setSurvey(List<SurveyVo> survey) {
		this.survey = survey;
	}
	public void operate() {
		for (SurveyVo surveyVo : survey) {
			surveyVo.operate();
			surveyVo.setCardinal_id(this.cardinal);
			surveyVo.setCourse_id(this.course);
			surveyVo.setLearn_app_id(this.learn_app_id);
			surveyVo.setReg_user(this.user_id);
			surveyVo.setUpd_user(this.user_id);
		}
	}
	@Override
	public String toString() {
		return "SurveyResVo [user_id=" + user_id + ", cardinal=" + cardinal + ", course=" + course + ", survey="
				+ survey + "]";
	}
}
