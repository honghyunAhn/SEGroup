/**
 * 
 */
package global.segroup.society.fap.company.domain;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 김준영
 * @Date : 2018. 12. 10.
 * @Class 설명 : 회사회원
 */
public class SocietyFapCompanyUser {

	private String fap_comp_id;
	
	private String fap_comp_en_nm;
	
	private String fap_comp_ja_nm;
	
	private String fap_comp_business_num;
	
	private String fap_comp_rep;
	
	private String fap_comp_major_bussiness;
	
	private String fap_comp_homepage;
	
	private String fap_comp_postcode;
	
	private String fap_comp_address;
	
	private String fap_comp_address_detail;
	
	private String fap_comp_nationality;
	
	private String fap_comp_est_dt;
	
	private long fap_comp_stock;
	
	private long fap_comp_3years_avg_sales;
	
	private int fap_comp_employee_num;
	
	private int fap_comp_scit_num;
	
	private int fap_comp_korean_num;
	
	private int fap_comp_foreigner_num;
	
	private String fap_comp_ins_id;
	
	private String fap_comp_ins_dt;
	
	private String fap_comp_udt_id;
	
	private String fap_comp_udt_dt;
	
	private String fap_comp_log_saved;
	
	private String fap_comp_log_origin;
	
	private String fap_comp_log_using;

	private CommonsMultipartFile fap_comp_log_file;

	/**
	 * @Desc : 
	 */
	public SocietyFapCompanyUser() {
		super();
	}

	public SocietyFapCompanyUser(String fap_comp_id, String fap_comp_en_nm, String fap_comp_ja_nm,
			String fap_comp_business_num, String fap_comp_rep, String fap_comp_major_bussiness,
			String fap_comp_homepage, String fap_comp_postcode, String fap_comp_address, String fap_comp_address_detail,
			String fap_comp_nationality, String fap_comp_est_dt, long fap_comp_stock, long fap_comp_3years_avg_sales,
			int fap_comp_employee_num, int fap_comp_scit_num, int fap_comp_korean_num, int fap_comp_foreigner_num,
			String fap_comp_ins_id, String fap_comp_ins_dt, String fap_comp_udt_id, String fap_comp_udt_dt,
			String fap_comp_log_saved, String fap_comp_log_origin, String fap_comp_log_using,
			CommonsMultipartFile fap_comp_log_file) {
		super();
		this.fap_comp_id = fap_comp_id;
		this.fap_comp_en_nm = fap_comp_en_nm;
		this.fap_comp_ja_nm = fap_comp_ja_nm;
		this.fap_comp_business_num = fap_comp_business_num;
		this.fap_comp_rep = fap_comp_rep;
		this.fap_comp_major_bussiness = fap_comp_major_bussiness;
		this.fap_comp_homepage = fap_comp_homepage;
		this.fap_comp_postcode = fap_comp_postcode;
		this.fap_comp_address = fap_comp_address;
		this.fap_comp_address_detail = fap_comp_address_detail;
		this.fap_comp_nationality = fap_comp_nationality;
		this.fap_comp_est_dt = fap_comp_est_dt;
		this.fap_comp_stock = fap_comp_stock;
		this.fap_comp_3years_avg_sales = fap_comp_3years_avg_sales;
		this.fap_comp_employee_num = fap_comp_employee_num;
		this.fap_comp_scit_num = fap_comp_scit_num;
		this.fap_comp_korean_num = fap_comp_korean_num;
		this.fap_comp_foreigner_num = fap_comp_foreigner_num;
		this.fap_comp_ins_id = fap_comp_ins_id;
		this.fap_comp_ins_dt = fap_comp_ins_dt;
		this.fap_comp_udt_id = fap_comp_udt_id;
		this.fap_comp_udt_dt = fap_comp_udt_dt;
		this.fap_comp_log_saved = fap_comp_log_saved;
		this.fap_comp_log_origin = fap_comp_log_origin;
		this.fap_comp_log_using = fap_comp_log_using;
		this.fap_comp_log_file = fap_comp_log_file;
	}

