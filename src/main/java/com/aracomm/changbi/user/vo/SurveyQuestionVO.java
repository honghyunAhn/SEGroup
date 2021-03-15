package com.aracomm.changbi.user.vo;

public class SurveyQuestionVO {
	private int survey_question_seq;
	private int survey_seq;
	private int survey_type_seq;
	private int survey_number;
	private String survey_question;
	private String survey_answer_sample;
	
	public SurveyQuestionVO() {
		super();
	}

	public SurveyQuestionVO(int survey_question_seq, int survey_seq, int survey_type_seq, int survey_number,
			String survey_question, String survey_answer_sample) {
		super();
		this.survey_question_seq = survey_question_seq;
		this.survey_seq = survey_seq;
		this.survey_type_seq = survey_type_seq;
		this.survey_number = survey_number;
		this.survey_question = survey_question;
		this.survey_answer_sample = survey_answer_sample;
	}

	public int getSurvey_question_seq() {
		return survey_question_seq;
	}

	public void setSurvey_question_seq(int survey_question_seq) {
		this.survey_question_seq = survey_question_seq;
	}

	public int getSurvey_seq() {
		return survey_seq;
	}

	public void setSurvey_seq(int survey_seq) {
		this.survey_seq = survey_seq;
	}

	public int getSurvey_type_seq() {
		return survey_type_seq;
	}

	public void setSurvey_type_seq(int survey_type_seq) {
		this.survey_type_seq = survey_type_seq;
	}

	public int getSurvey_number() {
		return survey_number;
	}

	public void setSurvey_number(int survey_number) {
		this.survey_number = survey_number;
	}

	public String getSurvey_question() {
		return survey_question;
	}

	public void setSurvey_question(String survey_question) {
		this.survey_question = survey_question;
	}

	public String getSurvey_answer_sample() {
		return survey_answer_sample;
	}

	public void setSurvey_answer_sample(String survey_answer_sample) {
		this.survey_answer_sample = survey_answer_sample;
	}

	@Override
	public String toString() {
		return "SurveyQuestionVO [survey_question_seq=" + survey_question_seq + ", survey_seq=" + survey_seq
				+ ", survey_type_seq=" + survey_type_seq + ", survey_number=" + survey_number + ", survey_question="
				+ survey_question + ", survey_answer_sample=" + survey_answer_sample + "]";
	}
	
}
