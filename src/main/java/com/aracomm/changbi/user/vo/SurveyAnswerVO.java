package com.aracomm.changbi.user.vo;

public class SurveyAnswerVO {
	private int survey_answer_seq;
	private int survey_question_seq;
	private String user_id;
	private String survey_answer;
	private int survey_answer_choice;
	private boolean survey_answer_hide;
	
	public SurveyAnswerVO() {
		super();
	}

	public SurveyAnswerVO(int survey_answer_seq, int survey_question_seq, String user_id, String survey_answer,
			int survey_answer_choice, boolean survey_answer_hide) {
		super();
		this.survey_answer_seq = survey_answer_seq;
		this.survey_question_seq = survey_question_seq;
		this.user_id = user_id;
		this.survey_answer = survey_answer;
		this.survey_answer_choice = survey_answer_choice;
		this.survey_answer_hide = survey_answer_hide;
	}

	public int getSurvey_answer_seq() {
		return survey_answer_seq;
	}

	public void setSurvey_answer_seq(int survey_answer_seq) {
		this.survey_answer_seq = survey_answer_seq;
	}

	public int getSurvey_question_seq() {
		return survey_question_seq;
	}

	public void setSurvey_question_seq(int survey_question_seq) {
		this.survey_question_seq = survey_question_seq;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getSurvey_answer() {
		return survey_answer;
	}

	public void setSurvey_answer(String survey_answer) {
		this.survey_answer = survey_answer;
	}

	public int getSurvey_answer_choice() {
		return survey_answer_choice;
	}

	public void setSurvey_answer_choice(int survey_answer_choice) {
		this.survey_answer_choice = survey_answer_choice;
	}

	public boolean isSurvey_answer_hide() {
		return survey_answer_hide;
	}

	public void setSurvey_answer_hide(boolean survey_answer_hide) {
		this.survey_answer_hide = survey_answer_hide;
	}

	@Override
	public String toString() {
		return "SurveyAnswerVO [survey_answer_seq=" + survey_answer_seq + ", survey_question_seq=" + survey_question_seq
				+ ", user_id=" + user_id + ", survey_answer=" + survey_answer + ", survey_answer_choice="
				+ survey_answer_choice + ", survey_answer_hide=" + survey_answer_hide + "]";
	}
	
}
