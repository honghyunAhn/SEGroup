package com.aracomm.changbi.mypage.vo;

public class SurveyVo {
	private String survey_id;
	private String item_id;
	private String item_type;
	private String exam;
	private String exam1_yn="N";
	private String exam2_yn="N";
	private String exam3_yn="N";
	private String exam4_yn="N";
	private String exam5_yn="N";
	private String exam6_yn="N";
	private String exam7_yn="N";
	private String exam1;
	private String exam2;
	private String exam3;
	private String exam4;
	private String exam5;
	private String exam6;
	private String exam7;
	private String answer;
	private String order_num;
	private String use_yn;
	private String reg_user;
	private String reg_date;
	private String upd_user;
	private String upd_date;
	private String cardinal_id;
	private String course_id;
	private String learn_app_id;

	public void operate() {
		if(this.exam == null) return;

		if (this.exam.equals("1")) {
			this.setExam1_yn("Y");
		} else if (this.exam.equals("2")) {
			this.setExam2_yn("Y");
		} else if (this.exam.equals("3")) {
			this.setExam3_yn("Y");
		} else if (this.exam.equals("4")) {
			this.setExam4_yn("Y");
		} else if (this.exam.equals("5")) {
			this.setExam5_yn("Y");
		} else if (this.exam.equals("6")) {
			this.setExam6_yn("Y");
		} else if (this.exam.equals("7")) {
			this.setExam7_yn("Y");
		}
	}

	public String getCardinal_id() {
		return cardinal_id;
	}
	public void setCardinal_id(String cardinal_id) {
		this.cardinal_id = cardinal_id;
	}
	public String getCourse_id() {
		return course_id;
	}
	public void setCourse_id(String course_id) {
		this.course_id = course_id;
	}
	public String getLearn_app_id() {
		return learn_app_id;
	}
	public void setLearn_app_id(String learn_app_id) {
		this.learn_app_id = learn_app_id;
	}
	public String getSurvey_id() {
		return survey_id;
	}
	public void setSurvey_id(String survey_id) {
		this.survey_id = survey_id;
	}
	public String getItem_id() {
		return item_id;
	}
	public void setItem_id(String item_id) {
		this.item_id = item_id;
	}
	public String getItem_type() {
		return item_type;
	}
	public void setItem_type(String item_type) {
		this.item_type = item_type;
	}
	public String getExam() {
		return exam;
	}
	public void setExam(String exam) {
		this.exam = exam;
	}
	public String getExam1_yn() {
		return exam1_yn;
	}
	public void setExam1_yn(String exam1_yn) {
		this.exam1_yn = exam1_yn;
	}
	public String getExam2_yn() {
		return exam2_yn;
	}
	public void setExam2_yn(String exam2_yn) {
		this.exam2_yn = exam2_yn;
	}
	public String getExam3_yn() {
		return exam3_yn;
	}
	public void setExam3_yn(String exam3_yn) {
		this.exam3_yn = exam3_yn;
	}
	public String getExam4_yn() {
		return exam4_yn;
	}
	public void setExam4_yn(String exam4_yn) {
		this.exam4_yn = exam4_yn;
	}
	public String getExam5_yn() {
		return exam5_yn;
	}
	public void setExam5_yn(String exam5_yn) {
		this.exam5_yn = exam5_yn;
	}
	public String getExam6_yn() {
		return exam6_yn;
	}
	public void setExam6_yn(String exam6_yn) {
		this.exam6_yn = exam6_yn;
	}
	public String getExam7_yn() {
		return exam7_yn;
	}
	public void setExam7_yn(String exam7_yn) {
		this.exam7_yn = exam7_yn;
	}
	public String getExam1() {
		return exam1;
	}
	public void setExam1(String exam1) {
		this.exam1 = exam1;
	}
	public String getExam2() {
		return exam2;
	}
	public void setExam2(String exam2) {
		this.exam2 = exam2;
	}
	public String getExam3() {
		return exam3;
	}
	public void setExam3(String exam3) {
		this.exam3 = exam3;
	}
	public String getExam4() {
		return exam4;
	}
	public void setExam4(String exam4) {
		this.exam4 = exam4;
	}
	public String getExam5() {
		return exam5;
	}
	public void setExam5(String exam5) {
		this.exam5 = exam5;
	}
	public String getExam6() {
		return exam6;
	}
	public void setExam6(String exam6) {
		this.exam6 = exam6;
	}
	public String getExam7() {
		return exam7;
	}
	public void setExam7(String exam7) {
		this.exam7 = exam7;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getOrder_num() {
		return order_num;
	}
	public void setOrder_num(String order_num) {
		this.order_num = order_num;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getReg_user() {
		return reg_user;
	}
	public void setReg_user(String reg_user) {
		this.reg_user = reg_user;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getUpd_user() {
		return upd_user;
	}
	public void setUpd_user(String upd_user) {
		this.upd_user = upd_user;
	}
	public String getUpd_date() {
		return upd_date;
	}
	public void setUpd_date(String upd_date) {
		this.upd_date = upd_date;
	}

	@Override
	public String toString() {
		return "SurveyVo [survey_id=" + survey_id + ", item_id=" + item_id + ", item_type=" + item_type + ", exam="
				+ exam + ", exam1_yn=" + exam1_yn + ", exam2_yn=" + exam2_yn + ", exam3_yn=" + exam3_yn + ", exam4_yn="
				+ exam4_yn + ", exam5_yn=" + exam5_yn + ", exam6_yn=" + exam6_yn + ", exam7_yn=" + exam7_yn + ", exam1="
				+ exam1 + ", exam2=" + exam2 + ", exam3=" + exam3 + ", exam4=" + exam4 + ", exam5=" + exam5 + ", exam6="
				+ exam6 + ", exam7=" + exam7 + ", answer=" + answer + ", order_num=" + order_num + ", use_yn=" + use_yn
				+ ", reg_user=" + reg_user + ", reg_date=" + reg_date + ", upd_user=" + upd_user + ", upd_date="
				+ upd_date + ", cardinal_id=" + cardinal_id + ", course_id=" + course_id + ", learn_app_id="
				+ learn_app_id + "]";
	}
}
