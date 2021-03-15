package global.segroup.society.smp.admin.domain;

public class SocietySmpScheduleColor {

	private int gisu_seq;
	private int smp_sch_color_seq;
	private String smp_sch_color;
	private String smp_sch_title;
	
	public SocietySmpScheduleColor(){
	}

	public SocietySmpScheduleColor(int gisu_seq, int smp_sch_color_seq, String smp_sch_color, String smp_sch_title) {
		super();
		this.gisu_seq = gisu_seq;
		this.smp_sch_color_seq = smp_sch_color_seq;
		this.smp_sch_color = smp_sch_color;
		this.smp_sch_title = smp_sch_title;
	}

	public int getGisu_seq() {
		return gisu_seq;
	}

	public void setGisu_seq(int gisu_seq) {
		this.gisu_seq = gisu_seq;
	}

	public int getSmp_sch_color_seq() {
		return smp_sch_color_seq;
	}

	public void setSmp_sch_color_seq(int smp_sch_color_seq) {
		this.smp_sch_color_seq = smp_sch_color_seq;
	}

	public String getSmp_sch_color() {
		return smp_sch_color;
	}

	public void setSmp_sch_color(String smp_sch_color) {
		this.smp_sch_color = smp_sch_color;
	}

	public String getSmp_sch_title() {
		return smp_sch_title;
	}

	public void setSmp_sch_title(String smp_sch_title) {
		this.smp_sch_title = smp_sch_title;
	}

	@Override
	public String toString() {
		return "SocietySmpScheduleColor [gisu_seq=" + gisu_seq + ", smp_sch_color_seq=" + smp_sch_color_seq
				+ ", smp_sch_color=" + smp_sch_color + ", smp_sch_title=" + smp_sch_title + "]";
	}
	
	
}