	public String getFap_comp_id() {
		return fap_comp_id;
	}

	public void setFap_comp_id(String fap_comp_id) {
		this.fap_comp_id = fap_comp_id;
	}

	public String getFap_comp_en_nm() {
		return fap_comp_en_nm;
	}

	public void setFap_comp_en_nm(String fap_comp_en_nm) {
		this.fap_comp_en_nm = fap_comp_en_nm;
	}

	public String getFap_comp_ja_nm() {
		return fap_comp_ja_nm;
	}

	public void setFap_comp_ja_nm(String fap_comp_ja_nm) {
		this.fap_comp_ja_nm = fap_comp_ja_nm;
	}

	public String getFap_comp_business_num() {
		return fap_comp_business_num;
	}

	public void setFap_comp_business_num(String fap_comp_business_num) {
		this.fap_comp_business_num = fap_comp_business_num;
	}

	public String getFap_comp_rep() {
		return fap_comp_rep;
	}

	public void setFap_comp_rep(String fap_comp_rep) {
		this.fap_comp_rep = fap_comp_rep;
	}

	public String getFap_comp_major_bussiness() {
		return fap_comp_major_bussiness;
	}

	public void setFap_comp_major_bussiness(String fap_comp_major_bussiness) {
		this.fap_comp_major_bussiness = fap_comp_major_bussiness;
	}

	public String getFap_comp_homepage() {
		return fap_comp_homepage;
	}

	public void setFap_comp_homepage(String fap_comp_homepage) {
		this.fap_comp_homepage = fap_comp_homepage;
	}

	public String getFap_comp_postcode() {
		return fap_comp_postcode;
	}

	public void setFap_comp_postcode(String fap_comp_postcode) {
		this.fap_comp_postcode = fap_comp_postcode;
	}

	public String getFap_comp_address() {
		return fap_comp_address;
	}

	public void setFap_comp_address(String fap_comp_address) {
		this.fap_comp_address = fap_comp_address;
	}

	public String getFap_comp_address_detail() {
		return fap_comp_address_detail;
	}

	public void setFap_comp_address_detail(String fap_comp_address_detail) {
		this.fap_comp_address_detail = fap_comp_address_detail;
	}

	public String getFap_comp_nationality() {
		return fap_comp_nationality;
	}

	public void setFap_comp_nationality(String fap_comp_nationality) {
		this.fap_comp_nationality = fap_comp_nationality;
	}

	public String getFap_comp_est_dt() {
		return fap_comp_est_dt;
	}

	public void setFap_comp_est_dt(String fap_comp_est_dt) {
		this.fap_comp_est_dt = fap_comp_est_dt;
	}

	public long getFap_comp_stock() {
		return fap_comp_stock;
	}

	public void setFap_comp_stock(long fap_comp_stock) {
		this.fap_comp_stock = fap_comp_stock;
	}

	public long getFap_comp_3years_avg_sales() {
		return fap_comp_3years_avg_sales;
	}

	public void setFap_comp_3years_avg_sales(long fap_comp_3years_avg_sales) {
		this.fap_comp_3years_avg_sales = fap_comp_3years_avg_sales;
	}

	public int getFap_comp_employee_num() {
		return fap_comp_employee_num;
	}

	public void setFap_comp_employee_num(int fap_comp_employee_num) {
		this.fap_comp_employee_num = fap_comp_employee_num;
	}

	public int getFap_comp_scit_num() {
		return fap_comp_scit_num;
	}

	public void setFap_comp_scit_num(int fap_comp_scit_num) {
		this.fap_comp_scit_num = fap_comp_scit_num;
	}

	public int getFap_comp_korean_num() {
		return fap_comp_korean_num;
	}

	public void setFap_comp_korean_num(int fap_comp_korean_num) {
		this.fap_comp_korean_num = fap_comp_korean_num;
	}

	public int getFap_comp_foreigner_num() {
		return fap_comp_foreigner_num;
	}

