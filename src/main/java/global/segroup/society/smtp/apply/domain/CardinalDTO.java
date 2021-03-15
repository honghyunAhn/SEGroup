package global.segroup.society.smtp.apply.domain;

public class CardinalDTO {
	private int seq;
	private String id; 
	private String name; 
	private String learn_type; 
	private String credits; 
	private String course_type; 
	private String app_start_date; 
	private String app_end_date; 
	private String learn_start_date; 
	private String learn_end_date; 
	private String issue_date; 
	private String att_eval_date; 
	private String att_eval_time; 
	private String att_exam_type;
	private int cancel;
	private int dup_limit; 
	private int add_exam_period; 
	private String open_results;
	private String app_possibles; 
	private String expect_exam; 
	private int preview;
	private String complate_yn; 
	private int order_num; 
	private String use_yn;
	private String reg_user;
	private String reg_date;
	private String upd_user;
	private String upd_date;
	private int comp_percent_quiz; 
	private int comp_percent_exam;
	private int comp_percent_prog;
	private int comp_score_quiz;
	private int comp_score_exam;
	private int comp_score_prog;
	private int complete_total;
	private int recruit;
	public CardinalDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CardinalDTO(int seq, String id, String name, String learn_type, String credits, String course_type,
			String app_start_date, String app_end_date, String learn_start_date, String learn_end_date,
			String issue_date, String att_eval_date, String att_eval_time, String att_exam_type, int cancel,
			int dup_limit, int add_exam_period, String open_results, String app_possibles, String expect_exam,
			int preview, String complate_yn, int order_num, String use_yn, String reg_user, String reg_date,
			String upd_user, String upd_date, int comp_percent_quiz, int comp_percent_exam, int comp_percent_prog,
			int comp_score_quiz, int comp_score_exam, int comp_score_prog, int complete_total, int recruit) {
		super();
		this.seq = seq;
		this.id = id;
		this.name = name;
		this.learn_type = learn_type;
		this.credits = credits;
		this.course_type = course_type;
		this.app_start_date = app_start_date;
		this.app_end_date = app_end_date;
		this.learn_start_date = learn_start_date;
		this.learn_end_date = learn_end_date;
		this.issue_date = issue_date;
		this.att_eval_date = att_eval_date;
		this.att_eval_time = att_eval_time;
		this.att_exam_type = att_exam_type;
		this.cancel = cancel;
		this.dup_limit = dup_limit;
		this.add_exam_period = add_exam_period;
		this.open_results = open_results;
		this.app_possibles = app_possibles;
		this.expect_exam = expect_exam;
		this.preview = preview;
		this.complate_yn = complate_yn;
		this.order_num = order_num;
		this.use_yn = use_yn;
		this.reg_user = reg_user;
		this.reg_date = reg_date;
		this.upd_user = upd_user;
		this.upd_date = upd_date;
		this.comp_percent_quiz = comp_percent_quiz;
		this.comp_percent_exam = comp_percent_exam;
		this.comp_percent_prog = comp_percent_prog;
		this.comp_score_quiz = comp_score_quiz;
		this.comp_score_exam = comp_score_exam;
		this.comp_score_prog = comp_score_prog;
		this.complete_total = complete_total;
		this.recruit = recruit;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLearn_type() {
		return learn_type;
	}
	public void setLearn_type(String learn_type) {
		this.learn_type = learn_type;
	}
	public String getCredits() {
		return credits;
	}
	public void setCredits(String credits) {
		this.credits = credits;
	}
	public String getCourse_type() {
		return course_type;
	}
	public void setCourse_type(String course_type) {
		this.course_type = course_type;
	}
	public String getApp_start_date() {
		return app_start_date;
	}
	public void setApp_start_date(String app_start_date) {
		this.app_start_date = app_start_date;
	}
	public String getApp_end_date() {
		return app_end_date;
	}
	public void setApp_end_date(String app_end_date) {
		this.app_end_date = app_end_date;
	}
	public String getLearn_start_date() {
		return learn_start_date;
	}
	public void setLearn_start_date(String learn_start_date) {
		this.learn_start_date = learn_start_date;
	}
	public String getLearn_end_date() {
		return learn_end_date;
	}
	public void setLearn_end_date(String learn_end_date) {
		this.learn_end_date = learn_end_date;
	}
	public String getIssue_date() {
		return issue_date;
	}
	public void setIssue_date(String issue_date) {
		this.issue_date = issue_date;
	}
	public String getAtt_eval_date() {
		return att_eval_date;
	}
	public void setAtt_eval_date(String att_eval_date) {
		this.att_eval_date = att_eval_date;
	}
	public String getAtt_eval_time() {
		return att_eval_time;
	}
	public void setAtt_eval_time(String att_eval_time) {
		this.att_eval_time = att_eval_time;
	}
	public String getAtt_exam_type() {
		return att_exam_type;
	}
	public void setAtt_exam_type(String att_exam_type) {
		this.att_exam_type = att_exam_type;
	}
	public int getCancel() {
		return cancel;
	}
	public void setCancel(int cancel) {
		this.cancel = cancel;
	}
	public int getDup_limit() {
		return dup_limit;
	}
	public void setDup_limit(int dup_limit) {
		this.dup_limit = dup_limit;
	}
	public int getAdd_exam_period() {
		return add_exam_period;
	}
	public void setAdd_exam_period(int add_exam_period) {
		this.add_exam_period = add_exam_period;
	}
	public String getOpen_results() {
		return open_results;
	}
	public void setOpen_results(String open_results) {
		this.open_results = open_results;
	}
	public String getApp_possibles() {
		return app_possibles;
	}
	public void setApp_possibles(String app_possibles) {
		this.app_possibles = app_possibles;
	}
	public String getExpect_exam() {
		return expect_exam;
	}
	public void setExpect_exam(String expect_exam) {
		this.expect_exam = expect_exam;
	}
	public int getPreview() {
		return preview;
	}
	public void setPreview(int preview) {
		this.preview = preview;
	}
	public String getComplate_yn() {
		return complate_yn;
	}
	public void setComplate_yn(String complate_yn) {
		this.complate_yn = complate_yn;
	}
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
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
	public int getComp_percent_quiz() {
		return comp_percent_quiz;
	}
	public void setComp_percent_quiz(int comp_percent_quiz) {
		this.comp_percent_quiz = comp_percent_quiz;
	}
	public int getComp_percent_exam() {
		return comp_percent_exam;
	}
	public void setComp_percent_exam(int comp_percent_exam) {
		this.comp_percent_exam = comp_percent_exam;
	}
	public int getComp_percent_prog() {
		return comp_percent_prog;
	}
	public void setComp_percent_prog(int comp_percent_prog) {
		this.comp_percent_prog = comp_percent_prog;
	}
	public int getComp_score_quiz() {
		return comp_score_quiz;
	}
	public void setComp_score_quiz(int comp_score_quiz) {
		this.comp_score_quiz = comp_score_quiz;
	}
	public int getComp_score_exam() {
		return comp_score_exam;
	}
	public void setComp_score_exam(int comp_score_exam) {
		this.comp_score_exam = comp_score_exam;
	}
	public int getComp_score_prog() {
		return comp_score_prog;
	}
	public void setComp_score_prog(int comp_score_prog) {
		this.comp_score_prog = comp_score_prog;
	}
	public int getComplete_total() {
		return complete_total;
	}
	public void setComplete_total(int complete_total) {
		this.complete_total = complete_total;
	}
	public int getRecruit() {
		return recruit;
	}
	public void setRecruit(int recruit) {
		this.recruit = recruit;
	}
	@Override
	public String toString() {
		return String.format(
				"CardinalDTO [seq=%s, id=%s, name=%s, learn_type=%s, credits=%s, course_type=%s, app_start_date=%s, app_end_date=%s, learn_start_date=%s, learn_end_date=%s, issue_date=%s, att_eval_date=%s, att_eval_time=%s, att_exam_type=%s, cancel=%s, dup_limit=%s, add_exam_period=%s, open_results=%s, app_possibles=%s, expect_exam=%s, preview=%s, complate_yn=%s, order_num=%s, use_yn=%s, reg_user=%s, reg_date=%s, upd_user=%s, upd_date=%s, comp_percent_quiz=%s, comp_percent_exam=%s, comp_percent_prog=%s, comp_score_quiz=%s, comp_score_exam=%s, comp_score_prog=%s, complete_total=%s, recruit=%s]",
				seq, id, name, learn_type, credits, course_type, app_start_date, app_end_date, learn_start_date,
				learn_end_date, issue_date, att_eval_date, att_eval_time, att_exam_type, cancel, dup_limit,
				add_exam_period, open_results, app_possibles, expect_exam, preview, complate_yn, order_num, use_yn,
				reg_user, reg_date, upd_user, upd_date, comp_percent_quiz, comp_percent_exam, comp_percent_prog,
				comp_score_quiz, comp_score_exam, comp_score_prog, complete_total, recruit);
	}
	
	

}