	public void setFap_comp_foreigner_num(int fap_comp_foreigner_num) {
		this.fap_comp_foreigner_num = fap_comp_foreigner_num;
	}

	public String getFap_comp_ins_id() {
		return fap_comp_ins_id;
	}

	public void setFap_comp_ins_id(String fap_comp_ins_id) {
		this.fap_comp_ins_id = fap_comp_ins_id;
	}

	public String getFap_comp_ins_dt() {
		return fap_comp_ins_dt;
	}

	public void setFap_comp_ins_dt(String fap_comp_ins_dt) {
		this.fap_comp_ins_dt = fap_comp_ins_dt;
	}

	public String getFap_comp_udt_id() {
		return fap_comp_udt_id;
	}

	public void setFap_comp_udt_id(String fap_comp_udt_id) {
		this.fap_comp_udt_id = fap_comp_udt_id;
	}

	public String getFap_comp_udt_dt() {
		return fap_comp_udt_dt;
	}

	public void setFap_comp_udt_dt(String fap_comp_udt_dt) {
		this.fap_comp_udt_dt = fap_comp_udt_dt;
	}

	public String getFap_comp_log_saved() {
		return fap_comp_log_saved;
	}

	public void setFap_comp_log_saved(String fap_comp_log_saved) {
		this.fap_comp_log_saved = fap_comp_log_saved;
	}

	public String getFap_comp_log_origin() {
		return fap_comp_log_origin;
	}

	public void setFap_comp_log_origin(String fap_comp_log_origin) {
		this.fap_comp_log_origin = fap_comp_log_origin;
	}

	public String getFap_comp_log_using() {
		return fap_comp_log_using;
	}

	public void setFap_comp_log_using(String fap_comp_log_using) {
		this.fap_comp_log_using = fap_comp_log_using;
	}

	public CommonsMultipartFile getFap_comp_log_file() {
		return fap_comp_log_file;
	}

	public void setFap_comp_log_file(CommonsMultipartFile fap_comp_log_file) {
		this.fap_comp_log_file = fap_comp_log_file;
	}

	@Override
	public String toString() {
		return "SocietyFapCompanyUser [fap_comp_id=" + fap_comp_id + ", fap_comp_en_nm=" + fap_comp_en_nm
				+ ", fap_comp_ja_nm=" + fap_comp_ja_nm + ", fap_comp_business_num=" + fap_comp_business_num
				+ ", fap_comp_rep=" + fap_comp_rep + ", fap_comp_major_bussiness=" + fap_comp_major_bussiness
				+ ", fap_comp_homepage=" + fap_comp_homepage + ", fap_comp_postcode=" + fap_comp_postcode
				+ ", fap_comp_address=" + fap_comp_address + ", fap_comp_address_detail=" + fap_comp_address_detail
				+ ", fap_comp_nationality=" + fap_comp_nationality + ", fap_comp_est_dt=" + fap_comp_est_dt
				+ ", fap_comp_stock=" + fap_comp_stock + ", fap_comp_3years_avg_sales=" + fap_comp_3years_avg_sales
				+ ", fap_comp_employee_num=" + fap_comp_employee_num + ", fap_comp_scit_num=" + fap_comp_scit_num
				+ ", fap_comp_korean_num=" + fap_comp_korean_num + ", fap_comp_foreigner_num=" + fap_comp_foreigner_num
				+ ", fap_comp_ins_id=" + fap_comp_ins_id + ", fap_comp_ins_dt=" + fap_comp_ins_dt + ", fap_comp_udt_id="
				+ fap_comp_udt_id + ", fap_comp_udt_dt=" + fap_comp_udt_dt + ", fap_comp_log_saved="
				+ fap_comp_log_saved + ", fap_comp_log_origin=" + fap_comp_log_origin + ", fap_comp_log_using="
				+ fap_comp_log_using + ", fap_comp_log_file=" + fap_comp_log_file + "]";
	}
	
}
